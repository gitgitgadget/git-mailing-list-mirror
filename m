Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE3346FC0
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332214; cv=none; b=amige0QYbVkyTYlOGlM5Kd1jPfzZ8ZD6ikgvAByA/wY9SfgfjbsFfskoKZGdVibJFRSJjXuRHbmh/POa/lWV+cJH6iyvUP07HpLR1XHspWOsbQXB50NzDXNhp0acbYYP81zjvD8VCao+r4lP8aTLSq/L8rwLG5jsLFYlILY/ACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332214; c=relaxed/simple;
	bh=iBE76jGaPDXtt2pua/qAyZVEbAaEJZg5G10EQBigoZM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B5piuqsUmzSWJ6/h2ZEDIHnQwR/XgfcUSkdbcEWLoIRFb09E5/HzC9u41pOz1QkZ1UN1C0TfQUGnn6H3u1/x83UTh8tYL0VRUpd1isUkpxr5rcVqs22bY9i8rM/rm4knFgI5D2XnbML0nSgqfabj60JfmPKP2C/AVTaTl95R8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXLOaEBZ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXLOaEBZ"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a5800772f3so24885946d6.2
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332212; x=1775937012; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuRxKgZEU1d/KBnUCKYd0QMuUy0pgr3i5/KCGCRCGHY=;
        b=lXLOaEBZul90LrAcABDtCOJaYHAbFsnB1zDexNW1cmeIvM75+vyTRq+DVvyDaYZGy3
         aBIuaPk7kkUZMtSB3Z32HXV1z2zuFuWpynupLGFCddG1uUamLvlnHZneA7MeKE5oE85O
         qkhxr00zD9s5JSV5Oooo1XeWvm39r0mER9+YnfmFDI4ORa+aRy06d3i8Mcm+VnJ6rteQ
         hTRnST1c5Te/EpYijlzX7HseV8+fcd2MfINFr6aRznQe//r4UYh2PdbvM41J3wuf24pC
         gWAs73smMnafaSPAsl6Imlvptj+xnViELtJ096ZpWT4M2coMLy+SFjrFcbhUye0XBuwm
         hsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332212; x=1775937012;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RuRxKgZEU1d/KBnUCKYd0QMuUy0pgr3i5/KCGCRCGHY=;
        b=T73Ssji13iSF7F7EZ8Y+evheZL33ppUeC9Rdh70qa0ZByeYFAqgDtNpkPv8u0I6pVa
         12rLN9vSUKjpf2aggSogUT1TryBGHftJ4ZVtKVs+jCee5PxrGg6vh4pd5wYF0Ig0BKx9
         nleJzRhQIfccq1MiIOU64MtyjPjitPtp1YTelnmWmgrREoV+Qh3UaDsNEBO1iQm983Tn
         m2yej3KY5RGqcr0Cp9vfNN4jdMWirCBWEUOo0npbeCAK+apKbRN6IbRcQpqkPC+4E4VI
         MRVrQdELl3fJ/pqOy6zoJEwTozxeFx1YqFGpCfVxEAm9tR+JKEkEhU+Zl5I6URzelkGW
         Diiw==
X-Gm-Message-State: AOJu0Yy5bJziJDZ8L6DphygYxkNezgtFbbKygprWu2d+o2R3aWNCg6kN
	3X90SFfFeV6eUNqnU3fbbaB7CktGFOBTGCTvVvvXLciutW6/a4xr5QtokzNuIxcE
X-Gm-Gg: AeBDiest05VGvvvjcF3PFFSSVVAOXkRYresXGLIxBh/LABgpV0bTY/GYYqKyk+EUl1z
	MVoNj5Und8l+oAjebnXt67UuIUHtGD4BozPALflafigEKPSilYtU7JG4f1akBHJCokwrlPJFYz+
	JmoG8JmkepFSwoZ9hRkmjEkkEptE6wAl4qJwZWb83CirrqPQc1yA4TRkpeFgiIp2GiLD1F5EJJq
	uKZueZk1oLNmOPssAwXcgq4NF+LpnodIpEp/2bojbDqfuR6gwXslJeNa6TdxWhRzy/y8iaOj/iN
	G6kjrrJC/SywGY2LI8rt496JpQZJzQwWBrLT9N6FjPddNz1s9LWOqI5emJqag8UNz/AB7TzJGJA
	nbX9iYJS0WLBV9BIzw6+GJr6XTqCF8zmTl2sDKBS3Sy0gQwbHRgfQ0KLpJnA/t9yl7/MPWz3hQV
	N+sh/yF+AOS4Gfumbw6jOqx5FqUz0=
X-Received: by 2002:a05:6214:f6a:b0:899:f829:e8b9 with SMTP id 6a1803df08f44-8a703460b75mr121169826d6.23.1775332211844;
        Sat, 04 Apr 2026 12:50:11 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5974ddccdsm80397546d6.41.2026.04.04.12.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:10 -0700 (PDT)
Message-Id: <2f1e745b551e5cd492389bb20d1252042cde3141.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:51 +0000
Subject: [PATCH v2 11/17] t5509: specify bare repository path explicitly
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `ls-remote` is told to switch the current working directory to the
bare repository `pushee` via `-C pushee`, as part of the
`safe.bareRepository` preparation let's append `--git-dir=.` to spell
out that this is a bare repository that does not need to be discovered
implictly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5509-fetch-push-namespaces.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index 095df1a753..5167c16c1f 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -88,7 +88,7 @@ test_expect_success 'mirroring a repository using a ref namespace' '
 
 test_expect_success 'hide namespaced refs with transfer.hideRefs' '
 	GIT_NAMESPACE=namespace \
-		git -C pushee -c transfer.hideRefs=refs/tags \
+		git -C pushee --git-dir=. -c transfer.hideRefs=refs/tags \
 		ls-remote "ext::git %s ." >actual &&
 	printf "$commit1\trefs/heads/main\n" >expected &&
 	test_cmp expected actual
@@ -97,7 +97,7 @@ test_expect_success 'hide namespaced refs with transfer.hideRefs' '
 test_expect_success 'check that transfer.hideRefs does not match unstripped refs' '
 	git -C pushee pack-refs --all &&
 	GIT_NAMESPACE=namespace \
-		git -C pushee -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
+		git -C pushee --git-dir=. -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
 		ls-remote "ext::git %s ." >actual &&
 	printf "$commit1\trefs/heads/main\n" >expected &&
 	printf "$commit0\trefs/tags/0\n" >>expected &&
@@ -107,7 +107,7 @@ test_expect_success 'check that transfer.hideRefs does not match unstripped refs
 
 test_expect_success 'hide full refs with transfer.hideRefs' '
 	GIT_NAMESPACE=namespace \
-		git -C pushee -c transfer.hideRefs="^refs/namespaces/namespace/refs/tags" \
+		git -C pushee --git-dir=. -c transfer.hideRefs="^refs/namespaces/namespace/refs/tags" \
 		ls-remote "ext::git %s ." >actual &&
 	printf "$commit1\trefs/heads/main\n" >expected &&
 	test_cmp expected actual
-- 
gitgitgadget

