From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: How to undo changes?
Date: Thu, 29 Apr 2010 03:29:25 +0200
Message-ID: <g2z40aa078e1004281829o446bce44r165aa59c98969043@mail.gmail.com>
References: <l2l10d816431004281808s79a559e6p308052c788c9a4ca@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Lin Mac <mkl0301@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 29 03:29:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7IZK-00056P-4q
	for gcvg-git-2@lo.gmane.org; Thu, 29 Apr 2010 03:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab0D2B32 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 21:29:28 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:53571 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab0D2B31 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 21:29:27 -0400
Received: by wwi14 with SMTP id 14so1278084wwi.19
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 18:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Uzn0QGAoArgjThC+IktBHFF/1lUVeFtLS3lsUmYH5Vo=;
        b=vaD/i1FOeh0VgLyasbbiHWAr15P14CuZBhxp4QfdB0Q56xti/BVdv8Yxv8T/nWP/lf
         zxooosyqOJQEeK2WJdYLAjvolTIBztoh4KhN8i6XVN28ueHAwALtUNLIJw1xxbLbuSHC
         XAyl5S2wnUnSQV2cE2tsfxT9RNTZcwhPdh5+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Z0X8EeoRWn53KI1D2PfVpvvBOlIT3mfB8tG7Vdinkn49K2I0aeOdWzTKupM2N6DMV/
         k6YbHEa0/XuioJNXSGSbp43PDtTyR3ajQSqqX/puwnpfUdQUHJ2jBGC++JXaktY+0vAf
         UD9dzItlAbeSwm9HKU7cliDteZAOQ+7TflC7s=
Received: by 10.216.182.78 with SMTP id n56mr9843797wem.148.1272504566031; 
	Wed, 28 Apr 2010 18:29:26 -0700 (PDT)
Received: by 10.216.51.79 with HTTP; Wed, 28 Apr 2010 18:29:25 -0700 (PDT)
In-Reply-To: <l2l10d816431004281808s79a559e6p308052c788c9a4ca@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146025>

On Thu, Apr 29, 2010 at 3:08 AM, Lin Mac <mkl0301@gmail.com> wrote:
> Hi,
>
> 1.
> I have multiple files modified, but would like to undo the changes in
> one of the changed files.
> "git reset --hard" do not accept single files. So I used to use "git
> diff <file> | patch -p X", but X cannot be know until I checked the
> patch and know the path relationship. Is there other way to do it?

git checkout -- <file>

>
> 2.
> Sometimes I delete old unused branches with "git branch -D <branch>",
> but I just realized theren't a reflog log for such operation. If the
> branch is the only reference to the logs, deleting the branch makes
> the commits become dangling commits. =A0How could I recover those
> commit?
>

Run "git fsck --lost-found" to list the SHA-1s of all dangling objects.

But make sure you've taken a backup of the repo first, just in case
something gets messed up further ;)

--=20
Erik "kusma" Faye-Lund
