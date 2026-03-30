Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6241D3876A9
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864120; cv=pass; b=pV1rpv7EjDFhkYDiWkI2RA2JCM6KyaEXjhVwwM/Td+xDxi6t539oqayoUwWLEDYaWaqoGnt12Cwe9YHCJaWTrZfZktJ1QFgLRkKOSSLGIAbEfINcCfitA3fiGSWAaelYOaF7uhP1V+7SyChm8kQUbmvgQ/cO3SWAEIWhZXW1TwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864120; c=relaxed/simple;
	bh=KtBXMdr73yx7UtcFdvZs/fuNuMQxKluSfor8Q3VxRZc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=iTiPIYxNZHUhLbMsUjVjeuvN4MQBoov7xsFxJI4WMsnCPPZFtBAHpmOWWa+ZhlL6wP1BF64oMNWdeFD9w6hgQGqGj9DAU7+1qy7ozyGJJ9spnL8h9aS1A1GcAr9AbaNFTa0Shr7Qh1jsTvZ+U4RmLDoSjHsdNCa4Yy2cwKmSztU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCyn5Y+6; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCyn5Y+6"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56d3fa1ea69so1191848e0c.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 02:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774864116; cv=none;
        d=google.com; s=arc-20240605;
        b=KvY//daQRxVAnENms7EnFFAhLdwNQUaRgi+txfl4Iuyrfs1wptiEixa1qIfUX5gL8x
         zIjl0LGIL9/Yt7mxoBT1kwAdRbbNIdOEkq8FXueG00CYi8KX35LyvAlHdESSNohtcA1M
         y9Tzlhww5uu5xU0c97X/tc7V1LoJwexc8TtKEw0RP9ZsaZcGO6CCDRT9KRqs0OJRrPUM
         v53t282pvRhelBiVcxmmA74tTIkT01aD/axT7DOLbnFFy7qvTdX2sh0FQ9lLx9FrOMQi
         b4roQWUwmO7ZDwtgd6iETelrt/ZTuepeueydLIyDa9xcAeu906b6Nf0n8wWMug55XeLq
         i9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=xLrU3jlATl/GHUl3WHuJKjm+flV5OFijHDb7b+Rmcv0=;
        fh=BL0svzUC3zz+2wGD+rVhaDwlm7QbBTc34fDO+7FrVuc=;
        b=lAwCz6A553O7PigvGsji8kHG1BvQR7venRl6efwIJeM2rzA6UNDcLLJDlLnycYVyVZ
         1gJQY59kiBg8PjoCrUNfO8YrB9TMRBXNXbnrPxMH+4nJHCX+AEw8r9ZiHVP/Bf05nTFr
         vT8Y8mHZkjE0YlzkHh4/51aQxyTxCwEsb8lNY9ClGTJuVf+6b0Lfcw5JTnRCX/rK/V82
         7lPKEw46pyqwCUbLU6mIpMkfnLvMkZIdRadLfDfQRr6DO0lxaAODFaT9jOW7KQomHA8L
         ZOL2fS9vaUwJIG2qxvBhqZCUuACmWDriFCTV/evHDbEC9gaAEKYAMomgvZT0cTuW7FB4
         xqBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774864116; x=1775468916; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLrU3jlATl/GHUl3WHuJKjm+flV5OFijHDb7b+Rmcv0=;
        b=QCyn5Y+6R2WzqrUXIdgG6kSivkGy+58HYWoxxi5i98l98sPSJzVFFjvGghwLwjrvLq
         PAxQ0ror7mzsKcuUn/iVrw7JzT8fIHagLtV/WOJFgz79dRn3i0UDrcSeHklwJHSTiIRt
         cT8qRTYrDkO37HaNY0ftt7C8t2SvFh4Geaco5jraYiY74ZSkPgIZAs5gnS9IG+v/dWw2
         xZCui9UDA/GpJzDoFGqUJcM5Fkzz2UfgikhZA8roxMcd+Fy1Z7grSChPwVHrNb9nHTXu
         yK3zPM74A6jb8OeIO6dtHr85kw/SabQbNoM1e19XnUVp3/gG5WMoFKXmAKGcYMZFki/C
         c2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774864116; x=1775468916;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLrU3jlATl/GHUl3WHuJKjm+flV5OFijHDb7b+Rmcv0=;
        b=qBkpj/Y82zE968KKEcecCDxNEf/Zfmu+0rt3MuK3Q0K5JJom00YAo6B6/rMaVuHvjh
         glJ+3cn22XSTdVKb+uikqrn3tFhxpPmINoNex1AlsflDRTKJyN1wrfwPYYWAxsA5TLmO
         wJwnsKrhp8JioS2idRsv3nGkk31/xuz1T7zi18TBeuZPtfsEav4ynTqDS3zCx1WNvz0H
         YBTTE3Gv1kDcrashbeipLGJCURMSNTbDk319QTot0Wv+mLwonAY3oMpo/B84/DdZ3yPY
         fIKVZF2HxkxdwmNWtJs3tSnlm3QuirTWhJXVe72Tuv73CizZvY/UfI4apkBe5YU5RPrR
         dFWg==
X-Forwarded-Encrypted: i=1; AJvYcCW2o0oQvoRgA0C7QUE+lCY5T2GC/xLmv7t3EwybQG/SyK5dty+lRgnY0VPQsA7UjkZj/sI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ridG3Hu/B8YqXfsU26IPjuJ8Gz9wbiWL9tOh9ZaWAqoa0qDd
	ie46DRYYmOd8e2GUhZIIA13VkVwkVXMqebFKv47/BeSq+MQPzLsromQCtlB42qTg+BCSL5p//DQ
	jZPCorOoyaj6LhS262Z8N8RUynVDi0AIhqw==
X-Gm-Gg: ATEYQzw48ytDCybMAMUpm577aNxatJANcHS4OX7RhyaVoLHcvr43dyiorNcoH06E90I
	cJyE6J33V2ff/VDdpnPGfB98ayHuzAteAju4bBTZOOL82pwRm5aJKv5yS38H3YlpnDKMUUhAoji
	TqKVINAOeriaZcPhPqXM/m5Hh3P7I9NuG9mSHRdiSpjFcJsXqMugNnWWXcayjwWEZEFE5cxJvNZ
	1ntqwVogJm88xdi0ly6XAo2QEwP7D3rA4YV/rVO4HGfRPTQJrekYGR8wPDYEqRpTbuHbd9Wcjbn
	SWjoRW2tWkkykwy8vpzhaDixsU5EOy7eB15CJ1yKsQ==
X-Received: by 2002:a05:6122:e203:b0:56c:dd62:eb45 with SMTP id
 71dfb90a1353d-56d4a6706a9mr4555992e0c.15.1774864116097; Mon, 30 Mar 2026
 02:48:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Mar 2026 02:48:34 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Mar 2026 02:48:34 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260329183603.538241-1-vikingtc4@gmail.com>
References: <20260329183603.538241-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Mar 2026 02:48:34 -0700
X-Gm-Features: AQROBzCB52Hx3y0KRleo2aE2YUcGVW2gQV35Gm8_S74DxefHXQYTujj_LdRTO4A
Message-ID: <CAOLa=ZSRAQtZKNWUw4YhX4bx6MwFccN5oR0tSKQFtex0sKZGmQ@mail.gmail.com>
Subject: Re: [GSoC PATCH] backfill: error out when HEAD cannot be parsed
To: Trieu Huynh <vikingtc4@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002a398e064e3ac142"

--0000000000002a398e064e3ac142
Content-Type: text/plain; charset="UTF-8"

Trieu Huynh <vikingtc4@gmail.com> writes:

> handle_revision_arg() returns non-zero on failure, but do_backfill()
> ignored the return value. On an empty repo with no commits, HEAD is

Nit: s/ignored/ignores

We use present tense in the commit message. See the 'present-tense'
section in 'Documentation/SubmittingPatches' for more info.

> unborn and handle_revision_arg() fails, but backfill silently
> continues with an empty revision walk and exits zero, looks like
> success but did nothing.


Perhaps: we want to say 'and silently exists with a zero return code.'
to be more explicit.


> Check the return value and propagate the error, consistent with
> how builtin/pack-objects.c handles handle_revision_arg() failures.
>

Nice.

> Add a test to verify that backfill on an empty repository fails
> with a clear error message.
>
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  builtin/backfill.c  | 3 ++-
>  t/t5620-backfill.sh | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index 27a301f9b2..4b2db94173 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -96,7 +96,8 @@ static int do_backfill(struct backfill_context *ctx)
>  	}
>
>  	repo_init_revisions(ctx->repo, &revs, "");
> -	handle_revision_arg("HEAD", &revs, 0, 0);
> +	if (handle_revision_arg("HEAD", &revs, 0, 0))
> +		return error(_("unable to parse HEAD revision"));
>

Makes sense.

>  	info.blobs = 1;
>  	info.tags = info.commits = info.trees = 0;
> diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
> index ff67e8ecea..91b5115732 100755
> --- a/t/t5620-backfill.sh
> +++ b/t/t5620-backfill.sh
> @@ -101,6 +101,12 @@ test_expect_success 'backfill no flag on non-TTY is silent' '
>  	test_grep ! "Downloading batches" err
>  '
>
> +test_expect_success 'backfill on empty repo fails gracefully' '
> +	git init empty-repo &&
> +	test_must_fail git -C empty-repo backfill 2>err &&
> +	grep "unable to parse HEAD" err
> +'
> +

Looks good. Thanks

>  test_expect_success 'backfill --sparse without sparse-checkout fails' '
>  	git init not-sparse &&
>  	test_must_fail git -C not-sparse backfill --sparse 2>err &&
> --
> 2.43.0

--0000000000002a398e064e3ac142
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 35fd924d093c1f43_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uS1J2RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meTFPQy85WmxZYmczUjFHVkFHbmVWNHZHNlA5MlgvdgpCVklubEE2V2lL
a1FLUXRpY2d3THc4MUt6dGd4NFBBWHY0a0ZwK0s3TnZ0QjRmeFA4T3M4VkFuZXExdm9neVF4CnBP
WmNLVERiay9LWnhOZDVqbXBET2R3aGxiVENxZW9KRmJ5Mm50WjRROHdRMnByd1dJWTg3WG9OckE0
Q3BMbisKQ0lwOEgrV2FjS1Y2MGc5U1ArTWZCZWNxUEFIWDg5cCtrdzFINDZMVSs1YzFnWWs4YmRo
d3BGNEoybEl1QTZESgpXMTUrYkJTM1pPS0hTT2E0cGJVOG9PRTBhQzh2dkIrNU8zLzhCZUg2UTBM
K0FzaFl5K1ZNTm1JeUpnalJRcW9tClhiSVdRSjg4TFZpWU1QRlJ0cWdYd0Y4QlBTcHBSMEwwd1J3
elh0U25VczZQMEQ1ME4zSmNKMlgwZGExMk5qek8KWHVTTTB4dE03VlRIaUc4NVYrRjk0R0dDcDZv
SzI3aW9DdnBkY2NWa1BwaHBNZ2ZjQTU4OCtDbW9aanJtais5TgpyYWJNRCtISnk5WUFBeFdBTkpC
dW1YNHdnYkpBblpGeHplblpCdjRHd2dFTTg0ZEE4Wis1TzJuK0JLVmhGS0Z4CllpMTlxeXRkMXk3
MndPaCtMSjRQNTE4bXJPYzk3YXhFT0hVQ3pRQT0KPTRSYUwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002a398e064e3ac142--
