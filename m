Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA11878
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721213704; cv=none; b=BDrR7GjcybmOfHE9nMCEmj68Dct+hP2jpnLHfqxT7Owt120V38IHsayJ12YlCPmQYKL35c1jAXTJ/TkNin4UHbvJdZ8aCHv0JApbaEdNe1I6zjNpE9IL8fy0vpJvU6smRY6jnHWTmWbWaPyDrbxWzBrm5p+z56076f+HfCaqjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721213704; c=relaxed/simple;
	bh=yLkKNnur7FWEH3vQjhPLWM/vs2Ah2/gLZNQvHyTx2m0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pmm8GwGWxNaCOX0m+04RwvSwdbFM7vT8BIZ8PbPjV8D8JJjvxXf1n9bG1p+4yDL5bZ/IrseqSxvBXhCzKEVH9GbT+N+dwYajjFzc5d71QLUcNGDCDCbJ/k2+0qKKZlboFAbPkP99Rqp3+rBnSei2jFs5gucPXJWvw9Yb6sR66y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJ7LBrWc; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ7LBrWc"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so6906363e87.0
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 03:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721213700; x=1721818500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAvTEFoH9Z/k2AEyrrysCg6L6HcL2/vg8wBCx0bwCKs=;
        b=AJ7LBrWcwkfPt9xzF3sPrdp4205/q4l9RfuJQl2FjvamyjroasTlb5fj0vQ62S1UaW
         oRJ2mFNltn0QoOXmOFDguNu5k7PbtlZbitkqqYSfDO0tRiwAO8VwiBpy7tkq0nrnB41l
         xYJ16FIlOC046Z84mXj+AInTT1yEVpZd+3JdPG7h/9OCUidl+YgaW9T3XSizqOTS+Xgk
         Dv5KpID6E9k9id3PHzw2hpfsVurAeDMTtxhBSfqSh7oL2ooxbomw/PePihcBlLI7NFFm
         CrKl3HxtonBDISkZC9/agd38s6zZJEr9AkcnpaLN/jh5bEXGrhXs3zEE+jvt5CFRg0aA
         n7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721213700; x=1721818500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAvTEFoH9Z/k2AEyrrysCg6L6HcL2/vg8wBCx0bwCKs=;
        b=o+bPxjAceSal1Ycii2f9bTsTOfT+We6Rn99MwDg4cj8KSOsi7zFCzLOapHKI7GI7WG
         TJJqaVtqsV5KM1Kf5cWB5N5hycDFccNHrbP7tOSFjIeN278rqW5YCNcKI0eLCxr7mQK/
         IWi4mz3nkRE+VLYo+7qdah9R6b6M567Fb0LGFbVuMRvjiWS8H87NtvExFBccpIk7TMIx
         eQfloTvZYWRxbvKHgZlGBfDvetsDxRu9/2U2DJK8IlyIFN1BqaMlSNJaNrb6LVdfdLQI
         TD4pdzQjrujXYdrlbQoNJZ5AQFb4/Ozq+TGetTs4z9DMrSMD3PEl3p4+MgkpfF8pJ7td
         ahBg==
X-Gm-Message-State: AOJu0YwD8R+P3YanoesURi7IksFoM2eiiDbmAM5z5CPIP+9qyiCAp74O
	9ss1lstHzSURE9KxrASPguhaYBPb/n+OrBLAEq6E/QJmtWyJxGaFlLE62Q==
X-Google-Smtp-Source: AGHT+IFBSoBSiCDezj5DBtgkxzEtSTLDsUWx48KXU/M359TJ96BZlYUNhqkiz0FGTTfAmJqlVaO1HA==
X-Received: by 2002:a05:6512:ac8:b0:52e:96d7:2f3a with SMTP id 2adb3069b0e04-52ee54420ccmr965278e87.58.1721213699749;
        Wed, 17 Jul 2024 03:54:59 -0700 (PDT)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24e1d33sm1440162e87.44.2024.07.17.03.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:54:58 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] Documentation/glossary: fix double word
Date: Wed, 17 Jul 2024 12:54:29 +0200
Message-ID: <20240717105432.2801097-2-martin.agren@gmail.com>
X-Mailer: git-send-email 2.46.0.rc0.321.g44c27ab58a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove a spurious "that".

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 This buglet was introduced in 74b50a5881 (Documentation/glossary: define
 root refs as refs, 2024-05-15) as part of ps/pseudo-ref-terminology.

 Documentation/glossary-content.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 30b394ab47..42afe04869 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -550,7 +550,7 @@ The following pseudorefs are known to Git:
 	to the result.
 
 [[def_ref]]ref::
-	A name that that points to an <<def_object_name,object name>> or
+	A name that points to an <<def_object_name,object name>> or
 	another ref (the latter is called a <<def_symref,symbolic ref>>).
 	For convenience, a ref can sometimes be abbreviated when used
 	as an argument to a Git command; see linkgit:gitrevisions[7]
-- 
2.46.0.rc0.321.g44c27ab58a

