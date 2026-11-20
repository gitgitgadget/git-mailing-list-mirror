Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795148963;
	b=El/+f6PsrRijk9AHIufg0olD4vP0RA8omD/J7rWj3USORk0mUD2MDrH2nfku6dZNn4R8
	 FzTJs8Npot9kvMNnld30pzNf620BqzlKznVpZf2QOVXzddB6ZBP18N75kAam8wx2cHyf2
	 d47Qd+d91RE1r3eEM7hTlJb9fwl7/oCVime2FJmRZDUzOLPt2dTof123PfA2fpmXWlwQr
	 tSL6aLfrFTqSrLZ+Df+mT2ztCL1OH4AWHrV+lHttj+KhTY+X0iZClNU05cl91iJlUP1rQ
	 Lu7dzBnlVXqw3wv9FSoOzspHb9a0QvcWMmP2gSNzCcOQ7He1WEmV6uTCSKrwPoDBGHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795148963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XsS+XGqIdE4cMAz//wIwiKIBx3Jvlq91qULwS3a9eZs=;
	b=jXb9ZLbuLjQAxEn562npmQ4YkmwUshr+Ps6D8RfTZPxVcgZKcV1VKyuLLJzM5szQWN/6
	 FaoEYSw5VZ00Pvqji/Jaw0PVm642Hg8t9c63p2H9U3tLZOugvOXhe5kwyJ0NHiL3x+RJo
	 HLM9sC961ZB0SBJpM5cAeobA0y8yV9teYZtf0VABWktSFCQeXI3ln6rA1R7zCcmnPS3to
	 TxULlcxOcTmNBLUmnvCmRYMjpm5pMnT/4QK+EDEaezyBB6FpgZVdZoeIxmHEzsK8xzyxT
	 aM8UxD2ktht49LaoGQcbFsGXTwqwG5y3Ba5B50bbsIGd9pIcwKOn5fL94HjufdKaPkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="C/OrDSDR";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40885606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 04:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40885606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C/OrDSDR
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b1bb072438so53472a91.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 20:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795148962; x=1795753762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XsS+XGqIdE4cMAz//wIwiKIBx3Jvlq91qULwS3a9eZs=;
        b=C/OrDSDRzXsfKIdkaejBbV1SfKQKWpXzvCjRlcD3zaHLYzNO36KmBflYUNMqiJvcBZ
         ViiHKt73wgGlAUqd3prbKjbpvThBFO4dd3DPOVjvpf91lnFbZIDOQFPEzD2vvsypi7pd
         yaE8+o3AQW1kqKJieDniEsbT8I8LRXzWsFPpt8iqNOozjvioqkhgncL6i6VEb78j6ikL
         gNMKEqoIvk083cUg53mtlJt8yhoE0PAyXrsJ++2snPFiC2Nnw5HWa9xdbXJSzPdfov+N
         Vhwu7he1V3TsCzhyw/dhqMNhVdS+eS40RxAjLlSVz9oxWIp2vdfVGS3T77QZVFqGHzCk
         EfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795148962; x=1795753762;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsS+XGqIdE4cMAz//wIwiKIBx3Jvlq91qULwS3a9eZs=;
        b=Sx0amHCg5DSbJ5RN+GsjnNPRlCgd4H/t35HXMCrcds+4Ih7n88RxvxPwymcHiYtnCe
         DSlZaCGnj0ShxJ5Psi8HXNBlu1uDXhdk85fcKZJxMScNZ7EG8SA2iYt0YImrgzMWJBUi
         0T7WXd5w2+FF+ShMoLVsjXZXtcJtfV6edNvCRj4bX8xcugY5Hi9lO5uLLmIQ+HQCcZEM
         7iqS+MivFZzLpcbDEwJWFg9pdY4keG44YY0F7WXHtPOoA5vvUZTuizERFotorfs8rbD/
         8l4yIdS0jhr4omSqEBrhVLT+8fCKD2QxLI8dLgXznM8f9ym/3KL7duXeo+ZbPrZFuT+r
         92dw==
X-Gm-Message-State: APuU4Z+RWw7UHVGbratm2uvaxPGG6iNe+Tegd9TlRiX2/CLrnLpygRdf
	qKASSo/wchktmkJChqj663cVpn/fGKz+M9Sxz2NxTmgFP0jj0/AMERg0RcUSGqPg
X-Gm-Gg: AZFdTZfYwq3IA2sKE4pQOB67Npr6qa6xe93cgyDax9bsHUunQibR38362f5KyfykjuJ
	/K+QZBA+6jB54aVJ59KgKEsXHjIimHOVTaNEgKfq4sXAksf5Y0e/CvytdOSLBSXZu7mMozTdBK0
	HkItL/Gn90+xll/jf0AzpyhtatqUHEL6+q/Hly5PTbnPdVYNmWaDnupi54irXA4gx/zIFje3raU
	hwB0q6SziNz9Ng7WJ8t05WQ0TCTy5ybrMDOp2S1sEMTh+zSnxgw/BkU/Ya5HWhHxQQAYe/F21V2
	vhEtRXxIVlmjD5ABrrzBuPLbfNkbqx1LxKw6VlwA2ZY9B0ZlpN46FYxI7TiWJGXuxFdWpyCZNQj
	Niml5dGPShFlAtFPD/VT5N7EOnbCLHnP7ZtN1Ch0XRHlo4Cv1gNMMNc0IqfLd3ND/VnJyfdv62U
	Aj2tSVHx1CEaOMMNpOK9bKft1btt4orCxCevuwcBqXfUf2tbDKXu1AcQg9jsGFO5UgKkfWmdel0
	6il6I0v0se6cX5g+5A8tqYwikkZH5iZSXiQ7I5sVpOCd9M44zvee/djirdvtacCybbkTg8tWeCj
	9Qpg5rYjlozAzQW9stOfrXH40CbglRkqVAgSI5jcxxOqJkFVCZMU5YdT64W3eElZmHzp5lnFi+4
	w1sq9A5ukuGyk4vyAgaTGaaq1/bKKiicxyAghqNB1eR0=
X-Received: by 2002:a17:90b:2e47:b0:3a6:e61f:749d with SMTP id 98e67ed59e1d1-3b41c7d65c2mr2521869a91.1.1795148962441;
        Thu, 19 Nov 2026 20:29:22 -0800 (PST)
Received: from pamplemousse ([2604:3d08:9d7b:1d10::e3f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm4011442a91.3.2026.11.19.20.29.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:29:20 -0800 (PST)
From: =?us-ascii?Q?=3D=3FUTF-8=3Fq=3FAndrei=3D20=3DC8=3D98ova=3F=3D?=
 <andreisva2023@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH] builtin/clone: fix --revision with SHA-256 commits
Date: Thu, 19 Nov 2026 21:00:52 -0700
Message-ID: <87mrr486sg.fsf@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The refspec item is created before the destination repository's hash algori=
thm
is set up, so when cloning repositories using the SHA-256 object format
parse_refspec incorrectly parses the hash.

Signed-off-by: Andrei =C8=98ova <andreisva2023@gmail.com>
---
Hello Git developers,

I was messing around with a repository using the SHA-256 object format
and I noticed that --revision doesn't work if you give it a SHA-256
commit hash, so I put together this fix and a test case.

Thanks,
Andrei =C8=98ova


 builtin/clone.c           | 15 ++++++++++++++-
 t/t5621-clone-revision.sh | 15 +++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4b9929b980..69513a14c2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -963,6 +963,7 @@ int cmd_clone(int argc,
 	struct string_list server_options =3D STRING_LIST_INIT_NODUP;
 	const char *bundle_uri =3D NULL;
 	char *option_rev =3D NULL;
+	int rev_refspec_idx =3D 0;
=20
 	struct clone_opts opts =3D CLONE_OPTS_INIT;
=20
@@ -1484,6 +1485,7 @@ int cmd_clone(int argc,
 		opts.wants_head =3D 0;
 		opts.detach =3D 1;
=20
+		rev_refspec_idx =3D remote->fetch.nr;
 		refspec_append(&remote->fetch, option_rev);
 	}
=20
@@ -1525,6 +1527,17 @@ int cmd_clone(int argc,
 	create_reference_database(the_repository, NULL, 1);
 	startup_info->have_repository =3D 1;
=20
+	if (option_rev) {
+		/*
+		 * Re-initialize the refspec since potential hashes might have been
+		 * parsed under the wrong algorithm.
+		 */
+		struct refspec_item *r =3D &remote->fetch.items[rev_refspec_idx];
+		refspec_item_clear(r);
+		if (!refspec_item_init_fetch(r, option_rev, the_repository->hash_algo))
+			die(_("invalid refspec '%s'"), option_rev);
+	}
+
 	/*
 	 * Before fetching from the remote, download and install bundle
 	 * data from the --bundle-uri option.
@@ -1588,7 +1601,7 @@ int cmd_clone(int argc,
 		}
 	}
=20
-	if (refs)
+	if (refs || (option_rev && remote->fetch.items[rev_refspec_idx].exact_sha=
1))
 		mapped_refs =3D wanted_peer_refs(&opts, refs, &remote->fetch);
=20
 	if (mapped_refs) {
diff --git a/t/t5621-clone-revision.sh b/t/t5621-clone-revision.sh
index 54789423f8..1afac8abaa 100755
--- a/t/t5621-clone-revision.sh
+++ b/t/t5621-clone-revision.sh
@@ -78,6 +78,21 @@ test_expect_success 'clone with --revision being a raw c=
ommit hash' '
 	test_must_fail git -C dst config remote.origin.fetch
 '
=20
+test_expect_success 'clone with --revision being a raw SHA-256 commit hash=
' '
+	test_when_finished "rm -rf src256 dst256" &&
+	git init --object-format=3Dsha256 src256 &&
+	test_commit -C src256 --no-tag "initial commit" &&
+	oid=3D$(git -C src256 rev-parse HEAD) &&
+	GIT_DEFAULT_HASH=3Dsha1 git clone --no-local --revision=3D$oid src256 dst=
256 &&
+	echo $oid >expect &&
+	git -C dst256 rev-parse HEAD >actual &&
+	test_must_fail git -C dst256 symbolic-ref -q HEAD >/dev/null &&
+	test_cmp expect actual &&
+	git -C dst256 for-each-ref refs >actual &&
+	test_must_be_empty actual &&
+	test_must_fail git -C dst256 config remote.origin.fetch
+'
+
 test_expect_success 'clone with --revision and --bare' '
 	test_when_finished "rm -rf dst" &&
 	git clone --revision=3Drefs/heads/main --bare . dst &&
--=20
2.55.0
