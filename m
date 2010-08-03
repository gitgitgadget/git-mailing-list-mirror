From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: Re: CGIT 0.8.3.1 "chokes" on some bare repos
Date: Tue, 3 Aug 2010 20:47:30 +0200
Message-ID: <AANLkTin6+X=nTTqLG=xCYDSPKWX3CVPTxAhzDM9uKMW5@mail.gmail.com>
References: <90e6ba53a8a0a88e46048cee6566@google.com>
	<AANLkTinDPa7ngcTEfYC8k2O3hwkYszEUsb3pZqnuOSo2@mail.gmail.com>
	<AANLkTindiOoy-4W5DJ9AGa8q29Tsm9P8K_4TEgRfmJW=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 20:47:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgMWZ-0007Tg-N0
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 20:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757582Ab0HCSre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 14:47:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63334 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757577Ab0HCSrb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 14:47:31 -0400
Received: by fxm14 with SMTP id 14so2118726fxm.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YiPcHuPiHlRnUHmWx2WXUBEg1qgirW1iu89D6hxALVM=;
        b=FdXgDCq4710fKKDS+XS/+Le7jZA7uGf5K62uLvcPkKtfmVVBxXnK5+FR00i09h4Ne6
         T6VThbUNcf1IAVYthKYEwyGpuVLTg5Jj5ThUhs2zxENJv08GAKmDg02qGVdEquQNFvS7
         /dJHKLatRJnPe0pC2KUqQ6LyMLO4JKdiuxoXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FCe1WjiKCvNWa34sF6Vb7ou7PDo6B+999xHThb0ACpbVgwgFiCupNl4URY+yUFlR/u
         KAGLAf6mtwQFEyD9fATMxMppvauz9UBzEeBV+LvBDpz3MeqVbKxyE3sfn/GgqTqgwrGY
         50MLk4li9/NeT522V9eRgiJRsX6zL+zG6hGzY=
Received: by 10.239.188.67 with SMTP id o3mr406026hbh.17.1280861250250; Tue, 
	03 Aug 2010 11:47:30 -0700 (PDT)
Received: by 10.239.165.79 with HTTP; Tue, 3 Aug 2010 11:47:30 -0700 (PDT)
In-Reply-To: <AANLkTindiOoy-4W5DJ9AGa8q29Tsm9P8K_4TEgRfmJW=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152534>

On Tue, Aug 3, 2010 at 20:19, Eugene Sajine <euguess@gmail.com> wrote:
> I have disabled cache: i have nocache=3D1 (we are working without cac=
he
> yet, =C2=A0cache-size set to 0, but for the experiment i commented th=
is
> out)

Good

> We are using scan mode as we have central folder to store our repos.
> So I switched off the scanmode by commenting the scan-url out from
> cgitrc

Then you'll have to add the repo.* settings to cgitrc by hand, or else.=
=2E.

> Now when i'm trying to generate the html for the repo in question i
> get html where it says "no repositories found".

This is expected.


> The command is like this:
> $ PATH_INFO=3D/home/users/gitrepouser/repos/subfolder/repo.git
> ./cgit.cgi 1>cgit.html 2>cgit.log

Add this to your cgitrc:

repo.url=3Dfoo
repo.path=3D/home/users/gitrepouser/repos/subfolder/repo.git

Then run `PATH_INFO=3Dfoo ./cgit.cgi 1>cgit.html 2>cgit.log`

--
larsh
