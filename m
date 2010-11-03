From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: rebase not honoring core.worktree pointing elsewhere
Date: Wed, 3 Nov 2010 22:52:46 +0700
Message-ID: <AANLkTi=UxD0cNvFK0RctCq=idfQV4VH+sNoOO2PLT2sh@mail.gmail.com>
References: <loom.20101101T182113-378@post.gmane.org> <AANLkTi=ejRcnz+83zc2Z-6etUGMsBSw1FFUY0JNFRFGB@mail.gmail.com>
 <loom.20101102T165800-486@post.gmane.org> <AANLkTi=T5kHfgNOpOtCDCoq7epEgwUrVayaUCbf35dSU@mail.gmail.com>
 <loom.20101103T162424-483@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Drews <paul.drews@intel.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 16:53:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDfeH-0007S2-MZ
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 16:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab0KCPxK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 11:53:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36132 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab0KCPxJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 11:53:09 -0400
Received: by gyh4 with SMTP id 4so560849gyh.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=D6zAH2ydU8cFYdEqCYGA3DgyikvQuvaPrnH7lHSUaZ8=;
        b=J4joaHro9K+ggm3u0okIwfVLHNeHkMeDHbI1whaY53y2G5L26qbTwS1LYWi8abp2Nl
         cuzyqEkIYZ52LDg4A2kDQmyljCu68mYRfYUYYPw3X60KZ7U4bE7UjaiBlWAxdZnhxpg0
         5h4/LSWdY2bEqEnGt46pGJyH5XhVPRtbnMuGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cocrnvVIvN/Djf9mtRBZ51/WAKzCEd5OmQx9QNoBAbgI2sSflTuSxZPKa3ggC52VcU
         V7+lwXPpdGVMyThlvIrHWciuT48WkBzK330tpP5cktM6li/ryy05CZfwA3m7J/FknnPb
         FE6e421bLJEj62kc5Mo3oFdnTcZbjHqfRS2QI=
Received: by 10.216.35.74 with SMTP id t52mr6717522wea.41.1288799587423; Wed,
 03 Nov 2010 08:53:07 -0700 (PDT)
Received: by 10.216.172.199 with HTTP; Wed, 3 Nov 2010 08:52:46 -0700 (PDT)
In-Reply-To: <loom.20101103T162424-483@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160604>

On Wed, Nov 3, 2010 at 10:41 PM, Paul Drews <paul.drews@intel.com> wrot=
e:
>> Another one: create a .git file with this line and put it in worktre=
e's
>> topdir
>>
>> gitdir: /path/to/real/git.dir
>>
>> See gitrepository-layout.txt.
>
> Ooh! =C2=A0That would be my favorite, since it's a documented legal u=
sage.
> Unfortunately, although the rebase scenario works that way a local
> "git clone" doesn't work:
>
> # git clone /abs/path/to/proj
> Cloning into proj...
> fatal: failed to open '/abs/path/to/proj/objects': No such file or di=
rectory
> # git clone /abs/path/to/proj/
> Cloning into proj...
> fatal: failed to open '/abs/path/to/proj//objects': No such file or d=
irectory
> # git --version
> git version 1.7.3.GIT

"git clone" needs to learn about .git file. Thanks for pointing it out.
--=20
Duy
