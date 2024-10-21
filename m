Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A9A1FA266
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518286; cv=none; b=dp0IkZ3ZZkqe3Qy/HTFC/VDjhBHIOSD47UVFcA3qqwQqPkHMjCpysTqkgSHtWNPuMm5MUsdVqoczRhF0DnGp5zVVkL4gMpggVgDalVtI8LO04pdPLsv+W7sK5DrzFAdRVTkirBELWHBPmfLXTWSko3xsR6F9ueWconfQMgEo6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518286; c=relaxed/simple;
	bh=rSmvOAaQME/2eeDBgTsmbx4bIQpyWLtxmDP/hGx3/ac=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=nRA/1XJmm3C7v87qGaNvIbNtT9yGlWP1Pllo5mhHyAAXQ0SMiY9lQRu1x15tsyGc2Cw6LrX6K9CpuahN1xHctcBFsXHqRinS9uCFFmGITr7hVcXGX8mlN/tgJtSS2yhMm9j3ORyEZ9n8rKn/tv0MXeoDYBzOxk2jHWDYPvP5Uw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=d+6xG7ui; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="d+6xG7ui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=53dOa2wWM2lH3V9OA4vxgdv8K6jkno0ndMMZA5cpnS4=;
 b=d+6xG7uipwh7bUn8vhP7LVhfaE2ivzjb+q7C6vhDeCNTYPU0BnZFM4JVWq2dGGHV4q11pGEAwtlD
   w/jC/CWu+wydh4xWul9IchXEJKK843IWXujil33jIBFNJ9TBvvn05ey9iQiRnrC6WNa9lHO38Gsx
   IHiG6uDTdRH/d0QDFWKT+WR5nUrpIjPoMwkkB6a31xFEBFzk4+n8aK2xuNP97x3ujFGpFWL/HXnb
   JZFveW8YGAFWDQ1W0fiE4oEUlIwpGy0cJgpgMheK0KNn8IHusASxrzta1sZEE4Sc+KA3gmqBD5bv
   IEAT5BRw0J/pEHo40zIYZ1sGm/JNQDyFPv5AzQ==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLP0076DKUD7WB0@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 21 Oct 2024 13:44:37 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?F=C5=91v=C3=A1rosi=20V=C3=ADzm=C5=B1vek=20Zrt=2E?=
 <noreply@vizmuvek.hu>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v10 1/8] t/t5505-remote: set default branch to main
Date: Mon, 21 Oct 2024 15:36:58 +0200
Message-id: <20241021134354.705636-2-bence@ferdinandy.com>
In-reply-to: <20241021134354.705636-1-bence@ferdinandy.com>
References: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
 <20241021134354.705636-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAE6BqyhgBdw3psBAgzOYdkbpZ8nb9aOMlGbkvEbMCP+FYXYH0Z2PsjfZFybAL2p
 F4KXeXYr4sKQKCoxQPVWMxcVOAjEy3L+QKV0MCeoBvRUzgDOaf+mO+wFa4gv1OcL
 8PfUpKVc/5SMGsLdg+6FIFn6jq62Cfs6Q6Wr6qcHvFZBpl4urS2OKygp6FhIm8PF
 pk41G7kBupsKIqR7xhomRK4xKaigSuz2lfcGqQzEj5nP7Jt8HoaQ8PcYCSv5Sl4S
 FyGwurlyHZaQoHdg4f0LXlIsIAq2lrA1i6cFE6I9yWUz6e+h/uddNE+FL2B71Vji
 QqyQo1Cr3P8tQiVx2oD/JGkrxNbmi246zqnmBt8lLpuov8CDPWCWqL9spprQsMXm
 lxseupjyN9+ZZm85/+yopkSuhL6r6VAgj1cujzcZZXUN6ta22bpZzll9weOIe/w3
 lbPzSz7VS0Dhi4NDeMwRC91OG+S04/kZtnvEbRSCe5Okyj10MokZkk3u

Consider the bare repository called "mirror" in the test.  Running `git
remote add --mirror -f origin ../one` will not change HEAD, consequently
if init.defaultBranch is not the same as what HEAD in the remote
("one"), HEAD in "mirror" will be pointing to a non-existent reference.
Hence if "mirror" is used as a remote by yet another repository,
ls-remote will not show HEAD. On the other hand, if init.defaultBranch
happens to match HEAD in "one", then ls-remote will show HEAD.

Since the CI globally exports GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main,
there's a drift between how the test repositories are set up in the CI
and during local testing. This issue does not manifest currently, as the
test does not do any remote HEAD manipulation where this would come up,
but should such things be added, a locally passing test would break the
CI vice-versa.

Set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main in the test to be
consistent with the CI.
---

Notes:
    v9: - new patch
        - a bandaid for the CI issue noticed by Taylor (cf:
          https://lore.kernel.org/git/Zw8IKyPkG0Hr6%2F5t@nand.local/), but
          see
          https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/ for the root cause in detail
    
    v10: no change

 t/t5505-remote.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 532035933f..9b50276646 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -2,6 +2,9 @@
 
 test_description='git remote porcelain-ish'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-- 
2.47.0.94.g8861098b6d

