Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795041670;
	b=TsbBtlGmOs+1j2ZG8bX6AP8Krl8sQ6tNYaYSphNnsbOcNg88SylLDt5y67eAestWdO3L
	 w7h/HU2Ng2x09lyCKSNQbZUQNFKbRPU2ukFTgFJBUAC0LTc4fV0J+Hb12j30ed9wY+wsZ
	 UzJEAQOxKdVTnaoWwRTgNlfYoGEWUKvDB5Rg0ZrQCsoVCyxNNbPsFSzELMkLt0iG7g4Yk
	 Iabu/x40wo6cJBciA98Ltcb7wlJbHBvMhFMUIKvYY2SvNfX6KIiaY5V/X5gigU2LuINf4
	 j89KlApReV4DVelUDvuwWjhhCjxwJ/qLjzCKc7qdQd1LENp5k+YFFB9J8+FJZNcnyAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=juE+dWTzyuorBRYz1K26ywRMUSCXYviIVStKjkbrLP0=;
	b=ZwE85Arzse1//kRs5UcyOKNkWt1mbtTqhP4mU6b/yEEgMcnOfslQs5n36KBRr2xQf2Nl
	 g13amCqlsWfcQhuNyz+uMuRPD2D8vBMPdadNoi8zL0bvWDae2Do7rup/Z2cGMKhEyDpG0
	 CgPKgCUuZ2rPL+Mydyydd6gZT006xBXXNUdYjRWU46IeG3sbMrS4dOOFTzdgjHEVott3X
	 3WdAIRNOsYjhbdR8tKx1jtYCsmzK+t5IehInsdbjt5h8R5agl2KcjJ7X3ViE5LtUit7y9
	 1Psyc55+uvXsdia4C4hnhgxf5zoNgJk1HJefD0bPVs3O6h0NBfHJy36Zgowr5S2qbeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hj4GOOn1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3717606A320
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3717606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hj4GOOn1
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-71ad2c6491fso214293eaf.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 14:41:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795041668; cv=none;
        d=google.com; s=arc-20260327;
        b=ojydSZsaUsi/2SE5trTNLzukV42dPHXSPLW/VyZTV8TFxfo92Nm8cqS61EK5kufdsC
         hq+BV0tW/o0/A9QU3JRFze+hsei9ZiQlAicPyqOlYaF47sy/qH1WgqOk+tM+Iy71wDER
         UtKLvFmX8IQ1Wslza3quHRgRciusrmPjpsLhFh2GVphM5kLLvRyHGLrBqb0jp2n+6k/2
         w8BDlEZKKGktYQOmqWvLywuQyWt2nBIF07+kPZSPxMZjYGyU120VbIIZTEA5SOtpWuKF
         xrf0JS236QoDkcmWf0BCZOZHr/halJOB8dq2g0e8QPx/ysa0tAwfw3iT+ZX/VijoxwEV
         HLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=juE+dWTzyuorBRYz1K26ywRMUSCXYviIVStKjkbrLP0=;
        fh=mlouSdSHE7/G5OKhQH+jWDS5dcudZ6PxjEjDttTuunM=;
        b=EQRqy6Y3KgrIoLOOd8bP5OmCfZSdldcJ89vOoqI6mvS50N0wI25kNj73Ma1+0oT+Z8
         Beb62EC+lqYXDgYtG2hcc4HuBAPJ+5GOErlvzC5kTIornnO6LhowR7IUu8qjteDkJAE7
         rRxtZ0+R1nlmWRu1iRiz+rXQwGr2z9FR41z7t3k19HIlya4Kt4oIzWiwY4v/d4ATBOTy
         wmbvPGEsH05aB9gLqUIRAXCeBvUex/1rg5sqddkS8QwPCmXuUM/OmsIfs5kNKegxI9Jc
         m9imwaC+uOtFcdcPY77upwbiKC157BysQfYu+2q7vmOfwhietBg0aRtukuB6H/+G6YaW
         4XEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795041668; x=1795646468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=juE+dWTzyuorBRYz1K26ywRMUSCXYviIVStKjkbrLP0=;
        b=hj4GOOn1o26H55nThmGT9KiyIk2hxs9q0WDKUZwnxRbTRudHDYqzlhHACFSP2/14yG
         ZpFaEGJWCOSrfLM1FSBQhVHzuRRIcqcoMN6HoTf3JVM3jEjOW8Fnk6BYAp19+KXugiE4
         AqgqUm9KNqOLkzIiguYXLvtkorab6bgUX1RpfzdV0WyQrCNalFbvHgQIzP9p0Ugwlvaz
         RHF0uphPAWrp0eQbSraNEFUhWKBzfT4ENiISaaZaQPl7kijJ7a6mLtmuoYVIqRftdzCK
         vMIpq2O5yALSBzTesVn/c+UocgxdGUJPwBpsa/Hg3ZO40trw5p7PezXwEA26m08Yx8AY
         EGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041668; x=1795646468;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=juE+dWTzyuorBRYz1K26ywRMUSCXYviIVStKjkbrLP0=;
        b=D3qk/rAFRy6Dhviigh5rXm+9LgksMwd2Rk6OgmEY5yM/nTBM5EN1oV7IjvJYiXty3y
         aa+9Tm8je7HR4WBhpnqoI2WSwpkCUBeQ1P3AWchc2aE3TN8rQciSDO7ChinQmkXaFnUi
         fhMYZvbg2cBhtF7jZWtZgOx4MK9WOHKk/JYigNw7rvDc+aExypKsZJ7NTgE2vvxUTpQC
         BUpB/RKwTz27TWqO34E3ed8W2EGv5Tz3QrJxiaUKa4qLsbWQ+VHj5AGVUVqjI8pDY9/s
         hsS16NJwFhz3MPuj4Ys6tJmkWlNiG3Z9Rpq5CKgQNyLae/7moP5PCROLOoBMVFAWhSPk
         iftA==
X-Gm-Message-State: APuU4Z8e1xIp1zKFXpF6/86r6NHtRJa2+mj7mhUa6Bcg3hBSF93dPhOR
	8351niN52V2VHKC1OqPnY4nc3TaiCeSLNzWx+F6qX65Wqcc0WxkKJEJg7+gn+WJqkhw+nyEXPNQ
	XT798YTxTsYJz+cJvhcSycGdRXSOVoCHnRCx6
X-Gm-Gg: AYBFou2o6fLo3GNqZJDWXhkwAtvO01X5EqkTzt9OPHgYWpVd9Wd1BPyIPioqe2douC4
	PMib3M03A31vlyXw8UGE8ubZgIYy+IS85hdFWbaMlY6J10K0AT4ilzUgnZ9hr/Oi8KyFLICP4qs
	52Rp+XfRT0NWK8c3hDOknBlC767swlkN9RLwGX5CckOhn/Iwsnleh8ylxZ9WjoeJqTmJ8j2Rhkh
	7A0XhzfU5YmocmEcjI2SqbearTlCv3CAHurhpTMQFLhE+8V5Jpsb6byA2MEicPxRY1tHmvfOpLD
	Lqz72YlmHucZVTYUVf4uQz8SXWnq5Ewre9zW5Bz8RW0v2vwccoTzAk+yAyRdb2WHBp84FtNInkY
	P2smdR7nV0gA7hD1PazIwklOFCZ/Mvg1gWzEPyzIednYS3cbK6TTqrWI5
X-Received: by 2002:a05:6820:4511:b0:71a:f98b:3be7 with SMTP id
 006d021491bc7-71b2e2bab1emr110773eaf.26.1795041668512; Wed, 18 Nov 2026
 14:41:08 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net> <20261118-master-v2-2-3f2aaec15d31@gouders.net>
In-Reply-To: <20261118-master-v2-2-3f2aaec15d31@gouders.net>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Wed, 18 Nov 2026 22:40:56 +0000
X-Gm-Features: Aa3M54qfZ73HISvpruWxJ9tOMz6MP03oVyDQFzQeGdKWKjgOpQN9Bfv5OW6yUto
Message-ID: <CAHWeT-Zzvjx5knLdCdxUmn8zmkAk2qrzzvXkbSjhCibWy7hAeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] utf8: fix comment for utf8_strnwidth()
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dirk Gouders wrote:
>
> The comment for utf8_strnwidth() states it returns strlen() for cases
> when the given string doesn't look like valid utf8, but it returns its
> argument len in such cases.
>
> Fix the comment accordingly.
=E2=80=A6
>  /*
>   * Returns the total number of columns required by a null-terminated
> - * string, assuming that the string is utf8.  Returns strlen() instead
> + * string, assuming that the string is utf8.  Returns len instead
>   * if the string does not look like a valid utf8 string.
>   */
>  int utf8_strnwidth(const char *string, size_t len, int skip_ansi)

"null-terminated" is wrong too.
