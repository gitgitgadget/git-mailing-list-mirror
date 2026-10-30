Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361316;
	b=aVoXLICDe4E43srROi8lzg47idva+MiK7P3boMoFFaypJMm7ZGIvbp4/ddsAYBeI6SLZ
	 KMrXZHEIIxvrbmXKbuYEhLWg/mcy6VcC8oUENNRyFB8ImsFQ2D+Md0ZOkz2inWaLGnl/K
	 JqlYglpk+WBQxa6GmjEswo3PKh1CIPyryknyNe/h8qYV5CIdl6yeP1EdWNKFk1a71ZSZh
	 1vKkacaQNI1lTgiYyPxJUj97gPcdkUjTXhmDVx4Y1V9CBXnBpNciybwQIQR0sB5LwjOUW
	 /cCbpBuLW0C2bOQTA80LkFEGwqJn0WtjaFI0sVr+ZtQxNP5+s5TnTzvrIl9OW+vmonQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=mZAMIW6YMjzfVfeVniDx9tSFIwqqu4A/nBjGCK8aPcE=;
	b=Mv+j/PFS5OcIdVy9xXcqA7wSnb7/9YCwsbJgs8vxNTTJmfMokEldW5II3tIGRBSG1hCZ
	 i9agRvIZEJJkRjXwmsgw04rTgN91YvvSDoMcqUMy5lFlrEoG4lPiVTrKR2XpGwPj/qIOW
	 xp5koftYrlr5P+X9JcxSVHb80utdML71b4/oVqp5ulXBuppFJK8iCm08U/Ba35K9Hm3rI
	 QI44YOGvlwz+m6+JroX7BViSVFHaF4CZRcXBNMpGQdkg9XZ3SnvP0yfyc2j1du/E1N16I
	 MDjmtDnN5tbruAZRDBvZfVZ57f1YKzk1XOeRU8VOZ9fNqzVzJzyrQshczWx6iRkjBHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ondi//EG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49D606A31F
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 11:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC49D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ondi//EG
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eafb65e169so467854e0c.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 04:55:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793361315; cv=none;
        d=google.com; s=arc-20260327;
        b=hq29F1bq7MTSgTizzmxUnL3CWdCYW4dCM61CYl3Qa5Y33k2nglKV9oDFIEVkdUN91i
         Rlr0okgKs0wnjbvzyzVXzoA6BUKwIJfOdHIfcHoQUrYBYkOeam43vzrSpyTYztW6vUpZ
         7BrG4vNA3nFhyUWCJLJP/hOAzwRNNZNe99tECK+LpZsW900pYwwy2hOH62oWWMSXc8hl
         x2FNtuecOECJnvr7SUipNiwFQeHYmuqpdVMxZkxVg1CcmT+qqVsMLCtYgbJqLppCnhjS
         gi3hAnDUy3/QuTO8GMb4LoDM2PeM7de1sHpMN1reAVtTXOGogxAS8LTuvxB+DV/2dph2
         OfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mZAMIW6YMjzfVfeVniDx9tSFIwqqu4A/nBjGCK8aPcE=;
        fh=zsCM3X89Rpw5fJyF8JP4Lf6Dpmo5KEVveAtcUTxUHFc=;
        b=Vn7N4JYCqSu3MDHirzNXc/ahEIg3d2BTLVK5p4LC5gj9gcIePOZlIvtvTpVKALzilO
         7K74hdD49qcEwIRFMS5J6PBmRq3wxaPkZ6/cknBDaCKtMjwoULukN5f8vLg0TVWB5pjH
         moHHH2+TinXoAUdcgkmg0w0beim1YVQzzRPGDRBAkDtUw62V7lukKBBpieqzbysssR6V
         Ib/AhVaJd1wl41I2HSdLon2oWXdxrUaAWrzCVvWtR08gBl/me7EFYFvns4wt0zz9/BYH
         AfoMMvAzDQ6hcpXwJhEdvzJ3LPbyJBM2VnuKWkVe7a7iJJe+5UDFf2NkXcfsBYGstdVm
         5DJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361315; x=1793966115; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mZAMIW6YMjzfVfeVniDx9tSFIwqqu4A/nBjGCK8aPcE=;
        b=ondi//EG9hntiVlUm082A97zNN19ikiioXFmGQq9i1Yr1fU/GBxZH9EgqV/68oNHk+
         WNDpzs7Uog2Rp3533iPPRIEgnkWJ3bfzUfmqkrl/vbbH4As9QTdcY/6veKv21h9LrL9V
         X5+PDmMzXEMYtzKpeb68c3DeYbBYjQzu2IWq92lfW6hkAXWb2XW6uUgQ7yqM5PZfW1sM
         8Z1It1S9BA4zgRUMvArs1cHo9r066FOFrJm1U1pvbaXG7dGLyWqU67WzkaQjpNIMBxNO
         5VG2A/PCrCGD6x9w6YwXNtkVN8MzzIqafiznPTgO/YCwAgDLEvlrbuhNbNQ+XEwycREL
         3CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361315; x=1793966115;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mZAMIW6YMjzfVfeVniDx9tSFIwqqu4A/nBjGCK8aPcE=;
        b=Wv3pHC/3vxf+lnT8fFSdyoXvwlV0tZ2MIGLYbHQK3sEAybR1OfccBpAjNa2PYyXbbL
         dLxQU84Fm46hwYFeZKbwk8KOZYEWPcZyng7ejaychWf+FFMDOUrSK28zS/znf1kXunFQ
         sSZ7vGg4a5NvIkr7EQY1OGxu/zaaxbwrddxLZiwd73wMOzxyalS2rSMuG4tR10mg4R0H
         TEHnT1PmoksFgO+EHPOv7SAKgfTIEtBsnx3vOFSUd+3URCjylvzDWh/zOm6+LdDBsvue
         ys5haQrTNo3jyLPGUFxT04xYnetfUSUPKt46eL2bAbeFHgEmdqQbb/vekoyH3s5MPngm
         u+yw==
X-Forwarded-Encrypted: i=1; AKwUvBzk291sPGB5qEDL+QMEidtxTrMF1oApcaP3yT4z2uhqexn4L6cxcopQTtkZknPhrClXJiQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfUQk0VutcoDzMH65srmVMPH5gbqqRlDQFfmzaLBoPQ11t/SlG
	p+qvYlWY0n5uzRqYPs/1S77oGlKGicQ7UVuNo9+FK0R6L/S+jPwStiCMqVHkrVeCYnmIWe2Z834
	PTyoOurh9FrOxSOoEi7KPIW0cAL84DrM=
X-Gm-Gg: AYBFou0+ePwQSUTGdaWAGn1fVJof6Wcaq+g6kMBRF4F0tCIVbZGWZEJC+WmEOwZSXn3
	HNLtCKzMqC94nrLy7rB9irgoBzknh4Ycia7Ar4P/4uBPzqGCf2arcLCyclgGtX3qaJYuVKKdjlN
	G0IlM371+7TcsvK2uOV5RYblcvT0wu5VDPkS2vtDaruam2CfVZuTdBVPShhtAwWAcnavgnOmdcg
	vnVjZrrGgcfNxMyHClxrzEekNX4LFeDOgi+l1YHWlB2nu/YDF+R/VZa0KprtxHgBb1vUcb/YEAe
	KmuveD4dhm6ZJ4bC+dkIE+Bok1l4yos877/nGO+F/28WcdzGKQxFMUnbX/Nree3Nd7OSeQg1uer
	Dntd5t0zHEwxRoZRaXGfFkBDpI6GXcH/yGeH8OwM6QeVTcInhE2RVOdl3BH5J0C5sZ0tuucrVhO
	vtks57L8UzFIDpdJ6k/csUhfqZW4g=
X-Received: by 2002:a05:6122:4d86:b0:5ea:aedd:6087 with SMTP id
 71dfb90a1353d-5ec6871d3d2mr1102264e0c.4.1793361314657; Fri, 30 Oct 2026
 04:55:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 20:55:10 +0900
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 20:55:10 +0900
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261029232220.1245827-5-jltobler@gmail.com>
References: <20261029002413.3291184-1-jltobler@gmail.com> <20261029232220.1245827-1-jltobler@gmail.com>
 <20261029232220.1245827-5-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 20:55:10 +0900
X-Gm-Features: AclHuK_eUFfDJBsCNaZ1YCWuuvTgqAbBLEjUbb-5FMlU5Nl6ZKNnzR2AGrVh7CE
Message-ID: <CAOLa=ZR2AmC4EDM7V2A9UainUZ5md=dQT_pnJycxuqV7BhfxxA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] tmp-objdir: merge loose object index when
 migrating tmpdir
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000001d697c065f0d7822"

--0000000000001d697c065f0d7822
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> diff --git a/loose.c b/loose.c
> index f2e111c25e..0ce9c7486e 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -311,3 +311,50 @@ void loose_object_map_clear(struct loose_object_map **map)
>  	free(m);
>  	*map = NULL;
>  }
> +
> +int loose_object_idx_merge(struct repository *repo, const char *src,
> +			   const char *dst)
>

Nit: should we name this `loose_object_map_merge()` to stay consistent
with the other `loose_object_map...()` functions?

> +{
> +	struct lock_file lock = LOCK_INIT;
> +	struct loose_object_map *map;
> +	int ret;
> +	int fd;
> +
> +	loose_object_map_init(&map);
> +
> +	if (loose_object_map_read(repo, src, map, NULL) < 0) {
> +		ret = error(_("unable to read loose object index %s"), src);
> +		goto out;
> +	}
> +
> +	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, dst, 0,
> +						    LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS);
> +	if (fd < 0) {
> +		ret = error_errno(_("unable to lock %s"), dst);
> +		goto out;
> +	}
> +
> +	if (loose_object_map_read(repo, dst, map, NULL) < 0) {
> +		ret = error(_("unable to read loose object index %s"), dst);
> +		goto out;
> +	}
> +
> +	if (loose_object_map_write(repo, map, fd) < 0) {
> +		ret = error_errno(_("unable to write %s"),
> +				  get_lock_file_path(&lock));
> +		goto out;
> +	}
> +
> +	if (commit_lock_file(&lock) < 0) {
> +		ret = error_errno(_("unable to write %s"), dst);

Nit: Shouldn't this be unable to commit/rename? This will differentiate
from the above write error

> +		goto out;
> +	}
> +
> +	ret = 0;
> +
> +out:
> +	loose_object_map_clear(&map);
> +	rollback_lock_file(&lock);
> +
> +	return ret;
> +}

The rest looks to be in order.

--0000000000001d697c065f0d7822
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fcabd22c6980276a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ya2haa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmFyQy80MHp2S2RkUWdaY09TeVhpVnpibk5tV1l5ZAphK3MwOGIydjJ5
c0JIb0ZJdjRFaW90UFZESnFvM0s3RVIySEtyR3BWSjhrVVlHeSswUUN2dkdXclgrMXlrL3ZYClV6
dTVJM1M3Wjc3V1Vud2dMZlQ2aFNjc01ZZFVRSHFvU1pndzczbVBhRXFFTG1CYVp4L3ZUNzBXQWwr
YWtrUzcKMXBiSHFaTkZqd3U0NEdqak9xaVJhTkw5K0lza0p6SFJMMHIvRWs1aUQ0NU1EU29kVWw2
dDNiSXNEYzdxVWdIZApzQkdJYy96eWNKM1Z1bmhZbk5YMEZORUkzVFpUM05BZ3VsaXZrSnNLSnVQ
TmkyS3NrK3Z3ck91eDVkTHFxQ0lICjNyRXNmZk9TN2s0aWhUL3ZSaFZBMGdSZlJGUUdWeGxvU1BD
ZGxpN3ViNVF5eHZJd0dNcmthRHhPYUxncEVuOG4KdjNJcHIxVnpWYmVteS8vRlVkZzVZMHErNXBm
Q1NEcGpic0VLYTY2d09jYVRNU3AxQURqQW5mUGdsNnc5VHhUeAo1VHByRzBoVHc0bTB0VjAyUGJW
NitYeXo3YjhSWVNXU292VWVrYWE4cTNDNXIySm9hcWFxMGQ2a0l4aTgzOHV3CnRYREM2ZGM5LzFi
MkFZOVNMNW9wUHpEdVA1TzZmSkEzYW9UaHBDZz0KPUdQazQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001d697c065f0d7822--
