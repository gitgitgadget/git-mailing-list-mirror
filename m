Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205338;
	b=oIntkNicI9a+94+9tfOuXzkWXK7gJf95KRXcIE5a56dua7gyNEWECcEc4aAsJn5cCqml
	 Egvdia50Mb6f/2x+qq6b5pWCxp80XUG+AykG3iCJcG8jw0YVNMSztL5e5g1dTbGTlGVzR
	 uPfuUv/SkZQl0rCPNX+3hWjEjDpnmsewEw50haJm+mPCXHyFou0n1WBXCDqpM8O29vbaC
	 SM07rgHLtOOptkV2X1ybxsdzxWgR6MLYoT4j/oVcrO709hp7GUGpKYkCJ0TyQ85MwfcN+
	 +W/4XD5mEEjwaQFxXrHi+SCCm56LskBA8/aay6CjZMwHsnOvRXXcK8DcGEd9dx1e/hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205338;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=j/DXuM2ejRm20mlz6/q/eMsbCNf2YCTQrxuztgNeFkA=;
	b=qriH3CMt+6LlNZ5S+24lrQDbe/oK72NwH6H+u4QUT2NPNmopoHFls6fpRdpepYelCNft
	 qWaf6mXJSG7htTGv4/KZWMfmTDxInn6FuP+crO+7dMKHmPF3fQQHxcwWvjOWuy+vfp2Fn
	 6gFbyT3nNZk+rJAGfcJUyvm7J8yvixCKJW5xs1yalHtz5mibbjXR3E5Z4LJfG0E8nJuoC
	 zJsnN9Q1CdxsrMIoqJxIKCsedyuYxyuYrfnYc+iBzIm/4/bgLH5Lfza/T+Lsed9021snC
	 7BAKVRDs4LvCTiKh4xZNhxf2IxCupo4bCWudJHvoszFFZRNm1kSWb09FYnarzZG5TEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ky+QdSNM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="aN2w/4Ew";
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78A606A6D6
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 20:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC78A606A6D6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ky+QdSNM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aN2w/4Ew
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0AE301400164
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 15:08:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 20 Nov 2026 15:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795205335; x=1795291735; bh=j/DXuM2ejR
	m20mlz6/q/eMsbCNf2YCTQrxuztgNeFkA=; b=ky+QdSNMwm5CN47ZtjV2cV84dG
	8t6mI2MgFKH8o9++SDsfgWwE9PYVaLR1xeXNl+uSHMyaSeEMlCROuZgSZic5DSF7
	sMmHcvBgLlMq8gWO7xK6lIdrG7muZqQiOB0mDTrdPRpxnuvNyXznLYrui4stbvum
	IaAftcJC6nhyhb06AhCAka3kS6IV4ZDfhG8EGPdJb5lhXPrK7zaFaOpAOSQReGrU
	TbRZw/P8kFp7NpRHHM9vaCB86wr9piPWk+8QO8ePCxiSFgFH+L0If4mZ8BEH79Dv
	9QlY5HqiBbAsrFZd/wGPStQH7qtDxXHmLchbzCU959IvQwWSX1FFpdstSieA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795205335; x=1795291735; bh=j/DXuM2ejRm20mlz6/q/eMsbCNf2YCTQrxu
	ztgNeFkA=; b=aN2w/4EwOFQCF3DQJwy+w4YnTkj9gRkf8SB7KxV9RiRUJ8IYCB3
	/mZ/b5ERzEGysQTQdRGUzvrWc1Tyx1dvtKyVbCsWDrLH5+stw+lRfUD1iabxenCR
	lesFo3p8SBbqjWCr6ISdmZ74g6cMO0gx6Sj0RO39MfYhqFwKeMoMhJ0woaOzuBNm
	8F3WsS+mHxOvdAQBnvCeaWqg1YEO5AMann77pr9eA2SAQQYlAiJkQIu6bny79LaS
	WIshvXKBu/WcO209BW0ok6/Mgfpw9sEpQJa43fOFTQqrwhlLawZi3vsdNBNh+u6p
	S06T6OwLpWYeN3Ex7Jazx5PrYwQEGAqqUGg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795205335; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:M442PSW9wPDDXjk8jUJQ3vkSHIdhFAKgD7SNFkqygM9DCKX
	AqhIHrj7ZPceZfC1MUi+TfvSszHO8BmAYCG3K46Q+foOEMm8eyQ/bULLA2AeCjLY
	cF0P72fFY7jx3+G682q4Cs/ILtzwoQZId0C610qB9UM9E66zYZt/8yfLLQRgj9gq
	aTW3HFFvHnlIGz8uK3RrY5kbw9RgOTrekAVFOo19SUFr4JJ2CvmAtbclndZ2aKCY
	Nz1I3JJmT2ynhUQsgRKVUxKkh0IleGo8VgXQbJNZHKZqF0ZU+XWKiwetcEipVCG9
	TX6T9OYoJ9lwgDO9jeXz4EE+jQea7V6oJorVCqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xB28O2qzqfl2w2Cq0a9KtbQ+zw7ktXQFvAscdXWGjk0=:bwm1sMRVF3I2xVplPU9J6n8Q3I25oGJ6gXQa5QWLINs=;
X-ME-Sender: <xms:1agAaydEmZiPikEFrZ01HcyXqq0xbrs6VukQp6Klccg0AEgQYJ9CHA>
    <xme:1agAa-zuJIVUj-fTQDCeVQUwQ24K-5toYkQz8DcvI1WokEY50yogi-qpp2NU5QotN
    TmjQkRXa4IMqupTzZlwGNLxOuv03QEFcIu250IZbUd1pI7Di_ViYQ>
X-ME-Received: <xmr:1agAa3KXD1CRGruRRUw5hDcN_o-BRPgCNXiDQfpl4mG8OeD7tKKKAz8NKd4bDLdoypK-FszLwSuqLOMm_T8DOj-uo87XwJFo2yFh>
X-ME-Proxy-Cause: dmFkZTFfV3pZOqO7OZU1KS04nhw7eBrmloktzuPKCtF1oOwj5ONSEMyuf1fd2i3op59if8
    nOP7cimvF5tvrDOcNuMU2c9Qau0WGiSaGn20oX+bGqxk3Ak7FXvKueEw8RWLHbJy/6fTdZ
    JUqQvNFGdbl6LXeqnXrAQgJI6eQaljuiZa0TRFyQju6Wzja/nh9fFshZDYILcINhung5an
    2ZF53P/UMSJN7hQWrhNalERi1cEEbhGEVLZ6Qteq6rB6qDdtH1T3jlSViIsCQwtoy5AqP0
    lmE/ZIShGLDTN6q4mD3GQMgp12ozVylG57CvR7FjKn51cWnhOyx5o+vk7EpnGdKpxEWuTf
    Xi/AASW+AqKCZB7BsfYBvuRWpT7nxHZqNq9M6DcXHspMgt0gZ+eE4l8X9pkmVSGEazumuz
    vSCxrOJxOte207zpKZjI3D4AIJQcuihPPy2enMKak5Iz1lOI0ZQUBjrlZ/HoMDLa9JQGLD
    M6iM3GIbjZYRwqYX6JNrfmKrTrSlNAyR389Rz2/YAdVW7HV/9YE2Wr+ooBa8wQiBO431oj
    xhUCm+S0Mxv3QOk+0v8kbqkF27G3CYaPytDwzX0jXw8E5wb7z5NrxcxoFse8+7CVKStogB
    VUzB66pPyWkQRriFKt0MCh2uqckkYGUXPd8Oa+2TaPE1vtXAVBYrVElB0Ziw
X-ME-Proxy: <xmx:1agAawGdWJ_8EeyM3UfuqTay7WQ6Xl3v-7kCZIWPAKS_1X64O3FDqw>
    <xmx:1agAaz_vNZLXzjb3nRws_Aq6OwFlTLVu5yukxEtjJEXpmV3hKtIfMQ>
    <xmx:1agAawIun_cF02ijlT-_voTg2ZDTyfJU-PjAx-_O8gUfG1YjWY3Sdw>
    <xmx:1agAaxtf-2By2XbB6Q9Z56uymmvkTJqfVWfsjwY48yrJ-bS7zYPvsA>
    <xmx:1qgAa0lr5NrdcKA8siyvu7r7y8C8ssPXERNPoGdbqbrh8F0KF_iBQryf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 15:08:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>,  Tuomas Ahola <taahol@utu.fi>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v9 4/4] branch: let --delete-integrated find branches
 merged onto changed files
In-Reply-To: <ef6570030325b4fe18624c30ad1779552fe46b37.1795184664.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 20 Nov 2026
	14:24:24 +0000")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
	<ef6570030325b4fe18624c30ad1779552fe46b37.1795184664.git.gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 12:08:52 -0800
Message-ID: <xmqqv75rnu3v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success '--delete-integrated keeps a branch that replaced a submodule with a file' '
> +	(
> +		cd upstream &&
> +		git checkout next &&
> ...
> +		EOF
> +	)
> +'

This test looks somewhat familiar.

Was this the only corner case that needed a fix?  From the code
change (below), it seems to be the case, and I was hoping that since
reviewers are doing a lot of work finding corner cases, the original
author would be finding three times as many corner cases to make the
topic better, instead of just reacting to a case that was reported
;-)


diff --git c/builtin/branch.c w/builtin/branch.c
index 7b1048b583..a225c591b8 100644
--- c/builtin/branch.c
+++ w/builtin/branch.c
@@ -864,7 +864,7 @@ enum change_state {
 struct branch_change {
 	char *path;
 	struct object_id base_oid, branch_oid, upstream_oid;
-	unsigned short branch_mode;
+	unsigned short base_mode, branch_mode;
 	enum change_state state;
 };
 
@@ -901,6 +901,7 @@ static void collect_branch_changes(struct landing_search *search,
 		       &p->one->oid : null_oid(the_hash_algo));
 		oidcpy(&change->branch_oid, DIFF_FILE_VALID(p->two) ?
 		       &p->two->oid : null_oid(the_hash_algo));
+		change->base_mode = p->one->mode;
 		change->branch_mode = p->two->mode;
 	}
 	diff_flush(&diffopt);
@@ -943,7 +944,8 @@ static enum change_state change_state_at(struct branch_change *change,
 	if (is_null_oid(&change->base_oid) ||
 	    is_null_oid(&change->branch_oid) ||
 	    oideq(&change->upstream_oid, &change->base_oid) ||
-	    mode != change->branch_mode || !S_ISREG(mode))
+	    mode != change->branch_mode || !S_ISREG(mode) ||
+	    !S_ISREG(change->base_mode))
 		return CHANGE_MISSING;
 	return CHANGE_NEEDS_MERGE;
 }
diff --git c/t/t3200-branch.sh w/t/t3200-branch.sh
index 78b7d395e2..41b31c8f67 100755
--- c/t/t3200-branch.sh
+++ w/t/t3200-branch.sh
@@ -2217,6 +2217,50 @@ test_expect_success '--delete-integrated keeps branches whose changes did not la
 	)
 '
 
+test_expect_success '--delete-integrated keeps a branch that replaced a submodule with a file' '
+	(
+		cd upstream &&
+		git checkout next &&
+		git init lib &&
+		test_commit -C lib in-lib &&
+		git add lib &&
+		git commit -m "add lib as a submodule" &&
+		git checkout main
+	) &&
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git checkout -b replaces-lib --track origin/next &&
+		rmdir lib &&
+		echo "from the branch" >lib &&
+		git add lib &&
+		git commit -m "replace lib with a file" &&
+		git push origin replaces-lib &&
+		git checkout --detach
+	) &&
+	(
+		cd upstream &&
+		git checkout next &&
+		rm -rf lib &&
+		echo "from upstream" >lib &&
+		git add lib &&
+		git commit -m "replace lib with another file" &&
+		git checkout main
+	) &&
+	(
+		cd repo &&
+		git fetch origin &&
+
+		git branch --delete-integrated origin/next >actual 2>&1 &&
+		test_must_be_empty actual &&
+
+		check_branches <<-\EOF
+		main
+		replaces-lib
+		EOF
+	)
+'
+
 test_expect_success '--delete-integrated reports a merge plainly next to an unmerged branch' '
 	setup_repo_for_delete_merged &&
 	push_topic a-unmerged unmerged-work &&
