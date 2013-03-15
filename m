From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Fri, 15 Mar 2013 08:59:59 -0700
Message-ID: <7v4ngcwt4w.fsf@alter.siamese.dyndns.org>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info>
 <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com>
 <7vmwu6x72q.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info>
 <7vk3p9wqh5.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1303151054130.32216@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	kusmabite@gmail.com, git@vger.kernel.org, msysgit@googlegroups.com
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Fri Mar 15 17:00:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGX3c-0004A3-Ej
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 17:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500Ab3COQAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 12:00:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48851 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091Ab3COQAH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 12:00:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDE22A726;
	Fri, 15 Mar 2013 12:00:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=29q0hHebfG0z/fMdjNVB/ob4/8c=; b=wB/yZA
	sfpebVse8Fh/v8ACeUjcEfttIbVTtPkr+qDt69+lqv7EXWS8zbsIQjdL88GGd19U
	2Gn9rFQbgiGis6hKP7LwLjjYnsYNV9qR/HJ/EB2kw1W+IcDBLY8vJnuRgneHUj+7
	ry7c260b9nbQJJiaUpnwgMV8bVaH1Wr8UomNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yjMgKzw9FIlfINW7OBnk4lMyxJeWTMhH
	xnj15XA0qNqckZcaNVC0aQ3y41XEQ/5dyZD8A4Ga0rTPb5Jvwd8rWilaUEI668kA
	ulYGLlkbGhwKEgyQI1nYrG8+LR5eylRZGGiQn1BhJAaJOMZr7vLQjWyLDKRGoJhV
	oLP1KsaZ9uk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9AF4A720;
	Fri, 15 Mar 2013 12:00:04 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED14EA719; Fri, 15 Mar 2013
 12:00:02 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1303151054130.32216@tvnag.unkk.fr> (Daniel
 Stenberg's message of "Fri, 15 Mar 2013 11:08:17 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65A47DF0-8D89-11E2-B6BC-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218248>

Daniel Stenberg <daniel@haxx.se> writes:

> (speaking from a libcurl perspective)
>
> As for how ALL vs DEFAULT will act or differ in the future, I suspect
> that we will end up having them being the same (even when we add bits)
> as we've encouraged "ALL" in the documentation like this for quite
> some time.

Thanks, then we should stick to starting from ALL like everybody
else who followed the suggestion in the documentation.  Do you have
recommendations on the conditional dropping of SSL?
