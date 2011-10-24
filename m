From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Possible diff regression in v1.7.6-473-g27af01d
Date: Mon, 24 Oct 2011 18:11:02 +0800
Message-ID: <CALUzUxoc00DxB75Qu5qz+R9k4_xHx13RJGwwX8vJpbet1jf0Aw@mail.gmail.com>
References: <1319448227.70497.YahooMailNeo@web29402.mail.ird.yahoo.com>
	<201110241138.51448.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Franz Schrober <franzschrober@yahoo.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"marat@slonopotamus.org" <marat@slonopotamus.org>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Oct 24 12:11:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIHUt-00048O-Gh
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 12:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab1JXKLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 06:11:05 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35614 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab1JXKLD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2011 06:11:03 -0400
Received: by ggnb1 with SMTP id b1so5561527ggn.19
        for <git@vger.kernel.org>; Mon, 24 Oct 2011 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=sXT0RfZ/HLwBaE4SAiJr1m0tvSdwfkAKDXV9iulBJhU=;
        b=xCXPtZOMn7suRz09a4+Rbfu1TR1CEhGHPAuUX8k+HxOSeFPGjyZU1CCB7EtPpYosYu
         VZAtL5plF2VI7sEkQbP+StqBIC1LIvbtKpuDjn0TamgW/Ec4BPfEqXf0MnIn78SDEJoH
         1SjuAfB21io3XxYFQUflIXc6GnIq2uRs0Ng3c=
Received: by 10.223.63.206 with SMTP id c14mr42555878fai.7.1319451062982; Mon,
 24 Oct 2011 03:11:02 -0700 (PDT)
Received: by 10.223.83.2 with HTTP; Mon, 24 Oct 2011 03:11:02 -0700 (PDT)
In-Reply-To: <201110241138.51448.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184170>

On Mon, Oct 24, 2011 at 5:38 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
>
> I'm not sure why you call this a regression. =A0For the benefit of
> people who hate saving attachments, you used
>
> =A0$ paste anonymized_orig anonymized_new =A0| xclip
> =A00 =A0 =A0 =A0 1
> =A00 =A0 =A0 =A0 2
> =A00 =A0 =A0 =A0 0
> =A00 =A0 =A0 =A0 3
> =A0 =A0 =A0 =A0 =A04
> =A0 =A0 =A0 =A0 =A05
> =A0 =A0 =A0 =A0 =A06
> =A0 =A0 =A0 =A0 =A07
>
> the old diff was
>
> =A0--- a/anonymized_orig
> =A0+++ b/anonymized_new
> =A0@@ -1,4 +1,8 @@
> =A0-0
> =A0-0
> =A0-0
> =A0-0
> =A0+1
> =A0+2
> =A0+0
> =A0+3
> =A0+4
> =A0+5
> =A0+6
> =A0+7
>
> and the new diff is
>
> =A0--- a/anonymized_orig
> =A0+++ b/anonymized_new
> =A0@@ -1,4 +1,8 @@
> =A0+1
> =A0+2
> =A0 0
> =A0-0
> =A0-0
> =A0-0
> =A0+3
> =A0+4
> =A0+5
> =A0+6
> =A0+7
>
> So the new diff correctly represents the change, and on top of that i=
s
> shorter (by only one line, admittedly). =A0What makes it a regression=
?

Thanks for inlining it, Thomas.

> Franz Schrober wrote:>> Hi,>>>> I am using git to manage some patches=
 on top of the actual upstream files, but noticed that the result of gi=
t-format-patch changed between 4bfe7cb6668c43c1136304bbb17eea1b3ddf0237=
 and 27af01d552331eacf1ed2671b2b4b6ad4c268106>>>> I've attached two inp=
ut files (I tried to provide a minimal example... I am not sure if a sm=
aller example is possible but at least both files are smaller than 10 l=
ines) and the results with version 1.7.6.3 and and 1.7.7. The diffs wer=
e created using: git diff anonymized_orig anonymized_new>>>> My .gitcon=
fig file is empty.
This has been "fixed" in v1.7.7.1, with 713b85c (Merge branch
'rs/diff-cleanup-records-fix' into maint) - "fixed" in that it gives
back the old behaviour, not that the diff produced is incorrect and
needs fixing.
(I'm running 1.7.7.1.599.g03eec, I get the same diff as diff.1.7.6.3)

--=20
Cheers,
Ray Chuan
