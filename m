Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910140;
	b=x+5GLF3NTesOoQidw9RsYynW9UkvjWGIKiTfm/QwY+HuudFyR5x7BKpZNgmrCPnTDeXP
	 CII9IL7tuLlZqq58Mln5SZEbfeudB/iu80SPc6o1eFm/IcZxgjPn3krkTbHpWP1ogQop6
	 PxlnUnuALbN+1IeAaPO1qVbUzFnjRye90Uzzh9P7ONQi6Nb2jefRSNmSsZvYpbKsSZvPr
	 sKPWxmHZKxXq4FhZdlIqWWadXO2jtDNYUF5yZKpOuU4xNVsSJe3g6qyoR/V5NnV5wNp6y
	 Ut0jm4XFoXYp21HBihoIx6qP5fvA/NyChfJLlWgYUMFBmUVAlqTVrWIhK9AzGJDuuvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TLgBtJn3gK4X17be+aFGR16fFPZ0bxB37jamyvDNOng=;
	b=gzqPhiTkp5xz7B/Bf1yL1buux3ePRozMTjZpaCEVy/1HHiR7XeqLFmDqjs5K2G7SfXAx
	 4G2GKWXhy5ccSjSgaZaGKMt1dtuvAPJL6ZSB4g52n1qHMt6glzrXz0FLLDKSqH3JP/38O
	 JZEd3uUTSVg95syiC7ei5XKCay0j4wVp52L/pDCxYGVtROuOFO2aa7GGqLND0TV9iRiEg
	 WXlYsh5auDjxZbJ++b2nRgdXHJcZFXK5D7db68fRHhkVaUYMry97WsOgE8x+T12BC/Sea
	 l9L3wwGVEbSKl1CMd+NvEXO3pkPPsCZYRRaIS7GNcG8XFxvbmqhXXJYTjEyz7BaIF4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tylercipriani.com;
	spf=none smtp.mailfrom=tylercipriani.com;
	dkim=pass header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=zeqE0zQO;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B7606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 06:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E1B7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=zeqE0zQO
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-846566246e8so1822355a34.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 23:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1792910138; x=1793514938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLgBtJn3gK4X17be+aFGR16fFPZ0bxB37jamyvDNOng=;
        b=zeqE0zQOkpC8HW+34t6a9TU6V3gEzApdOQNVvPTamcSfSdenAh5sUCGIscigpmIvfU
         k65YlHHNgy94qdG+DHfXGIlTDwYR0qyUp6KPhPYJAc4jo3nPVmW7OU0oCkpKmBJu/2at
         pQsSb+DUq0/XxHzUOUn6cgm4fKHDJT/pjMk84tF7sudIl7RM0yLZJSZWjur1GHIAqyAb
         fIx0cscCLqO/sDmEUDis+vTzZV8SmWTYL9Bfyo7lX/lTUVR1UdSDcoFGTbHl+sZZwB87
         Uqa2WXgRDliXcd/SdgUhbP4nwcUwhLHPEI9puwa71WvAjkC4iudMGilRV0rK5osxmucG
         xXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792910138; x=1793514938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLgBtJn3gK4X17be+aFGR16fFPZ0bxB37jamyvDNOng=;
        b=Ql8WZtRben+OF9WIRXXogmyhq2HEsnP0jjwCS1yAI+eUoip8OPaJE5hooB283EgVQ+
         sGC/w7K2T7tTi6rCr9AxCNpOBm84DfaeMfYvt/T1huTsoWpTAAqLwxnB2BxexkGoki5r
         QJDOZSBU3YguCT2ycTDSG5UR54YvvDqJ2RHkoDY4yz4M9nnXNDUkcU+lHXR1GGXshewD
         FnTVPiCjlqSD7pFf4yNk5Yu+YS7CLLBDwom9dbGugp8GYUdIALzJoTjOeVNfe1GRqJbi
         IClSDPmGbMfcr+PBBJ1FVNT1UsWrKHwmrveBCwgEill8HmZNR0orgZomIFQbhCAYomI9
         LZgg==
X-Gm-Message-State: AFq9FYJJFXKJVI+LygEe24crAY3iLAFyNaAJpuTxWFDniq5bAnYw3Fk/
	PpcAEjzYJvn8IdqhSOBWPmGHyconOF08l1GWjA0rRz97RJbVL5GlMjV8E1mKX2dqayuSfBnVvYn
	kht3k
X-Gm-Gg: AYBFou0U5KGW1W7uU83PW4gysertQNL0LMIc2RW0Cta21MfRHsfQAXYJM2VKnb/atMx
	YTlKO2XYaOt5JjGSrQDJziOsFBUORFEoGbosXMp9ZG93GgR/om4fBcwXxfzj50yJfl/LXOqDa84
	71sEOx8YZaS6DJ4tg8xKlrE5yILbV+7zugPBDPmjUFBG0xpiNsXqQ4L6J7w7FdO/L8OZ0AhjrUZ
	pMTKWbbEcCUcM4KUq9weUlwwc6vZiMNfJ5BPMFNncYJemHkzTLQsURRGnq0gXzB7bO725RRj4Xn
	UvaYmouk8G0MsiBjkxlXqWucB1kloVlQTPjLDlIj7O5Op/mlvciVloV3pCrCuIIToYSE6BzLzkb
	hmMLB3OQt7eroRqSj4kN5X54t5QDGH6wm4Rd5ZhiJ0Gv1tY0sMm8QK0/mtgLxt4dN0MmSMXy7V1
	2RGCtqklrQC6VApsi3+TgsQCUrtwR7Qp4CLbeOHfZGD3kxfUK0Vd24j/Zpds/jy3iQmt0Gyugvi
	aKnnfEUdEqzpB7zSciYktz/3ztvA4wh6fqpP+43XStQZ6+GTQfvW8cYSA==
X-Received: by 2002:a05:6830:25d4:b0:823:d058:c236 with SMTP id 46e09a7af769-850fba2b0abmr1792000a34.3.1792910138599;
        Sat, 24 Oct 2026 23:35:38 -0700 (PDT)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-850f8458a4asm4257686a34.3.2026.10.24.23.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 23:35:37 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Tyler Cipriani <tyler@tylercipriani.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Montalbo <mmontalbo@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/4] t: run greplint checks inside chainlint
Date: Sun, 25 Oct 2026 00:35:04 -0600
Message-ID: <20261025063508.3026136-1-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <xmqqjynueq81.fsf@gitster.g>
References: <xmqqjynueq81.fsf@gitster.g>
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

As Junio said[0], make test-lint is "uncomfortably slow".

make test-lint runs both t/chainlint.pl and t/greplint.pl which do
mostly the same thing on mostly the same files, both:

- Open about 1100 files
- Parse/lex/tokenize the files
- Run checks - which is the only place chainlint and greplint vary

Plus, greplint processes files serially. So we're doing the same work
twice and half the work happens in serial.

Following Peff's suggestion, this series teaches chainlint.pl to run the
greplint checks while running checks on its own tokens. So "make
test-lint" parses each file once, in parallel.

Keep greplint.pl as a standalone for GIT_TEST_CHAIN_LINT=0.

Peff's early return (patch 2) speeds up standalone greplint.pl (when
greplint does its own parsing).

Peff: Can I add your Signed-off-by to your patch in the series? It does,
indeed, cut time in half when greplint does its own parsing.

Before this series:

    $ time sh -c 'for c in 1 2 3 4 5; do make test-lint; done'

    real    0m25.158s
    user    0m51.557s
    sys     0m0.899s

After this series:

    $ time sh -c 'for c in 1 2 3 4 5; do make test-lint; done'

    real    0m5.972s
    user    0m41.536s
    sys     0m0.943s

(nproc == 16 for both)

[0]. https://lore.kernel.org/git/xmqqjynueq81.fsf@gitster.g/

Jeff King (1):
  t/greplint: skip test bodies without the word grep

Tyler Cipriani (3):
  t/interop: replace bare grep with test_grep
  t/greplint: move parsing and token check to library
  t/chainlint: add --greplint to run greplint

 t/Makefile                             |  30 +++-
 t/chainlint.pl                         |  24 ++-
 t/greplint.pl                          | 240 +------------------------
 t/interop/i5700-protocol-transition.sh |  10 +-
 t/{greplint.pl => lib-greplint.pl}     |  78 ++++----
 5 files changed, 93 insertions(+), 289 deletions(-)
 copy t/{greplint.pl => lib-greplint.pl} (85%)


base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
2.47.3

