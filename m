Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAABB276028
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004902; cv=pass; b=lnd4Y1R44WU5tWaMUPE0rXTpmZvFCMx7RhU1OTtV1zsGdeF5VUmFGvxxBcmJFiRe1jg/sx0hViSDiRDJfXgbXY/UNkO7r9h61YWMSaunogQnDNoj/JtHvo4crOHKQNSn47rX7xtjzsH963C4V5kEQM+OYOdG+2ycwUfRf5+5Gz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004902; c=relaxed/simple;
	bh=KA2v4IdnJ/jlZdpO/UFNoPyRyQ+SCfLCACs7h3kJf7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFst3rQkQPu4rDRXiWY4oDqbWHZ93qCCoUqzxVcLcRgaDvX0SW/BaKuSMih5CJKGwghIT3JbyIhHSPf1MyFO0VrULDsJDtsAYOxSXhCW1PJTFGu27Z5AYx9Jt6KX69Vs++XUki8Jma+RMAf3l4dw0s7XevCMxtZcZPrfi1LApzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=GR4VoLrJ; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="GR4VoLrJ"
ARC-Seal: i=1; a=rsa-sha256; t=1764004891; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hJPpNXGwd1c836681/AXS6iDRZ31hKfsYkgYaFzuvovBX2bUGSAMs+WPSv/Rz62IRY1z+1E+egqFRRwiCMYhLdzYmea9pAcIofBQR+cHQE4NHoIowlhVYx96K2d6ikvOG2SeVaOkvtnoKU25WFqSj0AMAcrNazuyAlblAkxY0VI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764004891; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cdYpvCKhX4+w6z1VOhxX4OJrQBQr0WldIyfRNGSgEjM=; 
	b=bQ0xsDASkCdKiPD1mkbePiYtyhhmtbXAmEq62UjXiTIOm/9hbq+iiSeX9DCXAe2ObS8bv1QDwDSXXJdgZ+QEBoo33uc+OJG1SZNjtv3T+5q3STmvb6E5m7i38Ob7s8UO94seE19joV65xBtCBxiYStVf2V/WFhdQs4N5PCmJ49w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764004891;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cdYpvCKhX4+w6z1VOhxX4OJrQBQr0WldIyfRNGSgEjM=;
	b=GR4VoLrJU/pcxcTdFVxjGbZ5DjA3/BPKUHL5pKWCUp3QNRucv86ohev/6oFFJUc+
	XMZV2WPzo/iIpxGRmC5qZm2Xc+6qGqTNdukV0gHbO0Uy5Ac8UqzGYlpUKx3gSkzEM3c
	p2AYyEzskbyKhqJR6EQzSXCwwgKYP+cpExPy8hB8=
Received: by mx.zohomail.com with SMTPS id 1764004880486160.6356643271249;
	Mon, 24 Nov 2025 09:21:20 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v3 08/10] hooks: allow callers to capture output
Date: Mon, 24 Nov 2025 19:20:41 +0200
Message-ID: <20251124172043.1650014-9-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124172043.1650014-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251124172043.1650014-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

Some server-side hooks will require capturing output to send over
sideband instead of printing directly to stderr. Expose that capability.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c | 1 +
 hook.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/hook.c b/hook.c
index 89c7a7a9cb..4ca6ea36b2 100644
--- a/hook.c
+++ b/hook.c
@@ -152,6 +152,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
 		.feed_pipe = options->feed_pipe,
+		.consume_output = options->consume_output,
 		.task_finished = notify_hook_finished,
 
 		.data = &cb_data,
diff --git a/hook.h b/hook.h
index dc9eff1e57..1df604f0e0 100644
--- a/hook.h
+++ b/hook.h
@@ -80,6 +80,14 @@ struct run_hooks_opt
 	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
 	 */
 	void *feed_pipe_cb_data;
+
+	/*
+	 * Populate this to capture output and prevent it from being printed to
+	 * stderr. This will be passed directly through to
+	 * run_command:run_parallel_processes(). See t/helper/test-run-command.c
+	 * for an example.
+	 */
+	consume_output_fn consume_output;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
-- 
2.51.0

