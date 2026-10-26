Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999875;
	b=UVr7Vvyino4ATfwqCDKDHZCfvoHzcIV7pIS98UkrM+gm+DELbTtHLD8QR5JvnWPuIlEO
	 HSYfkKv0CnmS+Njn0T3l6rYb6RjmeCMHO/A5xO9WPwDSWzSMX6cRtkVqutliS9ym2LPUX
	 otmVN60L2FlhDmy3XXjwffzz4xhVY+2TuYmuFPsCycRbpX7xO85Eh09zeFEoXJlBahgEF
	 EyQbig8NbetkglvooCpW3v/I/OvVui6iK3QLretkNx1HFR85PnCxLApyxdjhpke6X0w1G
	 wzRHVBreQ1iO1MKyBIj36DlWGvI26IXIgNt0LmjF9l7HFuSI7n2dhBoV+OhxW5tSAtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Mailer:Content-Transfer-Encoding;
	bh=OI1G90ezTgkCcWqLwBtF4AirykJWzYiu8xv4ID+dXj8=;
	b=Tse8Va1InWF5TpUeddM8rF3h+O5uoA2I/+PY2c+EEa5Fao+EUaOfwKKy+AUBItoOvoY9
	 FORF/3UDt2yhfW+HhhktkwhpqcWFmVJKnas1dy58OD97Q2pBCouSstgfUrbyWeqwCOZgF
	 U/yh64Kb9qeJQQPfKgDEvcivkP4Gxn6uESimcV3AiYwk15smZciv8S3jWDtnE3jQZAHc8
	 N6SDDEMUGVHYaMLHdLyznYqkJedRPWfqX7MLdBZA4NdreCTSpU0YdVX+G2BJ1BjzO17RB
	 m2qgV4rtPcDezPM+46Iw/di8nPlZD6YEKM3PTjEx45sSOYwJi1nkY7V5+aN5Dn/Issw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QFt1fgj+;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1A606A326
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FE1A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QFt1fgj+
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33fb4680717so4824301eec.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792999874; x=1793604674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OI1G90ezTgkCcWqLwBtF4AirykJWzYiu8xv4ID+dXj8=;
        b=QFt1fgj++JNxEvS1p8u3HfQKKL98+fjS/9GsD7NS66YcJjD7DZXHNf0azL2nRWFVAO
         2Bz5QJIk0eDdLnq7VouKppseIstm+hv0HHuZe+Ph4gDBoOg7SH2u3IZe978hjeNbS+up
         0qmrqAJCgJ1HR0VhEl4kIOeFuOJgTqlww61IxGuG4OP3ulc2lQVVgGEf6BGJBTyB+KNU
         XDua8Jvjs3/TfQMUz1U0DDYA6Pb9MwA9prXVAP4MLeS4gI7atJf0FRGph5NBwbdiw6y7
         jYg2DbmavaSB5+FiBZFAAC5LaLcfwlzoWC7/NqOE3nYeziTrj2X9adCJP0io49Y19N5t
         2uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999874; x=1793604674;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OI1G90ezTgkCcWqLwBtF4AirykJWzYiu8xv4ID+dXj8=;
        b=y8kmYNDSxCyxghneUHa0Khw6fUS1nHH3IZa7VAPvydnqfIQfAv+rwIHGwVieplamrF
         XTHLDjoPOcWNUfqLCNkmgRMH6MorOm4JbdgG/hUVCVhgyw+SOQu4a5lrfoghc2KDFv/6
         2GZG1vFndyFFCWZzgbvw9C5QBjVgk+g0yY2XZEt0Q7o4pd1Y4qeYVMdxkywkOjLPlmxu
         +5d0gNVwsgJxVTCLMzvnBUic4FlFfuIpn3y1YQX0vKwcD0htHNK3ASO/LanLuV+4ZjJ+
         MF9oTQcdGi/IzIRQ53v/vesyJUfkutd9WGjCvnYv3ovE+acYEvEUt2lgTQMRpyvLxDyY
         6OFQ==
X-Gm-Message-State: AFq9FYJL9DnB0XFVorBXpiORAsvkhRGNcLifBK14GV6ee0qbcwy3nA0p
	O/l0UEmtpgfidxJb3dyWpLOZDPYAGfY14PGuVHwcWTpIkywEOBkambXbc3zBqw==
X-Gm-Gg: AYBFou1dGSFMxZLFYO5crwRAsPvh033mKQmfWQkvdBSaO998mLlnhti0/eYFGOUv67E
	Mb1Yz/ISMxDqcGUa8q6uUGCfmWHe1r6mSQzrohfkZ9Mpx+SmexWXeJ8Ucd4YPdO7sOLRQQkKwiH
	FvUBFb0zM9/A2qPOxGUkMrCVcThQQNHHrRE0GicnbyPGDbmpydkgY7HD3qv44lOVUp59EKAdRbl
	jkD2DbeQiDSeuIJL+gXVwGM6MszIOm2RGtUNK2uKAp2nQyg3qYQDZC7AgOmrzbc28wTXpQMVovJ
	IyZzQaCs3VRs4RPQzOd1mTipnW8azkiV3++RgfnCbw258lcIL1XecQx0tFRelD/rB9Q0VtLcc5K
	wDL5JScmZH54RTbcQOeqCLZ9Mh7X55VZruLhv4PXDdB9a7lICytC3BDwpBVwX6vhoq0/R/amV94
	C0kngggL+cmPMJaP8zphpN3UQwyYjuLtT4POeV4aD7xhJ4Q0OsjLjdaZlQuo6VtOdphxTZqnH4J
	/tbhCVxg32dbw9+6korssTunds9XbOzEMvbVHKON8ZWIQV7hrT2BbJdBXyEZKzwbn6MD5e0JTpd
	OwJsqlFW
X-Received: by 2002:a05:7300:80ca:b0:369:e918:3c95 with SMTP id 5a478bee46e88-369e9184604mr14978558eec.4.1792999874097;
        Mon, 26 Oct 2026 00:31:14 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ff5a4d68sm8190664eec.14.2026.10.26.00.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:31:13 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/2] unit-tests: reshuffle NOOP arguments to
 maintain order
Date: Mon, 26 Oct 2026 13:01:04 +0530
Message-ID: <20261026-ks-unit-tests-ignore-long-tests-v2-1-fdbbefbd19fb@gmail.com>
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

Ever since 9faf3963b6 (t: introduce compatibility options to=0D
clar-based tests, 2024-12-13), our clar tests have a few NOOP=0D
arguments in order to accept the same arguments that our integration=0D
tests accept. This makes it easy to pass in test arguments when both=0D
unit and integration tests are run together such as via:=0D
=0D
  $ meson test -v --test-args=3D'-ix'=0D
=0D
On a quick scan, the order of the NOOP arguments seem to be=0D
alphabetical. That is only until you notice that 'with-dashes'=0D
appears out of order.=0D
=0D
Fix this by moving it into its appropriate place thus ensuring=0D
they are in alphabetical order. This makes it easy for future=0D
patches to not worry about where to place a NOOP argument=0D
that is not yet in the list.=0D
=0D
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>=0D
---=0D
 t/unit-tests/unit-test.c | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c=0D
index 752fb38fb3..d066c8a4c8 100644=0D
--- a/t/unit-tests/unit-test.c=0D
+++ b/t/unit-tests/unit-test.c=0D
@@ -33,12 +33,12 @@ int cmd_main(int argc, const char **argv)=0D
 		OPT_NOOP_ARG(0, "root"),=0D
 		OPT_NOOP_ARG(0, "stress"),=0D
 		OPT_NOOP_NOARG(0, "tee"),=0D
-		OPT_NOOP_NOARG(0, "with-dashes"),=0D
 		OPT_NOOP_ARG(0, "valgrind"),=0D
 		OPT_NOOP_ARG(0, "valgrind-only"),=0D
 		OPT_NOOP_NOARG('v', "verbose"),=0D
 		OPT_NOOP_NOARG('V', "verbose-log"),=0D
 		OPT_NOOP_ARG(0, "verbose-only"),=0D
+		OPT_NOOP_NOARG(0, "with-dashes"),=0D
 		OPT_NOOP_NOARG('x', NULL),=0D
 		OPT_END(),=0D
 	};=0D
=0D
-- =0D
2.56.0.99.g5a7d1e8045.dirty=0D
=0D
