Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309119923A
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545461; cv=none; b=l8UUd8Uo1zgUYDW/ybRXMvmAjHih2eCPnQt5ouCdXc00/E1jTnDR5YQnqJidGGyVxeZ+4tkl0KWrItZcR+enx417gIWJommx9WeIRI4i26RGYHqXBFE9rBUjRsLtsqsppVLm4TtrjOZNjC6mEnexIPiWI+UC6A4oWr9q/XUFR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545461; c=relaxed/simple;
	bh=9K6M6qSm8OG3G1raxRP8klRKnG1V0goC07VeGupuevc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fRbYvwCwOhFJBPgp9R19FuADaazFoz+HArbob8Mwf5MrvAC2FSeChOGjR2djNEk2+/+PA0mcJp5GOwlWf2pz00aC9Zkftkt7/u59jFxD1gJzL3stJVv1eDIHZHE6ohoe70Yr258bj4d5Xx1Udw1FujVNOcuPzavsIj48lnBJDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGjyJgP7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGjyJgP7"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d89229ac81so631356a91.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725545459; x=1726150259; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9K6M6qSm8OG3G1raxRP8klRKnG1V0goC07VeGupuevc=;
        b=XGjyJgP7IGdOLG2x+d85MsFFknHWtA3ZU8Pa5zzw1GWjvQGddG1O0AtUTR8EN6Escu
         dpLqQSSNluYDbqNUzb/QMjd+XSw62G/iGNYoVxrNCJmx1tuUDmUOSRyiSIFubyagg943
         F6YXQtkovHuzu+8TEQXxkfTNfzrj0TXM72lfQJ22alhdSQfmUOLKySrfwgUjzJmLlyqX
         erB4CP5yyVKb1Hyj7CHrGH2HkHVRGAMmW+N5Cbvm/8T/Xdlvm+Y+1UJqsrLZOsnKJ8aX
         iR358eybspBC8ZYqUQ2F0SJIFiyVr8oZ7zCEovMSMCyYcycn1jAcuFFufQFeTISLfpG9
         B7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725545459; x=1726150259;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9K6M6qSm8OG3G1raxRP8klRKnG1V0goC07VeGupuevc=;
        b=r2JXU9R0C9cHjHb3tJbipFydthf3pSnMjtQV2899dtyZQBXbf6mZxhBM2McmhAVlgX
         jaWpyDWHAJ+LD0kB6j6MSl2x0kNCPEwgmdtRT43vuMXfE8SVhKnyadaZrPqn6kojRhSn
         WZtDIC8J3bYKDT24b3J/t5MV3GuZJUDTy6KTsDqTXyl1kCPgpG0K4qYX6/FET+6+hAvF
         n/POX8Fz8k4Co5bOBvzHuff77Blcm1ioniLglmRiy7Yqzsab4xaw9lOMfbnqp4ZdUUUs
         ZrXwkeeSDbHQ8mJAWkf/LpXjBgp9z1XF/XUNs0fEdeoo3lUVPfFE0l4e3ku4VSlIwKD7
         l43g==
X-Gm-Message-State: AOJu0YxphyKm64CF8Elam1p9yUkTy+WozJqj0nPONeZ3gZiX9UYIhdNT
	QUThTS9ej2uhi5NupzUILGIHA8g3d8haIMBHBjn/d0R1HiEAyNm0UsCzDjhoURXAPA60mX0U4RV
	5IiRAvcVkEhAmLR3m3GAYorZgtA2g0z/waiA=
X-Google-Smtp-Source: AGHT+IGAvEQO8bVyhDLJMI+yFvOzXyqiOiHKLauggU0GCmVDZ23FpM9Rn2K6HBxbXVEg/muEXrWZWG+nU4t+YM46vZ8=
X-Received: by 2002:a17:90b:30c:b0:2c8:6bfa:bbf1 with SMTP id
 98e67ed59e1d1-2da74887540mr10433964a91.23.1725545459000; Thu, 05 Sep 2024
 07:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: KwonHyun Kim <kwonhyun.kim@gmail.com>
Date: Thu, 5 Sep 2024 23:10:46 +0900
Message-ID: <CADLV-7K-D8ydFfeojv7EuhxBqKWsVYLofXJji+Y5rUTA8JEQ7w@mail.gmail.com>
Subject: How do git recognize conflicts?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

 Hi, there.

 At first, I thought it's determined by line.

 But as I experimented, it does not look so.

 Here's what I experimented

 merge-base ====

 hi all

 branch BrA ===

 hi everyone

 branch BrB ===

 hi all
 good to see you

 when I merge BrB from BrA, I get conflicts.

 but the first line is only changed in BrA,
 and BrB added a line so there is no reason to have a conflict...
 that's what i think

 and I wonder the algorithm how git recognizes the conflict... or how
git automerges...
 I searched internet, git documentation but to no avail.

 Thank you in advance

 KwH Kim
