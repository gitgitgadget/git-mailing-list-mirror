Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4030FF1C
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 21:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766440617; cv=none; b=m8zUt2cBapCZnAKyZeDvhtFjfG98frerQfaWVh2UCDQjJRkMMLBdPU2THBbAZ4oZ/YglyQ/CupMfnZCw/RJufPVR8NWFQY1OXfui9ifYMDF/e0vjoE2zeb10PrPTLepVa/hT+J7c3w+fjlwW2l3vS5N610THPkj6/jUrIpa8GBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766440617; c=relaxed/simple;
	bh=hiYf/JDTI0tuGJopRjZao0dJDo1dBaGNqC7SLb1XZuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/2/6Ay8meJx53/kUZz92trxCAXlq0vAQf1/AMXG+4+prpqDFr4MnGrOEqmzxUi8osD9m7BtQ4Lj6DFSEMMYtCPjNQbKMyrMe94maiw8VuS5u7Ka9nagKwX/87Bs3uwjVuIlvAUMe1vFOab0g3/wWpqpQbuRx2VGxbEk6t/ZRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JasBlnz/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JasBlnz/"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso3664393b3a.2
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 13:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766440614; x=1767045414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXwJHpJQM82z9fwARb9m5Q5vW6O30IKecnlxci6D4lI=;
        b=JasBlnz/PBDeaue6TssmkQO+iGOeTNf8Zotfb1B6/w/mBc3lPGa5p7UFl+2qvxLVW6
         bwBiWo/wW1sUkIF23DXoXUX3602v/CAhfOoVbxxSKqo+1hHWIXsGCihq5lbfNKJDueQx
         XJatFCczh9skDfl9rKCqt163SUtKGHkvkq5waEp9+62+fKY7Tg28ukpAgMGvDEr7pt2y
         UuRSKd64E4rQo32gDBSIMO2VFR8yp/CCDhW/U0HrgZ1dzyJ8fuL6BOPXe3UfUGlKDQQW
         zNG4oeS9T1HvoD3askBsaCz0PxZ/IjJFlJB69IFGd26+16ONNC7NG5WVSN1K6LVoSX9T
         6W3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766440614; x=1767045414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXwJHpJQM82z9fwARb9m5Q5vW6O30IKecnlxci6D4lI=;
        b=RisLAm6spapz5NYc6HcpjyNxupIAtxKkYO+6w88IngNbBeawQugZxgqIt2DMNv55rp
         LOQVP+x7W/HHTkLo+Wed4mKzPMDTlTuVkIXvoFQVSilewAZlLqGnRxh0NzZdVYKz26Yk
         0U80trxcGpqShHmNAOKMXwcZL9BmhcZTUAGoBtW4ZaC1eaC+vsbFn/DDWEnTyiqEqSeu
         /+HmtxabfesiDqD8uLEfjgLVGj+Ae+VQQWUh/iF64YGrlHE0IeSQ+pYaA1jtjfrKNVlA
         X1o+PNO96SaO5qlnI+TfEbxzD+Pa63J/+6x9VXHVGUpYpGSdAs1CVU3kSqp8FwNZX04r
         E76Q==
X-Gm-Message-State: AOJu0Yxj1dpNWVQFMXl5Ic8lj5DTwK4ndfApEB70yINZXUfQ47uBXnt+
	pHUobNY6eqkMG+nD+Hx8EPZf3XK7iqctqFcnqSnssSgbZyB57UOIr5RduGF5tMSPXiCRkBzH65m
	0BgAuYh6hEmBC9F/7g2f87nxPbMqBhj/SY+EN
X-Gm-Gg: AY/fxX6LnkXKEcM94KmomLeFJITFAjF9RP5cDBAwElksvmoviHzXe0kdLLMogC6qJRN
	Ki6CttTX+fUsRfwqTiq7muowBWc6b/x42LxE6KQrXaKzvT+ZY4Iqc8VSWYVZ5h/az68yO8Ceg6w
	QDGfhneehefJoJ0NKzW0yUvbPIfJlhd9NdvyEDn9uLU/lb9yIAjjhEOBi0QbG0NU7jHCL0zOTIZ
	y25ICDBI7gEU4XAUhJtVNfQ1WqySTW8qoIfGq2c5+2XiDpgPhFkXmMWGlnk8VBivb1u9MCKtQxd
	rM4oqs3VMX6yiXQvGJHfBPUbmPwc
X-Google-Smtp-Source: AGHT+IG4GZ/aY8ue/GO9Sp+zQH9ObOLbrosBt/53r012Up28WPZjMZe/wQbkN7LWwZigKrVu3nhW/1eFbvFziBZBLgc=
X-Received: by 2002:a05:6a20:6a08:b0:342:1f0:9af3 with SMTP id
 adf61e73a8af0-376a81dcc3dmr11087787637.29.1766440614573; Mon, 22 Dec 2025
 13:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHnEOG2o784dk+OpkGt-1qjRJb34=sFMJvh-JRJ3v+GNBxFywQ@mail.gmail.com>
In-Reply-To: <CAHnEOG2o784dk+OpkGt-1qjRJb34=sFMJvh-JRJ3v+GNBxFywQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 22 Dec 2025 16:56:43 -0500
X-Gm-Features: AQt7F2oRwcklm3LH6afIRrJooS2lzqxBmh_fwctbnqyNFsynCS0IOn0Ofy5al9k
Message-ID: <CALnO6CAYaOQBOg+8pUZk95frML5tod+N_n3avxASRL10sLtwwA@mail.gmail.com>
Subject: Re: Metadata for merge conflicts during rebase (to aid rustc) and
 potential for better user experience?
To: =?UTF-8?Q?Esteban_K=C3=BCber?= <esteban@kuber.com.ar>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 9:31=E2=80=AFAM Esteban K=C3=BCber <esteban@kuber.c=
om.ar> wrote:
>
> The questions I have are:
>  - can I *avoid* `--points-at` in any way to identify what branch we're
>    rebasing onto?

According to "git help rebase", ORIG_HEAD is not reliable but @{1} should b=
e.

>  - is there already a better way to identify if the rebase was triggered =
by
>    `git rebase` or `git pull` (configured to rebase)?

I haven't studied the internals on this yet, but I think the common
pattern is to look at REBASE_HEAD vs. MERGE_HEAD.

>  - if neither of the above has a "yes" answer, would git consider *adding=
*
>    that information, both for third-parties as well as to extend its own =
UI?

I think "git status" already shows some of this (maybe not the
branches in question, but certainly the "it looks like you're in the
middle of a rebase/merge/cherry-pick/etc.").

--=20
D. Ben Knoble
