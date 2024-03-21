Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE741E4E
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008101; cv=none; b=GhhJciletZi6DsCSwkgM6I/Uc1zdZkCTCpP0UvG9Bq/6xbY+Gb9Tx6RvfYhFc940Zi8AsjmltGAgCtsPnU+7u35VAgd20MDUBh0FjH/NupCua8gKGr+J7uWvG5haDHawAiVEGyKFJkIaOH5lAXGE+owzkcSxnD6H9g/Gk0X7jlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008101; c=relaxed/simple;
	bh=uznyLylptvRepSygUNkWNeGt3VQmQY9mlT/ghkI7PTk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=u/Yjdhu6pUTQNIXLQpyoCXYbBX/KT7b0CMkQ/UgkSOPlABzV5SG2B2hyZTz0jnpNlqGLXqnzUF8ZrWEOTf+NApeH40OmuDSId5vm88ckGN+r5ozH+SnaZEC8cqgecpaDG/0wtjWqXlw//zRLGX2qGaB5VwP4roawcjZem+uYJN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+rWTCON; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+rWTCON"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a470d7f77eeso45612866b.3
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711008097; x=1711612897; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4t4wf/ZbDtej/KBQlfXhvMgVj8YwJlfk1GSLmcJ4Ms4=;
        b=Q+rWTCONl32b3+GY5a/KgzH7Y0BjaJb33TjrE8DfTWmrj1KLwGio0Mfg9YzGCTQqU3
         wgGHSUcodHyBGE8A0umw/VO/9Dydt03/HHkV2PRDfsZv//cfHMQovCQS/ivbhZPNTXuM
         2nNdFqO6FQQhecPsBcBSadfdoP+lgZfNYdOSmyYBPjkamTZtI1jOtWuMXywPa3LANvy7
         Qxj1+Kd94eecKwAD/Yg9m6SGAzmJuodoiZ4k936JSN75EAG4/jgAXzdK/oyrI6FyiiQ7
         I7O85wOdBtTwl1e4gEvvm2GidHlQ03o62xWGVf4GzR0alzmn9C01qulsXrfQ0vlt2QU/
         wkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711008097; x=1711612897;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4t4wf/ZbDtej/KBQlfXhvMgVj8YwJlfk1GSLmcJ4Ms4=;
        b=bxIuVCYRZdX5dqgxjgx5ej5RZ1zANmNcL7pUD0vJBANGLGwZBZEQZ2pK5MFW0O8pnA
         ciFyKfzQ2KudASY6ICYGUSK5e3tXlGJnVGW6QDpHc0SZYRaXyX+U4yXpELl6qpQpDTt9
         4wlowBw6mOupRaT6ec9GBrnxY3P5s0bp4BGyeHW+fYH/snnM+h2nhXkcBiMXvMzWZWOe
         a0cJwuTV/T3xMg/Tm/fCPDJY46FJ2Hb1cPOm2aTnycWNe1PyCoiu16ma/Sg1/9UDQc0E
         0/bDVQJEBX+ItgvijLQoCK7sgMOj7jjXaACIJ5gPq38QrG1M+TK02H8YGd0mFySwZJdh
         gAqA==
X-Gm-Message-State: AOJu0YwxkYG9+FI8z1zIefzK7IKYdjYSppq58ZgOqWtbxPmsug5ISvHy
	uT+ltZSFJKkUNMvIPaW7b62fA1Piif+Fw+KlTtrbw+CGe+UcIYfNFMGSBaP9fq0DHKzl5i6m2gi
	aMPL1/Bsr6ac9IF8QjZZzzLkdZ0Ca2499Gag=
X-Google-Smtp-Source: AGHT+IEJkd7qeHQqBsPdwGRcWqbG8wbAVP0VdMtMADke6fK2EIwOuSml+ZuKUuACws2VWn2w3fB4ptxkvZzDNiCYwas=
X-Received: by 2002:a17:906:6bd3:b0:a44:e92:ebcb with SMTP id
 t19-20020a1709066bd300b00a440e92ebcbmr2852569ejs.21.1711008096982; Thu, 21
 Mar 2024 01:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: M Hickford <mirth.hickford@gmail.com>
Date: Thu, 21 Mar 2024 08:00:00 +0000
Message-ID: <CAGJzqs=ULaHwttY1jRaW4ZT0tGeSW2S_gcEw=tMrY+i26Jy1gA@mail.gmail.com>
Subject: Feature request: status could list ref names after "HEAD detached"
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I frequently run `git status`. Sometimes HEAD is detached:

    HEAD detached at ea601b57e

It would be neat to include ref names here, similar to git log:

    HEAD detached at ea601b57e (origin/main, origin/HEAD, main)

This gives me more information before I create a new branch or switch branch.
