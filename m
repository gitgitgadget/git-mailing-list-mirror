From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: Fix make install target
Date: Tue, 30 Jul 2013 07:51:46 -0700
Message-ID: <7vob9kxfr1.fsf@alter.siamese.dyndns.org>
References: <1375172169-26582-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Tue Jul 30 16:51:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4BHH-0003Ew-5F
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 16:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab3G3Ovv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 10:51:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486Ab3G3Ovu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 10:51:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57F15341D9;
	Tue, 30 Jul 2013 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+9KeuivsKPJrcZRxqTnFDaFBvso=; b=HgQP/P
	CEbOsd26Dyq1OGNV24luSGeTVCgTjtdBf5qhQ42HBHBx17XrfUi8KLmur7WXuWNt
	7XoaNpkbBF8OnszeWjsn8Hr3fe37tSxzaaig/nonPp1bY5vd7PUYYqnuLtkphypc
	QvwYRfqC04q++z2aOeMb6fQjf1rJbnn2NYJ1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FZA3c4piSc/SLyNlExDQMUs4kcfsSRjK
	GZI2tUGH5I1gcYFBM2cebbhUtj2s1mqwfIfRjobNAlFI1TgIVmHzbJfnxj2MFf+r
	htuseoeWmSqEb/XEER12c19qxjwGpfXByVHatjCp7mZRgvhEJmOmvh2Fdrsegeo9
	u98ULMIot88=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E2C5341D8;
	Tue, 30 Jul 2013 14:51:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D16E341D4;
	Tue, 30 Jul 2013 14:51:48 +0000 (UTC)
In-Reply-To: <1375172169-26582-1-git-send-email-sojkam1@fel.cvut.cz> (Michal
	Sojka's message of "Tue, 30 Jul 2013 10:16:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F96C604-F927-11E2-985E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231363>

Michal Sojka <sojkam1@fel.cvut.cz> writes:

> If the libexec directory doesn't exist, git-subtree gets installed as
> $prefix/share/libexec/git-core file. This patch creates the directory
> before installing git-subtree file into it.
>
> Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
> ---

Will queue, as it is obviously correct.  Thanks.

I however wish somebody steps up to start properly maintaining this
part of the contrib ;-).

>  contrib/subtree/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
> index b507505..435b2de 100644
> --- a/contrib/subtree/Makefile
> +++ b/contrib/subtree/Makefile
> @@ -30,6 +30,7 @@ $(GIT_SUBTREE): $(GIT_SUBTREE_SH)
>  doc: $(GIT_SUBTREE_DOC)
>  
>  install: $(GIT_SUBTREE)
> +	$(INSTALL) -d -m 755 $(DESTDIR)$(libexecdir)
>  	$(INSTALL) -m 755 $(GIT_SUBTREE) $(DESTDIR)$(libexecdir)
>  
>  install-doc: install-man
