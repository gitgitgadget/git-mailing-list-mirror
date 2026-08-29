Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF4396D09
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787986847; cv=none; b=SRs+31uRfMIsx+2yb8cekqxlMAB41AZJCpcRE9PFqqoM8+7zqx4Chdyjl+v8evQKZjRLWbSfPdcHjbEiV5l564/Z/4hCrxcITzjGL1pvV1/RAy2Js/dmJ/VB78390n/tSYXgiNfAnWdSX0nQrcgz913jPl6BMvv1ydd4ytFIYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787986847; c=relaxed/simple;
	bh=G+0QNEdFEHTWegopR9l8hql1pWZWOyvWURIKnyzYyys=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gWs5gUmxiVXkYvjI8lL12hV5ol43PSAHaE7rO1rj1BOFfuidT0ADKlkYE+xF9fBZQZ/C8D/H/INmPqyqTms2kGbhcNYvX79AOI8TyE+XXCPMG9KmC/+Ic6Poh69g1y5P+NdtRWIoeazG+So+anV7VdRYORl7wMA5yO3+lYqYJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCnChoZ7; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCnChoZ7"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b1b766bf01so67422eaf.0
        for <git@vger.kernel.org>; Sat, 29 Aug 2026 00:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787986841; x=1788591641; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vcfcY4xk3gSwEAXBMUNmcroZczNM4FFLgqvffS/JIpg=;
        b=KCnChoZ7WbbprVuiL+hiCOBlks1FRxJnJ5jmOhfEWLqtgsAEOUQoWnohad9uDb9Iyy
         p3IJKPNWEN1Bp6pv1GUnpkWrhdIhmSAn2wYC61GQxSmSunLXG6W5Azmuj2YpiD0HiQSX
         e6IY03+NM9IazZDm4OpWPsKuULLGi2G49hxD3Sh+hSeTfXPTDakuJSQKlj4WMfimKFRZ
         kxYeh++aefI7zzgSmRQGtf7u1+l1ZRR7oIGkKXafmX6lG70j/9s39ASReL/goXI4v/RR
         WCcJLOINLOdtj0NEGu89ob5ABq03CaSgICOIMtHCver1xCtDTlQFMQF1+eis7Mui8Mdx
         ChLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787986841; x=1788591641;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcfcY4xk3gSwEAXBMUNmcroZczNM4FFLgqvffS/JIpg=;
        b=loze1qdVuUWc5MZNW7jIHB4GxTC8uoRou3GHWiqo187hrG6rtMM/XcPqyPBQoCwRjY
         bzkfA++3oGlHBJsSXtdKhyrICqgxXk7fpNmu5OWuLNcq9y8/doyjR1SQHLmpSzvoHWvR
         tl7QaWtS+M3JksfieLSYzuFRXd4CsXyx8eo4dMINVpHaX3M2sAebgmxdvr0XzCzzdooX
         R+c8XugM9lx0vBlJiDkWskzoa1B3ypFIeRhkhDDJq0+UT9+zMm95FJKNftJqos4eNxPz
         mmChz6KgwJbTiOtsR1cPg/d7f6lgOqcOyjMRauS9Tji34N7ifWPERKIBODwB9cLqav0i
         yLMg==
X-Gm-Message-State: AFuF++lc6Jsj2Qa0TRaPX88RrVg0GJ5I6ZoEYqnfk4hzSIcgCc0Y5HCJ
	rGcXZ7ysaMaimC08NjyBEmqK+DJxbJ7pFohPjURXJEGeuzbBW/lxrHpfkxNFT5nU
X-Gm-Gg: AR+sD12vlEOqWp+sT0P3u7VWtlpls6668ys/0BWSI4m+A8KFyAjzAxLtmKmtmeKXyEH
	3d23qL+UJdWY/rIBvlB1BO4MeNZDvfQvc3Z3Vrsphs/bzZXZokdDEetjfG8XNjYpGNn1Ugz4wv8
	cdNfwC5Dxwxlby30Qhj7yOTKthdRafduSkptlXTPSHKuXzsB0VYWPBc3ANMF2DdUjvao8AY2H8q
	CmkBCQoTL7AQ1/HBnxQJZVHE2s7DYPw0gBmh/Ni+IVAPn6i2FTyN4XZQpve7syyv/V713tWjO3f
	5X5bYrZ/XyEBiVqUnPoOFLlTpATxetD2IkoRepytfhi8yRGr4J2pJpjn1tIAA1PfuU1Gom0nzGB
	NbeWVreD7jfwpku5YhTATKNNQTpOG7xN7f5xBBaBf05ycJxD1M8LCmxHcQioVFao1nGijjCsYRm
	iy4HwKYvtvK6SaHk5+VICMrjGc114nNDzX3ATdkcE9OiKbka3mJ0ffGQsxxZdojCBjOeUArBAK
X-Received: by 2002:a05:6820:f185:b0:6b1:4e37:41c0 with SMTP id 006d021491bc7-6b1c66928b9mr10205676eaf.19.1787986841487;
        Sat, 29 Aug 2026 00:00:41 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.5.228])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1ce160533sm3664517eaf.8.2026.08.29.00.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 00:00:39 -0700 (PDT)
Message-Id: <79ce753c6849651cb7497c5e7716f0f1068df4ad.1787986831.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
	<pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Aug 2026 07:00:30 +0000
Subject: [PATCH v3 3/4] mktree: do not use OBJECT_INFO_QUICK when checking
 objects
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
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

mktree_line() checks each referenced object's type with
odb_read_object_info_extended() under OBJECT_INFO_QUICK.  QUICK skips the
reprepare-and-retry that reloads the on-disk pack set, so a resident
"git mktree --batch" reader reports an object that a concurrent repack
just relocated into a new pack as missing, and rejects the entry.

QUICK entered this lookup in 817b0f602710 (mktree: do not check type of
remote objects, 2022-06-21) only to avoid lazily fetching promisor
objects; OBJECT_INFO_SKIP_FETCH_OBJECT already provides that.  Drop
OBJECT_INFO_QUICK and keep OBJECT_INFO_SKIP_FETCH_OBJECT, so mktree still
avoids a promisor fetch but recovers an object that was merely repacked.

Add a regression test driving a resident mktree --batch reader across a
concurrent repack that retires a pack.

Assisted-by: Claude Opus 4.8 & GPT-5.6 Sol
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/mktree.c  |  1 -
 t/t1010-mktree.sh | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index dc2d293c3d..45ae2af3b5 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -125,7 +125,6 @@ static void mktree_line(struct repository *repo, char *buf, int nul_term_line, i
 	oi.typep = &obj_type;
 	if (odb_read_object_info_extended(repo->objects, &oid, &oi,
 					  OBJECT_INFO_LOOKUP_REPLACE |
-					  OBJECT_INFO_QUICK |
 					  OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
 		obj_type = -1;
 
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 312fe6717a..cecba55d45 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -69,4 +69,52 @@ test_expect_success 'mktree refuses to read ls-tree -r output (2)' '
 	test_must_fail git mktree <all.withsub
 '
 
+test_expect_success PIPE 'mktree --batch survives a concurrent repack retiring a pack' '
+	test_when_finished "rm -fr race" &&
+	git init race &&
+	(
+		cd race &&
+		test_commit seed &&
+		a=$(echo A | git hash-object -w --stdin) &&
+		b=$(echo B | git hash-object -w --stdin) &&
+		echo "$a" | git pack-objects .git/objects/pack/pack >pack-a &&
+		echo "$b" | git pack-objects .git/objects/pack/pack >pack-b &&
+
+		# Drop the loose copies so the blobs resolve only through the
+		# packs the multi-pack-index names.
+		git prune-packed &&
+		git multi-pack-index write &&
+		printf "100644 blob %s\ta\n" "$a" >tree-a &&
+		printf "100644 blob %s\tb\n" "$b" >tree-b &&
+
+		victim=".git/objects/pack/pack-$(cat pack-b)" &&
+		mkfifo in out &&
+
+		# mktree --batch stays resident, so its pack view predates the
+		# repack below; feed it one tree at a time over a fifo.  The
+		# subshell exit closes the fifos, letting mktree see EOF and quit.
+		(git mktree --batch <in >out 2>err &) &&
+		exec 9>in &&
+		exec 8<out &&
+
+		# The first tree makes the reader cache its (soon stale) view.
+		cat tree-a >&9 && echo >&9 && read tree_a <&8 &&
+
+		# Mimic a concurrent repack: a replacement pack holds every
+		# object, and the pack for b loses its .idx (its .pack lingers),
+		# matching the order in which unlink_pack_path() removes files.
+		git cat-file --batch-all-objects --batch-check="%(objectname)" >oids &&
+		git pack-objects .git/objects/pack/pack <oids >/dev/null &&
+		rm -f "$victim.idx" &&
+
+		# Resolving b used to fail, as its QUICK lookup accepted the
+		# miss; without QUICK the reader repreps and finds b in the
+		# replacement pack.
+		cat tree-b >&9 && echo >&9 && read tree_b <&8 &&
+		exec 9>&- &&
+
+		test -n "$tree_b"
+	)
+'
+
 test_done
-- 
gitgitgadget

