Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7433AE71C
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521824; cv=none; b=ZQfmqpiP6/gEx6HxRGF+Tn1G4kLch3ONNAvDmXU/55hhhcOl42T5423Z7986T497reA6p1TNSXvoWFrpHus3pwywoBvvSorC5pLGsKCA2fM6gzCY0+xSQuOPWd93Mkwm7z6I8lLNgltQUPPuXWQTAMrjYltICb7WRGOqQn+BOgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521824; c=relaxed/simple;
	bh=jb1+5zh525lJx2yTH4w9R1S975YJtAmBtoDENblHSJY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n51JZjlM6ASpURvC7DH0jP+v4yoqFugeF4MKKMQeZUh5clKZEdrTZPSDqE2muu525FF9ASWgbG+bAuTnjE5tFeQRXFiY+Yvero7qox+CVHAQihOgPmQgbbE8zwalWrFXK+bed7aOZAqKPdMsob5swoFkqZiZ2r6pdYPwKOPjlUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/NYsf7h; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/NYsf7h"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so774876b3a.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521822; x=1787126622; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fRccCIDR+jTMBT4usvw0ZbAZlpjVniL2pBi2VJhyIow=;
        b=P/NYsf7hYupoIqxInl6DmQ2vL5+pvewc/uUoL28PPsXKQJVwiIzTJsVVoHVSfYp/0g
         lR4L5HOmsx8usx1NHGFWxQ3yos95KIx0J7nJ/BoQ1V+yAwC5XVqB80/Uem2pf093Tm/C
         t/yZKtZYvqvpxwELtYuDhi/4dS8ojlkJpbBnJ47Hb+9ehkoZqv2vgn5jaUhyq/Dd23ri
         jtImKoN4uoKiWOPJn8mMNDZAUJwlrvLFKvQT7GE7DU+Jgy6cdRcMWgx10A1AGcODLz56
         SgwT0wx3fZLssNvXwQhAdcQocDp7PmguVE6p6V6QUax38O1YWWMRcnXe02zhozVSgufW
         v4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521822; x=1787126622;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fRccCIDR+jTMBT4usvw0ZbAZlpjVniL2pBi2VJhyIow=;
        b=q7aUL/Bm30bAKmVDnw8ZnziWRH8JjmDy7vSmuB8Ypfhd/6wAQS/u6b7XcgRaUeV3o7
         q79TUB6ne8SRz0oymhHqglVFBsvL2TqVQueDe7qyFKkhs2AY+3F8g92FDVadu4/sUe68
         QplifOvQWf+Udi2SHXfMP+/tN5WpEeg4FJzr07sGUcsvlDGHxPrumLYUn1HAU9k9h3cf
         wMO77SQ0jrysPN7YCyP6dDRfSHEdLEUr5LCUigi5QH5BaofvEbTrojcl7Y+m7XqmMvxy
         vzN0u0PbV/u+FHM7dKmSJfUskbMKiBD3TMiA95vMcL/rqABSPivr8N53OFhr7TwXQHoK
         sRhQ==
X-Gm-Message-State: AOJu0YzpQUqpPal9kIoOivzdHE84G3cFG4oXB6HJmBlf1fUdN0pfFNKN
	EvBzjjvULi5v4lOJO2ugU2V7WpjAvXTHM4UMLN7/iyZyzaIyab2Sjya+yaE2eg==
X-Gm-Gg: AR+sD119rqxWtfEPojkIdJP0Ov2NdSuUnSWgMJQQvUllTdg4AZUCoXDDEaenDy77vn9
	M3gpZmj45Qzq3+Ynl+aHZL3YOO7ZPad9m1+wFWjpf9uohUj20asUuB7AexA4KSg9gfApSvEGtnX
	g2TsAShIopnHws4WoNC2gqxD+ROLTjJpt4xUB3jhyUa+SGUEGIQuZy4cI/d/CQZdpoegSChZDzW
	oyrbRoBKybQzczMNcnoAqbmFlC5qBwASfkDAyaD1um/KKpP0UaVqOt6VigI/IAB52TV5ISyP8cU
	7eM6vYQGkcrG0vgBv/8psvKE23u8ZDVSwH9Ko8BCHMfx3kZ6m01RXuf8/eK80ZOj4sDzREE5V/5
	ZxbxAUl9Hxgh0sjPgh/ZDHPPy5tD+QZpTDokgUWt5+DG2MmaRHcaQHdyV6y/5UL6m8TkLJ6hNZT
	I2wEkGA4mIH4p39yn1ofBDbyBiWjp2I7dfhnWfQWDfrw8rkG0XmKjcTIW/iUwfklNagvbgnTAo
X-Received: by 2002:a05:6a00:8f07:b0:847:7ffd:ce35 with SMTP id d2e1a72fcca58-84fb53c14c9mr3610806b3a.8.1786521822470;
        Wed, 12 Aug 2026 01:03:42 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1d24ec8sm680344b3a.21.2026.08.12.01.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:03:41 -0700 (PDT)
Message-Id: <ad6ea197374f48f0837a40993588ae0cf69affc6.1786521801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 08:03:17 +0000
Subject: [PATCH v3 09/12] transport-helper: warn when export-marks file cannot
 be finalized
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
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When push_refs_with_export() finalizes a successful push, it writes
the fast-export marks file to a .tmp sibling and rename()s it into
place. The return value of rename() is currently ignored. If the
rename fails (permission denied, full disk, or an antivirus product
locking the destination on Windows), the .tmp file is left behind
and the existing export_marks file remains stale; the next
fast-export operation that resumes from it then silently operates on
inconsistent bookkeeping.

The push itself succeeded by that point, so promoting this to a
fatal error would be inappropriate. Emit warning_errno() naming both
paths so the user can recover manually, and keep returning 0.

Flagged by Coverity as CID 1427723 ("Unchecked return value").

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 transport-helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 31883b244e..ed0543f1ad 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1184,7 +1184,9 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (data->export_marks) {
 		strbuf_addf(&buf, "%s.tmp", data->export_marks);
-		rename(buf.buf, data->export_marks);
+		if (rename(buf.buf, data->export_marks))
+			warning_errno(_("could not rename '%s' to '%s'"),
+				      buf.buf, data->export_marks);
 		strbuf_release(&buf);
 	}
 
-- 
gitgitgadget

