From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH 4/6] Improve error message for git-filter-branch
Date: Thu, 19 Feb 2009 14:19:42 +0000
Message-ID: <43d8ce650902190619u149b4619k3f9e08bc1e5869f8@mail.gmail.com>
References: <200902190736.35364.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 15:21:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La9mB-0005HY-Cg
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 15:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554AbZBSOTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 09:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755305AbZBSOTp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 09:19:45 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:40972 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828AbZBSOTo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 09:19:44 -0500
Received: by gxk22 with SMTP id 22so1027713gxk.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 06:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ZYOzNlLmgN2rr1nqMUzGcelQ7LdpSjuCd3DrevnmsHc=;
        b=MV3Y+ywXtsrMmZQqXHdnMVIh2dbV/Lt9XLOr3a+0TYHupUAYeomN5aLefRN3O0i9Pw
         Nec19CXauGkuwFX3WeoXGmDUWgrdWZ7EtK76WSgeyOgV/8DcGzwJq9uIkUUdqs/pZvec
         04tyKOWyZWFqLNbYnro8DHf1Ew2aPj0N18/XE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=aylYBL0S4qGtdVWuhKpJRLbtBtpINOCzQkcG4mm2N1nRa9WFd5YlG3P+8yBmenE/zg
         k4mpSW1518E6YZIwjBzNpfh/3hXtbQBDAMWz1lhA21C7fnDqArTHp0oZvE4y8LSfW4q2
         4IVDO9bS3jTF1z3knGiRWs0/L5S8IwVg3OFTc=
Received: by 10.150.138.8 with SMTP id l8mr1014587ybd.144.1235053182736; Thu, 
	19 Feb 2009 06:19:42 -0800 (PST)
In-Reply-To: <200902190736.35364.johnflux@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110705>

2009/2/19 John Tapsell <johnflux@gmail.com>:
> Tell the user that a backup (original) already exists, and how to solve
> this problem (with -f option)


"Oh, and also all are:
Signed-off-by: John Tapsell <johnflux@gmail.com>"

> ---
>  git-filter-branch.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 27b57b8..1ca45e2 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -226,7 +226,8 @@ while read sha1 type name
>  do
>        case "$force,$name" in
>        ,$orig_namespace*)
> -               die "Namespace $orig_namespace not empty"
> +               die "Cannot backup - a previous backup already exists in $orig_namespace\n" \
> +                   "Force overwriting the backup with -f"
>        ;;
>        t,$orig_namespace*)
>                git update-ref -d "$name" $sha1
> --
> 1.6.2.rc1.3.g7d31b.dirty
>
>
>
