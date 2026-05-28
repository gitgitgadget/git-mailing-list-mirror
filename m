Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B130648C
	for <git@vger.kernel.org>; Thu, 28 May 2026 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937022; cv=none; b=kuH2A7mhvtU9vk3Yz9RrhoYBCQfdr+tB6F74V4rOUW2ybU3L5I3YBk1XXtF17DD546sAlREYcCMNkcPgUvDX3vd5y8X8lbmPloO9FCOL6qckZdp51HKuPvn4SmEe0MkFAfnAfx2+rjW8xWZK7whgZCE3DzwRcrKjmbim9+q5P28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937022; c=relaxed/simple;
	bh=ibo5E6hS6Z8RzS6e/C98f64QZg4vj/RQmA68t2CjalI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SYvbN/fTkHskQdDMe3GcSiCbXrsZRKxEsBatboYUvhPXP1rN4xmD4AoEs2nBRyKfg4ZobMHB+ZRRwugYKOEsDcg5jgDdA+K2j0lxTfdJB4u6/jsPBjlMMduA/8mKs6OkPbQD/8Ev/veBTyZBYKDBFzN/NckKfnWYzrU06LNIc6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW6rlQH1; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW6rlQH1"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so221733786d6.2
        for <git@vger.kernel.org>; Wed, 27 May 2026 19:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779937019; x=1780541819; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCanl2UTdnJmm5I1wrST2Zf4CXnElEoaku2wr4IvBUQ=;
        b=dW6rlQH17JTDTTKl4R8jKWnpTBJRB22mmzxQYWxQWONOroAc0cQNwnfi02eKjoDh4n
         A01QXZbCTJWbqfT/NQEglBju7tkR8gda68uFttSO3zOswecGGphY1vbcYjjcgmH+emRq
         xYMBwz1ogJBddw0Ij+u2c1x6yxqe+iPgbZDgVuB+ZCm0s/5sX6nJbe3o0Cu0FDSW+h5f
         AVwKpndEuskLHAJGvwyeGV4jvS9x5ARcm/Y+6FTHamTeVMTijEp2cqqnlyTl61FYs9FT
         /6Mkp17AFj0HbnujCs/RkhP9N1w5UTXu/BrwbFvlp22bJ3lhcIj9GHs3Zfajalcfz/OB
         goeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779937019; x=1780541819;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gCanl2UTdnJmm5I1wrST2Zf4CXnElEoaku2wr4IvBUQ=;
        b=PWl9yLHxaprTXit6I9KSaRKguoikxctkSlI5sEBy6YaaHEBGtNG2p55LVVxT35H0AY
         z/kTVI58XtSDTBZ1qAg7EbwZZcD6zVZJLk8oLph7qkb6WceqU0t/bCM29x88zv2i97jn
         be43N2Mk4vOrqClJePiD95WhQ12598vGTnXw1id/iLG7mOWnph/gHPyVS/HBxAfUb10z
         wgMLvx66D1CDupp3jzW+mrnkQLMJuscvYh5BvfQ+3/BWuiby70YgVv9mL7b1sPQ0wjXv
         F27G9P/gEUG6hxupDXlfVnaW5olDrp8/UpK6B6nwpoPMf3q0FvfEhjMRhbP3j0gFOEJ4
         FAew==
X-Gm-Message-State: AOJu0YwLDiZlYhTaSCE7vSNmZ3hk15TXDsSZ+aLgAagQUfnhvytzvW7v
	JED/QiIW/LK3ta0l8+G7dz2TuuoxzqXYj0KoOYeiAVAh2O+F0ticblectcjU2g==
X-Gm-Gg: Acq92OGJXPQmmcC7rUto+5o2ZCGp7ZtgfcSjdimoVnoUqQQQFG7YbeFgT3qS1ZSRNlu
	eUr/IPXpaZ5kWzyYdkRrhu0ZC6B3S3WEIc19yl60RP/kzTtA+z2e5TioQK9jZJphDI9LqU/WlEZ
	X/riM2BsqKvJJ6kUTh5dJghUvTbb7jeX3YrP18ufh0iRUeSmdJ4+ZA/Mf7N9w83KGXVM+5vto7K
	Z4WixomwdcvdYmLP/AH/OWXNS6oS/wB+OCgdu1Lw6FzDG0pTt4qToET8/ESUKu2S921UhwfRqvD
	14gwkg8WaWqqNyyfNS7ivrbJVl5/CL0+D+UjvL/WfBOPY09Wfi1gl0AMNlI/QE64gxrTBeWb6gq
	1xEJ/XTQngSPUBnobTbWBOVP7dRNIyV8//kkgM86qo4smC44UlIcIfLiS+d8Oo9wUEqEUPXr+xM
	NSPlecVFFCdtj/PifPX+VcR9cZXVyY0fjFkZU+
X-Received: by 2002:a05:6214:242c:b0:8cc:3546:260b with SMTP id 6a1803df08f44-8cc7b620d46mr417843216d6.14.1779937019229;
        Wed, 27 May 2026 19:56:59 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcf895sm207441306d6.1.2026.05.27.19.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 19:56:57 -0700 (PDT)
Message-Id: <b2d81438117a716417a031c74b678a8f91701af4.1779937016.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2300.v3.git.git.1779937016.gitgitgadget@gmail.com>
References: <pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
	<pull.2300.v3.git.git.1779937016.gitgitgadget@gmail.com>
From: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 02:56:54 +0000
Subject: [PATCH v3 1/3] daemon: fix IPv6 address corruption in
 lookup_hostname()
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Sebastien Tardif <sebtardif@ncf.ca>,
    Sebastien Tardif <sebtardif@ncf.ca>

From: Sebastien Tardif <sebtardif@ncf.ca>

getaddrinfo() is called with AF_UNSPEC hints, so it may return IPv6
results. However, the code unconditionally casts ai_addr to
sockaddr_in and passes AF_INET to inet_ntop(). On IPv6-only hosts,
this reads from the wrong struct offset, producing garbage IP
addresses.

Fix this by checking ai_family and extracting the address pointer
into a local variable before calling inet_ntop() once with the
correct family. Die on unexpected address families.

Signed-off-by: Sebastien Tardif <sebtardif@ncf.ca>
---
 daemon.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 0a7b1aae44..80fa0226d8 100644
--- a/daemon.c
+++ b/daemon.c
@@ -674,9 +674,20 @@ static void lookup_hostname(struct hostinfo *hi)
 
 		gai = getaddrinfo(hi->hostname.buf, NULL, &hints, &ai);
 		if (!gai) {
-			struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
+			void *addr;
+
+			if (ai->ai_family == AF_INET) {
+				struct sockaddr_in *sa = (void *)ai->ai_addr;
+				addr = &sa->sin_addr;
+			} else if (ai->ai_family == AF_INET6) {
+				struct sockaddr_in6 *sa6 = (void *)ai->ai_addr;
+				addr = &sa6->sin6_addr;
+			} else {
+				die("unexpected address family: %d",
+				    ai->ai_family);
+			}
 
-			inet_ntop(AF_INET, &sin_addr->sin_addr,
+			inet_ntop(ai->ai_family, addr,
 				  addrbuf, sizeof(addrbuf));
 			strbuf_addstr(&hi->ip_address, addrbuf);
 
-- 
gitgitgadget

