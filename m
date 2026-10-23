Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759846;
	b=Ye9SUXsmXmhajIpsZioDElpLWd++ANLM1GrHrzB2CCe4acnaUuOEIvTP0EDm8mjXF2O3
	 +8GWP83Gl2X97rNR7tVVAwud1Oximm6UbUXD5TN1ckcnv4OdZ5FaebhheHrYh6w8KZxBo
	 fs65Ik1Q+2UtfBJKIGGVQTHE8mi9FxQcPFGBTCtNAUVdYDHxJVw1YijqA28fAWvj06+HI
	 wT/RHtGCWil3kyKMxIJ4Wuy4xae+vI2LdggFioXTUS0LeLPMdYari8biK2B0QX3WH89c6
	 V039D4fAcdZitLPHRmDyf18kBfqD4FZgYqyNkm4tMvzoMjfqNECP+5aW6LpD0D1Z1nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759846;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=GYVOhQ3K00nYLVQp+XJajFb9CuYTOYGG9HQK29xjHvQ=;
	b=HpmnbDBaiySF3arbPBTRprZkXSSja+blazcB316AJMvurSpEtRpgoV3S/j72NU2kOx3Y
	 gLWq2Ou3UvclQR+xM1kSew88DawDrJwzTC90s7me+IRBPjpR4FMMDg9iz2fkaMk5HSuG+
	 +BnSN7lS8hfE2vtoliBqH/KZin7Aht9fPFEFLQXDwHtpQ88GEQrwKavyWeNL6qhPXnPzq
	 AqqEXxrB8E1MWLEqfN4c+EVo0OXERP5HbmWtjprKPoBT+fqycHL53wHwXEP3VpZdT6hXG
	 rq1tL7HmOY4nzuyAHnwP8TqatSdZqA/d4EhJL/UndvkUtM2gZa3/QHHyZyrbNHwjR2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=rQjfXw9G;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="UV1J+/EV";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10F3606A31E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D10F3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=rQjfXw9G;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UV1J+/EV
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 35D821D00120
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 23 Oct 2026 08:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759845;
	 x=1792846245; bh=GYVOhQ3K00nYLVQp+XJajFb9CuYTOYGG9HQK29xjHvQ=; b=
	rQjfXw9GpJrNMnpbHwXs+cycHW9DjuKclBFMHZdR+5vDqgZBEkxxHvhm6Sua+Ybc
	dYSyNZtn0fWEZxBlMy+M644e+dpz5ZnIjXy7A8y/lZpqK0BuopzzPVyVaBcE5Yyw
	4avTr+6elZgPHtSz0GVZOWVLQNwEmC4PWXOcEg7QsdDW9SVsulcmWPNR2i8TE5zJ
	Lt0YnzDqtCjQS0BUwnMYJBRhdtHaP8NMHnC+2rmh05aeBKlvEU/0VxOInXSJW1QS
	4wIyAUeFTUWN6kiogdS+n6vU8Gpr0a56lMNwf2QTmLB1UnRbK9iSv2OpgpeB5Rdr
	AgeqENPoqzfkSBiiREstbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759845; x=
	1792846245; bh=GYVOhQ3K00nYLVQp+XJajFb9CuYTOYGG9HQK29xjHvQ=; b=U
	V1J+/EVJvb4BCFFP0z2njLAFj8cXAzD/EVkkAssUTjrfs5fkzoh1cVkP0AbEPIYM
	vRJytQiBPk/tPO016aALZVdLAM+GZn5hrEPsFHU0BCgFpgcsqMQ9FzwHOd2IOogy
	kRBf4ABiU/MBhN11EuGgROiOG8Y+KhKISE7UFhL4A5OvIvhm/QqygkJahnH76J3H
	Vifyt1Zhm3527tSmotk1oRxVqwnHfob0sx3T454ITDbEeKQNWAHSCF3y3TfCYZ5P
	dW7n9EpSn+Z9IAS0LuXwfmrxS5QYee7w3J5utLbAqxaxJcIhnLilKDH9Kb1gLXWE
	FTBqJwtmNAcdFTCgxlnTQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759845; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:D8yYiUfRQ47w2md+3Ww3hV2xH91wIbjNr8sVq4Hkx+71PlN
	gX7D6/7g/IkaTjUjZX+h/JZ1JguwO+BcPYDo6cPQ3cg5IViv6MpCHi48R1euRi+e
	9JsssWT7pviG6WcETO4Oae/W8DZnvlTu2bsSM/KUdfKSWUNSPMiNupH8lgdasOUU
	/jDW+KxrsSyr1btTpb8oLy4opnUK3GJeIZZTekpYqLcYma0GF3wdM4QgJm7OV7pn
	kFeSb9kHJVSteylrJCcgHxCQwd7tU+OzjfTIsSJCpsxy6Q+fCga/FRZ4agA9ZEJw
	uSQMn0sA/sAoSBhONQmM1TtXjfhCatc8e59K0NA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JTJVxt6Z83celoqvkJIBlwo/QWE+HJ2+FK7tociLA2Y=:4wxa7oKH/dOepBQTX9XQL7rrVh5ksfhjrowrlkDqcw0=;
X-ME-Sender: <xms:JVjbauS7mhn5eAfB_125Npxua2oBWO_6l6pgscR43MuH9W_dM7oX5A>
    <xme:JVjbaqvsgICUSylDeE12JccLSjP0ksflGfPB8BnIqhlxD0lFz4M8AObBBXAdfzuPm
    0_BEUVCaq5N_sMFA0a-BhuuHqeTVl0nKG70voX3lLvuBzd25KefoNM>
X-ME-Received: <xmr:JVjbahfSTH_tZSDWVs3ucq_oaSi-xeHwWJCmLehy0l_wtXlN38SVABIemk27aT8G7OP4-A>
X-ME-Proxy-Cause: dmFkZTGqNuAd1/xXSkVpjRGwpg8ruCWl6SmqOphFYTWvsnIwKxkcEYhnMN2aeMunw78weI
    hd3WZPzhRTxd3w/shofImYxiwLdJ0byPH6NZx/1Cn2ueSoP/lmw8nDe013bC/eIEbp9Snb
    6yo16Dcj5aY0LE0tZwWYQ/lJ8H93jdbTIkZy/xVdf4BYvhi1Sh2VWHoopSIJlhN7evHEE9
    HMRPknYvfUUkrGNA+VvBsjBQwm9t/3En9rtyVpnQZUVWETWV7HHQtzJS+YNZ33BrW6ong7
    t4EF79vc+lyYhgbrBnt+bMwq3ZpiLhOl3NHQTApCD7jBa2nV7FteS8HSCEptRNT5AjJ9th
    jILr6trilZhZu+lc/PV+vwVRJhGtD8o7LJ5rkVx+eV5WdAZdTiPx9CIOonyYgmP6ne4eK4
    mE5kQyjwDhXt45qk+7ODt1JCfAgoKS95vD6ipd75AQ2zH2RW+eCy9V/7d/UsIth45Ru62r
    f0sawKWwGAffO7bnBRA5kbqiiZXGcr5gBCL4S3U7oLRDJGk61ByMBHLcK8fdDoGTSPMpVo
    pEaL/iEVTDexLMu7WAZog6q6w2y8IIDEo2NX4+73hVk69Q87OAtV2pOgbT1MA3fxji4z3X
    I33Ppmzb3+ELtF1BOegn63I0uEUj5SLGZHA53TOkbA7Ct41zUb8EIMeQxeog
X-ME-Proxy: <xmx:JVjbavKeH0CrakueIjTBk6Wj-i-Y4RKErXhEq0Pjr0W_51wS37shAg>
    <xmx:JVjbanYOgbr2xuZUaLq_VYkXw-Ug8qjNlBUUECNCrX5XvAS9-CxWcA>
    <xmx:JVjbaisZZMa60aR16o94O1FPNe1qXzTW6vWSX5IuMkrNztDs1X8_7w>
    <xmx:JVjbasti3vN_Ek4MHWtkQ3uLb_30YbRedJSEVfbfnABfJ_uYa83duQ>
    <xmx:JVjbauSO4a5hJ5QLHDHMCxgaAoJEFMXckeTBOaiRkre8EnkQYgSW1LfF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 87e06254 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 23 Oct 2026 12:50:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 14:50:20 +0200
Subject: [PATCH 3/7] rerere: remove redundant calls to `repo_config()`
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
Message-Id: <20261023-pks-rerere-wo-the-repository-v1-3-b6ac0c2e4b81@pks.im>
References: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
In-Reply-To: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When setting up the rerere cache we eventually end up calling
`repo_config()`. This call is redundant though, as all callers of
`setup_rerere()` already called `repo_config()` beforehand.

Next to being redundant though it also feels like a layering violation.
The intent of that function is to set up state for the rerere cache, but
we potentially end up modifying other global state, too. This is usually
fine, but it is surprising to say the very least. If a caller for
example were to call `repo_config()` and then modifies the parsed config
manually then those modifications would be lost when calling
`setup_rerere()`.

Despite the layering violation though it will also create problems with
a subsequent commit, where we are about to cache whether or not the
rerere cache is enabled. As part of that change we would stop calling
`repo_config()` when the rerere cache is disabled, but continue to call
it when it's enabled. So the above layering violation is essentially
becoming even worse, because we may or may not clobber config values.

Drop the call, as well as another redundant call in `rerere_gc()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 rerere.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rerere.c b/rerere.c
index c568bd5e89..56b6ef547b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -878,7 +878,6 @@ static void git_rerere_config(struct repository *r)
 	repo_config_get_bool(r, "rerere.enabled", &rerere_enabled);
 	repo_config_get_bool(r, "rerere.autoupdate", &rerere_autoupdate);
 	repo_config_get_int(r, "rerere.locktimeout", &rerere_lock_timeout_ms);
-	repo_config(r, git_default_config, NULL);
 }
 
 static GIT_PATH_FUNC(git_path_rr_cache, "rr-cache")
@@ -1333,7 +1332,7 @@ void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 		return;
 
 	rerere_gc_cutoffs(r, &cutoff_resolve, &cutoff_noresolve);
-	repo_config(r, git_default_config, NULL);
+
 	dir = opendir(repo_git_path_replace(r, &buf, "rr-cache"));
 	if (!dir)
 		die_errno(_("unable to open rr-cache directory"));

-- 
2.56.0.307.g5fe7bd680c.dirty

