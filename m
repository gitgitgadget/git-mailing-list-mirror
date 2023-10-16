Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3B929425
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b="fu4Uz6l6";
	dkim=pass (2048-bit key) header.d=tritesengserv.com header.i=@tritesengserv.com header.b="1c9qKzCv"
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Oct 2023 13:25:28 PDT
Received: from relay2-j.mailbaby.net (relay2-j.mailbaby.net [68.168.211.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E9C83
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=uNdq2qdTYtyh1cPcpSYTX1lnZ6tzl4KY3AycJ7P51xQ=;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding;
 b=fu4Uz6l6iX0gxr+UQngKevfxqIdmxVNONJJGl0wJC03ml2HvdMxTXZ1pKoFe7oz4m6P+ZombD
 PATSTcj1TJOzg4Q6hS5Sj/NKZ8y3e6aL1JRO9ZnxXeB82EhG5MsUgF1g1cvueVX2RcgB6fvIxJa
 86QOErZ9lCMTh4aj48Kn70Q=
Received: from webhosting2051.is.cc ([69.10.62.42] webhosting2051.is.cc)
 (Authenticated sender: webhosting2051)
 by relay2-j.mailbaby.net (InterServerMTA) with ESMTPSA id 18b3a2583d9000d9b3.001
 for <git@vger.kernel.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Mon, 16 Oct 2023 20:20:19 +0000
X-Zone-Loop: ab3d3045d7cb9a1f26443823231af2e1f6a1ab39b79e
ARC-Authentication-Results: i=1;	rspamd5.mailbaby.net;	auth=pass
 smtp.auth=webhosting2051 smtp.mailfrom=jtrites@tritesengserv.com
ARC-Seal: i=1; s=detka; d=mailbaby.net; t=1697487619; a=rsa-sha256;
	cv=none;
	b=EpP7a+6TWpAc0JqyEB4XS6HAOpjroIKMzp2/XA7aTEgXVF7eQhKHk5Jd/mr1MAOkIVwfnR
	zIieQ8XCSZlxU8VF62uDUn6IGMtWAG6Fql0gqFOD2ikqZ5DQxip6x+M/9gHVtKREbpze9b
	XNSzX2sQtUs8Cj6Zow9DJekGKuB6nRIWRtSNEk/WUb+1KPOsoFiNGIsDjNMJesWDdH84MQ
	awBTDEv3/kvNQDKsaeqELv2rSlx8b2OzUtR63mZjM7wonMswHiV9Vq6otqjUnZPqCpQoil
	xaEHPY4dKmDkeRoG3HYyS1ZJOdLyVAF3AZ0/ZCt/ljDlZcQKag/OZ+1aaAnElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbaby.net;	s=detka; t=1697487619;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=uNdq2qdTYtyh1cPcpSYTX1lnZ6tzl4KY3AycJ7P51xQ=;
	b=eMXD713tCbfwUAXdh9T80qFh0P2Eexbswnck7sve04uEwvFyvCFboS9vbIrSLktakYVoJI
	6NC6nUw7fTwwHXe0qJbjl3wa2brJZL+cNz++qR8paP+R8K63BWrZKibFCszIY3eGas0f4F
	D+LxX4z1dlvVCO76ASZngYVyPGi6BLbbmbnmZQYzRpAuEmboeWwl9MrPt4w0RsGXASxot7
	5H1R4jV5leBMHiGjCGHgKRYiidPR80ICHaViUTdr5Ih6Q4aFUjl8VtFAnUmZZzY0SW66ny
	WfgOkmGaN1KPJGqSRRzwiP42hFiUi8PoCdXgqlcisCBDzlHME+bnlToPizoqbA==
X-SPF: pass
X-Originating-IP: [69.10.62.42]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tritesengserv.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uNdq2qdTYtyh1cPcpSYTX1lnZ6tzl4KY3AycJ7P51xQ=; b=1c9qKzCvs/OhzBo4zRnJCcC3qy
	ornP7RCia1TgLyX7Pbqo5VT3ns95/HsjMiOTUoDTDw5T41nq7L8F+kdJMQ0aPdmhhrkvxOJpbygXk
	R0g+3bvo9Z7z+3dU8mIzMm7vBrasKwUb1xeDJf7nPTKouiU4dNt+y9dSBsyeW43Q5zaIajEGZQVVj
	MM0LS4vvwTz25YvH7J7fd+yc5gwpVGIME27sjHDD8yaiUcAQjigCdeeXu78G0FU3KbQf/ElQTOsZi
	P31aeSuMd9FqvHM2lyWDKm4a26E3ZM0WQNmiTizEsKr6aHqhujBMapvwl0wu0wREu5K9OZjrqSPrD
	D4I2tb4w==;
Received: from c-73-218-41-214.hsd1.ma.comcast.net ([73.218.41.214]:50684 helo=MSI)
	by webhosting2051.is.cc with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.1)
	(envelope-from <jtrites@tritesengserv.com>)
	id 1qsU4X-001BU8-10;
	Mon, 16 Oct 2023 16:20:18 -0400
Reply-To: <jtrites@tritesengserv.com>
From: <jtrites@tritesengserv.com>
To: <git@vger.kernel.org>
Cc: "John Trites" <jtrites@tritesengserv.com>
Subject: Git does not work on my machine!!!
Date: Mon, 16 Oct 2023 16:20:17 -0400
Message-ID: <002301da006e$2e2d3c50$8a87b4f0$@tritesengserv.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdoAbi11RXAcV1bdRx26ZaalsLhMRw==
Content-Language: en-us
X-From-Rewrite: unmodified, already matched
X-AuthUser: jtrites@tritesengserv.com
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I would appreciate some help resolving this issue!!!

JohnTrites@MSI MINGW64 /c/Users/JohnTrites
$ git config --global user.name "JohnTrites"
error: could not lock config file C:/Users/John
Trites/AppData/Roaming/SPB_16.6/.gitconfig: No such file or directory


