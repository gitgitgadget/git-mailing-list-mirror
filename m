Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689D1D14FA
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931142; cv=none; b=obHf7ZmGEmFe35cRZkPqJQvtNBWsw9zoOlWazK0RH3xycK3V1Plt/GM8oCWkIKx4jJ5PBbNpZiYKJLDC0TtNZ42XN0rSwu5KZcaLaXsOPBLGzhU4Hhn2BfvrGlcOfjbINedZphGzpKiMBmwYMIg6Dl0XyDuBbbDwTa8NBPgdlcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931142; c=relaxed/simple;
	bh=J3FzQ/JckLt7RjVRrsQ4sfLiJu0hXRyB7ohUtIdbYMY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l7LY9FzYBozDxEk71rxE+RYN+Sve7B7nOu57omcrVUuuj7K/xsvmMbKfBTQ18Sa9n133Ui3AVTfmVuEeDjeCcRPrlpNag0NWGyse5zuj0JHpUh0YaVOtdK9bf3tjFxZkafrAVn56OxOH34xpkDNN3j8uvM7dlSBwBcgURf1mW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOCPVfrW; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOCPVfrW"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f006748fd1so35169787b3.3
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 07:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733931140; x=1734535940; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J3FzQ/JckLt7RjVRrsQ4sfLiJu0hXRyB7ohUtIdbYMY=;
        b=dOCPVfrWs6NwUxZdihT3oDha0UqYQm2G/KAT4/US6PMe2+KGenVjBKae7X08dLp2wg
         QPUNEY0cQ1wA+Z5/yxD/frR93nTgECXLYg2ogKb+iw0dz9dhwk27ghqLA/oCXKwlJeSx
         t2FQATsFlI6PwJ5WtfIyR5BmHmGMj4ZaJyi30saEzIki1rhWlTptlrUPBbwRB6LsvNqB
         kk52tAA287crdguV6v7IPTAQIoZEPulslg7XC5mixJl5IhI1GYtEfKDz8e+O+DlnhxdL
         rhKBdJ6tMePs3obKFClRBjwLkQTL9zlXqfeCSxVHxfWcenXU2wPtxK36vf1DT4VDKQ9T
         HMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931140; x=1734535940;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3FzQ/JckLt7RjVRrsQ4sfLiJu0hXRyB7ohUtIdbYMY=;
        b=WpQJGLI1KdkD5lznB571Dp0ky71LxS0tuugfy2fk0I46LBs3uHY5eoxxZnlUwJdawg
         258JpkPEKlD85r8aY/GYXPzuYLIwyyNURfcVXGZvA5cYFOzbTg4ZB3XSAwFCumoJj//T
         wS0+5V4/EmahUHFh6IZLeXzZ8RDH5TJ845uy0blyF87AngRNoeOlC4ylOZ+lEvhkyPIB
         teHUuDsOIcCECMhoOqDGFjLUoW8m0903d6JP3DAqeISLidA+QHegeJ/uZ4kSX6iqID0k
         LNPakxDxyNKgFzppanxFt7PNpsNfOmLLI5aFcQuAu9D+sT0nfqCA/ZNzF9mid7pxlXN+
         IrCg==
X-Gm-Message-State: AOJu0YzvVchIocTKU328EJKvWmp5F0gueeHdNMHowabBisHuozJfFIFk
	CJblJb0FgDXRJWsOaqANyGVmK8vhlAL8AuzvwNmw2Rs4Yot2+DlOi7OliefhnrKEBJXxzKX/h+S
	kyhpbwhcqg3OxYpPnblSmjmJbLRvGJ+7RwFRGqOj8
X-Gm-Gg: ASbGncsiohysVquTFgwhzvITRORavQVDOOQK5jqleNU84OSgdI3n2j70QUB0fi4qtIM
	0O5jP3J3o6sW6Svz7v7JYSC+3BPdxrlq5ZkyPNw==
X-Google-Smtp-Source: AGHT+IEjTb+nWMkxAVUbPksREgSjL7agHsSQtm/XY40X3ZnRjt3Kvvye71drkSJC7EFNESmSIr6OyZgd/BtsBfXvQyQ=
X-Received: by 2002:a05:690c:fc5:b0:6e2:43ea:552 with SMTP id
 00721157ae682-6f17d5ee333mr387607b3.16.1733931139872; Wed, 11 Dec 2024
 07:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Wed, 11 Dec 2024 16:32:06 +0100
Message-ID: <CAGedMteHtyrSThWnsS43bFqKXBuNrDrRAbrP5uU94=3UYFgsSQ@mail.gmail.com>
Subject: [Outreachy] Blog: Introducing myself as an intern working to convert
 unit test to use clar
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone, I just published my first Outreachy blog post
introducing myself. I would love for you to check it out and share
your thoughts!

Find the link here:
https://seyi-kuforiji-902b48.gitlab.io/posts/week-1-Introduce-yourself

Thanks
Seyi
