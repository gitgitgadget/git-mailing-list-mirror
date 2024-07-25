Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96B19B3CA
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915072; cv=none; b=ZNr52R5mQSI3SO1S1VD1Q5ckKE0/xqI6JCK6elxTZIS0OwAIE0OXaZ8h5z8tBlPNIpxzcXhY6mtIxlvCj0j0aQuAwaGLlcInKmnWHgTeW4MkutlOrGmizKavg8lN6DI3tFtO8ooHELAuDrMlbInYP6xmiTRcbDwCZfPbFN/TjWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915072; c=relaxed/simple;
	bh=qO0zp2sajpSo7snyeg5+wqxrL7sLpkRojyksEyYz7B4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K1OQve5u1rWpCTHomcZo9cW/pdt8fovm8pLMdSj8vWY+Cj+Ws7TRCJh9jX21bhdsczY7Tne/po+ZE4hlWgkSw3rOuiR47q3Cq97wQsID+V+rkVlxAzMiC0bbH0pusz+o63AAX9Tb6Bo2bFHZR+jR+IylRV3uuHWfpNS9d4Q+EkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BintvxIQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BintvxIQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-427db004e36so7132565e9.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721915069; x=1722519869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b5EsJ/8liA9vP6t8q9qXTgn2RsycUOxh9cPdMz/fToE=;
        b=BintvxIQPYtQ+YV7drcNyglNEACy8CZo4UIkH9I3OeAe2WUl4Q+AY/asrYP+4oGpH7
         2y2k0zm6RB8Y1CRyOX2p1bFRHxgbse0D2mTTbZwVtkTbLnHWXw+TZzhjADw2/4MdbhQY
         mxrsgj4jcFH1XVBvs7iqPkuCpU70KGY9Y+7FHL6i9W1sLeG+XuJIAv+jPcO193zlgHGP
         5eTHEfVUilX0E8IT5YOF7JUvlsKp066l3wWVKlfGhjqHdjYrhAdRsGn6PAdOT9BUzJPV
         BouuqAGlCJ1+zP6dbQX8TdavOe7wD/jbnq7SG1FQKwkg/KY+v5ZaJEOu3DORokHeOewM
         MEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721915069; x=1722519869;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5EsJ/8liA9vP6t8q9qXTgn2RsycUOxh9cPdMz/fToE=;
        b=dl9swh6z8wmo6Vni+rJjgLfIA6LVAHiK5D97CF8KpgasIM6atPMrGEPsIZoynofcos
         j/xodNG1nWfqCKPdi/IZbOHBs02UKcqWwAeX2pUz2MpXPizDi8c+itOKQTOOizDertLK
         oK3HQoGPlokcfpuLaKI3YYN25UfKFu6C0rEH5tUpWzIeRZl7wtrloipKq4UvP8DQ4D9l
         rjMK0RS3dTOGDPc98vAGv6lTH0kg8qO/Bh1znGmeDfORd7itf3l24gjzMt9bUYI2biiN
         WW+hqdc3kdbG6sMUuNAwBC8+HulhcqYomImmjlzfuYUByhIIa+yNSaj042r952edlxap
         AmmA==
X-Gm-Message-State: AOJu0Yz1cWJT4GO5L6NEPGa5URO9nA5i/paA2dLrfsB6P8DCZcRUjjTc
	UAPCkbryDi+HrGBcNLghSSkNjk+oObOHKlMeaylZDYROCoA0AOfJdBkUpA==
X-Google-Smtp-Source: AGHT+IFJqGzR8QTWsjbl6DG+kB4ua0qwFS1tS0b5MxJ+NQFva2UpwG5wVluHzYNiXk9lHc5buwmM+w==
X-Received: by 2002:a05:600c:1c99:b0:426:5cdf:2674 with SMTP id 5b1f17b1804b1-4280546deb8mr18963025e9.4.1721915068734;
        Thu, 25 Jul 2024 06:44:28 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93594b6sm78901695e9.5.2024.07.25.06.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 06:44:28 -0700 (PDT)
Message-ID: <3fcb30a2-8a97-4b34-aa3d-b19ee54dc97e@gmail.com>
Date: Thu, 25 Jul 2024 15:44:27 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/4] pager: do not close fd 2 unnecessarily
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
 <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com>
 <88286ad9-eab7-4461-a407-898737faa6a1@gmail.com>
 <76936fb1-446d-455f-b4e7-6e24dda3c17d@gmail.com>
Content-Language: en-US
In-Reply-To: <76936fb1-446d-455f-b4e7-6e24dda3c17d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We send errors to the pager since 61b80509e3 (sending errors to stdout
under $PAGER, 2008-02-16).

In a8335024c2 (pager: do not dup2 stderr if it is already redirected,
2008-12-15) an exception was introduced to avoid redirecting stderr if
it is not connected to a terminal.

In such exceptional cases, the close(STDERR_FILENO) we're doing in
close_pager_fds, is unnecessary.

Furthermore, in a subsequent commit we're going to introduce changes
that will involve using close_pager_fds multiple times.

With this in mind, controlling when we want to close stderr, become
sensible.

Let's close(STDERR_FILENO) only when necessary, and pave the way for the
upcoming changes.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pager.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/pager.c b/pager.c
index be6f4ee59f..251adfc2ad 100644
--- a/pager.c
+++ b/pager.c
@@ -14,6 +14,7 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static char *pager_program;
+static int close_fd2;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
@@ -23,7 +24,8 @@ static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
 	close(1);
-	close(2);
+	if (close_fd2)
+		close(2);
 }
 
 static void wait_for_pager_atexit(void)
@@ -141,8 +143,10 @@ void setup_pager(void)
 
 	/* original process continues, but writes to the pipe */
 	dup2(pager_process.in, 1);
-	if (isatty(2))
+	if (isatty(2)) {
+		close_fd2 = 1;
 		dup2(pager_process.in, 2);
+	}
 	close(pager_process.in);
 
 	/* this makes sure that the parent terminates after the pager */
-- 
2.46.0.rc0.4.g6f4990c0d4
