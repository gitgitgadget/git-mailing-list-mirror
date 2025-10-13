Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB7259CA5
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380412; cv=none; b=DijUznpSAo++leJLalKYVfBPtDnMviMPt/SBGN5OgpvhXFg35+Yx6+WR8tIgagqKWOnf1Ro5ePPhVVxhOgcBOWBz2w1TiQx0bTv8lXbmwI6KYzquSaUILuGWgXdf+hH1fcSfV3PkA1nrf4XVTcs52ZhVTe+tvcdwNXZsbKUfFJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380412; c=relaxed/simple;
	bh=V55hLMVPP7bbb+jEOAa6Zr+eIjYLIVy0gaSBOJmavk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ht7OlyZ9HZeh2+2RC7lBgKhLbMjFnKxgrUavtAoBUjQxxNsGp+yaFvRASCIY5OdvqooPwjB7ixysvfAAGmYA/zKFt/EHuLK5qhSeawteu7PZELnYTv5AXA1P+n6SikPyHvuUjJXalmfJEZVl3bp1A3xCw7f3/DXHI9w69b7FeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpYFvmAc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpYFvmAc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27ee41e0798so72797485ad.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760380409; x=1760985209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLPKM5OL6K06fyN7V+5EbQUDXA8ErWWZxpx+2mpEdG8=;
        b=UpYFvmAc1KRft3ZGP1eyfiEPxbTBg2g+JGm/XtiNRjiiS2yqO2zO+EXJJb4yoSZ4+X
         xWegqCA2IZ9EbxPPSXf7wBeTUuh8t7smN8/3y8HJgIfVhfMcIEGB/L0B5NA+fMzmtREw
         A6bMVdvqQAm/lj25Yn0VnZw9uE3gvGBNqC0o8y4wqgOJDXCkfn3mwp/emoSwzLjtyqTU
         yU811BzcRyRK7fIXhqGehnCGFYd2J4MdiSWfPadIHY46HqfzIm5ZnTQ5p+3Rd3q+5zDS
         td0NMIU/WBOhwTF03MB3UADopGzWU/PQK0pWNjbbMmeX2CfSjcatenyFIwZLysO9lGPj
         ugWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760380409; x=1760985209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLPKM5OL6K06fyN7V+5EbQUDXA8ErWWZxpx+2mpEdG8=;
        b=JPr5e5N86/QgLwXt9OMjdDL4C07QWQTEohgvhRx1yWvenCtJsuayNDhd/TbuHL6MNL
         +Yd/bZmIbCJAnsi+E5xXUxYArQDZJBED3fAaiOurcp+FPvXEMOWNPvtC99BxFZyJZ4jd
         MDulBuRVahi5pqHEBznkCAc98Yx8hfyGE3j5pI7+1e71zysvvycvoslgps1tTXP+eHg1
         r0KzYQnStmaspPVNWRKyY4+vJA1yPIVwlvPI9GBj/cWUApC6utnTU2LbPH6L1ckAMIMC
         bePaTuEMGbF+dJD2iOWAVjsZO/61uoirYXrx/77JxFqXOhQ5rB4wBK45XkxTE94tA7vh
         Av1w==
X-Gm-Message-State: AOJu0Yw36ueqyMm+XyMweP7yjlsas1RWefMZEm/acOG1M2ehxWdflJzc
	oORvQp89CGynPUQNNThMTkvx1ZTfDjK2V4iuiWjvKtAYcLUNLNzZhCXyKQWdLsN02KM=
X-Gm-Gg: ASbGnctHfhIncnxE93a8sGPaHVXJDOO56NQVW8LsuhQ3LBDCizVQhlTkdlcs071GJuN
	SG6WOuXtxnvQRqjftQtIRuxKzLCNFW9eW0bjJETsQuNRMwbPkJNCWglT3DZtgsCMosxJ7RHss0B
	taPXLESZqiWaxqkbJZs6rGAL1WKFZvIeInlS6urIRyMqoT1Z7ouQiggdjJelUMcAHwErdrMRQel
	G3NNlmM6yf9RdiNzod6u0dZwYXfwu24dd/+lhV4NhDXN1c1kRjCIo9epSDplUYpDp5qvt2z+Z3V
	/1fLIBL5TSxQe6eniaxu4WpxwJheRzPeV/ekY41mQ2vB6DPFqPR/6lFXjxb8f5qdGkCWJt6vqc9
	7svRgKWQcfFVzbs9BsJaVhrkKNcI52k7csSCXAvwUCk6vWOJKJSgNCStmJkI/tBLu5wL8K4kMZz
	v4shL+kzM/nKD/DgsSOI0vn+Z8x9nWgAEWxab/czaxx0I+4v2bp4iO45gqQbgdfi0QYyyCug==
X-Google-Smtp-Source: AGHT+IHCRl9yWVv4l3Hi4DCmOKDsDyW6k75VtxbSbghkBkiFVVGFX+5FNC3DIpLpyLUdLhOoXLnI+A==
X-Received: by 2002:a17:903:3b86:b0:28e:7567:3c4b with SMTP id d9443c01a7336-29027373b18mr321885805ad.16.1760380409572;
        Mon, 13 Oct 2025 11:33:29 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:56:dc83:edd1:7853:510f:d37e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c70sm140019905ad.13.2025.10.13.11.33.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 11:33:29 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	newren@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 1/3] replay: use die_for_incompatible_opt2() for option validation
Date: Tue, 14 Oct 2025 00:03:09 +0530
Message-ID: <20251013183311.33329-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013183311.33329-1-siddharthasthana31@gmail.com>
References: <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20251013183311.33329-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding the --update-refs option, convert option
validation to use die_for_incompatible_opt2(). This helper provides
standardized error messages for mutually exclusive options.

The following commit introduces --update-refs which will be incompatible
with certain other options. Using die_for_incompatible_opt2() now means
that commit can cleanly add its validation using the same pattern,
keeping the validation logic consistent and maintainable.

This also aligns git-replay's option handling with how other Git commands
manage option conflicts, using the established die_for_incompatible_opt*()
helper family.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 builtin/replay.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 6172c8aacc..b64fc72063 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -330,9 +330,9 @@ int cmd_replay(int argc,
 		usage_with_options(replay_usage, replay_options);
 	}
 
-	if (advance_name_opt && contained)
-		die(_("options '%s' and '%s' cannot be used together"),
-		    "--advance", "--contained");
+	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
+				  contained, "--contained");
+
 	advance_name = xstrdup_or_null(advance_name_opt);
 
 	repo_init_revisions(repo, &revs, prefix);
-- 
2.51.0

