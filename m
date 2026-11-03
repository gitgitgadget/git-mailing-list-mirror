Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700062;
	b=phu4BDu+Z3Sv7ICFttuwD5sp/QJxYC4XAW10CfDO/cGbpkepuHCActW6G2WJX+ZJ/Nbz
	 bijsauo1VXobOIAt1UxEUaMUsdbmy6MKIckqfQU6rwKpZjUXd/sdCJZEl93gZo/EYLMCD
	 QFue4sZWu4mwgfBZvSsvUnhgPJ+h5Pv3UNjp0ZvYpaSB83X+cJoCBT55KpnIVzu+UWlws
	 3xaBeFmtTQQl08tVV89Ad+BDK6AhWB4wMlq5AiAb0ONCQ7YKGjV8+bpQeTtvs3kM10Q7y
	 BvwEXBpTPs+7LmyOlkIIEceWQvbvcjfF8dXzPvN/53AFi7Fd1zn4zny7WJ7xfNbm+Bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=SufCO5vXmOofjrNc8DxAFwJiS5DhDr/MoaIEp3PctGY=;
	b=XKrL3iSrTUEmZO3GlWeAP5X5vRCDr28b/5VVoZh+07gdmyA6T++UEeW870pWc76DqQY4
	 z6cafqapQcW41e+whoumDTGAyHGwPXCYNdtwsbqSZHdnNPxSRn8Fk19Q9p8ypkDTXz1Gj
	 akT3R2VcqhVRTASAMzq2STRxZdfWfMtFP6YXiPJxtyYcJQImPHU/ojqpls/NW6lJFvk6x
	 UKtxiURFxF5vcac8TycDJ0Yt6glRCq0V9ERi3JTZYhfXhTZoZmpPtezXn0K3O3/DIEL62
	 YkhhSryY+0diZlSxS6tnmrnSE4k+i5F9kSsSej+2VisT8w2RB6OqieFcJrYsbkVf93A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ai86AIuu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97557606B355
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 10:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97557606B355
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ai86AIuu
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so932953241.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 02:01:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793700060; cv=none;
        d=google.com; s=arc-20260327;
        b=bPOSIZI3XmYdQF6jdIQNW8AE9ehV0CvhPT+/vMzbhPenPnZQaR+Q+A44SEf4zZwHv1
         lnML8aTwY+Va5vN2ob0gEWfSyTn7E82rjQSU+zOHC0B5bZ5yYMUfZqpvQrVhBZ1ddpH2
         1ETNLuxqAm714FEK47LucJUmfS+kGT5My/zZW72LJL7PP2SlN6SiNbXhotxjCpMLOHfT
         YXPZxNzTyxpNzP+XBfHfSWoQKdR5nOzGstvZUXau9DAYoRiGrzhvNr30jCq1p1N7eXH/
         vO6mkCO+DFfps1UUCw1OKFL+tJYB2JxiAZLCeY//FlPTXYuIh7x0uPeWBO/zMxj0EXIQ
         KJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=SufCO5vXmOofjrNc8DxAFwJiS5DhDr/MoaIEp3PctGY=;
        fh=MqLSLQvXULoGitqjW/cQkDcXLZlXO+Bls23DzTn9+eU=;
        b=EfkdfpcqpqGnxTWDNLhAaChR/hF8fmYuj6sKspwPE41vddN4FSpDrrsj7ftsppaVmT
         o4sgvGCgdGud4BYlskSu4p6SQfaJRFdLoglUFvloDlhJTPP+oMEb9gCV/IcI9JQtQ8Hu
         h6KV9KrW4V3q20WqEaYTYsguI8saLU84bD1BoivAn5u0514cmFZ+A6pzbRvJZwfoXA2G
         Gv/6Z8UTADSM9zbwZUSpYAV4xwnWtDztJAlXkrR+QhQFTL1EgUiQoZ2YWf71YPO0MmzY
         UQD+Dka3WeD1hpi4bnpPRAjQSk2wq0t0/bEkVYqQ1VxuPLlbSx4MqpNyheDCrjqbGYg2
         OT5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793700060; x=1794304860; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SufCO5vXmOofjrNc8DxAFwJiS5DhDr/MoaIEp3PctGY=;
        b=ai86AIuuIWWMf0o/xHVHb6dYUKp3lRELBH8dAo+1nGpUH+21cseGnCOzGF9bX3w6sY
         rXucBJyKZNW3wnDabCnT8hl7eByrNy3+Bj+Vr+DoiaZnvz8QqsNMs0GDyXMMDib/uWeg
         grsEkXEmTRSvzVICJn9LgC/5jgU+gCo0MNVRJKgg+ivMRoi57lEeMd+LcK5sA25J82cL
         2k5FezG/PN4/AsLrw1uESF5F7vljtiidKtm6jHKMAVklhrIB4iCb3ZsfOWWBQgYVvYuo
         ZWNcz4BfzkaYDTSQ+kojYxyW+JUq1d7Q5IlHGRjEekfm++MUPaYeZ7wYqqO7AznBoiGn
         0HYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793700060; x=1794304860;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SufCO5vXmOofjrNc8DxAFwJiS5DhDr/MoaIEp3PctGY=;
        b=U5RYZG82pFiEshqy6PmQzaAXuVpOggLZseImvzzHlfYSX3W187Ww6JDQTz7LO6GLU7
         IR5WvAjiOQyHks1KWCNBZWJQo3QfTaRvnZ5tLtVTTk2xPfQBhKkQ8JksVrtInRWp83Ih
         98z1lrM5Tu//1NOoeT69+s8qtd9tU3SQylGP29k60A2bg2o4YcIDwBpBL+K2Q5Vq9X2q
         QEHTk+8tvEzAlubVz4qLJMgR5y7/CPxOJmm3U2380vn26iI0wf9jzkg9FtTrRj6Tc1rm
         GNScCFMvJrPQmroEVqxHhefJeizLDQk9PKD7mO7M6hX98O250OQaKNUkG1BFLA5n44iQ
         mOXA==
X-Forwarded-Encrypted: i=1; AKwUvBw2pe7n/B0X1zdUS6X7IRS5X9Du9/ef0xtyY9JymMyY6qEvHb4rBzNegdOl4USk8ItRz7w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yk7DzKKbve82A3Xrha7cZeaBwlRFeys3axP2AQYiuZrYrWIpg
	OB3tf2TQpNAG6IxUy460GwOPWTi31pzJHFpQ0/ZqD5iIE5smMrdAdGEEKaK6n7k5/k5FWsAq8+R
	fviG1B19QMSS22Ke4+HiyDfqrmGil+CkcKQ==
X-Gm-Gg: AYBFou3csAPwSW3DtAR50bDUVXeqTDeWoVedeHpEPskyfiQOIb/RagKDo1BzAsJPvwU
	05Y5vGMB6sBWotonxSW+qhbv8NEqro23jdiPukSO6SuBu1lG5HykmDwVvo5nFHrGXKYi9N/3LhC
	Enjd2Z1HyivfdcFZYqsCryE9udE1EjIbNYA7JkrFXLKj8ZcZ0sDSjirnQ5NB0pgSefWemMrHiep
	JoZo4ZwbP03zXP/BHdrJHnmG10TQWAOkTWPSbDrsBg+Iv7YpKxE29jWhTIwrBdlgHTqcWiOgdYu
	Pu24k9adZzc31GZVJ2l8J5brnrE79m3J2C9D3CQBAPJWvZWxVt36T+H6g+cmPBVDrTkWykkrx1l
	/d4RFvquHJWsblsNPs5QKu8/1Pln2lsWq8MomMi5VvIb3B5Lfa/1p3B09bEfxI8X3hdIS9AF9tz
	6l1B3YtOcPHr3M2AqQi6rB+GPpbzA=
X-Received: by 2002:a05:6102:6cc:b0:7b5:7cd5:2a1b with SMTP id
 ada2fe7eead31-7d072634fbamr4225240137.10.1793700060373; Tue, 03 Nov 2026
 02:01:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 05:00:59 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 05:00:59 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.2470.v2.git.git.1793694813386.gitgitgadget@gmail.com>
References: <pull.2470.git.git.1793298807397.gitgitgadget@gmail.com> <pull.2470.v2.git.git.1793694813386.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 3 Nov 2026 05:00:59 -0500
X-Gm-Features: AclHuK8ooZI4aeDL9vS44LajJdQwWIv_3Q5RMlfasWP3WtLwRaXR1gWzo9Ei3Xo
Message-ID: <CAOLa=ZS3ULcNVjV1DMO-iB+LcC2Gnw+9oU2_7VXKoLvgiVRnbg@mail.gmail.com>
Subject: Re: [PATCH v2] check-ref-format: use parse-options API
To: Husain Sitamuwala via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000eec411065f5c56b5"

--000000000000eec411065f5c56b5
Content-Type: text/plain; charset="UTF-8"

"Husain Sitamuwala via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
>
> The command parses its options by hand, comparing each argument
> against string literals. Use the parse-options API instead so that
> option handling is consistent with other builtins and the help
> output is generated from the option table.
>
> Keep the existing behavior: --print stays a hidden, deprecated
> synonym for --normalize, only --allow-onelevel can be negated, and
> parsing stops at the first non-option argument so that options
> after <refname> are still rejected.
>
> Drop the early show_usage_if_asked() call, so that -h is handled by
> parse_options().
>
> Two minor differences come with parse_options(): unambiguous
> abbreviations of long options, such as --norm, are accepted, and
> "--" may now precede <refname>.
>

If you follow our 'Documentation/SubmittingPatches' guidelines, it
states:

  It is often beneficial to allow some time for reviewers to provide
  feedback before sending a new version, rather than sending an updated
  series immediately after receiving a review. This helps collect
  broader input, gives reviewers in different time zones a fair chance
  to comment, and avoids unnecessary churn from many rapid iterations.
  Waiting also encourages you to polish each version before sending it,
  so reviewers can focus on substantial issues rather than typos or
  other small mistakes.

Seems like Junio's review went unanswered. Which makes it hard for me to
consider dedicating time to do another review of the newer version. I
would suggest that you engage in the process before sending new
versions. I'll hold off reviewing till then :)

[snip]

--000000000000eec411065f5c56b5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1ff54c3c122df4a6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ycHNOa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNi8vREFDRFhrLzJ6UUZXVVhuUVIvRjRVWmRkanFNWQpPQkpBWDJlNC9R
dU5uaE41MXBjc2c5ZWdraC9GQ3ZGdXBCRWRucGU2OWd0bytMdnF0VnRwQThoREtOR3pQUm14Ck9u
aEMxU2lMMTRtZTJVYTVTNVkxaC9VSTRXdjFwWWVwaFMyMVoxb2UwaDJjejJhNi96VmFTM0lCSnpX
V1AxYjYKSnBTMmNBaEh1d3dkZEZlYnd3V3pyV3ZRbG5VU1lIajc2NXk4SmtITXBYSWVLSHFsdkcr
eUNiM3FINFBaamo1bgo2YSt3QWRjeGxGUHc5SXVtakxwVVpZOU4xQjBFWURCS2FsSE1URWxycHBa
Z3JXbnlIVjhremJ4ZktZbDNldFJTCkRrOFlUQU5HVjVTYi82MjFrU2FpK0dXSUR6eXdxaVJYdVl1
UHppZThYYkx1UG9CVlo3b09zK0IySjVjRjQ0eWMKamsrOVlOTmMwVGo5V1VYYVd5MUdMY3FCZU1N
UlNYRFQySzhMK0t5WnRCM2hTMzVnN2hPVWVLdVpZOTE1QllkegpRc1BOYXRSNjFwYjVDNkJYeXVP
dXdCdDI3T1VWVWxsaGtqWGYyb1lmMElpNlBkSDIyeTYzdHNUZnR6WVZkbDVvCmNmRWJPYlBGTDB6
Wnlja1dUY1BpS05YRmMyU0J5cEN1OWxEVXRIND0KPUFzNXUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000eec411065f5c56b5--
