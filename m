Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103223643F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 04:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774931883; cv=pass; b=l1jHR1KR1Jtv5biVy4BhVdOKYGbfocy9ttq3UOo1/dB/BMFOm7FzAh5oZQeNfb4QhKfJFPL/HAXlc3yFMZ5aLER5Oa6xaF0tjPeKlcXTq79a7JCd+L2ZkT/0rk63ojQnSp6Saz13OYOGdojmq2IpV07WdSEx2uQ1FjrDHSUKaP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774931883; c=relaxed/simple;
	bh=wNVVfCRyfvXucVtAD31/VFyyPW2GROQXB6rK35V0yfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQaqdWUtm3M979IK3iZ2ZnR74+lq2Aon1co7bzQu13XRhAh9u7Suv2IBtKnHiutaV+zxUxtiNnn/gkcdNXWdNaID44CC7ekXPynMxZWc80kGVzgiVnKd+9dpDGAyUV2KZDiJTA/azqe7+YaaGReNhYNERxFKPTr039uwmQw+NqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWmWjGoI; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWmWjGoI"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12a695044a4so1780836c88.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 21:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774931881; cv=none;
        d=google.com; s=arc-20240605;
        b=kJ2BFRw3pEl98g7nCCCKCVAg6RMlGY4jOHgQtE52bGEq61eY/j8RnN2BXP8/+Qvea7
         HuU/4xfW5fEnUiK8rs7bOBrhbGdU1uFjj+iqVFIMrJXQTtxMpnXKfoUWm52o1Hk00aZ+
         pDOrWQrO1M8I5HZ4rwib/Hn1L2DrhONHWweCi/N0dLeghC528vPkgQaxUeeIAoA2PLp3
         mCfxXgeVgjPnuUWVU4hawBXfxuwty+v6Yrmtrbc446vmurfWEzVJF996XvrvuSY6GwKU
         Hfo3/nd122P8Oy3NdOhMeswFCKSBrf17Jtp2/vVUY1BjTmeurjMLjYqGfjBFMrTwzceG
         8caQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S3yfYZUAgyp9noN9XmtcK5WQvd6VtAQFTgoIyjJ1dN0=;
        fh=Z8mQlnSJr9GAT++M1E9F52K5GlvX0+ZBZKb4UlvpfYc=;
        b=TwVVihRGDaZW8RJtMPZX57+0/eWmqpYnXmZhYCXUQs03TrBieNniYvkZw3Pg+ETXjR
         DRwad1AQ189ofOQdVOQoJdox41BiPZyoqJvyIpjzEykeMIJGaMoDsuSNv7pk1q+hMYGY
         1Umo3Hxrfg7f0KCTO3rJ3jtjLFHl1F/uVSoP3T5KF7T6lad+3xGPmdPSLZuWXGUK6pZ2
         GfZsHDwrR//7SRhFGzo44NAsGcAvQTLHOjLQYJ675iZyB5FP1Z6GKNrc1l2rVttdOl/V
         qvtPEfbHqm6GDLkaYk6iNu5ajfptpnwXp2Ew2L5YNFkhOV5VI8ag7woAA4Yefh7idxPs
         3rEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774931881; x=1775536681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3yfYZUAgyp9noN9XmtcK5WQvd6VtAQFTgoIyjJ1dN0=;
        b=jWmWjGoI6VtwgvpF5rdo3Lew/B/DvWCdsqnJgykv5UF53M314JynERWUjgK7bArHlD
         B4DaFAxureNgPPtGIudSCbDhIReLVZqPanwjLU4KYXOxKcdNUcFo2jBrYSoD5hwX9klT
         kubmbldbjF6RKafpPS/V4ps0eGlFpRuMClVGbEN8OEeRFAa97Qe3/zauafOwc7J6+VDx
         STPkJnB7UP7+jh0Tat3d/i/e/hO+vQX5kKkIB78kc9Hw+stbIazRGp5jCQ7O2L2oPxQe
         8RPYNWPoSXhtqVptcenmPsexn+qCRnyjBwE6OlIaIDkAp4PHDHFM9t5j0HUAOPpVR/CM
         BXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774931881; x=1775536681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S3yfYZUAgyp9noN9XmtcK5WQvd6VtAQFTgoIyjJ1dN0=;
        b=I/KUruFHtOYSwc7CbAF1V5I07NwLaC3qQM8Pj7S7a/0zPIA4YvJMTthIQ08fi0oe8E
         OUzTUwAy0sCOOLoaE384m6pR6ZunykgNn4Z6pEqDIiusarSYpop7UXrr+VtxppyW+r/3
         awAcUEtP1x1vfoEcoEDKijzG+MQveSrbHABmoPv5FvOM03gpyuglM2x4yRaFnB3iVz20
         /hHdgnQdcatEX8aN+O5xRhPp/5jiYH+HSpJDY0hF6yDffxKFF2TVZBQbLRXjMInOkuie
         GX2ugSk8uw9PvWDptkiL47cgfeuL+tyosK+SXohN2kGe5PwrY5YFv0ccnA8vxyL+Wpc2
         IWOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqO9zwJRfICHUKXeNXRvmNkAK/ckLgW4AObG0CMZ7BnIt7NSO4rTHfU0CVjBEEDMvf+OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIb9leWRuTtMDIH0DkJdQ3sliMRPLXo4W3W3md22SR0Fdps2CA
	pC5QtqgoVOytkIYvNKKp6df4oepIMzWLblMfjbPfcndnR+2kWwyuWujd3giwanE/RuvWlSUPIk4
	UX8s4JLnFRObAqDPeMlsMaD+tBg02VTk=
X-Gm-Gg: ATEYQzyxmG2PAXtbhNkcgZ7H/iDc8ZW0Er/7aRRgpYhRylW22N9Sb5Qf2yvowefVD+Q
	T+6rvxwC/VWqJv+MKdjUvOY5qYf3aSXUhnH4Rr519NLkP1anCGZ514fV4VNijk/4XF5ERuRRM+L
	TbbaxUn9NNq4J4pz37aee/f8ZQkt8apunNKgI+4ezFlrC4aCcTOnUftKltzcGQQ5t3L1kqL3k7T
	Lf5NCbgMIslVKbY1Yv4E5svu593gWAOC6Q7GJBoN+/IRXtCOZ2oilyG+cu4lhpTreP2dXJhNXm2
	7eB4JcWA79nROVILhJBBbt0TfN4KPwfBjk/fHcH7W52ZzmlSIY9iMfYaj1zb+Hnve+hSxiCs+97
	1vDDaVlY=
X-Received: by 2002:a05:7022:6b94:b0:127:5cda:fb7d with SMTP id
 a92af1059eb24-12ab284664dmr9133508c88.6.1774931880946; Mon, 30 Mar 2026
 21:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
 <cover.1773704908.git.worldhello.net@gmail.com> <CANYiYbFpexxr8hihAQA_v6Gr+mvxS=1GKToDVf-O2B9XXwEWaA@mail.gmail.com>
 <xmqqfr5g4qjb.fsf@gitster.g>
In-Reply-To: <xmqqfr5g4qjb.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Tue, 31 Mar 2026 12:37:49 +0800
X-Gm-Features: AQROBzBQ0mPrD6TMrysqBXrxFm2rkxn0YcQiYLed3RtUNTWtUd2Mw0ijYyU3EmE
Message-ID: <CANYiYbG9i9FcYCPbhS_DyhubEPJKjfxkL=wmYFLMiBc8+HdM_A@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] docs(l10n): AI agent instructions and workflow improvements
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>, 
	Alexander Shopov <ash@kambanaria.org>, Mikel Forcada <mikel.forcada@gmail.com>, 
	Ralf Thielow <ralf.thielow@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, 
	Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 11:38=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > The l10n window for Git 2.54 will open soon. I will merge at least
> > patch 1/5 ("l10n: add .gitattributes to simplify location filtering")
> > into my tree. The new GitHub Actions workflow already supports checks
> > based on the filter attribute.
> >
> > As for patches 2/5 through 5/5, would they also be appropriate to
> > merge during this l10n window?
>
> Up to you.  I didn't find anything questionable in these patches,
> but the area the patches touch is in your bailiwick and ultimately
> it is your call.
>

I tried using AI assistance on top of the current master branch to
complete the translation of po/zh_CN.po, and translated a total of 177
entries. I also used AI-assisted review, which gave the result a score
of 98/100.

    =F0=9F=94=8D Review Report
      Review score:          98/100
      Total entries:         177
      Perfect (no issue):    170
      With issues:           7
      Critical (score 0):    1
      Major (score 1):       3
      Minor (score 2):       3
      Applied PO:            po/review-output.po
      Report JSON:           po/review-result.json

    For full review details, see the report JSON file

Manual inspection found that in multiple translations, the placeholder
order had not actually been changed, yet positional syntax (%n$) was
still used unnecessarily. These cases needed to be fixed one by one by
hand. I will update AGENTS.md later to reduce the chance of this kind
of unnecessary positional syntax appearing again.

    @@ -8980,7 +8981,7 @@ msgid ""
     "Unable to create '%s': %s.\n"
     "\n"
     msgstr ""
    -"=E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E2=80=98%1$s=E2=80=99=EF=BC=9A%2=
$s=E3=80=82\n"
    +"=E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E2=80=98%s=E2=80=99=EF=BC=9A%s=
=E3=80=82\n"
     "\n"

     #: lockfile.c
    @@ -14663,7 +14664,7 @@ msgstr "=E6=97=A0=E6=B3=95=E6=89=93=E5=BC=80=E6=
=96=87=E4=BB=B6 '%s'"
     #: fetch-pack.c
     #, c-format
     msgid "couldn't resolve 'auto' filter '%s': %s"
    -msgstr "=E6=97=A0=E6=B3=95=E8=A7=A3=E6=9E=90 =E2=80=98auto=E2=80=99 =
=E8=BF=87=E6=BB=A4=E5=99=A8=E2=80=98%1$s=E2=80=99=EF=BC=9A%2$s"
    +msgstr "=E6=97=A0=E6=B3=95=E8=A7=A3=E6=9E=90 =E2=80=98auto=E2=80=99 =
=E8=BF=87=E6=BB=A4=E5=99=A8=E2=80=98%s=E2=80=99=EF=BC=9A%s"

Overall, AI provides very significant efficiency gains for l10n work.
