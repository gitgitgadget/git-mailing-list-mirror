Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254573C09F3
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958177; cv=none; b=VW7H+/4qtaDqbCBmDT9wnC74JYBKcWEcB65DgPAM3KJBhQ47v0lGKyQ62RRJ7wuUi3jQsh3cnp6GXlg4BYSmrWCc4MVf1psHLAKOfr7VzSPMSrA0SPpYLwGYkn9W2AaLWO3cGwohCeCz8xpMdbvYZqbaxoYuNzuwoVANgutQbZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958177; c=relaxed/simple;
	bh=4w9H36caIe4h2JLhXPhTODlyYKGAP/zRRLqDnN8ahjQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nAU4XvYQKHZaA4zX9N2aW7vQIlLC5VFql6rQNfFAYeTOWAg1xeEy0dfERvoHtkgxVq4QEljwW1WVbGsJAOyGiJC4iQkuBjaTgFuvdNRRiGCkSv3S8q+VecWtwxmYw/Fro2jGykfb3xnqFxDU4+7jUgNISWsafUEfrXZLTktojVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvCQpaJf; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvCQpaJf"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91b52ba422cso42299776d6.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 23:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791958175; x=1792562975; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qAvJ5grP30AbSfEdZCtUcAfr1EYbGfMSU8/ycn0unQI=;
        b=RvCQpaJfpBYRhhcdRDyYzz61CSa8OJMrp0/XVS8nXj+PSsnghaZBbLMnGV/2H5cJDV
         xbAS5MFfE+/6NBECMvmIIpg8f2G07VFGo7f+hHgJYW/J5/nwY6a2ZS72HHq0NQmIW7gf
         R9BdnsFlILuqz5ASWB/6HP6ZzY0R4U5RBIGvUVU3Gr4MCKhmWaZtfGEw1sTNP8MzQpeP
         5lxKAGyJNkmNsvlBBati0wbhmSVxr6D84VR+1YdX18CTErpw6/0XXUV8J+qrWdeCwOGT
         Khlks7wlHQ2mh2YIoC88QQkTJDJOval7r/emzymVyFYLx05ThVJMSuR/O/AVq0Hb7AMj
         3kFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791958175; x=1792562975;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qAvJ5grP30AbSfEdZCtUcAfr1EYbGfMSU8/ycn0unQI=;
        b=Q7U6Y6TBKoKMwMInvfJFy7iIG2T9wv/xJMYihLuwFY5eKW2KIGAHbRHIuiaX0LU4CA
         S+RdDtBtoDq7s7G2VQts5lw3BReM5XUYi/pfNGq/2vAjOPlnM9GsyXY4zifX/60RhOS1
         ifI8+PbuOj1233gBqO5GlTUHMbReTn5ob6m32cvpLqyCvwAWy46sCCg3db33Ni57CXTS
         EDAX72WpSdPc+dhSpYRr6o++v13YyXpbmD++31SQ//OofBoVhrS0X33tJ9VaWFwR3NQ7
         xX0pU0yUT+nxNy5ERSuc9W3qZ2FY8m99Zcx8yr1eTtfsJNU8EkxFSy3a5pk8IiUG31+D
         M7BA==
X-Gm-Message-State: AFq9FYKhTz6moaE0JqFrPDQWpNkW8ibl3aCBNWRB2KTWfIt5kHBN73ui
	2ZAxbtA3Rh9oanS8PoaUynk59PqhvD18QgJp0KG/B62Rnho+iTdT5/qFoPTeRw==
X-Gm-Gg: AYBFou09KSf8LWSDtU9rAT9HIpnKFpy4ppYV9q/HaRpHagJ21+Y5akmc6YrLTBuFmUh
	9RA7C7ri3lyq8FdvVMr53CCNz6UmRcOEL2r3KIXMWjpDatQd2y+pcY5wFKlwUn95dQGpFZYYg34
	FUfeslAgxWDGeo7ciVr1jyuqbP+OBdH1KS/ez4VgwwXA3joCzvDEu/OYhSncw2lmnu4UuiuW4Aq
	SOQZ/PUujW5pwUXkRxwDgD0q+wmU04cdt5w48Tak6nThFSVN9oW7kdyPOFfZf8bzyk6vCDv1FUO
	sIPqRdV5wTvr7p4auMSmlr5Tv7fD2OUNkIcJ2WqeQ8LklP7BIMq5FUtvPjmzJ5CqP88FrDJZI5K
	BL3eCHyB9/vrF6pHmrjRGeqDPrQaDeI9EGWF/LqN3kq7FKwC29sGfteFWqPwBRz2+D8ZxnDaBDk
	Id9Fc3f+QDxEOM03Ha7WwUip/al1V2mERJHnv86o+qFh0Ihu1/UPr/rlxP8yvBjIQTN0vfSa5dB
	C6jWKxkLYY=
X-Received: by 2002:a05:622a:2483:b0:51c:1590:8e13 with SMTP id d75a77b69052e-5359f4892a6mr250491831cf.4.1791958175092;
        Tue, 13 Oct 2026 23:09:35 -0700 (PDT)
Received: from [127.0.0.1] ([9.234.149.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b6fbdcasm118051261cf.5.2026.10.13.23.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:09:33 -0700 (PDT)
Message-Id: <70a909de18e8cd8d282439fb51a9399baa8c7be8.1791958171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 06:09:28 +0000
Subject: [PATCH 2/5] http: use `size_t` for byte position in fwrite_sha1_file
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

The `fwrite_sha1_file()` function tracks the number of bytes written via
an `int` variable, but the total size to write is of type `size_t`. When
the HTTP response body exceeds INT_MAX (~2GB), this causes an overflow
and a heap under-read, then writes that data to the local object file.

The hash check afterward would reject the corrupt object (so no bad data
enters the object store), but the under-read itself could leak adjacent
heap contents to the temporary file. In practice this is unlikely
because curl delivers data in small chunks (typically 16KB per callback
invocation), so in practice, the total size is far below INT_MAX in a
single call. However, the function interface accepts arbitrary sizes,
and the accumulation across the loop means that the `int` variable grows
across calls within a single invocation, not across callbacks.

Change the type from `int` to `size_t` to match the type of the total
size. This is a hardening fix: the attack surface (a malicious HTTP
server triggering a >2GB single-callback delivery) is theoretical under
normal curl configurations, but the type mismatch is a genuine defect.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 4af3c29c76..809471f436 100644
--- a/http.c
+++ b/http.c
@@ -2848,7 +2848,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 {
 	unsigned char expn[4096];
 	size_t size = eltsize * nmemb;
-	int posn = 0;
+	size_t posn = 0;
 	struct http_object_request *freq = data;
 	struct active_request_slot *slot = freq->slot;
 
-- 
gitgitgadget

