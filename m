Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A906F2EE5FD
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770679049; cv=none; b=e6QU/+ki84XNGzd6xtnG7xQjiVmMv1q/Hh8WQPfKylGjYtvn2njjOdQbTeSe7lzM5RWA6LESe2Wxvmgt+j+FYdFTvigTcuSQUgtychCFRFIRDbGDKWhKLDcJdoShdadJ2G0qi4uQmu8uGle+pHHZyPUQ0uJ0t0AMMgymoFvETyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770679049; c=relaxed/simple;
	bh=a+DN5fjqdWdSpm8Hk6suuHjSu2I/3LDlt7AnTfJeDjU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qbaYctjLx6VrO0KhmEvyMdzAkwTw9AyPBg3hsU7IA7JhuwetBb2C9cZVwGNr8XYUCBGzmhFyqonnp6DpkkEyudGbin5n1+TsnsRWLmuuSrYiEe+w04iHXKVpU/upCGS0GgMrf1npCRzTFEAnpw2IAyfcxJkEgamMqBxFELIdlws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdGL5Fdz; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdGL5Fdz"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-896fd2c5337so2110106d6.2
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 15:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770679047; x=1771283847; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+7SwK5kjJYLIQsCYDnJ2opui+vfOv3dX8tL8lw4Z4U=;
        b=AdGL5FdzAvAQnzdcXdUOxEZ78EysQHmP5hIzHv2Ux6sdkPG6nQfDzJ8lrwVpm2y+4A
         1eeOvFbUXLZy1oR4XndgVixb/paxH4oax51ego0bnRaf/eEWk1rUraijlQp3LWwkKVqg
         LWYbE8J9vLgkj1rldXRqnYgA3gyNedNRCCdjRU1EMOc3lUgPG5dJ5qlWbDGpJ1BvhqSb
         z7rPTWI/B5+GK+jSPkcf6h4bzhm7IxxDw+s+doOtkyO7eYuVSmBTaUhlNOXaWzfEfnEr
         D+UgQ59xF4Y4VXGVE8n1GR+jA3KtQCbwaXY1owj8miIOU98wG6VjY5qFsB2Yyh9KPPLz
         H1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770679047; x=1771283847;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+7SwK5kjJYLIQsCYDnJ2opui+vfOv3dX8tL8lw4Z4U=;
        b=Np9rxf4Yv67uDj2sjTzVNbibtLXcM1KN0sMYQK53VFcyQgU3O0Lvld9RnN0wCOiqC/
         WaP230tAqR3YVbC/F8CdXH0vlhTredB4rLWqiM2/A5mh6gWavwjbmTDQAusxEbhlFIkB
         XcN5ObkoOmPqEtUmIJllxQgsec5iXAYTZnRqMMKh0aoVLTRMcHldxIceGmWZABddIl5g
         xJ0h4mlkfvMExguIQAIYXa6IHP/FsdXb9FezIEcGLHdfBeoX6BPD/oMadwdLGKJoswRR
         gmGT1doFBvihfi7CfVHOU5PxS/g59WWoI25x6OFQfoyPRnvnO+y0VdO9HRI/C50Jns2v
         skSw==
X-Gm-Message-State: AOJu0YxTN6Fd6dZpH9TveCQy8w3yWnGf846FiY5Xd52r9FS0eB3bvUtY
	7eKTskFEHXcFW9McPjgUWLMdFudi5/CriITD4Jx0xE4olc3Ggm+ajGL7ATHGfw==
X-Gm-Gg: AZuq6aL7a/D8wk+XjfhVsm3aG4z7kOuZBb4kSbQys3yRk2tHjUaq58s+eDLPqTV0U9P
	Cx6JtnPWoWdD19xkI0fPWYrUTCTLF4K96kl4XSzbw6b88LG7JjC+WuU82vfWrWklOxvXVpgknZW
	UbOl6BZxl5Nnra7EOigkuy6QckR+ZeD1gsr2Ze2MeSOxRZ+cbmzi9hyjaf7jnv7XfYgGq4XMAht
	9PMCgfDxhs6aDr4VSC6sefl2qM54W79h8c1zLqHNV8Udy8sT5ph0N/u+Pva3vmwNNC/heyY5MM6
	W6EA+2nSC4C/X0dKeWRHU59Eu2/c+b+jXUg5BCPyMSkwL/B1AxcXUKOOS+i5VvauZK6wQjy9Pz/
	Rccau7g0EGpG88bLPpvvOk1x878lmeZTwvgUNTPBICw/ChmW4vTqlFzVUQ/DuC6ZqQpLyVx3gnC
	CmK4lzTOT/YutqC2JkMtWLnZ7x
X-Received: by 2002:a05:6214:c66:b0:896:f8b2:5f16 with SMTP id 6a1803df08f44-896f8b261b2mr86430336d6.4.1770679047310;
        Mon, 09 Feb 2026 15:17:27 -0800 (PST)
Received: from [127.0.0.1] ([64.236.200.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-896fb9ad27fsm39193146d6.4.2026.02.09.15.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 15:17:26 -0800 (PST)
Message-Id: <8d5f2ed15bcdfa32df69d92d87e7aac2ee17d447.1770679038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
From: "Rito Rhymes via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Feb 2026 23:17:18 +0000
Subject: [PATCH 5/5] gitweb: let page header grow on mobile for long wrapped
 project names
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
Cc: Rito <rito@ritovision.com>,
    Rito Rhymes <rito@ritovision.com>

From: Rito Rhymes <rito@ritovision.com>

On mobile, long project names in the page header can wrap to multiple lines,
but the fixed 25px header height does not grow with wrapped content.

Switch the header from fixed height to min-height so it expands as needed
while keeping the same baseline height for single-line titles.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 gitweb/static/gitweb.css | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 8247646063..e2e6dd96a2 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -42,7 +42,7 @@ a.list img.avatar {
 }
 
 div.page_header {
-	height: 25px;
+	min-height: 25px;
 	padding: 8px;
 	font-size: 150%;
 	font-weight: bold;
-- 
gitgitgadget
