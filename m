From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2 18/31] rebase: extract merge code to new source file
Date: Wed, 23 Feb 2011 22:27:23 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102232216180.11038@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-19-git-send-email-martin.von.zweigbergk@gmail.com> <4D58E17C.9090001@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 04:27:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsRrc-0006zw-6B
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 04:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277Ab1BXD1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 22:27:31 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62006 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173Ab1BXD1b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 22:27:31 -0500
Received: by qwd7 with SMTP id 7so102829qwd.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 19:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=YtxzKwJO4Fe6JwRG59FKLEC2D1Djb7Vx2lUCdsCD5+4=;
        b=rZ8qAZL2BiZ0RBeDYsARQWXPUB2vCRduM2GR7U3xQSwwMaRvR3yQJBIoop34gD4xcA
         FCOdbFIiZsmSlEeaM0O5S20sO6kwoP/xxHnnlV8vOkSEg8RmlyKpbFdmBxpn0kENSA5p
         PhGK+xmAkbc5Gfcf/jp56DMqFPivEvIocNcxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=LAtZd0Nzk0v9W18ilKdLVfMDnmEufgBdtoEBwyLYqpXHME7DTa2V24zF2DOVnw387q
         fJnBAMCMM7PTc6glomBb8l0nkKpOLxMiG07GTb9X5aHLIn+P+yf7NmXV3hvxkFCoR6Hf
         CYpAKxQPoceXJtCOgxRiMuseoctjb/1r1ypiM=
Received: by 10.224.11.15 with SMTP id r15mr232299qar.192.1298518050148;
        Wed, 23 Feb 2011 19:27:30 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id t7sm6072361qcs.4.2011.02.23.19.27.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 19:27:28 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <4D58E17C.9090001@viscovery.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167773>

On Mon, 14 Feb 2011, Johannes Sixt wrote:

> Am 2/6/2011 19:43, schrieb Martin von Zweigbergk:
> > diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> > new file mode 100644
> > index 0000000..c04ce8a
> > --- /dev/null
> > +++ b/git-rebase--merge.sh
> 
> This should be mode 100755. (Ditto for git-rebase--am.sh in 19/31)

I was just about to fix now and I noticed that quite a few other
script files are mode 100644. Should all be changed to mode 100755 or
is there some kind of rule as to which mode they should be? Both
git-sh-setup.sh and git-parse-remote.sh are also mode 100644 and I
(think I) know that both are always sourced. If the rule is that
sourced scripts should be mode 100644 (but I'm just guessing here),
then I should actually have changed the mode of
git-rebase--interactive.sh to that mode instead. Please advice.


/Martin
