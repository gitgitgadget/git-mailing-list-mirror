Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618447;
	b=oCMDKkZbV7Y+DP4MfuupckJJDTZErF33tDa0tFT+zvPNR6MDZ8GZwY/QaV+6cjnSfu0k
	 YaBr1uQX2ZLMP/UBN+dbtaFNTYinoz24JSqFAmNWHgyy2OyWn7WV9ZuqW3SRpWhcbM6uc
	 XuBcIdQDe7Xs2xblYTOv3zV0Z+TUc9s0XAtSOo1KFRJ4XDDI9RMdRRanPaMF37HEdp6hz
	 JzGPgvsNy68wUTXdp+BoY6E6Wn7t8kdXd3Dq6hucjKT6uJdPDAExEfCBVpZUlZ4TBnEoN
	 XTPgywCvvJWkKXMml5xyX7nHgep9VPAzVKsTjsafey4cmQyGEm5ZzoceIb5kf2lq6eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618447;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=cJa7A87wrT/dy+r0yF6ECnbWue21SRiRm6qvH0YFKlI=;
	b=QPitshhqbIrN3yxdxjVDGGb+2BNc83PWwhF6Ofslwyjz04OVwX2WI1W7jWM6KUujmu/Y
	 JYZdzlKnRGs6gdqH/baQvmGzo7eA5QmLWATaYDs4W3eygDkK5CfJJ+rrsYw5wRpVmLzui
	 hLFuBHPKb7S1OkN539s75WSX5atWRUWXVXFQysUfWYlBBaKfNKeLQcqOgUuulNwZBmz53
	 z6c6OtM/vbbcuC79H+e8G8rtN9ZujO7geLMkrs3U8RAzdQBCSpaixdRUcRDPdCnPoUhPw
	 ymR3fjQB2+xvCtsjDLTVa7cjsqQqjHqh+E/yLu4Ip5O0yRTCPhY3JaI0nBVyFa8ugSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=gkWyFSuD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=R+Vfcshh;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8A606A338
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41A8A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=gkWyFSuD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=R+Vfcshh
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F6A21D00233
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:20:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 02 Nov 2026 06:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618446;
	 x=1793704846; bh=cJa7A87wrT/dy+r0yF6ECnbWue21SRiRm6qvH0YFKlI=; b=
	gkWyFSuDDhZ9EfOk1OgRbbZnBVnEEumdzbarDs7SkBm/+yU/nkGiMqRXaUjPZypd
	AQbDEj+FuOTp18sQ30YPwj64OdZjJ5YR142woTCrW3vdokyy+ThIOGuz48r3AKYk
	MvG1nD6LX6quvK7URLbmb1TicHY789DpdPDLlqbnipW4aGDgrkpTzGq/OD5VBVzp
	XC06ei14IZBt97uLLVDBTBBvE9uQdLppXfOJubVTWhaOIToPA9n+Ztp4B7ODmln/
	Wg1ayLNAuGDIMV6Qx+k6ISyKKfKcneNa818VFXf67I2P8Qdws3HOjtVxB8oe3orV
	KSYzlGB6jyRstXdFFb0NDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618446; x=
	1793704846; bh=cJa7A87wrT/dy+r0yF6ECnbWue21SRiRm6qvH0YFKlI=; b=R
	+VfcshhTeVc5hS0/DcehEN4WsS96SDORRLFlEQPxTbEpRwgl0UiS7ghAs4iIzlUc
	VwPXIB2idWlF4arTpWPSAHeWqidYKx06WBY52XJAd+uwLiMmBoPsEEB0CCm8Nzng
	RQAbf/V6wx7AynX+n/P/FOOmEXCdme+N25T7Fm49CiH+qOZS8nQ5/o6qNHnHm00j
	Rq0TmNwQoG+dL/AqdXzx3d4Fd4bRWeI1sVAYh7SCiq3+qhGSaQvSu1GmV4X1nrnQ
	5k97F8jl2CIqiT2GUNLcphuEfsvgEdxe4i2YNQX/F80R+9Wzp1J3sSgq27rSQHB5
	aEvPWX5IeLwoTjwSc9T9Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618446; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YmDlnDf7OGYSgWPS4xhowttS9Q7DiiJimjIH+69zEeE5R7I
	gJE7iaQ99V1vvfZ8YTNRxALsyxnTWvGMvmUn1H4r0RXZyq3xdxOEb8MpuAkB4A8q
	YJ9rO0dW8+V1C4rJ6dto4ENuYQgBFOSR8aPlFz02fz4mcWTIR+CV3aD9HypvJnIg
	tDkFI6fBr10wWnnmwp4QAJT6JPA/2SUwrR06sJkOiHcqz4EaAmnTzXm1VrP/7gCN
	1dygHxwNYzX/2zbsnc2Vdk/dZndtedFUzbZ6NJNUOy7Lndb/CSOitc9WS1KdJHFm
	lHJedpkT22x2cL/8IPCcwZ9qVCc5CkcxxnUlF6w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xz6MZCzs/NsNvclQPGz3vO/wNrNoadpy/VsrIXMrhxs=:wIBFGemNWHlHAXAHXQyYWQJGipJmVdNYblAuElhJxew=;
X-ME-Sender: <xms:DnLoap_0ZcdsZXVSCuNk9xsUS8FPhWapHtB1PLGJsYYMGIfPGRBfQg>
    <xme:DnLoakoWZIt4Jwo1T7sY1UgcurfzswWeDosCUj4SLXR9cxI7trnUQWl5gyMyuXA4F
    iiRfreKS01eMFY8kibel1kSeCC-rlJfi_xRvEblFdr-Sktx1dJlNQw>
X-ME-Received: <xmr:DnLoaspk_nkdp0JGvCcCrDOJOFojm320rDy69OXIp0kCMYZGLJEjfWRLHc3HVpNoospvkw>
X-ME-Proxy-Cause: dmFkZTGQj+fdf3mI5XjclMagQeKqcdM6WQpmferS0N7qMh8Zbnkfb+YPsLip4bO33tV5le
    w0kC9+ic4jj23SzIc7eu6MKv7woEjLAV1ktqs44Z5huXtv3Z8JEXNLh+mg49LZqZeDdBay
    ErkQTUIPOrj0eZ6vk3RE7IEWxi49xcDsxiMdXik4/sk4KzfrfoANatefJXc20M7qveGnXf
    ykYAP2W0lp5KlIa44pfxJsfx7yzPRUj6dyygxuiDAuYthmMsFEtCwhKfwBNdk0DtxCs/Ka
    hzEtGgC3NiGtzn6D+1QTWNsp7I3v6pdyxxj1DzJJ9MO3aGF04699lcXkyQSICTWlBOLukW
    coff5EIdOiVpprWKBwkv1f7mHNCEbvoCePrPTXz1YDbjvtPFyjnEI2QHQFukyQ+nt3mtIX
    rClt3EgCVAlVhEymS+TriidBa35rZDSKr8zF27pgf4G6ItOtsin9wHgrG6AktSeoa2yP4p
    jIWZ5y4WEN5dpS8s/UfJQedqa1FMtuQaU1oaw3WwjrGNDA6pdEbvOhHseOKMU9KAmRgm0e
    8N9ODqHO+/7LKx0ZAjKPrSN1ClXi5ORL/P5asyb7pgRRTL6CPSZMDfp8FuHp91yAZMCDWM
    wXkAO8Z9j9KZJFAaH3h+gS5khyUUiA00PvhcCWxLsx/kXuL6R7hYcqKaPWjA
X-ME-Proxy: <xmx:DnLoainni_5gGwmVfvsGe976eAYnql91Wl0YvIKx8YNi-zjLan3fFw>
    <xmx:DnLoauE3MVwDxeF0y9d1qsJjl-55TKAzDHguyYrj6aVopWUHHdpM6A>
    <xmx:DnLoarrdP9xVBXkDQsay7W9bIXD3YV_PZVut0NnMjg5PqJwTdzQ1Zw>
    <xmx:DnLoaq6N3eou-fFWE-blxALcqwgUs88daniFwRjG7kwfStwUIaoFbw>
    <xmx:DnLoattS3DlygF8S3BjP5JDSrFmi0kQ6v4EE0aN8zpX9vQOPs3v8vYER>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 2 Nov 2026 06:20:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0f487eea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 2 Nov 2026 11:20:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Nov 2026 12:20:22 +0100
Subject: [PATCH 6/6] object-file: stop including "git-zlib.h"
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
Message-Id: <20261102-pks-odb-loose-cleanups-v1-6-fbbc86c29693@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
In-Reply-To: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

We no longer reference `git_zstream` in "object-file.h", but still
include its header. Drop the header and add it to all the other users
that implicitly depend on it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c                | 1 +
 builtin/fast-import.c  | 1 +
 builtin/index-pack.c   | 1 +
 builtin/pack-objects.c | 1 +
 diff.c                 | 1 +
 object-file.c          | 1 +
 object-file.h          | 1 -
 odb/source-loose.c     | 1 +
 pack-check.c           | 1 +
 packfile.c             | 1 +
 10 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index a0b7119c639..c705ce06adb 100644
--- a/apply.c
+++ b/apply.c
@@ -21,6 +21,7 @@
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "xdiff-interface.h"
 #include "merge-ll.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9db3f83eea8..c4d955b61f1 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -5,6 +5,7 @@
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0264c18c5f8..6d758a04419 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -6,6 +6,7 @@
 #include "delta.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "pack.h"
 #include "csum-file.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e53c69af31f..f13c49090a1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4,6 +4,7 @@
 #include "builtin.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "config.h"
 #include "attr.h"
diff --git a/diff.c b/diff.c
index b4ac17f8efc..0309f91f5ab 100644
--- a/diff.c
+++ b/diff.c
@@ -18,6 +18,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "delta.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "xdiff-interface.h"
 #include "color.h"
diff --git a/object-file.c b/object-file.c
index 917a65d5b33..cf859520949 100644
--- a/object-file.c
+++ b/object-file.c
@@ -15,6 +15,7 @@
 #include "environment.h"
 #include "fsck.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "loose.h"
 #include "object-file-convert.h"
diff --git a/object-file.h b/object-file.h
index 746356ceb51..70138a358de 100644
--- a/object-file.h
+++ b/object-file.h
@@ -1,7 +1,6 @@
 #ifndef OBJECT_FILE_H
 #define OBJECT_FILE_H
 
-#include "git-zlib.h"
 #include "object.h"
 #include "odb.h"
 #include "odb/streaming.h"
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 5cd679e802c..737d583f033 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -3,6 +3,7 @@
 #include "chdir-notify.h"
 #include "dir.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "loose.h"
 #include "object-file.h"
diff --git a/pack-check.c b/pack-check.c
index 605811b7b09..c6c3d7c9c0c 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -2,6 +2,7 @@
 
 #include "git-compat-util.h"
 #include "environment.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "repository.h"
 #include "pack.h"
diff --git a/packfile.c b/packfile.c
index b32b4cd75da..59e0e0c1c91 100644
--- a/packfile.c
+++ b/packfile.c
@@ -3,6 +3,7 @@
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "list.h"
 #include "pack.h"

-- 
2.56.0.500.g5d06dc02cd.dirty

