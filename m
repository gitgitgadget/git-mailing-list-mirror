From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 04/16] update-index: add --checkout/--no-checkout to update CE_NO_CHECKOUT bit
Date: Sun, 14 Sep 2008 11:50:51 -0700 (PDT)
Message-ID: <m38wtuo92v.fsf@localhost.localdomain>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
	<1221397685-27715-2-git-send-email-pclouds@gmail.com>
	<1221397685-27715-3-git-send-email-pclouds@gmail.com>
	<1221397685-27715-4-git-send-email-pclouds@gmail.com>
	<1221397685-27715-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 20:52:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kewi6-0008LR-0q
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 20:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbYINSuz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 14:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753736AbYINSuz
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 14:50:55 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:51717 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbYINSuy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2008 14:50:54 -0400
Received: by gxk9 with SMTP id 9so22933809gxk.13
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 11:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=AxstjoxOmO2mqxDpMk5kBEVF32M3j8OQl2Yh/5WI4T8=;
        b=mSROwxGXqd7+Y+dfbCqRyXoPnlT0f4ezA4+qTgUbcaC9EIwntOku+sEPtwGVcQfSyc
         77tzLkqdWEaU9pgYql1MuJIMaX6BIdJ1Hu+iwwNd2vK1anm8tM56noPfG7xK5pCn2YGr
         pEormbIq0eDI4itTfUmzWAtFtIHMpVdRfgp/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=h+6hCBoTc1IgpcTG1+8c95qYEtccFzs1QsfEkgU2HMGRuX2b6zNVmvX9CgSc9LzAJy
         T+eu8xQ6fLZiypASLZfbWX4cX1uSu+UuBVBULVOCqJp+xAycQerokRIWp21aiWWf3K7v
         gNEAOTqFaZDdtG1Idq0FVNebU1URoUqfRJQfs=
Received: by 10.86.65.9 with SMTP id n9mr5202772fga.55.1221418252216;
        Sun, 14 Sep 2008 11:50:52 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.193])
        by mx.google.com with ESMTPS id d4sm16174461fga.5.2008.09.14.11.50.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 11:50:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8EIon5o014089;
	Sun, 14 Sep 2008 20:50:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8EIom6D014086;
	Sun, 14 Sep 2008 20:50:48 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1221397685-27715-5-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95852>

I will comment only on documentation...

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -15,6 +15,7 @@ SYNOPSIS
>  	     [--cacheinfo <mode> <object> <file>]\*
>  	     [--chmod=3D(+|-)x]
>  	     [--assume-unchanged | --no-assume-unchanged]
> +	     [--checkout | --no-checkout]
>  	     [--ignore-submodules]
>  	     [--really-refresh] [--unresolve] [--again | -g]
>  	     [--info-only] [--index-info]
> @@ -88,6 +89,17 @@ OPTIONS
>  	sometimes helpful when working with a big project on a
>  	filesystem that has very slow lstat(2) system call
>  	(e.g. cifs).
> +--checkout::
> +--no-checkout::
> +	When these flags are specified, the object name recorded
> +	for the paths are not updated. Instead, these options
> +	set and unset the "no-checkout" bit for the paths. This
> +	bit is used for marking files for narrow checkout. If
> +	a path is marked "no-checkout", then it should not be
> +	checked out unless requested by user or needed for a git
> +	command to function.
> +	See linkgit:git-checkout[1] for more information about
> +	narrow checkout.

Low level (porcelain) access to "no checkout" bit/flag, isn't it?

Nice. One caveat: you refer to git-checkout(1), which I think is
updated to include referenced information only later in the series.
Perhaps add "See linkgit:git-checkout[1]..." part only _after_ the
referenced information is in Documentation/git-checkout.txt

>  +
>  This option can be also used as a coarse file-level mechanism
>  to ignore uncommitted changes in tracked files (akin to what

Ooops. It looks like it is continuation line to _previous_ option,
probably --assume-unchanged, which you have interrupted by mistake.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
