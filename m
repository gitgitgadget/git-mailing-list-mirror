Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB0138484
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841622; cv=none; b=g5bw51qOUrQK8+07M6eatQZVBoW1lXkS38m5hSwv4XXnOxwagw+YmVivFsH8Q+HrzG6FtQaESWK0WIJCJxx9Bf0jSuyavRUB8Je5h71qsqN40QmmjZ7AgYbVtXA/NrZ61zpIHE5TIWgOOhT+hvGLkdPfV49tZKRkiC7vlrQM94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841622; c=relaxed/simple;
	bh=BcZNKx1Y5GsB302yMqh5pZfqdAvKP6vd/HLEOuDoMw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAIKE3Vc/m+ZuM1z+IK2pc8nQeEIn838R2ywtRPQ6gi6HxYZzAEg+lH3gBbQ7yX3XQyq+inNEKIbXBPZVMsJ4FClHlZkS61Hwqk/T3C3wZ59v6Yh4jfONeXJKYJgLbcDAzMq+JHjk1QAn4GmbvXGdq/RiojZoWWY8ZzZ10KeBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=YD3q6lAY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WpjkOLaD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="YD3q6lAY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WpjkOLaD"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0CD251380114;
	Thu,  7 Mar 2024 15:00:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 07 Mar 2024 15:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709841619; x=1709928019; bh=gcwrHNk4q8xm1qgVnUUJe9drgX4iZOAV
	2m5Wxx5cNiw=; b=YD3q6lAYwC1Nrvg4MvIvTIxmxnVt5AesMnVE9tCbp9BzB4lI
	jC3Xmk8ZDr11+1bL9jyIIbP8inMbnowJg5sAtexujOvEwZpZi8W15/ru53dCC0SU
	Y+Jjd3k6KC+q6kHjpBPHIxqjrToMpmBD+satG2cE9YcIcWaYTVr/E+nabc1QCNrG
	o7ixRIlYznLP78wTMSEi2A6jd5STzh8YBxyW4DL79v4ktgkdhYMsZDloE1ZcrUnL
	2NwS/9iPVnv8xJxxEs48cRc2cwP+WO2hHjgqbH0hqMjmP7/uFjUhrEnSvFJEGeRf
	AaV4fujDsuN9iPNh0Hn+gt07neerFV3ctsQr7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709841619; x=
	1709928019; bh=gcwrHNk4q8xm1qgVnUUJe9drgX4iZOAV2m5Wxx5cNiw=; b=W
	pjkOLaDNajkVDal4BGdOjcxD7eWiuYJXDhk14bWYscDQ8rCBpi/cgZrY32mBabXt
	Z7M8wM+v3VA9/k0XHPpP+t43FxaXd0fflxhJ1NIAr2lU5R+j/MN+d9rTZ6d875KI
	4Va4dX0Xx+h7l20iY2K+AqoGjQ3PDPtxm1X3WUXop4CvhaRA6A8zhaeXiL2zYNcQ
	yIEoioFqdPHHahlkAX7TM0XrbAtkTLKKDxzW/HRaCq1khTnLf3owjSgGhx8+XI85
	7bYD/IOpUPUWOZS17B7ZfNZ4R9ADZ39vLwlANWbdV8JGXFPUj7q3ecRqPIVauWYm
	wkLKl2GqDuSBXjbl8C0aw==
X-ME-Sender: <xms:0hzqZbfKsKO4dp7E_3Y9-sqSIZiYCEpswGlk5lzDdzMqN-4kiMLiJu0>
    <xme:0hzqZRPWEGOS4i5hp_RnjvbKJKhXokUoKV-_nmItP03QujLirEG1gw986pz2lHdej
    5MoM4imcs3P7LpsQw>
X-ME-Received: <xmr:0hzqZUiQZBmaQfdatih3XXX2EX0WONQ0lRNykBBTv84pwEuUwj-rBxWLsrU40UK6M4zsKci_zwjk3bT7Lny4bEO3CA7vwozpp8kwwBELLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:0hzqZc-KteD60glycxNZFFrD9fuia5-jYYTZkzI0VGl84KhxjHVCFA>
    <xmx:0hzqZXvYGX0_z2dbXtsIqRHWYc-6AIHX-T1i7lrAPe3aDCGBawSVXg>
    <xmx:0hzqZbFKyjiNL7OXXfScFMXqYUtkM56enS5YJbz8n4y33gsGg_bg3g>
    <xmx:0xzqZQ5aW5mhoIp2ENQALIkMbrAsGOy2Uy9cOJcuhELQoG-g6wcFbQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 15:00:18 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/3] log-tree: take ownership of pointer
Date: Thu,  7 Mar 2024 20:59:35 +0100
Message-ID: <3b12a8cf393b6d8f0877fd7d87173c565d7d5a90.1709841147.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709841147.git.code@khaugsbakk.name>
References: <cover.1709841147.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 3b12a8cf393b6d8f0877fd7d87173c565d7d5a90
Content-Transfer-Encoding: 8bit

The MIME header handling started using string buffers in
d50b69b868d (log_write_email_headers: use strbufs, 2018-05-18). The
subject buffer is given to `extra_headers` without that variable taking
ownership; the commit “punts on that ownership” (in general, not just
for this buffer).

In an upcoming commit we will first assign `extra_headers` to the owned
pointer from another `strbuf`. In turn we need this variable to always
contain an owned pointer so that we can free it in the calling
function.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 log-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index 337b9334cdb..2eabd19962b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -519,7 +519,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 extra_headers ? extra_headers : "",
 			 mime_boundary_leader, opt->mime_boundary,
 			 mime_boundary_leader, opt->mime_boundary);
-		extra_headers = subject_buffer.buf;
+		extra_headers = strbuf_detach(&subject_buffer, NULL);
 
 		if (opt->numbered_files)
 			strbuf_addf(&filename, "%d", opt->nr);
-- 
2.44.0.169.gd259cac85a8

