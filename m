From: Christian Couder <christian.couder@gmail.com>
Subject: Re: RFC: git bisect should accept "paths-to-be-excluded"
Date: Tue, 17 Sep 2013 09:26:06 +0200
Message-ID: <CAP8UFD0qC3UM3Dgt2dhpcBHt34yZ3HwNO6y7Z=EBtyRYpyc+Bw@mail.gmail.com>
References: <5236FBEA.80909@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 17 09:26:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLpfo-0006CW-Ro
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 09:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab3IQH0J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Sep 2013 03:26:09 -0400
Received: from mail-vb0-f41.google.com ([209.85.212.41]:33312 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab3IQH0H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Sep 2013 03:26:07 -0400
Received: by mail-vb0-f41.google.com with SMTP id g17so3841355vbg.28
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 00:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hP8CgVhCqhGZIObe7cAq7VFQvp/MAtH9g51l7vHaM6g=;
        b=ZXy3URB4345dClOa4xU5ejmT/A+LMnqtsdMqI9kopiK7g4gm28IVElD/Wdz4FWz6fI
         x67ocRaCsqvsIjkgBB2Eljd7fJBT4WyiF4Xq2qsb51wUf1990uF80nd1RLBTC3YkSOIz
         +pug4o126MyFmOpldAEVp8s1jQE4zmHxs12aalLd7l9u3mIE/dEcqpAS4/6Vg6tFs/ui
         cRALAF/zbcBV5AugTvY2it38MWAn2g/C9agWF+KTwEpJavf6E4SDaZbqVtnLawnnirXs
         zfcPGIy11YuPv0UemKv3fA/wcNxr9eapRR2zvIHSnrRKVIWBq9vA+EAC4lNtqqNxKWBf
         qNOA==
X-Received: by 10.58.208.130 with SMTP id me2mr31083335vec.13.1379402766393;
 Tue, 17 Sep 2013 00:26:06 -0700 (PDT)
Received: by 10.58.240.102 with HTTP; Tue, 17 Sep 2013 00:26:06 -0700 (PDT)
In-Reply-To: <5236FBEA.80909@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234858>

Hi,

On Mon, Sep 16, 2013 at 2:39 PM, Toralf F=F6rster <toralf.foerster@gmx.=
de> wrote:
> I'm bisecting a linux kernel issue and want to ignore all commits jus=
t
> touching something in ./drives/staging.
>
> Currently the only way would be to specify all dir/subdir combination
> under ./linux except that particular directory, right ?

Yeah, you are right, currently the only way would be to specify all
dir/subdir combination
under ./linux except the particular directory you want to exclude.

It might indeed be useful to have a way to exclude some directories or =
files.

In practice though, as git bisect is a kind of binary search, if what
you want to exclude is exclusively touched by half the commits, it
will only add one more bisection step if you don't exclude it.

Best regards,
Christian.
