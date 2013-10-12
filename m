From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: Re: [spf:guess,mismatch] [PATCH v2] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Sat, 12 Oct 2013 23:52:35 +0300
Message-ID: <D89D1A4D-B9B0-483C-BDBB-BC6CAF6A4D2E@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com> <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com> <52584125.1090706@vilain.net> <87mwmfyru4.fsf@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Keshav Kini <keshav.kini@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 12 22:52:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VV6Aw-0000Db-94
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 22:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab3JLUwe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Oct 2013 16:52:34 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:44858 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab3JLUwd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Oct 2013 16:52:33 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so4653508lbh.9
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=TR+zRj5TVEEDhVDugQ5FTwfRP2LQsz2Pr7oUE/65wQU=;
        b=gjoFr/9LG86v3DRGLz5Pk2lDzLb1CrCY7uRNwkgs9/c9r4t7+74SPZFBQ4rnQyVDek
         SPkpNDXMVZWkyV8wVkkkdjKcptRyINk7PVTpDexzFX2UY0odxQtq5jpQ/nZGDwCzdOfl
         Zf1+oY5q8jRwL6z8+eGwcyRM9ddMjrX3Ls6baQcgDzJzCzrUKcQ08oV2Y9eRt6zIAkqJ
         eCSLexF1b7VNJ68BDU3KuwXqJx4SNAZIrQ8N7Dh1kNZjut3THwhJpnKrM2iP3vfIaKLK
         +28cZ0MN2IOhMl+krwlum9slAiD6XOBzdaofju7/ym8ugFYxn0aMLpEq4/bmgw2ZQDTB
         W7ZQ==
X-Received: by 10.152.45.106 with SMTP id l10mr22982078lam.12.1381611152696;
        Sat, 12 Oct 2013 13:52:32 -0700 (PDT)
Received: from [192.168.0.14] (cs27064221.pp.htv.fi. [89.27.64.221])
        by mx.google.com with ESMTPSA id ao4sm51474424lac.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 13:52:32 -0700 (PDT)
In-Reply-To: <87mwmfyru4.fsf@gmail.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236057>

Hello

On Oct 12, 2013, at 8:35 AM, Keshav Kini <keshav.kini@gmail.com> wrote:

> Sam Vilain <sam@vilain.net> writes:
>=20
>> On 10/11/2013 06:07 AM, Yoshioka Tsuneo wrote:
>>> +				prefix_len =3D ((prefix_len >=3D 0) ? prefix_len : 0);
>>> +				strncpy(pre_arrow, arrow - prefix_len, prefix_len);
>>> +				pre_arrow[prefix_len] =3D '=C2=A50';
>>=20
>>=20
>> This seems to be an encoding mistake; was this supposed to be an ASC=
II
>> arrow?
>=20
> That's supposed to be a null terminator character, '\0'. See
> https://en.wikipedia.org/wiki/Yen_symbol#Code_page_932
Thank you for pointing out the encoding issue.
It looks, I need to change encoding of "pbcopy" command to
"en_US.UTF-8" from "C" on Mac OS X.
I just sent updated patch as "PATCH v3".

Thanks !

---
Tsuneo Yoshioka (=E5=90=89=E5=B2=A1 =E6=81=92=E5=A4=AB)
yoshiokatsuneo@gmail.com




On Oct 12, 2013, at 8:35 AM, Keshav Kini <keshav.kini@gmail.com> wrote:

> Sam Vilain <sam@vilain.net> writes:
>=20
>> On 10/11/2013 06:07 AM, Yoshioka Tsuneo wrote:
>>> +				prefix_len =3D ((prefix_len >=3D 0) ? prefix_len : 0);
>>> +				strncpy(pre_arrow, arrow - prefix_len, prefix_len);
>>> +				pre_arrow[prefix_len] =3D '=C2=A50';
>>=20
>>=20
>> This seems to be an encoding mistake; was this supposed to be an ASC=
II
>> arrow?
>=20
> That's supposed to be a null terminator character, '\0'. See
> https://en.wikipedia.org/wiki/Yen_symbol#Code_page_932
>=20
> -Keshav
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
