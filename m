Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7E130499
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492758; cv=none; b=CuRTEBH1jhPK/2QmqvQxM0p/kGEoAWZyIglIe/gpMHB+uMYo/AKU7tmUtCQOc7sSJ9L6V8WNpaUbuh09g4f2U03rNPq4mBq4czOXb6+X6vtdfjw96sUlCUFlKMZZw8NHO9Yv+9pXrt48MJ/w5NzXdoGuAi77VjMVZiOKMGxvNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492758; c=relaxed/simple;
	bh=L2SLGSyxc33Hc/0I7Flm0/Rnl730igEnZSJlOKX/gTc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ASXszxaRheDjYJ0wkFSAYZ5OIKmkES7ReNzjs5lHi4tCMkMp6K1XepuFN6SOKtPDHSl2uyl54F3jnQJbc+NEWbfP7UyCFGoeoODmeeJFnymAskj4oZseT9yAxui98R+PAcN98E4msawoaW8lBwqjJVPPhg0FLc7eHfPPLhEquwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EW1jhBwZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EW1jhBwZ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-382610c7116so3107418f8f.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 19:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734492754; x=1735097554; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oIfrlelErYppMRM8nsEsX9AtCou3AVa9kM9Vlq6zTxY=;
        b=EW1jhBwZBE7rv0gQVTPevZy5vdQuYxlmd8PqXTszl/9ZNMMsqgXW/8VVQh5Xdo+oZc
         Md+GE2cgoLYC8cV93HHJL4/n7Sg+pbxKu2CCBfQ7GzEhb4cqTj4ULmfitujME4n4IWYd
         M3vzLOfoNj/CUTV1eiYDfU8QK5pGRzX/0sRfR0Uc9+VEhxYocZXrTf12uUYM0zTWXt+2
         U9IFhJYRUSihzRMUQ0rM8gry8FPZox+7xO2/ER0u6GVKgxUATsJzGaKIOHOmM0KCsmvO
         avGs/7WgN0ws9dMNzVcwoUUyCFJtagLRFfannNbdIQsyHOyJbG3/33GS2Up+rqRkGHD/
         lp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734492754; x=1735097554;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIfrlelErYppMRM8nsEsX9AtCou3AVa9kM9Vlq6zTxY=;
        b=rAe3HV008lo8I5irRmrSs2NBG2i7tAu5BRZr0S26hHBBi0hWr2mB+imhvm+kwi0LlF
         RUdNHK5WVqJ7zgmPEZwxuoQ61W/vJaywszXyz0PFq/idLMh9sLkpxwmyIDpgh5inDo0J
         Rxd33pL4d6jR5E81PBsQjETI9OOv2Q7yqGFBM1CFQ0RmJDEUOmMeMja8ImfvDbE64wPy
         EEjT/7tUEHcc9q0oGtraFHxIuAIWwW8RI55obYKh7TzNNvznI8+LPh3TJUbcgKzH7P7f
         tUclhTPdP2tnhRrJtFoQy85ZDy0J7RkThaz6h0KSc8K8O3+OpxsOVzR+Wmqv1EmDCln7
         Gpaw==
X-Gm-Message-State: AOJu0YxATp6IclQP7VbQBRTypJb67SXNzQqOACKoBM8G+z/oBEnQ4BUl
	YUpEp5E8k4rw4kXksiQs5CY5wkbfBvWli2M4wuVDRmOacpq8XLuRui1xLw==
X-Gm-Gg: ASbGncsM5EZlZOAjeZoAa3MZpn08goJpQZ1vxWf0yDC6+fw8QjGfqvYefRWaYsUUsQu
	XV3ibTYZkFlQSxv6s7x9ez3LzbJjTt3kYHuYRA1lG6dDeaSgZ8ZKiI0DaQkXLnz02fvI4kyJxR5
	eTnAFJfJYvDvw434mHqE/9ujR5fcKiPuQEZtXWrGO0inBgvhV4J+xpaWHresLipv89MfpOwxNOP
	RwV/D9/tuVOINGmwJ4xSu6xeuCagHWzEv0BrNAz7L8c/GTN677+Q1MOog==
X-Google-Smtp-Source: AGHT+IGZtIg4kiP/szNgdN0BgHq447cEEhsIqVA0r1cuHzf1ysxZt+xsHdYdHPvjtSK5xwwtC9NbHA==
X-Received: by 2002:a05:6000:4b1c:b0:385:f4db:e33b with SMTP id ffacd0b85a97d-388e4d42923mr1018330f8f.21.1734492753804;
        Tue, 17 Dec 2024 19:32:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c806cbd8sm12595836f8f.109.2024.12.17.19.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:32:33 -0800 (PST)
Message-Id: <pull.1398.git.git.1734492752951.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 03:32:32 +0000
Subject: [PATCH] bundle-url: always close child_out before leaving the
 function
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
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

Otherwise, child_out may always be left open

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    bundle-url: always close child_out before leaving the function
    
    Otherwise, child_out may always be left open

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1398%2FAreaZR%2Fbug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1398/AreaZR/bug-v1
Pull-Request: https://github.com/git/git/pull/1398

 bundle-uri.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index cdf9e4f9e1d..23dfc1999b5 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -337,10 +337,10 @@ static int download_https_uri_to_file(const char *file, const char *uri)
 cleanup:
 	if (child_in)
 		fclose(child_in);
-	if (finish_command(&cp))
-		return 1;
 	if (child_out)
 		fclose(child_out);
+	if (finish_command(&cp))
+		return 1;
 	return result;
 }
 

base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
-- 
gitgitgadget
