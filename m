Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659ED1E2848
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744228365; cv=none; b=H7c41lzQY7dFsiq+iGWBxmZgX4t+Rz2GJb0dg07CB7l+XxnjZGQ5E9J4skIaBQndkYgo8bkW+opuQTZGCd757Hf2wxbzqnQtuPO78XAkNDItnGHaH+BBk6gmisZ4jgCPcsoeW3vWh5+k74jxS3wL8zKSQ52dC4qFR1NxrOM3J2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744228365; c=relaxed/simple;
	bh=Gh7uY1/S260Gy6W7JnhuypWlCtOYoGpbYZvSnK4Mt6c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WSgwHdSlyGPYETQlaZOlx2qXgRNRsKafM8Web67A3UamR/K3xqhpTu+tALMg3w73Sy6vKwAmQ3Q/V0gB9i6IAaAmr5x83ONMZCsW8eHNrO7Y4d7yTXdXSfyrcv1l6/JSohq6iHfGfgU9J8VFDjSlKCnMwGal9VLi6DDv1wjWtFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2PyXNt6; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2PyXNt6"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4774193fdffso84151cf.1
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744228363; x=1744833163; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gh7uY1/S260Gy6W7JnhuypWlCtOYoGpbYZvSnK4Mt6c=;
        b=D2PyXNt6/8+bD4YY7TPB07v2Tf/4y6gmSmPx7ZX2P6oBqo1as9n9wdaQeoCo12Q1S+
         Rxg5fDItuIaAiJthIsx6/bRtq3Z46XCrMF0U/lHu2OsNoIIJgz6fdV3LRqTddwZ2cgF7
         wzyHirkRQSXUObV9WsU4oiu/Fweqplh+hlPQgs1nbO7aa/eVuOlbaspEaZzZlNypK+Vn
         96dDIGB0hlAUUJSNAxO4c9Ds1bNZ5P5XoxkfEcFMjAnNwnyMxzDKaDltwqUy4WW6mGl/
         Y/K/FlbyyxwQPaTmQRebob8+nDkx7Y0eap6JMd7SMMWT0yqS/dWWmvypvz6D9c2d7mDS
         fXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744228363; x=1744833163;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gh7uY1/S260Gy6W7JnhuypWlCtOYoGpbYZvSnK4Mt6c=;
        b=KIfBSQUVU84FfsoBiyE0uH4obyM0QLuGqEvca1S94Jb18XQNNR8TSpBBwCyqzSSEA5
         trOfqelVCKNDiE+334uFlSn7+XSJkxVAceRfDKsCRd8eA219jE5iBjeDNCeBz9+C+Qjq
         PnyDvBpiBkK5hVlKwCuBMcvVMldMQdEeH3eEgiK3m2tZJA+49QssnjL7tW4saL/BypMO
         jQc5kEJeUsJp0n0dvw/uFMU8EnWTgsIbGl39KZiT+prvzH+soK7UOwE1utVWmrCY8ygJ
         mLQkluVwzyIqBkP4oiqiM1mUs+F7raCfH32EwzID/EIj/xjd4DmRcQOUe/bjETX1wIRM
         4SPg==
X-Gm-Message-State: AOJu0YyK5p7Mt7+NyBj4hRlFv1M/Kro3hnPxhfqwVj++2sZj6RQp8qa6
	6jO0XZcJbiUaOksLFUVMuYvw2RswqeX9Do/Ryf7znksQMSnP1E9/W28WMeRm+s6Kru+WzV5Y3P7
	DsS4BwTAVR0vO05tLLdWIwsk+jmWsnhLy
X-Gm-Gg: ASbGnctKLDt4ThsltMw0yCi6lBMeBPRbsMGhrcUbZ5adqyF/yweW6rVlpFQj79hB4L/
	OYm1RyjaXsP0GQcsoCvwjELK0eK6cvSaS3PrNvQX3vnSLSsbk7QHCNrLNoboE6Q9zR2nk41UtkH
	JVRxc/iieDUz2jc+PNxxHxDw==
X-Google-Smtp-Source: AGHT+IF/6T1JJl2bZKrSi4sNa41HeEL9nozoIj2kgRXsfT6YEhpMyGu+2MOeuAL9R6k+EB3opBmyp61cUf9dv0j2MNE=
X-Received: by 2002:ac8:5d04:0:b0:477:5c51:dd10 with SMTP id
 d75a77b69052e-4796ccfd226mr2016221cf.37.1744228363036; Wed, 09 Apr 2025
 12:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Junio Luan Pereira <junioluanutfrma@gmail.com>
Date: Wed, 9 Apr 2025 16:52:31 -0300
X-Gm-Features: ATxdqUF8hd0TEGHOtYnPY1UeaOmUgegFFoKF4NqjyIsKicSmJgBLJSNS9hhHmBc
Message-ID: <CA+7SsOdTiAocj7ZTV=OVw0tyKJxZ-H+m5S8soPfFy6zW=1ddzg@mail.gmail.com>
Subject: Error on using git update-git-for-windows
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I am using git-for-windows on a windows 11 laptop with the Brazilian
Portuguese language.

Recently, an error occur every time I execute the git
update-git-for-windows in the following way:

$ git update-git-for-windows
curl: (35) schannel: next InitializeSecurityContext failed:
CRYPT_E_NO_REVOCATION_CHECK (0x80092012) - A fun=EF=BF=BD=EF=BF=BDo de revo=
ga=EF=BF=BD=EF=BF=BDo n=EF=BF=BDo
p=EF=BF=BDde verificar a revoga=EF=BF=BD=EF=BF=BDo do certificado.

Reinstalling completely the program apparently does not work.

Is this some kind of bug on git-for-windows? Was it reported? Should
it be reported?

PS: I have no knowledge of programming, developing or debugging git.
Ask me in case more information is needed.

Sincerely
