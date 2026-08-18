Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14433C18B
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092455; cv=none; b=Fd5Zn2Y4VkB/p68a6Vk16QWwQrApZf0sMe0Z+Ll005uhXscX8+NB7gPPlUL/xPKBTGIy+6+khUyO2ViZ2li4rp63RhHJly0+34e+JbkMq7O6G5Pz9yrOxjemzAabeksQcWP4MJz4hVkMaUM72ganjuv/eW84IhWZpi2YZXuNu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092455; c=relaxed/simple;
	bh=NDEb5h9dAHXFdTxmOvJwVqWY3g9ixbs/tiu2D9vgdwo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Vk+c5Ct7Nf0ZVcDU6iu2yCPnXYfVj0HowcI6sXDuxCj4LWxLkSUyYurxxIlw+UdjU0a8193l+FpjK4KPdMlgLVwzoIH/rCK4z8tb8+XMMYxLsfHzo4LRBvPE/hwGypgLEikr5vDXeT0HrwoNstg49uezIxRm7vNVwy+GFU69+Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYjY2V8E; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYjY2V8E"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso255717a12.2
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787092453; x=1787697253; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BT3KowMTjaIQDYvcf6Kg1edpBO5Cgfs8MP8LZ2nfJv4=;
        b=UYjY2V8E4HBatT7LhIVG01iDMbmCsdO9SW6ljdqY+A+NwUCehWywhW/Vbs+V9KLLvd
         t97X3oiItgDMUsv7yTLPZCF1704atfOgq4FVLYcbrFedXrsWsXR7AKq19JghWIgRRgy3
         HvcnBkMB0nCGMtUxdY1Mu8QCnJdMgi23Ev58SV5A8DEHIAOKI5IcfCTpnEK1/1V7J2Pc
         QqM8iv0k4ljdRVNBcATFWDY4ru4478yN5v77gc8lxel6QHtFz89zm75zX5tNOKVWr9M6
         nCpRoBIHGvgUqZ+7Wd4XBSJ8XL9bcQliKVX9sCFrbJiMmvSDNQUg1WsMEg4JoJt8paKz
         ImKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787092453; x=1787697253;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BT3KowMTjaIQDYvcf6Kg1edpBO5Cgfs8MP8LZ2nfJv4=;
        b=jbjcTZfSupp+X3ttLZqYo4vP6l4BknuBpfwlaWJf5wUARigtolctyXZPjBl40wfHcd
         vrX9bDaI6/1ENoX36hdab+90Zq6AEFTAWKiAysSmp1V7SDu/grZmhxS32ornTFdrNAvG
         A9jV+nXRy+CQy+GYWOQPpL5/YEkr00uIIHqym3SHMtO9uO8qCNQezvoDVgMPcMv3LsWX
         GzxRev9/Vip10G194XaytFeLHTbtAzhkCLqtSWMe6Rdt+97Yy4D32dYeGyvrsOC5okT7
         lBxed+OAsnPidyZXVCNe13u+8f2tJtYStT/BdmX8Z9Fu3oIJh7buxBJI+mHdMxdGv2Z6
         pDSQ==
X-Gm-Message-State: AOJu0YwdHHydBcfvThZoOKd7PDNPSGZhwuQd49fwTnjaOhhAi46WWZEj
	jHNEHhc29vjyK4/pYtQnljqwpeAxYYx5PjuwJXL51ZxYemXUNarthhQSNrtQvw==
X-Gm-Gg: AR+sD116IZi3XvNiYWlFoI6ykTF/mJ9qlwKCzqheuQhCXxq8DyxeHNU01bMW8ffd3ya
	EF+77gE0NSHKloWvTnag2Uj2ttYtkfTM/dj/OyYCLNqnbGdgEQZw7fgj+3ZOr7j38UKkeMEB887
	QH8mZINPgStCQ/ckuK7gZZptQUOvF0YrpVNqLRxE0EKh+yYWedR7shdUOjXh6rOV60Tm3/T7YXA
	755ijgCTgEQyMRP+KizhSNeodpMiJ18zjK4KnISQhfED/088ZK6Dwl1VuwNGq0Ye1U33NWpvvlK
	iE/2EuYiLMD2ApiL2wvG00ZClSM0RYCZGjWIxQAHiVPbSYiXNtUX3RtoMR0KKhE9V4Trm4hjdPs
	GuIxlfHQiSvYNoYALgqDuKck+xNF1yVSuHqgChwc67+Zam4YRgVUKtzPP2bGLq6VQ7aclkkpQFG
	NKZs3RKvTMrdyYt9VbMX1bfn6U9vFJMY+v9GA7BjEiJ2Pu3hH7Wp7fIhCVMtc7A8K1
X-Received: by 2002:a05:6a20:d48e:b0:3c4:1916:9d3c with SMTP id adf61e73a8af0-3cd012ac425mr729116637.15.1787092453093;
        Tue, 18 Aug 2026 15:34:13 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf14376asm228882eec.24.2026.08.18.15.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 15:34:11 -0700 (PDT)
Message-Id: <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Aug 2026 22:34:06 +0000
Subject: [PATCH 2/2] packfile: recover when a multi-pack-index names a removed
 pack
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When a geometric repack runs concurrently with other git processes, it
can write a new pack and multi-pack-index and then delete older packs
that the new one subsumes.  One or more of those older packs may have
been indexed by the previous multi-pack-index.  A process that already
had the previous multi-pack-index open keeps using it, and that stale
index still records the removed pack(s) as owning some objects.

Because a multi-pack-index attributes each object to exactly one pack,
an object that exists in multiple covered packs is served only through
its recorded owner.  If that owner is the pack a concurrent repack just
removed, find_pack_entry() cannot serve the object: fill_midx_entry()
routes the lookup to the missing pack (prepare_midx_pack() fails), and
the regular pack fallback deliberately skips every multi-pack-index
covered pack.  The object is reported missing even though a perfectly
good copy survives in another covered pack -- for example a large "base"
pack that geometric repacking intentionally kept.

The false negative is not limited to one caller.  Any reader
(cat-file, rev-list, pack-objects, ...) can spuriously fail with
"unable to read object", and callers that only ask whether an object
exists get a wrong answer too, since the OBJECT_INFO_QUICK path never
retries.  Writers that merge in-core, such as "git replay", are hit
hardest: merge-ort treats the unreadable tree as a premature abort, sets
result.clean < 0, and returns without a result tree.

Teach find_pack_entry() to recover.  After the normal multi-pack-index
lookup and the regular pack fallback both miss, check whether the object
is nonetheless present in a covered multi-pack-index (bsearch_midx()).
If it is, its recorded owner must have become unavailable, so scan that
index's packs directly for a surviving copy.  The bsearch gate keeps
genuine misses (i.e. objects absent from the index) on the fast path, and
because the recovery lives in find_pack_entry() itself it also fixes the
OBJECT_INFO_QUICK callers that never reprepare.

This recovers the object without touching the multi-pack-index itself.
Reloading the stale index would be a more complete fix but would be much
more involved: other code (pack bitmaps, object name disambiguation)
borrows and caches the "struct multi_pack_index *" across object reads,
so freeing it underneath them would be a use-after-free.  Refreshing the
index with proper invalidation of those borrowers is left for future
work.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 odb/source-packed.c         | 29 +++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh | 40 +++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0890704e76..de96215069 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -31,6 +31,35 @@ static int find_pack_entry(struct odb_source_packed *store,
 		}
 	}
 
+	/*
+	 * Recovery for a concurrent-repack race: a MIDX can name an owning
+	 * pack for an object that a simultaneous repack has since deleted,
+	 * even though the object still exists in another pack the same MIDX
+	 * covers (e.g. a kept base pack that geometric repack did not rewrite).
+	 * If the object is present in a MIDX yet none of the paths above could
+	 * serve it, its recorded owning pack has become unavailable.  The
+	 * regular fallback above deliberately skips MIDX-covered packs, so
+	 * scan this MIDX's packs directly to find the surviving copy.  The
+	 * bsearch gate keeps genuine misses (objects absent from the MIDX) on
+	 * the fast path.
+	 */
+	if (store->midx) {
+		struct multi_pack_index *m = store->midx;
+		uint32_t midx_pos, i;
+
+		if (bsearch_midx(oid, m, &midx_pos)) {
+			for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
+				struct packed_git *p;
+
+				if (prepare_midx_pack(m, i))
+					continue;
+				p = nth_midxed_pack(m, i);
+				if (p && packfile_fill_entry(p, oid, e))
+					return 1;
+			}
+		}
+	}
+
 	return 0;
 }
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 68143cb5b7..2b8ff6f3ed 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1393,4 +1393,44 @@ test_expect_success 'pack.preferBitmapTips interprets patterns as hierarchy' '
 	)
 '
 
+test_expect_success 'lookup recovers object whose midx-owning pack was removed' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# "keep" ends up only in the big pack; "dup" is deliberately
+		# placed in two packs so the midx has to choose an owner.
+		test_commit keep &&
+		echo duplicated-content >dup &&
+		git add dup &&
+		git commit -m dup &&
+		dup_oid=$(git rev-parse HEAD:dup) &&
+
+		# Roll every object, including dup, into a single big pack.
+		git repack -adq &&
+
+		# Build a second, "moderate" pack that also contains dup, so dup
+		# now lives in two packs that the midx will cover.
+		moderate=$(echo "$dup_oid" |
+			git pack-objects --quiet $objdir/pack/pack) &&
+
+		# Attribute dup to the moderate pack in the midx.
+		git multi-pack-index write \
+			--preferred-pack="pack-$moderate.idx" &&
+
+		# Simulate a concurrent "git repack" retiring the moderate pack:
+		# its files disappear, but the now-stale midx still names it as
+		# the owner of dup.  A valid copy of dup survives in the big pack.
+		rm -f $objdir/pack/pack-$moderate.* &&
+
+		# The midx routes the lookup to the deleted pack, and the regular
+		# pack fallback skips midx-covered packs, so without recovery dup
+		# would appear missing even though it is physically present.
+		echo blob >expect &&
+		git cat-file -t "$dup_oid" >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget
