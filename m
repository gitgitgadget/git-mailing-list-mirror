Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B4C29A9F2
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314720; cv=none; b=c+HRbElM2YPMpgOT4bAhyEkOxseBIr8hWP/e4qLAxhA56VEApRwAIXpLJyhkfnTNE8cYYApB/POHHo+16BOsXRtcBXkjMp3BN9o0CDpWMQDEmAx9bQD7eO/gQgabCMdVC2lVpqQQbwNK+sNMs08sPCvQt+AUkXhhBBYTaUnC6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314720; c=relaxed/simple;
	bh=QS9CdYlcVTVzI7nLR1owP4QL6fBSM9xo7fCYEPSXD3Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ELfHo4+Hj7voG7oBrSXUpx9kXvc9XUeTDXKXCTsEC42vMmV2uN6oy/wX4o42Lr1b+5SgVkPam9lVTEmWkFEpv7wwhvfl27xAQ9cPitSh728RZ1QjaCtan4rTjic0vwRb+n1OezNpYQKxxddNqVXpx7ETwmgZQH9hnLNS8o0EhAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4xYT99w; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4xYT99w"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so7371235e9.1
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314717; x=1747919517; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T41tEkPHKrPkD9qNHAdZutVmn15/R1XyCSxhoGzpg8=;
        b=G4xYT99wy1Y3iCYJdvYatcbYuJyDLwYK/FD8tN5wuH2FgT4g8Kt0zn76koiWC4Vv2C
         W2sAhP+fgTUDoJFGZgMCytBVB3wPPU13RBUxL6uo0Nmhxjr3MbxaeZNfI2HVlncldpO1
         rRaeUbrjIvDphOBpL5P3kw0YeFN+3jBfaWRWnbk1Dw4hj/+QDe7KkEjL++EqLZr++1wy
         TnUq2AmpSf2l1fhWM/YnPxG2LhB/aOm7jLAlYzJh+v4JJ0QQahnCpJSWbvQoE+Vknno4
         wd3OIBjf0VNdFAnOsXM71edW2wk6HCUHu1brDSQDlx6hyWmNywoD48sMGE3Dt1RnbYCI
         7x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314717; x=1747919517;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T41tEkPHKrPkD9qNHAdZutVmn15/R1XyCSxhoGzpg8=;
        b=lwvmUEJCJJfyUDu/uNBwTusUZdkPPAd/mGeULGrB/+Y8kZmuj2fkcyc+tkvi4G3MIg
         tVYby+GNhk0AeA3hFVeHAjTvD0Zz1EAHTMFxIBPuRsijidwXxrrtyIAR5LvcL0n7sMpT
         FBoG+NRlZUW2y7Nf1I1y3ICdg2lLztwz0jc6ULwD64SgsZOKx8o873MDyrkwDj4ezUNU
         Ah9BtExFZIfYixrYc3bb0MrErL28LytEskLV7OiaG6bOdN9mxrmThHH2oX6sjr6uisAs
         oUaXNIRAfxgLagjL/yMC3g3uwah674K/xe7VNQWD5ozrNnFrjsCBd6B+0IBAubDd+A/v
         +I5Q==
X-Gm-Message-State: AOJu0YyLVSxpXW9Q8P4uG/HfWZEywRbQdhnn8uPUshKGdKQyD+Wl3dJx
	b6DDvEAx+tjuSWwVgEZMtqd6UMMQKffMxVFQbzcuWPlSOTjpYBHc2ejdvg==
X-Gm-Gg: ASbGncurnbLXfAVwtdkZFEwLwTCY0DKfIxQpn0Kzt1nY/LKbfNTQOb6d15Jkl8RsL0n
	IxPMedTG3fHPQdpaiQWWwr57n+47f1cvkq/sPRaMkA2EZNkrg7OMW3nLrlAva4mAu03GY3waGFV
	2tAwGnHv/TkHzKvC9kXDW7K0ZR7nsXEi/xPY5JpVSH/XwTIZXEQtkFsCGmuW7d8aTT+GUE1YLtw
	6juB/OlAv3fkDAt9EHTiswFr9a895JaNX5av7hxjlCj2ZnfNU3Cg/ZKZqAZlsvndIcVw3fnkSPR
	HjQSQOla+MpumHqIEVSOlsdGOdooi+VS3VIS090nZe1pSG6Ha6z6
X-Google-Smtp-Source: AGHT+IGoz4ndfJF/k0I8Vwy4b6xcaCv4V4yuE5xgVW7rcafl+LvB3JU5WhsIJ/r9YoUipRD1Tfy+HA==
X-Received: by 2002:a05:600c:64c8:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-442f217ab9amr67776945e9.33.1747314716759;
        Thu, 15 May 2025 06:11:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3952929sm72530475e9.24.2025.05.15.06.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:11:56 -0700 (PDT)
Message-Id: <dff0a3ec886cdccf199bdc3881094ec0ab8b3bca.1747314709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 13:11:44 +0000
Subject: [PATCH 06/11] fetch: avoid unnecessary work when there is no current
 branch
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

As pointed out by CodeQL, `branch_get()` may return `NULL`, in which
case `branch_has_merge_config()` would return early, but we can even
avoid enumerating the refs prefixes in that case, saving even more CPU
cycles.

Technically, we should enclose these two statements in an `if (branch)
{...}` block, but the indentation is already quite deep, therefore I
refrained from doing that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c1a1434c7096..40a0e8d24434 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1728,7 +1728,7 @@ static int do_fetch(struct transport *transport,
 			if (transport->remote->follow_remote_head != FOLLOW_REMOTE_NEVER)
 				do_set_head = 1;
 		}
-		if (branch_has_merge_config(branch) &&
+		if (branch && branch_has_merge_config(branch) &&
 		    !strcmp(branch->remote_name, transport->remote->name)) {
 			int i;
 			for (i = 0; i < branch->merge_nr; i++) {
-- 
gitgitgadget

