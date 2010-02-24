From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 1/1] Use GIT_ASKPASS environment to launch thirdpart UI 
	app to get password
Date: Wed, 24 Feb 2010 16:13:01 +0800
Message-ID: <1976ea661002240013j164fc875o469c0dcdf74afe0c@mail.gmail.com>
References: <1266923463-2828-1-git-send-email-lznuaa@gmail.com>
	 <20100224051307.GA3232@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 09:13:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkCMo-0008Gd-2k
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 09:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702Ab0BXINF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 03:13:05 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:56867 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab0BXIND convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 03:13:03 -0500
Received: by gxk9 with SMTP id 9so4878803gxk.8
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 00:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NrxO3tKKFIoSkQ899sQnw1QzeYQLmeP5shtjQ6P2hyg=;
        b=CFnRQkKQnpopFcTBUVfX8J2VMbndCgKmzTlNo0rximv/RbJAjOgYH/uBoOSpS0jiW3
         RitwBMp+76/ctgbKPVDeVb3A9BRiR3jWlO71OAlmkHQqMmSWYsGNDxEKVVH5K9j75NjK
         0o1H/nbAaLWNfFkEo+OVr6tLN3M2R7YfLvKGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Witx0d9Ua3ek1bc5A82nyOIxJ5vI6H5rjs5llvw8baSdWHD4A3TMYKSWYkaI+O/tDE
         IwQzPFyC3YNaeHEUv1gIR3+1St70s81xkOVCYUPhK0DYLnceZP+SNHPnSDgUe/dfAz8z
         ENEFYui9jKvkSNSbDwO8572hM9ZvOBrMyU98o=
Received: by 10.150.118.14 with SMTP id q14mr1997288ybc.105.1266999181948; 
	Wed, 24 Feb 2010 00:13:01 -0800 (PST)
In-Reply-To: <20100224051307.GA3232@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140918>

> -- >8 --
> Subject: [PATCH] git-svn: Support retrieving passwords with GIT_ASKPA=
SS
>
> git-svn reads passwords from an interactive terminal.
> This behavior causes GUIs to hang waiting for git-svn to
> complete.
>
> Fix this problem by allowing a password-retrieving command
> to be specified in GIT_ASKPASS. =A0SSH_ASKPASS is supported
> as a fallback when GIT_ASKPASS is not provided.
>

Okay, I will change it.

>
> I think Junio mentioned this in passing but I'll repeat it.
>
> Many users already have SSH_ASKPASS defined. =A0It would be very
> nice if we supported SSH_ASKPASS as a fallback when GIT_ASKPASS
> is not provided.
>

I consider add such fallback at git.c.  when user use git svn,  git
main program will be called firstly.
git main entry will check if GIT_ASKPASS and SSH_ASKPASS, if
SSH_ASKPASS set but GIT_ASKPASS not set,
GIT_ASKPASS will be set as SSH_ASKPASS.

Do you think we needs add such check at git-svn.perl ?

best regards
=46rank Li
