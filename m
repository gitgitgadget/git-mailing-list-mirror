Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833246;
	b=LGLGXlc0YL38J9trc8yRt0Nyonvul3nWnLeytuYym+ptLYxIlZabgf8VdKcfuYepXqJM
	 jDhVa0gCNQcv7ODn9KDZzNZ1LJA75W0hHGzRKYiEBsK72ucEQ3v9GD9hw9Qx4GyvtMewR
	 RHM1qWOcmHDAWqMfdpNUm2bM7vl57GthTcg+5EZ4q8xTEVgIfbHHfBMcoCGQCB3VEZCcR
	 F4oLIKWySjN6QGFugkMBNSHDjC5Yd96MutuaTVaYXSGEiQqDyRJVdiWm88DS3UZGr5+Ba
	 kh3AIxybhM0xyihVa5ORycTPhUL+YpUmvtfqqAMu9wIlv4QpzpiJHNroAlE6QwivQkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833246;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=NXC4VZdN+k1h20dHQ1KDnSzpbEgv2nlT/lsfL6tE8wI=;
	b=4vT40JrmYESkjvM91D6Syc5/KGC8LhH5i2xBzMnIQbtG59fw14wyikaKlAo9HJEAC+nR
	 GL5JEb2WlJv59ADoW7ys9uBlM+KfATzkE3K/TT4XruMfLc16qIQh+jgVsZjDR9hSq6eyK
	 IzuxZQ4du9nnIpXCdVDVUea8SS5FFqtJR8X9IR54WVCfv6w3uPUOzgT4IPt3G0ZgMW24o
	 iY7uAhWRuSw4dM2bGLBExhdecILr5Xi6WJ957mvCYbzchC3Qop5lfJ1ZGxEVGfttbPwyR
	 ZK+pPk8yKguzdL1U/hFJLcFIGU+zghNKg5rt88/z0pyEnRsCZr6ij97Ro+4QecTRc1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fwP4T7Fx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vQOqMHHA;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB0E606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 23:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EB0E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fwP4T7Fx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vQOqMHHA
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id CB2A4EC05A4
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:00:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 04 Nov 2026 18:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793833244; x=1793919644; bh=NXC4VZdN+k
	1h20dHQ1KDnSzpbEgv2nlT/lsfL6tE8wI=; b=fwP4T7FxKBXNjWADro3ZwONCab
	H3WmSt3SCn3+htXkSMHYQJTlKU+XV8EPtWwBB0ffOKb+Oi2X/ZvPCZo70eL7W+Ra
	QNU+8cCaTXgRFlPIgxwAo9HJ+lEsFaPRhDhcWC7T97BmErDHCD+7m1eQv7WthBu5
	PiaxmkfhLN5gJf2GtyFWahfy89gVBUtJ9wKXRGPQj5E2K5v9PbW93YE7aOmmgBwU
	W+T7LUCN0rPZavEVZZRQnmW16kiGxfuMXLQNA0eabUWS4fupMb6alimfr2c9HVmc
	Fjdn5cDltPhKK3BpvPorHnQ+BULYKReziStJ/iTRTiP8rQJ8K59II7qq4xsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793833244; x=1793919644; bh=NXC4VZdN+k1h20dHQ1KDnSzpbEgv2nlT/ls
	fL6tE8wI=; b=vQOqMHHAH9c5NoP3MQtaYVNjxbDl3Ge+LxtPAcfFjSsI5T7Ioc5
	IVwP2DnCf4T/2Zc7YfC+1hmkB6JBVGuzn0A/LYSQqF2ho/F5hDSbfWUyzZuKhVW/
	Jc7IIXGLYK5H6RH29Uhk+9E5l0cY2zau0390zmQyS2DN2lOAHxHBg0y1f+oE4Fs+
	oF0lGHLQpLFTFJ0ZjFwq9DG3ZEqanS47KltAG9IudO1G3vKVX2NmGPelFszClM5G
	l7TAM7AS0790fkMpemnQbTxSFdwHMUCd9FbfMaHhWlwwZLYuXRKfzqWCo17eVWFS
	1RGIjzC/UllSM3FB00ZGEHE365mIcKAEemQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793833244; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:d+tA97jDhfgg9gqQ09QyP7YZEzlzZPvYD52lH5wTeqKdwGU
	AZBb9AOFMDUo2HZZtdKviNAFVsFiTqSkRzKGcQaen0OumZuIrOzo+L/3RmsuhkgF
	Zfyhad0FADkwY/SzLzrULkilObdPLUS4la40qZpzlgLqjaSuptlbnfsp53JS/kl8
	33VOLsJuEBUU1etHYFUf77hBE8iKYrlhori6DoYUJWD0uv2FSqcc6zf3wKGoEK6g
	Zb52C/Rfvz1Hz4PHFRN5gJ1IX3Pj8iKEr2X81aC+/W87+clI6IAQTaDzVx52z3mk
	egpl7508zFK6PmdHM/11dAc0x/dS1nsMFq/GAAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4c4zVLQGPIJVZATSk7huk4Nn8gYCFifbvpuMjdoMy58=:jKgvmj7N0zPRGN2at2K/CFYU+EPqRpg+jQSLZ97UWeY=;
X-ME-Sender: <xms:HLnrassRDPlEDnnXGo-FPKTi00D1FXk6CXJTAcQZfsoZrDmkjVifgQ>
    <xme:HLnrag7tFQUrTbmZ5rnTkOzr1oDkRwaWA9l8Q7te_h7EOvU0FtqN6ewKVzeuwq8HV
    GSeBXd4aBYX1O7Tqt6UkCAddrw6GgUyCPI09oeRHjRs5PJmczM8Zg>
X-ME-Received: <xmr:HLnralKLtr5bDqP3Xqh_gxEMoptM25KvuBUMat1RNC1-5vyMDKQ0ez9HFpfl2KKRmWqxFR42PEWBf64rBtp4ylTzXHL6rYHELyEW>
X-ME-Proxy-Cause: dmFkZTEXUC2mVA2YN/DAye4oWSNzvnZssgTgmViSWlrJYErZmzoCn9lJc+HcuvGQTGO1sQ
    FATrp8WYrCzxTHGhhzBFZyO0uKIf8w79w64EwAMJ3j7hHR7w8+soDix7GpDi1BzhBrDqsZ
    EkZHlAlJJ4dCECUSSPD1UNh3wFN0YKscC1z2eTZwBX9TRpYXA6yq0Dq8j9XlF3XSfYBYrs
    /K7scUEUdCEqMt0tzqZx/GRaE5Mk9DLJfuk6UGgSDRqiUfuUS+L922nG33BhJ8tM7x0qZS
    yOjg5PUmYTXdnWHl6zb1q50jGS7vjYe023n41C7boc1EiRePBsIUNsmb49cyAGZPDkwAjT
    7huL+shf+FvKdQTEWAWpRuPnXIHwGCg4BR8BYUiKyIr49bwccejSa8Jfz/pWBx/PqLWN0X
    yHOFTeyNVd14C9CfiQp5hiMyJhCT6KwiS36G7UgWJ/lcYpCwJh19HaK9OiIJJETggU9WxX
    nnm6T9xkDtTbfxy0eqkM0OqwySEl1f3NjjF5H69jSFwjNihAGqAAcmSe9DB5RMjlmmtxjS
    YjiUWQ1Th12AKZXhUbHt9OiADBS51v3jdIg4mv/q29I80EHMUOIG+QZoFDubNWVF+L1Y2R
    NYAxshOs2qDmfIXld6ZAkOHjdRvqKolDYlOp+Ywp5d9p5h5urd0dPX6hKLXA
X-ME-Proxy: <xmx:HLnrao6BR6kW_XUzDQ93qcU_1aN0mFMs9N5VPdF8v3nZqCHOJwv9gA>
    <xmx:HLnragw5IU_hDXZ3cixhO29xidxbFL-6UPuFmXwsMWHFNphVoQzpuw>
    <xmx:HLnrakaTB5SpQdRBiRRokFoSDPCzX3UABQ3qBqj5e2ej502S5HdujA>
    <xmx:HLnraqSi5bv6IuLBXzV4V9mvnvq14zq1HMQw9j8A0ERU0HdiJRFI_Q>
    <xmx:HLnras40O2M_N3Af941QdRRN94-nd9ZN6z9Bi7RQS62-Q37RGz1EpPfk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 18:00:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] object-file: warn on failed unlink
In-Reply-To: <20261103212410.1389988-2-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 3 Nov 2026 15:24:09 -0600")
References: <20261103212410.1389988-1-jltobler@gmail.com>
	<20261103212410.1389988-2-jltobler@gmail.com>
Date: Wed, 04 Nov 2026 15:00:43 -0800
Message-ID: <xmqqfqxgyzfo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> When the "files" ODB transaction cleans up a temporary packfile or
> ".keep" lockfile on an error path, any failure to unlink the file is
> silently ignored. A ".keep" file left behind this way prevents its
> packfile from ever being removed by housekeeping.
>
> Use `unlink_or_warn()` instead so that such failures are reported.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  object-file.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 132aaab6f8..a9800143bd 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -823,7 +823,7 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
>  	if (state->nr_written == 0) {
>  		close(state->f->fd);
>  		free_hashfile(state->f);
> -		unlink(state->pack_tmp_name);
> +		unlink_or_warn(state->pack_tmp_name);
>  		goto clear_exit;
>  	} else if (state->nr_written == 1) {
>  		finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK,
> @@ -1276,13 +1276,13 @@ static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
>  	if (write_in_full(fd, contents.buf, contents.len) < 0) {
>  		ret = error_errno(_("unable to write '%s'"), lock_path.buf);
>  		close(fd);
> -		unlink(lock_path.buf);
> +		unlink_or_warn(lock_path.buf);
>  		goto out;
>  	}
>  
>  	if (close(fd) < 0) {
>  		ret = error_errno(_("unable to close '%s'"), lock_path.buf);
> -		unlink(lock_path.buf);
> +		unlink_or_warn(lock_path.buf);
>  		goto out;
>  	}

Trivially correct.
