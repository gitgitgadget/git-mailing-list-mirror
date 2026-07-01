Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A63B47E1
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889490; cv=none; b=MvIlhmRmDqH6WTWwpCsUYehHEkdwtqS5llKJ6FYiA+TG8hlvVNS3k3n+OeyrGOXfuQKtL4irYEgasu0grO97/7WHDJLrlxVrInVtTXB8O8h16VyuV8I0xBe6TaihBpTBs8q0nIRq/CyAkYQisXlKhtppGNsP63EhO2omackED50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889490; c=relaxed/simple;
	bh=x/gLVcmgsAVWyrXPPQ3h6kZvLGddO8RnE3Xd//4dBBg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hvgn/V7kulma36WPthTvzgI7vx2ybvX4V+lqOCwUJThhsTw8MqHKj16X91VL1Y30UZt4BOykZmDTUkUzdgFcj5zt5h17x6k6Uk5a9MNrn8zo8bikH7N8DKApC5sOSUcGNpjuYVmdv92xVBexlNv5U5A7JaWwfq56GbX965it8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLSF7uxB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLSF7uxB"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8efbafa1bacso2099726d6.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889488; x=1783494288; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghUhyDzB7GkqXesEJmOdd+Zl+wYHro0CYeXz0EMqLy0=;
        b=gLSF7uxBh4vzM5x5R3vRl98Zj+ChB0GyCNzWg0HFcUdZ4BRoz0qPPKnpjn3xPbXtQE
         2OvcRUSZPUGjcxnADeNjM+6qvNEcW6tIXXTwBTmUEbM9Brp2HNGgc+Sn8KUkwPxXOLpI
         IoYtGv7hL5WbdAnwjS76t+l3RiJNYa0Rtu40mcu0tZFKwYu3yzdC9uzeqflNx7Rnx+F0
         T3ORPE/AcuAieW/g+kITTKqzn9HQ0H9hFKcpThoDYn3YAccHgdEyiif7ApUVaIikMIzt
         wjvTdB1ZSvYUe1ZZaw1qu2k+g0vrfjgb97FzYudv21tsU7oslGN5vDzEzCE3xE71fyDJ
         31OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889488; x=1783494288;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ghUhyDzB7GkqXesEJmOdd+Zl+wYHro0CYeXz0EMqLy0=;
        b=c6NTcfAbv9Z8feSlhVbdoSIi9c4+cLMKB6fKV7T0rB2RU3xaC6rWRmMtBlBogZA4Ol
         XEGSl3qKYnr8ku1K+T8Yuf8S6IOps5VyklX337NA0QggguyRGJftdi2mveV46ymbjCVp
         M87l/t+eI74bG2K34v51iAs1UeZ4PdGckg4X5F75QEYSk/9lP43OJpQaWUTgPVm6++DQ
         7Eqi/7tBWbWmIIofQdUdHJ8Kxxa74pROPHLLrmwkq/Fu03VKvvyB99XBk66Fr7KUkZAU
         JGaK0jC/C98IwM+xxt5BoRRFSmoK1bPM0nRjdglTAWvyFNHjk/iCP2ppa0HNaUFs0smN
         fhzw==
X-Gm-Message-State: AOJu0YxXzFg8oZV7bVsyEaoTxNkMJQUGnHKC2W2775Nh8QQ0TjHw1CtE
	f1KQovTMliuBteV240lJT+wkMN3NyilSsbb/W18o/I8T3DcRh9H0MIHW0fWr1A==
X-Gm-Gg: AfdE7cliSPySFpaou1XSXPCUuZY0g+aJIo1qcz1+O/gYGaVc/p0H8lbKulCwOyG2z35
	eCOJ+bNYBHQBK8doQDWrzg/IRAopU61VOBsFNJwltvCScR7SRIifDmwB8/42VtpKEmWdTCmcQ55
	HZl+l8ZvBwoE9camIes4LXGMFlLsGNL0LBUvG9vVDi8LMyjeLhKAzp5CG4RPOKCJUjGaC6n0fQS
	uiOohNwtFTTfFIg6b1bZQOKjjyn1PmYX44rEPtw9Xi4xqLUC6pd+fOAqcflQlb7tCzTLWnFVqxI
	sUDz9qEH38p6MlxABjdaHpwPqMCi0bA5yxZod7Izgw/hhqleGNiBWp3O0PjnoyoRI0h+3xUeAHN
	EAhm0fbysYy8dgv10Qg2NVBxS7fIrTkAq//ZifqtqJww26VvwrrvjXX9mdwuQU9VwGlC096/T6f
	mGf/gdtvsLvxow3k9S
X-Received: by 2002:a05:6214:3482:b0:8ec:235c:7a66 with SMTP id 6a1803df08f44-8f3c8a20853mr3966036d6.27.1782889488069;
        Wed, 01 Jul 2026 00:04:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f394ae2206sm9279276d6.41.2026.07.01.00.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:47 -0700 (PDT)
Message-Id: <cc19a300f5c4735fe91718d4a3ddf414f11eed23.1782889472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:28 +0000
Subject: [PATCH 10/13] imap-send: avoid leaking the IMAP upload buffer
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

When uploading messages via libcurl, curl_append_msgs_to_imap()
accumulates each one in a strbuf that grows across loop iterations
but is never released before the function returns.

Release it alongside the existing libcurl cleanup.

Reported by Coverity as CID 1671507 ("Resource leak").

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 imap-send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/imap-send.c b/imap-send.c
index cfd6a5120c..0d16d02029 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1750,6 +1750,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
 	curl_easy_cleanup(curl);
 	curl_global_cleanup();
+	strbuf_release(&msgbuf.buf);
 
 	if (cred.username) {
 		if (res == CURLE_OK)
-- 
gitgitgadget

