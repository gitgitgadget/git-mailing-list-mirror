Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C82797B1
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855782; cv=none; b=atsJ/0/IXfGQ+eYmJV9UxIXSleaDlZ85ObSmuXvyU37qZc1c/Hf2rLxCrBEiUDHfr9dv6wddre47A0HUApP5+VgycYw3eFHCAGc2X+sTaU5fJMUM+aBFGAAxM6QAw+AL4L6ZgcTk5Eqbuykji05dl8HhtqyBY1YJwV9KZeEXrWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855782; c=relaxed/simple;
	bh=XH17vX7KKk/jgRKBI/hnHjn46mpb9uEufTU4pEWs4oU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EKNBrnQKU1/hjJv5th5dZlNaVk1iDwTvNfGVTBanNDdQKhBgkFPORy8wmyDtywHNtpZ0OERpm8PLI8LJnpuGXtaO1Ch8oxDhwYMz9/ZijA7PQV320mNYZMtM3fPrLBwwYnMFGjt4WSnaskXtgyFpUCPHCzeAaRtW66EeRtEJ/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR7TlQjK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR7TlQjK"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso35731465e9.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745855776; x=1746460576; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25EYEqfkSMU9yZMikfmO3ALZ3AYuzPoYAusjfi8Bugo=;
        b=bR7TlQjKSNO6zYrW31zUDGFof+A8Xnk6AJ96tcxvBilTbWjx6/dNOZXwZ5+w6/EPNJ
         WD2DUaKfPNpai79iNq+OfbZN7mWiaMPEr7RPYXdpmHWzj0BlSbOKcDfEi+7nCadrcCRt
         j7bSC80u7jm7uM9+NOqO4KYtANvkgxjALl6nLN7EFM696+vXlDDBSEF/qo8O0v1mZlaP
         ncA1gS8O1orycZ8rauKfdj7ZNbHReqoCG5wwVh/zgPn5MNWkqyZ7GXxUOmb2Fp2nEoNi
         a2cjburfkE1Ay3aOBdVnRKLt3es1oJLR9RYuANipMR+lWnNfdx8mqligOjlcrMcqnJMF
         J2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745855776; x=1746460576;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25EYEqfkSMU9yZMikfmO3ALZ3AYuzPoYAusjfi8Bugo=;
        b=aL8vlz6iCUzYvoBHtNbHKbVZIOraF/TRfaQpO6UsJxruOf04hhNjDmlNQmLfaTXn9i
         PS4v9dHJMdgbi/vqyQteAKe0QQ/VswDTonKb1Y1vxYUyahGPDsVy2AUgdcL1LUVlmgYV
         +x/i/jJM4/wOZp9lQEASs+yGO6khI1xyi1diKfK+9cIM1GVqtstqNI3yXUX1OqHlE25u
         5B1b6vAC9CIAPWCaZqVWw2wwayNRTcU/DhZC5deET070dyzbJOHPuAOytaPWQcF7tM3Z
         N7aAWMZS4xH/QnjnxAaZ2k8kBMxsb1ohG2cxsNIozjujEz+IT1MS39aYfItc6dC/DM/x
         VcAg==
X-Gm-Message-State: AOJu0Yy04t5AWr+SC59e1lZ3Db3NWcZt+OY8JyY/qjRnFJvcICU0I3eD
	EyBsddq1MUsUmNv+uOTGsv9MnW9qp6xSCLFMZddnwi+tSEU/qjzD3amHgg==
X-Gm-Gg: ASbGncv6UMWS9qNBFWBgnHYNiGkQH5Cd5X8FXOAoEoXiOCcAJlJkjmki1su4o5XxDCR
	vD6JvNjsUoxJ8QnRy5iM+gV/t+Gzb6sjWm4p4woe0uTqOKiyK/lhlvUd3VThhAbFQEV4C7tM4te
	pnkLRDkz2GbZiz9i9/4uktubCyFj34/IUW4stdJdxudBpWtB+CSaj1rG5VTthODnpNDG3DXMlhF
	XoZnkh59+TdPWw5XasPeKPSEowlnAOmB5EWgAp/kR+eueMFE5oVyNt6McEHRzYpp9IyW80iUjo9
	OfH6EHX76gjbRmKT4dVDeqlI8iyZgq1UMVzSFIrMaFnDJ5lX+a9E
X-Google-Smtp-Source: AGHT+IGValz7DxmTlbSUd9RwKQR1pP+Xc+yabhx3nrB3cdQkDdm5igMuHZVvlwCxHgyOWMuCnkrPOA==
X-Received: by 2002:a05:600c:1d20:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-440ab7b279fmr84812005e9.14.1745855776347;
        Mon, 28 Apr 2025 08:56:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e46869sm11532195f8f.72.2025.04.28.08.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 08:56:15 -0700 (PDT)
Message-Id: <abe92305dcca8ebece332454004b6611ce2efd5a.1745855773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1909.git.1745855773.gitgitgadget@gmail.com>
References: <pull.1909.git.1745855773.gitgitgadget@gmail.com>
From: "Christoph Sommer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Apr 2025 15:56:12 +0000
Subject: [PATCH 2/3] gitk: do not set fg/bg color scheme for themed Tk
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Christoph Sommer <sommer@cms-labs.org>,
    Christoph Sommer <sommer@cms-labs.org>

From: Christoph Sommer <sommer@cms-labs.org>

Ignore the uicolor preference not just for win32, but also whenever
themed Tk is used. On themed Tk it was frequently only changing the
background of only a few select widgets rather than everything -
and the default uicolor was frequently not the background color that
themed Tk used for its widgets, resulting in a messy looking UI
(mostly light gray, with random widgets surrounded by darker gray borders)

Signed-off-by: Christoph Sommer <sommer@cms-labs.org>
---
 gitk-git/gitk | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 8cb17f39d41..da7507af360 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11991,6 +11991,12 @@ proc setselbg {c} {
 # radiobuttons look bad.  This chooses white for selectColor if the
 # background color is light, or black if it is dark.
 proc setui {c} {
+    global use_ttk
+
+    if {$use_ttk} {
+        return
+    }
+
     if {[tk windowingsystem] eq "win32"} { return }
     set bg [winfo rgb . $c]
     set selc black
-- 
gitgitgadget

