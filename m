Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88528C869
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012511; cv=none; b=QoAuJQ7MS3S1Zjaul+Zr1kWVBig/4lbgmNnI91hxYTQniFXqgHUW3mn0Rt6GoVcughfQidMREuMY8hQZl+KDe4NF1PzEmZFERt7XOY3HNG/tKZauB6rtDxcC+grCmMe+wkCUtqjvbdiucLgiOXIwNnLGZwn9HKyOeQhNcqFRTfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012511; c=relaxed/simple;
	bh=+yPHfMO82MOs7OQFl+y4IFlB+qHI2zBALOnOyiZR3EU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=K/zxhl6WahADgaT8XarJILRri7CCinQ4B2/PkfHJ1yLrLlME3fKl4yf74maBMPve0uBvu34sMq+Oqj1gTRwTTMnwBaP4umXLZ935Kp9VSz50RtDaRkPuUoUs/Y7sJfpq3LtK8ByZbSfMaa+wx5PYATsMgA0YwY+Hyu1/ZPeamCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fyn0qOQg; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyn0qOQg"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8954a050c19so15637216d6.3
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 11:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771012509; x=1771617309; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdEcR0dD6hIrNxIDkgrBoIqa9CIiY3LB9DK8nCE6SDE=;
        b=Fyn0qOQgKPC4uc8222lEWV1B0KpC91gej0cHPGfKMl3RKFPXizDYms7XQbqMumppnj
         r3VbX5BQoW3594zx9jG2FR5V4PioRtg6zlraHMJrwId+nU3ZjuC5ebgbJPWeNhBJnhwg
         UiXL1wQmvzIXb7G8T8Ovm/hJmYGLaiJ3gW9a0zEBc38OhzovH+pNOMajnVl1KK8n8mo/
         asQd4NeMOQoIZT+Djfqda1ZhJleIRLeB1cpEMIBoCRYuBoykLuin8SUa04eyCTbdcVEH
         gjiibOpdbD+T2+t9TgMDuHe0ZoNaXo6myzryu/bmZWR6pGMuXU8i2Mj3pak7y/9c+B1A
         Gffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771012509; x=1771617309;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pdEcR0dD6hIrNxIDkgrBoIqa9CIiY3LB9DK8nCE6SDE=;
        b=jTBa6TcFLf7kA8xu4DZ/tZSz1ZKAV7DEwJsUuyZv79bm3xxlHXOXg1ulJNi9jC9gIa
         ZJtL7KvpvpMaqYIM4HRsWGHlwE1zn6kJE3Vsu5fT0n4tS209CZqsVsI0QAyzUeklgT7Q
         q5Gf9sQtn4a+YewazLWxrlnvZXWb9CdfxeoGionhnqtfR5GXiCeBu/HIJqxaVRU2EOcH
         85aR/bstdy+587v65BYiPNg/INlMQF4btD8Flt+8rWx/pPGEWzrCgJVZB93N1cvwJipS
         RQG1sygVBp3rcwqiNJxRzoD3ZO4nZNW2VoUW92FyTHXtdVZkcjYMFFVccwAebnADQIZJ
         HKYA==
X-Gm-Message-State: AOJu0Yx3AJu++z4s3253SLXCIiQ/g3xCkOlpfeIomO26ohvom7ESA9eO
	mVAkoAmbdfDfi6D8mbd4VW/f+MOJXcPEixRMVCrIyQDK8+cwVfzhpcoRYlRiWw==
X-Gm-Gg: AZuq6aLkbz5R0kK+HoFaQ0togqQ8n6DibJ020KJA+XAbtx1Kcy5ddC7jzwC66NFSd33
	KIIbYciJ4snARdGhMrzitDsOigbcp5bbPMdN5/MvE5B7rEay9RU9rQAAVcC7Vjh+kumkgE/lrs4
	7C1wDd24TAN/88Un687B0rUhimFAA8ledBgADc2IoBwIr58dlPjutnjdRx9GFFnq+W2Tb4uSh+1
	UZ8LN5XGLdu5lZ9Nk47iW/WnyO2CPNAXxrVXcjQOxZWqGRjVnBirTu0+MezLJZagrGw9/1YrcBg
	wbx8FAKzi05Gf1/PmnwtdQcShHBOb6ZslJbarCqdUrxFiAjvyvmujIQSydQfh7x3TCX8T0oLHxp
	zkltnNwbeWHvbdjNPWQrek4jUbkKPLXLE2RR5UmmOMqfdPS4+BdLaAd8b3imXjn6UQft1QwKlbP
	TfJbRF72b6NStAngoyaGUwVVBi
X-Received: by 2002:a05:6214:411:b0:88a:4452:750b with SMTP id 6a1803df08f44-89734971460mr55109666d6.60.1771012508972;
        Fri, 13 Feb 2026 11:55:08 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdbf972sm70177506d6.44.2026.02.13.11.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:55:08 -0800 (PST)
Message-Id: <6b9054115eddeb08d0e429f1ec45093691dd84d3.1771012500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
	<pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 19:54:58 +0000
Subject: [PATCH v2 4/6] trace2: emit cmd_ancestry data for Windows
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
Cc: gitster@pobox.com,
    stolee@gmail.com,
    johannes.schindelin@gmx.de,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

From: Matthew John Cheetham <mjcheetham@outlook.com>

Since 2f732bf15e (tr2: log parent process name, 2021-07-21) it is now
now possible to emit a specific process ancestry event in TRACE2. We
should emit the Windows process ancestry data with the correct event
type.

To not break existing consumers of the data_json "windows/ancestry"
event, we continue to emit the ancestry data as a JSON event.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 compat/win32/trace2_win32_process_info.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
index aceea05430..6a6a396078 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -172,6 +172,11 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason)
 		get_is_being_debugged();
 		get_ancestry(&names);
 		if (names.nr) {
+			/*
+			  Emit the ancestry data as a data_json event to
+			  maintain compatibility for consumers of the older
+			  "windows/ancestry" event.
+			 */
 			struct json_writer jw = JSON_WRITER_INIT;
 			jw_array_begin(&jw, 0);
 			for (size_t i = 0; i < names.nr; i++)
@@ -180,6 +185,9 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason)
 			trace2_data_json("process", the_repository,
 					 "windows/ancestry", &jw);
 			jw_release(&jw);
+
+			/* Emit the ancestry data with the new event. */
+			trace2_cmd_ancestry(names.v);
 		}
 
 		strvec_clear(&names);
-- 
gitgitgadget

