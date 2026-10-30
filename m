Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399273;
	b=LK7Ri62OuarwH/g735biDzu0gT89cKSHbQFHLl/LYjIcH2LIunOlyTOk68fQjUEuO0Em
	 nshBddiKknU77CPRah5AFIdLHVCRAK1YyU11Xh7WgEPqaqYEKXItyDwe4bxkYypcMh/Cz
	 z57UY8MkQbC61D9b7QISwCF++ivdwKjwqT8LGP24hcm2tL+GuvX/0D1eokKIGedI2LXVx
	 weY/Tb3P73w+ToX0Ca9++hcUBXUVgdT2VjKlIi4BxAWccj9tcenx9q/esMPsr8mLdkZmQ
	 R+bdpeAx32xsoYmXQtzNaqgOleyV4JX2y1SSLfGZkkUIta8OVwdtWj7oyl/Lz8R3+iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399273;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=WRy8WIP0/L0NsMzWng2rGajdCRZKMuZvhiE5GX9E+UA=;
	b=lHVYWSNesA0kAPNYirrUFkz+7/SFocYUiTKEHgpuvLDroqnZxR9mGZR2bTkRjdTqHde2
	 8pSLPik5DWzLGnbHQeYpslw+wb6aySi+8ZES/nisq78zLYA1oehMNcJOnhjc0cxCstnpz
	 6SNDmN+9otFp/E0xuQMQY0z3QO3IixXEW6vED+Dhg318C/QZFrwgSgL/3F2fgbgetBJgY
	 l3KY0iPmS8kiZzL3jVtmeWGUaRZQOS07GAaL7DPIELoVT4S7oBzLlGaepA9SSM8/SIOG6
	 jCaZInnCTAD8ttcDhQKiZuvsgsmdbcE6Ip+1oHw3yq39AOGsfp9nT+cbVg8T70p0DVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=bnqqVmPP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Z2wA+QHJ;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22914606A31E
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 22:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22914606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=bnqqVmPP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Z2wA+QHJ
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 552391400160
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 18:27:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 30 Oct 2026 18:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793399271; x=1793485671; bh=WRy8WIP0/L
	0NsMzWng2rGajdCRZKMuZvhiE5GX9E+UA=; b=bnqqVmPPT+y+JNRfeC3L/cmpCU
	vD1pRTo/hqAwKrk9M85URPFTEKBtcrdHJSDI/qZBE9TwXj6Xd/FehalHFEuvw35z
	LlstDh7K4hIPVhAk2cUL4xcmTxfbXL1C+FrJOUyRgFi3+tWjmFtiOUwCQcltoVk0
	vMNSYGAo0z8wj43fK+XfEruZByCN2RIGIthTurG0ghF1EBhblm2oTXHSsE84JizW
	m1dASSD8gB+JMcB7h5YXMqQf1KbG+2wCCgoijuIvtbXdNRffMna4IiCHyWk7JsFS
	q/aG4YDNel5PtBbtIw00VOnP2aK04kZ5zYZSLePq5NP1rzrORikF5Zn2TCAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793399271; x=1793485671; bh=WRy8WIP0/L0NsMzWng2rGajdCRZKMuZvhiE
	5GX9E+UA=; b=Z2wA+QHJb2JDPBMhJ8iodidiUB3kCkieXfhzEKizZkoMoDOUn71
	o+QbK+yYZVI2NqHQTn1HzrPMPlz2z0COp+A4UJNdLUpX1gj4bOzWTg75fu1/IbBY
	W5HcXzY7bazECiJ7BUrWvAkDgKHvz/uDkk4f4n8UXm5AiJdLyITHdZh1I6TT2/tV
	ipHuR4yvj/V3AlgwfB3YxH1gbd0EjqjqniGeSaimau9wExrMea6RcuXWb6xvVNUm
	SFNvKywy6YtPqluE42UNvy5xS5scmBBsU90TqJeFQuuhxVjlt6NjCXRauV0lKUz0
	Kyd2/ytqZ7m5Z2x6CyKNUWvn2COd90jXzMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793399271; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:S15khBSa1BDNAE0f8Ur1GqNthq2Pws/qwSC7cj9b7n2GVlG
	0J9xEWzRqO+JU6aBHjcxui4+2H99+tO/Cssis79Salp5uPDMz0K9OxDrd8wfCDyE
	RMUQdn7xJqaHv4RRC1iYtxODSjAfAjqmHh+R+k2hfD6uW+OHqOrmSm65O2kOP5Hn
	VZbVzFNdzpqUFgtMJe26c2Mi/e5XrX4JEfjWpuI3uPIbLmOSyMGrtNfb/o4jaLo2
	S44zT7J+pbs1WX38MgDDYC15ECArZZNX/gMuZ4yJcpeD1Hzom9q+u+4U+Kycvu/4
	F1J4tCvpflUdqf++DUIWTlZe+JCJ1xetxF+nz3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ORw4VMEESrhVO2mWf5382BCqfJoo32+mygvhdsAXKo8=:26cj6hbWK/bGKiTbfOqIDDLJM9d+1p3lWaxIuZ514l4=;
X-ME-Sender: <xms:5hnlatcfUlaA9rHERCKeVofnmWxoxENiMCjuTG12h3OIJqdLMN2-GQ>
    <xme:5hnlate8lFTpJfFq4NxpEo4otk_Fbil_I6e3S1gkJouT0rR8E1BuVY9SiOMz2mcg9
    oh2ZqLt9fxSVqEkX75-EsOVqibAPgUasKACetzf8NVLgTpBwTiIBK4>
X-ME-Received: <xmr:5hnlaoxtdRgCjpc4Ilt2k7staly3viYhnEe8eaW9yX24f4ca5C1_ftEA6F5q5kgjfGpN-zxULfLiFpirqdc4UsaJGAYSioNdlXiG>
X-ME-Proxy-Cause: dmFkZTFijsEamH5DlZS+4QgePEU+RNlFMZ/yDtuCAdl1uRWiWkcgTb1U41Rm35PfD2nU+M
    rFG2GDhis7wrOhUVVvHF18VZp1FGB5mK0u8y+gVXZiSwXqoVj34BBMUoFxfLavAMpcBbjW
    jnWiS0BFvaESmrcnub7lPzjE2AzPMUw0TGJ+BijrQHieH1mBYNm+c0Wj9qhu7AOKI/3B0k
    MW54rzbQZtjbqe8N8xc2ksjpYYNMcFjzsOzpAw5lmZbMTU+8XQEzLqlYJ/ds0xcrDE7Enn
    PWSM/ty3AZwSGWCnSl+BFXfGVA7kJhyvKY6XgYk5shL/5PTr9uTzjNmiJKBiuLyuD7fddt
    /5971do3MzoF4hvrMhQq/xX1o1bwwsMbk19tHDcmsPxSKaXtWWBAjFrRJHJ/FXDVZh79xc
    O0u2YZDb1ruIvSkSQDb/3eNa4k25314pBO2cFLWnCAg08+mfuZf5WqgXy7wO/ryCmX58Cw
    ha4MEPL/r9wwjLhfSMhMRGbu6b0yjOyma5pKDOCyx4fu78hEhskKD121I64QXvra7mfajk
    vdeaNGZ9grgzbhSYX8bvOOD014eOXDTkdG0K6052ULyb+2GLehSxOOxL/JZXAmdcN3ppZ7
    rOtEJPslPsZ2Vc42R5mF09N5ZgJRcMc2HV/lQpwKTgu/a9q2orFuSqHMfqzQ
X-ME-Proxy: <xmx:5hnlas_aKt5xnKTDyOQPx16TOiFZxyTEkD6lBE7ezlA9pQRh16kWsw>
    <xmx:5hnlaoj4XZmQNjv8o3R47QWLtoJm2bprt6BjfzC7lOv12wChI6_qeg>
    <xmx:5hnlarFh-hnWu57QjlWaHh7ViUfKLUDqD02Hll9dh9_mtdF9mvRl2A>
    <xmx:5hnlav_5ZgRLGd8ShBoyYksXK5GePrPk2DoTMLBcpBYvFqYd6HJi7w>
    <xmx:5xnlaiGClh0LPI8ezaq6zPvXV_aJ2g4Z6hN-NbhchzubeP-FCno3mR8a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 18:27:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Tuomas Ahola" <taahol@utu.fi>,  "Richard
 Kerry" <richard.kerry@atos.ai>
Subject: Re: [PATCH v4 1/2] doc: remove gittutorial
In-Reply-To: <9e07da3c-0e75-41d2-8769-1347b3827ba6@app.fastmail.com> (Julia
	Evans's message of "Fri, 30 Oct 2026 16:52:01 -0400")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<pull.2248.v4.git.1793198687.gitgitgadget@gmail.com>
	<64d9811539b531104d01ae4382c90230eea01c61.1793198687.git.gitgitgadget@gmail.com>
	<xmqqh5i5aemi.fsf@gitster.g>
	<9e07da3c-0e75-41d2-8769-1347b3827ba6@app.fastmail.com>
Date: Fri, 30 Oct 2026 15:27:48 -0700
Message-ID: <xmqq8q3evn6j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> I tried to fix this, but there are quite a few references to the tutorial
> (including in `git.adoc`) and removing all of them would
> cause some merge conflicts which I believe would cause more
> work for you. I can remove them if you think that's best though.
>
>> Having said all that, it seems to me that this version is now in a
>> pretty good shape to be merged to 'next'?

Indeed, this approach quickly becomes unwieldy.  For reference, this
is what the change for [1/2] looks like, whose revert must go into
[2/2].  Alternatively, once the final contents are mostly settled,
we could squash [1/2] and [2/2] into a single commit, which would
also ensure that every step in the series builds cleanly ;-).

Looking at your latest message, it seems we are rapidly reaching
the point of diminishing returns.

commit dec52253b94b4e39e35ed1b3318f0ea1d867c807
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Oct 30 14:34:20 2026 -0700

    fixup! doc: remove gittutorial

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f8dea4b395..b7caca088b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -64,7 +64,7 @@ MAN7_TXT += gitremote-helpers.adoc
 MAN7_TXT += gitrevisions.adoc
 MAN7_TXT += gitsubmodules.adoc
 MAN7_TXT += gittutorial-2.adoc
-MAN7_TXT += gittutorial.adoc
+# MAN7_TXT += gittutorial.adoc
 MAN7_TXT += gitworkflows.adoc
 
 HOWTO_TXT += $(wildcard howto/*.adoc)
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 6b164c02b0..f93e592b4f 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -1208,7 +1208,7 @@ the Git Security mailing list <git-security@googlegroups.com>.
 
 SEE ALSO
 --------
-linkgit:gittutorial[7], linkgit:gittutorial-2[7],
+linkgit:gittutorial-2[7],
 linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
 linkgit:gitglossary[7], linkgit:gitdatamodel[7],
 linkgit:gitcore-tutorial[7], linkgit:gitcli[7],
diff --git a/Documentation/gitcore-tutorial.adoc b/Documentation/gitcore-tutorial.adoc
index 71fda63a1c..dd0f0572c1 100644
--- a/Documentation/gitcore-tutorial.adoc
+++ b/Documentation/gitcore-tutorial.adoc
@@ -12,7 +12,7 @@ This tutorial explains how to use the "core" Git commands to set up and
 work with a Git repository.
 
 If you just need to use Git as a revision control system you may prefer
-to start with "A Tutorial Introduction to Git" (linkgit:gittutorial[7]) or
+to start with
 link:user-manual.html[the Git User Manual].
 
 However, an understanding of these low-level tools can be helpful if
@@ -1644,7 +1644,6 @@ to follow, not easier.
 
 SEE ALSO
 --------
-linkgit:gittutorial[7],
 linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
 linkgit:git-help[1],
diff --git a/Documentation/gitcvs-migration.adoc b/Documentation/gitcvs-migration.adoc
index 905d08cd5f..ff68bc1e23 100644
--- a/Documentation/gitcvs-migration.adoc
+++ b/Documentation/gitcvs-migration.adoc
@@ -20,7 +20,6 @@ designating a single shared repository which people can synchronize with;
 this document explains how to do that.
 
 Some basic familiarity with Git is required. Having gone through
-linkgit:gittutorial[7] and
 linkgit:gitglossary[7] should be sufficient.
 
 Developing against a shared repository
@@ -81,8 +80,8 @@ Setting Up a Shared Repository
 ------------------------------
 
 We assume you have already created a Git repository for your project,
-possibly created from scratch or from a tarball (see
-linkgit:gittutorial[7]), or imported from an already existing CVS
+possibly created from scratch or from a tarball,
+or imported from an already existing CVS
 repository (see the next section).
 
 Assume your existing repo is at /home/alice/myproject.  Create a new "bare"
@@ -193,7 +192,6 @@ repositories without the need for a central maintainer.
 
 SEE ALSO
 --------
-linkgit:gittutorial[7],
 linkgit:gittutorial-2[7],
 linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
diff --git a/Documentation/gitglossary.adoc b/Documentation/gitglossary.adoc
index eb1e60832e..e44384fe64 100644
--- a/Documentation/gitglossary.adoc
+++ b/Documentation/gitglossary.adoc
@@ -13,7 +13,6 @@ include::glossary-content.adoc[]
 SEE ALSO
 --------
 linkgit:gitdatamodel[7],
-linkgit:gittutorial[7],
 linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
 linkgit:giteveryday[7],
diff --git a/Documentation/gittutorial-2.adoc b/Documentation/gittutorial-2.adoc
index 6a4d482ed6..6244039b04 100644
--- a/Documentation/gittutorial-2.adoc
+++ b/Documentation/gittutorial-2.adoc
@@ -8,8 +8,6 @@ gittutorial-2 - A tutorial introduction to Git: part two
 DESCRIPTION
 -----------
 
-You should work through linkgit:gittutorial[7] before reading this tutorial.
-
 The goal of this tutorial is to introduce two fundamental pieces of
 Git's architecture--the object database and the index file--and to
 provide the reader with everything necessary to understand the rest
@@ -418,7 +416,6 @@ example, creating a new commit.
 
 SEE ALSO
 --------
-linkgit:gittutorial[7],
 linkgit:gitcvs-migration[7],
 linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
diff --git a/Documentation/gitworkflows.adoc b/Documentation/gitworkflows.adoc
index 49291fe3c7..edeb5959ef 100644
--- a/Documentation/gitworkflows.adoc
+++ b/Documentation/gitworkflows.adoc
@@ -461,7 +461,6 @@ other options.
 
 SEE ALSO
 --------
-linkgit:gittutorial[7],
 linkgit:git-push[1],
 linkgit:git-pull[1],
 linkgit:git-merge[1],
diff --git a/Documentation/meson.build b/Documentation/meson.build
index cfa9c67609..4302c7e854 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -207,7 +207,7 @@ manpages = {
   'gitrevisions.adoc' : 7,
   'gitsubmodules.adoc' : 7,
   'gittutorial-2.adoc' : 7,
-  'gittutorial.adoc' : 7,
+# 'gittutorial.adoc' : 7,
   'gitworkflows.adoc' : 7,
 }
 
diff --git a/command-list.txt b/command-list.txt
index 63ae2a67c9..559b943d68 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -243,7 +243,7 @@ gitremote-helpers                       guide
 gitrepository-layout                    userinterfaces
 gitrevisions                            userinterfaces
 gitsubmodules                           guide
-gittutorial                             guide
+# gittutorial                             guide
 gittutorial-2                           guide
 gitweb                                  ancillaryinterrogators
 gitworkflows                            guide
