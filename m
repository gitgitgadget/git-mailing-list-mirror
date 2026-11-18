Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994339;
	b=uNmECRDI4qoKwsApMOGFdOdsgYTxr2BsEpELwAVZYf2V0XvrPCgA12RU3cuS4DGGQPL3
	 /NCLOBbmYKX9rRsKzyb4uY8Q/sNdWHShTPvEAAcBGxT6sRdG5x0D2cT6Kc+gAWeud7SVR
	 ilquMc2UzmrKfXmKgolMUudCSZjCwweR89wTRCk/yo7pIRSZuY46IbGpAPq7zXfc1gTb6
	 vZO8+Q7Crf33riVl2VisIVAk4rQNPmtv6w2vT75xI3Ajai6Td4VKstlD20cKCF+c3+uI4
	 8IDN8l+xE+frdRQ1V2DjCjquBksMUcFu+6diAKd2lUmnydSgvzvIqxAJViaID1jB8rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994339;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=FF+yAj56cG1I+dcGkLgKjf6N/SJzpV09unQKbxBk4f8=;
	b=3pVSlBjFzwye+MXSAEl5Hb4AzjSdfZg9zLWW6ol3qd5LlBLf+lD0txIyPG31ROe7Hein
	 6RYzctxDGlBPjIFLOKcnWBVPY3Nt8MRh6bfoyHBy2A8z9w8DdjWdM3XfQkmrtWvfUi4Ah
	 E1A5lRSXCvPLzwKwhEol2T78O3krzKOx5nt56oKdf1yKfU+OhHY/jJgjaX6kxBcT8QjcK
	 4nwb0NmnnMUmYIPX5jWnDX0k8mYRSqyJsziGZieQDOLeVMWsoiaLJNhpoeNusgiGgDAdg
	 hUPUVitqz7ApKliVoapxZksZCmiy2OnYif8/hutHqSYHa9lnBHtmLYVD57yFtANmESQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=dD94kb6p;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Truv3XMq;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A1606A89C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E4A1606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=dD94kb6p;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Truv3XMq
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 30049EC022F
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 04:32:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 18 Nov 2026 04:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794994338;
	 x=1795080738; bh=FF+yAj56cG1I+dcGkLgKjf6N/SJzpV09unQKbxBk4f8=; b=
	dD94kb6p4z0hSy3c9RLc9AXLAlBOyDxNT+RuLvbZy1PjGGpMBkPnqBMh7+uuJguu
	xiCP2ivQXSh7ZUGjgpdjJzymQQV0GFJHUUIRN9CE+c3TpJ4DBlnJa+70be24rECn
	/i9/ZQz6Lnc0TJV/2YZINf0a38pOEMjYVEoLX6QTKMejMTn9/XaL+H0l5h91kT6U
	KnmI17zj5/8tXn1cMfbA2BY/FMQPdYTSlgaaI3qqycoHcfQpdB5WrVabYNZ6qJC0
	xw7n1ndVJPJfq9w9DbJLVLiaXFC7/qeh/rrCUsyad3jao6nKavtB3IKrZxouEKfL
	iSldQJP5+JFksj2nreYKpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794994338; x=
	1795080738; bh=FF+yAj56cG1I+dcGkLgKjf6N/SJzpV09unQKbxBk4f8=; b=T
	ruv3XMqYNUAjeFZ4CuWco3gu9g0vb5ar4wE78QbsaU3VLD7qjsQw6ooMStUMvZkt
	ylC7NWt1XaKnCKT06N16BenvP4KO8en3t3vJz2qPBPjtwZESgItL/RtF2ommb1ax
	Fy0Drod7waOtbfLFBd5wrOyWV/Kq+iAUBlSIbFymizzVHrOz6M2itpe9T6yZaw8u
	7ZLISRVSJUKQ7xta6Xyf/D6JBt6KK9Iq7jdeaMMtj965H38AoTGVJ6g0mu4ebEnM
	ZAdVwkb3Nv3OlzoDkYrxPDGjjJy3PofGU3rdNw8CEZqgEOLOsg73EZibWGht5lh4
	9CIRg4weUB2TPUp24RfnA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794994338; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:s7o7oq2xk9rKgXCCM5801DIuRgdCCQcrTByjL4akAHvCGs8
	jeLQ0gfEY1t9ecs4jbl1f9eDqoMmdfeaqVNLcAg+ngjr0GJGramhV33a9WGN/Fz9
	9gV95PQLn/yyWOuQEsKor4c/vyywGTDsrXM31gLDyQ9JeWtAFLuAk1swfBN7D3ih
	/tSKhqzWF2Y/h38napC1zXgXMWWIRYIU4NfDCy5B7kXWNcJw+CrqR1WYBCrI5XM6
	TCzB0UXytteZkpir2dQcgI3rnpS9dLAJOkmNjHZRxTtEsWHrHANRBg6IYPyfIaZX
	DSh0yGR2wc0tXmkGZtIH3BTQu8+xr7FswngSmKg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:A3FUFsdECgynGQ9vQNuVeim9DAc1iopbtbmHCTfoZDs=:NlF6WGAWFi7IFdUxTxcyZz22KGSpzepJolzHmYrBTHI=;
X-ME-Sender: <xms:onD9aiCam7IAY8XrZss_OIxfgzgrY5SE1Ulvzzo8uSs1-jjRxxIAfg>
    <xme:onD9ajd02VSoXOJEOMW7Ql3IWHvBAmZ7Ib82mgjARrtubA0NvAJ0VKym68pDcLFIw
    jtP63F7pRnR8-vl3eDBh1lLYSGI9qLCfXfimML-faBH3d_19THkbBw>
X-ME-Received: <xmr:onD9arNQ1s9kiVeDt5WuSq8uRD6e5XE-l2p2bBHxWiGHsK2CtGuYhg>
X-ME-Proxy-Cause: dmFkZTGLgILtr0lEBCwVpNpc/C8NAkj7uHjua/DnKMLe5JYQ5NK7p6g8cx024oVQCRJJgc
    XFAHTKCDIbz8OW5iy5awc73t5X78ewUA1phKistsUhPkHcy2aOYVXQ4/ly4RNq+wsdVvzy
    kcqopcWOlOFk7JkliQj0Y1W7rI+73BjXkenihzg0w50AXLadNp6j4uxEK0xnrn64PTByjW
    gIeWUUNGvqBibpvp4nm4i+HW/GBuZNf1vbZU8FP+2kNDuiHKdi87HO6EBs9HtcouX0GWTd
    Dwai7OCqaXmoBJfZ8BYtEzaR4ue2Ea4b957/BWu56UxnwIGvORmeM2cb+DAPccC2ec5Rg3
    bEeRqagoV5SKeS6Pq17kX+9NI45HXTapryHy+Lre2mAaAl33spE5hMalvOL0h9MvuKMFEl
    aasnfFiVD/NMkJ+FAxHdqPmnZKhYmwWucL0uwTlrTkJcZMdzguyefC9UXMa8/OlgdMSKVh
    MH0Vxfh+RpXN0ID4CmFIHKLU4HcbtWBt708OW89Hjajn3UpVnpgaoQl1iJUv0HGnSitq03
    MBQEy98olIhs4nYwU2FvH8b/kJALga7eviXj3hyAFZw3yJxzYpLS+kORNQL3Z50lTbofTg
    2YZorES2hbO+gkr4EOZdc6bI1sY6iz9ubyP20669sJ+yLbdUh4xo/LebGSNA
X-ME-Proxy: <xmx:onD9al6vOhLuIihdLXhEpTNGSu4tZqo1No4Egt8_nYMYHdFKFGsiTA>
    <xmx:onD9anIUWEwS08lVFh_dTqJ0EXwhp6rk2mF9flNa7_BBrRTQ5rEjLg>
    <xmx:onD9ancNohrarNPKUfy5n750wMV2Zd3LSqRJ8HNyHpXE_x9aIH42Qw>
    <xmx:onD9aievy5nvgtxPzcxlknX7nAZ1BM9kMWLyFt-qhGs9152djQ2Vbg>
    <xmx:onD9alCS0S7Qjd6GmrIDTXn3RZLQQT_C1LJcWJweeccEc4thG50D13Rk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 18 Nov 2026 04:32:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 487c6cbf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 18 Nov 2026 09:32:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 18 Nov 2026 10:31:03 +0100
Subject: [PATCH 4/4] Documentation/config: fix typo in
 "maintenance.reflog-expire.auto"
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
Message-Id: <20261118-pks-reflog-expire-performance-v1-4-10b9263566a8@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
In-Reply-To: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In the documentation of "maintenance.reflog-expire.auto" we accidentally
refer to "maintenance.loose-objects.auto" instead. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index 165102518ce..7066fe0e168 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -116,7 +116,7 @@ maintenance.reflog-expire.auto::
 	negative value will force the task to run every time. Otherwise, a
 	positive value implies the command should run when the number of
 	expired reflog entries in the "HEAD" reflog is at least the value of
-	`maintenance.loose-objects.auto`. The default value is 100.
+	`maintenance.reflog-expire.auto`. The default value is 100.
 
 maintenance.rerere-gc.auto::
 	This integer config option controls how often the `rerere-gc` task

-- 
2.56.1.831.g720f3f5937.dirty

