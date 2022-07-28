Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7BC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 18:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiG1SBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 14:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiG1SBq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 14:01:46 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9926C100
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1659031292;
        bh=XLSyoN8AR5z9yDo762jm0mFaRv4SRhPej7b/9Atsa7w=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=a2rxBt9m62uN4loLdFCYWMY8l/TG/xBdtdTUa58Iq72yUVUxA44WJB5zy2C9yURYl
         wD2iXbSp8J4i8cJ78OBrdBnD4FJGc3DVk8PW83p2H2vPl5UhuptRM+w75KC5HVa9rz
         HhFdK1CKr7NKt8HfiHJ633sZUtkG9OLtCI89RCvM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHVen-1oD3LG3JKb-00DHhz; Thu, 28
 Jul 2022 20:01:31 +0200
Date:   Thu, 28 Jul 2022 20:01:28 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Thomas Guyot <tguyot@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        CH <ch-and-git.vger.kernel.org@ch.pkts.ca>, git@vger.kernel.org
Subject: Re: Feature request: better error messages when UTF-8 bites
Message-ID: <20220728180128.dlhhu7wlbubvnyph@tb-raspi4>
References: <f5a49da29fd0e5577083f1006d394158@ch.pkts.ca>
 <4b09bf98-dae2-491e-9858-801a9bcdd2fa@kdbg.org>
 <1e454493-ca57-ca2e-7d82-7333a769817e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1e454493-ca57-ca2e-7d82-7333a769817e@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:W+ykqJUtIfYY3nEsTtwtR2ePTKmvc1vosCBIll/M+ThoWF66Qj4
 dbpi8CmjdnL18GHuu5caQEWn7/Fn7BtMQTZMIZcqZefE6Hs11NwtP4Eebp04gQBzXEJ6W6J
 0Kf0F0eqq62ddb3FIueGezlUd03uwSSht41EKuAcbiQJXvXizrGFC2ziBFeIKQI/ZpJY/iS
 1M5pSE7/EXvw0OvHu7Elw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:45MO1oZfTH0=:WIFKD0+HDxXxSWD8DKRRZw
 nE8HbylkdOBMb1xYFaOJRgN/xKnKdE0QETwjMvSj+7m3/2ayJCV7auMlJ3M5lP7jHorA8xgVA
 JPracnI9CW2R9EV3DkdOiaxgHfco7uOv+cnUJRY7kSSB/MWgWKjL02346QpV/Wh5d8V8PeHsv
 28Pfrz7h1imLGia12oKg61SkuY+uP0ndDyQ3Q7KARHl/QXzLnoNzA0ad9AC4NuCw2f0DEzG2h
 5nK+m9bnAPgc/h7UpZQXTrEr1D1pwaMUWoncOURw4PJZNCKD+7LLSEqxemzNNcQ5+V6ko1fIH
 TWnhVJJ9t8rabNs01OksB4OWr0aEhx1ujeWvpk3hBdukdfSo6tSetuEAsPIf+vwmDeMCsOZPu
 SHcSdGvvFoBvuCRKvvejrqUvejpW1OYpxMMtRw+CZAIE+KbmudTSIsGvh4o+HyEhe15B26FyH
 2shoT4bEqknuURYvN6HoLTssEIrTf5PKxjjZ9ZwX2B7thLEY2KjGUGx+2+OlLPbv9KX/1BD3/
 F29dWlnRpfEqJPvnho8YunWQF94mx3l+FpMWPSZcK6JXyMAl3hMO9NA6pfHsOMuBL5YvX8VQc
 rF9mw4JzDIqB700/lIDW30f6csq6bzXahBxBYz6S0L6D4FuVciNQlS77Fp1yPW9N0a6SoQmms
 FjEFyxFFqgHvA77Wjl/NcGNU9H0MME/n3sRic3zn56bel1Iy54vhyZ0LEJKJZScFIjaY/TEd5
 5pJJXSRaO2md6PtxYcUmnPw5mkSDs4+IvRXSIgKf8SOt7u5DXbWSTbPh3kWvNaxSmUpu+mVvo
 S3k7Jxk8IVYBtdwp8p05E2d4W80rACIyol9lyaz136DnQ3uEss84oyLsz/30sjqSGOHgbxVzX
 q9VELU2BC5hjcqn5+OMB9ChzI4eYvbsmXMVVicjhMVrHrKn7BhzVc/XnWTkYwsu5hSqrwHcSy
 lOpI55bANGzsIan0sdAe8gmo94R9JEBEIN1QLSxGzx5+iAZ+xafJCK3uaK7Pyze0Sqk4u/clr
 Q6hMUAyejfApf4rh0BD+DBZ3MkuPzCOw15h6ivfYWxnaXhOk+ZZjhez3Tg5h11LTu49WGykGR
 VQVBpMhTbYL23eudnExZAFpcn1Wz6D0mk79eMVxHWb6IaWHbFPN24+VXA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[]

>
> BTW you actually raise another issue - I do think for file paths git cou=
ld
> either recompose (NFC) or decompose (NFD) the strings on storage and
> comparison (which should probably be an option... the current default fo=
r
> 2.30.2 is to treat them and print them as binary (escaped on print).
> Consider the following when using core.quotePath=3Dfalse:
>
> $ touch "nfc_$(printf '\xf4')"

This is not valid unicode, isn't it ?
Probably we need to use the octal version, since not all
printf() implementation support hex values starting with 0x,
but all of them support octal:

auml=3D$(printf '\303\244')
aumlcdiar=3D$(printf '\141\314\210')


> $ touch "nfd_$(printf '\x6f\xcc\x82')"
> $ git add nf[cd]*
> $ git status
> On branch test
> Changes to be committed:
> =A0 (use "git restore --staged <file>..." to unstage)
> =A0=A0 =A0new file:=A0=A0 nfc_=F4
> =A0=A0 =A0new file:=A0=A0 nfd_=F4

>
> I'm not sure how the Unicode will be translated here, it might depend on=
 the
> mail client if they even's get sent as-is, but both shows the exact same
> file name, one in NFD and one in NFC format.

Translated by "whom" ?
Most programs do no translate anything here.
>
> Both are canonically equivalent and reversible. It appears MacOS already
> decompose (NFD?) filenames by default and git provides an option to
> recompose the characters (core.precomposeUnicode) which, according to th=
e
> manual, is not even usable on Linux...

Yes. Technically you can have both under Linux, at least unless you
are running ZFS, which may be created unicode-aware (or not, that is the d=
efault).

But why do you want to have 2 files on disk with different normalizations =
?


>
> More on Unicode normalization: https://unicode.org/reports/tr15/
>
> --
> Thomas
