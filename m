Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500048;
	b=ZjzfbWgnBX4Ra8KAu60AGWIptzqGZh6IOt6DHuhKulMqJYVmbmMMcl1NifUKhe/uQT38
	 i3ctY4yGbkbRFe8lSOY9HX6xqnviFdIjOj+mJ5BZa0yFeyYI5w8O1K7rv0x1eLKNU5oSV
	 VoGy+tkmHh1pA/6rjGigu7G4V02SQx2w73p7Hs5jQNLsnY0NqRnYbpdrUahIUqGOoazud
	 50MDJ/Bbb3bBHBGVO/1+viNE/sZSOA4s81bck4+xBmFMYB2uFmlInGiW/h/EI0wiSxC/g
	 5iT33B/Jtq3B9fGup5QjEiIitlOhq1Kr0sk0zJpho2Oc701+SCXIuTTUaVK93FbKXOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=xdQfxFO51Lm3kYux66foco3nTodpeyX2LHKvNq+iLKc=;
	b=joDrvEZ2gAT387TzzUhSedjhuEMlwlyhoBl2iWpoFdITZH4nykkSJgg+JmSMylyp49UR
	 tYwUwyckgZb48ku+WWLZJLViQ50MtPtS0KYSAs1Zcix/M82JH2OqPOqlfupeZFnOmQvbc
	 r1ulSpWOZYSkcM53fscORWivL8cgyow7xzTLAxZ5UsQXU3zP17rDPbE1TsVyT6ZBue1E7
	 Daw4Dhh96EBMrq4xRpDPzwQ142Dy/QPAqjiZNOPMI9Xj1cEAPdtB2lvJhyOIZb86dO1U8
	 mrXAiklorWlVfoGGq1YLpj5VNdJITgAkFNFzNQ73YnWUXsepvKfFbDKmlZZlWj57IXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGhqzSah;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A1606A331
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 16:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC1A1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGhqzSah
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37000e7234bso35836eec.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 08:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794500047; x=1795104847; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xdQfxFO51Lm3kYux66foco3nTodpeyX2LHKvNq+iLKc=;
        b=yGhqzSah/u8TktLbTCa/+T+9Td+Qb9cMHI4MSO6wUXrlp9ua6YuFYHfo7D34n3vi0r
         AC0txvSzRtc8J+Whjx8PAc3msXr77mboaL1+nI06Q+rEo0vshfsKniniodIO7U+0wvf4
         DvH4jWn7jUwdL162+CXiAZbVA4NWSqjIvztxw9mF3zSIc6weFwFNOgChFBVPhHJWbF1X
         MDZvAj4pjEzGrjRsdbGyWJgZsCmE4JnCdFJaINu9wcTd2S35vks/DfpPV81/RYJIp+hk
         DBZGot3pUjjALypn7qsSrfROVWPS7F2GeEMfhWCnrAMVYBF1U4Zxl8xT7LowKYb4rdHG
         Kxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500047; x=1795104847;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xdQfxFO51Lm3kYux66foco3nTodpeyX2LHKvNq+iLKc=;
        b=oWn/7xWZUPGgtICWruq/qsaWCyglW/ZJrrdXN9lwEjMmvTUqgkosgMEma8KPrjpP/0
         5LtEF0H2OMCGN4ele8r3iezAwvi+MCncQYcSMtrEr+8UHyAYrSkOjdIyCkR+21cCbYcd
         aNNOHHvP8qXHgQntW+dhBHwOPN/mEWXFguM/hYCzN9Ix8BE3j95q3S2Sdh0Ro1eGMBQG
         QzOweRFt4vCmnwPRpVxbghlESOVE2LLQarV16l1Ul26Rr0HspWqroRh78wfIdMNoM5Mj
         eLZqYweNRsaUZ3ahcOTuJHf5d7BFD67JMhsiRySBvYKDjcVKimx700ANWJpYLVy640OV
         ILGA==
X-Gm-Message-State: APuU4Z/KXgIM+bkKLypDKVpJcfWWb6v7p9B5KU6RoqZcPuFyqqEy2joU
	CPU5OiWY89wEMSWQtARTiViSYRU5vDJgzraVCKfRX4UFuVwYeRIs14U+dkVFaA==
X-Gm-Gg: AYBFou3E/ltI35kbt5E3UIAgh3Wtp7o3N0cnZioEFw/l/e0cCE5nInJ39AJQKLhBOzR
	Z26Cfskxsu640QY0s/juZsHATWQrZGb5sJqHUf0U1CV54rhqlf6FuRzhmeqbl53/k/33z04yAnH
	2HpzWJdXpgWGB1ovpT2qCNtSauHcePST7KjYAS0M+IdxLacLv8D8m59Pu1paZKnj3eOpx0SRopc
	Ky0N4L8dUhL2kn48A/Icf54v5qMh1ZSTk39pYN3By3ANr1kYe8wGAjyg6Xiq801yQ/XcJh/Jsdy
	LlEvEUAfpS4Mr5UPbB3kX9sM7UgKVPODlTdy+Sgxg9FH2uh2KYUJKZd3bxyA3vm91K+JgmmlPDD
	3FIqJbIdc4yiUfqc78LVDW+dkdu0vEMj0BAv+6OtSx75M2P0FEq6MyhU2RPVLS3u8kIXz5WvrQJ
	RqFMVqLlly0H/tvOdWyTVONjmMhNtpAWKQVzuyH5WsPRYY/pW1JoPu4PJMRhIYciE8GtwvvhuS+
	/BlnHufWVv/ScVxY3JFTZWD+MNEDS0V+cTvwWONPKRzNH1gwzqPabldtmFHra+y5W5jSgo1KgH9
	CuKEr19jmi0xzuomomA6Ez8PvDpQT9FHOQ==
X-Received: by 2002:a05:693c:638e:10b0:375:dbeb:b363 with SMTP id 5a478bee46e88-37686d341eemr6318709eec.28.1794500046419;
        Thu, 12 Nov 2026 08:14:06 -0800 (PST)
Received: from [127.0.0.1] ([172.182.224.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37925581683sm840634eec.11.2026.11.12.08.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:14:05 -0800 (PST)
Message-Id: <pull.2309.git.1794500044740.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 12 Nov 2026 16:14:04 +0000
Subject: [PATCH] commit: remove padding from struct commit
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

On 64-bit platforms, "struct commit" is 80 bytes, 8 of which are
padding:
 - 4 bytes between .object and .date
 - 4 bytes of tail padding after .index

Reduce memory usage by moving .index into the hole after .object.
On 64-bit platforms this shrinks the struct to 72 bytes and
eliminates the padding, resulting in 10% less memory for every commit
allocated, with no change in behaviour.

On platforms where 8-byte members only need 4-byte alignment (e.g.
i386) both layouts are already free of padding, so the size stays the
same there.

Measuring peak RSS of "git rev-list --all" over an internal monorepo
with ~4.5 million commits (three runs each):

             peak RSS     time
  before     ~849 MiB   12.8-13.7s
  after      ~817 MiB   12.8-13.0s

The ~32 MiB saved is close to the expected 8 bytes * 4.5M commits
(~34 MiB); running time is unchanged within noise.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    commit: remove padding from struct commit
    
    I stumbled on this while rabbit-holing on an unrelated change to the
    commit walk, by looking at the layout with gdb's "ptype /o".
    
    Digging into the history showed that the size and padding of "struct
    commit" have changed several times, sometimes undoing earlier
    optimizations.
    
    I also prototyped a regression test that compares the size of "struct
    commit" and "struct object" against the sum of their members' sizes,
    plus any expected padding. I left it out of this patch because I am not
    sure whether:
    
     1. such a test is worth the cost of updating it whenever members are
        added or removed, or
    
     2. a unit test is the right place for it.
    
    I am happy to send it as a follow-up if there is interest.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2309%2Fspkrka%2Fcommit-index-hole-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2309/spkrka/commit-index-hole-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2309

 commit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.h b/commit.h
index 1061ed791b..66a5d245f2 100644
--- a/commit.h
+++ b/commit.h
@@ -26,6 +26,7 @@ struct commit_list {
  */
 struct commit {
 	struct object object;
+	unsigned int index;
 	timestamp_t date;
 	struct commit_list *parents;
 
@@ -35,7 +36,6 @@ struct commit {
 	 * or get_commit_tree_oid().
 	 */
 	struct tree *maybe_tree;
-	unsigned int index;
 };
 
 extern int save_commit_buffer;

base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
-- 
gitgitgadget
