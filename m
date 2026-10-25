Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910152;
	b=mqStyueWOlaNHPu8EGCQ6y7jsyxp+eXjwprQ3dWeNCi6Gvmm0ni0GsPpgD5oI8+pmX03
	 m7oDSd8e9C1P9o0zGUblQoTodk/tOnp01JoZ5ndCTDHI5woyCLsz/t9D4i1I4uT4wQW/C
	 XawTDKdTRhhA8HYiR8S+Z98W5qoqgDXm/sshVuITCOAY7+ZSyW0vLrZbVfFiNUkkMD3gb
	 aC7bQ1rLN0h75WIkcuqYq4WLlxOA/PivGF8uefSsBkKMFftTmEdC4X/oWE8os/MwCFkbC
	 hjOWC8ZeVD+aDOpKkSfldfzTP4QhKg0bS794+/IdDwSpceN+UhanEQXjfKAHVcVEP2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sqllzQpnSXM885vnUUOktAkb3O5P1CclbvgGH8lrLKU=;
	b=4XkVSKL8y4ausmP7kbyLO/2O0Ud4u/v/HYEbxCWRs9sfJuW24jKrBITWkKIR/zlKHPgn
	 47bhJhb85E/UDSBszrsaIHqj3bTjOz9oHb0vwDWoqOFuToHq421GlWnA6BUtf4ZVkbMRn
	 CXMz5I2qTvF9hInlxRM9ctkQkM099nLmUTRj4wCuLp+U+H7CMFbrlq6tYt/YtvncVUxDQ
	 CRdle6aiDoMXl8pFSAUap6jTgetAHdF0jwXdAj1tXWEZAOA58Am4WBsFV/v724K9qH3AK
	 hVvKtn8unKD1XPHkYalmh3df8NNcAKyXfXgFRFzF/teY5dHnuaZ4shZBotI/DNWtnEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tylercipriani.com;
	spf=none smtp.mailfrom=tylercipriani.com;
	dkim=pass header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=XMlCPz5y;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F3606A31E
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 06:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 100F3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=XMlCPz5y
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6cfed5dd083so1424995eaf.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 23:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1792910151; x=1793514951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sqllzQpnSXM885vnUUOktAkb3O5P1CclbvgGH8lrLKU=;
        b=XMlCPz5y8G2a/3+IrTMWv8oSOOr1Oow4/168dRsRTg5stCCyQM2dkSWGiwCSq95nAM
         FO8LkLNGasAlXhQ8GFqfQeKDQuQmFP65/sGyqVSaTeux5URuluiDfaQ0At9n44SeRybi
         Pb6g5o+eJlXSk4Rz681QaDlKPo7E41Fk5lKHOpQk9Vnkd6nJwHnQbZf0woBv8NnKY5Ao
         I85rdwyP+rFq/thY2tGUmJWRdMlgkMuMbHitwkRnMvMCVL7Bq0y+VcYQ3pA9DEr/OA6v
         u5IO1XoNjZx42ex5fc6Z/MiHXtKhaJWZhOKKmv6VeUhR/3qbdWDSoKRGsRKerGwTGx/p
         nIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792910151; x=1793514951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sqllzQpnSXM885vnUUOktAkb3O5P1CclbvgGH8lrLKU=;
        b=RatAfrql/SuhrMqqGLFROcyAZYEW/WT8FoPSmQnspZdtbcK4bq72D99x7ARCNdssTm
         arEhRf+8Rwy66d0LD7OxUgNJLeMFh/K2Yb6F0CZPdhveGhicg4TV8u5QNWnFYeHcUbwJ
         V1s0jrCURxVCckHIyrw/bOb4kNIQ+aq3KTIUN2ZHMZAOtGERDewYepQqQ3M1PS2FKWSj
         X8L+qAACuKp16SjrLUR0tg9D0fPsF3hQsFfHs+/f0WwhHYNDNe1P3ZtW6usZ8DiDTX7b
         9R1WKCTlLXNh4ljKAbGfrYZwlniWabJ57Ncad4YfgACr8+oCqebgQq0iZjH/kRERhE9L
         Vg2g==
X-Gm-Message-State: AFq9FYJUj5M8zWsu+rv2ZBrgRatC7uHzoLMnIQ45uiSy1FrFmXyprkI6
	wCLNAicrxl2r6fZTxvxpVlxaxv3lTS5P9i5rfWxKbnqtTVgocF8C0eYN/Vlhtr7Rc50utE0ZiCT
	BjgY5
X-Gm-Gg: AYBFou1Sq1CXZkTZ2CMFKLSXXNhEWKCmlIULOWgqWuXQawJwBYufjiP5mM/MVbDsj94
	BfIzL0mtrXlsqS71xCD+8dqPhQ2u+ozymrGxxWs//LwJu/1ZamMPi6tVlKAHU5xV3svkf3GNf9H
	w3xztw0Z2nXPoNB9KPc/RssSXjCSnfrLIJlwtPsWLwjipYq42/fL8YPp9uhJqbm8NxA37WYPs+b
	SdX0a1GXdSarse4pAu8DOqLFw2Y42NRfWUQLbJxvxPMd18hT6tblR9fOxG/qP3x5ypvtJgrCQlt
	qR2L8bkyNwNVyo+2LynX4nlF74lj20dTGDYr5YVlyA4BcoYxMF+0nlvE6YKGOVB88g92SIW7cLn
	QTzdUquw6ZWuof83xrDhkph/cYb1bKNGRiq9fLmZgZGfWJbvflXC9SbVwo5KTFTx+2QDbxrvqMt
	E0+tuLjYGFuT6jIlzX8ftCcjsDDRCRANpISQ2AsqAWaWyzQyACkVwvKqNgzdUIs1129A69ansyQ
	HriBzCVfNMeDVupP2Vboryx5kn0pE45vLUjvfy6uExKQW5rw6UQ4AUElg==
X-Received: by 2002:a05:6820:1508:b0:6e5:5dc5:14f3 with SMTP id 006d021491bc7-70ba0e32c57mr1880289eaf.44.1792910150975;
        Sat, 24 Oct 2026 23:35:50 -0700 (PDT)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-70b9e04aa58sm4207903eaf.7.2026.10.24.23.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 23:35:50 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Montalbo <mmontalbo@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Tyler Cipriani <tyler@tylercipriani.com>
Subject: [PATCH 2/4] t/greplint: skip test bodies without the word grep
Date: Sun, 25 Oct 2026 00:35:06 -0600
Message-ID: <20261025063508.3026136-3-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025063508.3026136-1-tyler@tylercipriani.com>
References: <xmqqjynueq81.fsf@gitster.g>
 <20261025063508.3026136-1-tyler@tylercipriani.com>
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

From: Jeff King <peff@peff.net>

greplint.pl spends time parsing test bodies that cannot contain a bare
grep. Check for the string "grep" first and skip the parse when it isn't
there. This reduces the cost of "make test-greplint" by ~50%.

Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
 t/greplint.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/greplint.pl b/t/greplint.pl
index 23efe27511..68b6eba78d 100644
--- a/t/greplint.pl
+++ b/t/greplint.pl
@@ -190,6 +190,15 @@ sub check_test {
 		}
 	}
 	return unless $body;
+	# We can never match a bare "grep" if there isn't one in the first
+	# place. So we can skip all of the parsing effort. Technically you
+	# can have:
+	#
+	#   gr\
+	#   ep
+	#
+	# but that is sufficiently insane that I think we can ignore it.
+	return unless $body =~ /grep/;
 
 	my $raw_lines = $self->{raw_lines};
 
-- 
2.47.3

