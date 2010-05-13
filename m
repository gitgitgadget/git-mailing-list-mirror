From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Thu, 13 May 2010 05:39:03 -0400
Message-ID: <AANLkTilQjSKNYq8NEabcsZc5WWF86kWMWxnTy-mShVgS@mail.gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
	 <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com>
	 <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 13 11:39:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCUsr-0003Ag-J3
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 11:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323Ab0EMJjH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 May 2010 05:39:07 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:41523 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab0EMJjF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 05:39:05 -0400
Received: by wwi18 with SMTP id 18so698095wwi.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 02:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=viTTwsCt0C3zJRa2kjkcooJVo5d6DZYXG9b8RGOXOyo=;
        b=Y20pv9/4NVvdZVeMnaC6Cnee4m6EMRY+CZjgqfdJFy+LL9H3vUKpvm/xFM/FpB703O
         AaSJfJtpc4Rpp3256v+Fa5jCJevz4iLmUuwG60+aCV9UlXWB2cSauGIAqszb04WRVZFr
         EeLOk1KJ5lvK6cuOEIfaqs4FSCVkSZ9QdvheA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GwSvo2BYDmpgNfojAG7HjbAfVE3oeDG2Oy2E3cOR8cKr8i7AjWxw6FDr3GDU+iJ8iZ
         onj5k8wGBPIfJkAQsCd/672zx9zOLQycj3Ai+Y+ljQdhakB2X02Z4IU+OWXWZSGOKbb9
         N4FWUqNawSaiwZPjWHg6wTRsERD5UWLfXBor0=
Received: by 10.216.169.72 with SMTP id m50mr2404346wel.169.1273743544226; 
	Thu, 13 May 2010 02:39:04 -0700 (PDT)
Received: by 10.216.7.207 with HTTP; Thu, 13 May 2010 02:39:03 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146985>

[...]

> Now, it _does_ make sense to say "eolconv=3Dauto", but that's because=
 it's
> that totally different case: it's not about what the line ending
> character is, it's about whether any eol conversion is done at all. =C2=
=A0So
> for _that_ case, it makes sense to use "eolconv", although even for t=
hat
> case I think the name is not very _good_.
> So if you rename these things, keep them separate. =C2=A0Make the "am=
 I a
> text-file" boolean be a boolean (plus "auto"), and just call it "text=
".
> And make the "what end of line to use" be just "eol" then.
>
> So you can have
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0 text=3Dauto,eol=3Dc=
rlf
>
> that means "autodetect whether it is text, and use crlf as eol".
>
> Now, I'd further suggest:
>
> =C2=A0- "eol=3Dxyz" with no "text" attribute automatically implies "t=
ext" being
> =C2=A0 true.
> =C2=A0- "text=3Dxyz" with no "eol" attribute implies "eol=3Dnative"
>
> so now you can write:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*.jpg -text
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*.txt text
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*.vcproj eol=3Dcrlf
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*.sh eol=3Dlf
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* text=3Dauto
>
> and that means:
>
> =C2=A0- jpg files are binary
> =C2=A0- *.txt files are text, and we use the default ("native") line =
ending for
> =C2=A0 them (implicit, since we don't have any matcing eol rule)
> =C2=A0- *.vcproj files are text (implicit), and we use CRLF line endi=
ngs
> =C2=A0- *.sh files are text (implicit), and we use UNIX style line en=
dings
> =C2=A0- everything else is auto-detected, and we implicitly use nativ=
e line
> =C2=A0 endings for them
>
> Doesn't that look finally sane?
>
> Because if we really rename the attributes, let's rename them _right_=
=2E
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Linus
>

Love it!
