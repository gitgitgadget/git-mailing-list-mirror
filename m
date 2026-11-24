Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560538;
	b=2xGw7bv4c3JHhaUfXJXTi0xS1SywLTyylsEnnMzA73P5Yd5eWfB3OJP0U01fQlT2li8S
	 uH7Yi1zbyOfk/M7Qv6OuJ+/jzDdh6O3Bc5WLlWciJvrVq6RzPrl5s3/sHP5rq1h0zi8Ji
	 t78eRShvZDqV4Ev2+HN+8QY0txvMgqIrQTxBv8qX2i9Ype/BkXJ4A/XeaZp7f+Fz2pGUF
	 a6NPayc0qT1J3kLK14iuiBIcmW7iPS2lH/Q8EbyEVyxAv3MMXfB9sY6BF/NpSj+vWmeqi
	 Hc7G7UWhtdqDEj0ch8YPZEoLEV1R3324IVGXNnNNKXcxMmTdfLQRxn0gLzeInKUzp3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=d9fzAJ8owgVMQOy5Qa2fGXTT/Bo+S/rTUY351FhjaFM=;
	b=y6lv3WrBR7HuYGA+QHSJw1wodrfV4eC+b2e5CCa6nxvucePVpCvgOZFbqb1eyo4OKW4Z
	 I8BYQQbz9A1yf+kIVG9+Az9S5FIhxyD8W8HloxtjD54mQEJ3EIHbu+76EcDTI1fm555lL
	 HTO2PXOZt6eWnUJDjQAHuSAQ2nYJL2Qlr/a2F5lL72H/lplkfi+lUMfekZ3ASH9cRwKEt
	 5YErO7X7HlmvZqu5zLDioHHVK/PS5Kvrz5kbunm+XeMYXvnM7PQd2y69J9+K5B92JRi13
	 60Jd1ZdMEIcXFGxp2Nyx6/s/d2yEOEjH5yeLxudwFsRy87ONx7/rZwl3m+/GWe6SFYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mjAfJYV3;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B80E606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B80E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mjAfJYV3
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f22a8515eso444539885a.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 14:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795560536; x=1796165336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d9fzAJ8owgVMQOy5Qa2fGXTT/Bo+S/rTUY351FhjaFM=;
        b=mjAfJYV32dU1xTSSLnfrrwGq5YoJkixpg0R8ufIn0ow+ZKyDMQQkUhL7mcC3ss2ggZ
         8qof75iZ1cREIHQehl8BAtY0SGnk3Gi4ChSHPXf1n6pRs/LGFN9oyXkYzJLPD92ZSvT7
         gnhX2Ase+otmlQ7ti2ZgbZ2u69Dd6eGwkxnewCuN4sqgtU45+PuVjlWbfLH13x9KZNwb
         kgZCwbi+v4M1HcwFMrU6vX4TK++7yTvf9vkba6r3U0/3HqkcnYqWGW7ZTKnzQoR4XFt+
         P4FDS+T8B3ZUfHWBlG2aRBn93MxBMQouqjUXi+bMlw1d79D6qtLAGM+99hkWdWgU2WAK
         Li7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560536; x=1796165336;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d9fzAJ8owgVMQOy5Qa2fGXTT/Bo+S/rTUY351FhjaFM=;
        b=xJO4fv/k//DtOtqmhxSHdvET4kzW9080eyJ/nIG1f1pAjwEJYlVDDqMb3CmQsTicF8
         cRBpfDHHKbZpVPO794Og2QbAWTZQFh7Jc3kGl90PWZCfUqaBAmlACSyE2IpVNJgaDmhm
         36P0mMhj0igvn4+/jJYeH4YTquiIYucYC2/vXMiENKDLA5060x7nwPanUmItTCYTticQ
         ezKoYAw7/3eValQFNbDBCrKfCjL4ahh8/iI8Er6pbEPisG6zj/WQUm2VbO6rHuWToN5A
         YfzuqJR+Bgqkhg+uOH4v0zJQ3NJ/bjYj8JrbDoFMeGSdOg2oxRKKZ4Cs51nVlpOZkRBs
         hZNQ==
X-Gm-Message-State: APuU4Z+8zpyhojctTwsBjJMS/5zjFHrNPNawitbdk1u6yOg82YrbxIx1
	DJ8D6y/cpzRhlWNyZoaxleGf7ajgsnxPvPVpsSR7Retdb4tKXBzL0vhpl+gmaQ==
X-Gm-Gg: AZFdTZd90Wjvly2pCNy46dHR7ELs6CF0YYC8dJwFJ4GPrw591F1jbz/WD+vCzM4yNQD
	buBMZzdvrckijD8cGxb6DBYF0RhD7xt4po8bTVC6FCBN83GkrZRsP1D0+VcfsMGzMeN/6p5ODZt
	XlblB0Aqv6h9m1ExWolTUGZyzKNOvtFzq9H40PtJcuiq9El7tR5VZjehJbTRHoGyYVkSAFlbFrj
	aeacEvA14+HR9TsPEN/TMnr0+wocurDciD1lvrCYyQl5iKhhBtNlf0GG+YXAScoKPx1Ie7rA5g5
	5ZQ6M5nRRv3+V6GeVXw/KSeOeWu8uE0HvvM+eS4y9pDqKdIfegX7zcc2Chp9nqeAPqLl54loG7m
	5mwJu5NkiQ/OoALoGnYBU0qhxIuNhjeVlixOVeEoc8t9pZNNvOfRdtIKQno3soI48DoEh9Hi9JB
	rhgD72xZwHRHaN8iDZpOS2fx/kqkd5CJx+S9ncj4UVyTlEX0H0a35kLa4qp8SOE2a93HYMMCJZa
	CEGh78TaK/Hhm5idDg7wQ++iy0XCkX6gDCf6rG5dmkBlQI4eh9MndRNDfq0xbmKlvdgpHdDvrpo
	sLvB5Er5dzPG9VAexf+V8vcEP2CfaPS7HLs2CDHx1e/1tCJvJCNsDHU=
X-Received: by 2002:a05:620a:1b81:b0:949:6a66:66dd with SMTP id af79cd13be357-949ba96e873mr3096434685a.21.1795560535831;
        Tue, 24 Nov 2026 14:48:55 -0800 (PST)
Received: from [127.0.0.1] ([172.190.109.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb0319fcsm1147573185a.4.2026.11.24.14.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 14:48:55 -0800 (PST)
Message-Id: <pull.2508.git.git.1795560535063.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 22:48:55 +0000
Subject: [PATCH] imap-send: make the header loop easier to read
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The loop that looks for the From, Date and Subject headers of a
message stops at the first empty line, which can end in LF or CRLF.
The check for LF also moves to the next line, and the check for CRLF
depends on that, which is easy to miss.

Check for both kinds of empty line in the same way, before moving to
the next line. The behavior does not change.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    imap-send: make the header loop easier to read
    
    Make the loop that finds the end of the message headers easier to read,
    as suggested in review of the series that is now in master:
    
    https://lore.kernel.org/git/avq0R5zx0PgSN-Oa@pks.im

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2508%2FHaraldNordgren%2Fimap-send-header-loop-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2508/HaraldNordgren/imap-send-header-loop-v1
Pull-Request: https://github.com/git/git/pull/2508

 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 1b5850a80e..c2d6b7c55a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1462,7 +1462,9 @@ static bool has_required_headers(const char *line)
 	bool from = false, date = false, subject = false;
 
 	while ((line = strchr(line, '\n')) &&
-	       *++line != '\n' && !starts_with(line, "\r\n")) {
+	       !starts_with(line, "\n\n") &&
+	       !starts_with(line, "\n\r\n")) {
+		line++;
 		if (istarts_with(line, "From: "))
 			from = true;
 		else if (istarts_with(line, "Date: "))

base-commit: 77904e546de3bd940621092ecec47a88d0cede5d
-- 
gitgitgadget
