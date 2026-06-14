Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB62FA0C6
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781419054; cv=none; b=PM99WS/hlZYHPBJ0jap3KN92GdyiWRSRQTDIk081EaJgW1vi5BCi2zdu7+nrwmX3nV2rjZls2i30grKKs1pVxENdfm1yo3ME8ju2UvAPCOs9RoTzXazma9cWJL6b2Ywht8Kh8/JLzLLJgUpj7J35q8KSVG5/thG55FTPQEScggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781419054; c=relaxed/simple;
	bh=tCntjicGkzCIEfqEApBlMwlGSyQipQ05uvtQC4bkyFk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NqpOXo9csWHSd7DR/ufvRzmjgI5Z2mDaq6DTiA3zcOOmYBxVBerEeu+WGgVmF5u6rZl7qiH0LMRL5S2y+e+DX08BPCeeRvnOrXwgTwpwf6npd6HjTkI2gMsdRMIiVRfXyh5MdZk5CA5UUMs+nNykGsYWCaYC0j6SNdNDuFkpaMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrwvTsJl; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrwvTsJl"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so26878246d6.2
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 23:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781419052; x=1782023852; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n6I0u+HRI3v6guwV6ovxIEI/TED1NdGKWo0n+27bwo=;
        b=VrwvTsJlyt32K/Lx7i6F+7EYlWaycC4a+ckfeiFbDDtiGPnVMktPjnhW/+C1/UPdGg
         k0UJvuafktRZtAFqXZ6hGkitx+qFeFgL+ntXwMaIKF7oTcitKPbOY19Yhi9iqn+x9qoe
         i5erees5nCLhX/LTCY38r9mDWrLWP53vyq4vfvUxsiHJwzRhBKeJkYs/+wtmW86hD0qd
         Nj3TjyQhyAAq8YROUWDixOLoKyaqG91L0K+kaHHQV476wSwyYvR8AYydiHNFC7z8to+M
         PkVCEEqQeINdxrfvcgjud94COwsNEBdVr1CpElh9uGRQyu3d4LE2EMWrQc8MDXbmOc7W
         qmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781419052; x=1782023852;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4n6I0u+HRI3v6guwV6ovxIEI/TED1NdGKWo0n+27bwo=;
        b=NATtBXI6ub1dgNWBLxirYujJEOjxLDNgCsi3NW05xYljmcrgwqOqjUgwu+jO9amkO9
         AZqXQuaw8//W+40KenqrgAo3afErawWqT8MoSnnK6cJOw8P0VFUB98oNpVxzaNiMRNhy
         E4siHaO5kWqq7g2r10IHncAUe2R1qMPfwuN0MAnaZ1nrNr+b1be+wu9AtBk8OJ9GTp7F
         tPvo9suR/lXSXf8DYdDhBuhgb7SX9ouUG9469QUBeEKHS6P1NgzMWPP40o4hy1zN/+XS
         tq2ct4sbqo2HMLuw+p4xyr42M/Qgfmw274+3bS2a2LCTQmhl+sKTK603U8j9ihVk4cfT
         Le/w==
X-Gm-Message-State: AOJu0Yz5EgPYSlNJ/tsRTTLWrkGq8s1HXCnBvi/8x9wHt6g8C5Okuqw0
	JlubEzj75rYHfe5xm9A669Q+7W0YjmCWLbuiVKOGGUkaZ7IIH9DK3513u8dxsg==
X-Gm-Gg: Acq92OEYhu8+ok+JfsRMwz/Zpp5hW4QeBOaX7+H71UDbTthLZqt2JrtQs8r0YmUCotL
	2aIdslpgdFU+Y1xxrhpWxISJAeKLMS1oxaL/wVkzugtVAThOQ0Qhw90NNLnxlr4G1K0livNX3YE
	+3L2+V4SnZSASQJFLF/gpNj79WffRux+PuKuTQtgf9ohC6DZoqYA3IVVI1yLTc6pgyD3ICOu4Gv
	1+ieOuNyEQWfpr8MvXV4CbkDcnegjoC+W18oOb8bLZocWCbsFtHTL/2IxS8A/As7IFqSu1bErRn
	Ib2MSu0Yq4HNnszf279hRqgGraHZNI6HLa4i1hD2/GmCIodALIzRqWDqkYkRQZu73yztMca3nCM
	bk+ycgSypRLk5x8Nnu4gllEEC0tF1l9AmJZC9rqM+pUvXpXoNMifLmdxV22Gh6tRbQ3IfjNjOQs
	R6GJurn7r35qd3++2eHIGlpQ==
X-Received: by 2002:a05:620a:4628:b0:915:b718:accd with SMTP id af79cd13be357-917ee4d8be8mr1019272085a.6.1781419051837;
        Sat, 13 Jun 2026 23:37:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.15.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a061028sm681235685a.42.2026.06.13.23.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 23:37:31 -0700 (PDT)
Message-Id: <b4ff725a77366a1fae136c3bb72f6198f47d6ebb.1781419047.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2096.v2.git.1781419047.gitgitgadget@gmail.com>
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
	<pull.2096.v2.git.1781419047.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 06:37:23 +0000
Subject: [PATCH v2 2/5] merge-ort: drop unnecessary show_all_errors from
 collect_merge_info()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Christian Couder <christian.couder@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

collect_merge_info() has set info.show_all_errors = 1 since
d2bc1994f363 (merge-ort: implement a very basic collect_merge_info(),
2020-12-13).  This setting was copied from unpack-trees.c where it
controls batching of error messages for porcelain display, but
merge-ort has no such error-batching logic and never needed it.

With show_all_errors set, traverse_trees() captures a negative callback
return but continues processing remaining entries rather than stopping
immediately.  Removing the setting restores the default behavior where
a negative return from collect_merge_info_callback() breaks out of the
traversal loop right away, allowing a future commit to exit early when
a corrupt tree is detected.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 4b8e32209d..74e9636020 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1740,7 +1740,6 @@ static int collect_merge_info(struct merge_options *opt,
 	setup_traverse_info(&info, opt->priv->toplevel_dir);
 	info.fn = collect_merge_info_callback;
 	info.data = opt;
-	info.show_all_errors = 1;
 
 	if (repo_parse_tree(opt->repo, merge_base) < 0 ||
 	    repo_parse_tree(opt->repo, side1) < 0 ||
-- 
gitgitgadget

