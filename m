Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793889071;
	b=aGwlCydlpz46WXw5EbS1/QHGftNd6YqcCIwuD4Xe52DqMK70MZGBuULsNhi+i98a57Pa
	 LvVJqtaNse25mviM5TPi5ds+XWlf7hsx7AshcgXPvqzcJhRqE7VDr5VDdffkFHLHluryx
	 sHR7j9XDKzDpu2OpVLoZS2TLs6bc2IgurU+3O6WImxgEJW3Ox9PrrtbP9NVrbz2r7nnyX
	 3IPtJiz4ftA8aOcA4ntrhfYOESDHoD8H2Gd8yS3O8nCDLIH+ATA4i9VhEXopxoGPI4JLH
	 1rRFtNvupaTzOcZxqr+SwiV7L5nwW4Wej+vA4BT6ytc5iIwlcHMS+TPASOQXHrwRiOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=PzRZCT/tPG0Z34ndweAfJaDBJNpku85DbWLzMxOC2l0=;
	b=V39cyhyDimDmy47YYOlVAgZUyWcJ4PdEif4Tf+RcQQ4nU/SfKYUwyNuKHPrgdTUNfxXb
	 idMJpoj2PTIILkMsL5MkGNayvOl4TW0Ggsp6E6ngUEEKDhVhO/nMjgGAlPDKMtrhcWODw
	 rdCA5GWQKaMDsg6twIrBCrQdxoH3Dy4/DykldhHCYeePVqAivtPUc5PPIrt3/hLB3JANY
	 Ib6OsyVNBq+T8J3vB+Hl6eMep6OD4x9GJJr7gxwv0ykxg1euJbmHKGDHyEtgVfLjMsY68
	 tntXjwBFhDN574GDNJ77TQ44rDb3s7ah4xd41QqFbEanXNIttVhgeCLikdgdy2SGV+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIwSgJDo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0BD606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A0BD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIwSgJDo
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6de2f213b7aso891366eaf.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 06:31:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793889070; cv=none;
        d=google.com; s=arc-20260327;
        b=dVU2l+PEowdROFNaVLxgmRnPvam8HI876/vVqlGsgBiDbUXl+01lm/NzACjWBC34/o
         2S1BkdAI52S12/pNLkbgPHGkhlOXeMkE1adb5/RKvLBmVY8XKm8JwvK/rQUZKDUajDpM
         uPT48GxdV4FyVEglXZBG3/gJpCu1mcx9RQ/QVYKVBgR1lv8F3rwpUOqpA8UtTGgcOLxE
         r5/htvcril3qLfLmyYptqeEjPMQYRpte88MEHpCfxBzEVulrKLmfebtLePfxFL7aP96k
         Y0vOEdWU2TmPs6+9V00PK6I4kbXh2LmyjWExoiEROyxobfgHzIiRDuzawVcjMethbz2R
         YXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PzRZCT/tPG0Z34ndweAfJaDBJNpku85DbWLzMxOC2l0=;
        fh=t2tfTzhi4uNSt8SobEJkE/vnMGTPovY6UcZ/twvETWw=;
        b=Ij97fa2+NIiqy00xREKfnKlpnoNrTTTwUIY/YEOhgS3mnfHrzqwuM8VViLrWNhuMiP
         huzXAY3mC9Xuehvash748owW8ut8wSYNhkd8jABd68YBvVU+a65Ckcs9jj+gU/8zQCyG
         RKXNMSLfjAotNvkxijpnQC+T/7BZLkmUnKtMjCBVyNBqktRHazumOWUY8hcrwxQrdAti
         Li3rbGjqbhDtWAwwWHG4TGkVcFXReG5GRR+5Cppq3wRN8wxLSZwI1OdH1Q9hw/A8v3nA
         mK7SSP3tUZj/cyyupgTs3/EqilWzV6K5d3jT+5ui4roToyl4YNX/eRRBGDW1JokfV47C
         4g5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793889070; x=1794493870; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzRZCT/tPG0Z34ndweAfJaDBJNpku85DbWLzMxOC2l0=;
        b=OIwSgJDo0Uuh89dr12nnA9R5iSG+cHFpec0jGFdKxv3nYrJc94u1ecwnVpbpOqiVNL
         RF035ztMQLS8aVcOhELlZ6niT0WwhSJl9D2yLnb+ilmho6m0ULKbrrOF492XfKBaM3lE
         2ExqEG4dVU0gnfHURihRrYC1YOhxTTo+upLrtzE0trtV9ztEbOv1n0lYnEFCXmcU+ked
         n3QhYxr5hgW+tQ/EIr6CJN2wwUtcC8Hf4NIVl3k1kS/Zrl4OMc/0HAAeziGut+xn725c
         J6Rgba68AWZUGXanVdWj3KQM4wL3upzxoWbtJ5QCmyEjESz50DiHAKvzKrmQCHmMVVGB
         o62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889070; x=1794493870;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PzRZCT/tPG0Z34ndweAfJaDBJNpku85DbWLzMxOC2l0=;
        b=yiOnD/irOfvLSZx26t8zzg8Doh2HoBlX6lifapYv73hSv7930RU++/syeHtk07QyZc
         HMW5ZBOLFjGpIeI33H//WZtOO7XIHaLLDkfmXdD+AmhoO7wMadVj890TejYpQCweJ5+v
         Vfl6FKh95rqlqj1TAtfdpYaihr9gx8JwyOQoph8HDYQ+5whhKjYzh3mHklQSaTpW2CBH
         RR0Dw4m9lo42ngSZZufw1KqtjaW1CAB1t1hJkgK9uCRlEoqqJXvq3CCBnff3QzJU5Q9U
         yZMlBR0l8KyskNRODPHWGH7rxp5BRCC+MVdC1cBhSabnpryZCsR3Gnh7rj4Oe4IHKUgB
         kIow==
X-Gm-Message-State: APuU4Z+XTCGOU8PhYIC4BMUVt5fZEqDstmwl1XrK7mamYs1rI9EtjUJf
	dsqY8xdrZxvNJaS2uuFFSqxX4mZMbsoe5m7YklHsaGpBw8WzL8FVUPXR4RXISXo5EdOroT4hnxa
	E6UoTxYH+WQHSjTC713mErKu34SkSceAmOlzZeMI=
X-Gm-Gg: AYBFou0ah1zNpMzynZmls6U3+iqdqgj3aaps/QzxUgL0B8ic6B06yLnsprYej+HrfTg
	FUUxGnarnqInLSRzPSBoy9iaNtV6lzdf7HGfSezRmzs8TVew/pcwbvTblNgDnO6Vd8Z8RkmLhxh
	0dqevNzEubzG1SgPbydhmeWlgVIbkh78pJetYFiyjfjEFoEyftP8zTyUcqVu9gokiShhlt5ydRq
	ZvjRB8KbDDKZxxGodAeAAa3GFQM1Z3SuL0Kz2JcVxBAVlAKbJVIsjrmNwyCbAkiFHQpjDKKy+MM
	o//UxsbHplYvBAP2G5O3iHNcWqz9Xr+itR0l8yIHz2H/a6ScPI5uMPBVcJxjHV50sa+1kD/6o1P
	dYfmcG7DEM+QRh5dO7jflBDuX9dE+t8tDREX+e1glGuFy5XxRTqP+ujnBlpbFds5g9XOeoyyLR6
	ZgmTJ1nbJ7+vnHUiblKoEEvyvwd7zaJlMddG4fOFs0EjswfJtwWQkKNBaw
X-Received: by 2002:a05:6820:625:b0:709:529a:4775 with SMTP id
 006d021491bc7-714f6e7ffc6mr10309591eaf.50.1793889069867; Thu, 05 Nov 2026
 06:31:09 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104172434.691381-1-yopatatchou@gmail.com>
In-Reply-To: <20261104172434.691381-1-yopatatchou@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Thu, 5 Nov 2026 17:30:33 +0300
X-Gm-Features: AclHuK8oKz-Yt-TBoZuIJwy7HCmooGza8f-eC4x674ICdoiHEP5fMyPjDaUgPrc
Message-ID: <CAKrRMNpAW+f2XXMFqpB8ffZsTdyPsaFtHe8dku=JVXACp1M3Hw@mail.gmail.com>
Subject: Re: [Outreachy][PATCH] promisor-remote: honor promisor.fetchOrder
 when trying remotes
To: Yopa Nelly <yopatatchou@gmail.com>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Nelly,

Thanks for working on this, being able to choose the order of
promisor remotes sounds useful.

I tried your patch on top of master (0ffa3e35c7) in a partial clone,
and I think there is a problem when the new variable is set:

  $ git config promisor.fetchOrder origin
  $ git show HEAD:f
  BUG: string-list.c:340: string_list_split_in_place() called with
strdup_strings

On Wed, 4 Nov 2026 at 20:48, Yopa Nelly <yopatatchou@gmail.com> wrote:
> +               char *value_copy;
> +
> +               if (!value)
> +                       return config_error_nonbool(var);
> +               value_copy = xstrdup(value);
> +               string_list_split_in_place_f(&fetch_order, value_copy, ",", -1,

Without the variable it works fine. I think this is because
fetch_order is created with STRING_LIST_INIT_DUP, but
string_list_split_in_place_f() is used on it. Maybe
string_list_split_f() would work here instead?

Also, each time the variable is seen the names are added to the
same list. The list is never cleared, so values from several config
files pile up.

It also looks like the list is file-static, so every repository in the
process (for example submodules) shares it, while the rest of
the promisor config lives in each repository's struct
promisor_remote_config.

> No test, and I want to be upfront about why. The t5710 fixture

Thank you for being upfront about this. I noticed that
t0410-partial-clone.sh already has a test with two promisor remotes
("fetching from another promisor remote"), so maybe a test for the
order could go there. It would also catch the crash above.

I also could not find the new variable in
Documentation/config/promisor.adoc. I suggest adding it there
too.

> +    if (!strcmp(var, "promisor.fetchorder")) {

One small thing: this line is indented with spaces instead of a tab.

Best,
Tanga
