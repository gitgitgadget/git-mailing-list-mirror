Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C13446C7
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803866; cv=none; b=Dbok0H4nboTJ5CXLLYQjD5rBFk/w5kSv7SrzP5mrKqm4xQPZY4U7xGfaSwBtP2NHngglokh44aadZgAws16H443i7yhsUa81MqxBkidBLFONGMrhnPpMR5S/IJc3rWOZKt9cvVyMZxKd8VL7UnXxV/S2ynGbmHTq3Fsyqvy7hVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803866; c=relaxed/simple;
	bh=ElWxJvL4rjLFfpxR28cshO3bRJvg7h+Ss3/FQSbpapM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cER8c4NxWbJQk6K+SmN4GGVYtLIRaO9kb9/KJ89NE5LXGIq5iCQyvWyCZD+xzqSzj33gamMPRx7MqCZqHTnKA2Wrh93ekPm/V8budfRTTJTLWUMqYGmHJ2S0dVcfQDttvHurn9c4lUOy9hc0ryjCgI6gv/8gUHUb6szOKSLgrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=LdsX2fbL; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="LdsX2fbL"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so3564831fac.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803864; x=1777408664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=21v91jUopmUrnp5msa4wdZdGn9tPvpfjSKm2WqDuwj4=;
        b=LdsX2fbL2jq/LU2dut0xx1uDGDH9EfdQz6RC0+TdHwbaFRpF/hhku5VjpIzo2RqZxV
         BlJxgwpHCsw1tAeSQP1mn/e2clm1mMPOry/ZYcRHJdGULFOvatKi5v3c7z31TQ2oWzim
         Lg6ouwyZUsSTfPX5h3FGNKi9R57GslEOesL/zLS407cwo95/QWTdfgQVkPKBm+VQnaUD
         EnPNqcjrpkZSGpxQSL3vK+OojMsQfgsc8E6ySiqp2OhsNs1fRrvMGb7WTO+MdkohSmq5
         J4/H002U0aDsILX8YRgGctxz3XpHWqFzXnqjdL420Z9ZXetODVu+Pbfz5KT364Di+fgw
         G0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803864; x=1777408664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21v91jUopmUrnp5msa4wdZdGn9tPvpfjSKm2WqDuwj4=;
        b=ayjGR45phivjsz1n7AKWJzNeKEoJciDaqzV3mGi3+TxXYm1N7nRqdZLM5UoPup5dws
         P+iHgUkAIdvut2vlnzso3BTFcVG1ZGOcxQ3A/4d3vzeOG3Ozz/9wcGUHFZpYITtenxgQ
         8ctk+/pWcaCe9FO11MSeeo/6CBVCHVtH2zuNnPZzehlwQHMxSxTQgL+RevXrE6RQbjnt
         HMO9Wta+3tDSViih7pP2Uj2K99+ISxiYgk6hc1UTR+nRjyoNLLWxnPcrZL8fA/fTr0eZ
         yPcBhyIf3FoiKm+H62rwhdF/CpmTV+qkGNTyBuHn0MQpeNcianmUF8fDYYi+J+oVyCK8
         7VPw==
X-Gm-Message-State: AOJu0Yx0H0WzwjcoupHPDGpF8BYUJkX5KqJLTPh4qZfQ5nzE++vNbFgr
	e7PPdOagRxkMrKZwl1k+Nwwshxk34np8VV3lAOqIhfy0rDk43kSmf2/9OfyZpN0Ucc333OkuNqL
	31IlR2Ww=
X-Gm-Gg: AeBDiesfDICvu1UA4n6yKB3hUCNkb7hced9eLTD3JrmJOE1dI8fY2cRuiV3T3QFMSLo
	PJOSUuCCmP7B72OYFjQ+g9Gxt0bznGfIKQxjk5d7FK9p9pd/q0a75urYxCOjXnmvUe708l8/kBA
	cjsaejY4sKu29/b7iwWrMmZD73PjMwwoEhRAE5L3VdrqAYzGsjNjrQghj9rCEdW6skGtAJ1CHBx
	ybi2lyadIychaZG+SGdwm79WTisa2Ypx+QpSLDs/Vxe9urVAG0KKOr1xuczCADqzkrTexkhueNN
	kDcvrlzCHCGEhJRKgqIVW6U+gj40E7esi0Xf/uTv5ViaonUPV91zJfvIJ3BOjSMl0KuWNsHoaAr
	rVAMNMGN4y+ArGk9gIssK75qbEBa4DRXoQd/WashzUhz9kUnsCQVYDs9XdAfmKQ9Llirkdb7p77
	XQbB0VoXzgj7xD19GTF6e0KMceQD2i3irYjzVkIDUfMMMOId9NVIFrYIdBCCLZe4KCGE8AelHnP
	KFZFAb7okZlxENjNd3a9yps5fWupTTKNgtCL18nxPr1C7neQrtbcQTYAumqw+fu4nYg5MWxcZ/m
	zaOQsFMgDjFjZOGUtLCzZbeLcCs=
X-Received: by 2002:a05:6820:f003:b0:694:6e87:2815 with SMTP id 006d021491bc7-6946e873675mr8190085eaf.24.1776803863800;
        Tue, 21 Apr 2026 13:37:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42c05ca16e2sm5327413fac.15.2026.04.21.13.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:37:43 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 10/16] repack-midx: extract
 `repack_fill_midx_stdin_packs()`
Message-ID: <44f522ea04df5176ec332b60a38d1eab9b649c30.1776803827.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>

The function `write_midx_included_packs()` manages the lifecycle of
writing packs to stdin when running `git multi-pack-index write` as a
child process.

Extract a standalone `repack_fill_midx_stdin_packs()` helper, which
handles `--stdin-packs` argument setup, starting the command, writing
pack names to its standard input, and finishing the command.

This simplifies `write_midx_included_packs()` and prepares for a
subsequent commit where the same helper is called with `cmd->out = -1`
to capture the MIDX's checksum from the command's standard output,
which is needed when writing MIDX layers with `--checksum-only`.

No functional changes are included in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-midx.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/repack-midx.c b/repack-midx.c
index 83151d4734a..78f069c2151 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -292,23 +292,42 @@ static void repack_prepare_midx_command(struct child_process *cmd,
 		strvec_push(&cmd->args, "--bitmap");
 }
 
+static int repack_fill_midx_stdin_packs(struct child_process *cmd,
+					struct string_list *include)
+{
+	struct string_list_item *item;
+	FILE *in;
+	int ret;
+
+	cmd->in = -1;
+
+	strvec_push(&cmd->args, "--stdin-packs");
+
+	ret = start_command(cmd);
+	if (ret)
+		return ret;
+
+	in = xfdopen(cmd->in, "w");
+	for_each_string_list_item(item, include)
+		fprintf(in, "%s\n", item->string);
+	fclose(in);
+
+	return finish_command(cmd);
+}
+
 int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list include = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 	struct packed_git *preferred = pack_geometry_preferred_pack(opts->geometry);
-	FILE *in;
 	int ret = 0;
 
 	midx_included_packs(&include, opts);
 	if (!include.nr)
 		goto done;
 
-	cmd.in = -1;
-
 	repack_prepare_midx_command(&cmd, opts, "write");
-	strvec_push(&cmd.args, "--stdin-packs");
 
 	if (preferred)
 		strvec_pushf(&cmd.args, "--preferred-pack=%s",
@@ -350,16 +369,7 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
 		strvec_pushf(&cmd.args, "--refs-snapshot=%s",
 			     opts->refs_snapshot);
 
-	ret = start_command(&cmd);
-	if (ret)
-		goto done;
-
-	in = xfdopen(cmd.in, "w");
-	for_each_string_list_item(item, &include)
-		fprintf(in, "%s\n", item->string);
-	fclose(in);
-
-	ret = finish_command(&cmd);
+	ret = repack_fill_midx_stdin_packs(&cmd, &include);
 done:
 	if (!ret && opts->write_bitmaps)
 		remove_redundant_bitmaps(&include, opts->packdir);
-- 
2.54.0.9.gb905fd5d0ae

