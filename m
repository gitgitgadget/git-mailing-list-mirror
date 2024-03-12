Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8E55E73
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240196; cv=none; b=frFCRql4Juyf8eZcAOmNVSXqmlZyP5cgXdwbx0EO4Gr+7yqDBaqmMA6sBcehGYfbZLB9he4CPumsUZHCQI4VZJ713WIZOyhQGkFQFPtrfa+iTdOocxLZB5abb/S9UrofBRtob6nkGSjcNYa4DdRPhbXXfvzwwUwI4XORpmlgQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240196; c=relaxed/simple;
	bh=JNGuKSJ5lNsSsbnRbgcT4I2wGBIyr+tSHTrQae6GZQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieA1pqgvG/vn5DGUHaWTwj4vB9UhFTIGxF2cgqGLfizE5ot6qyHC0cROuNi7jCk31/tXGO0WDYJf7I53DuCSxEXW0cEbDedRxEYNS6gUkiSGqVwB5ORU/Qn6XScW6fWRNea7dlmS/4oaNJKdLigDLoAt5sFDDLlsi73q04ByJjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=Cq8DR+s2; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="Cq8DR+s2"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42CAh6CI002833
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 Mar 2024 11:43:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710240186; bh=JNGuKSJ5lNsSsbnRbgcT4I2wGBIyr+tSHTrQae6GZQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cq8DR+s2WPS1ya7Nq/9dvf517l5bflpgKBawK1p6751KWzGjMLdgrquUI19uzoqwT
	 K2ymoBi/xsnUhcXlpK7MPcfJa9DuPw/NicRfRSVoG8lqqW6Ru0NoKpGNgk9Zd+CjPk
	 dJX/aGp32zs5LjbyPWQVJWrO+WBvApOGRInS+C68=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>
Subject: [PATCH v2 0/1] Documentation/user-manual.txt: try to clarify on object hashes
Date: Tue, 12 Mar 2024 11:41:55 +0100
Message-ID: <20240312104238.4920-1-dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709240261.git.dirk@gouders.net>
References: <cover.1709240261.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the second round of adding a hashing example to user-manual.txt.
---
Changes in v2:
- Do not go into detail about hashing in the history.
- Change code according to coding guidelines.
- Fix a typo (s/asume/assume/) and change the wording of that sentence.
- Write Git instead of `git`.
- To fit the whole document, change sample content to "Hello world", lentgh 12.
- Add verification of hash using `git hash-object`.
- Provide for empty lines around code blocks.
---
Dirk Gouders (1):
  Documentation/user-manual.txt: example for generating object hashes

 Documentation/user-manual.txt | 36 +++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  6995f866e7 ! 1:  568c59d69f Documentation/user-manual.txt: example for generating object hashes
    @@ Metadata
      ## Commit message ##
         Documentation/user-manual.txt: example for generating object hashes
     
    -    If someone spends the time to work through the documentation, the
    -    subject "hashes" can lead to contradictions:
    +    Add a simple example on how object hashes can be generated manually.
     
    -    The README of the initial commit states hashes are generated from
    -    compressed data (which changed very soon), whereas
    -    Documentation/user-manual.txt says they are generated from original
    -    data.
    -
    -    Don't give doubts a chance: clarify this and present a simple example
    -    on how object hashes can be generated manually.
    +    Further, because the document suggests to have a look at the initial
    +    commit, clarify that some details changed since that time.
     
         Signed-off-by: Dirk Gouders <dirk@gouders.net>
     
      ## Documentation/user-manual.txt ##
    -@@ Documentation/user-manual.txt: that is used to name the object is the hash of the original data
    +@@ Documentation/user-manual.txt: that not only specifies their type, but also provides size information
    + about the data in the object.  It's worth noting that the SHA-1 hash
    + that is used to name the object is the hash of the original data
      plus this header, so `sha1sum` 'file' does not match the object name
    - for 'file'.
    - 
    -+Starting with the initial commit, hashing was done on the compressed
    -+data and the file README of that commit explicitely states this:
    -+
    -+"The SHA1 hash is always the hash of the _compressed_ object, not the
    -+original one."
    +-for 'file'.
    ++for 'file' (the earliest versions of Git hashed slightly differently
    ++but the conclusion is still the same).
     +
    -+This changed soon after that with commit
    -+d98b46f8d9a3 (Do SHA1 hash _before_ compression.).  Unfortunately, the
    -+commit message doesn't provide the detailed reasoning.
    ++The following is a short example that demonstrates how these hashes
    ++can be generated manually:
     +
    -+The following is a short example that demonstrates how hashes can be
    -+generated manually:
    ++Let's assume a small text file with some simple content:
     +
    -+Let's asume a small text file with the content "Hello git.\n"
     +-------------------------------------------------
    -+$ cat > hello.txt <<EOF
    -+Hello git.
    -+EOF
    ++$ echo "Hello world" >hello.txt
     +-------------------------------------------------
     +
    -+We can now manually generate the hash `git` would use for this file:
    ++We can now manually generate the hash Git would use for this file:
     +
     +- The object we want the hash for is of type "blob" and its size is
    -+  11 bytes.
    ++  12 bytes.
     +
     +- Prepend the object header to the file content and feed this to
    -+  sha1sum(1):
    ++  `sha1sum`:
     +
     +-------------------------------------------------
    -+$ printf "blob 11\0" | cat - hello.txt | sha1sum
    -+7217614ba6e5f4e7db2edaa2cdf5fb5ee4358b57 .
    ++$ { printf "blob 12\0"; cat hello.txt; } | sha1sum
    ++802992c4220de19a90767f3000a79a31b98d0df7  -
     +-------------------------------------------------
     +
    ++This manually constructed hash can be verified using `git hash-object`
    ++which of course hides the addition of the header:
    ++
    ++-------------------------------------------------
    ++$ git hash-object hello.txt
    ++802992c4220de19a90767f3000a79a31b98d0df7
    ++-------------------------------------------------
    + 
      As a result, the general consistency of an object can always be tested
      independently of the contents or the type of the object: all objects can
    - be validated by verifying that (a) their hashes match the content of the
    +@@ Documentation/user-manual.txt: $ git switch --detach e83c5163
    + ----------------------------------------------------
    + 
    + The initial revision lays the foundation for almost everything Git has
    +-today, but is small enough to read in one sitting.
    ++today (even though details may differ in a few places), but is small
    ++enough to read in one sitting.
    + 
    + Note that terminology has changed since that revision.  For example, the
    + README in that revision uses the word "changeset" to describe what we
-- 
2.43.0

