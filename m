Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D640DFCB
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776211566; cv=pass; b=Qjal44HxBEvsMAmg1nfmshnlEVET9rfIqlRYO0QuPAMY/2A7o9wtqM2luhHU1jglGbGxBey6odzzlsE9Bt/pRLIDZc8dmc8/dNUFrb5NGt6pIIJB2nExiv1GwXgDMAW2IqiX+yeCmp+NlEdGBnwTSsoUHImQKuY2PCm32Ms7W2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776211566; c=relaxed/simple;
	bh=jqN8Yd8DlaxHaGEOekBvKf1k9gIsn7ylAFzkrGBLmDo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cZJ69X3eyOOCVLjbQb+Lm6i2//g0YsR4kf55ykHA75vpOnXNbq+y4j1M6Cn3JCtya1BvwIUQY8yLbZCqJ9gi04LXkFqzVWiOiCRPUEeBmMY4sWXDjDOJMMyZgHnQqdtof0q5VqTBW2VtTiA1IJZWEt0eHGv1hI0yi5U+aBFof3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qcY8Xk12; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcY8Xk12"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12714f01940so322004c88.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 17:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776211564; cv=none;
        d=google.com; s=arc-20240605;
        b=ad+bdadR+5i2tLWFi63AvtvxtalUqUJICjEUcvdt2UT6UnNJcSijQhvVrD/UG6G+8A
         773JBn3UEFcPNLbJFeRS2eL6kWNL4STB/0au4m/p1WqHR1h6Iy/L5uAAQDR0gi5CiGj4
         Sr8fHPXeqN4FpBcEGHvVLAsEutw8hOFHoXyGySy5XBGQBazlLeXtjQylnbqTA6BfrmFN
         TOVW7rvz3barLQl+H6eoF3BMwalLd5k8mzYk00k6tUR24zZXuUWVKxWeoz1FMtLNXcZg
         wzy1bkBhhbaqW+c/kVnBRjq+Qzl+QF1KNl0caba4D7NimCJtUWVrMk7If8s5I/xuZuqy
         hrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=jqN8Yd8DlaxHaGEOekBvKf1k9gIsn7ylAFzkrGBLmDo=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=bsvjbNlYuDFV2N2hTtgaJZyevWt17lKOXXXG+pfWyxzsuxbFeED82MF4F4QU9CSYuf
         3jjko6OijfUtCBQRCsmEiVUVn2jwOhg4P4W/yKFPDvmv8VCGGjjUjDSunNBRMGcLn3kI
         LuY1ey8GMbloswci2OHOC6Iq+qtHkp3ra4i4k0iJIS0ueyxvQ5k9TT6soV4F7Y7DUOu6
         r1McWdQ5bEDqJUuoxdBTacUKAyzosVcKWCw+NiegbaBhFrAzniOKQtMJmMa7aCUwf90z
         3x5j1lgaOHE10/gvE035m4IuBWCD97J46FuCZDEEq54XccPgkTa2ANu1U1EBo9i4iqhW
         iISg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776211564; x=1776816364; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jqN8Yd8DlaxHaGEOekBvKf1k9gIsn7ylAFzkrGBLmDo=;
        b=qcY8Xk12qGZm1wNswsrOCDUN+xvpg7KPxB7Xj7Dvd3VvQm4+GrjNnwvYupQiezGjcl
         uKiBt63gzk6M5G1ZF8tLxWo/3qOFZnJ3KOKrQ9xiM9xomsy9XvqOpPt3DHdQ/NGXghEY
         IjBnh59dCfaf6DKzAN1CmuGKurzo0q3uburSXvGkX1hCkqo6iYjMNL6WXe6xik8KPBTq
         AHkk44gIHChSiRYlKgoyEoYqF6xuan/fPygDq+baH1mv6aVC/ytQwEuDxiVW6rUuVDE9
         w+M8RIaZvoWkpsWYz2Y/9t0+G9C3ypIWqprxR8egkECz8AVJ/p0uJXOSkhaXypzXDUDV
         kSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776211564; x=1776816364;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqN8Yd8DlaxHaGEOekBvKf1k9gIsn7ylAFzkrGBLmDo=;
        b=hpqYKs6wsFIl3w3S6Rgc/LTRcnz4c8VxdGeOUHi+mjSD18WJtO8e3LpGdQZLHtIQlu
         WL2vSQvZytYpNOOnmY5RTGf3M2YJAOFeEqn6yucWQkezOK9Jmj9Uw47Y+oZFhECtXNWo
         8rEtU94PfR2LWrbr4tcZCmuLz2sIwGL27kDtodx6Cx2FTFB2XW0zS1y0caLu694oqTRP
         o4UWqxX1eakEcd98gzh3gfVSft1EiLPkKMVpOS0WqIHABmGuNqWOeB3bS7E48XWY0R00
         e5SPrRCce9WGqyVe48OrM+P3k2lHvhcGBoTim1VGI60eCaE0V9T/SKF67xv8Est48mKy
         H7Zw==
X-Gm-Message-State: AOJu0YwYCiIF9l3HVvSvNSbkcpPxP2Qs39L/MaeKmz3ZRSBiKXJYabNh
	d0FMsFBOHRxZWsy47Gq07uc3O431wqpW8T9nLCX60E0IBNpl7QxDFXQpm7MDtjlDXpg/wECO0I5
	XjPlTHdDZs6dmJbKnAGSyKPh11TnrXPWmm9q9
X-Gm-Gg: AeBDieswNkveePixX5Ak46MpqldRqLnZeVqZld124AP9JdS3uzZIkr8nuPMksLDyRb8
	0d9LRfPP6rQHEYeW6jACAtx4brY42HAs3FlmTGwCNQqgnXWgXgwYeTrNTUNdRlTgGxmQXktkObf
	fRwekZwE2FDU7wQjUw4qaWCxql8hzN3YVB6rkv+YVG7ZnFRgy1Bi9WugARDlj21xjvFrYDTv+52
	Z3JrB7HEAGQmfnZxFx1Q1PT+iHbqAcrKMqfs7s3jsGbFb9V7KpgPkmpC4MmwwTw2E3waUeqie34
	SU+2uT/Ww5Ubcc2dh+fM/8w/6gOYbVCULjPletWo
X-Received: by 2002:a05:7301:6091:b0:2c7:2cac:8149 with SMTP id
 5a478bee46e88-2de7c0785e2mr76545eec.7.1776211563599; Tue, 14 Apr 2026
 17:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alix Brunet <alixbrunetcontact@gmail.com>
Date: Wed, 15 Apr 2026 02:05:50 +0200
X-Gm-Features: AQROBzA_zFOV_5x1KzeQcOcH67C4fLplSCNfxqHpQ63OIHSLOPKK5_5E0NCS9IE
Message-ID: <CAPCeX5b0T6WOnr-aCWV0CfMvPSk0KgzbnshgYgREELWjdGe=hw@mail.gmail.com>
Subject: git fetch second argument parsing inconsistency
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello team.

I just "discovered" that the git fetch second argument parsing is
inconsistent

`git fetch <url>` silently fails, but `git fetch <url> ""` fetches the
default branch

I quoted "discovered" because imagine this might have been discovered
before, but it took me too long to figure out, and the docs page (
https://git-scm.com/docs/git-fetch ) doesn't mention it either.

I figure this is either an unwanted behavior, an error that should not be
silent, or at the very least something that needs documentation.

Sincerely,
Malix - https://github.com/Malix-Labs
