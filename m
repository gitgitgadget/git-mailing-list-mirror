Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="voC4L9tC"
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C25C4
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 12:15:25 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so3546623fac.2
        for <git@vger.kernel.org>; Mon, 11 Dec 2023 12:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702325725; x=1702930525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywJGsRYTbe3wws4tVZrmHbT0GeWjkUr8Ahj55n/p3Gk=;
        b=voC4L9tCswBfXoLQoa7ROjH81uLMfZVe1W3LNLXaNPreYhQGYM4/Ygi8JYfBbF5Qfi
         ti6/V1OTt262Qe+VP/EPcljD/eHbGHqqv7FujwlVlVpC/4tkVxfGMJASdQ6kQvHun3g8
         SzL4bQRmp/d4t+wQLCqBdaCmgHu5ByxMl+Nr6ptT07t8XwvlA2N+QsPe1iQpNjbKQng/
         PvtlH4uJd5w3Vp4HpTazRJiuF3za2mHX/LsXaPUSZkOeae/mjEMsULOQrFKrjQI6TwtB
         SxNTHIhGiKjHZnpJ9a5Fy83BLGSwIFInT1iSHjZujiVSu5z8q0Qvfb4mnjPTr9anfdwf
         s8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702325725; x=1702930525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywJGsRYTbe3wws4tVZrmHbT0GeWjkUr8Ahj55n/p3Gk=;
        b=Xo6O5XUZOGSGfRuN4YV7s1THhcRMcThqYs7nmHlv1oPWk7re+G65n/a4pwTSd9t3Dw
         H1kzPke5lIIculOECALXk5Q43GUgpB4IzQsonm2DXDPgyLyFMqFqVtdrSaarJpIpuznb
         uP/gLVJhoUjoJJ1sALh17RGwFvB2A+Xx0Az/SjSRE0Q5yESbO+PZOB8PJ/7LZMFnx7cq
         CufBnn0Be5L1bx3f+8ypmlTmIL644btVSI9dW48QIiTFiTehvp/pcpUuzEtr0A/QhAX0
         mnuR4VWtFIrxwLwJbj6vaj3kUC1ptBuN2xzojG5eF8vgWR6oOcUQx5kSS3iyF79rq6w4
         lgLQ==
X-Gm-Message-State: AOJu0Yzistrv2ax+yliXywD416e44kvhyh8wPYGC63ql3L83VjwB4+GW
	j5aF4yGURADmG9dGBOgt1GaCjA==
X-Google-Smtp-Source: AGHT+IFnZGa7c5H7ofGVBTphSFOCC2yHhwJ26xloUON02DvQ6IdoxRSkgt6Z7LBzBXSmLJQkgjHxzA==
X-Received: by 2002:a05:6871:7a02:b0:1fa:ede6:4691 with SMTP id pc2-20020a0568717a0200b001faede64691mr6157175oac.27.1702325724937;
        Mon, 11 Dec 2023 12:15:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a15-20020a05620a066f00b0077d78afc513sm3166139qkh.110.2023.12.11.12.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 12:15:24 -0800 (PST)
Date: Mon, 11 Dec 2023 15:15:19 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 04/11] reftable/stack: verify that
 `reftable_stack_add()` uses auto-compaction
Message-ID: <ZXdt17pN68tsmH1H@nand.local>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
 <5e27d0a5566d90969734e92984cfafe6048924f4.1702285387.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e27d0a5566d90969734e92984cfafe6048924f4.1702285387.git.ps@pks.im>

On Mon, Dec 11, 2023 at 10:07:42AM +0100, Patrick Steinhardt wrote:
> While we have several tests that check whether we correctly perform
> auto-compaction when manually calling `reftable_stack_auto_compact()`,
> we don't have any tests that verify whether `reftable_stack_add()` does
> call it automatically. Add one.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack_test.c | 49 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index 0644c8ad2e..52b4dc3b14 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -850,6 +850,54 @@ static void test_reftable_stack_auto_compaction(void)
>  	clear_dir(dir);
>  }
>
> +static void test_reftable_stack_add_performs_auto_compaction(void)
> +{
> +	struct reftable_write_options cfg = { 0 };
> +	struct reftable_stack *st = NULL;
> +	struct strbuf refname = STRBUF_INIT;
> +	char *dir = get_tmp_dir(__LINE__);
> +	int err, i, n = 20;
> +
> +	err = reftable_new_stack(&st, dir, cfg);
> +	EXPECT_ERR(err);
> +
> +	for (i = 0; i <= n; i++) {
> +		struct reftable_ref_record ref = {
> +			.update_index = reftable_stack_next_update_index(st),
> +			.value_type = REFTABLE_REF_SYMREF,
> +			.value.symref = "master",
> +		};
> +
> +		/*
> +		 * Disable auto-compaction for all but the last runs. Like this
> +		 * we can ensure that we indeed honor this setting and have
> +		 * better control over when exactly auto compaction runs.
> +		 */
> +		st->disable_auto_compact = i != n;
> +
> +		strbuf_reset(&refname);
> +		strbuf_addf(&refname, "branch-%04d", i);
> +		ref.refname = refname.buf;

Does the reftable backend take ownership of the "refname" field? If so,
then I think we'd want to use strbuf_detach() here to avoid a
double-free() when you call strbuf_release() below.

Thanks,
Taylor
