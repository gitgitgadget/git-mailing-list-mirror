Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795297597;
	b=bBcNAJEeCN3XvW2RMbBmsdhZLzVT1ill3mKqmlnwELjKkSlHCYIsJDysbns+Xsjrgepc
	 Xu1/ySWXZ2aV48ibNsIXLM1xGlLCMMQ5AcuCGH+yk6ct8YII/UMmGbaDF0KK0vPoJUdna
	 e0rGyM51r0JG3dJwDHqxSqskk3NPJOyPLXQ+YJeuuWGZQyPvFTMKugrDxhNwvFjziQH0R
	 f0moBFb2vBzZ61Q9SaSeQMBRuYbEct3lAgMtzzzDpPJOUXk3dO3/o517mIs7OGgqfWICk
	 QXwGB3OPEdTfO64/mWwY5tMQ/xEuiy+XWiVAVOAoIi0rUt+SGJbf7Tw3Y9ZKTPccq5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795297597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rxGebJdceeHnZu98aU/yQLY4dboKF+0tkTRfVmv4nPg=;
	b=10JdoN/roMK7enB2UmkgHsuAMCl375Rzh86c0ccgzrjtW2DXbSi6H0w+oRIKqyNKIP9x
	 gLeMWIaKq9WBWWyftMhP+fe6WHXPNx6UtfcEceqsFKM05hsgXKcCVIUORLgTuH38UcPQU
	 BstiJ48FuPGDUb3PptdAUIlrAajT0KmPfm1O4bukceBdyVse0L5iJkT4CeeeF5otWU3gI
	 uGT6A5+D+K7PhoPRgFpom8rVCVs5MXHdaRj4bX/UYg3C2IkHl3MWYOgyJUlJGYqf88oPs
	 SN5nsCfDnQN3hYNA77A5AXMop5ZucKjARP0Z7VDTkbC9FQKRgMKFQz/MSrtc8WZm+LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YxFO4vf5;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422F606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 21:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8422F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YxFO4vf5
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so21915385e9.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 13:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795297596; x=1795902396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rxGebJdceeHnZu98aU/yQLY4dboKF+0tkTRfVmv4nPg=;
        b=YxFO4vf5Vz86bEGGD50lMZC5IVc/ZFgGA6pIw2kZVHwMEyCxpwfY1fS47jWAT9dIE7
         f/nEiGx9tUoQpCazVA8jrlqxsAnuR+JEbsdRkIf6b9nPUM7pFx/pGG70f2ljtnGlM6qz
         86T9XYcB7IrXFtbNB6nLLyxd0nMj+4yqavo9Q09tX1pKnMS+l/3ZfuZMIzE2VpxL0oEj
         2tZ6c60hsPW+t5yiQqgESPRvzqXHF0pcMhDbyBJF8/EngLu457QxjLpVP+lNW32sdmyq
         6VTRYcgdz+LMzmHiXvN1+mvp0Xu9YOgeLwh2GcKud9fmKnwL+har7ch8JV8KPpT0IIih
         9+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795297596; x=1795902396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rxGebJdceeHnZu98aU/yQLY4dboKF+0tkTRfVmv4nPg=;
        b=TXjOaTyEfz632BecuiV71Tijta3tk8qnJc6A8IAWBHsMaKzP/3i+qopVvTGn3ff+nf
         hwMa+hsHb3rEAeWIZ9Fmg2dXp1qfI91GC9x2dNseg8gooWkz1tHJirn3uGD1g+QvdCdE
         iD5TO/sQlhIjKSdSLJ2GngAINthEDP+7XNZH/Qw31kRCLO6K/CRVc07lBXOzpEKlNsqV
         fTk2FtKNLPiE5XVAU9jOPsK3CdSZ27ZaunRnE9FKSQV6yA1YmpALuQuNYp7zn3rcFYkZ
         +mtkdgLPHNVwuYrPcfOVQuqPi/xhH8ocku7o20Q7jVusKxoWQVKfXc2ywvl/VkAmRXsg
         0OPQ==
X-Gm-Message-State: APuU4Z/jR10rrs4BrWi4HMFTr0/nQv3aNJC/nOhtAM+k/GE7hJyB0i9y
	z5N9TKsj+bh9y8WzRsLL077Bs6hj3ietcz3bjZ4n8iczxDTv8lqerXznDtaelQ==
X-Gm-Gg: AZFdTZd+q8hTWkaNwJgUCVEyKqX5/MPWYaHj5AxlyAFNzsTbcBgohMrKolW20Y+IPmn
	3Ix0/5TYQQxpADGxXuFBKdyR9+Kc44lwtGDtNbo6w4hwNN5FIcXcLaADegVr3GATRAwgHg2GF6s
	n6SfpfqAc+1Whjxy5ozQZgLj2+SfYc8dOHoEnWJ4QQrVrZdrQC+w4/EP7b7PxFToP/YY56rCr88
	KRr/HaIfEVOzempCqMs5iXCt0QosacMAavv8KoopLLPVuHKTIuOMsbxWPTy5Hfx5E2nLPeIU234
	DIJ7xWVoRzFoS+qM52UrVFV8c8vGsV+Ww1CEDL4oZ2lxfcFaXbtjgwtDSmTvEhUa0J2t30BqgEM
	KFNIBeWZ4JsMBvgc5+kM06kVfehoN8z1VnW+9HHI+IsrciloHEc2sdaIPZn+u29FDsajkgcT0Ge
	t27S+rXfnL+vVZKtLOXqAGCweq11deCZ9zyaNA7+DFOnecpDR66ef7bXwzyPY0VWWCTkl9LDS6m
	Btx0KY9q8CAbrTbEXXzClPECr+ks2wgs/lnpwCSblq4cPQo45Le0jJbf25JFyAcQl+mCp5XrwbL
	kC6ngD57ofEbWrRld5V0bx/IhhG5N348hTqnmkHF0u7TRIXdKV90bC2mPdeA5jWDNyjTrFOFmzr
	LVhIFVEYqYiGKsXTC6MI+sdetOw6gdb9SHefSYE/X+bSvssY=
X-Received: by 2002:a05:600c:6748:b0:4ba:761:97a1 with SMTP id 5b1f17b1804b1-4bb888251bfmr148779285e9.14.1795297595633;
        Sat, 21 Nov 2026 13:46:35 -0800 (PST)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net ([131.189.143.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm211800125e9.15.2026.11.21.13.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:46:34 -0800 (PST)
From: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 0/2] fetch: make --prune-tags clobber changed tags
Date: Sat, 21 Nov 2026 21:46:31 +0000
Message-ID: <20261121214633.1523706-1-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
References: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

--prune-tags is documented to force-update tags that changed on the
remote, but since 0bc8d71b99 (Git 2.20) it rejects them with "would
clobber existing tag".

Changes since v1:

* Instead of treating --prune-tags like --force for tags, add "+" to
  the refspec that --prune-tags implies. v1 also forced tags fetched
  with an explicit refspec when fetch.pruneTags was set, even though
  tags are not pruned in that case.

* The commit message now says what fetch does today, and where this
  broke.

* The tests check that the local tag was actually updated, not only
  that fetch succeeded, and that "git fetch origin tag <name>" is still
  refused with fetch.pruneTags set.

* Rebased on current master.

Orgad Shaneh (2):
  fetch: test that --force clobbers a changed tag
  fetch: make --prune-tags clobber changed tags

 Documentation/config/fetch.adoc |  2 +-
 Documentation/git-fetch.adoc    |  2 +-
 builtin/fetch.c                 |  4 ++--
 t/t5516-fetch-push.sh           | 35 ++++++++++++++++++++++++++++++++-
 4 files changed, 38 insertions(+), 5 deletions(-)

Range-diff against v1:
1:  3a5b1c73a6 ! 1:  6ee374acd4 fetch: add a test for --force flag
    @@ Metadata
     Author: Orgad Shaneh <orgads@gmail.com>
     
      ## Commit message ##
    -    fetch: add a test for --force flag
    +    fetch: test that --force clobbers a changed tag
     
    -    There are two ways to force-fetch tags that have changed: either by
    -    specifying an explicit forced ref (+refs/tags/*:refs/tags/*), or by
    -    using --force.
    +    Changed tags can be force-fetched with a "+" refspec or with --force,
    +    but only the refspec was tested. The test also didn't check that the
    +    tag was actually updated, only that fetch succeeded.
     
    -    The first approach was already tested, but the second was not. This
    -    has now been addressed.
    +    Add the --force case, and check the tag after each forced fetch.
     
    -    Signed-off-by: Orgad Shaneh <orgad.shaneh@audiocodes.com>
    +    Signed-off-by: Orgad Shaneh <orgads@gmail.com>
     
      ## t/t5516-fetch-push.sh ##
    +@@ t/t5516-fetch-push.sh: test_force_push_tag () {
    + test_force_push_tag "lightweight tag" "-f"
    + test_force_push_tag "annotated tag" "-f -a -m'tag message'"
    + 
    ++check_child1_tag () {
    ++	git rev-parse testTag >expect &&
    ++	git -C ../child1 rev-parse testTag >actual &&
    ++	test_cmp expect actual
    ++}
    ++
    + test_force_fetch_tag () {
    + 	tag_type_description=$1
    + 	tag_args=$2
     @@ t/t5516-fetch-push.sh: test_force_fetch_tag () {
      			git commit -m 'file1' &&
      			git tag $tag_args testTag &&
      			test_must_fail git -C ../child1 fetch origin tag testTag &&
     -			git -C ../child1 fetch origin '+refs/tags/*:refs/tags/*'
     +			git -C ../child1 fetch origin '+refs/tags/*:refs/tags/*' &&
    ++			check_child1_tag &&
     +			git tag $tag_args testTag HEAD^ &&
     +			test_must_fail git -C ../child1 fetch origin tag testTag &&
    -+			git -C ../child1 fetch --force origin tag testTag
    ++			git -C ../child1 fetch --force origin tag testTag &&
    ++			check_child1_tag
      		)
      	"
      }
2:  ae82d31bfb < -:  ---------- fetch: clobber existing tags with --prune-tags
-:  ---------- > 2:  3ed44788d7 fetch: make --prune-tags clobber changed tags

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
2.53.0

