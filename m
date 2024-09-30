Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6B51A262D
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731633; cv=none; b=V7tJYemVqagiRr63jB5uKVaXDfjcX7gZBtCIR+L8f0PCvDnyutUBcTBl2dlrjprh3eesiyPnmfxaGBoDaIUxbRiqC8U7OtUI/5xqp2PYXQb6zN3A+bRC3bE+DGyeAGnrsatTJdEIUihxS+bhy/hg2EKrkCi1Pg7M3AhvWDif/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731633; c=relaxed/simple;
	bh=fnqwfmdcktdKi7zqpYX7ohyLKWkDGpLiMyLxzOudx+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qozcxRrjyvglT8xCIfODzncQCkDFcTKKjtWeBBi6cKX+bs0nbYFlZ0x2SwrAodntnWQvH2vfaSTqTOHpDFesuJlt+7+sMuvHK0YM2vnQKfdG1WxjHN4lm8fKTuj6PLPtEvbSPGiChzd0ExZEJeQk2F2ss1UHaC1XOw3J96Uuqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=I3yaMvsF; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="I3yaMvsF"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e25cb262769so4286132276.0
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727731630; x=1728336430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFRXgBgGijOXiA6VfH1+/73p8sUzaGqY+y8duppdHPs=;
        b=I3yaMvsFC1Dkn0e6RnnmVXF4+qOTTtQEzeRXWimWEMDk2dM3fw30rWqr5as5kLGHzR
         UIsXp+SLe7Sd0IO+qSnwCxdGOnNXhsYfRoN2e21IATEXwStXGllSxGBacclPjYnN+B4W
         Ew1JKJzE/6thJgMIFJ3trz5gBVKxrNlhBL0umuHx0WeCYcYkHxzahWySDZeq6rN3mm4Q
         9eS6t5WWYx0sHeTFqBcffkiuFVRIK4p1SzgoON726ijPHvJd3fwlqK3EgCIYkMT76RLb
         nBD7ZwaO4K9/0YmLB1gBYTzja2/UH+0wmBrLoHG/LD3zGOD8b3OreQplbZPWTCSVw1oD
         LjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727731630; x=1728336430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFRXgBgGijOXiA6VfH1+/73p8sUzaGqY+y8duppdHPs=;
        b=qIO95YqEBfS2DPUbp4URSeeV2vOPVRBkDpvwWyaYnBB8UnJ1RWt7sSAWLhemSYnOkx
         BbXeIRTiIzdUqN/JQVwGrwx3ekMmDs3z3+YcwMm/ZbgXLAV46GFXrVeOZ5Wm65ntFos1
         av1g7J83hVjViS3B1QLz2EpPU4Bq+L0+ah19Q9pWRdCetOF1FLpSuW6Kn3maEpSkBG9M
         UcvUeBNOyWpH15Ra1mTDUNZejRQ7+7BSAOxCj4iahsSR5KXPiKrd/E2PjiAeBhfG7YRv
         +W16ej3XmotFawmXlgV63zrAjCsow8GDlcOvsJ8TcfYD3sVwnCiWT3ESiiZRI3BUj28T
         8pAw==
X-Gm-Message-State: AOJu0YxqPFzqemgC0t4JtsA7YNel1yU5LDnY0n5ZPh5JTKAVzlmOl3K0
	5pqKHeTaWpHE5ZTqYpeYN36WkSRbx/mi3wMCEu3+Z1IX5OTVErqOFx4glg/6Z0LnSNR/nO/sQIT
	V1tk=
X-Google-Smtp-Source: AGHT+IHr7EmrqDGCQrHt5QeE3l0vntINf9JE30ijaJ4fRcPvlvULWrucligsLyrhyTha9NFpxYp5mA==
X-Received: by 2002:a05:690c:6612:b0:6b3:a6ff:768e with SMTP id 00721157ae682-6e2473a90c5mr118113647b3.0.1727731630448;
        Mon, 30 Sep 2024 14:27:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2452f787bsm16065387b3.8.2024.09.30.14.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:27:10 -0700 (PDT)
Date: Mon, 30 Sep 2024 17:27:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 17/23] midx-write: fix leaking buffer
Message-ID: <ZvsXrQadrU78rEha@nand.local>
References: <cover.1727687410.git.ps@pks.im>
 <5db4e17db9b9b991e0dbe56d7043b56e5d161097.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5db4e17db9b9b991e0dbe56d7043b56e5d161097.1727687410.git.ps@pks.im>

On Mon, Sep 30, 2024 at 11:14:01AM +0200, Patrick Steinhardt wrote:
> The buffer used to compute the final MIDX name is never released. Plug
> this memory leak.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  midx-write.c                            | 2 ++
>  t/t5334-incremental-multi-pack-index.sh | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/midx-write.c b/midx-write.c
> index 1ef62c4f4b..625c7d3137 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1445,6 +1445,8 @@ static int write_midx_internal(const char *object_dir,
>  			return -1;

Would you also want to strbuf_release() the final_midx_name buffer here
as well?

I guess the point is moot since there are a number of other finalization
steps that we likewise skip here by returning -1 directly instead of
jumping to the cleanup sub-routine.

In the above sense I'm OK with it as-is, but it would be nice to verify
that this portion of the code is leak-free even when we return early
(e.g., because we couldn't rename() the tempfile into place).

Of course, because final_midx_name is local to the body of this
conditional, I think you'd need to do something like:

    if (ctx.incremntal) {
        struct strbuf final_midx_name = STRBUF_INIT;

        /* ... */

        get_split_midx_filename_ext(&final_midx_name, object_dir,
                                    midx_hash, MIDX_EXT_MIDX);

        if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
            result = error_errno(_("unable to rename new multi-pack-index layer"));
            strbuf_release(&final_midx_name); /* <- here */
            goto cleanup;
        }

        strbuf_release(&final_midx_name); /* ... <- and here */

        keep_hashes[ctx.num_multi_pack_indexes_before] =
          xstrdup(hash_to_hex(midx_hash));
    }

Thanks,
Taylor
