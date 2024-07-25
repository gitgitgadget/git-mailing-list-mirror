Received: from sonic317-26.consmr.mail.bf2.yahoo.com (sonic317-26.consmr.mail.bf2.yahoo.com [74.6.129.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B71F951
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938510; cv=none; b=PzifD092dLDw3O5NOSXy1cJN1v9LLqsVLxrUymXSlZABKDbk9K7Qtua9vX8E0WX3YuD3lyHrKchLw7u1ZvjXnnmQp9I35B4dPH+vKxl7xnll6VQyylThztMcoVNu60+L05QQLxvpi0+DJ72Pya61DzB59HEFUskwgUbfh9KGrMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938510; c=relaxed/simple;
	bh=0Dik9H5rHd6w6pqYhT2QOYn45GsMaWc6n3NFOt+UeNE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DwzPnokZPtcuwtjjN5nnwyqTX2TGsN2BxrNdH9b1VW4N938X17jxAxpJl6GnufU7QK6KHzN+sH8WypqdsvUni7Cg+cGE1ZnrtTXejGOCwAW+S4/Nc1Jh1CGYZcHM197YeujP1qKmAaf9eFB7jCyoT17RNbY6T2IGjjpl5PsbBvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Sgf9qmer; arc=none smtp.client-ip=74.6.129.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Sgf9qmer"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721938508; bh=0Dik9H5rHd6w6pqYhT2QOYn45GsMaWc6n3NFOt+UeNE=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=Sgf9qmerm+H6DraMlMzicyjE/rbfbDLWyBTopeKZ57VJ3P9HD/4uDYuYD+uvry+Du1MjkYaGbz9xvCe+bJi+1/N/MT9KbK+pKIjs0b9VcMHd6TP5YW/jdAOuAiiBgPa3PdJDCfkYaF+tcAp59McwVLHNJYHrksWDVRjAcJS+5oCINpGRGTz2D9f73v4PCG0q8d07VI29zSn376d8zPfnKwaiIbubaHzzyizbJhNTDcYvjH/sdmFYt3r1mLV2Ied2rFSAIpDz1tKm9Dpz2imDP6a3nruKXNZ+59FW37YcJhSFDUcpEvoLL01Jatn9HKVC0Q8Nyzo4uRgHEqLSDmhdjA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721938508; bh=A0szN6jn4/uUfh4QPEmPGAYwIfGoC6CGiq5akgKxlcp=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=a/ORm7aUHgzVIdFbA+oZLuXpipWpkdaluN8lrzPXTVbkS6lb/mtEVQfdxbeRwvRyhI4nk0cAbrEvoZE0EOJ7pKO+WXbNDbfhGm5yT/w8XYt3yAKvDbNsIiUrNWtndHqhxAnIGO61M/WzreeQmFd7elTV3PnPFM2P1xsKNEw+4+SsKswqr9ErplILK6345PHwoO2AgTdv5CF7Mi0ZmvDKLPdLGVkaGXvIjEQc9unlm5KfwChcGjvIS+rCieBxKS6obspM93qDQn58msZeaRPDZRn9HPepwZRVZMuUHGq+oL54w+LnjhoF91HSAh5r9VVvItwis4PvP+rh40F0Dpyspg==
X-YMail-OSG: mRt363AVM1mz9FRCKi0Up1ZK0esrzbABBEtRKoBzK4fLFm1i6Nxyc.cMTP_lmtL
 Pj_zKZs88RsyKTbd7VcA09lqnRbZKC7DvCtfr02GCpgeH.C2mYxP2QOmlGOQHdF6td.4DiMttcbH
 UpmBGnKAolOtw.GBkhMUcomcAPaJFe8omPOpmeOmKBQdj1.vqODWq3C5N5cRxNd1R1QBTkZ8lU7f
 jaAJVnnUvlutTKu3OugpGHULxc2xr9r4u3y0YKdhUfnRNyZ2btOuQL8ujGgVxhJ5J9tqvoWEsZHr
 DSJeomNRWkaIwgtC4_y3OfzCX_AqtfMk93AqgAWn0FsbOAdku59N_za3wcOwlwLhyqS3eouEa.UI
 C3FVOvSzY2uvxmCW9eu86rU7uXj0kEyzeKyviEiOennyAmosXeo2kBW1wIjhH1zwmEPN3P.mB79K
 B_SKxnDvsXHOe06.eXJUXvboYR9Hqf8EMO.azSDSMaPPR9qsPmclNVtX6JlYH0RGRgEd5YMqNSMh
 x9m1foRyq_hvnunVZfCnsMjdo7JynqA83p_J1XOOyFsm7dxEo7Q6cCTqaWiesUt4NN6Q_wnSMWsV
 RNAaPUsvJb97R_9PW83jvEF41i8nry8pke9ia1u.iNNLbmu5wViy8Mhosk3AQk6Q89e6fN3dRyYw
 g7nr89tbI4OOax9Bv3JUuoR3KlMul_Tgddah32ZbMEyJWqdtJDRUnS2aFAhuEGLS4diIfwGxu.Sg
 sd2AyvoWLb2D69F.mE258D7yjXRPtLsCAScANBfRWldZC5oWoCvjJ5lexw5IAm1lPYv7E_TfP2sF
 .gtDTNsF5U_MM9TuEyVdR46MEo5sNHy.rnWIrk8nOU3M0nNf2z03AeB_GBvxUQrwqoEQUf56.SKo
 H7BO72vUyfbEaRwGi8ji2Bdc_8YQIUldwrxd3emqZEaJI.RmyxDTIimFexvact.MvWZQ3E5fP6MF
 pA6y99chdmI0Caf0bALEtZ6x.jz5dyiFmT7._CTiwoIP5cNnb2DBgy.cs7VRZNKa7qiB7xn3i25j
 skBkoO_KlS_4qs.kGl3PWzWtc5Z1OGLm_hkGsEMBnPHIrQZDtZIUvNihpRMLlBzl.OGC4J0SBE7C
 JoCZViro7SzeFEZaHbls37vG5AKG.zXf9AvkNodUDikDze3IlMVvrseulxdm0GEH8LdtmwrOr7X1
 2atqXD61hrog0W7VzQVvPH9JBfTUd_bixnIIoLd2klvgdM_9Iy93q39eBGG8qJxfBVJpXOwuf1km
 tAzwMMELmEUwI2igUFlVd7Mp1m5LAZk056rQ1aBPhd3mgdg.a9W8h72GbOAN_6b4Fdd3AkdgwTGc
 Q3WfAVTRvBw6qaSEplBXXRt0V55QsQ15Rr2uscr_XVcEuqB5VPYvbQ3DlGUb58OuW1whB849mTJz
 XLEmUF3OKh5zEMs7P9r.tI7_Ba7jiBYC8zKRpggNkzbY9E8gVfJfw5B8GEoV12Q4z7RZlqIDw3AE
 Lxh3Xrw5opPaSF8g2Oke0a4_I94.Q0RLrBZaPy8nyJHINu.GhPIyVJqGO2s3Y.1sH5QfR7mhbwfh
 8xSs7y0AAkMAxVRv04nH1.Agfwep3Xqb1PcPZKprCjnhtLD43x.Gfli6KGaHrCUZqChdMviEWgfz
 981agUfxw_rRfa_vqypek7k9R30p0DA1pm4dyJYtEsqTU2ftMudVqTfm5YAyc8.J3_e49l7WN7IM
 Ql3yegTq91yGNkslIvRFPQ08sW1tYvbnYJSU0BgDjBk0jb2gN7qJ0kmJGbix8l8ELsChAvkZb35n
 u.Swa2XIjxArS5Ckh4ZlQ8GJUdY26jN9H1OYog5RDXYyuURekAe8YsvaAd0r.J5d7RSO2JQ4b5pd
 Ad1UgqpNCrqolM07vaiMZoAEXQxv0xLQNrjKAvj_qOrJcPblwRbNKB8jOfgaruJvE..8LiFXbPj1
 8Ildu0oL9JsnCbOauZevCmehdwqqABe2og2VAy3SmVdk4UkUlc9Dmgfrma9mR9Q.qH1k0PPASyiR
 Hbaa093JqcFoDmxrwpqaHE8b_eG731dIACOqD2M8xxsRnXs88urI0GuY7hYXiF5Cqez.Mny2gqBI
 7CH4ZXuqKcZTKUzWj1DEBAG8LpAKvtFAfrn0ADBwSbfGA8UnLUPMs8Wa6WkQ9BYNTqVJGWCqCry_
 Zmc2hTEkpvmrvGgRCpHxGwxnEZU8kEpGj2yhqWOy_3PSlNqKjMj4mTkduU42o81J.iS50AQ72Jjn
 f6PBHm_jj
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 131a2909-a098-4f72-8368-239172dc38f7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Thu, 25 Jul 2024 20:15:08 +0000
Date: Thu, 25 Jul 2024 20:03:19 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <511935853.2797881.1721937799082@mail.yahoo.com>
In-Reply-To: <xmqqsevxignu.fsf@gitster.g>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <1c1b58e20cab6b4989b140282353073165f0067e.1721762306.git.gitgitgadget@gmail.com> <xmqqy15rzwi5.fsf@gitster.g> <1542063589.2363688.1721786934049@mail.yahoo.com> <1106076396.2672924.1721906849141@mail.yahoo.com> <258254527.2690084.1721914093743@mail.yahoo.com> <xmqqsevxignu.fsf@gitster.g>
Subject: Re: [PATCH 6/8] git-prompt: add fallback for shells without $'...'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22501 YMailNorrin

 On Thursday, July 25, 2024 at 07:19:56 PM GMT+3, Junio C Hamano <gitster@p=
obox.com> wrote:
> I think you are over-engineering this.=C2=A0 We do not have immediate
> need for such facility to be used by other scripts.=C2=A0 On the other
> hand, we know exactly what git-prompt wants to see available, and
> you already implemented them.

Yes. It was a misunderstanding on my part, and it was overengineered.

But because I initially misinterpreted your statement as
"disallow $'...' at the guidelines, and we need to find one variant
(form) to use", it got me thinking, because I wasn't very happy with
the existing form at the patch either.

And it did eventually lead to a solution we both liked. I'm OK taking
that road, but next time I should probably wait a bit more before
going pulic with half-baked ideas.

> So just losing "make assignment asuming $'blah' works, and then
> reassign based on what printf gave us" and always using the printf
> thing is what we want to see here.

Yes.

> Are you sure that everybody's implementation of printf(1) is happy
> with \d and \dd?=C2=A0 I am an old timer who learnt in a distant past to
> always spell octals as \ddd without omitting any leading 0-digit,
> because some was unhappy.

If I knew who "everybody" is, then maybe.

But "learned in the distant past" does carry weight, as do existing
practices. However, there seem to be almost no cases in non - /t/...
files, and most of them are in git-prompt.sh.

In test scripts though, it's a mixed bag. I think in decreasing order
of popularity:
- Always use \ddd form.
- Allow less than 3 if it begins with 0, like \01, and many \0 .
- Yes, \1 or \4 are fine (there are not many of those).

I'll use the \ddd form you because you prefer it and it does seem the
most popular (I think also outside of git codebase), and even if only
for being bullet-proof against following '0'-'7' chars at the string.

But back to the question of how much I'm sure, then I'm sure there
are exceptions, but I couldn't find one yet.

It works in all the shell-builtin-printf I have access to (~ 20),
as well as gnu /bin/printf. Obviously there are many common ancestors
there (esp. ash and pdksh), but they are still different codebases,
and others don't share code with those, like ksh, bash, Schily, yash.

As a cute data point, this printf statement, copy-pasted into a 1981
BSD 2.11 running on PDP11, prints the exact output as it does today:

=C2=A0=C2=A0=C2=A0 printf 'a=3D"\1" b=3D"\2" c=3D"\33" d=3D"\n" e=3D"\r\n"'=
 | od -c

https://skn.noip.me/pdp11/pdp11.html=C2=A0 ("boot RP1", user root, no pass)

On Thursday, July 25, 2024 at 07:24:08 PM GMT+3, Junio C Hamano <gitster@po=
box.com> wrote:
> avih <avihpit@yahoo.com> writes:
> >=C2=A0=C2=A0=C2=A0 eval "$(printf '
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __git_SOH=3D"\1" __git_STX=3D=
"\2" __git_ESC=3D"\33"
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __git_LF=3D"\n" __git_CRLF=3D=
"\r\n"
> >=C2=A0=C2=A0=C2=A0 ')"
>
> Modulo my superstition against \d and \dd, the above does look
> very readable and hard to break.

Thanks.

