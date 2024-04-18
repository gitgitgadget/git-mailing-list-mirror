Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243DB1A0AF1
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477138; cv=none; b=KY6OptHnN+7AFuRZQpZMbWq7rfZLDhRWOR/D0YrPIqmU8iQ5T3vX459FbcLCjAWjoarFzyeMXWWpf74bhBxvUvJN7vVJQZxlZ3eWbsoiF8lbrueYb97kZ5HeILuVN8KyXPZZX/4m9ezryuvYcTemGn0kzEAC4ATDdQfPIHRTg/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477138; c=relaxed/simple;
	bh=6hRNSGyz3uZsyELwf4nzoLmlPx0s3agHui6OfS7JyaU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KkH79vBjscJNtIGsynlNyZzIAFeUFC8FH9GWB2ZFz+DawHgRBpOIPJQwoWQuQ2IGfODHWgCzRqmIFVidii9qqQv0FbPdXRE7uzlvyr1LxDrcAxc9E8t8uK/0DKv4NrlCWYM+TG7qcXFX/b1095kQa0xmRtIuHD1yVrzLN5wPDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDBaASJ5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDBaASJ5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-418e4cd1ffaso8809985e9.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713477135; x=1714081935; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWCmGqLz5qlVPr0cXv3s+aiOSUjGs2uMbTP3zozJ1io=;
        b=NDBaASJ5Bdk3wiFXSm+YvDLOMuNOZ7DejtVmRwYenP1KD9jgjhT9urkNCnVAtNNsuj
         40+9/4WUfQPuC1dene7D066RZQlhvOOfIM1oNu7wxJ94lMP0vA4XVznIFLThq/EcXTtq
         mzeh/LMXWj9c4OSZyTvaPF1GrlgG3qHAPGYEx1Y03nzeOKIazsTT7dofnel/lqfthbWs
         HekQFWuxtJn8GMAbc5Gg0ACwyJjMvJXfyJgEtRz7OE9+NqCFeMYvBncSrJuDWxZLq9Bm
         q7qFN9m1KiaEgYj1Mfpl7MDw6OC5O5VT7YCCMr3TsojrkgOyLy2dRajnwhEj2npJBZO+
         CD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477135; x=1714081935;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWCmGqLz5qlVPr0cXv3s+aiOSUjGs2uMbTP3zozJ1io=;
        b=B7/6OnG3/zVmX/KtiJo3tB8lAKLv9eX0NV43OzXvnNl5N0xEB4Bf4fWe3EpBTw4t/E
         97TtAWMrQx9BE/owAPzvzBDreGuvKbhsYggptMQtQx5L6bDQeQygYYqB32kiAPYsttAM
         oWS1PZpn0bv7bIPl4K3UMyUYjfb1RW4V0wJhImpy4IBZzrD6pxEJrAqwqBxg3xrjV+xX
         CqvSL5oFNo+MNPeoLPkm2qFQGlOaZKBxyIioR+IbO8l4mKDhOaTcnOBz+MNwcRsjLP1A
         Uxwutos6Tf2Vhq5fR+93sKMBZ7Ov8KQVehZAGCcMFUrLDIAoLVU1RYgeouj2afl02mF9
         0+UQ==
X-Gm-Message-State: AOJu0YyCedMS/g3+oXp55toyfGURNUF+OdmLDtl8U60cI3kV9vpwZn3+
	ZLqtwLeDeA7HAY30sbrsfuNv5skBx2LGgMtUN8M5CdrRwpp0V6mMtTa0fw==
X-Google-Smtp-Source: AGHT+IFwXdNF5XWEBG0lxVdFacHLb9vsUUoWUNBOsoh3oH+Lu6P994uwJ3ZBbrIhYt8tmphrl7j38Q==
X-Received: by 2002:a05:600c:4708:b0:418:6eb6:5cd5 with SMTP id v8-20020a05600c470800b004186eb65cd5mr105293wmo.32.1713477134904;
        Thu, 18 Apr 2024 14:52:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b004186c58a9b5sm4026979wmb.44.2024.04.18.14.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:52:13 -0700 (PDT)
Message-Id: <f346da95ee22e0bec3e147df7aa8fb9bd0f91aa5.1713477125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
References: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
	<pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Apr 2024 21:52:05 +0000
Subject: [PATCH v6 8/8] SubmittingPatches: demonstrate using git-contacts with
 git-send-email
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index ef3985459a4..b684e28c0d0 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -417,6 +417,13 @@ trial merges of your topic to `next` and `seen`, you may have noticed
 work by others conflicting with your changes.  There is a good possibility
 that these people may know the area you are touching well.
 
+If you are using `send-email`, you can feed it the output of `git-contacts` like
+this:
+
+....
+	git send-email --cc-cmd='perl contrib/contacts/git-contacts' feature/*.patch
+....
+
 :current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
 :git-ml: footnote:[The mailing list: git@vger.kernel.org]
 
-- 
gitgitgadget
