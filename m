Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650163;
	b=4MtvZnYrj27FO/alAZkH70wcjHXyJA2x8q2mzDrK7PJIRrwr2/LCe4TYMGlyoD+LEv+e
	 yrcgAoDKL2jYAOhKdpLktwOr6UXCatFuHM6+z1reqUwSREnswDecHjYZkidWimXHwuZYB
	 XyxUc/Q1wXLzDRBHueykxossmJwc+EC6yqnmzZSL2N72ntx99DVZpYSF4ywdpjYbvZ4a4
	 V/yf8FXnX5lDECioq76qYbHBjZJHO+tLqKS4YUJFbnon7VQcYfa+14R13D01EoIBBKDHl
	 D2ahC9BzFrz6UdSAg+zq4hgBiTjzX1Hv5l8XJcz2tlEKtX/K5/qqc/XAuet2vj8eBSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=VkYgdjnsNaBkfhoy/0So4IwHBSrUNaLTAQ4eCOoBknE=;
	b=dfF/vyyUF/fqr4LziWZDNMcxwRJW+RlXf1pIrmRX9p06lDVpPOKKmaVDwAxKQRrPBCe3
	 lD/8HxrMv49X/GyU1bwtCdNpaZ0v1YsiJXtI9hswerCcS6ew8KN/pcb7wLw8iqjjN3EUa
	 asfcxlOO3qvPKN0N9b5/Th+28xdK44PuQQvwzw/ii/bLnmbgEnPVb5sDyvnTKXJNpiJyT
	 rELjWEDxZQxYMAh3T1mgpsSCthFC47IP65ykWrkZU4NNmT7vFtTcWQz3UdJQPqTERdoxz
	 C+lBF7AynT0eR1wiG2oESTnYnHZiV0THMkNFhxKooSfjROCEqRIg3DyvxSDt2CR6+ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HB8e/hby";
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C4606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 23:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D4C4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HB8e/hby
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so4418796c88.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 15:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795650162; x=1796254962; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VkYgdjnsNaBkfhoy/0So4IwHBSrUNaLTAQ4eCOoBknE=;
        b=HB8e/hby+AD+7k4d+qi5ZKm/b3R7fF/mb2nOmfbeNnPQmRPGiluYwRuEs1H0R4mVbl
         RxFfUng2bkMCU3Xe4ZxFa9wn7rzDzYsiNiUL6ljWgbSjnEdEG+BYqjXwecmpdtEiYigK
         bcxCKmrtw19d3YFRQQJMcZHD6/lwAN7VlEOJToni4OjPKnUNgSvn8ijU7I9HlR2BerUc
         YfbjK3mVv6ctMzTudmWTGyluR56oPL5wBBcMDx/yjAkdC3sUPaCAAOblyTLb6hCNcgtk
         STIqGqvZ0rvKUOmlmc0kb7tszOAP+7WBBYFGXYhcHCpck9+3zOv8Jae3Xu7CwX+QaICD
         iAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795650162; x=1796254962;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VkYgdjnsNaBkfhoy/0So4IwHBSrUNaLTAQ4eCOoBknE=;
        b=GYV9lftdJj6+ySDA4aNq5vSVODZOMVMZtCgGGml5muQitgtNQ6RuvQIg7YImWkxmFz
         1rirbUSEr7tIudtC+KQrkmx0VDiz3Mr6sxoyLyxWTkta28k6vDZifWCcZMTx2gXzzk4A
         oQf9dUrfX5caemPFe/JTkC/kGifwhFIGLCkztsE1sbsp4tZ7vqVZe2a4guKFIOOKiHcb
         +KpUxib25wUM7kNwEu62Pen4GN26jS8wRYT1ecpr54cLQLQ5MkOgFXd0DGYMQ27j2Cfg
         /kwk0eEJyMow9wq3n/boBX96xB6cIW1iejAxx2YfD7Ko+4ZdWOpWAXHknB0vTRQQbrLp
         mFWA==
X-Gm-Message-State: APuU4Z+YEP9fFp8GckNj2GuSBQmINkG8PHCF6iqbXHy/XFjHZpbwYu3u
	ySnSlF4aceq+PnhTQ2AlNedHk9BFm39ALGBSyd84EvFHF6WOmwRUIKtw9XO4iQ==
X-Gm-Gg: AZFdTZf+I8eThsMpZ4Oh+X78PWVqhbB94vSMZAKIeCPvqdqCoCRwdtS+K6gzGiRhj0W
	cb9VwUr+D8W4FMwA/LC5TrtvSf6pLlRBAQU6odGr3/HbYYthZhMizRARRKZvDccxS+5w06h/Zqh
	PX1e/VZFsGLWa3Xm2FA0MHbE2am4jgbj3+SYltdlBFSnM3O9ERpu/ZtTRr4kRxpEtpdJu7+1kLu
	uHxkdnlpHQX1hYdumSfc00mriKbNrsyrdcpZVooTgWJ7rzNEwgkbDrHO0rIBX0Sa5ip7djCbfOG
	YG9VDr9UR5GvPfV+JmTEOeGQzIjbF7wEcvL6HfvumFpwaQALpA3C0nIEkII97a/Gur/WxDkWUeF
	x5PP0EUdF409ly/Qyd+PLj6fhJtPPeQ7sYmcj+NKYq9yw0oqg+kgwk+YwwDwXmZX2tqNG75hZjR
	YtdPk46XImisCcW1ZWnjb5iCsLWc5O2GxdJbKRhEXvr9RXABb5st6kL+XlEFeucylRHLbp89MCS
	lkiehWV4cPbhemTQmol/ppvdCS/vpe7fH8ho9YkyckQtDQxccCh9LmK5SHe2ATeaPG2EspXUJr+
	qQtmq8/NGJZ01+mL6pOXWAy4KDcdZQ==
X-Received: by 2002:a05:7023:a41:b0:1b2:649d:dc23 with SMTP id a92af1059eb24-1b556901b95mr20313016c88.35.1795650161870;
        Wed, 25 Nov 2026 15:42:41 -0800 (PST)
Received: from [127.0.0.1] ([57.151.138.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm51838503c88.5.2026.11.25.15.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:42:41 -0800 (PST)
Message-Id: <pull.2333.v5.git.1795650160536.gitgitgadget@gmail.com>
In-Reply-To: <pull.2333.git.1795635624820.gitgitgadget@gmail.com>
References: <pull.2333.git.1795635624820.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 23:42:40 +0000
Subject: [PATCH v5] pack-objects: handle missing promisor objects
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

During a filtered fetch in a partial clone, index-pack --promisor
repacks local links from the incoming pack into promisor packs. It
invokes pack-objects with --exclude-promisor-objects-best-effort to
skip links already stored in promisor packs. After a filtered
--unshallow or --deepen, this walk can encounter a promisor commit
whose tree is missing. The object-info lookup then hits a BUG and the
fetch fails.

Do not lazy-fetch while checking these links: this is a best-effort
repack, not a request to retrieve missing objects. If the object is
missing, pack-objects cannot include it, so treat it like an object
already in a promisor pack and continue. This callback is used only by
the best-effort repack started for an incoming promisor pack, whose
output is itself marked promisor. If the missing object was not
actually promised, this still cannot discard available data; the
object was already absent and any later access would fail unless the
promisor remote can provide it.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2333%2Fkairosci%2Fattilio%2Fpack-objects-missing-promisor-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2333/kairosci/attilio/pack-objects-missing-promisor-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2333

Range-diff vs v4:

 1:  b2112b07dd ! 1:  1129e6a3a6 pack-objects: handle missing promisor objects
     @@ Commit message
          pack-objects: handle missing promisor objects
      
          During a filtered fetch in a partial clone, index-pack --promisor
     -    re-packs local links from the incoming pack into promisor packs. It
     +    repacks local links from the incoming pack into promisor packs. It
          invokes pack-objects with --exclude-promisor-objects-best-effort to
          skip links already stored in promisor packs. After a filtered
          --unshallow or --deepen, this walk can encounter a promisor commit
     @@ builtin/pack-objects.c: static int is_not_in_promisor_pack_obj(struct object *ob
      -		BUG("should_include_obj should only be called on existing objects");
      +	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info,
      +					  OBJECT_INFO_SKIP_FETCH_OBJECT)) {
     -+		/* Missing; assume it is a promisor object. */
     ++		/*
     ++		 * This is the best-effort pass that repacks local links from an
     ++		 * incoming promisor pack. A missing object cannot be packed, so
     ++		 * skip it. If it was not promised, its data was already absent;
     ++		 * later access still needs a remote to provide it.
     ++		 */
      +		return 0;
      +	}
       	return source_info.source->type != ODB_SOURCE_PACKED || !source_info.u.packed.pack->pack_promisor;


 builtin/pack-objects.c   | 12 +++++++--
 t/t5616-partial-clone.sh | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 87c3102e62..713d6d970b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5135,8 +5135,16 @@ static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
 		.source_infop = &source_info,
 	};
 
-	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
-		BUG("should_include_obj should only be called on existing objects");
+	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info,
+					  OBJECT_INFO_SKIP_FETCH_OBJECT)) {
+		/*
+		 * This is the best-effort pass that repacks local links from an
+		 * incoming promisor pack. A missing object cannot be packed, so
+		 * skip it. If it was not promised, its data was already absent;
+		 * later access still needs a remote to provide it.
+		 */
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
