Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357589;
	b=SMFq4vDvl+EdAtLsHvEbigWHg9kHX+Dm7WbEPvLEUf5BBo1/RdA1VUVtfmi40P8WnGpx
	 wHEF+Wch0CC+FU9fABtdp9Agp/n1dVvMK8ql+aLMbTh6TAKEpFxNAk4pxepoDic3taG4W
	 2Wre+l4ce4f93IMaLY7eGssgQ9RQVjikh2xsS3VU4vkQL7Kr0i5sOtgqYyePW5LDMBJRl
	 QP9Z//d0hH5WIkmIZDx1LTNfRRK94FXpQXKKx6GzNUBMSAj7sKNmjRx9Z6uZYuI6JZtWw
	 hIyq4LD5Bxtya3lkuLDd6nfao7FpYXcxcGByLOLBbWYzTh/f4DqtpQJz5uH/eE5sJPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=EpgRhqVPgFSAQgq7JmHdPOOaKVEQ2dIITA70BG8reTo=;
	b=SZleKI/m0NLUcEZFlv7/VSYMvDCsx7sN8/VK8L/gPKLkgxxcz0gK8Oe96XLPV4ca5BfA
	 hyBNO9QprjVqQSXEh2huJkvO92abFVGvmx7fAVahNZNVujE6mD3iJ+rjTSaa89Hrzw3J1
	 K/IxjJ7jI6Hlt/G2j30XCCY7B1uDmEg/3OAfUT5fp/GEWkJ7U3hTHB1cioDP9U8ZDU8rU
	 sA8oi5U34Oj8C9dSiTELvAd0ZLYXv01/E+ILwBsSlzIU9V/RhQHzLXvRjz0iYgjlUMlK5
	 FqEPovSwJrMB/MTinL/yFoAioznIDB65a92mG3wzu9byDAGojnwfpwr6EOZqfGO+NIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ttKjsIyI;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093C606B97C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4093C606B97C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ttKjsIyI
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-8451a619da7so413580a34.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357588; x=1793962388; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EpgRhqVPgFSAQgq7JmHdPOOaKVEQ2dIITA70BG8reTo=;
        b=ttKjsIyI2cn6X/ZFq/ufp0II2jmHAah9sKgnsfN7lxuMAQThRfUGSLSiqrwsuE8EYo
         Lvlv3zLA4e6/bHyHjNyiDa1zxoHZ4R0MKejMtinPQpnsJSMsEKxE+um795//2+ZFVw9t
         dJrIIjc4dzQnrQH9UnfkmagB1/6zE45YfmUHW/1/H90GnWkLAKLe8aT/DC+/LuQnsiXD
         S7vmGRaYs8EuaXcik0mrE9hygdu/Zt02+LdH8SUk26IQ0uokZtstIDDWTxT8xD0Jklwk
         Gq9/jghxm7G+OYmujKnYEag8xNA2SUiipng314HOVKASKxFrAfpFNEc+nwH6Pz49v0hf
         t4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357588; x=1793962388;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EpgRhqVPgFSAQgq7JmHdPOOaKVEQ2dIITA70BG8reTo=;
        b=toUJ8IC2mlD+ebA1gO+ZyjlqbQn9bG/OR8Z2vM2d3Ytiv+cf4pkky764ViMFGNeseN
         5tfzMnMhOKVC8stFXp3VKdLosZt3pXW9SpP4w9xEcnLqk9j666klXw1N5Cfl51Z+mxxI
         Nka0W6OnxnUZzrBC9WHvDUOYQon0uFvB7eFP7daQtJhP79FlsjnBN3l6wHFS7IdA/16U
         Ccd8TvB0K0pgehmqkamhiQliIXfjBbEijPZgiRW+Gx/aTqbO5shwlxAsxrbGIDGPmT+T
         91AVg7TY3B+cGaPF/oNPIlpiAjDktheFwPn0hpxxBjPqwmuxnVe+XTJ1EvoDxSA8yaHX
         7jCA==
X-Gm-Message-State: AFq9FYJIgXvMqKEeZuVVkIJCLWfKZ+iVRelcHX7llCYC2r+eTdQmfd7C
	b4G9cDF83gVpYWXqn26mBvEeDaee7bDL8T9UJ5Qpn2VpkZE1/XukQV4hIbMtc5L04BI=
X-Gm-Gg: AYBFou1PY/sM3RrOWitXPk5ZozrI6ADbxG1qyUjWhZXKSpCNsds9d3gx1AUOGvBSePc
	0xczJP82hkZO0xI95GWBmmj4OI4GP/V7XyrHI0bBaREIPVfYwz1RE5M0wu5FpUxUaroJUbaj9IY
	078HsgMhQjiZGaThZIzQgFnOufVlBrviEu1YtGuFxdK7n2z2aIxZxiyeSiIb3ZF0VeVQ8j9/46x
	I5XTZooNbZPK8d/E/FFt61S67KP/J45MSnncG8vhkRcPQBoU+96znLzkgs6ACX6fz1DpvpT5+0E
	/zC+OrHHhNcAJkEBfoRRlQ5LEjPuewXuOrR2wziQuCixNnNByioBdoVX6QMKfBK/0vNQheYg6GB
	BzEmEvYOW1NmSXNhovCOCNcNNsR9/yTqK8RgedynWW329qLbBAhA/njDp6D08K/LCQIaAUbRd0a
	wNSE1WyGLQSZhRy4i0fNdqNzjogtcveyOB4gi7U1KKuIqfITBZAxEGNcHZGhQkrcCedXmfGJoOR
	Ys8YakLhVv7gZSOgBBwHEktGGHceH5k4L718XxE3Zc0EuSB603naODPlIhElE3t2opQYjJ1AYP6
	xLhUbdyC9/ihbpdc+PA9KgchS2Zk1Yr9KQ==
X-Received: by 2002:a05:6830:640c:b0:845:156f:589b with SMTP id 46e09a7af769-85d36569f00mr1555555a34.30.1793357588261;
        Fri, 30 Oct 2026 03:53:08 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.62.244])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545b880sm1859791a34.8.2026.10.30.03.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:53:06 -0700 (PDT)
Message-Id: <090aec572530181b11ff4232f36e20908d0041a7.1793357582.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v5.git.git.1793357582.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v5.git.git.1793357582.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 10:52:59 +0000
Subject: [PATCH v5 1/4] branch: move the deleteMerged opt-out check into a
 helper
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jasper Mayone <me@jaspermayone.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A later commit adds "git branch --delete-integrated", which deletes
branches whose tips are not reachable from their upstream. Those must
honor branch.<name>.deleteMerged=false as well. Move the check into a
helper so it can be used in both places.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..171b13b081 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -824,6 +824,23 @@ static int branch_pushes_to_upstream(struct branch *branch,
 	return ret;
 }
 
+static bool branch_opted_out(struct strbuf *key, const char *branch_name,
+			     unsigned int flags)
+{
+	int opt_out;
+
+	strbuf_reset(key);
+	strbuf_addf(key, "branch.%s.deletemerged", branch_name);
+	if (repo_config_get_bool(the_repository, key->buf, &opt_out) ||
+	    opt_out)
+		return false;
+	if (!(flags & DELETE_BRANCH_QUIET))
+		fprintf(stderr,
+			_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
+			branch_name, branch_name);
+	return true;
+}
+
 static int delete_merged_branches(const struct strvec *upstreams,
 				 const char **argv, unsigned int flags)
 {
@@ -852,7 +869,6 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		const char *branch_name;
 		struct branch *branch;
 		const char *upstream_refname;
-		int opt_out;
 
 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
 			BUG("filter returned non-branch ref '%s'", branch_refname);
@@ -870,18 +886,8 @@ static int delete_merged_branches(const struct strvec *upstreams,
 					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
 			continue;
 
-		strbuf_reset(&key);
-		strbuf_addf(&key, "branch.%s.deletemerged", branch_name);
-		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
-		    !opt_out) {
-			if (!(flags & DELETE_BRANCH_QUIET))
-				fprintf(stderr,
-					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
-					branch_name, branch_name);
-			continue;
-		}
-
-		strset_add(&deletable_branch_names, branch_name);
+		if (!branch_opted_out(&key, branch_name, flags))
+			strset_add(&deletable_branch_names, branch_name);
 	}
 
 	protect_stacked_branch_bases(refs, &deletable_branch_names,
-- 
gitgitgadget

