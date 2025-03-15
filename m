Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2713AD22
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742056315; cv=none; b=YPjzp4F3JTndTCkpRyYZpae6VTenhj4U8wOtp5YbIzkE3w4g5l2CFQ2e7Vr6TyPWuC2b16ngnRx9MpwfGvO9fiAoK0g3BtvyiW6UFn3yefWE63W0uxwkNoJ9+2Wd1Fcb+kfrZJv+/PwQqgduAX3Dwa7VgNXfWWbY6dkhl0iXb38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742056315; c=relaxed/simple;
	bh=H6AmoztAfWowIbD4DTNSIbAov9bD4kbTSOrsUwr1J5k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=I5yxd26urlNWGFrX1ts6Qywkg/BMD3VNN/TLhbgY0YSkIUCGJoNABKMJvFPWCkUkeqDBL4vEC7yc1HWytEiS+1lvVJ4CnotBhjTScHuTS/wK7daSxv3xs6TumGZKOGjOfuSImS2PIOOW1xaSX/yW/Intx2WnAsQAajZadO2r8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbmrIDFQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbmrIDFQ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso4774855e9.1
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742056312; x=1742661112; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZFFnBtskaD3ofn/3S9IOKiBGkXIF+Jfw7BGiGLTVVg=;
        b=hbmrIDFQZHJymEyWOJ398GTww5yL4mYqJP6RUm82Oz7e+xVMjmEK0wmnP7JE+MUprl
         OIsVE2jZNkrbDTvvB8ceeyStjz21QyEDVFoWenrCFq8OMeKnAzEZpti9lpW8R3Blj90L
         WXFiY9ftJwbWJqsJ8GLjDbOJTPklzKMLFazr7yrOMajviaN+LRutMCk8iNN9vY7mwbhc
         vU77Drym/ObLWzgr5mMYC/bvtdkvwGd6YCaIb028dBqipoRX1ZU9U0qcWBOt9UL9d2J8
         iJMKHirFCLLxj79hom8ZdQtSiLFG9zdgnsuGwrdDElvDlqLWzZ1kYZHwNoiZZ1mi32Lm
         vuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742056312; x=1742661112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZFFnBtskaD3ofn/3S9IOKiBGkXIF+Jfw7BGiGLTVVg=;
        b=K5XBFkPjt3sGzTacLt6r3+WsOHE7xI4Lm12BmslrH8hictvfqAD5SJGf5NdbXAs/BG
         rJKFkGOAXvqes0eH/A3ViJXJ2guWoGEgA/5DLWXn1wjLxpMWlqXaohw0d+Brcv7Wfqvm
         Zi7RHBz5754jxsQkMo26SYJfLl3kVPVecwOehbwJkGQpfFyyIR59dA3L32YdDu6k3M/e
         LDmJnflowPHzJ1OLTxX1AW4oBdVxYkXtlltd7sOlnsnS4kCXc639ljssvXsgVrXq2sgT
         0jiJufcpCD0WvwPU4F9vq+sancjID0pAAemuSHEdN65mJlCSV2WIbgkq7uW4zK484kvp
         z91A==
X-Gm-Message-State: AOJu0YyU0I53+NVJ1nMFAFt+2X1E3CwDXk07nQRsXqrchY334ABijS/m
	iE+Mpper/ztkluY2tF6PTFYz1r5jHP/yjZeMSYb9NyCVqJTTVMjOKH+Hwg==
X-Gm-Gg: ASbGncvqU12UDZFtnOS/682nO7gjGoQquhkQTOn1dRH/9sZnpT/Z8GyFndir34YVrVt
	jxLdyawBtvnkb8k0gUr5XuwcNZqEueycc36j7yjpNzPe1H8GSxR7Bs9PtyIOoE4Q9xWbo1gq7le
	q12BSTI+NnBu3aoN+84DcTKgqPAtVy+dfmIMeD4Gk1gGiowWurzzcX33t4bWM3aocOXyRbj7N+6
	A8Ke3GMy8jViTAolschVNdMepaQ728Jng2KahtfexJW7UdKkhrLPuF8KGc06J8YFOIq67bNSR6j
	+qLU7VNJFx5wyEYnOHNYRLH9LteLHJMVam6TcSxIt1CsBg==
X-Google-Smtp-Source: AGHT+IFUeyBduZWVId1nxJADKp32BzZpkb8akLoFFsMW5zR9q9Jd+kgapxC3z3eXtmaPwPR2PwxVBw==
X-Received: by 2002:a05:600c:4fd3:b0:43d:8ea:8d80 with SMTP id 5b1f17b1804b1-43d1ec9071amr89818915e9.5.1742056312211;
        Sat, 15 Mar 2025 09:31:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df33aasm9344530f8f.2.2025.03.15.09.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 09:31:51 -0700 (PDT)
Message-Id: <f8883d83f3096ce16e5dfc9647a41970396693f4.1742056310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1880.git.1742056310.gitgitgadget@gmail.com>
References: <pull.1880.git.1742056310.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 15 Mar 2025 16:31:49 +0000
Subject: [PATCH 1/2] completion: take into account the formatting backticks
 for options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

With the modern formatting of the manpages, the options and commands are now
backticked in their definition lists. This patch updates the generation of
the completion list to take into account this new format.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 generate-configlist.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/generate-configlist.sh b/generate-configlist.sh
index dffdaada8b5..802178daad4 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -13,8 +13,8 @@ print_config_list () {
 	cat <<EOF
 static const char *config_name_list[] = {
 EOF
-	grep -h '^[a-zA-Z].*\..*::$' "$SOURCE_DIR"/Documentation/*config.adoc "$SOURCE_DIR"/Documentation/config/*.adoc |
-	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
+	grep -h '^`\?[a-zA-Z].*\..*`\?::$' "$SOURCE_DIR"/Documentation/*config.adoc "$SOURCE_DIR"/Documentation/config/*.adoc |
+	sed '/deprecated/d; s/::$//; s/`//g; s/,  */\n/g' |
 	sort |
 	sed 's/^.*$/	"&",/'
 	cat <<EOF
-- 
gitgitgadget

