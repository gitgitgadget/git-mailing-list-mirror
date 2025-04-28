Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582726FD9F
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855780; cv=none; b=M9SGkyyrgDzEUsbBpGBlKsft0AZolf3cEUkYFGIqk/76Zeuxpi82fGK8JfcVfjt37j9HsbpRrHkrattHjsob2W7EfNXtk25zKDL8V2hKxGPpjkEpeB2HTh3kRwgm1iMh/GgYMbyjXz+zl781Oo1hdzoqdhslYQNDeGl+XACjklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855780; c=relaxed/simple;
	bh=XhFsriqc9dTqtffunim/mbD2oQ3GwtWWMvGLpQxV1gw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GVai3yUBk9waXUHRd3vd8gyFbyiz0vVMNQjLMhq/DoNzCq87ntUAfGccBBQmrfKDvjHWgjSc5n9w/65POWS1nVgTgdmtzUL8/TRTWkpkcGLZ9eu4UuJyi5dBQS4LSMo3AZzmbN3qmbp1Mg8BvwW02gaxU2QMAGyg0fjymj1oc6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHSQctmA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHSQctmA"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso3882050f8f.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745855775; x=1746460575; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5n6ysBHXsGDBhf3ixviCH35XbeTdHqfA2eKFIbbuUE=;
        b=OHSQctmAggAWP2F+Yw8XfOgLVgCIwdOSxmxFcXcgBWTwgNGhhwd4StYW9T3Qu+gaAK
         YRMgYjaEWtz1un9lqmJTFxHFyEIhB0eoj7OXT1o/60kg6KXfHaGJHgA0ONUVwl9AkaG4
         qrLOrLIDKpARxHZAdBuzbp1lmm7lRao2ULEghT4agIcHWewkrci+2dlgej2EgSzKCKbe
         W3IyoxR9Fn9QmK5fArDZEKy0iLfVH//MDee2Af93CXOm/MJz6Jwv2mTlupyqx8LvkoYQ
         1Rs1hw/UlMIZFJdThivs2K/EPcyAp+f2RL0bKVNFTDEn65Uw3QlGETjdaA9RBCj8s5h/
         f5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745855775; x=1746460575;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5n6ysBHXsGDBhf3ixviCH35XbeTdHqfA2eKFIbbuUE=;
        b=CZp5ccyyHZZtN1bJV64LIJ++4BthbpFgpdFCpxFt2ZMbJxC3e5Sq+ZnHXPKEGMsQ3y
         lbuYJtblBVcCaahWUbrfyrux+UeDuWH57eTFX13DzitABBElKWCWBgvZA5IAD3zFCYvC
         X3DE6lxIn2qjSEEQZIVwvGgL2CsK1psLTi8t1XK3IRK29LW+gfOigllMP8esx3IkZSbq
         KoACL9wXyeab0jJCmFXbmAOn++7YPI19fcLqZSoRZFNlRDDydSW6i1zrgZKC3G90gzgC
         L6AvmciySTPJL0Y5m1E1boUcJBjWDCqIgHSRE6X+q2vOSp5Tz9TA6H9rJ0feAlkJjS85
         oEbQ==
X-Gm-Message-State: AOJu0Yx2Na3dI0TTCoWYPU1nFut8SBs8OGkSU60a0tCGu9flf8QLHVjs
	LGWDOVaSiOM/CnekvbeUOt/QVRF6gG6Oeq1hv+79cP/R3+VSwA9ljJpfgQ==
X-Gm-Gg: ASbGncvMXhUK/9uR6dNcSo4RSBLbJ2HR1AsdLWl/LwfZNNWp+jyTN719F44nd2Phwx8
	8vvbxEX2Mo/VbXNc0pJRUncP3bjPV1wo1do2GWzCkJz4IknPgWMeu3NO7htJeQPl7qP8jgYm5aE
	4RGwi0spLufkvpCai+ozGq1SdXH2unxPO65YU/zTsv/hR+5htsnczd/m3rcPc6iYJSNxmeknzPs
	lvbj+R5mvydgTqI1107dIjMZhgaF75jnNxttcEqy81euvO1ywLm7gmkI+3/qLEXCnpbd+jcGb5r
	Ca0wOhIECwSdH1pAjPgo7qtgyKdqdSrw/YYscSYtpw==
X-Google-Smtp-Source: AGHT+IFRfo02ZcuXHlgBeOQUTWFmcpbLfeaexu5B6eb82ChTA7Agf24qk852IVT/NppxRDHjwuzGBQ==
X-Received: by 2002:adf:9c93:0:b0:3a0:7a7c:3a62 with SMTP id ffacd0b85a97d-3a07a7c3a92mr6114120f8f.9.1745855775303;
        Mon, 28 Apr 2025 08:56:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e4641csm11384993f8f.80.2025.04.28.08.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 08:56:14 -0700 (PDT)
Message-Id: <59a6d8831a75f793aae087bbffa9325f09af246a.1745855773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1909.git.1745855773.gitgitgadget@gmail.com>
References: <pull.1909.git.1745855773.gitgitgadget@gmail.com>
From: "Christoph Sommer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Apr 2025 15:56:11 +0000
Subject: [PATCH 1/3] gitk: fix text wrapping preferences for unthemed tk
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

Use a widget factory that works for both plain Tk and themed Tk.

Signed-off-by: Christoph Sommer <sommer@cms-labs.org>
---
 gitk-git/gitk | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index bc9efa18566..8cb17f39d41 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11767,13 +11767,11 @@ proc prefspage_general {notebook} {
     grid x $page.tabstopl $page.tabstop -sticky w
 
     ${NS}::label $page.wrapcommentl -text [mc "Wrap comment text"]
-    ${NS}::combobox $page.wrapcomment -values {none char word} -state readonly \
-        -textvariable wrapcomment
+    makedroplist $page.wrapcomment wrapcomment "none" "char" "word"
     grid x $page.wrapcommentl $page.wrapcomment -sticky w
 
     ${NS}::label $page.wrapdefaultl -text [mc "Wrap other text"]
-    ${NS}::combobox $page.wrapdefault -values {none char word} -state readonly \
-        -textvariable wrapdefault
+    makedroplist $page.wrapdefault wrapdefault "none" "char" "word"
     grid x $page.wrapdefaultl $page.wrapdefault -sticky w
 
     ${NS}::checkbutton $page.ntag -text [mc "Display nearby tags/heads"] \
-- 
gitgitgadget

