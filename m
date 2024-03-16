Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D66617BB9
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710623790; cv=none; b=IYjtcdARxUhcvmGf70/OosrDUTLimRAZFbZXbXjw/qiWleTGUqsKNymHxRWbV9PlCGNVl90WJ8sppzNghkmCNNu8thjPmNmRsJR4js6V8LP2qjUOnjPC+3aJ+0X+BGHfcOlnfgb9RdF6SiqUCAaHihJY4fOx48YOWiEqynMjRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710623790; c=relaxed/simple;
	bh=OFNNhLJZJrk0cMP9B4QDAfKhdYx3NguSDjJ899sKfJw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RMzXKGmsSWN7Nwo+m+1WpZRRKUexV4w4Dcy+R4t6tXBD5XxGRXO/d4u5aRbpi9HAEGhn0VdBVAFFTDnavrOEGa+NUV0uxp1hWh2TnqopV8QV/4oZQ7uc624+1JnE2oTRZjgvqNyJpYT/Hq9DX8fycwK1D5Iq9S2cqaaVu0mygkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeTO8EGa; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeTO8EGa"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c3775ce48fso1252275b6e.2
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 14:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710623787; x=1711228587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTC1oE4Pv/6iSCADIUJGlV7oXlaX45ElZqI6O9Dpces=;
        b=HeTO8EGa5xWZw1xHdVvxYogS3iq/Ugn84rjweOP/SrbgAJzaCfehZUQdQyRk4sHqDO
         SuriP9iL9h8lSQ9UH/DRcnQEH1RSmHQxWM6wZz6q3JmrvdB8HTNQU0QkcR42v4AVTpba
         rR/wNyHp6tQZp0yPPH0U3em+Aigj8cKX5O8KMCa2Krcr83cj7EeLBh+mGylAGitZp/jm
         uvjK10FGVSMksCnka60x+mHlHaQjfuQxAPyPoQ1O7cCScFKSBl2ioSrdB4rMghZx/gYy
         2JeMObEeLmYHPHcMOJLN33XfC0BeZx9SNFVdKFcG/ZZirECBPcKFKSbW5/+bzSVpJ5LK
         XPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710623787; x=1711228587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTC1oE4Pv/6iSCADIUJGlV7oXlaX45ElZqI6O9Dpces=;
        b=KIrvYxdbepx/gR0SwcrMQGKVHmzCIwt16kOZwdFhJYczOkvJNQDu85jjKoZHTZpR8Y
         U2XY2q2Tx8zKKbcvnDoCyMALgdulCd4Z6Bnd53Bryq/94cNgGLwDT0c0jIBmqYWCS0+7
         lD1FoJVrj5cErE+Y2yrc7GILT9lfNpBnW3c0LSiLOb7ojJjsoFIOGD+0J8Hslc/uSbAk
         RzK8xVQdsbbwaJmTZ+LipVVTNoNF9j6qCAhvhqSLeRHFwfwu7Uu9aJQhY5uO2F6iuMcY
         3T8xngosOzS7jzElmZkmzZZA3pmFUAvAB7t4tYNwGDWffi+sxChtY4Qrp2D1PFrTuPyP
         ZdSA==
X-Gm-Message-State: AOJu0Yz+usqOIsK+1JW67v6OE+NtH+TxQ2fL1LMzrGtwWkKfSXouUAE/
	NhGACjkeJXofs5VkVxtdgSiMLFaxkRzdqK2719ZHrNo43weLWIJUjmFURlxD
X-Google-Smtp-Source: AGHT+IGCh3+xR77nMLjsEmZ+I6abBttIsRix5Vd1qvZ5OVD7WTS82ky/DZUP2r+kQeIEr6pws33+kg==
X-Received: by 2002:a05:6358:2799:b0:17c:1da1:aa8f with SMTP id l25-20020a056358279900b0017c1da1aa8fmr6123109rwb.24.1710623786901;
        Sat, 16 Mar 2024 14:16:26 -0700 (PDT)
Received: from localhost.localdomain ([152.59.36.79])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090a300400b0029b939012a3sm4850799pjb.52.2024.03.16.14.16.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 14:16:26 -0700 (PDT)
From: Utsav Parmar <utsavp0213@gmail.com>
To: git@vger.kernel.org
Subject: [GSoC] microproject: builtin patterns for userdiff
Date: Sun, 17 Mar 2024 02:46:18 +0530
Message-Id: <20240316211618.490683-1-utsavp0213@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I am Utsav, a Computer Engineering graduate, with 2.5+ years of experience in the technical industry.

I am writing to express my interest in contributing to the Git project as part of the GSoC internship. While I have had some experience contributing to open-source projects, Git had felt a bit daunting to start. I am happy to use GSoC as a reason to introduce myself to the Git community and start contributing via microprojects initially. I am aware that I am far late in starting with this but I'd like to use this opportunity to learn and contribute more even if my proposal is not accepted.

I am passionate about TDD and work at an organization that fosters a culture for writing tests first and continuously improving tests and thus, naturally, the project idea "Move existing tests to a unit testing framework" caught my interest. While I have some ideas around this, I've been focused on choosing a microproject and implementing it lately.

I have been working on "Add more builtin patterns for userdiff" for Haskell language but a regex for checking the beginning of a function definition here is tricky.

Haskell has function definitions that look like - 
```haskell
main = do
	putStrLn "The addition of the two numbers is:"
	print(add 2 5)
```
This is fairly easy to implement and I have been successful is doing so as well with verifying them with tests.

However, Haskell also has function definitions that look like - 
```haskell
zip (x:xs) (y:ys) = (x,y) : zip xs ys
zip  xs     ys    = []
```
Notice how the function name is repeated on every line. (and this is perfectly legal in Haskell!)
I couldn't think of a way around this. Please let me know if you have any ideas on this.

I'd like to know if there are any criteria for selecting languages to write built-in drivers for the hunk header as I only see a small subset of languages already added. Is it left open as a good-first-contribution for beginners and so can we add any language/s? I am asking this because I noticed a pattern for css and instantly thought of it for writing for scss files and would like to understand any implications of this before I send a patch.

I observed that javascript and typescript have not been added yet despite being popular languages. It seems that someone else has already been working on javascript, so I'll implement it for typescript language.

Upon implement this locally, I got confused a bit about `t/t4034/` directory. Could you tell me more about it please and especially `expect` files here? Are these auto generated? How can I trace these?

Thank you for taking time to read through this. Looking forward to contributing!

Sincerely,
Utsav
