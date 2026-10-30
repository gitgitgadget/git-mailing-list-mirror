Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356131;
	b=Zk2zubT7G/uPkKlIt70KkylQ8t8/oxy5wRAP1gl6MGPbVkB4LYiOq40xmjSwQ6qQ40Sn
	 KxHLzOVbyq8217WpH2SAMDutK3G1sSlVOexHOs/6E8ZvM/9vPRwh7vocy1CeupBawRmLn
	 Vu/uWLbCxRLPzEJH2LiA5qCITT22l11gCZfGdCMfKZfnmq7IlWPqxqje63e+ndV90uQUp
	 hoPGtQD3nqE2/8wkJ/kRo/G9qfb1zoOsp9VXApM4gyqUurCBTuVl3zW9FpPYiZ2amnPTK
	 urQwFIcxJyQaDJkBlRbY2a3osBDgHX/KH5DkZemvQzRszWXptOXfyNY8h2Wvh9UvKMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aeZlgdld8Mlenh+df9G4lQ3t/qfooZFG5zrAZBl7IVQ=;
	b=ueQL1pLF0nznV/r7k5Rq9ZtEzJyo0HMphGfNaFdxpmDW5xjMh/QMGnIA9iKI2qBGkMiP
	 DAZrEB5zGEb8aLWy+pDJ2SDM6fDDXFTO/DPPyyB26HDR2obNcMBqHZpBj6ZCtPjpm0yuZ
	 ioQbBkuXIP8/Kx5dXru8WahnGyBroSRPbwk2t9tMsHENMShGPMHEIJbchNuySDKaPiLKI
	 xINkuhapVbgAXgYCpZV4S+g5meJ0TKY07/SsMKU5DklT5sBpCc6mcGx9GUMveNU7ByXSk
	 nvEulGUuN0/fA4XTcJ8IbOqM275Z9cGsE8BhEWRYXL7tShQ7aS99jPSSF3X9zG6SISA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s6tzW80O;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EB260A6F57
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21EB260A6F57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s6tzW80O
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48dee593f18so460053f8f.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793356129; x=1793960929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aeZlgdld8Mlenh+df9G4lQ3t/qfooZFG5zrAZBl7IVQ=;
        b=s6tzW80Ou7GTGujaCHoWbkTEbygRoLo4m3oJgQgieKWX+VhCLZRRTo6wMobilPc4h5
         oYfwKi2+shbglykcK7aXkdGPNTqQuwhPPzUzhqmsDjJKsUrzB46QKotNgjkkgz0k4qWB
         yhEbsGCMRU6+i/i1gDlXFIN4aY4SXf/Pj41wRm4KJNALNNO/ghtHNo4TjPRgG04ds1KE
         00cgbNsPshpnPBcyZTUS6xIkzT7qmvOD4uChqdzIeteQbSkxwu9c5QZ48908/cQP3Jvn
         J8rcoLTJYbKrHaCxaE9rgtQDbYt3RM/NAxDkQkrZpPIQbCoPBNny1VqJ9m1AOBoN0x5L
         wGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356129; x=1793960929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aeZlgdld8Mlenh+df9G4lQ3t/qfooZFG5zrAZBl7IVQ=;
        b=om3z0CH31zSnGxwZ6NXSj3de0Cknx1zAwJsVpiwbRsMCoOJN26nNfsXsPHxmt37iE4
         dxYw4gFVKpIRw4lMcXfjxJgmUYfRKkeur7GuAqHLEmfhWUPwwRr8RTg9LUW5HVO/Rvx4
         50I6wbWYcKXgYrCdHeLvC62+s0714KF5cW+m1mHjMqyoxCy/UxHuHj8tIPtiaYHwrZok
         TDy6DqX4pqY2henLRRr9t1fHIEAmxg++yTg7+MBt5S0BXVkwQEDksEqZVEPnEMkqpzNM
         3GOsezWpAWgZgS1XbXUeUq/i/+JhzqzjnR1s96vUMl99iuLzVFhmMUZrn9+dArXI3i0R
         fvPw==
X-Gm-Message-State: AFq9FYK7jYeChla05ZLrrYrEecS16XEoh8iyULSDVX5WRAsIWG2SUyUp
	4aJRxn5KISO2AvOJizgUDlMq0K6h8RWmK/eLXrqGJ+rK/UJYpvRzGFh6/dLFBQ==
X-Gm-Gg: AYBFou26D2TqyywailP3WXh5GyZitlkDa1LvDeRQVGFKdHrKdT0a4TIkNaxamTZyQs9
	jb7VdRnG9ksRnnTsLs0ZHdo/PoAVop7ZR4PXQd/wTJ7ee4pERZXCuJWHvrQRf4/Id5/owbTii/C
	rO0suwAPX9rYoQsCTVmFZt+feL4Nw0LQrvLMWBXdcQeTqSTx+KMn92hOUCibAjw2iGOxeSJj7tw
	NqmiTS3ucZvKBI7PEWrTD1VoNEWr48hLt7R4/Bx9i0cYQadgOQw3M98n+pjd5yWp5czY727c6r0
	ZgvpDdQ2Qt/TGvzqg00X1pq9qzCShrptTpfXLqSIhAVDi+7R6iTZmgnpEonu+mTPainEBBx883+
	tIHTLFcu0z0nm2e/GAr8jXFC/yOiBZUXiNXYLy4k0wYqox0CFKWvM0i2jS/txtJU0D0UozpncQw
	w37SJsqEkp2wpo0zbcbm3865feXdX/mjegVAXsImgrheJUUxdClfXfPnLGCBnxNq++3AuBYqRZe
	cQCpJy3oqICHvcOh0cH7WR8UR09/jxHLE8miFPT+x4734Y5TWGkVo7+oMCmyK5hcLx1rQQScI45
	DXAH/2BHQWaFIRF4rSgxs0C6Ui0IUVVzncrGQgI6Px09cCz/gg==
X-Received: by 2002:a05:6000:4a0a:b0:48e:2448:ea23 with SMTP id ffacd0b85a97d-48e6e307864mr4787475f8f.55.1793356129352;
        Fri, 30 Oct 2026 03:28:49 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm2449445f8f.46.2026.10.30.03.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:28:49 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 4/6] cat-file: use size_t for the length passed to batch_write()
Date: Fri, 30 Oct 2026 11:28:37 +0100
Message-ID: <b2083632a1373b53380ead18ec32ca302143feec.1793355390.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793355390.git.gitter.spiros@gmail.com>
References: <cover.1793355390.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

batch_write() takes the length of the data as an "int", but its callers
pass the size of whole objects as returned by odb_read_object() or
filter_object(), which is a size_t. For an object between 2GiB and
4GiB the length wraps to a negative value, which fwrite() and
write_or_die() then see as an enormous size_t. We happily write the
object and then keep going past the end of the buffer, sending whatever
memory follows to stdout, until we hit an unmapped page and die with
"write error: Bad address". Objects of 4GiB and more are truncated
instead, which desynchronizes the --batch output.

This affects all platforms, not only those with a 32-bit "long". It can
be triggered with "--batch" on any non-blob object, or on blobs with
--filters or --textconv, as blobs are otherwise streamed. For example:

	blob=$(test-tool genzeros $((3 * 1024 * 1024 * 1024)) |
	       git hash-object -w --stdin) &&
	echo "$blob big" |
	git cat-file --batch="%(objectname) %(rest)" --filters >out

fails with "write error: Bad address"; with stdout going to /dev/null,
strace shows write() being called on addresses far beyond the end of the
3GiB buffer. There is no test, as it would need several GiB of memory
and disk.

Both fwrite() and write_or_die() take a size_t already, so just change
the parameter type.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8870a210ec..c846fe3116 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -425,7 +425,7 @@ static void expand_format(struct strbuf *sb, const char *start,
 	}
 }
 
-static void batch_write(struct batch_options *opt, const void *data, int len)
+static void batch_write(struct batch_options *opt, const void *data, size_t len)
 {
 	if (opt->buffer_output) {
 		if (fwrite(data, 1, len, stdout) != len)
-- 
2.53.0

