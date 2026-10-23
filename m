Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785802;
	b=s294yEE8KU3E9chTKCWplQKeMuao8JaBMMtP2U4zBoKXItmqzCObKCDbUh4R3FMEJYeD
	 fl2Nra1nQusnQKhWuojW7szwBzq6e7g0zpKfujnrw7A7w/eO7UC21y3zdfiaWTotA3gVe
	 +nUUjbshVZteJH4nKkdcL9I3w99zT++lSzk6QPIOr4XpmjB6mUTaO/aZm3h5hHJbQ3wKJ
	 FA65BjF4j7JdB/gC/400+msV4Uv4Bs6ukQyvaduGrnJmB2zfK1MORFcHKwqU82UpdhNEh
	 8dPxHA+tawsVsNynzVi0dpvbLJhfjd3WAoGrpevrMtWQMbPzkn6wsu+SFj7G2umcKEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=9sHrN2ZGMpCvCPCJwxDMZdsxfkfZNSJQWnow1jP30Ns=;
	b=E1z2DjcuIhQcBMufMJYJKJHOOfrmVskoZMh0eqizfyoSTKtYurW3wbWRLd8BkZwQtgC4
	 fPMeXW2I7mXYEd17cS/irwIcFkfoElFeiCc07MZ3SqTBrYjela7at/5ZyfFEpSLh9r3GJ
	 lgDsVqZYO6F5wzUWClX7U1k9wXIazecDiJ3mmqPz/NrmoHbNILnHdUn/5/mWFgUiSKpps
	 VtRjpNDPOJWMEE5mFE0snl/KFa4CL3GOWCJtP09j2lqE7VTdGd1Ft2BW6HAM9N7xIj08W
	 mRuY4D+oTehH5k4CmPBi2S1zC1ZNxzZK+PraatwC32guWhcPJ0GYs9h/WTRQZQpciUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pgzsBajU;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47260A261C
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 20:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E47260A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pgzsBajU
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f2049ea7aso82701985a.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785801; x=1793390601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9sHrN2ZGMpCvCPCJwxDMZdsxfkfZNSJQWnow1jP30Ns=;
        b=pgzsBajU0nWin8GBmza6glHpRxbmNstZRowUY46pTyvb5CCR1OClJFaV+WX8SXv3A6
         dP+Bvayn9FHc1Ne/5rEHl4DUK3R6Xohkn3ZZfNXXIjYhB2qlqHfa8xpa72E7OBPBp04E
         Rlzh65qly/EeHCWxndnsLjK15q7Ipeet9sVnq4i/caMfw+xNNy7rxlKU06LmAFtfqgCN
         jW1cIFpoJyZnFQvAczCw5cpGbYMGXQznv3wCCHrV/aCCchgOIwjc3TujW9M52dvNwUQc
         yzaQclrRza/FrpAPpMB6DplB1u4j6NajM/IRwmD3EsjoyYtL816U5FtK4b1svR6bK6gs
         cEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785801; x=1793390601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9sHrN2ZGMpCvCPCJwxDMZdsxfkfZNSJQWnow1jP30Ns=;
        b=p/BpAqnKDq/dVeAxuVQO9Nz2BZQem3pajY8Pp20+fy8FEUpCmHGUdQ34DdwplOz83D
         qUkJMo33Xgy6Pu+ZobV4ufgXvmj5rXlePj1Jsb3YwYqwqaReoHE2/1WtFqlUMGsTEeg8
         0DcC3fl4T+hBqFb6wNlnlgdvVnoTFUvttpoIGRDbZoy5lx8LnV4gIuuaghJEpXwo/JdP
         o4tOFLtHjrgeGn33QkTL4tMld7XD340yJ3+Z9dZoaO7bbQxMOyjWCAPGpi1ZFRKg6+n/
         +aTBX+2gQIzNBKk9x19PhMG0cLv1jWSehQHEu30AKFPNksd8eMQDn84RjQmPXshE/pOc
         U98Q==
X-Gm-Message-State: AFq9FYJxJ4Z0bHnviVIoGwloPyoelyYvn7Ps2mWibQtMrrzHP0WBYCpv
	UMsd/w2NFf9aXN4sJx+8V6q3Wys/OwTORSJt2zlqBeWaOo/ImJBMsN7i+3cVDQ==
X-Gm-Gg: AYBFou1a0bDyMVJSeFa7FuLbOtKmwni12LxuSprqeuJ3122EMUEzdpuOMBjEG7wDwiC
	79aJpSwLAof7vP8pa+EfkbgqpKmBt/BmzOb/cAmVSndIq30D7Yii08CoyWEaAwrKR0bBW8HjF0W
	zaohvFML9mX1/qa222MammG63Fzx7yt4Ya7jfw0Hp8e54lvG/ROq0OviP1F7s3hokthPCj+2DMp
	TkWCDyVx1+WT7uiFK9YAcQcO9l9pymaKDTlXWmJjM2sl+9LjGlSf2eSF0BuXg5b5APdLAgv4YXp
	QrFkDRezJ4rwAgt5PzUZmco6+hXfhmtAGEhBukvuomdnfsePE4OGCob6XD1iMg4hOnQd42y3G2u
	n23cJAPeSFkgFuSSBZyLFjMhHcqS6XolDml6r1e5YY4cxKyxbbGVg4xrQjcPv/jkNEs9YL1ScI/
	w6Vpv3r7oCsIsDpFbVCMWhYYqMG7VrlJd6AJZ9LZPZL9y/gisdSKpGKKb18HMpbj2Yt32Z3Eqcu
	bBqhAkNPi1o8sQWe0iL+YWbofaPsrUjpuwEbtz3NWv1fWNjXHMq0ZxTIhh1SWCQIzJrZAuDviyX
	dqX9G3LPMD9cfeT2yEiD15UgHL2giy9wB8QHz6qZcybDkKXOjEhsUg7zGaBS4CsQtz6xkOM2Y8t
	GkvVEeWnKmwYBzp81sCvxZsj1NX8ts91L1B8eKJguPJFXh48twWC7euWrX+0gXdjnhmoUvlN4U1
	/7KTNJOCtX5wjvmRbZHoJr4vC8qJ2J9lDz6Q4CWQ==
X-Received: by 2002:a05:620a:f06:b0:93e:bcbe:f709 with SMTP id af79cd13be357-940ef913630mr15330885a.16.1792785801440;
        Fri, 23 Oct 2026 13:03:21 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-eastus-03.tradc-corp.com. [40.76.104.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9402ee2cbffsm104288785a.2.2026.10.23.13.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 13:03:20 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 23 Oct 2026 16:03:04 -0400
Subject: [PATCH v3 1/3] dir: hash ignore files before appending newline
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-ls-files-untracked-cache-v3-1-292260e95f53@gmail.com>
References: <20261023-ls-files-untracked-cache-v3-0-292260e95f53@gmail.com>
In-Reply-To: <20261023-ls-files-untracked-cache-v3-0-292260e95f53@gmail.com>
To: git@vger.kernel.org
Cc: Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>, 
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1792785793; l=2566;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=iGWl8jaqdYHNEQO4bye3E/epO0yB4o0z0TENBtgMOnU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDO6Mnw9H5bPVe5f0fYBBW5yQH13ZXlwBFRivtvYXnd5AL5JDxtwR6jTql+dBX8GljTmmptzywj
 yB1IsV26+OAQ=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

add_patterns() appends a newline for the pattern parser before computing
an ignore file's object ID. Hashing the buffer therefore includes a byte
that is absent from the file. When the file has an up-to-date index entry
and needs no content conversion, the function instead uses that entry's
object ID.

Switching between these paths changes the cached object ID even when the
file has not changed, invalidating the untracked cache below it. Compute
the hash before appending the newline so both paths agree. Update the
expected object IDs of the untracked ignore files accordingly.

Assisted-by: LLM
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 dir.c                             | 6 +++++-
 t/t7063-status-untracked-cache.sh | 8 ++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index d896e7be4b..5484eb1562 100644
--- a/dir.c
+++ b/dir.c
@@ -1195,7 +1195,6 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 			close(fd);
 			return -1;
 		}
-		buf[size++] = '\n';
 		close(fd);
 		if (oid_stat) {
 			int pos;
@@ -1215,6 +1214,11 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 			fill_stat_data(&oid_stat->stat, &st);
 			oid_stat->valid = 1;
 		}
+		/*
+		 * The extra newline is only for parsing. Like do_read_blob(),
+		 * keep it out of the file's object ID.
+		 */
+		buf[size++] = '\n';
 	}
 
 	if (size > PATTERN_MAX_FILE_SIZE) {
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 8929ef481f..10d4850077 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -98,11 +98,11 @@ test_expect_success 'setup' '
 	: >.git/info/exclude &&
 	git update-index --untracked-cache &&
 	test_oid_cache <<-EOF
-	root sha1:e6fcc8f2ee31bae321d66afd183fcb7237afae6e
-	root sha256:b90c672088c015b9c83876e919da311bad4cd39639fb139f988af6a11493b974
+	root sha1:8510665149157c2bc901848c3e0b746954e9cbd9
+	root sha256:09ef24b38105f396a61ad78d73ba6a18ee3cbd89ce4524b4e13b6c1af191e2d8
 
-	exclude sha1:13263c0978fb9fad16b2d580fb800b6d811c3ff0
-	exclude sha256:fe4aaa1bbbbce4cb8f73426748a14c5ad6026b26f90505a0bf2494b165a5b76c
+	exclude sha1:2bdf67abb163a4ffb2d7f3f0880c9fe5068ce782
+	exclude sha256:b83643f4390b339c1b3ff2f5132c99bd4a77687dd321d3f386c25953aa6f1ce4
 
 	done sha1:1946f0437f90c5005533cbe1736a6451ca301714
 	done sha256:7f079501d79f665b3acc50f5e0e9e94509084d5032ac20113a37dd5029b757cc

-- 
2.56.0.1134.g47ee84b154.frankengit

