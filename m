Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0446333995
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538574; cv=none; b=uzWEV0BS9NFhGoIYa2Wp6XgGvA6JAqMWgVDfczlQZE41dJaBSK/aW+Ww8uETy3/05MtZcEfIAXKJGPv6xXgwpip7axjhEK56+Fmbwfapjas81WR7G5AYpRMwoIt4dNLudmMnMeqx2+4HKLXp0tYCszka+iycnTmrWWPgX8EiAq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538574; c=relaxed/simple;
	bh=6z2MSllONANuNTj+3dRNagoS6An1EGFPXWKSXBk9S8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McyqBRk0Wt4RHkm4ZfmoIWAA9iO46b3rhuUjggxFdPQR7WTTadaUxruTV6tuVT3hgul247EuvLCGUuphmOuD2B42ZNquUcMG9S3JMYGBxTuW4F96n1uN5KWylBU2kgrBC9WgEBAH88ch40gUyJvHG92OKAKWc3npvnpdIj4cOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=JuIn3aFs; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="JuIn3aFs"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42RBMf3C003280
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 27 Mar 2024 12:22:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711538561; bh=6z2MSllONANuNTj+3dRNagoS6An1EGFPXWKSXBk9S8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JuIn3aFs9th/CiehVn6LZyKTlIySk/lQxaEeqI3E1Bs0c0+YDDZdJaNTNiLsvPTeo
	 y5SRSELh7jrdeXjvJAYSjUzcOjr6hFNxAIqJk2/SxUR7k27dOSFHVK7rwnIsD1Hzf5
	 1zo5hpfCVU9RWSPLw7XpU74tg+T5y+/jeUhKANTU=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v5 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
Date: Wed, 27 Mar 2024 12:22:11 +0100
Message-ID: <cover.1711537370.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326130902.7111-1-dirk@gouders.net>
References: <20240326130902.7111-1-dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fifth round with the correction that a list itself cannot have
performance implications -- asking for one may have.

---
Changes in v5:
* Rephrase implications that asking for an `omitted` list
  may have in [4/5]

Changes in v4:
* Used the proper `git show` for references in [1/5] and [3/5]
* Another attempt to write clear speach in [4/5]

Changes in v3:
* Reword the description in [4/5]
* Add a missing slash in [5/5]

Changes in v2:
* Added Emily to Cc in the hope for a review
* Remove superfluous tags from [1/5] and [3/5]
* Replace bashism `|&` by `2>&1 |` in [5/5]
---
Dirk Gouders (5):
  MyFirstObjectWalk: use additional arg in config_fn_t
  MyFirstObjectWalk: fix misspelled "builtins/"
  MyFirstObjectWalk: fix filtered object walk
  MyFirstObjectWalk: fix description for counting omitted objects
  MyFirstObjectWalk: add stderr to pipe processing

 Documentation/MyFirstObjectWalk.txt | 37 ++++++++++++++++-------------
 1 file changed, 21 insertions(+), 16 deletions(-)

Range-diff against v4:
1:  2501fea789 = 1:  292ae67548 MyFirstObjectWalk: use additional arg in config_fn_t
2:  6b336e15d6 = 2:  99284db8c1 MyFirstObjectWalk: fix misspelled "builtins/"
3:  83034594e2 = 3:  e1b4a4c996 MyFirstObjectWalk: fix filtered object walk
4:  f23ff9fd1b ! 4:  e6030f1c0a MyFirstObjectWalk: fix description for counting omitted objects
    @@ Documentation/MyFirstObjectWalk.txt: points to the same tree object as its grand
     -reachable objects are walked in order to populate the list.
     +filter, like with `git log --filter=<spec> --filter-print-omitted`. To do this,
     +change `traverse_commit_list()` to `traverse_commit_list_filtered()`, which is
    -+able to populate an `omitted` list.  This list of filtered objects may have
    -+performance implications, however, because despite filtering objects, the possibly
    -+much larger set of all reachable objects must be processed in order to
    -+populate that list.
    ++able to populate an `omitted` list.  Asking for this list of filtered objects
    ++may cause performance degradations, however, because in this case, despite
    ++filtering objects, the possibly much larger set of all reachable objects must
    ++be processed in order to populate that list.
      
      First, add the `struct oidset` and related items we will use to iterate it:
      
5:  582cb7d44a = 5:  0a3dbd1452 MyFirstObjectWalk: add stderr to pipe processing
-- 
2.43.0

