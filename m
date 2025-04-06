Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306470814
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968536; cv=none; b=CT4sCT8mf9zWY6jHNhCdXr4ONPLK0MOZQXlI6kE3WIAj4LR+/m8xI/TguG6gJo2MJuwbvkk0zKeg6p7iVA3VlCMG2OE23FXljRrfCJUKBYNxrpr7Wnj/jl5DW5GwuyP6JaIc0cuTBTHNuEpv5h1oLNHhUhULyN1X3/Xo4J0A6Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968536; c=relaxed/simple;
	bh=f0adEdphm6D1w5sI1UDtvwg1RNgImY2wgWCLVqXF8x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oejJT8E2maP32Wo12dRmyWDjpQ3LiPNnzznE1mTWH8kxVDX483CijFozv9XO5UsWnaVV6G4agdOc2H+9RG3xVq/715A3xQOa+1UfZyX0J7ERimgDu4/vuS0T2QtiLgxw4Bqac8PiVhhoKTbtmR9SO6RDINm4Dh1mUugipqFp5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=cS+9yGUp; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="cS+9yGUp"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1VpoupkL9; Sun, 06 Apr 2025 20:39:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968353; bh=6BLxwGhSTMyZVlMf52Y5aa7oCWJkI1NpAoiBUH1U3GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cS+9yGUp7tm4Vf5wRasxXb10Rw7RIkAtABhM+x81/RZHlex7VLozQtVbVM+2GyQ6c
	 TNnj3Xc3njWq5xC2g5JAyjpQ3VhF5a0T8d5fB7MDJA9iULnm61rzWUW128QEvu4zyG
	 qstnrfypwNYr1hbL9IFKUkqyBZ2GwYokfu9FJ4DS4H41iUwDWBZL/5VFvw+0DpPPly
	 Y/2YcUeIMO4KU7VEycv+bziyKu2gU9xBQgOg2cE0g1JJFjyqxriPNca6ULkSxDyKgW
	 8xNwPTlgviNGDCv2AG3EiP9Ph/dpvMJJsPDA2ljzEUa5OdpgP6glhhmdLvt58SD73M
	 BcxUZyjPc77Ig==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d861
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=jTtcdIhh7rpG9tgoBZEA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 01/13] meson.build: remove -DCURL_DISABLE_TYPECHECK
Date: Sun,  6 Apr 2025 20:38:27 +0100
Message-ID: <fe969deec0f8d9542bbb39cd7fb3df98240657f7.1743859985.git.ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com> <cover.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCSXxvdKedaPVwvcLEdpitgqWUqDiA4tkA0NA5kor0g5XOoyIJdSNddzS43VmgBpLkc92sWLTLZmatJZKQENnMFdl02v4tV8KfxqIkfZxRdOWPZjzrZI
 o2lpOvQp+a5wneQVDN8UJmbNd7Y8sV/CjymW7RzW99iTX516JIfM5zec/xO7yvnl9eDbSlRyULFVzL//HEl697ef0nfgUDPK/JM=

Commit 9371322a60 ("sparse: suppress some \"using sizeof on a function\"
warnings", 2013-10-06) used target-specific variable assignments to add
-DCURL_DISABLE_TYPECHECK to SPARSE_FLAGS for each of the files affected
by the "typecheck-gcc.h" warnings. (http-push.c, http.c, http-walker.c
and remote-curl.c).

These warnings are only issued by sparse, and not by gcc, so we do not
want to disable the 'type checking' for non-sparse targets. The meson
build does not provide any sparse targets, so there is no need to use
the CURL_DISABLE_TYPECHECK preprocessor flag with the c compiler.

In order to re-enable the curl 'type checking' in the meson build, remove
the assignment of -DCURL_DISABLE_TYPECHECK to libgit_c_args.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meson.build b/meson.build
index efe2871c9d..88a29fd043 100644
--- a/meson.build
+++ b/meson.build
@@ -966,7 +966,6 @@ if curl.found()
   # Most executables don't have to link against libcurl, but we still need its
   # include directories so that we can resolve LIBCURL_VERSION in "help.c".
   libgit_dependencies += curl.partial_dependency(includes: true)
-  libgit_c_args += '-DCURL_DISABLE_TYPECHECK'
   build_options_config.set('NO_CURL', '')
 else
   libgit_c_args += '-DNO_CURL'
-- 
2.49.0

