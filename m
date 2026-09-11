Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043FA3EB0FB
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152569; cv=pass; b=e1nVKq9k/OKP2ZzUhawqs0WEEOr2ehAdFeveHGcOVCamh2UpXzuQXB2bpxWorMeN/7jdww9H7UHU6CImVxenEfQWy1g4pYaeB//85tIDsbsmGy1KWHX2NsW32LS3dJuIfeBvYfuya8oxbYqAKCsSOuGKsQSUtGNlpXY9IA3yG4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152569; c=relaxed/simple;
	bh=nzPZauGSFBC5cSv1IsCx3LQD0gCQd2pAML9jOVeXuvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JB6ZUYtyo5aRGiSSy8upFuA2ZwP971GlWHgpigbIp+P4xXdkX+SfwQV2cCVSof2Hi7gT5DTRJaS6Ng2gqWvQN97oHcYCX01NkER6dBd2wntlCoNUdFYwaBGCz1lwuqU2dh1j7Gubr8zbVf5BebdQkiJ0Qa6E6dQFlcj0TRBjX/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2+bVTmh; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2+bVTmh"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7daaso449106a12.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 11:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789152563; cv=none;
        d=google.com; s=arc-20260327;
        b=sSaF89GyI/HdGnifZYYnul/8On/LIS8OhUzYScPX/oZOO3G7xFSyghf8bsT1WWRtaS
         DWxIZZgmutdfu3koryttgi7D2++ul3hHkmUiCKhI0P48S1SlJqyUGotWc5zbvNfankqN
         UpKKvaTk03GZhC5nL9vH/FmLNLWVyf6EWJcFTrztxPl/xQWdXZm8eM02LZ8GRuFRLP9K
         AJH6IAgiVykTm8XLF1MVwiEAgW6GqMcRyaDvPWICsxou4vZCLbC2DMsIcVowjWYimcBa
         PkiJ67GkXm5kPNDtXXXxVxfbD9gNiyvfBn+dMw37q10JEv5l/sPCI2mVOUTXsrmY9l3f
         Ms3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mOIE3v7It77XZJN6ECwMLnNQcsVvX0E+acYA1zJaIQI=;
        fh=XjBFa1/L+Vg4GVQ7DpAnAEqKlPwShRxpZq3XgwJxQx4=;
        b=kkMNmsliv8SzS2JaUiEXvPFOHpnJzvBKqPSdWI24KuNi1EbfmNJnbD9/WcM62pDD/F
         168irrzU0etopgJU/Qp9Wf8vlUFs0LIdHEbOZDm+GGJweGugmazU192S1qbvLRAZ5XVu
         Fq1pcj9vVpivY/RUwrJ6pBoKiqlbdp1JXSN3DreUs5yNWFJrpJghQg7kPYiyapYL7zjf
         obIK68UVJJZSQYr1YISys3PuaajrfoJXySaFf9QLqagsGT+NtnKj2ROjV7CvhOY336af
         Gte8+fZISvUUJOkj4tNv6i4BkCvRruhV7u1HHIkCPXpzYzzr1c1AzcWlNuF4/WKEpcnx
         hGrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152563; x=1789757363; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mOIE3v7It77XZJN6ECwMLnNQcsVvX0E+acYA1zJaIQI=;
        b=P2+bVTmhs2C1WIvEz+kuSHr5sE6Y/Tty8TV5SPO3wg/4SUaB8IbIV9aNDm1mq+VARi
         0a1RgMThaSYZuodaGNm0AerhVBzODctUGmzR/4XTjnpHzkCNYSlP7HkBwI1yXXr9dj77
         fy7dPZa4DrDA+1bFzjPS1nejjzRIsMMvu0fMEwBl8ZO1smGzDgPeeKLhV6nN9YGAy7h4
         9j5uXwmrUASXsHuynmDf/NwlUnS90zQ303JQD07c39QguBO/lNbL33TRCuF7h2G6mjfz
         Q1OhqnmpV1a3NS1je26AiqjuxuTmG+/KTFe7Qd/yKaxyVxFv14xVtTNFdTJso4e21zyJ
         spfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152563; x=1789757363;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mOIE3v7It77XZJN6ECwMLnNQcsVvX0E+acYA1zJaIQI=;
        b=hiI2SI5ZerbSHnzdGBYpfKnLnZhCJSAPT8YV3Ap83yQS0E05ZIdvRRI+9wwnWociwS
         4aEVcj9RtPA87n0d9q1QlUeyvuVPn6ftx76DtpArjksKofOL/IJMod04uE4W7PntozOi
         wlK4X9itc7Juj1UocUfb6kW/a9x6QcYzEB2Ean4pBAb8oWQDUC+2IegeSRcy6V7VM723
         sKbtKYWctSgFP69JQ+k8H0LzD6z60RvREDbmTMu2+3Nsis3FGthY56G6RNCxgXu7tJwe
         IqnsVF/t6BPKAJ5orDSTq7yFLJDuv//8Kiz8GK88/kGbWv54r7TFqiIr1RZNPQ5Ow6we
         jkXw==
X-Forwarded-Encrypted: i=1; AKwUvByxW7Rphp8Lp8DHbDLoNEdpOYUGhhJnHX/0mVRE1DMjAAqTGYgZzIvqzD3ocpctrhbSfYM=@vger.kernel.org
X-Gm-Message-State: AFuF++lh3hdAI9Nz0Q8BXbFdWAzXV7wNMMSkfw5BMbnbRu414bP4q01I
	mKOfZchF2kaFP4G0SCLQTLaYJjemaDhqJBUEqSq4z/wtsGFdKy7v2KEIJyLpJPO2/y0x9vWHmX2
	nJlXFH8UiD5++dfKD7B271p/F2cf9RWZ4Xn2O
X-Gm-Gg: AYBFou1Z8JmySvtpPy7oxAaucR5KQrpqXG/dqhm/3d2ooQXbSsk/orDOQgiNnCwpmyM
	5rrrrOXGWG7aLYShj/4ZnoCwaUzmHGT+gszSiKB0USzxMGfJJvN4/GwZdhRmmus+gS9i8hbPwkE
	EA0gzK5xgquUs8RrAMhDS7e8BI0yztKjOpNr6oMGzsPOSNz27B/FYmMlK/Mc7CWxtvztUDIkki2
	1jzuIUKvSeKzOovelwNfqQZ1y/Ep+4/bw9DZwvze+KKquMO0EAke8qV4N74FwclRwCv30PVj6T/
	2vxoGMYkUWPLuyfmo04FcFYq9ABSreOiI0gIICVvnbIXJwjlXYklEShlK1c3K4QRqQ==
X-Received: by 2002:a05:6402:2186:b0:6a4:21c6:1d14 with SMTP id
 4fb4d7f45d1cf-6a9b55008dcmr4830964a12.0.1789152562721; Fri, 11 Sep 2026
 11:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com> <xmqqik4bbt9c.fsf@gitster.g>
In-Reply-To: <xmqqik4bbt9c.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 11 Sep 2026 20:48:45 +0200
X-Gm-Features: AcwNN1WcYeqqz7ZLZpITRG4YkDs07FlsbYcULcAoXLG18HtHgeFAonLcXOPJA-E
Message-ID: <CAHwyqnWkEaQHsp5GtYGL9qg-FYA0Ngt_+omdh8jmw4KfqfX6Uw@mail.gmail.com>
Subject: Re: [PATCH] range-diff: add --matched-only to skip one-sided commits
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I wonder if the implementation actually can be more like
>
>  - give "--hide-left-only" and "--hide-right-only" as synonyms to
>    "--right-only" and "--left-only", and deprecate the original;
>
>  - allow them to be given together, which will give the new
>    behaviour you are introducing, i.e., skip steps without both
>    sides from the output;
>
>  - give a short-hand synonym, "--matched-only", to truly behave the
>    same as giving "--hide-{left,right}-only" together.

Seems like a big change, and deprecated options are a pain in the neck
because we can never actually remove them.

If we decide to go this way, we might name them "--hide-{left,right}"
and just not introduce a condition that makes them incompatible. Then
"--matched-only" would be pure syntactic sugar and wouldn't even be
100% necessary to have to achieve this.


Harald
