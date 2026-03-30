Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3963BB48
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894059; cv=none; b=galHfCsSlT0TKypR+gUYvkE8i4iMXJobeqW61D3su76KTFhM4aaEuZbbbhwKhC+TEz11636QN6SlRCA9CtwLQ41/sByMGKB/mL26dQd+UM+uIYIMP5qQDsEQtJXGFtqbNpRNjEytuxKZTQ/MUoll3F7lDDlCNZCJhLOUFcx7m7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894059; c=relaxed/simple;
	bh=iEB+88CgrsfPZZ0zFjf+x77nsrVRtgVwmMu3qlfGmHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9jg+YsvBYuvv1gauzYf+8viYm5+Z+nksbGIt4h/OYBDpsCu3WyZVtfgHw6YLcf4838m02JwHNQGgZC2MTI5I9qZxzDsz81K1MvTDKcoDRqXht5ARmCUzADVFEqj3Fw+4NzTzAg4Wb8Ux85ReMWR8S5INgxo0SS2FONUXjcIASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sithyd.siu.edu.in; spf=pass smtp.mailfrom=sithyd.siu.edu.in; dkim=pass (1024-bit key) header.d=sithyd.siu.edu.in header.i=@sithyd.siu.edu.in header.b=KQQtoM9m; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sithyd.siu.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sithyd.siu.edu.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sithyd.siu.edu.in header.i=@sithyd.siu.edu.in header.b="KQQtoM9m"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad9f316d68so21289745ad.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sithyd.siu.edu.in; s=google; t=1774894057; x=1775498857; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XCcbIWFUnOOTL2Lbw7WePYEzqGXCNLLJfzPznIazkUo=;
        b=KQQtoM9mPdBJhjhhCcJsHVWtC1Rk3KCLULrBH0zXJVaKh025F93emODr9undF2RyG8
         04P+KpjFTT1xEcrHAtLRCw9djrIqKrRDwj2nRp4HwCdM53QGRFxccfDcuDEsMNFiUji+
         0XrAqThIYzKxXQOz/bdMkQCpnlLAHPVOC1Jxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894057; x=1775498857;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCcbIWFUnOOTL2Lbw7WePYEzqGXCNLLJfzPznIazkUo=;
        b=YyXZzqPcnKoWlvu8fC/viGl49rRl5YY6cLQtP7NeamPaWGnsvX72y4VTCrG7QjeVZ7
         auAP/5vLKFk7TS7NXszO/g7EMNQ6lhfo5K4wtskVr6kMsr0IVa75ha2yAoKsBfUCS+p9
         jgnnCCse7rEKE1nzGkzhzjxdtpwJwyEKR6r30WgftH02Op1LRB+xTJ10nF89r9Tz2f9V
         dWTC9JZA2jjhlBLLOUUGbCV+9BlyPsyRJ0j2Rm0eht/exOKj4a0VK7tmjbLLNgO93jN0
         V2HpCC5BPvg2CpfPWMOKPgebabXEZa4/rBtg9jZkNH8NN44xwOLyvmGZvr/SiRFxLzN8
         aHQQ==
X-Gm-Message-State: AOJu0Yxc6FZbpFExRs6N3nn6y9ot0U4kRZeZLrkxclL7PnJPiu3XzSmK
	t8f5aBORgPLTMeTZbMsTSOEUGSTZ2mx5Hb2PmsdgoTsvlCf10WSiLt+4r1pPwONwZuz9cX6YkoI
	64NNZVIBxl07YqT3khUEypBMzpwUiQ6Y3s2UrkmTkkk6L9GOZlSvdnSTnM3A=
X-Gm-Gg: ATEYQzztlAvdXAYY3MkmB4snKAibVRZsKwA5rJ9vDs6S07zDUCwitZRpOhJsXMkiIhe
	Y3kYHENwwCS/dbtDqRqidx+Nrh++UaS24KTpToF6XYCc5Zxqaq6frrbzPNn8xOr6rBW2C8izTbA
	oP6iQhBl2CMGmSNc8ZoESu2Y4PkKr5UOHTAuZAzpP4QJ6YwRmcuhiVCUKrYesnJGFbFJKLEoIa6
	QBMqPUcwdrck7RiK/KcBaAACTF2dV34C81J6pj0VcD7ECUfFgv0jQlcU1n/fTenFFNMQWHxzuL9
	fOzxpGlNk0EETsXyZ0uC9brgXn/gJuebaPcd+8fD3hAKGfKAJBqZGBq35Yo1yfUlhitZOWTFO3G
	azB0QypXSg9Fgnd68UJUA1R0O6zQxnQ3GYZw78nc38BNGepXK6B0M8hjQh+5iph6Co+hEi9do+b
	GPR3kfci11aiBK8wK5UjQzRAIEK+MTXk5EAd9IgHNQL+EO+JfXdWHh6Qg=
X-Received: by 2002:a17:902:ce12:b0:2b0:60db:7927 with SMTP id d9443c01a7336-2b0cdcdbb73mr153551885ad.28.1774894057098;
        Mon, 30 Mar 2026 11:07:37 -0700 (PDT)
Received: from LAPTOP-A2K1CSVQ.localdomain ([103.157.13.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24277e8d3sm85979815ad.55.2026.03.30.11.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:07:36 -0700 (PDT)
From: Smaran Jaianand <24070721037@sithyd.siu.edu.in>
To: git@vger.kernel.org
Cc: smaran-jaianand <24070721037@sithyd.siu.edu.in>
Subject: [GSoC PATCH v3] bugreport: revert incorrect usage message change
Date: Mon, 30 Mar 2026 17:41:08 +0000
Message-ID: <20260330174131.456-3-24070721037@sithyd.siu.edu.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330064454.76833-1-24070721037@sithyd.siu.edu.in>
References: <20260330064454.76833-1-24070721037@sithyd.siu.edu.in>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

From: smaran-jaianand <24070721037@sithyd.siu.edu.in>

The usage string is intended to reflect command syntax rather than
describe functionality. Revert the previous change to keep it consistent
with documentation.

Signed-off-by: Smaran Jaianand <24070721037@sithyd.siu.edu.in>
---
v3: Revert previous change after feedback that usage strings should reflect command syntax rather than description.

 builtin/bugreport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index f78c3f2aed..6b1d1accb1 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -56,7 +56,8 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [(-o | --output-directory) <path>]\n"
+	N_("git bugreport - create a bug report with diagnostic information\n"
+           "              [(-o | --output-directory) <path>]\n"
 	   "              [(-s | --suffix) <format> | --no-suffix]\n"
 	   "              [--diagnose[=<mode>]]"),
 	NULL
-- 
2.43.0


-- 
* <https://www.facebook.com/symbiosis.official/>*  
<https://www.instagram.com/symbiosis.official/>  
<https://www.linkedin.com/school/symbiosis-international-university/>  
<https://x.com/symbiosistweets> 
 




**Disclaimer:* This email is 
governed by the Disclaimer Terms of SIU, which may be viewed at 
http://siu.edu.in/disclaimer.php <http://siu.edu.in/disclaimer.php>*


