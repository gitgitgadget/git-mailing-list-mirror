Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792640688;
	b=k6sx6mbZtxKHeD3OMWVOGoUR+RHDwVAW3WbwxSzabSNF5HrT02qMA41M5re/7TyGWH8N
	 S8HcEg1WXtVh/32uxjsp0Yc2fZw9SChjKlKYfMfog8N7E9y1PAQqS9CZFNwPGtZk/sdSL
	 QIcmb5cmpHUd/sqvMjk7T1L6nmG5Br5apdXNrD6A6/Fra68DjV9AhlpbEGtOjZp/6P2Y/
	 wgqZo6+WNhZMlfoCkLtBwVzcArp1gEBo7juaikHuPmW1dD/v6IZDheQOEMNE2OXW2wfjU
	 hSpg2V9M8D5LsJDcIBaxPVi1HAC5gK9q6Bjz5nF4Ya5I4S8+tCArMI8PUZ4Nq+8a91g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=A/BkxpAIv7dG5Cl9FCnwHwr1g2WBjBXJM3NZlHJT9FA=;
	b=o6iVp3n86omFLNIjw9/s2Wg6Mqj4qqNZ9+qPK8lRxNnAJymxR8hnKBZqlxnYJFByz+NI
	 Bad33j15XUcBTZgJFRgQANGS5Vq56wiErnzLSQaHUjMLAKRS3HaJVQqZcpgp5mgBuHxpR
	 jSpqcdNYxGaeu28IGQvbRJpmyd2PsYbh37hTDpiXK5waVuyDK3+WDCTgqIHcGkvgIei5J
	 tzdzBZAhOOhIk8Ogm3FcLPkQnWVPg/f6ubP3lxsFoaUn3PvuwpJdVIWa9I6recLY+PXao
	 apfPMWOzuR9YG6AlifBa48W0wh7qlftOi53p+/bJZV7wYTydbQqmgYc71sE6Hu09PKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EUnVWwYC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB59606A339
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 03:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB59606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EUnVWwYC
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4550d8ab15so167561766b.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 20:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792640686; cv=none;
        d=google.com; s=arc-20260327;
        b=Mzcni5gXjN0QscFrGEaMCZDQCKQKbPtN88ah4ahLFGSpx51WaV7E0czmzSIgDNXA9w
         I51xwRLBU/XA3wr2JEq40aDLFs0StZXHPWBD3zHRiKu4COMbOZXpgC+RDKn0xk1r68BS
         6qs/3Silkwkadz11gZ4GZPQRHN7ZoZF2YyWzAvFOKIVD+axwsEX5bEehX6OrhXApSB5K
         lMFJ8oFYofcEfQEMmFPsNKiT+/983zG8XEKs7OG60z/2ALHWf2rPxtjfQ13erQPMS2ov
         3FE7hncTedkrf1KMhyLD+9UUMUp887GTJ53aJ7idCvq7pQk0Iv0rMxJbxEtvJd5iZf6a
         TX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A/BkxpAIv7dG5Cl9FCnwHwr1g2WBjBXJM3NZlHJT9FA=;
        fh=rNsMQzT29jDQ1rd2pi7MiTkNEI3EBC8bWHa9pkb0u1Q=;
        b=To5J1nAVPKx9Pm1SvMpzKFKIqGd02VMY2IEeVZ7R+omtqnYo8KUTfgnElANEejHLMN
         pe2c+hqLsfAPIc8k+dbTp97RGiMb6AtzzSG9lauhjH+xknYSGwjP8oy6QsAr+iT1HUNR
         OLQHp3hAHU5jXJh2IsvC3Ngs3mOnqbWt6Njc8/8gTsC2p/+3kRKdhzQ17QCsxXa7N2uW
         Kduqr+uhE0Hu45Z+y9R8KruKI3ri8picb27XXdkkCLW4UAfRkjSId2cmSQDyFhc//rZD
         KYJ71/uQcdzO6YiIgrJV6Vu+NTZ+MrgkhXN+mS7a08IOnYllcCg81GnkNOOKRMp7hQuw
         Wkdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792640686; x=1793245486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A/BkxpAIv7dG5Cl9FCnwHwr1g2WBjBXJM3NZlHJT9FA=;
        b=EUnVWwYCqDNql9icy2K06oP30nV/FN4Jbw+5PmjqLlobBm0skZklwfppNfcYbdOO4a
         o0ZU/olpmI5bIbRKSopILIFMhFVgjFkMMk8EqmCAvubGZN/ya2YjsnWK2O+M07crrRs6
         Wv0NCqnt30JZiDF9P6vCLl5WgWVca2ZyzNkWAo1ilKkDlFH/OvlaBTnPgJJ90ac58IA3
         8XIGY3sPXN+vvRAnt1G+M7vHgzQaNrU/F0ZL9ZshDMy2bqk62quHEpZlQzKoVKgKJRq0
         EO0hkqcpfb3m+jmsL7Pj7lpAsqv4XQGmmtEha+Afzy8MshnbpQixt/JZHItgHVjiMqez
         sBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792640686; x=1793245486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/BkxpAIv7dG5Cl9FCnwHwr1g2WBjBXJM3NZlHJT9FA=;
        b=fSpCyw4miLUnKOOZLFHipogGXgTrdKuspc/a8uRfQ4T0Dxl43NAzgNNFicSAKDk+fq
         Vruca2kNXftTlJh7jfrTEU+9tvdDCLiE9Dvr+uNNhFQ4wPov/L1Bu9PW9skRyqjfai5h
         dcLzeR6FaAVoi5CZcVq67ufGRrhUEMaHZPkyhH+tWNrin7BqW4FrtaWlUjleJ+DrsGLh
         qyoDjysoxI7cqGUwr68vjWRZZoDIhhKWEMIkXdWk5iifsaY8gWqa7HYI4DIv4On0T8Nw
         C/zF0a6SUo2uFYaIICc1o5MZ8CYebIukh/Ia+HbuSnnl9X2KNSAcedHZlMPhoXYvfqXq
         KUzw==
X-Forwarded-Encrypted: i=1; AKwUvBwXv86Sql9lq691ZV7zJwqCI6E7ja1pOPR39DDbGMyyRI0vLoq4IdP/SL9WvwLHS75/1Qo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpmGIjwcox7iWDYvcOhywEusYfRRjXwrqkwgM5UlWpacee8WlX
	Q1O3UIFDCqSIjCywc7iqmHoiG44vEWPE3RgZ/+dCIFgewPfGDqxg455TmKunqnqLYmKfa7gSKdW
	VkuU9x3Be+kreuyJK5oBE7os9ZVjRpQM=
X-Gm-Gg: AYBFou0EKC1KI/bVjWW+qNRdP4RyfdN8iNnVHlWiHKZdqhiIcwENhjIY+dtDA4gdiJK
	BKbeO5WPljrcij7Z2ArnHc2868QST1VN6oP674d3wx7qH886Lkk9lccqT+7bVxff1QQjZBYcoib
	jjJvPT2eM1ewLPYc2dFMVmmn20beJ+hdTtu8VmrgpQYLx3eN6rXqB78Lz2vWoHq0ArsDD0d+0xL
	OF99KH3PNd5n3yMMKpU/aZe0NybtNq/IiDx/JuTEPigLdBNfPtPpPfcIhx953BHTsBQH54qeDAN
	STEOBUcPrmd34EJkcnOZjI7VsRcA4GCm0x6MhdnyolJa4F50TN6VBfBdeP1HAuPqZk+9QgHEYgw
	bg52WWO7dOQxVwNLE6P0wGpgEGW6yw4XR6lIblGu43gcol9k6J4YaKQ5dhj2h5YoWijNoPb+XoN
	A6xBfcRA89nxI=
X-Received: by 2002:a17:907:969f:b0:c42:24ea:3220 with SMTP id
 a640c23a62f3a-c467970e3b6mr355863566b.31.1792640685994; Wed, 21 Oct 2026
 20:44:45 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAO=0-S64w=n47n6yfYoKJie2aFi+T88Sp_qPmFe2RW0xWEwcdQ@mail.gmail.com>
 <20261021110616.Wxkhc%taahol@utu.fi> <CAKrRMNrrsa2iwb-0D=FfzNAwyLTJtLbVEN69vu7sBRWOKheZ_A@mail.gmail.com>
In-Reply-To: <CAKrRMNrrsa2iwb-0D=FfzNAwyLTJtLbVEN69vu7sBRWOKheZ_A@mail.gmail.com>
From: Muritala Mudi <ibnmuhyideen95@gmail.com>
Date: Thu, 22 Oct 2026 04:44:33 +0100
X-Gm-Features: AclHuK9Yv2p9NxfRVlnIDhm4HHS9I_7CCXt1DiGCGNAPCREY59RPS0c9L3QaxIg
Message-ID: <CAO=0-S7fQgHUYreK48rMkkpHaZXc9OXVmZTm36Ux+wo01Hw=oQ@mail.gmail.com>
Subject: Re: [Outreachy] Microproject: use Q_() in builtin/checkout.c
To: Tanga Joris <tangajoris@gmail.com>
Cc: Tuomas Ahola <taahol@utu.fi>, git@vger.kernel.org, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 9:33=E2=80=AFPM Tanga Joris <tangajoris@gmail.com> =
wrote:
> Mudi, as Tuomas suggested,
> line 1405 and the similar messages in builtin/worktree.c are yours,
> and reviews of my patch are welcome:)

Thank you Tuomas for pointing me to Tanga's patch, and thank you
Tanga. I will convert the "matched multiple (%d) remote tracking
branches" message at line 1405 in builtin/checkout.c, and the two
copies in builtin/worktree.c.

I have also seen v2. I will reply to it and send my patch soon.

Thanks,
Mudi
