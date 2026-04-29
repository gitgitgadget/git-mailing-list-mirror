Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FED339844
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777505793; cv=none; b=Nx/SghVyRt7PFKhLff+Iu8EIpr1pql//dYjRerh9DDOeJHEqtwwxkm65oBkoaLjh7iUFUvEnvJN4QOx4ah8iClpH/JCq4ZdVL71uxm15VdAbBb7qey3AVHKeDnRjLNAlx9EfK/BQDDSK+6IZLEP7IDoKH61012lohcLL8WiDEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777505793; c=relaxed/simple;
	bh=6ThR1YN48Iwx812fDOBP2pPOggRQk6jMSuibhH4uT9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTDcFM7hqIoWHGyboMZqHv2L1tROZZ94nOitYrtk08Rd2du7XWn3HmgdoKNo5wmD0VVAKBDh3FnrZ4TmwEMQPYcWArSarSZPTQZU2FJdWCXzaGQEGYuWndqX+hfyoEePc9QnXprApUNPMkah5kasnenwyt0OoCFxH8HZwBYUNQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=j/4Kp+IB; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="j/4Kp+IB"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79885f4a8ffso3460217b3.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 16:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777505790; x=1778110590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hN5URE8c8LpDGowB+veG6jarp20eGeiUq7GnIus+IpU=;
        b=j/4Kp+IBzFZCaVeJXlkCOtEsbYtcv/PfDbELnY7RfqSIFdz1A5/rJuCBH3Gptv3uBR
         BxBJy1vB30wSZ38EODzmLwzbd809pf6EECc/irl3satvpb7+HmF1xw54ppHqq6WHKlQj
         t4DB6ddHRccXz0hlNP4gYjLkORellEKweEEoCAVZ0clMmmNoHfsS0+UGasurw4FHOCas
         /8bfpdnwHwmeSLoC2yKdxjLotv4V2+tLKuCfJASST1tGZlEC/1uxUitG3JzZHT9/bgFP
         JnAHcEOeeJvRtjchigPXiDAPEl4uWzC+FL7Mbb1w0x1lzya7ylWSAgPPnfyQ5Udlr847
         DpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777505790; x=1778110590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hN5URE8c8LpDGowB+veG6jarp20eGeiUq7GnIus+IpU=;
        b=B1Fo3yEQyVCa6ms6AWVKGqjSHipZ/G3GaY6TaNZlG2sxIO9zxWUsYukwFDBxnc5ta5
         QTxcck3kZ4A7iZNb88ihIvjdSjrm8IeEBnkyARFDypGKSyc0lXR7OzV3KigSudhBs/Lj
         2upXBerhdZ+mDtT5G5ai0s3mESqjoo62E23eBUPkubKgwgrQWr52BbjOBJL6yzTdC+U0
         BM2TO9s427SZQq9AKduNRbl30c+bS2kYwv2i/jKS6op8EkDrZXXBOZDPVaBhiwk13xjO
         KjtBTRM0oqLyme73LuVlnngQCbm744dDxHI5Jk/1a20frx3v+ENvz+mQFjmYzZa4A+qP
         NX2A==
X-Gm-Message-State: AOJu0YzaXqkN+Y7u5R7DITZXZupVJduQQMEXI52HDXiTCHkIKGdGLt10
	hK5b3A5Z3chDm8jiBfazzWpozkczKa+nC0as65+qFMbZylhGL60FECimBsGidQG7U1Q=
X-Gm-Gg: AeBDiet65jLtWqCye3O7KyzFhF2s1cNs3/JRR4kOUzJRfvJYaSmr6DTLjsAhaVMtCos
	xII9MR6YdCkuhXRlNJm+Do0DXey0SPy3lxnVkXmtcj5GaJjEGvINRalHvr38YRXLgiExwksM8Is
	eNtXe0TnFaUqWryu8o+fIuwPiuOjaAC/Xp0gOdjHNv3Pu+CAdIUEhpw7vjXiC5xy73tqjlC+jD4
	SEblgZMs2eWCC3cXhotwhL7Q3I1qJ2zXxAuOKFAbaz284zF5oou2l/n0okTltM/xfmNTEf6vSjr
	laAMf2PgIBDb5oSkuelKFD3m40QJMyKyhc4NZ4zTfj797lX5DCeRIWUIVVcDbUtIZEPvrAg+5vK
	0xw0uo2whw8Rz9CnlUh/+5swPSE8xq9EB6xmUaZo1YQL8Zj1UksB3Mj80nkJobztbw4GO57NX4D
	jIbL0F5+OHxw6tWDeoChxXk8q0J/xH4DWvw/GovNOjB/Bkhor23/Ga1B/XnwOEXIMtKCfdgMFk0
	Z39kMkUFG4L4I40G+hVc/I0i5NOCREV+A2wqav0g6Bz2JdthQcgc8AHggN+K1+XT2PlVBZqTQFu
	yA9ZZpB3WSNn0pHiETejgsK2hIE=
X-Received: by 2002:a05:690c:102:b0:7b4:ad41:4831 with SMTP id 00721157ae682-7bd547d5afamr5013927b3.16.1777505790571;
        Wed, 29 Apr 2026 16:36:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd55155a1csm1077567b3.49.2026.04.29.16.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 16:36:30 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:36:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 14/16] repack: implement incremental MIDX repacking
Message-ID: <afKV/SthrwsHDuWI@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
 <93e152fb6aa3bbd450d46c6cdd219dfef14d41fc.1776803827.git.me@ttaylorr.com>
 <20260429075150.GA1267476@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429075150.GA1267476@coredump.intra.peff.net>

On Wed, Apr 29, 2026 at 03:51:50AM -0400, Jeff King wrote:
> > @@ -312,6 +319,17 @@ static int repack_fill_midx_stdin_packs(struct child_process *cmd,
> >  		fprintf(in, "%s\n", item->string);
> >  	fclose(in);
> >
> > +	if (out) {
> > +		struct strbuf buf = STRBUF_INIT;
> > +		FILE *outf = xfdopen(cmd->out, "r");
> > +
> > +		while (strbuf_getline(&buf, outf) != EOF)
> > +			string_list_append(out, buf.buf);
> > +		strbuf_release(&buf);
> > +
> > +		fclose(outf);
> > +	}
>
> Is it possible to deadlock here where we block writing to the child, but
> the child is blocked trying to write back to us. It's probably quite
> unlikely as it implies both pipe buffers are filled up (and we are
> counting packs and midx hashes here, neither of which we'd expect to be
> too numerous).
>
> Using pipe_command() would solve this, but it also might be impossible
> to trigger if the child reads all input before generating any output. I
> _think_ that's the case looking at cmd_multi_pack_index_write(). So
> we're OK, but you might want to double check.

I think in theory this could deadlock, though in practice it is highly
unlikely. Regardless, using pipe_command() here is straightforward, and
guarantees that we'll avoid a nasty deadlock, so let's do that.

The resulting code is a lot easier to read, too, which is nice:

--- 8< ---
diff --git a/repack-midx.c b/repack-midx.c
index 8f3720772b8..9db59b18334 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -300,37 +300,27 @@ static int repack_fill_midx_stdin_packs(struct child_process *cmd,
 					struct string_list *include,
 					struct string_list *out)
 {
+	struct strbuf in_buf = STRBUF_INIT;
+	struct strbuf out_buf = STRBUF_INIT;
 	struct string_list_item *item;
-	FILE *in;
 	int ret;

-	cmd->in = -1;
-	if (out)
-		cmd->out = -1;
-
 	strvec_push(&cmd->args, "--stdin-packs");

-	ret = start_command(cmd);
-	if (ret)
-		return ret;
-
-	in = xfdopen(cmd->in, "w");
 	for_each_string_list_item(item, include)
-		fprintf(in, "%s\n", item->string);
-	fclose(in);
+		strbuf_addf(&in_buf, "%s\n", item->string);

-	if (out) {
-		struct strbuf buf = STRBUF_INIT;
-		FILE *outf = xfdopen(cmd->out, "r");
+	ret = pipe_command(cmd, in_buf.buf, in_buf.len,
+			   out ? &out_buf : NULL, 0, NULL, 0);

-		while (strbuf_getline(&buf, outf) != EOF)
-			string_list_append(out, buf.buf);
-		strbuf_release(&buf);
+	if (out)
+		string_list_split_f(out, out_buf.buf, "\n", -1,
+				    STRING_LIST_SPLIT_NONEMPTY);

-		fclose(outf);
-	}
+	strbuf_release(&in_buf);
+	strbuf_release(&out_buf);

-	return finish_command(cmd);
+	return ret;
 }

 static int write_midx_included_packs(struct repack_write_midx_opts *opts)
--- >8 ---

> > +static int midx_compaction_step_exec_compact(struct midx_compaction_step *step,
> > +					     struct repack_write_midx_opts *opts)
> > +{
> > [...]
> > +	ret = start_command(&cmd);
> > +	if (ret)
> > +		goto out;
>
> OK, if we get an error here we'll jump to "out", but run-command.c will
> have cleaned up everything about "cmd" that we need.
>
> But later...
>
> > +	out = xfdopen(cmd.out, "r");
> > +	while (strbuf_getline_lf(&buf, out) != EOF) {
> > +		if (step->csum) {
> > +			ret = error(_("unexpected MIDX output: '%s'"), buf.buf);
> > +			goto out;
> > +		}
>
> ...here we jump to "out" but the command is left running. I guess it
> will eventually get SIGPIPE when we fclose(out), but of course we won't
> wait() for it and we're probably leaking some memory, too.

Good catch, I fixed this up in the way you suggested to call
`fclose(out)` and `finish_command()` within this loop before jumping
out.

Thanks,
Taylor
