Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003631;
	b=XkozMHl94OY4fq6HGoZJN2dw1onhtTShA9jQbSfty/0tnE6TQbGwP6txBlD9frUQsL8x
	 9lb1z4XDd297XAvcANXS6VV1j/BOIYSb+bzS6oM2gcDi1xj3Xupu9AJhMy5cEgmcBkHwA
	 HEmSnYv5OaPc2OtirFfFtsyTMb3K6uePqmzR2rtlgT5+ncUpr0FRjhPWDEKTb3s7LdbmT
	 GevhYSDPOs1/JLlq19yYQTMJ9bEd5wrO2wYSi7A5DV9j12dd+GAemXoVIaErQQe5WzgT8
	 TKjb6uw3GRfVsTCn17SriF6jAfpAsGaw06KcgXXMVuZmhXoyDnoDbYmgE7Aod1J7Bvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=EpgRhqVPgFSAQgq7JmHdPOOaKVEQ2dIITA70BG8reTo=;
	b=Li0hP2xHl3TTiepqKcZPoiYZsfc1N5+UnHMdWI3o+wyxiKj24iC2N+z9RCyEnm0joyL0
	 O1rpF7bl9df0hoiFxLgmuJQd7F/SG48m9iXfbZcXjoyhxmORjd8i5am3K86Ntt22WREgh
	 9u1mziZNErfMGHN/y3Pl/ZSheJ9reNfs2Y67FjW5EpXpk0txuOGoYU8E/23bIX+4qemN7
	 rMwF7Kn6ln/xV7CsNpvAq7hE848GwZDwL1Fw5WH9RmDo2rbVZnMeXakiqcdkAAm1aeErY
	 cZZdVbKGAB807qOwWBwSeV2cTzubt1vpM9sL6jPQZ8c3rReoS9l2MbOLc1DX3EfZt/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D4tCRodv;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B65606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6B65606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D4tCRodv
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so1823877b3a.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793003630; x=1793608430; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EpgRhqVPgFSAQgq7JmHdPOOaKVEQ2dIITA70BG8reTo=;
        b=D4tCRodv5Tp0MK8GkJrBR3EG6ZHqCtw/XKB5yQ3EjoGNX/ucjQzAVYaM2HrQBEWPdD
         w3ITKm5dTWkzpB8nxMWEdtU4THEglww06oYct5urLQOit1by+sL7FBPuxR4BX0Ls7z9E
         l/2PCQb7QU4ukIr6+9TSUSKgMNNAetFSPXR+DY9Oa4sFOTJpCYludMtp7QdQmxUq4wzc
         uE5Pz/Fd8MT6R+8D8At7kJJFR+NcRfL3nJpWGhbxK6aLdbDhCNrTDUHXERJVVlbsKJB/
         dj3gNq/2lqR1y4dJyKFx9oZGXiXCETOeiGibb7+40FPQcEcIBfqYSVnbU6h8nDWGnbWq
         9A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003630; x=1793608430;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EpgRhqVPgFSAQgq7JmHdPOOaKVEQ2dIITA70BG8reTo=;
        b=iMI4GgP0rBjF1cQwueY/Rhe9w45AfNp/MHZPE4+YZ679oD9Giug+Sq4I12ZrTTCc8B
         +7XXZ22XMZ6J1QSNup2rYgATCS6MHTOY2iuiFX2T+dhaVaj1QJlEn6XmhU0+E5aKCNX2
         ro/KsXbHQS1nwgSLKGjZeXf6WTeFxvg3PDyZojDeVdjoCgjomgaiKZuGC+IW8EZ/NU6y
         npgKO6IkKaagjCJpHmjeZy6+xeeu6LkiZ2+BMDrMqm3LqRPP7oeW2FXKm+aUjmFiw74d
         L/Z1D0p0PWc1TDE0cpiloYsw7CHBypLHaenxXuliMoUMlxtlYmc6aorTHB/zH7Er3Fvh
         9dHQ==
X-Gm-Message-State: AFq9FYJZ1yUAkx1j8SZMIdaY6CSxS8iYfpxWrH780CM9cKrsNW/kipiD
	gZsQYc3ztBwhnJtgbcx92gUtpn7+Xg4jqjxdoUl+4lBswIK03YBk/NBPAfnsWtNe
X-Gm-Gg: AYBFou0+NaosJfCpddoUXyDLKM9UJgeU6UBhtCff++ykleavuXU20lC6z7C7CNCTaqm
	3E5f1M23KiLCLSh6uNuhaOP6+exLPpILO85FHzhAQQQC15IVRA3p3cRv9Sl5E4RXEVVWzrVRJYN
	fNULONXXZ0Cm3JJ7pslxDpuc4KN5VbbKu2At5/UNN9hTrzT5UVdA5iC5fc0t2nk5uT6MeQ1wyJt
	MbLiPYaoyN3uwwU67Z0letq66lsLgNq7r3OM8T7IeQmUjNy9/SGHerYqgKmjhS90pAPM9iuxeP9
	y57RQ6eOVye4AsPf0+6BY/rwYi+XKq1NTgSFSAZASFXa76FyqsSpXILh/J+IoE4TaiItBcjWW4e
	7pssS0Cv35N3zzvaZGkKqQxo08p9jUQbz2zJjXprxqPQB54j0IcybnKPu6IhM/lMvxkONnJjo95
	UJokkkIl1kd/EjcNwDm7S3KimDgVKOzlzOf59EB3RnG7AnrcgD3wCz8js394ZOtGb4jA8VUQ0fB
	U58jMcvqFsIfdM2z2jsLUauGC66nunT4L5pmx32TB9qEKtX59a9d9yGB0E=
X-Received: by 2002:a05:6a21:71cb:b0:3e1:d72f:1587 with SMTP id adf61e73a8af0-3e7cd509325mr4300454637.34.1793003629991;
        Mon, 26 Oct 2026 01:33:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.211.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cccce585sm1321441a12.26.2026.10.26.01.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:33:49 -0700 (PDT)
Message-Id: <1d01085b7526ef90ab762c010550e99494e94e3d.1793003627.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v4.git.git.1793003627.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v4.git.git.1793003627.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 08:33:44 +0000
Subject: [PATCH v4 1/4] branch: move the deleteMerged opt-out check into a
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

