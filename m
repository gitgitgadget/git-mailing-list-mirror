Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666926;
	b=UScM775X4eOot0xQCpqj21cBTy3m8XG3tcvKt5E0sbtwkHoGiv4lmm9KbI21hxvtWRXE
	 l+ZZ5uLGPFiqWEjXISFXRNa81kdCPC984HQ7jUCh57CGnfZT8hsg+tchG8FXit9RsdnXQ
	 YJFcC/gZ9L1ArJ+MnJluCkwVAWds1ILn8MNo//KCcAbbYvENQn2KEDCFtp1tKeKNOK34R
	 mk6WQij0rb0XZ9dirtFEJMofE2i0qoCD0f62zbvpjDyxjb2cfYa22Q1+hzrqyqISO+R5H
	 Je/WHqspmpBiezTDS0+fWvXwObR4086qKwy+PkGenmCzCPYdGi4JLFzzQfZ326GtyTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=tNWQ/GrFI/ofyDwUB7rSsOnN1dbZ7MfmZyTTWrBuPuU=;
	b=oDbEjG0uRVffZB9qhQutRi9KwVP2fEORwNVZ6Kx0e68rK62AXqQG6V5dlA99cL4HErU/
	 CWRWVsFe+IDLEFVhTiIYF/sjaWeDo6kZdBz1QcM6S12x9T36hBB4UXkgc1+e+mSqW7VdI
	 OzXyuoJUl56vSFc8IHUwo1ZCVoBZdrNxB7Tyy0uth80Mig8AfRL1L/mkRbzKkqcbA0kFP
	 bQCw7Q6kXfafN/F4D5nNRHW2E0Dw30eHtI6DYnd7bXzFTbRhmqe0GhpZhdeIkZVEv3ceX
	 6dOS0+rmIIR2KD0Vxn5A5fNAVrbAHbOsb9Rf0wv8ziIIpdzaKmMqNo6rc9ADAissisw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QRXEhVtW;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA67606A321
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EA67606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QRXEhVtW
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35f036b17easo1300021eec.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 04:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792666925; x=1793271725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tNWQ/GrFI/ofyDwUB7rSsOnN1dbZ7MfmZyTTWrBuPuU=;
        b=QRXEhVtWo1olz1SnFBegrr2jGKvebbj5n55210Et0xQLL0Mrt+hYjoE6xBjI6xL2Jh
         mL13oi7BGGQ33mHOeQb3h+qf42iEIX9fUK95A2t/8Fq4x9EqCSoywaVH1vRJFe3kk5+t
         8WcsMumGWstuCv2HrRo1dgDhd+th1jnDlFSIuOkjwUxZcNgLKJqXtU+NZscmkbAIRrf6
         7SYFoC6Hlb4Olpct6be25bTYZA03Z/9KLTkHYiDiQDbiz7kgwzS7zCwrspUWsygNj3D7
         t5efJ70GHeCOnQVLDAIfovliAL+IrG7yA946h+V71K1nuNjvmOrzFFpMmIjE6AhgRcZP
         axQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792666925; x=1793271725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tNWQ/GrFI/ofyDwUB7rSsOnN1dbZ7MfmZyTTWrBuPuU=;
        b=jzyEnOuksXnLIN1kalOg8webV/RdssnCFgaYk2t61Jgd7eOjm4M6IlyraSG2+/ExTk
         1cFeAAoisc2MuAbevbRx3lVzmaFb3WMu5Vrx0HgpWs1Di2xyLwbCGCNqs2xWmCfVyGfs
         n7vAbk1i/ae1cwnvcGQw6Z1b4mzctiyNChxLtTJeGiRZSJao0xT9uWzQwhM2q2sQ8epQ
         eqR6TJxJcyCg4rvoQai3fPWIrBfiZ3J8ZZy9i/pDaM2qg+QUMkZxNLMlApey+htUOFEk
         MES0KaN+jjuPqdHS+seRHOfABe9WdzqKS1HguVLX8n1qtt8JmPwmML9/TfvFC8sHr2O7
         mYuw==
X-Gm-Message-State: AFq9FYLBV1O5S9GX16xpsxMVNg9QE5IOLkGVWP0V8Ry27lOxmCq3jNlx
	XalsRQIYiWhW2YOISKjlNvBmtAyUWLQWQEWTxf4QO+jR3JFUGRF517zuENbOIQ==
X-Gm-Gg: AYBFou0UYgCzkzbCO1m5sDFNSAMNC+M7mbJ83L2f+IDilImMCuxaLeSyc40/D02PYEL
	l+gnnYtryIRbQGOiV2RAEd5MnI4g8JnHchyDfzlLMKZWPODZBuje6MKEPdpJ2psxmeGdwHzLGvW
	7fM3NJHoWLManx3rkGfmNPnxsu7H4CB2J31hIV4i7fVdtaE91D8b6p1s8tnH7U1TytlZ8Sd5IJU
	r45ue5eYL9tO3aFkIG6z7YOt7VJymuZwOzo3s2ZRSC4Fu8PDe3X3+lnN0JMU26uOlFR7A9+rraV
	es4hsSNHOuVrxDI7w+woq3zdJ2pw0DyWJQh5S8D1wcE9EVTjEY2UTmNpcUvWfXcW+nEg3UiWa1A
	M31gsa3VWq8XC12L17pQSMOWoOWg82rXmlo/qO0ofdm4VTTWAi39v9eFOjsnuvQfiSKxxpIgOBS
	gtlj/oRsI0RhzIfAoEMovfonD9FayaaKYDlGSiHWzUWw7KVoeDElE1jSe3F4L1CAwxs6liRgYzx
	X90qKoqZ8eRuNEbbxCjZnnRUE9ppzVbf1SMJMHsyD1Ltgtr87bB6LimXJQNo+6D
X-Received: by 2002:a05:693c:864e:10b0:351:7444:8bfd with SMTP id 5a478bee46e88-367508e2cfemr7088006eec.39.1792666925090;
        Thu, 22 Oct 2026 04:02:05 -0700 (PDT)
Received: from [127.0.1.1] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-368ca914bb8sm6277428eec.5.2026.10.22.04.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:02:04 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Thu, 22 Oct 2026 16:31:57 +0530
Subject: [PATCH 1/2] unit-tests: reshuffle NOOP arguments to maintain order
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-ks-unit-tests-ignore-long-tests-v1-1-554a590d418b@gmail.com>
References: <20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com>
In-Reply-To: <20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.13.0

Ever since 9faf3963b6 (t: introduce compatibility options to
clar-based tests, 2024-12-13), our clar tests have a few NOOP
arguments in order to accept the same arguments that our integration
tests accept. This makes it easy to pass in test arguments when both
unit and integration tests are run together such as via:

  $ meson test -v --test-args='-ix'

On a quick scan, the order of the NOOP arguments seem to be
alphabetical. That is only until you notice that 'with-dashes'
appears out of order.

Fix this by moving it into its appropriate place thus ensuring
they are in alphabetical order. This makes it easy for future
patches to not worry about where to place a NOOP argument
that is not yet in the list.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 t/unit-tests/unit-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index 752fb38fb3..d066c8a4c8 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -33,12 +33,12 @@ int cmd_main(int argc, const char **argv)
 		OPT_NOOP_ARG(0, "root"),
 		OPT_NOOP_ARG(0, "stress"),
 		OPT_NOOP_NOARG(0, "tee"),
-		OPT_NOOP_NOARG(0, "with-dashes"),
 		OPT_NOOP_ARG(0, "valgrind"),
 		OPT_NOOP_ARG(0, "valgrind-only"),
 		OPT_NOOP_NOARG('v', "verbose"),
 		OPT_NOOP_NOARG('V', "verbose-log"),
 		OPT_NOOP_ARG(0, "verbose-only"),
+		OPT_NOOP_NOARG(0, "with-dashes"),
 		OPT_NOOP_NOARG('x', NULL),
 		OPT_END(),
 	};

-- 
2.56.0.99.g5a7d1e8045.dirty

