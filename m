Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4C800
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521868; cv=none; b=k1QpXIJ2KCWXMu6DohUPjfyKdVuCDjH2szqCdA4dnYs9OzuV1jWtOjEqME7Z0oGLbdt8K6fUeCg5Br6eCsLK8OT5lvPlm4m2reKEA31FbiJovcRXt06xGF6LXNlrlC0EJIGa+EfReER0Z61KM2+yngW2JmvH9aG8rxuoKjeSKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521868; c=relaxed/simple;
	bh=gWc33uCmWb98uMl9nbX0fzw+Gtw1rfeEZqOBXJIYE8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQUmpPrA+sDa6NphN8ZSfqgwH0tB4jyEmbBOvgKvnfjXv5fkIiaoucCpE55hl8q0aCJKQkKKoJlqcdj0gRCPAyTcipljoA17WdYlaGTPD1GS4hX3jaNfTB8qDDe6D0IHIZNcgvC7JGTcemfH5FsxeYqFSRsPXfGfEBsdxe8JG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/F0rj/F; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/F0rj/F"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8714a52072so245280066b.3
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 16:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768521865; x=1769126665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OsYA8s3PqahFS1gOvXybEolHV/I8y+ZksdLvuBQENow=;
        b=T/F0rj/FVrgiwG0rAafoKM+hdpuout5Y2fzI7alcTqvBlehTKB7y6kz/TSPwPBvgow
         tT2m+YgHm1eOt9s4Ad4fs8Cr9f0Ph0tS1/kWyUz24aH6BTQjcPy+gONxDfn4gCRtxvKc
         qLqPfSr/IVllulQADeikWVZ2xlQr1oVOhXcBzjvjOdBZW1FnQti9cVKT2uwSXSlv76si
         poJqQHxaOiMleJgnDzkKhmqRBIo+VTJCXOaUAjtu3gyg+4dooGv5Z+lESY5xnbDJqME0
         hb9mBCm95bcj3ZTv0eJaGARhiEOtOryQEFPrOBEOe9igioYNSxgiwRk3pP9sedv1wC6Z
         IZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768521865; x=1769126665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsYA8s3PqahFS1gOvXybEolHV/I8y+ZksdLvuBQENow=;
        b=wP9M8Rz4praOvSgdow7wu/0f1frWpQ/WWxS7ZmVUvSEjYM6A/kGuHJJefv4RTbv2v1
         JRHgUtdABcAReH7ZJABppvB+5X7TtEJrY0Dxn2hj8kel8QrTbeAK2PLD84sqorLAOFN0
         Fbd10cn9Tk1D8UvBCcoLgY3uXUcrv57W4WJ2GWJSgm+Iy9TFU9ymrHxXrYyJtlNGu8sp
         4nhlokTB5Kg/roqZgE91V120gyaWoJrWiiaXIJ9xxg6w0m/mpNSQC//NQt8XzTTI6KJf
         xxV8yDDOEBriGtVtdQcVN6635vvI3tsuIGNaTsKb5Qfck1sTjfktFcfl2VSO9Q8aIUZL
         ioGA==
X-Gm-Message-State: AOJu0Ywlfk55xTmtyC/14KEP4NtgpRqRQDcQBCOhEHmUmGT/8dZU6xB/
	q/5I8PpT6pjTpryf2F/RPvPZsYHitC2BRV33khzDhrwjZ9f0ACSt0tnT19VgS64s
X-Gm-Gg: AY/fxX4b3GBUy5/BwKvLwgpDYIOKnD3G1GgwiWDt1fNHjNBHZ8nGk+U3mrjoWgCGj6j
	wH//m3KVrSg0nYT0HeJBZHUfd0K31/43OFMQG3j8PKH1LYdbwyaDH78R4577S9tLJekKrYLvqud
	LHfQ2x+hAM6eFNZGM/SZIui6WUpqSRXCMrss7npEHbkIoXLKEzBoidikPwq2cZ47FqYGgpO4cHI
	UZ/psoNSNapLLyLe3GhPanR3wz78GnrgIWwLfRfN+pHMU7hMrPKikvqaUKylzQX+tG5dWRdEtdT
	24+7X6DlNfBtX2JkOL9ecrGaEwxuknQulkTjowIe76icrKsoMy/TjPk378PFIZyqP/IHGAfboq+
	8tu21jFjWG6hgcVRma1Q55XJyR+g7+AebNAD9azOVciN7tgQJmhy5Y/1yS8C9rpB25Sxg+cc9+M
	7nw9igQn0BM8HzDfQPEuqk
X-Received: by 2002:a17:906:6a14:b0:b87:1db0:a4af with SMTP id a640c23a62f3a-b8796c12a53mr50412066b.64.1768521864777;
        Thu, 15 Jan 2026 16:04:24 -0800 (PST)
Received: from lorenzo-VM ([84.33.162.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a0880dsm68940666b.57.2026.01.15.16.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 16:04:24 -0800 (PST)
Date: Fri, 16 Jan 2026 01:04:22 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>,
	Niels Glodny <n.glodny@campus.lmu.de>,
	Patrick Steinhardt <ps@pks.im>
Subject: [GSoC PATCH v2 0/2] diff: improve scaling of filenames in diffstat
 to handle UTF-8 chars
Message-ID: <cover.1768520441.git.lorenzo.pegorari2002@gmail.com>
References: <aWgYRkv-YsuekdR_@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWgYRkv-YsuekdR_@lorenzo-VM>

Added a test (as Junio Hamano suggested) to check how the generated
diffstat handles UTF-8 characters when given various `name-width`s.

This allowed me to notice a bug where, if the given `name-width` was 2
or less, the `len` variable would become negative, entering an infinite
loop. So I also fixed this bug.

LorenzoPegorari (2):
  diff: improve scaling of filenames in diffstat to handle UTF-8 chars
  t4073: add test for diffstat paths length when containing UTF-8 chars

 diff.c                          | 17 ++++-----
 t/meson.build                   |  1 +
 t/t4073-diff-stat-name-width.sh | 61 +++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 11 deletions(-)
 create mode 100755 t/t4073-diff-stat-name-width.sh

Range-diff against v1:
1:  63e73122d1 ! 1:  abeb8d3439 diff: improve scaling of filenames in diffstat to handle UTF-8 chars
    @@ Commit message
         characters to drop from the filename, rather than their display width, using
         the `utf8_width()` function.
     
    +    Force `len` to not be less than 0 (this happens if the given `name-width` is
    +    2 or less), otherwise an infinite loop is entered.
    +
         Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
     
      ## diff.c ##
    @@ diff.c: static void show_stats(struct diffstat_t *data, struct diff_options *opt
     -			 * leave the resulting string still too long.
     -			 */
     -			name += name_len - len;
    ++			if (len < 0)
    ++				len = 0;
     +
     +			while (name_len > len)
     +				name_len -= utf8_width((const char**)&name, NULL);
-:  ---------- > 2:  ee088ea6ef t4073: add test for diffstat paths length when containing UTF-8 chars
-- 
2.43.0

