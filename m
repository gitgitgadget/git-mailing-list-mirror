Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA54DE73F
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354165; cv=none; b=jes+L0Ur7UzbiJOzf4H6/GF6C2AXn1Qp9OJCzYZ5KelFiv+OeeO/raYZqhIJullEoMwxCrojcOnJORi//WtXudkBcLGhGi1gZRfyCXbJHfn78a9M/+CB6CrmsZkWZWwVu5JgTmMp4itb28BNTVOJVZY3A9Nd8yjIp7wVwPnAfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354165; c=relaxed/simple;
	bh=uWqEt3TgPcKFcBx1ECxpMbGZZGwZ2GHj6CaNVP9kEFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XyuM/xIpwpROskAvocUZBn+cCVPYZ3tedG5jzK/amVRiBPCm2TM8fse3LoDfPWIML0YxZCWc8IlTBm+MFbZtCmgkrMjIpVAvCT+XLOJ4dFB4KZX7OJaXg9Gw1hI6DQLkSV52r7BgSRnSUEq8Sosz0HR2zxd+EbfrcCdrmtxp7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJLw+ona; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJLw+ona"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccbd478cso483755fac.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790354162; x=1790958962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ia+HwOYryDBvTCYxtmfMN75tEkBkl01bJnVNVzx9r0k=;
        b=VJLw+ona7leN2THGGLRr/4z+6qR7CxbrOeeR2aGDZqbwyU1g3ZY/1HrxCpUhG6TDCx
         Lt9UObBNjoQcGd1o2+mdAD8SOCHlsdKRkIbPZS4a5LXbeeXVoSUTLB2r6rAXKAYxVo9F
         5rcKXtl7D/f0x7CvUgwWUGh2k7jZlnuzaEVuO035SfvJP3UrtXya4DwZUovfiQhVyue8
         TdEkKMmhgJWfD+Pwb3EfSMjKvM7QSTPs4ST81PhXL4qiTnpEx+ztYl3Hve0VzXgFiGY8
         n00ldHKgsul35EJef4qzuCtb0xXY24KKxMvhb01Hix6T+4mR+cSbcOS6X4z/Y+RnmTKK
         o2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790354162; x=1790958962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ia+HwOYryDBvTCYxtmfMN75tEkBkl01bJnVNVzx9r0k=;
        b=tS9X9CfDTlGgJLUO66NGXtii0o8TQDs35RSdkIqE1ld2qRPGgc336/P+mV9d8rhBtU
         ITbBQM29p6V38xwoueGtk6NdwCvEgFINkdxZnqyQHym18ylrOtYeRxSpBd8ynmPpbrtN
         THeeR75koQEBkUh2AJ1iVHr/2tRU3/Sl+DqnoSJJE+AvFP3aWIbSnM2cr3QD7/c9Xgbq
         W8FWTe33ztd+stu6xRaZE0bMfcYAgeFBobXxQ55zTH1EJ1I88odduwJ7T8qxp/6gMWJq
         ZHrd4I7PFoavND/TK0W65XYWza/3df12uY60pHBj8WUladsZD1w0Vh8jHVTLvbmhu0s7
         86fQ==
X-Gm-Message-State: AFuF++n+bHYywV6pjfrHwBEFhb6JQrqsU4E8cL8dXynwH+REsZPQlR5z
	1C+BcpzjzDWpUG1tgI7iZIHhzdvVlF+P8/ovBrIbn+yhLporj65JejZuDWZiEngH
X-Gm-Gg: AYBFou0qyvZXCUxpIQP0SfnFH/6dbEtZUbKAn0DhIwbH68MojOxY4FauWeRse53Foui
	ximZJ5LOQ65vSqdCIU3oC0BLwM2jw6bl88vHzqkVIvNrqr8h6R2PjFVXxB7HqsxPcJ4nCMXxQOr
	RWXvPGHFqgfbLhtK6TcKafcDn9YZ1w125EaOVKVJnGqdoYY1C0XSjYdVYEzwGiz8WyWCsmL5nb9
	FnlrKAdPQF8s1Qq+naVrYRYDZsAj5j3tq8ogM2cO2OwOlHqK9msTAWHRsrut9KWASnWE3BbN46T
	qq5XVLd5U9JktqxHFON9LGFVbX9xo/C3mM+JagHi6c0+HMbFJRapEYwnWDKTRSbazl5XlMomHMm
	7Xm6sNFOQhk/1rwbicPDKRnCca5VMlVLoe7ZGM46tBJpZPeeKuYgIY/y8F1+ywHUnqsEFldiQw9
	2MJbxLSrWDLxqEhUHaIvBSrLcKBCOjZi+70SfgGn4Xf2XGE/R743ny33PMFjiLxQIzD5hOSXxcd
	CEK3s9wpwNQa/0zvh7CZRb/ziSqfKaM3w9I/jPSARw4M6u9DwT+idqx6A6LMq1wz6I4NalnGC50
	n6j2xWGVpesgDmidsQjLrL+xAbxOWAcSRi0+Vxkyevy6qLuA8TIJ2llaL71CvXZE0zb+15s3EVN
	Ppo4Eds5j9iliitUCOhKoBuMOkJsp40S7kO9usqtwrHRYJ9c4cEFrttqKaOA=
X-Received: by 2002:a05:6808:1a1a:b0:4c9:6b4d:f2f2 with SMTP id 5614622812f47-4dc640ac175mr2734728b6e.39.1790354162178;
        Fri, 25 Sep 2026 09:36:02 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-centralus-01.tradc-corp.com. [172.169.249.3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4dbe7e76bcdsm2113204b6e.1.2026.09.25.09.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:36:01 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 25 Sep 2026 12:35:39 -0400
Subject: [PATCH v2 2/2] ci: align job counts across CI providers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ci-large-test-resources-v2-2-f632cf319756@gmail.com>
References: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
In-Reply-To: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1790354151; l=1729;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=uWqEt3TgPcKFcBx1ECxpMbGZZGwZ2GHj6CaNVP9kEFA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEd3kLFfI/d8R5DrncnuUVyebIjLP+R4qYeM3qCEdM58IcSWMbSadzXFyBooZtqGrZOFtYXe4t5
 GQSGFlaBGbws=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

GitHub Actions sets JOBS to ten regardless of runner size, while
GitLab CI uses the detected CPU count. Use the CPU count for Make and
prove on both providers, selecting JOBS after the operating system
is identified.

Use nproc on Linux and NUMBER_OF_PROCESSORS on Windows. On macOS, use
sysctl to avoid requiring nproc before the dependency installer has run;
GitHub macOS images need not provide GNU coreutils.

Assisted-by: LLM
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 ci/lib.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index c6ccbf8c17..db593cc62c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -227,7 +227,6 @@ then
 	cache_dir="$HOME/none"
 
 	GIT_TEST_OPTS="--github-workflow-markup"
-	JOBS=10
 
 	distro=$(echo "$CI_JOB_IMAGE" | tr : -)
 elif test true = "$GITLAB_CI"
@@ -250,7 +249,6 @@ then
 	case "$OS,$CI_JOB_IMAGE" in
 	Windows_NT,*)
 		CI_OS_NAME=windows
-		JOBS=$NUMBER_OF_PROCESSORS
 		;;
 	*,macos-*)
 		# GitLab CI has Python installed via multiple package managers,
@@ -260,11 +258,9 @@ then
 		export PATH="$(brew --prefix)/bin:$PATH"
 
 		CI_OS_NAME=osx
-		JOBS=$(nproc)
 		;;
 	*,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
 		CI_OS_NAME=linux
-		JOBS=$(nproc)
 		;;
 	*)
 		echo "Could not identify OS image" >&2
@@ -291,6 +287,18 @@ else
 	exit 1
 fi
 
+case "$CI_OS_NAME" in
+windows|windows_nt)
+	JOBS=$NUMBER_OF_PROCESSORS
+	;;
+osx)
+	JOBS=$(sysctl -n hw.logicalcpu)
+	;;
+*)
+	JOBS=$(nproc)
+	;;
+esac
+
 MAKEFLAGS="$MAKEFLAGS --jobs=$JOBS"
 GIT_PROVE_OPTS="--timer --jobs $JOBS"
 

-- 
2.56.0.rc2.815.g5b995412e4.frankengit

