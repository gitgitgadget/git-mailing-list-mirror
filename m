Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999877;
	b=ZAVS9n0gjjugA8946gyvkGQHqXwrp75935yjCxGh+un0xMKsd5TZyxaqCpnPiBDvLqrk
	 0Vlh9RjHxOZzIEvq3Sf+D/heyAqhrxZSrU2R2Shv0US6kWODnE5sLSZ9S5/oCfMVM6/Xk
	 JEYnp5HoY9ltgW0iIvUZsmTtcP/W8ZHczTUgfzW57Dqx+bBcZTNYOoqyXhq0KmjJ/coiX
	 iR62Mxs7b5f0JJgs9QivnDgfBss3jzqv6z33aO1WCP4ixbQgl1F2N+GHQRQrpD/Wdsalx
	 cllPcKXvjytehYVPXECGY3UETZc8vHGU2Vu3aG8rx2xoUVfVRaLTqDPRPsRpgnhj0xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Mailer:Content-Transfer-Encoding;
	bh=KB+RhQqrSMy4kB54T9eAFJtPpTdmbC8db1q4gswKdis=;
	b=Rw7+V3lc+sa8ZeG/HzJDIfHAci8WVWAD8Mwm5XE5U+jDy1jilHhWaf/zaVYheuQWJQN0
	 1yGRgb/NTzhj1QPgbIyIZ6xKIhMIkblZHatumS199ETFW0AEq2yAl8jTKeEmRd6kpq6QF
	 9L/SeKnZCRhdCDjjelsY+OItYP3Czg1EY+2bzEpVDIIk6rwQYCyABjHTLvRPVr3ZiFXI+
	 gwA1AamT6S4J5723S7GyXGjUWpfnjm2wMxQLUyFysoIPlW1unUppONyUs16FJTnwr7MJT
	 hbF8A4DFAijv2Qd9NBtZBEhQ+rHvuWnLVraZyUR7fn/3vPVMUqIvGPSTpudvh1PSd3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J00WLOO1;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A19A606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A19A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J00WLOO1
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36681e85e87so50840eec.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 00:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792999876; x=1793604676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KB+RhQqrSMy4kB54T9eAFJtPpTdmbC8db1q4gswKdis=;
        b=J00WLOO1PZcAUWNwuf19Nm3/4XBHpZp3rGolnJD205p3hyVX2lx9uQidj/oylwS9AW
         ks4yZDw5lC2TaohgQLx7qxLVtBHKI9Lsn6iIS0gSY78MNTnXbQjAtPC8icLKEiyduItt
         QdBl+eksAY1QMSrk8VfrBqoIJDfXHEXUMYV/0eH+Je+XZEkNXDcA7v3DAiA02WAL1PCE
         2UHazDrBOF59cXb5CU7JssuCkcg12NwWZAO/NdJbG/ZQi5DsETHIPHzPiKb98rnbgrCx
         p7iEsKKG+usPH5bHPuPUc0cjXMiHtpQ99cW3Q6Ozg1MDLzDvi3Vfees+d+9AWimbLwbX
         VCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999876; x=1793604676;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KB+RhQqrSMy4kB54T9eAFJtPpTdmbC8db1q4gswKdis=;
        b=G5PCwCUgbDp7hPkgPip0zNPfirQW8aVZFh4uV44vImMIirqdJ367JyOz0hRCvJki0Y
         7QqKgslhySgEU0FDXvcO07G5rIXHe60mETZD5+qsBcVNwAq3tPbgluxoa+V308MY/uS4
         DV1YlTCNUJ8H3W5hZKUj4+ouiqaH6Swf1paXqbf5C49fqTYQjs7WbjdRKA3tzdG43ssK
         pDgeA04jUhQB0qAjjUckMitq5/tGlS7k237GUmMQiUKp+g3psyJbuNB+kdWlMWRpUq0a
         /KW2Goa/Tawd723EQ0gufj2OwqMSiSc/ps8QrFmmO9VoR5tlIOibjXJenCyMYyWWxSMN
         e5Ug==
X-Gm-Message-State: AFq9FYJUUKLNtOJisRYf/A2n+vTDhTXOrGGf5SfA/6Yph6hHtbgqio9t
	oZ9Fh4p8ewg+Ildp15sebE6yIEAv+DpHZ78OpyKaNW642KkRF1JCpdytUZJIDg==
X-Gm-Gg: AYBFou2x1J21M628IQNXohpc5fLmqwtiAdkTbndFj4vKXj4TaVZ82bTzFTzuFmVm3Ib
	f5v9onyqGY0CbUpvrzefk+KT5RB1S7QglYFTibWpzuVK+30hHekXGZOe90LZQd/TpjWQ7qyN4ky
	4CVs0BP4b+f5bYpjUsCeIvku0ZJdlUEUNRCCF/NoCGuinRMQbHvMDKHzZo+Ot2hGoqUSYQX6TQs
	+pM3GbjmbJa9kb90LfMA4fU4mVqYqV6LCJ9gnvszrNRX5JSzXpxX4zUYw93EQwKLYk4ADuwnOhp
	iCEv9SZwmXjRtDsbUC7LofDcdChkdt68m0rXPUh0SX0M5y4zymvo20AhOUJqx2T4VsIqkoemt8f
	7T+X9p3/9uUyLoEVe4bSe8uNdRgoqouAFBrI2zXimpsQvzhcUbF+baw+xquXLRo6Kf5KTay3Ehd
	J60ZkUfYVUNbWJDojUn2UazA5XgkG8v2dCrNeXhBItmSew1/BD2c9PsiRGaY6pOpW7picOKmIVh
	nZWPvPBtot6MtsV2w/CjChvzw8pAortJg+j2xebyNrzsVlDfJtiHVFtUGCeVKGkO4ylnQGD6DRf
	bAxMm7I=
X-Received: by 2002:a05:693c:8814:10b0:361:7ab9:479d with SMTP id 5a478bee46e88-369e84a69bcmr9891534eec.27.1792999876182;
        Mon, 26 Oct 2026 00:31:16 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ff5a4d68sm8190664eec.14.2026.10.26.00.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:31:15 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/2] unit-tests: ignore --long-tests
Date: Mon, 26 Oct 2026 13:01:05 +0530
Message-ID: <20261026-ks-unit-tests-ignore-long-tests-v2-2-fdbbefbd19fb@gmail.com>
X-Mailer: git-send-email 2.56.0.99.g5a7d1e8045.dirty
In-Reply-To: <20261026-ks-unit-tests-ignore-long-tests-v2-0-fdbbefbd19fb@gmail.com>
References: <20261026-ks-unit-tests-ignore-long-tests-v2-0-fdbbefbd19fb@gmail.com>
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
X-Mailer: b4 0.13.0
Content-Transfer-Encoding: quoted-printable

In the same spirit as 9faf3963b6 (t: introduce compatibility options to=0D
clar-based tests, 2024-12-13), we should ignore -l / --long-tests passed=0D
to our clar tests. It may be passed along while manually running tests=0D
via a command as follows:=0D
=0D
  $ meson test -v --test-args=3D'-ilx'=0D
=0D
So, ignore -l / --long-tests in our clar tests.=0D
=0D
This does not show up as a problem while running our CI as we enable=0D
the expensive prerequisite via the GIT_TEST_LONG env variable.=0D
=0D
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>=0D
---=0D
 t/unit-tests/unit-test.c | 1 +=0D
 1 file changed, 1 insertion(+)=0D
=0D
diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c=0D
index d066c8a4c8..06ffd0f5bb 100644=0D
--- a/t/unit-tests/unit-test.c=0D
+++ b/t/unit-tests/unit-test.c=0D
@@ -28,6 +28,7 @@ int cmd_main(int argc, const char **argv)=0D
 		 */=0D
 		OPT_NOOP_NOARG('d', "debug"),=0D
 		OPT_NOOP_NOARG(0, "github-workflow-markup"),=0D
+		OPT_NOOP_NOARG('l', "long-tests"),=0D
 		OPT_NOOP_NOARG(0, "no-bin-wrappers"),=0D
 		OPT_NOOP_ARG(0, "no-chain-lint"),=0D
 		OPT_NOOP_ARG(0, "root"),=0D
=0D
-- =0D
2.56.0.99.g5a7d1e8045.dirty=0D
=0D
