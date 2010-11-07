From: Zenaan Harkness <zen@freedbms.net>
Subject: Re: merge two local mirrors with detached heads and similar remotes
Date: Sun, 7 Nov 2010 20:42:46 +1100
Message-ID: <AANLkTin5GOGO3sf7kTjOz8X-rfiFTW6rTD5cO6w4p2yA@mail.gmail.com>
References: <AANLkTinidbrJjmt5w=TyFGMyNpaGobE1iDBm3VAWmZvX@mail.gmail.com> <AANLkTi=JmpXEiEe-7-ZicUp-QosWjTZQgK77-f=9iAtL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 07 10:43:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF1mf-0001Pf-LJ
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 10:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab0KGJnU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Nov 2010 04:43:20 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57062 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab0KGJnT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Nov 2010 04:43:19 -0500
Received: by bwz11 with SMTP id 11so3925533bwz.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 01:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=EWuYinBjtHoj+RXnGyyLnIUp2xZbJ1xqaKgSkt4EHo4=;
        b=GZ3uz2ZgWHP/S2ys9gcy9cHnW9QAaf+nz2W9gxCpc5Gx4K8tJc17w00eryuW4n9+UE
         E77guCi7XSgOCXMxi4v06Nuramox1ACghbsKPttSW9TxmaUYsGQmXx9+aDXS7g8gZ50/
         zbJdgGWUqZl7wCa0c9V8FKpu2YLmULy6yviIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=TbgmXLDaqZii/PkGfAJta8FPvIkXh2WGVfCds0eD0dWEksgjhIye1KqtcDGVF3/0T6
         hseyRhsoLdrA/3m8ArJA9Dhbl6CvbU8GVmlCYpAInovPrb+ByWKIZWGb3EDxjONI1A+Q
         xj3k3De/C21o1D44Z5MXnlVHtFpVlahll5p5w=
Received: by 10.204.64.80 with SMTP id d16mr3707197bki.181.1289122997204; Sun,
 07 Nov 2010 01:43:17 -0800 (PST)
Received: by 10.204.83.4 with HTTP; Sun, 7 Nov 2010 01:42:46 -0800 (PST)
In-Reply-To: <AANLkTi=JmpXEiEe-7-ZicUp-QosWjTZQgK77-f=9iAtL@mail.gmail.com>
X-Google-Sender-Auth: RTiMtBXTCbyCcrvpC45yFDNF5Y4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160872>

> In A) I modified .git/config to be as follows:
> $ cat .git/config
> [core]
> =A0 =A0 =A0 =A0repositoryformatversion =3D 0
> =A0 =A0 =A0 =A0filemode =3D true
> =A0 =A0 =A0 =A0bare =3D false
> =A0 =A0 =A0 =A0logallrefupdates =3D true
> [remote "origin"]
> =A0 =A0 =A0 =A0fetch =3D +refs/heads/*:refs/remotes/origin/*
> =A0 =A0 =A0 =A0url =3D https://github.com/chad/gitjour.git
> [branch "master"]
> =A0 =A0 =A0 =A0remote =3D origin
> =A0 =A0 =A0 =A0merge =3D refs/heads/master
> [remote "lach"]
> =A0 =A0 =A0 =A0url =3D ../u
> # =A0 =A0 =A0 fetch =3D +refs/heads/*:refs/remotes/origin/*
> =A0 =A0 =A0 =A0fetch =3D +refs/remotes/origin/*:refs/remotes/lach/*

My final change, for reference, was updating [remote "latch"] section w=
ith:
   url =3D https://github.com/lachlanhardy/gitjour.git
   fetch =3D +refs/heads/*:refs/remotes/lach/*

Appears to work with  git fetch --all
and finally followed by  git gc
