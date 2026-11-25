Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648287;
	b=GuhHX/gGU9B3PGaqflzSNfC4tlwldhrTVZbFgVFiaZYym12B/wzUkp05JV2guLZ/1w1P
	 02MjVo7Ohu3kNLMm/4BcwQ9X3VNHOEWUC6Iokco/7+GPP6xTJmVbGuXzLH2hPMoAg39YE
	 t/+ckWeBlTNk+vi7Szjk2IBYebcOo0AWNlLKseMIOmOV27zpv7J1i3oGHs7ainhhC/F2L
	 ZDEXwhC7pbrWkt+JhgqqKR+z9becThjWsw2bCY65S8V0E1bOsxE7bsiVtWtI9kKYFw386
	 ugXmnSM5jFT/6jTk6gZWwewW3IMRwudsiU/aXBHxMElsf9cMQe/bSCgHTKbK8Eng/mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=t8/UXvo53nBrbSab/JvzJ9/PLWNS8stHuTagzPp9IjI=;
	b=TOhH2jIirpQC78TphhJI9G1dPek6c6GgIXEKjcB0Sj1Vrm/w7uyesK2CBSO+oJRwjfKq
	 Rpr88daNGmGuHATdLvKY7xLuRw0mxOORkReNS0CNWBYwGyp/EyHd/sSCCdZqgEoeYeMuH
	 S6/ESfJDkesP9dhlO7vBvTyzD7pYa91sr+rutWdLS8VBqVMQ2RWk7hTiHa/0ie7cn6aRu
	 kunEkEkum38trJgPQk9EwAbPB3xeEfbA6RD+/CJwUCzXWvNHHurlkXkMr+x1j5bJKa+/P
	 Z7beun875ysCSC97jC9NinAil9UNv14rK+GkHiAQhkv9JZnzIlZ6ikeX7pqQ/IZMuQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L163PaVC;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A938606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 23:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A938606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L163PaVC
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-71b45386310so3003772eaf.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 15:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795648285; x=1796253085; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t8/UXvo53nBrbSab/JvzJ9/PLWNS8stHuTagzPp9IjI=;
        b=L163PaVCTFa9H+Ehe9JhuDk282JZeLSXPjX13ymRXK3z13OBrfFL3vygQAeWeSeNlg
         zUWWeG2Sn69YlTNmtxVArS5k3qXqahZzXz7sbTtlnXKsD+7MiQgkfdzu8FJ2Wk8xCKjo
         N7TmRl9AcgUHJFUz4XjTxL/TJ1/9H4NdsmlHqVZZLR0Oi+DrLEXDyH8bRflqHsg7K2Se
         O4zXiVTy9AaKAVCindhEta/z7FAm+s7PZkm47+6F0wBOHmcxhYYbXs75ab3K6M5pe5Su
         9NZsnE9gIx0dIWXaoFJN2M9aVAzU53rJnKWl29aIR5gNuVKHtWsc3ooP1F5mQef4z166
         Dd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795648285; x=1796253085;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8/UXvo53nBrbSab/JvzJ9/PLWNS8stHuTagzPp9IjI=;
        b=HVMh/ojqpq9i9Wsc3fisCjxS6ekpfP1v34onelU42ST42DVIPySG5MPlLgvvG1DOor
         /gIcW+bmKG6eYXCxAYUSFaMtQmQblIFY2SW9fkfifK8ONYHKMwH2OyZo07z2jmQRIeTQ
         z37mZ/DjSxEdGrw1QEK6X2yNb3b4tBJmMpcH607POy89YP+57cz2JIHowidsSKTWo5HR
         +HKwrNNZ/YejbpdZcvVohQmE9ZmxPmNIXSU1jPObZhs84sgYdT1Gf2cqkTMTTdzW1g7G
         PwaibAjM2vlgmERoZ740reJa6CshyhOPDc/iLJh3geBJOtIAtzn0YGjmNXYl1BraYqlR
         QZpw==
X-Gm-Message-State: APuU4Z9wUgsW0jW+CVlDntsbCjLF8pIKY1c/razBuo6BF31pP6b4MrXa
	qzv9K82CE8pFnjJlsWwP0Ye+ldQISR74luqzQ1gNsuCQpZkN16Cn6G007Wv8CQ==
X-Gm-Gg: AZFdTZdlek/Rdc7P8I2kRcLvh94neABjGg4xvzKr+065K/wSgccnZlgaMtsEgSTcJqc
	DZ4MTgsTqz3FWWYsmWQtyE9sPNApV6Xnd56cZy2jUQ+eWQsFQX4MxzViWsarYCvDqZr+JCJZESw
	kfZwQPUpTzZjo/6nxwvShwVY72f7+c2cV1zcgB7qOEFPQdDBG6DVtEZ4HU1aGXmRIIMIhV+4BtZ
	yFvppj+MJQu/oqKA6NlBuc0oG1tOd7dH4j+G/Vj7xeI6y0fyNMcFbrck4qUWtyB8eCdZOqcAzhB
	DfHSa6FpyzkmY/Lx0uCGuM5z1eQ1vnfs69xMCouaLEnD2KAhEXU+0NYvDnGldqWCYPG9FqQaS+R
	fGy1FAUZPvcJQhFDvhIQv6S+lzyMy6Sie61l7N/Ix/eF2DTqRxrevPBPION/7lnvijfHTDmDp40
	fQGoVt2S0O53R23R/ne9AXUoG261bFRCXMwxXUITAQptUeGiY/z9oquP5p+TT7Aivxa3AzkmXja
	ES3ZiFqE1TVy4vHgm5XxCIvb0k20i6uLwmFB0RalV+MmwjsmgAfwfkB398DG4FX8HMZQPyfGsLK
	xYt0JPvSrMe6G4vOJrZ8+r7sfRisWUxnizLwfF45zW6ouYG2CEzKw7M=
X-Received: by 2002:a05:6820:61e:b0:71b:7883:8d89 with SMTP id 006d021491bc7-71b7883ae62mr4281864eaf.66.1795648285372;
        Wed, 25 Nov 2026 15:11:25 -0800 (PST)
Received: from [127.0.0.1] ([64.236.153.102])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc61659cb8sm19015959fac.17.2026.11.25.15.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:11:23 -0800 (PST)
Message-Id: <pull.2333.v3.git.1795648282594.gitgitgadget@gmail.com>
In-Reply-To: <pull.2333.git.1795635624820.gitgitgadget@gmail.com>
References: <pull.2333.git.1795635624820.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 23:11:22 +0000
Subject: [PATCH v3] pack-objects: handle missing promisor objects
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
Cc: Alessio Attilio <attilio.alessio@protonmail.com>,
    Alessio Attilio <attilio.alessio@protonmail.com>

From: Alessio Attilio <attilio.alessio@protonmail.com>

Objects missing from a partial clone are expected to be absent.
When checking whether an object is in a promisor pack, do not BUG()
if its object info cannot be read. Such an object cannot be included
in the pack, so skip it.

Pass OBJECT_INFO_SKIP_FETCH_OBJECT explicitly so the lookup does not
trigger a lazy fetch.

Test filtered --unshallow and --deepen fetches, as well as a subsequent
fetch that repacks links to promisor commits with missing trees.

Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
---
    pack-objects: handle missing promisor objects
    
    Changes since v1:
    
     * Pass OBJECT_INFO_SKIP_FETCH_OBJECT explicitly to avoid lazy fetching
       during the lookup.
     * Cover filtered --unshallow and --deepen fetches, and a later fetch
       after unshallowing a filtered clone.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2333%2Fkairosci%2Fattilio%2Fpack-objects-missing-promisor-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2333/kairosci/attilio/pack-objects-missing-promisor-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2333

Range-diff vs v2:

 1:  a7e378ca3d ! 1:  cbe2fc475c pack-objects: handle missing promisor objects
     @@ builtin/pack-objects.c: static int is_not_in_promisor_pack_obj(struct object *ob
       
      
       ## t/t5616-partial-clone.sh ##
     -@@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non-promisor commits, gc work
     - 	git -C partial gc --prune=now
     +@@ t/t5616-partial-clone.sh: test_expect_success 'merge does not lazy-fetch locally written objects' '
     + 	done &&
     + 	test_cmp server/only-in-C client/only-in-C
       '
     - 
      +for opt in --unshallow --deepen=1
      +do
      +	test_expect_success "filtered fetch $opt of a moved ref repacks local links" '
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +	git -C target rev-parse --verify refs/remotes/origin/main &&
      +	git -C target fsck
      +'
     -+
       
       . "$TEST_DIRECTORY"/lib-httpd.sh
       start_httpd


 builtin/pack-objects.c   |  7 +++--
 t/t5616-partial-clone.sh | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 87c3102e62..371f16c59b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5135,8 +5135,11 @@ static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
 		.source_infop = &source_info,
 	};
 
-	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
-		BUG("should_include_obj should only be called on existing objects");
+	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info,
+					  OBJECT_INFO_SKIP_FETCH_OBJECT)) {
+		/* Missing; assume it is a promisor object. */
+		return 0;
+	}
 	return source_info.source->type != ODB_SOURCE_PACKED || !source_info.u.packed.pack->pack_promisor;
 }
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 9636652362..44ce9a1ee8 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -790,6 +790,61 @@ test_expect_success 'merge does not lazy-fetch locally written objects' '
 	done &&
 	test_cmp server/only-in-C client/only-in-C
 '
+for opt in --unshallow --deepen=1
+do
+	test_expect_success "filtered fetch $opt of a moved ref repacks local links" '
+		test_when_finished "rm -rf source target" &&
+
+		git init source &&
+		test_commit_bulk -C source 4 &&
+		git -C source config uploadpack.allowFilter true &&
+		git -C source config uploadpack.allowAnySHA1InWant true &&
+		COMMIT=$(git -C source rev-parse main~1) &&
+
+		git init target &&
+		git -C target remote add origin "file://$(pwd)/source" &&
+		git -C target fetch --no-tags --depth=1 origin "+$COMMIT:refs/remotes/origin/main" &&
+
+		# The fetched pack has the new tip whose parent is the local shallow
+		# tip, so index-pack repacks it into a promisor pack. That process
+		# inherits the shallow file and walks into promisor commits whose
+		# trees do not exist.
+		git -C target fetch --no-tags --filter=tree:0 "$opt" origin \
+			+refs/heads/main:refs/remotes/origin/main &&
+		git -C target rev-parse --verify refs/remotes/origin/main >actual &&
+		git -C source rev-parse --verify refs/heads/main >expect &&
+		test_cmp expect actual &&
+		git -C target fsck
+	'
+done
+
+test_expect_success 'repacking local links tolerates missing trees of promisor commits' '
+	test_when_finished "rm -rf source target" &&
+
+	git init source &&
+	test_commit_bulk -C source 4 &&
+	git -C source config uploadpack.allowFilter true &&
+	git -C source config uploadpack.allowAnySHA1InWant true &&
+	COMMIT=$(git -C source rev-parse main~1) &&
+
+	# Fetch a single commit as a non-promisor object, then unshallow it
+	# with a filter that omits trees. The commits below the former
+	# shallow boundary are now promisor objects whose trees are missing.
+	git init target &&
+	git -C target remote add origin "file://$(pwd)/source" &&
+	git -C target fetch --no-tags --depth=1 origin "+$COMMIT:refs/remotes/origin/main" &&
+	git -C target fetch --no-tags --filter=tree:0 --unshallow origin \
+		"+$COMMIT:refs/remotes/origin/main" &&
+	test_path_is_missing target/.git/shallow &&
+
+	# Fetching a descendant of the local non-promisor commit causes
+	# index-pack to repack that commit into a promisor pack. The revision
+	# walk must not die when it reaches the missing trees of promisor commits.
+	git -C target fetch --no-tags --filter=tree:0 origin \
+		+refs/heads/main:refs/remotes/origin/main &&
+	git -C target rev-parse --verify refs/remotes/origin/main &&
+	git -C target fsck
+'
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

base-commit: acba8bf9753134d9bde89f94369f775838a8c5fe
-- 
gitgitgadget
