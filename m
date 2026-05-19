Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5E400DE1
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206292; cv=none; b=X7RzE9nGaD3IG8I94T3Owp/B5u6XYmH1pnQL7jXlt8S3vIG0bLChKCcYeV/Kmo4Va5VAGflrfcBMXpKWQ4HLc/AoEYJL9ochYYKIje1K9ibjFkxy3ycBoZRelKKYN3SDQfKDAhQd94B1VAz2OJBxZ6vpgBwkJBRWZhTpwXM05L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206292; c=relaxed/simple;
	bh=sd7Ueajp+oubfCilbbtKS1kEBHLcFPQqOZeKkpabXpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRj341UfoUlfKRslSPokLT/rHE01ZNWbPKrFhzyPMsZQ62wQdhk5J72NQKglMkadKfv9FAkYuBx//3VyFp3UcPNAMOOf+ErOAUjavYLS7tCiZQT1AJAzErtQFXxkM/KisD9zMwKDMp12+8BuRPnImVThUJNgwd5WS6G8p1GG3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=a1Ttlpai; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="a1Ttlpai"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-65c0bda7f15so3787456d50.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206289; x=1779811089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sqrq8xHJRWSuw6JV2Z7LrBv2QUCfyyIxrXzwbaFnEL8=;
        b=a1Ttlpais4TtXDTQZ+C0XW2A6KNIQKfFsGCRezJRTJ5uGUnuMvksCm/Zla+xkiPUGI
         D59Ytgxaj6j0Ct5PyQuTVagiBF8mh2uBb/s2fR7oA0ZW4UBhFh7et4ZiXRYFREiKhrWp
         iDJ05dSfM9cx+zfAgmxpU1E7EIVLcvneEQDObc5qjqzqelw7vf18zqljR7uhAlAcoh2w
         QE2xct2mjLoCDYK4K6I0tT0yZyWtofq1hvy3c35XCNDst8YKpjRTypTOYL7lLtT1gjYW
         cphnbQCemz0isoAaADtllKnfqiO7okGyM1uaH7I1ouJJFDTntfFL7CIvyKNpQ71KJURd
         rK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206289; x=1779811089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sqrq8xHJRWSuw6JV2Z7LrBv2QUCfyyIxrXzwbaFnEL8=;
        b=JfXvhs080pTQYVaXIt2V4bbOauvv003haZX5rQdfhgY+bocpLYgiaRm92BrS5H/U0y
         oc1MnzixskntOmKzhUl/v9VuPfgOvX4nq80IzQx5tJRqM8179Xig1QdL1qMmDyDWpl27
         i1sdwAfYndv4YmUrXu777Qi6I9c9thBt+p9Z1egVAA/pkq34h69/OkpUrH2mmtlfzfOB
         fI60y0JWIfD2gXH3rwcHqLqBsdHM2XTvtirtpAoEEa9xCJzZl64M8LvGoCT1V2eKaxTT
         YrMz7w9KYvjc+pyG4qkdYUahkbaswDAI3H2WZ3FAKWELrWXYAr5f9gHHlpPp/7pEaYoe
         FBRQ==
X-Gm-Message-State: AOJu0YypJonUHwt6QFGrLLtlY/IFfjzRLzG1IaVoZiIlae4ZdXhBTudx
	xGMfyOoJIqFknlcRCQf5dlZK5M6jCv4mPwbJcdboQqsDnaVELDqJeA2SCH1VVvW6IsMPwi2hItl
	XI1OQ2NPHaP1g
X-Gm-Gg: Acq92OE3p+UX3IIR+bHm03sQsS0KELpFGbtcSjEPJ6Ea6QWI4BdYSXXFkrem7FfDO5r
	ptoihI9b4UIs+gIF5xFr2VTd8g4cf6hXzy2bZ/gxdmHVw02EdmHfRYJ5runztM5EHnt+5Tiz2cs
	eJZN4rsXn7gWul7+8vs8APNKboFtjThTj74bgZhYg5XHefYrQfqMZwayiQ1AW5Sxtiv4b7o3ruv
	5Qy9opCusFYpdE0D2Eb28ogGdzj9GhNQXo+078Cwex7G4c9ed0MHDJ7BW77xEiiKXMPlkESm/JD
	lNvu/zqTpzoBnOkKNwG7g9P+8k9WL6PP5NhjRboZp7srxCe0cPFygYlOTjpPzXPOmnSR5f0OlFZ
	41fYaECXGYYQaQ2da+3W/PTo/D33/vvNGFtcdWoJgP26ck6jxtg8HAF9MZxrIAKSqsziI4RU8IT
	q21pmF2iWZcepsySZuBBJ9XPFp+7yhWVAs0o4TnqjDfbgFLJNBEPol2EJXuNUfZBVAAzTn9NxCK
	4TKWme6mGunNHlkm/D0ZKP6DzU89PY6Ovmr+5u3WNq/Nl5oiGop///q2horn7qh8c0PRkVlow8h
	JPlK7v6YT65YXUme
X-Received: by 2002:a05:690e:dcb:b0:65e:37bc:b72c with SMTP id 956f58d0204a3-65e37eaf20bmr13987332d50.58.1779206288761;
        Tue, 19 May 2026 08:58:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d8e60c5sm7961071d50.7.2026.05.19.08.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:58:08 -0700 (PDT)
Date: Tue, 19 May 2026 11:58:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 10/16] repack-midx: extract
 `repack_fill_midx_stdin_packs()`
Message-ID: <ed76e6efd1c9a4ba304a768734ef5065e00c1957.1779206240.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779206239.git.me@ttaylorr.com>

The function `write_midx_included_packs()` manages the lifecycle of
writing packs to stdin when running `git multi-pack-index write` as a
child process.

Extract a standalone `repack_fill_midx_stdin_packs()` helper, which
handles `--stdin-packs` argument setup, starting the command, writing
pack names to its standard input, and finishing the command.

This simplifies `write_midx_included_packs()` and prepares for a
subsequent commit where the same helper is called with `cmd->out = -1`
to capture the MIDX's checksum from the command's standard output,
which is needed when writing MIDX layers with `--no-write-chain-file`.

No functional changes are included in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-midx.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/repack-midx.c b/repack-midx.c
index 5634dc186d0..3fe83715da4 100644
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
2.54.0.175.g8bd0ec98dc3

