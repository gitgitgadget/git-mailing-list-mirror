Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227CB3A63EF
	for <git@vger.kernel.org>; Sat, 30 May 2026 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780137879; cv=pass; b=VFcrWxA9gnGnad/ICrGSeL7s69m0lOnJxakMHkPNCGKxvTOlOSRx3E+1YzJg7KW2h/nSFx1xV9eVoZHxEMcqBm/S9BYz0Xw5Up1Oz7n199rYdo+jj1rgayR/5kHvBOOf7+xs7tqez4xabJws5h05y7H3g2XB8cBhgOxLMd+9nh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780137879; c=relaxed/simple;
	bh=pE0QzHDYrZLMw4qv9biKAthPn1FlzVZiiyH5WYIskis=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nGrcG2N5ivKi3vqVpQZv9zwAIW5DYMGCMHrFY0zhuL7XLrDvC/+3wG3TwLVm7cdKIKbY/8Y0nHO+6Hfs2TEDpz3sj5MN06oIRrHfsK17OXqsI/7qv8pGQkZfxA/vitHWJ5eH4V3lJwg6JBSr6HMJfIoFpYafWiGOHUnePfTYC2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAFu7GkI; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAFu7GkI"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304dc707bfbso248820eec.2
        for <git@vger.kernel.org>; Sat, 30 May 2026 03:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780137876; cv=none;
        d=google.com; s=arc-20240605;
        b=CGDAAPW+1TXZPkn4NDVlvbxYWhea58D5NcWwKuO65tzS7qlVIXpRzmWU/PlWzfUbJS
         DjbP1iR19RIz2QgoacC4Ah2tDxxj7+O+COYoJ1vswQBp+ZVVJo87jfykI26cuyrT5yqY
         80FJ+lKzNlEcrUqz3TK4KDAaK/PH/YzNC53UnvDpr5J8ypS3QH+GHWSlDEOn+lkVCpHN
         jQMQrj2cS2OyFc3nobXc+ty5Lr0uIsvkWW5L21i5gDfI5SiBj7k4VRPRxtCPs23182q8
         xaaN/AiLXcY7SQ/HXVNqJbkh4com7BNfAlPHfC1ViK/2P0KBLiZ3QXvOz3hiVb4BK1QU
         cz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pE0QzHDYrZLMw4qv9biKAthPn1FlzVZiiyH5WYIskis=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=U0TvsGjuPoTBNJBXe7J0zde/0JgMHBca8JpmK9aHyRM0XrqCC2yJBPWrNZO9/iiubp
         umrU7pyEKJr83JG4S6TJvZPUkrYoYJJP3GbUgJm+Tyw4nfA2sbapzNGfntkXls1rcW3Y
         jmJyC88qM2de70Q5C/mMLVZ93nfHRDvh1ubJzokVmjLMaxKvsE2Z+sE+t6FGLXiALrE1
         svp+l5xhjKvdrVHFHYC0n68H054B4uwOK25G5qu0BT/cKEl5WD6HQhjVUhlCMe0QePIy
         hVa04ogSh+mQSJ2AfbOQjVvOg5DvMQkrsrVlxqpQqJb40GhEWSs1Oi67Q6cK7r5CK1y9
         RXTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780137876; x=1780742676; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pE0QzHDYrZLMw4qv9biKAthPn1FlzVZiiyH5WYIskis=;
        b=lAFu7GkIf1MMZWe4e+qFf6QZyTlPZX9fuPN+ZlDEnTAKuGG0dHd9kRKJpjfdZ1u5af
         zlMNTHm3Bi6UJvs16rknoe4Y7mP+rCiJZoJxUmsPf8mQaR1K41jnKphmdZkpI3vI6/FB
         NMHuoouj57fwh4rmhHZk+Lrb4Tz7dlCZhtgRx4VeafEGcpjivvIXmAJHDoTcHe29bICA
         Sh7T6lFXXBMtbJoSKPmiT1xKuJiryKnGLEm8tKeEUE1pzP9ZCzHjs3dey0qxQSZVljRv
         4UeG86pnkIbkhMwGtCDeEog5Tb4piBRO0E2l6/mc8DjvzX+CG4EPjd2mnw+XBS15A4cV
         0LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780137876; x=1780742676;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pE0QzHDYrZLMw4qv9biKAthPn1FlzVZiiyH5WYIskis=;
        b=MPKeF1i1GG15TOL+X9U7xbSUR1wjP49iM8e8NqMx2sT3egHvQ8zIvuyqv9xnwFj/Vy
         /vnx4fhM5lf6cOWO0E42F7W3O5iXo9No2P7LkoYjrY03/N4wpB3xX9wcsSubFH4FALdF
         2UXHSRXgHcmII2erYOAekGPwAWm7gDeRrJPNbs90sqQ7B3KrhVUETUyRsswR8IvU1QOE
         Yyvz68ELD1PHd6cXrVLXqhc3xRqbjp18Myaoyeb79hCyBl5RrVV29G5q9rrIS98ks5l2
         1n2eYiiwFIFJmSCGSl+Q3oUc6jbJ+UIi6WJ02l+QOLO6YXtNvh8z4Y1/YOZNTLMQzGIf
         hbsg==
X-Gm-Message-State: AOJu0YxzrNOTDc5nSd8yvD91/jg86S08pkENs41hmSr1zZjVQQx+DWXt
	QVK0HmIaJ/3EyBlSV6jDaBg3ujZgmXT/fp97m4MA49gS+WPpNK9F2a/qEU8itNbxAt0Os9LglVX
	0gE+V8/l+arbfBNE9qSTm22vfthjNTRuEWA==
X-Gm-Gg: Acq92OGXKa+nlm1vChNUblVWYUJVP08hhZft/RK564XQM+GlXx1+pIWJJA67ZSt6+jt
	QTVXWuzcVfM3Q46+PHA7Bsv+dN9ffzmIJ+vBc9gqWu/5LQIIOCgv5vSSHWbWzYhRD60/8Ep7u5h
	j4gnVyiUQZZ6KFk/PEP4+WbsHQ1I7eMQqmYbcU/h3t2+PXiUSk/wUhtdX5YlPMt9054vmhBBUmc
	u8+GHFDfDMlTd6Aa1GKkJXns954XO4MwTSloRv10YhXO4sCUAtGJTuC5tj8ArAub7yMqj+N1s15
	UBUP0OB8dVPvh7JTDrW4txQrT3R/e/ruoNIrP6Li+567c3y0HyU=
X-Received: by 2002:a05:7300:a198:b0:304:8361:a8a7 with SMTP id
 5a478bee46e88-304fa65a384mr589382eec.4.1780137876018; Sat, 30 May 2026
 03:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alix Brunet <alixbrunetcontact@gmail.com>
Date: Sat, 30 May 2026 12:44:25 +0200
X-Gm-Features: AVHnY4ISPF1O5ghNc3nGycHTc5Neo__ExbDQtkSq62_ndKOXIIbjxS9DSJeX6TA
Message-ID: <CAPCeX5a6HxD8pAcE9th8+0zhsa-nabRrJQpjKXJrg02zc6EAOw@mail.gmail.com>
Subject: git-history drops signatures
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey team ;

I noticed `git history` drops signatures,
Even though `git rebase` can keep / re-sign commits (`-S`)

Will this ever be implemented?
