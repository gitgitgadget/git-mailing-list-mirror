Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348811;
	b=yvoRp8xTqm3JyWQ7xLcW+wumMHoGbyvq8I3j4QS59OD0wEv7AFohF6/zBF+48tY+7Y2c
	 ySwo+fFfUeJ8BUelGP8FFzdwFlgCVCdDNpWvRRGEJyWV/VCc4JAeu1uyvjFu0Zuw/bB9E
	 b7zMQsczItQ1wxKNNc0vLbuWgJ/0EBO4zqtNulQXSX4yH+IUDTe0gFd+fxuikHOclWp6F
	 1XED3mrlWcLBSAyg8fuETMs7FT9xnQ4pgm5Vsr4B4JWiu+hM87AhKeMHdQZEFNKcfQAlg
	 3u5rJh9CZ8rvmzUe7lbUgAuQLBN3mlnzz5X03VnMB5cupYSp2jdL1XEC3lehlsj6X1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=ky/Ue1Myrd73SHNlLwqwzKPBLyiEVXJe5helPh0eo7k=;
	b=UnXiJsPYECXvM1pzxsjvPUEv4NPOuSv/UNYl9p1spwaYkZkhQcc0Bknc9qY4h/C91ThE
	 xBFaKmCgbPgXIUYzkwwuMboiAE7l9Ul1SuP0qDf8HopX8gka+VI32wfHRuaJurtJNIqCN
	 ukow33x3XPsinSzthGkuSWett+QzfauvBG4yd4H3d0Oy1mgTgPW9RKD6fmrUzbbDLmWiK
	 QFx0+qgXNCGXXFeV/1wFKZImffyJJLzDRhulPAoNobbeuEVXzBT9NrJJgRJkt+m6XwzZ+
	 f9iZyhYS70UwLrjcqr8DBJTml5tfiF7AKDXuEm62sCAY+F0jFb05MVJCxw4VRZE3yzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3Nq9PcT;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFDA606A33F
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 22:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DFDA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3Nq9PcT
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-85f34b20042so1467911a34.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 14:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794348810; x=1794953610; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ky/Ue1Myrd73SHNlLwqwzKPBLyiEVXJe5helPh0eo7k=;
        b=J3Nq9PcTccJaUDpnGmNtwlN6ofbFj7rjyiFrfdmqimvuro1hx5/oL3OknflLlo7Aqj
         qX/pQjdXxZuaVdwHVtkQyRtwfL8uodXWYPhdiBbsT3/7Lw3jIUZi7l/spFdv5QlTiRWK
         OY+QobKR9KGZz10mEjQfGh7bPjSDEnuzw5uV0eOAagli1QoD7q79ZRKrFrkXYVVcoABC
         RwoSH05ZgObDtSm5+2vMY30gG0avX7NoiPWpgCXymiT4SSnRm/CYeDdXtSXv9xRQvvtm
         HTdPOsu7xCVaPF40CRKxR9QFcl4YKeysyoIsYvnkNBoEYvtqOxanL0c2iW/jjYBb0jnW
         eg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348810; x=1794953610;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ky/Ue1Myrd73SHNlLwqwzKPBLyiEVXJe5helPh0eo7k=;
        b=SiAkrBstF7zAeMwI1YkT0R1J2vr/zMwdgkYvY6GAkPlde8cFJad8Y6D4k7AkBtrjTs
         y5l6wp2VsFpI1csy+qLhVRymOpr2dpRA0PH/s0U69oLglaTygD7WI/64SyzqWeHmmDPV
         PvfYR7syjDb1YQh3HKF1SxI5ilR9wOcpqXT9wol4wLZ3Q1rlH4SjYn56LXWBuvhvXYjV
         emRWuF/UIB/w/3EEXZ6rYv7MPAtIPI/l8x7TgbiI5Yb3IYYPxLmekHENNxKn20DZ1u34
         +rgb49wwIukWzELQaBMSCjfgfIyisWtkLILO630VdcZTO46gWQmwIdUUNFEX8hbeGVfi
         flIA==
X-Gm-Message-State: APuU4Z975fkgYtkCj4XwPYiiM7UjRJe7c7DjwJWCvk3COD2svcbX6b9C
	kQLtK8THO/JoyhNToxc5zxerVGR5//BRQzjkzmzg1/KGxnNZgx5eB7SnX3Pb1LjB
X-Gm-Gg: AYBFou1bRvZZKdHTe+RwAS5J+HvHgZm5dFfs0aCLRO1/4JDIh+RNHCd+ZWbklVHlz+r
	Dx0tgFBKuybepPHhNbF1CkPB1wRHxhSQS6jWVva/Jtiqspa0mTAvfCc+Y9ZLtc3PBz13ZWIYQfA
	pH3C+INQxb32XgJ6bvQttZvx8ia5QvMvFM/4C9T7ja03/V9q2iz67BYwwsklwYHGwSPt9nKqh8h
	OhVr5KIFlhCG0ju1uaQApL50dJDo86aGHVE3JAPvOQ7j76YR4FdkZ2YGsxS+buEjd/Q4jR4VHUU
	K/O87JPfJCUyJvD0a1501RZcO7B7AS/GQ2JyTaMj6So50tFOmY5xRBpWnXtoSyRIYCDyoVwzcIK
	YvQUGq1JOneFN5RsFdROfVTTr9NKZtWedAOR1CLalbD6zP89CNntlGc2ZfGaZPASNWHyHslHy1i
	dI/THYkyartG7emUggsRx+4RhOL2IK65LnzkV0qyFbcmPy6yNtuznSUP9EEhFLbjWowX1gmUcb4
	V18fkAAfNKpAac5KuHnGrY7NqtqqXWh6oROZBAOQ3i2z4o6bvh5uyR4GCadJMnVk9uCOpL1QSsH
	whvX43Wj0bFWW16ttwLtt82p6ufppf0n
X-Received: by 2002:a05:6830:914:b0:80c:d30f:97a with SMTP id 46e09a7af769-860f294e49dmr284678a34.27.1794348810236;
        Tue, 10 Nov 2026 14:13:30 -0800 (PST)
Received: from [127.0.0.1] ([20.15.228.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860e5978892sm1832647a34.12.2026.11.10.14.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:13:27 -0800 (PST)
Message-Id: <pull.2270.v2.git.1794348807240.gitgitgadget@gmail.com>
In-Reply-To: <pull.2270.git.1792497283164.gitgitgadget@gmail.com>
References: <pull.2270.git.1792497283164.gitgitgadget@gmail.com>
From: "Roger Koranteng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 22:13:27 +0000
Subject: [PATCH v2] t1010: add basic tests for mktree --batch
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
Cc: Jeff King <peff@peff.net>,
    Elijah Newren <newren@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
    Christian Couder <christian.couder@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Laveesh Bansal <laveeshb@laveeshbansal.com>,
    Roger Koranteng <rogerkorantenng@gmail.com>,
    Roger Koranteng <rogerkorantenng@gmail.com>

From: Roger Koranteng <rogerkorantenng@gmail.com>

The only "mktree --batch" test in t1010 is the one checking that it
survives a concurrent repack. Nothing covers basic batch mode, which
is how the leak fixed in 6272f3bd17 (mktree: plug per-tree leak in
--batch mode, 2026-08-29) went unnoticed.

Add a few tests for it. Two trees in one batch should get the same
IDs as running plain "mktree" on each, a trailing blank line should
not add an extra tree, -z input should work, and a tree that names a
missing object should make mktree die after printing the trees before
it. While at it, check that a blank line is rejected without --batch.

Suggested-by: Jeff King <peff@peff.net>
Tested-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
Signed-off-by: Roger Koranteng <rogerkorantenng@gmail.com>
---
    t1010: add basic tests for mktree --batch
    
    v2: check the error message in the missing-object test, and move the
    blank-line question out of the commit message.
    
    One test feeds two blank lines in a row and expects an empty tree in
    between. That is what mktree does today, but the documentation says
    trees are separated by "a single blank line", so I am not sure it is
    intended. Is it, or should mktree reject it?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2270%2Frogerkorantenng%2Fmktree-batch-tests-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2270/rogerkorantenng/mktree-batch-tests-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2270

Range-diff vs v1:

 1:  7a928dccb0 ! 1:  40f09c123f t1010: add basic tests for mktree --batch
     @@ Commit message
          missing object should make mktree die after printing the trees before
          it. While at it, check that a blank line is rejected without --batch.
      
     -    One test feeds two blank lines in a row and expects an empty tree in
     -    between. That is what mktree does today, but the documentation says
     -    trees are separated by "a single blank line", so I am not sure it is
     -    intended. The test records the current behaviour.
     -
          Suggested-by: Jeff King <peff@peff.net>
     +    Tested-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
          Signed-off-by: Roger Koranteng <rogerkorantenng@gmail.com>
      
       ## t/t1010-mktree.sh ##
     @@ t/t1010-mktree.sh: test_expect_success PIPE 'mktree --batch survives a concurren
      +		echo &&
      +		cat top.withsub
      +	} >input &&
     -+	test_must_fail git mktree --batch <input >actual &&
     -+	test_cmp tree actual
     ++	test_must_fail git mktree --batch <input >actual 2>err &&
     ++	test_cmp tree actual &&
     ++	test_grep "object $missing is unavailable" err
      +'
      +
       test_done


 t/t1010-mktree.sh | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index cecba55d45..bf03b62215 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -117,4 +117,78 @@ test_expect_success PIPE 'mktree --batch survives a concurrent repack retiring a
 	)
 '
 
+test_expect_success 'mktree --batch writes one tree per input block' '
+	{
+		cat top &&
+		echo &&
+		cat top.withsub
+	} >input &&
+	cat tree tree.withsub >expect &&
+	git mktree --batch <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mktree --batch ignores a trailing blank line' '
+	{
+		cat top &&
+		echo &&
+		cat top.withsub &&
+		echo
+	} >input &&
+	cat tree tree.withsub >expect &&
+	git mktree --batch <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mktree --batch: two blank lines give an empty tree' '
+	{
+		cat top &&
+		echo &&
+		echo &&
+		cat top.withsub
+	} >input &&
+	{
+		cat tree &&
+		git mktree </dev/null &&
+		cat tree.withsub
+	} >expect &&
+	git mktree --batch <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mktree rejects a blank line without --batch' '
+	{
+		cat top &&
+		echo &&
+		cat top.withsub
+	} >input &&
+	test_must_fail git mktree <input 2>err &&
+	test_grep "blank line only valid in batch mode" err
+'
+
+test_expect_success 'mktree --batch -z reads NUL-terminated input' '
+	{
+		git ls-tree -z $(cat tree) &&
+		printf "\0" &&
+		git ls-tree -z $(cat tree.withsub)
+	} >input &&
+	cat tree tree.withsub >expect &&
+	git mktree --batch -z <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mktree --batch stops at a tree with a missing object' '
+	missing=$(test_oid deadbeef) &&
+	{
+		cat top &&
+		echo &&
+		printf "100644 blob %s\tmissing\n" "$missing" &&
+		echo &&
+		cat top.withsub
+	} >input &&
+	test_must_fail git mktree --batch <input >actual 2>err &&
+	test_cmp tree actual &&
+	test_grep "object $missing is unavailable" err
+'
+
 test_done

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
gitgitgadget
