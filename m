From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Make update_refs more atomic V2
Date: Thu, 10 Apr 2014 13:08:37 -0700
Message-ID: <xmqqlhvdvtfe.fsf@gitster.dls.corp.google.com>
References: <1397154625-11884-1-git-send-email-sahlberg@google.com>
	<xmqq38hlxbh3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 10 22:08:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYLHD-0001Mm-6A
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 22:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbaDJUIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 16:08:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41875 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759101AbaDJUIl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 16:08:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD2CB7B6D2;
	Thu, 10 Apr 2014 16:08:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h0Nc+OXk+G+OvoitzizJpAr6Tvw=; b=S7aL5n
	HoEDiXcL4Coj4RmPTtL1N0PIJMzaU6NvzV47jiNRuz8FUWJgyJ5GFyyKxuQH82nI
	1qGcil5aSy2OU0h8bj/GwGm3qsqNoqr6aBi9Y0IY12QFAe1cVu+lycaSZ5oYiUgp
	KgWPUJJqOo231eyK/8C9uR0nsH8IKoQSPpYdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jZyMUyt++65Z5rl3XJU7+FN0tMODddet
	KFYKUcwT9TmH5K8K8mvtofQay21Sl3pFNlOws3lGoRfzHdMpjPuGpWy0bE9UupXP
	aNBwcHr9JDbdCidbmkC60h3D6n78lghus6UBi501Fij9z/D/BcRHSkfHD8a6vVy8
	TLrF+O/Bagk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B901D7B6D1;
	Thu, 10 Apr 2014 16:08:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D25B7B6CC;
	Thu, 10 Apr 2014 16:08:39 -0400 (EDT)
In-Reply-To: <xmqq38hlxbh3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 10 Apr 2014 11:53:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E8119DB8-C0EB-11E3-A267-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246053>

Junio C Hamano <gitster@pobox.com> writes:

> CC'ing Michael who has been active in this area as an area expert.
>
> Ronnie, please make it a habit to run something like
>
>     $ git shortlog --no-merges --since=18.months <affected paths>...
>
> to help you decide who your series may want to be reviewed by,
> before sending them.
>
> Thanks.

Another tip.  "git format-patch -v3" would produce

	Subject: [PATCH v3 0/4] blah blah blah...
