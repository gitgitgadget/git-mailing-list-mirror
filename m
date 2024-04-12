Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE29148313
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712942112; cv=none; b=bkRt/XbsZTAtU1koNQRGpuFuII/Oo+yDL1wNdU8CfJHal5r9G8yu+f15GPuNBIEAt1SJ1vo7FvXcXNnFSp790QTrurt2/XnK9HlUwU90Vm4NeHqAEOR6wXEfYoHl6xmQIhMIy2ARSfILMBUKDVHJcbMc/+jped+2dNs5clyWIBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712942112; c=relaxed/simple;
	bh=6yQVcvVpclhj3Xa3ZReE+xsE5PuOvve1Qc3RfwtX4is=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=lNeLNnzkw7X7orl3CoJP8pFyDApRFdRufqk6nUvj1P9Rzge2PmnsxVattY7pUUCBddMZ8l+KeyF7rVvQuFuCipQxW0ZlElpl8tieq95bmdgH/DNhMwEQ87bLaTgdi72bNqhzzjF8u8bFOMfSSMxHOUnqNiHj2mjpQ/xJFU9/HHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4iKRCiD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4iKRCiD"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41550858cabso8395435e9.2
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712942109; x=1713546909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c3OHDOJOIk9LSMabyMXP0jOYJB3HrYwQJTn8HFnZszk=;
        b=h4iKRCiDkrYO9lbm6Odk3mD1NBh04MHGGR34UQT2dXoDtsfZ+ooTYGJDUIaHQ2bG9g
         h9qUJ2qXDuuzHwQHth6bIFP0RXsu8lAqAMynr9LYRZzvuWXNs8RNBV0penWbA5zNEMs3
         AkdOuQwcStEDG1ZZ9IfFE2xWFIyONV45MaC7eaRoB+SD5RJmEON1+OoATziDJy/yLsPx
         gs02wWaJY1JJurx+j38RvI/l4W4IJLtXGh30RJTjxFJ+hFTAWFZTcVIt4SIOTxVCj4ZB
         OGgrmKkWKUXXiODro6vdU8xQcWRU6YClEJVAq8QBFbvdEbaL9YC0G5TlkrFzGdml3iAl
         ty3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712942109; x=1713546909;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3OHDOJOIk9LSMabyMXP0jOYJB3HrYwQJTn8HFnZszk=;
        b=RPrfkc9XsIxaYPMYTeT0kJmYO/MxkVqe05zr8NpAxwFgFbzzkjWbt7SsLi+2DznNUW
         MD4QIBeGQDIY2rppm5hWky7F7jgHWAO6Ta3zZ5rAucjLg+hqDaYOJRsBCs6ZE/f5Zvzz
         gsRtqy6pTCgSXI442obG5uGjZnHkC4Z516IzC/0YBeEkvaqgibokvOe0WkWTiOBix1L6
         xLp1sxj8PEcNYyTRrgJBKyu+dVyAe6H7Cm28J41v1TqCRbt13b36NlzsVKAcp/TdGPpM
         euBg/NjpstzRagk7IOZuYlpUJkUHRUjrGq5yDmV2OFmgWyHDL7dvRu0EPbxLAjZyLdJ3
         BSOw==
X-Gm-Message-State: AOJu0YzBqI0wYHvmUrpQKNHgfXfAGdRxRHgUMc1dg21lVyKpS9DhS8Ey
	EbudwC9zqF3FnFy+4FDLcGeL62Iqq3rBHm9fvimLES1wuXEdl8aV8IIoPg==
X-Google-Smtp-Source: AGHT+IEk04rZOhcC0cUSABqV/n5MXywLBQ2PvG0RAhMYZbYbWlc81zMuddaDp4dWCHjZtlJk/XndTQ==
X-Received: by 2002:a05:600c:4ecd:b0:417:ec11:c445 with SMTP id g13-20020a05600c4ecd00b00417ec11c445mr2159418wmq.13.1712942109000;
        Fri, 12 Apr 2024 10:15:09 -0700 (PDT)
Received: from gmail.com (188.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.188])
        by smtp.gmail.com with ESMTPSA id d8-20020a5d5388000000b0034335f13570sm4679026wrv.116.2024.04.12.10.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 10:15:08 -0700 (PDT)
Message-ID: <c430a194-32ac-403c-a381-801556275f66@gmail.com>
Date: Fri, 12 Apr 2024 19:15:08 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/2] launch_editor: waiting message on error
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
 <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
In-Reply-To: <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When advice.waitingForEditor configuration is not set to false, we show
a hint telling that we are waiting for user's editor to close the file
when we launch an editor and wait for it to return control back to us.
We give the message on an incomplete line, expecting that we can go back
to the line and clear the message when the editor returns successfully.

However, it is possible that the editor exits with an error status, in
which case we show an error message and then return to our caller.  In
such a case, the error message is given where the terminal cursor
happens to be, which is most likely after the "we are waiting for your
editor" message on the same line.

Only clear the line when the editor returned cleanly, and otherwise,
complete the message on the incomplete line with a newline before giving
the error message.

While we're here, make the error message follow our CodingGuideLines.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 editor.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/editor.c b/editor.c
index 1da3a26f5d..eb0cfe4a28 100644
--- a/editor.c
+++ b/editor.c
@@ -104,16 +104,26 @@ static int launch_specified_editor(const char *editor, const char *path,
 		sigchain_pop(SIGQUIT);
 		if (sig == SIGINT || sig == SIGQUIT)
 			raise(sig);
+
+		if (print_waiting_for_editor && !is_terminal_dumb()) {
+			if (!ret)
+				/*
+				 * Erase the entire line to avoid wasting
+				 * the vertical space.
+				 */
+				term_clear_line();
+			else
+				/*
+				 * We don't want term_clear_line() here
+				 * because the editor could have written
+				 * some useful messages to the user.
+				 */
+				fprintf(stderr, "\n");
+		}
+
 		if (ret)
-			return error("There was a problem with the editor '%s'.",
+			return error("there was a problem with the editor '%s'",
 					editor);
-
-		if (print_waiting_for_editor && !is_terminal_dumb())
-			/*
-			 * Erase the entire line to avoid wasting the
-			 * vertical space.
-			 */
-			term_clear_line();
 	}
 
 	if (!buffer)
-- 
2.44.0.771.gbd07cf668b
