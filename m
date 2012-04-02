From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: catch garbage after marks in from/merge
Date: Mon, 02 Apr 2012 09:16:19 -0700
Message-ID: <7vy5qegld8.fsf@alter.siamese.dyndns.org>
References: <20120401225407.GA12127@padd.com>
 <20120401231259.GE20883@burratino> <20120402001354.GA12651@padd.com>
 <CA+gfSn_8J-HzNjLMi2fXn1XQNA9wx3EVuiseq3pjy0nP-odb5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 18:16:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEjvf-0000y0-2O
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 18:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab2DBQQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 12:16:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628Ab2DBQQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 12:16:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE85D7F25;
	Mon,  2 Apr 2012 12:16:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BPftXZ8lA4LR/W6Ik23GqZ9r3gY=; b=OlTKqJ
	4KlOyG1UeZKWqv0K6qR38WmVJQfNKdYdE1KU7Gk9HAoxZb36DzwvoaPd1Sb54Ak3
	ZlRL35iFnWGaQ4xeuiiJMZ7gDiP5xxsTDbwLivcigt0b+xJL+MePD+ttqy5QctmN
	j7TjgZ6ayx1xVbiuO8BENtb0O2FSu82dwt+as=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b7yUpla11h2b+qOR8TbsYwoFapXdnf8v
	sCHtNRm/MA8Vv8YekwvDl0IaqKQFnXQogot21KkU3LkS+aEB3pJv8NJYzW5HzDts
	B/JKWdkJizHIQNye1ytoB9Sm90/gcC9xykKRzwGjKwsj2jRtC179+HWGQgJsaIsw
	0uLGzF2JmQM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E57F77F24;
	Mon,  2 Apr 2012 12:16:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 799297F23; Mon,  2 Apr 2012
 12:16:20 -0400 (EDT)
In-Reply-To: <CA+gfSn_8J-HzNjLMi2fXn1XQNA9wx3EVuiseq3pjy0nP-odb5A@mail.gmail.com> (Dmitry
 Ivankov's message of "Mon, 2 Apr 2012 12:56:40 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2EF3BCE6-7CDF-11E1-A7D0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194527>

Dmitry Ivankov <divanorama@gmail.com> writes:

>> Other similar fast-import are less forgiving, such as
>> parse_cat_blob. Maybe we should generalize and enforce its
>> approach to parsing marks.
>
> Docs say that "fast-import is very strict about its input", so
> probably it is ok to both deny trailing spaces and fix all other
> strtoumax()-es.

Concurred.
