Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC66395DAC
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030992; cv=none; b=jTKmvb53MSJ8r/U89f5Duzpsns30uvgM42mi401BgAlQO6xKyDVVhTLOBpk78Jmr4ZRQQVaB11L0njWB7EaG3cgRkMBigwsBZTK/8GSQxS0Q4ZoIFwhdy/FzK8H5FRFEDRqA5jYHikOYlS0uZpSwMvEbuS4FCB6t5mRXUhAiZ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030992; c=relaxed/simple;
	bh=dHJ5v+flstXJg1b4fiPgGpXAxz73aDHe48Jklc6zTcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0ySbTx/tzLMuND/M/ove6+qbL+X+ABk8RHqMcIZAz/t1L2LlE6dWTsS4UCVi4myW/TYzw9SAPaX/cNgibHaliXTMQhbU5mBAVVZoRWQ/F/EXQ7CMj4I9c3ygn91xZLy76bK5g3xMOGDLjdETSK6SR84K4HxxONOF6osllThTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvROyNzZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvROyNzZ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so861799f8f.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030989; x=1784635789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J5dPsCSw4rc76QWSUkZ/YN6TiycwnxZYRqoysQs1ZJU=;
        b=KvROyNzZG0huimiPzBnWpjh1cQlZMJu/TmOsB+8FMFcuHp8kHyf20qk6HmuJnxSjxM
         o11T2KJ+ZXqbTLDqqScQlDIr7uYmdowtopW+Ibm4h8lpa40Vwv6jlD+7qmwE559JVWy8
         6JJ4dlwE1nQdfoAK/RmnWzn0MQzzej8FK5EdE8EYYHrYQ6iQ7DF0UIa4keRCYa/9zfmG
         CQlSjqDEpcoiWe7sWqKgxN3xRshTNkTw69fAdJ8k2UlOfTaFNYu/RPY3+GYJJ+Tv3XVS
         2mzlM1w4hy6A2TZn44L4MZH3KzzqFAZD9SrXl7sNQ1KG8Jgu0tf0BAFUuG/YbP9o7ChM
         glng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030989; x=1784635789;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J5dPsCSw4rc76QWSUkZ/YN6TiycwnxZYRqoysQs1ZJU=;
        b=ln9sJBr+MMkYHSzfxf89YblhSWdWvGlsqmaXqZc+DezfFa7TqLrpqIgUy7axsqFmUZ
         M2/ZfgrYKgFClBdhy+roigCqH2eYShFZjn61UIMQqmMH139f99tTzrpDK4wvqJw4ZFbQ
         qwAVrw+KSBR9kHKzilDpQmShpzfADe/5Aoj3LEHeGdFPmHtoGlPzyC4c4MSEhx0PEPXY
         HGAF7KanhgazjJiu9PlwSIKjcD786Qynkha9JtWXMg/tzOeKvOmomnP+Racd8Z8vR7gq
         VEjZpGjC2w4m/hfNtxVaOIvcM1wW2kFHSRtJq0t6PGsiYuvNV1NWjjWLOwZH3XKBfIMF
         5fEA==
X-Forwarded-Encrypted: i=1; AHgh+Rqbysc76AT5iR+DlTcmiVGkWqzPmUDC06zNexMAYlDRPNktYdmFFKsPKXUZLKH4r+gvNKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZd/AktiL8RYILREctEbUxBpNqJu5FDAqdk1JdogscrN8s9Mq9
	ipHDzPaWuXy1Juez2J5H4PkUtFpV9WLJX+ZMhd6Hm0KJ9T1jOg2/2Ywp
X-Gm-Gg: AfdE7ckI5JLGFRhe9wXDSeIXxMQBwWnB6CbZ2ljdFykmLMVg9+/6ROuQpq/TKbV2V2F
	qH3SHBlXRaMXWMtDAhEXTAOsENstcDLKuV7BHiN/yzWcjpa7HjMNcCtHUlEsgJMIJhOrM8ogx58
	yLicZoUegvypJpBEqREeB4IqKAOw5VgViuUbvUzcUsU+a1wEwj8TqbAX3m/U0N4RMYifoCci+q6
	ChR2iNG/iuMMqzxxT6cNWtgyADFbbRkl4dVeXdfio9/YKMNIWT6ajrdW4s1RvNQMFqzPHLkg1r0
	tmTeEHvdn6SmCj5EWBTkhscx+JOTDMwafPEpwxffzi01ZXZ/Iz5B9cYk8U4RRBldAIiNn247OEg
	cXzT4p+pNbpdfZfGUAiXonRVvKNInZgd/i4iAxvMWmaDRoeqZUdBvm51Eg29WJPpOy/8wlQYBIu
	rB0f2LF6CltB9oornMo4gOfgEcaMt8dRoJt/tny2h9eQuhmXiBsr/p0QPWUea5q4LELwIdd+BSF
	py3xfw211oYB1jXzdt8g+gZG8OlRhHuME94pk3YDS/BhqUEt9wGwoCOMWMKKvsiqTiEgAcDLjZ+
	U2lZiTGtQ0HqMWNxkJs+kyrXyq4KJ6jF2FsOu4sNDsDNzE6irpKE6uoa2Z7VUUI98bhLqdt0Ct9
	RA+UB1suUzA==
X-Received: by 2002:a05:6000:2512:b0:470:390c:1e73 with SMTP id ffacd0b85a97d-47f2dce45f5mr17203368f8f.18.1784030988975;
        Tue, 14 Jul 2026 05:09:48 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c89e5sm7749939f8f.34.2026.07.14.05.09.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:09:48 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v12 6/7] graph: move config reading into graph_read_config()
Date: Tue, 14 Jul 2026 14:09:37 +0200
Message-ID: <20260714-ps-pre-commit-indent-v12-6-d50938e006df@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-pre-commit-indent-v12-0-d50938e006df@gmail.com>
References: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
 <20260714-ps-pre-commit-indent-v12-0-d50938e006df@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Move the repo_config_get_string() call out of graph_init() and into
graph_read_config(). This simplifies graph_init() and provides a
function for future graph-related config opt.

This commit is a preparatory commit for a subsequent one.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/graph.c b/graph.c
index e3e206170c..c14be934a0 100644
--- a/graph.c
+++ b/graph.c
@@ -417,13 +417,11 @@ void graph_setup_line_prefix(struct diff_options *diffopt)
 		diffopt->output_prefix = diff_output_prefix_callback;
 }
 
-struct git_graph *graph_init(struct rev_info *opt)
+static void graph_read_config(struct rev_info *revs)
 {
-	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
-
 	if (!column_colors) {
 		char *string;
-		if (repo_config_get_string(opt->repo, "log.graphcolors", &string)) {
+		if (repo_config_get_string(revs->repo, "log.graphcolors", &string)) {
 			/* not configured -- use default */
 			graph_set_column_colors(column_colors_ansi,
 						column_colors_ansi_max);
@@ -437,6 +435,13 @@ struct git_graph *graph_init(struct rev_info *opt)
 						custom_colors.nr - 1);
 		}
 	}
+}
+
+struct git_graph *graph_init(struct rev_info *opt)
+{
+	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
+
+	graph_read_config(opt);
 
 	graph->commit = NULL;
 	graph->revs = opt;

-- 
2.54.0
