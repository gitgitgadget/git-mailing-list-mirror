Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116200;
	b=ekphK4gL6+pc80a066eiPoaJPt/lT75h7pGx1Q5xNkv6xBKMKlrFIi6842Wlae7P9Xos
	 2vHVPhe+GgmhiKeeUpSz99xSUOSU/UDTBiK/FiUVTwc8cNHakg1yjLVSczhgi/X0mq+40
	 VyDtwJ4v8VVvalUWa/C9U2gDm6+NP1nfogv9feFzn31UfEINKTXf87yxrVyIVa4TQ6lRV
	 VfoE7FT8Ael8wPoPWPmArnz+Vb/UMp9026/PkS1cBgF7ehatROAcN89UuRdT8hL08UQlP
	 jKG4RRVMooIHK6XoKdShvg91nTt8BGmRmD13aShXX7wXDO9m1DdUK+/EKQSPtqPr/Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=Ao2xJHBC/1U+S0ToTgL9ZqkzBGZpJYHrnznFLLa1mqQ=;
	b=e3T7l/VqFk8o7Gx29ZQs7+FKiSNuEtMcFmRBubXiH6I0JNfvKrp/YegTo2RRr5bXn2DQ
	 a9KgXL/Z9cDeMzu0ZOqRiRF+6iLE0cH4ncyh7TIUDzR+TviRMQVdQDTOLJPCpwjrMxyA0
	 f0th2TLeP2Z8OpjCsRVROjfBa/rEw3gOIL1s12q2dEaZQihJfzKcP0I3gm08WnZWltPsF
	 14fWSweV8ra2ILZ7KClXPgFrFPXctFaFO0eJorV3P2KUVctn131KJprpJMnCj0jhoDBkS
	 IZKZSYmqYvGu4UX9l1BFb9rI7OGne2EMIditYb5MUt8JJm2p8fNnGSe/UIOsyFlV8qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="BFrWlKq/";
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96960606A330
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 19:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96960606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BFrWlKq/
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c50547b4992so7402166b.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116198; x=1795720998; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ao2xJHBC/1U+S0ToTgL9ZqkzBGZpJYHrnznFLLa1mqQ=;
        b=BFrWlKq/JQmFbHp/uRpgDIRILNVY1+YkWgR0xPi6mGCAEjfXCoGF97bNFosf0uaFSs
         oA5dek4v0WerkLTxsNiBzSXLYchsvj9tpG9RQz+WTDzUpjbDxESo93jJ8RbMDXfZM+Mw
         mWQj7beWvJS8QleNCxNoaPy+71lgNDj7TM10CNeSv0bKXutsegc4cBzclxUT1aS9TUkp
         PGNSbAxvj3/oawNs3L+6vYZ+S2a4Kk3DrdxMKGFJ8v6tKmTOWI2aywKnnl1QtYeyEn/n
         X4xmMjbTa64qduG8h3NlxhdEeWYzfaPHfhm981UluK7Nqamezd5acNRRdwhHf/4tTqAa
         cG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116198; x=1795720998;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ao2xJHBC/1U+S0ToTgL9ZqkzBGZpJYHrnznFLLa1mqQ=;
        b=tqgokM8y9RbFWVHroEw53FjIL0yeD4ovWJpS/olVb5dfS/k6QLzUE+UAWeQqyJMcl9
         7nX5DgG4WRnDnNzv2Eek7Pj1GRNMwzuwBHkh3BajY242EC9Sswo+y3CYX92l5v+9ALPN
         PEIkoXfe5ZMiZcKH2ZtjNHxcNu9o7d7BzNFEUJFNGsfFVgexoJw4uY5o3ZOzv0EiWcZ3
         tESDXwSs/2sbeIYXuVevcIVxVbexPJW3OLBmKtw2hijxl3nKF9lDBj+Gm2N1Xscixe99
         +7ePuPW4d3YRHcC1KRcVnmluRmoiIyWfCaksUP47Z8gkO0pHcI7+3JsTTGjC4if2XY4L
         +oaw==
X-Gm-Message-State: APuU4Z/gZ2Sn9zLbmaun4eR/QWSAIfxPgrsPWOAg+cHEgcQ7En0v2SLp
	BmqzublhE5VochjW7w5jAEYq56HsEyzxKoS+hBQr2WG9NcAi508DvseziLA4Gl7UavqcT7PyHRo
	n7SABxMcTJ7wAAWX+OXCfnGoV/glDEXvfsojLLt0fbLGzRdNtuskWukJwjIuQWHXB8ru9+CUme3
	Jvp+q/2YUxcCJBepjSmqgoKQ==
X-Received: from ejbdx3.prod.google.com ([2002:a17:906:a843:b0:c4d:2eea:d325])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:a890:b0:c40:5ee3:8698
 with SMTP id a640c23a62f3a-c513ab0efcbmr106717166b.31.1795116197705; Thu, 19
 Nov 2026 11:23:17 -0800 (PST)
Date: Thu, 19 Nov 2026 20:23:16 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192316.2688525-1-dmnk@google.com>
Subject: [PATCH] filter-branch: check hex oids in state-branch map
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Grant Moyer <dev@grantmoyer.com>, 
	Michele Locati <michele@locati.it>, Patrick Steinhardt <ps@pks.im>, dmnk+artist@google.com, 
	Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

When "--state-branch" loads an existing "filter.map" blob,
git-filter-branch splits each "from:to" line (restored to "from:to"
order in 4811dabed7 (filter-branch: fix commit map init from state
branch, 2026-10-02)) and writes "../map/$from_commit" without checking
that "$from_commit" or "$to_commit" contains valid hexadecimal object
IDs.

A malformed or untrusted state branch whose "filter.map" contains empty
keys, slashes, backslashes, or ".." segments writes outside
"$tempdir/map" instead of failing cleanly.

Read lines with "IFS= read -r line", and require "$from_commit" to be
non-empty lowercase hex and "$to_commit" to contain only lowercase hex
digits and spaces (allowing empty "$to_commit" for pruned commits)
before writing "../map/$from_commit".

Signed-off-by: Dominik Maier <dmnk@google.com>
---
 git-filter-branch.sh     | 14 ++++++++++++--
 t/t7003-filter-branch.sh | 19 +++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 9aa07be6e1..fbf7882a70 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -298,13 +298,23 @@ then
 
 		git show "$state_commit:filter.map" >"$tempdir"/filter-map ||
 			die "Unable to load state from $state_branch:filter.map"
-		while read line
+		while IFS= read -r line
 		do
 			case "$line" in
 			*:*)
 				from_commit=${line%:*}
 				to_commit=${line#*:}
-				echo "$to_commit" >../map/"$from_commit";;
+				case "$from_commit" in
+				"" | *[!0-9a-f]*)
+					die "Unable to load state from $state_branch:filter.map"
+					;;
+				esac
+				case "$to_commit" in
+				*[!0-9a-f\ ]*)
+					die "Unable to load state from $state_branch:filter.map"
+					;;
+				esac
+				printf '%s\n' "$to_commit" >../map/"$from_commit";;
 			*)
 				die "Unable to load state from $state_branch:filter.map";;
 			esac
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 801cc83e5e..cab97e0e0b 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -560,4 +560,23 @@ test_expect_success 'filter-branch handles ancestor rewrite' '
 	git diff-tree HEAD^ ancestor
 '
 
+test_expect_success 'state-branch rejects non-hex or path-traversing filter.map entries' '
+	test_when_finished "rm -f escaped && git update-ref -d refs/heads/bad-state" &&
+	bad_blob=$(printf "../../escaped:injected\n" | git hash-object -w --stdin) &&
+	bad_tree=$(printf "100644 blob %s\tfilter.map\n" "$bad_blob" | git mktree) &&
+	bad_commit=$(echo "bad state" | git commit-tree "$bad_tree") &&
+	git update-ref refs/heads/bad-state "$bad_commit" &&
+	test_must_fail git filter-branch -f --state-branch refs/heads/bad-state HEAD 2>err &&
+	test_grep "Unable to load state from refs/heads/bad-state:filter.map" err &&
+	test_path_is_missing escaped &&
+
+	head_oid=$(git rev-parse HEAD) &&
+	bs_blob=$(printf "%s\\\\:%s\n" "$head_oid" "$head_oid" | git hash-object -w --stdin) &&
+	bs_tree=$(printf "100644 blob %s\tfilter.map\n" "$bs_blob" | git mktree) &&
+	bs_commit=$(echo "backslash state" | git commit-tree "$bs_tree") &&
+	git update-ref refs/heads/bad-state "$bs_commit" &&
+	test_must_fail git filter-branch -f --state-branch refs/heads/bad-state HEAD 2>err &&
+	test_grep "Unable to load state from refs/heads/bad-state:filter.map" err
+'
+
 test_done
-- 
2.56.1.750.gf70dc682cf-goog

