From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/5] Large file support for git-archive
Date: Tue, 1 May 2012 17:19:01 +0700
Message-ID: <CACsJy8DXMSZE+ZHEXcCKteKxheLhkNu_O0JM7YQFsFMxbm-A7w@mail.gmail.com>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com> <4F9EFF2D.8080505@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 12:19:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPABH-0007mD-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 12:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329Ab2EAKTf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 06:19:35 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:49412 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962Ab2EAKTe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 06:19:34 -0400
Received: by were53 with SMTP id e53so89825wer.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 03:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WOBrgVXp+RQ47IExcQr3WZc1/fx+enEibqJD49eCm+0=;
        b=PCM4HZ4pO7K54CXv3TEhtGf/zi9qN6LLMSJngUwSH7G++7RdASUgKkh27XmJWm8S8o
         EixjsbZ5GRm90HechorNvHoS1IHYPV8k1cQai+Vkx0uuozGe2rDiNxgOM8u8uekkviIS
         g2Ybgxn6+c5F/79dUv2pJH3emlE39RbF5tl+khWOBYjc7A1iLNJSx9Qc6JWA+dezHsIb
         gjm7NrJNKB43JC7aSqkKEx0b6+8xzL+kPAak/wg/RN3PyaS2W0Ev7c4ZTdxMeJESnRYd
         7QzelXBq3SvdpWT+TKh17zAAScVOEGtq2KIBBWb5VQXPNdBavVAZ3G1G7OefkrPWVODx
         TVtw==
Received: by 10.216.205.41 with SMTP id i41mr7710702weo.96.1335867572803; Tue,
 01 May 2012 03:19:32 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Tue, 1 May 2012 03:19:01 -0700 (PDT)
In-Reply-To: <4F9EFF2D.8080505@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196677>

Thanks both. Will resend with fixes in the first patches and Ren=C3=A9'=
s
patches with better tests that also verify output. I think I will move
zip tests back to t5000 though because it may change output structure.

2012/5/1 Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>:
> Am 30.04.2012 06:57, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
>
>> This is a spin-off from the large file support series I posted some
>> time ago [1]. Both tar and zip format now support streaming large
>> blobs. Although zip will store uncompressed large blobs.
>>
>> [1] http://thread.gmane.org/gmane.comp.version-control.git/191605
>>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
>> =C2=A0 archive-tar: turn write_tar_entry into blob-writing only
>> =C2=A0 archive-tar: unindent write_tar_entry by one level
>> =C2=A0 archive: delegate blob reading to backend
>> =C2=A0 archive-tar: stream large blobs to tar file
>> =C2=A0 archive-zip: stream large blobs into zip file
>>
>> =C2=A0Documentation/git-archive.txt | =C2=A0 =C2=A03 +
>> =C2=A0archive-tar.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0184
>> ++++++++++++++++++++++++++++-------------
>> =C2=A0archive-zip.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 56 ++++++++++++-
>> =C2=A0archive.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 28 +++----
>> =C2=A0archive.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 10 ++-
>> =C2=A0t/t1050-large.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A08 ++
>> =C2=A06 files changed, 209 insertions(+), 80 deletions(-)
>
>
> I like the cleanups in the first two patches.
>
> I'm neutral to positive on the third one; it certainly simplifies the
> interface to the backends with only little code duplication.
>
> The ZIP format supports streaming natively (look for "Data descriptor=
" in
> http://www.pkware.com/documents/casestudies/APPNOTE.TXT). Incidentall=
y, I
> had been working on supporting that, but without any presentable resu=
lts.
> =C2=A0So far. =C2=A0I've adapted the pieces I had to your series now;=
 will send
> shortly.
>
> Ren=C3=A9



--=20
Duy
