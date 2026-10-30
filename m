Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394978;
	b=EAMiv+dhup4RYKmR6iSU4Sll4y3ofbUvxehsm7e7s0+jYoB6eyelt+rCqTCNpZw+ESj0
	 NQ4aR/O9K8tyhuez4alzN5oJLsS8YbJ4FO81ZfdlcK1M0Ui+Fti2On6X+j0+r95IefcvE
	 AjgDh0S2hny1nrc39C2VOWMUShxLotSAOzrZopoRNqnZgPzdb5l1kbN1ErXnPxChSqd7A
	 /na4OyvzZw3ymKCG1BGbbI2XTUBRi2t9JYXiYzd7ZxEsjPQQCbjCPorayaAGc49iiOMHe
	 D4My/ujRnJuPfD/i3Rcn9hxKk1+fJUxQxa/fkSlaW0JvQvlciAI199jRgihIrcUn8rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394978;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=9ObxGcjTr5GDu9qoahDO4IcQOb63FKGQVbcPNn6x+j4=;
	b=QDKaNIOOX9zQIiL/RPSAjvhlYToeYy1o1kVAyZ1786W+Dm+HJpFva1r+17NYkhZUSV5d
	 UtZwc5VeCS1qcNAG075C+ZmukbAeb+wHd8brSOQp+lFKTsS9EU5WgtYoGLdOK+h9orfLs
	 boGNIBrqSoCxqCIeHHuU2bIc625/dyTjhx+6bPqcIuf9Yqyi0UL4ljfBu5aGbYXpx3Xy4
	 AMYaIH3ckkXw51/QCPVy1wcrcdOR+GtCgm6t6UANczz087VeIexh7w6VWJ/jUNXQMP9RQ
	 rqYxfnP+Pi/nlYf3Sx6DykCVZoBNl+lj/IMnm34/qJBB+bdffKQZrwpLuZE2MqrgGlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=c2+qWiFb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="dOHX84c/";
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA677606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 21:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA677606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=c2+qWiFb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dOHX84c/
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6F5D14000CA
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 17:16:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 30 Oct 2026 17:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793394976; x=1793481376; bh=9ObxGcjTr5
	GDu9qoahDO4IcQOb63FKGQVbcPNn6x+j4=; b=c2+qWiFbOtbGzh+29eLIlb8FtK
	JnyZBa28ZanQA5M5O3i0l92TA+vRNlNXKh27z/Ip9ekSbwCZG8ZbTGvbyV4vnIkq
	NIuCu9k0z2idPjKsAseiht8ujPgaGoq71KTgBntEdDxqFXS7aPHxX5wv6gOTHzEE
	7W6yx03GzFgB+UlmfFY2+LKTrVH7z425WhCsdl5zKa0j5JvXpjjEo9tX9HttguMO
	62GFpIdiTgZMOPdsFUAtStAhMNc8m44kaZCSDiWggW7B035/+EZBRhb95MVKdLYU
	kCRVujJ8PcTW5bwHv02feftpEaNj3z7EbUni1kXYkcwbh1fqkMPOsSMnWknA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793394976; x=1793481376; bh=9ObxGcjTr5GDu9qoahDO4IcQOb63FKGQVbc
	PNn6x+j4=; b=dOHX84c/lio8s/duRNHfw0xZvNaytk7XgLTLONrkWxY2lz/zhY2
	/Uux8EO2LCZQmras4L/UL5+Pep/YyJPxUUbzkCvZfBjnSQENP8MnVdPSBDgmZ5n7
	+o75QHj3aPFbgwfbHS5e9LSyl5JyyNkQwEMp/z6XAhhzbh/ZRi1kSOrasp6DHQGx
	Jca9lAKBTTvrEivS/rcD7Cnm2O4oNqJFBksHXyXAPxxU0gtZf12oMgVey3TRV17w
	nTT1SYRYS8sJlJ77I3jaq4qgupUcJmtmpX1bXtXObWRXc7SewYZaws+CKsrRZQzk
	A/geI6sa/KRBD7A52pSGd96ZcnSl4hDsP7Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793394976; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:b1oF48OFRMsuR7L3gbk/7nNDGL+XOWjrtvCTLBH1wkzZ4qp
	yFTlb1lBfKSo7Mg3NPkzs+tt4wSZQbVBGuC2LZPHt01QndAhG6UU+ZdWaR0R75pc
	JX84VVd8g4nVRKT8M+87KrGARWrCEkwhNEAqWVadvjq08ugq9aEM6UUVOJBd1Oy7
	t9erTwJXzimI5TGSlSW9KB6onF0n7Gku+XoI61QyFak0u/T/dOVu8FMEZCPcmv+X
	ksE4M8jknuvkCg6QPfheQ1eKcHPJH3NAcka0JOP9tzktXNgS35OeM4JMLEtBV1n9
	uuiz1NETDR5oCAlu6Vz99f48RfKOM+OhtfF2AtA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:aFwV10iNU8DTcpOf2dapkW2zt7g7w8iBZW2y+bvJCdQ=:qdo3esrYCtLd6Wnrwgtp0Q6c8NS3Tkj8OkzrK84253k=;
X-ME-Sender: <xms:IAnlag2cSg2CSM0yOPrR2xFCvBXi3LykN1CYMYwApKe-czvsW4R7_w>
    <xme:IAnlatUjwtE_Auz1VKuUzGZNWGqE740cQ45aJO7b0-mpGjC-eTZkC6u-KDay6cK0b
    RKxAc-HOSi8xe12Wvbd4qkvMmTo79BRlRt4V5o6FqThMHllPps7yC8>
X-ME-Received: <xmr:IAnlarJ7emUxEk0URoKZIN1QBW_al0O3pAlPBIQx3AUU27-0Ee5ljpdqjWGYFz_j9NCxLVeMNWMSOZBfURrUe4kqBWn7zNgBxNlV>
X-ME-Proxy-Cause: dmFkZTFg5rxP3LpAxwUzNoyMO9dPJq845eMOdU/LW0fl2YsRWazdWjHH17MjjvGCHBVUHN
    amknszt2feHXR7im0yO/qwLsR5RB3sKfpJkkDrDIBUS009d37MU2Sa1neg3xHm3fLRj8Jk
    lam5303TN4Ftc4ZpcM2CslFbrcIrFEdfgqRAvQ6OnMy+BSqCefgBBjVTYUvv5iM/prbws7
    t/lCJmMmfyOHEresaCoBnc+MOzusQmLKgll01HtQoU//KCPI5Hj3W5o5bOTLFvJSJHv7qR
    hZvJltZcIEPa9JVFCWkhEcYjxOU2lRNd1EptdhO3eZ8pZJkTwEdBzbbwGjtzWQ0Ie9hFRm
    Dndi9u8uW6CGG1OQeX2ML52iiWqOUtVQZrOzP0LzDdeh+5qAXl0LEK2zEygIbDeeVGZapW
    iXOLUjVGTcB3HDBzakyF2H19fQb6nA729i/fP42WMYGHiTGgSTvdY0P6rGb87We297bqGj
    qu8gGzskEE/irMQBaIcsllIvB45SWESyUTAJCeLYWq1nnmsa8rs83fq3XEW9vemXh5Nw24
    09W/hs1XizVvSbPaafAt9HQAMu0b1FFl33N+IL+X4lQjJIAlU9HQ1Olnp86JMJVT5dh7La
    uoULyHEgVkff3wSUMB4fBoLyEBznKNb/wmsrQYILPeCuhDnodzSZ7j4h8YGg
X-ME-Proxy: <xmx:IAnlav0EEDNnhT5FYTtEjHVhW0yWL_3MJxEy2Gzpsfe9utvtuh_PrA>
    <xmx:IAnlah5CPmk3ANoKbyodm8Ki0PaLj_hBoX7qDL4WN0haGCJ3XA6mig>
    <xmx:IAnlao963gifVvIb26nrJSdUFXJ_JCJGETMMqcDxandKOzASSH5_NA>
    <xmx:IAnlaoUEhRpH7pmJcLHEm3biWml7OzysE_9oQO6Yjn14uO-5dWbXqw>
    <xmx:IAnlavOuKNG_1AMQbEryBO0CFLR6CFCDTMKOmdeQxv5Mcfe2McvafTJX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 17:16:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Tuomas Ahola" <taahol@utu.fi>,  "Richard
 Kerry" <richard.kerry@atos.ai>
Subject: Re: [PATCH v4 2/2] doc: add new Git tutorial for beginners
In-Reply-To: <13af97a1-a86c-4077-9136-204c74f3d625@app.fastmail.com> (Julia
	Evans's message of "Fri, 30 Oct 2026 16:35:00 -0400")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<pull.2248.v4.git.1793198687.gitgitgadget@gmail.com>
	<4b40588c90c82549c9774f14cfeb4e4741b66386.1793198687.git.gitgitgadget@gmail.com>
	<xmqqpkwtag8d.fsf@gitster.g>
	<13af97a1-a86c-4077-9136-204c74f3d625@app.fastmail.com>
Date: Fri, 30 Oct 2026 14:16:14 -0700
Message-ID: <xmqqik2ivqht.fsf@gitster.g>
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

> I hope so! I found a friend with a Windows computer to test this
> and it did work as advertised. If there are issues hopefully we'll
> hear from folks about it and we can adjust :)

That's good.

FWIW, I have squashed the change into [1/2] of this series, and its
revert into [2/2].  Otherwise, 'make' on [1/2] alone would fail due
to the file removal.

Although some references to the removed document remain and cause
dangling links in the build product, the primary goal here is to
fix automated tests, so I did not address them.

If you ever need to update the topic, please make sure I do not have
to add these fixup commits.  Thanks.

----
commit ea0d9b32d6ce69a67cacaa3c97dd4165248b6bf9
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Oct 30 14:06:36 2026 -0700

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
