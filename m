Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA01F188
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 04:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705810077; cv=none; b=NM/qFDt7zmucMQ0wgyO3KLiIJa8RA5LKmiuW2i24OMprw464vNjBsTTaXRzEmqFXPSBjfC3OvO+pBMp6A5mFA6WNEZhicLgIyGMrI1iWB9VApMdxvTUMV6nN3RQ8vIZh4q11npftrYENFeXXbvatlwQyc+JsPA5T/Tf+euFgGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705810077; c=relaxed/simple;
	bh=9DfTGyLgaB7IOo3JPHjdfT+boQYLhwbgr7vUIDXZycI=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=p38XwLKOj6rF9I/XylwmjE5RpEy4+W57soifl6XCzW71C0cHTppHcA8PMOplrJUTZ8UrWC/K1p65mgz/tth/hNs24KNGdync0hQJxQtgm1zbeoE5jxctZSAsL1eO5ZnFpLKWDCcN3I1cBwGha6W/vsjlsvxPNHmX34c4vZ87hkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmAqzTLP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmAqzTLP"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40eabd0414aso331235e9.2
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705810073; x=1706414873; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XconMGS1+FGVe9d0s2aGxi73WMaFLve3AEG4JEP4jrY=;
        b=UmAqzTLPF/lOG2dkIpNKc52faPUNa9JYdnnNARQoiNtQlywqgjCcMIZuhOVoov8VLJ
         IIuEFIZdClasl19x0vqjeumDwBe/ejpq3WzSAWdUo6z3qERKumCMzhD+oWcOE54LwbS4
         N1drThNFRMNDsSxnfnRMsnpu+LAwCDVKANxJtjRNAjaFxaalhBZ767Q5oOCVwl243XGs
         +T9BZP6D5DROBlxf7OrZgAOqG1NqXFUP0clDLTCqkoTKACBujGWimhCG81SUKNffgCeg
         uu1mxYjR9vcAafhWWbIJ2M1BoVvCErCqM8JMAMm+o8D9DLrzt5wEnAlLCTxUz20bI9b/
         ETVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705810073; x=1706414873;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XconMGS1+FGVe9d0s2aGxi73WMaFLve3AEG4JEP4jrY=;
        b=QinhbVoEsDaw4vw+C9w38qAT8jW3eA7cfNWfjmwaNuit4p4XF0RPf9Ebtpyy9d/dY0
         lPQ8cVLO6IjvENgJMaXmq6lw9fQNNgxFbRUDS/7iC8bImg49uuSsnRlI83c5yJ66F0L5
         KNsv906bN/SCzoFer9sQz9Xc6R929Of74LNNpzEjrBEzH6LDgfng94iD2k8T/51LklcT
         BzqFAnrqxJg09Q7YkDR5i9bA+HJJdT1UQYlJ1fePwAo/QLosO9zveC39s3TgiE6nUvWH
         i6cgqKJPkEh+pQ805Fu96JJYhwZCtaDwpsEdRuWvrn4qapvMNkFVfxUcHp4hrZR4EbjQ
         7YWA==
X-Gm-Message-State: AOJu0Yxozh+OYjWV0XjOndCnF7IqB4o+vgCxFTBb0bUTNm8rzXuCxAt9
	HGvnUWVjarE/rpmSBznKHNyyhZ7ka9wXp4DIhY0QylAsnUBGYhYtaHWrSIwQ
X-Google-Smtp-Source: AGHT+IESBcWNhJn0WTeU7WXs61yOQ+Uom2lXJRSnSkb+dYOIXkCNk3V0enEqW/ATTMh2Gcmv91W2Fw==
X-Received: by 2002:a05:600c:444c:b0:40e:4e13:82e8 with SMTP id v12-20020a05600c444c00b0040e4e1382e8mr601427wmn.32.1705810073200;
        Sat, 20 Jan 2024 20:07:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c314500b0040d7c3d5454sm38350446wmo.3.2024.01.20.20.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 20:07:52 -0800 (PST)
Message-ID: <pull.1650.git.git.1705810071.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jan 2024 04:07:47 +0000
Subject: [PATCH 0/4] completion: add missing 'git log' options
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>

I noticed a few 'git log' options (old and newish) were not suggested by the
completion script, so I went through the whole list and added those that
were missing.

Philippe Blain (4):
  completion: complete missing rev-list options
  completion: complete --patch-with-raw
  completion: complete --encoding
  completion: complete missing 'git log' options

 contrib/completion/git-completion.bash | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)


base-commit: e02ecfcc534e2021aae29077a958dd11c3897e4c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1650%2Fphil-blain%2Fcompletion-log-options-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1650/phil-blain/completion-log-options-v1
Pull-Request: https://github.com/git/git/pull/1650
-- 
gitgitgadget
