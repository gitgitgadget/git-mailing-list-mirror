Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7107F47F
	for <git@vger.kernel.org>; Wed, 22 May 2024 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716413092; cv=none; b=oGJV/ygIwW31eQcvUTjP7UVBzDjaVWcwtwrB0yPVr/6a408KpQqf5ML6LJn0JdCyHIoNRjugqoGzCa71mz4haC3owPjGWc/r19PSpBGwp9Yf53Kgtsv9PHlgWoAmhaTahnZEqLL01OEHBc3b0JW3y8kfh1FSoBeOoSxinJBxRYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716413092; c=relaxed/simple;
	bh=3uRSao06hA5YQyKscz82MMkj5xih/W4k0pHIELkilUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cT7Hix/ZQzv8nckz6GaEUHq04wz46T7B0Y55KsVsS4m9FFzGk0pHvYmH3u1RbQrQt8xK2ZlJdNuhbfj9xiKC5aaVAlW3roDD2T9XcMl2Nq8w9CHRM37ODWwUte9I1XnaP8xuozu9VP4T3UnkfVrRXwVaud27c1uDIz+cEkF0wI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Ac56VzEf; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Ac56VzEf"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716413087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JMHl3gNEvta38OeuNH5so5R6fZ57WgOegMfU0XgT7eI=;
	b=Ac56VzEfinGcxiJpIIv8sgqiIVY5TeeM6rXTZFTu71S9wfCM27PsEYQ9RGEtsO+hUH5NdX
	RfkJDF/tYmC8s5PC64bz34r/Drj9NZQYNa4rcxff9hRAaboO0eEBuYd0x4AzM/rhKTJ1Pu
	3BidxeCB3s8Crd1k2RObMkXKe1IANfU6Yi95R4NzqyBolqFzS2LtTkQGUjHHcSM7CM42Ze
	Qj3ENyj6ZB7WFLpMBJrNkC/Wg7jD7MmDfd79g5tgmUGjgLZoYeYjwMUnTAqQgItL6ZsVwY
	Zo79oiGP0qav3cUTr8f6mn2xOZdLkAb3yzyMuY+LdFANMepIYiCAv0Lht2y0QA==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rjusto@gmail.com,
	sunshine@sunshineco.com
Subject: [PATCH v2] doc: imply that interactive.singleKey is disabled by default
Date: Wed, 22 May 2024 23:24:43 +0200
Message-Id: <7da73f15a018d858519eefa373001ccb3eaf32e2.1716412958.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Make it clear that the interactive.singleKey configuration option is disabled
by default, using rather subtle wording that avoids an emphasis on the actual
default value.  This should eliminate any associated doubts.

While there, touch up the remaining wording of the description a bit.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v2:
      - As agreed upon with Junio, [1] switched to more subtle wording that
        does not explicitly mention the default value.
    
    [1] https://lore.kernel.org/git/xmqqttip379x.fsf@gitster.g/
    
    Link to v1: https://lore.kernel.org/git/3141fe9f7328a97bf3818748421f6ae929120626.1716363167.git.dsimic@manjaro.org/T/#u

Range-diff against v1:
1:  3141fe9f7328 ! 1:  7da73f15a018 doc: note that interactive.singleKey is disabled by default
    @@ Metadata
     Author: Dragan Simic <dsimic@manjaro.org>
     
      ## Commit message ##
    -    doc: note that interactive.singleKey is disabled by default
    +    doc: imply that interactive.singleKey is disabled by default
     
         Make it clear that the interactive.singleKey configuration option is disabled
    -    by default.  This should eliminate any associated doubts.
    +    by default, using rather subtle wording that avoids an emphasis on the actual
    +    default value.  This should eliminate any associated doubts.
    +
    +    While there, touch up the remaining wording of the description a bit.
     
         Signed-off-by: Dragan Simic <dsimic@manjaro.org>
     
    +
    + ## Notes ##
    +    Changes in v2:
    +      - As agreed upon with Junio, [1] switched to more subtle wording that
    +        does not explicitly mention the default value.
    +
    +    [1] https://lore.kernel.org/git/xmqqttip379x.fsf@gitster.g/
    +
    +    Link to v1: https://lore.kernel.org/git/3141fe9f7328a97bf3818748421f6ae929120626.1716363167.git.dsimic@manjaro.org/T/#u
    +
      ## Documentation/config/interactive.txt ##
    -@@ Documentation/config/interactive.txt: interactive.singleKey::
    - 	linkgit:git-add[1], linkgit:git-checkout[1],
    +@@
    + interactive.singleKey::
    +-	In interactive commands, allow the user to provide one-letter
    +-	input with a single key (i.e., without hitting enter).
    +-	Currently this is used by the `--patch` mode of
    +-	linkgit:git-add[1], linkgit:git-checkout[1],
    ++	When set to true, allow the user to provide one-letter input
    ++	with a single key (i.e., without hitting the Enter key) in
    ++	interactive commands.  This is currently used by the `--patch`
    ++	mode of linkgit:git-add[1], linkgit:git-checkout[1],
      	linkgit:git-restore[1], linkgit:git-commit[1],
      	linkgit:git-reset[1], and linkgit:git-stash[1].
    -+	This is disabled by default.
      
    - interactive.diffFilter::
    - 	When an interactive command (such as `git add --patch`) shows

 Documentation/config/interactive.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/interactive.txt b/Documentation/config/interactive.txt
index 5cc26555f19a..8b876cb4eb8e 100644
--- a/Documentation/config/interactive.txt
+++ b/Documentation/config/interactive.txt
@@ -1,8 +1,8 @@
 interactive.singleKey::
-	In interactive commands, allow the user to provide one-letter
-	input with a single key (i.e., without hitting enter).
-	Currently this is used by the `--patch` mode of
-	linkgit:git-add[1], linkgit:git-checkout[1],
+	When set to true, allow the user to provide one-letter input
+	with a single key (i.e., without hitting the Enter key) in
+	interactive commands.  This is currently used by the `--patch`
+	mode of linkgit:git-add[1], linkgit:git-checkout[1],
 	linkgit:git-restore[1], linkgit:git-commit[1],
 	linkgit:git-reset[1], and linkgit:git-stash[1].
 
