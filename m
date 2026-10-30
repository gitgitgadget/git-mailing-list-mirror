Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354344;
	b=hPWhmdi8iHkLGu1P0d9BtWQs3m0NyUZChvuP3byahqbApi69uDNsKrgeI2QzUrxJUi2W
	 iwCSafyl5OqBsZ+ch+fXRSkHjs1L7nNZ8iH5eJvLoiQ+leonhQMjP2L55qHk59aILt89V
	 8X7imDU1bCBlegZGzsYHhFuyDuV+NWtXGhwtRsUVD8ay4uLujNGjGoyMWN8OSDdUlvysQ
	 ZYEcxIGLN5DfIsnwt7b70l0yjw6WxJS/vO4Nb+u2jL3IpHxFNuxoJGNeSorZ7AMGYE1Vj
	 gC1ULabYAx5SUQ68kbAl8Fd/0iYWbQ/4uM8RlPfwhvPhDBXqBQHK8r8fA7zYUyGk0Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dPkKzaHYkJhh6wa7QFoKyPu7Q3qgqtI2wNOLP5sPG0o=;
	b=Nn/JJd74FgxvO2VqweSSMvzMRt5OtmJlJMFNi8EJ9N9hOP236zq4zvfdkESqoC0u2xFn
	 hhD0qjA5DGNO+xnKeCVknnnB15pN7KphrCNOT1Dilg9q/Ro8vfxR0yq8x/eDbOJliB9tD
	 gB/u3oEa6g3o72lsSt9P8asbXNnrFK4co9+2BZEPUosH/nGeGf6Qw0Xhmq3lkJ8mtgQpl
	 L5ZFomNqiz8kzBSkb8ZuUlOCjQ6E4x56lbVHH8va5WIy5z6j+emD5Q7rnY3XMdqmctqnF
	 8X9dngLUjlvEpTQ6HEg+qYrYDOU95JVCXjqzzeuAbnZL276B/MzPk5YJkhI19EQcR+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cvvieoqL;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A410A606A32D
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A410A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cvvieoqL
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so273781f8f.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 02:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793354342; x=1793959142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dPkKzaHYkJhh6wa7QFoKyPu7Q3qgqtI2wNOLP5sPG0o=;
        b=cvvieoqLQQ7e7QgsIWN0arVsfCEajft2XKVYcUX2Q4BNE3kog8dKkrpUcz+uc2B1A3
         q14jGD2Vnn8SsdvM2EefjYjEueqB7tZ4VBvuPofaFoQxDDHGovmPSvhKWUQ6V3RIOzc0
         bNTlSgB2xUbHyotsuF77OgJ+zpfYtKO3Ja4LCve3UQq9aOlWIibEvWPDQ7HWvqxVekWv
         lLHfQrT6sYEzwmpstzYwLVYrGIwpR+O3xXNFlxsfvopXbPOKTccnEkbUXLM/AgNR8xyM
         udN9WqGLrL589kA4KkT921f7dl1kR4lMXjA/hcMRVEtoaRte0Ph7UsmvaQVtGJU5LpBs
         vMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793354342; x=1793959142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dPkKzaHYkJhh6wa7QFoKyPu7Q3qgqtI2wNOLP5sPG0o=;
        b=PkxyG48drWuU5b4BSN3VzKl25JB0NLmVSh+YFyhHx/AToFynUxlTfOpp/88224ii6N
         jHos6W02I7/Hm8P2zZeYFgCvixg5/rG8jQWCD2yW8TeOuZLRgpbENoInplvGsOR4WxC4
         WwIYaqj+H3cbW3oeXoc8AAmcm+w5efSngfmGKJIFC8PW6gQVN2RzbdXfazTCDqf4lmy5
         0kxWY7Vha/8LvtQGvfjx6fPAhxF0Qksyz4VlgnEJAHXFL87zJ+QHo7BVbKnJc+sm73Xt
         09Z+EQwQCnhcGQEoVsKMLiwOq2T/5++sOoiL5l+DxMCN3IcARRro8ntsYXpbHRIRezAS
         iDYw==
X-Gm-Message-State: AFq9FYJiDLwIzULfagkdyylBmRAGiO1qpu04J7SN/EapIa7MzIQbLfCK
	VV3xVXFE4vnjdYwLpOwOQwVoWZ78Cpf7lblU5R+USXto2+f8Icv5nKHBcwNUujOS
X-Gm-Gg: AYBFou0ZkmyYrgOXvuEg+3YAGnmtsTteyU+29ZWYZpJlrwFlJKUH1+dwfeqtS6b93/Q
	uH4Uf5igMcQT1ej6y+Np/qJTgCadsznXHRVdjFFSNJ6n9Wer/peX+IFN3HY63YdPbsDqt2kW3xI
	VcOye0wBV8ScbQ54OrAINT+RQBqgBlxMfMdCVRuI3bx7d4PkAx9D6jI6gXvot2mCzhxavC5YmKh
	nch+E/eLIEhc2IGhuXVY2XTeKtdLkrkXtBvnQJIsdfDSqqNVocJWYBKAOfkakh15Z/1oHu2+Zom
	O88WWZMI3ulzyG4UaJJZ5nwERG2dqP/wkbuaRpLn6XbrMAkjDZ8xxKI6hFBiVVyEavZFEERhJ43
	YUQY2R9pj9W3E4fu7ErkWGUWyEW/NNgd1xD4Q2XkJ/5pMXREQakixFReOqDvfhpRqlp7Vk3xKlf
	dJi88fgHl/mW9RXz/eyss0q6Xs2bXu0hYNoiUwtJADnIMd0quDW/qOMYTJ4FnxV8nT9Khz8M8ph
	0Ql5D0lbDhzq/sOj8/ciiwCnVUsfIwsOiK7Vfi0E4iHetcWTwCpbdDUCynTXZwuYrBTdwzg/l27
	YIomT9+Mw2tnNQ122Law2duDVKFpNuH+KfvAhJNALfjWj/twZA==
X-Received: by 2002:a05:6000:2007:b0:48e:5e63:27fb with SMTP id ffacd0b85a97d-48e6e2dd32fmr4711947f8f.20.1793354342000;
        Fri, 30 Oct 2026 02:59:02 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9b54dsm2359421f8f.47.2026.10.30.02.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:59:01 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] diff: use size_t for the allocation size of word-diff buffers
Date: Fri, 30 Oct 2026 10:58:51 +0100
Message-ID: <42d4eae98540028cbb1deba469d82d676642ca17.1793352943.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793352943.git.gitter.spiros@gmail.com>
References: <20261021101640.329990-1-gitter.spiros@gmail.com> <cover.1793352943.git.gitter.spiros@gmail.com>
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

Since 3c7a31204f (xdiff: use size_t for buffer sizes, 2026-09-30) the
size of an mmfile_t is a size_t, but the word-diff code still grows
these buffers with ALLOC_GROW() using an "unsigned long" (in struct
diff_words_buffer) or a "long" (in diff_words_fill()) for the allocated
size.

On platforms where "long" is 32 bits wide this is not just cosmetic.
diff_words_fill() writes every word followed by a newline, so its
output can be up to twice as large as its input, which is limited by
MAX_XDIFF_SIZE to just under 1GiB. alloc_nr() computes (alloc + 16) * 3
in the type of "alloc", which overflows a signed 32-bit "long" as soon
as the buffer grows past about 700MiB. The result is undefined behavior,
in practice a negative size that REALLOC_ARRAY() turns into a huge
allocation request and a die().

The buffer in diff_words_append() is bounded by MAX_XDIFF_SIZE, so
there it is only a matter of consistency, but if that limit ever went
away, ALLOC_GROW() would truncate the requested size, and the memcpy()
right after it would overflow the buffer.

Use size_t for both.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index b4ac17f8ef..9483931c05 100644
--- a/diff.c
+++ b/diff.c
@@ -1959,7 +1959,7 @@ static void emit_rewrite_diff(const char *name_a,
 
 struct diff_words_buffer {
 	mmfile_t text;
-	unsigned long alloc;
+	size_t alloc;
 	struct diff_words_orig {
 		const char *begin, *end;
 	} *orig;
@@ -2192,7 +2192,7 @@ static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
 		regex_t *word_regex)
 {
 	int i, j;
-	long alloc = 0;
+	size_t alloc = 0;
 
 	out->size = 0;
 	out->ptr = NULL;
-- 
2.53.0

