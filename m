From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 16/31] rebase -i: support --stat
Date: Tue, 28 Dec 2010 14:24:52 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1012281407360.788@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-17-git-send-email-martin.von.zweigbergk@gmail.com> <alpine.DEB.1.00.1012281858300.1794@bonsai2>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 28 20:24:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXf9X-0003T7-N4
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 20:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab0L1TYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 14:24:03 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44735 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab0L1TYB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 14:24:01 -0500
Received: by qwa26 with SMTP id 26so9592848qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 11:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=K7zRWUSdY3cIb6cIgDByp1Dkal2DwCs2PHcgNrXjqCU=;
        b=uF6dyJ9/U6wy34kbUS4Xc9rWTcFLh1kHU88KAgHf56Hbd4ImmGd4VqWx6Ni7rA7lI/
         u9OOyNtYsQRR9PmKDYMpJa2mW6vC72Q8F8CTPQxdAjL+uri/Gr2SLc8riV2liNwO84Fw
         Hoq92BgPJuQXbWLuFHyFhQvXGyv+n3F5MsL6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=Bjg1LQUSXsT+bmtwdjxVx8PikKePkHghTImioO29O0Qpud2ejCgZAzEMegjIxCXL+W
         J/NPbcMHdAkt/RXlSVbspyS9x6hgL8CR4CnkmVHRcmX1cGlhLHGrcSGv4zkft3dKp1K+
         MQDTGt+xQtUHZSvqILaF+Ct5Ev5YSTOMovcTQ=
Received: by 10.224.11.9 with SMTP id r9mr13119092qar.85.1293564240994;
        Tue, 28 Dec 2010 11:24:00 -0800 (PST)
Received: from [192.168.1.105] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id g28sm7843569qck.37.2010.12.28.11.23.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 11:24:00 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <alpine.DEB.1.00.1012281858300.1794@bonsai2>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164285>

On Tue, 28 Dec 2010, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 28 Dec 2010, Martin von Zweigbergk wrote:
> 
> > diff --git a/git-rebase.sh b/git-rebase.sh
> > index 229e8d2..0fc580a 100755
> 
> Hmpf... After a rebasing merge to junio/next:
> 
> -- snip --
> [...]
> Applying: rebase -i: support --stat
> fatal: sha1 information is lacking or useless (git-rebase.sh).
> Repository lacks necessary blobs to fall back on 3-way merge.
> Cannot fall back to three-way merge.
> [...]
> -- snap --
> 
> Is this supposed to apply on top of junio/master, junio/next, junio/maint?

It is supposed to apply on top of junio/master. I tried exporting the
recevied emails using Alpine. This is the first time I do this, but I
managed to export them to one big file. I then applied it using 'git
am' onto a new branch created from junio/master and it was
successful. I'm very surprised that patch 16 failed for you if the
first 15 patches applied correctly.

I'm not sure what to use the hashes in the beginning of your mail for,
but I have verified that they match the hashes of git-rebase.sh before
and after patch 16 (in both my original branch and in the temporary
branch where I ran 'git am' on my own emails).


Regards,
Martin
