Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2215284881
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282289; cv=none; b=jDM21JlMUJxi6zY4jEn/W8rDDRWNQrxq82sR7I/bWIN7NpmvvaXt23yHr3a0xisMu9vgkEgj79nzojZqRyI47cNa73pSRFUyHKhJwBdYxzfXzxp5WixLxzJos0hTo9CNChfR1gL5IMzv0OZ+h0rRcBDRbjmSSOTbwxf3OpUeoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282289; c=relaxed/simple;
	bh=288h0mtLyep2xMLJHiSw8EVoiWMiEZPqZaiOPkHZuYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChgAI3zYGyhXGaLK2FRR2/Ab7mM+j+J5zGugxXZQIEXwT9ym2ncZs3hTve1z+p5fUWjWGjcNA79EZV7sTWq++Qhn6bJPc4gSH9TAn0gZr+hZRYtYXa2Wj6cIl5P0FyXhCpyVTJS7MZuVGkZcqjtCINO2qVvkQZPOGSO+nRMEVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb8Ge1RS; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb8Ge1RS"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8ca01dc7d40so32269285a.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 09:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774282287; x=1774887087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOpODx02vqnIuQItSU2kJcW1MWLXO5dVdzh0TCf+iWM=;
        b=Kb8Ge1RSI3MDSig4/4iI4lhsBzUe6PvIQetLvFF7klcLIeHiKuhqIG8ks5wnaCWGAo
         vUbf/cI1pzieALDkooI2sXcHRvbYDz3/9KGlBSck7/O2J7qpOOe69XMavON7SqbRDHJi
         j5mHqV83IpvR7O6AaxDXOuk+8ZPcCqy2VcUvmIgWB+JXBSZK9+cKp/h5MZQZoBA72NS1
         ztLnEzXhRiVCCZ57VHS7O2fefF6P3qQMkYIJYugvAOn6OSoJpsqn/5cJkcYH1Uwae6Ep
         FycOflUAKMI9KwO6Kc6eDAfe70AC0pqyTZ0ucdjhJFgsCid+TX2CwYwPG8j9kPdrHgj0
         UoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774282287; x=1774887087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QOpODx02vqnIuQItSU2kJcW1MWLXO5dVdzh0TCf+iWM=;
        b=BLqwXymKBJDAGLKMyv4cJzVLSN/Gub5oK7n9/1NzzUQj48eqyhdroiRO2Bx+KVNGh7
         cn3sI6/j669nu8r6UzNw+MJ30o2Cgn+hhMaGO4IogVSGG38wEhB5JDrM5Me+XarjUVK7
         5Wafz24dKgpzcmCOSrz02Xi82nbY0KZgSJiNpi3o8KeqRL/WOgApDorB5dpAo3YmVBrR
         SH6Ub2/pKEwyxLUZMnEdbXVaFpa3tjn6UTp/4O8077DEVx5dm1gGpUI0dQEOlDDtPrJW
         nn+64SFSCO4+C4Z1dv1Lw77WxJZIoCqSo3SM4Ip0+6CUs4ZG+h8CC7iF9WfUQ0LWXrez
         nvbQ==
X-Gm-Message-State: AOJu0YyrQ8ner8oTsDPGgSEch4n0DOG+vmU54cu8b3+u7bH4vzX5pAbj
	GaaCEUCL/TjGYX4YY+f0ttjF/51H12J3W+D6hDKqJmkdUtoNoo+15SOcurG7tyCN/Nc=
X-Gm-Gg: ATEYQzy2ajFcriMhViMjQTr6+oQaA//HsIae5Sho1hp85mMnmTubKDKjqkq6gGlsOOO
	ijTFL/KUjdRvii84BYDYWBA5l+57uHy0VKn8JrHonUrThPwf6STu0+1KLE7AioTX+kiQuGpgzsO
	y+EIzVC7GoJFAoeRZE+JFnj1qK9PaPp0GEwS5Hx/HH1gvU9wVV9gfPiZx31wL2ju/LD2T5wNnxr
	Od+88l2+2CHdhwIXoNnpnqAa7/CeDENFFW5nofljIdH85tIHALGzBKTlWe6mnwokJ0S7msNtA1E
	Ua/WDV5aN/HhtxAP0JiG9nNHBryqtXvNQS9l2TQIsQTb58EfFWVwoIM3YvaywKYPh2Yp9LJFV0G
	h+GgsaGFPxbskY/dF/r2Rl9SOs0jUxfiA3aMqy9msov0SbkKNr1MjJOc2PugFCB6pHoNas0n/ZF
	ppZir3dfORm3Qgvjcc/i6YFr6/emKcD/ybCs8Fbbh/TBLpq+YlUPGSdFo7D9BvTBhd+S+e8kgie
	H7jKsDG7IipL7zk35s=
X-Received: by 2002:a05:620a:47a4:b0:8cf:da2d:d6ce with SMTP id af79cd13be357-8cfda2ddb38mr789186585a.41.1774282286385;
        Mon, 23 Mar 2026 09:11:26 -0700 (PDT)
Received: from localhost.localdomain (nat-128-59-176-206.net.columbia.edu. [128.59.176.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc908dd5esm834809185a.30.2026.03.23.09.11.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Mar 2026 09:11:26 -0700 (PDT)
From: Mateo Patino <mateopatinodev@gmail.com>
To: git@vger.kernel.org
Cc: Mateo Patino <mateopatinodev@gmail.com>,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	ps@pks.im,
	gitster@pobox.com
Subject: Re: [RFC] [GSoC]: STRBUF_INIT_CONST: initialize `strbuf` to constant string
Date: Mon, 23 Mar 2026 12:10:51 -0400
Message-ID: <20260323161101.9142-1-mateopatinodev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAPig+cRAsEgeT+OgCSpTuY_Q6dMpXrfadrB=ujkAUyF-ocu2-g@mail.gmail.com>
References: <CAPig+cRAsEgeT+OgCSpTuY_Q6dMpXrfadrB=ujkAUyF-ocu2-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

(Note: resending this because it had HTML the first time and the list rejected 
it. Apologies if it becomes a  duplicate for someone).

>
> You probably didn't intend for it to sound this way, but this summary
> makes it seem as if the Git project rejected these patch submissions
> without proper justification. However, having studied the threads
> which you referenced, it becomes clear that the reason these patches
> were never accepted is because the submitters never followed through
> by addressing reviewer comments. For instance, in my review[*1*] of
> the patch [4] which you referenced, I pointed out several significant
> problems with the patch, but the patch author never responded, so it
> makes sense that the submission was never accepted into the project.

Yes, I saw that they did not reply to reviewer feedback. Here I meant to say 
that previous patches had already been attempted in this area and could be
used as guidance for future attempts.

>
> Although feedback to Robear Selwans's submission from some reviewers
> was subjective, Peff's review[*2*] pointed at a major roadblock;
> specifically, that strbuf has always promoted strbuf.buf is a
> writeable C-style string, so it is not safe simply to assign a pointer
> to a literal string to the "buf" member, and it's not practical to
> expect that all consumers of strbufs can be audited and modified to
> work correctly with the "new world order" that STRBUF_INIT_CONST would
> introduce.

Since the Git codebase widely assumes strbuf.buf is writable, I wonder whether 
we could create a new struct that is specifically documented as a read-only, 
non-owning view into memory, something lightweight like `string_view` in C++, 
which is an object that simply holds a pointer to a string in memory and the length. 
For example, in C,

struct strview {
    const char *buf;
    size_t len;
};

This struct would not care where the memory that `buf` points to exists. The
memory would be owned elsewhere and the caller would be responsible for 
ensuring that the memory is valid throughout the lifetime of the struct. I think
this could help pass around string data without requiring ownership or 
allocation, particularly in cases where the data is already available.

A small downside I see to this approach is that we'd need to write a few helper
functions that accompany this struct, and they would likely share similar names
to the helper functions of `strbuf`, though I think this has been accepted in the 
past in other places throughout the codebase.

Another consideration is that this proposed `strview` would not address the
lifetime and ownership issue in [4], but having a safer way to pass read-only 
strings seems like a step in the right direction.
