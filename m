Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D180F14C594
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842175; cv=none; b=n3rnQC2jz1wzeiI+v1uUDKDFhwI5dYb5sTSTsmcm9ECpbqXwXtW/ssXoY6WBbs7OqPTi4Q9or+1x7pHa7LH0vFnYPsBYo/06iIWsfoluyJz6WU1+sfIRfXF1jw6zFNTaZnX/isjyAVBNP9c0xkqX3w/YVKwa/Ur2zzW2QA/divI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842175; c=relaxed/simple;
	bh=ta2igMgUXdulQqwVacGlJg1k0ZbHulnOrSrJmwMVDn8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=duWeMqWpchbae9PVJMR57OkCl3ehu7jTEaTktA3tzu89803v7FNzJ5ccWqaqyr/eNwvKEaLj4IHcUSfhaOhNp1nIk+WUi1T/4pJClpovrdbcJGTlz21dTccHzbWxks9e6of6EdG2SzjySpErNMkq5PFm0/C6X1UUsfNrcxNyGUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmKqWXMe; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmKqWXMe"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a519ac18b3so3116031a91.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712842173; x=1713446973; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KeFWpJNxqsKwfgr97sMmBpfRqvGD6luAV7A2RHx93j0=;
        b=DmKqWXMeo2FkHuyPiogGmnzRsfrr6DjZWX1t9nAGF27nbUYxz6T72lJudkesGS026/
         a/sC09atvKpewW9IQa+bXpbJGBbJbv3kvghMpyLPwFqcaySqKWXt95TCHDIRJp0LOHoh
         R1NhUsZqYY+WPItfFrr5GzxSIT3bs+7aX6fh88TXu3s+ypWIx1dTBUJVDxn0DK9PJ2+g
         O2OJlq/GTQFQvcIs4rAoumK0RZVEVvyi/OdePiiAIAoIOciHjAWrkofl6K74a6f7p8mD
         EH2bqfa6ErsgHMv88bavqNgWLZeZdidwqlJzvUplKQvWo/ErTLdUq4963hFrcQ4KqiW9
         YvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842173; x=1713446973;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KeFWpJNxqsKwfgr97sMmBpfRqvGD6luAV7A2RHx93j0=;
        b=BYntDlirXeLJWiXyfkzSrdSMnc7kRcxIyOcSrVMu8Xp8t4jjZz6oF0OGhhXD1r47NK
         +9Rlny/zHRo4xmc+hQKz9AgROzr696oyg71RllyILJTs26dLdssuppaV9gJSrXpHe1Qn
         lXc0l6CLV3+x4D25ImfVI+E2gva8bzgx8ik/q3RuLGSdgRiZVOnsJR14untrggMw6TQh
         3o4W5kIzLDWnRUzxNkiVWC4pIDD2PYBOZ45CaPjgfc+7swRusunnqAcC5JYSsfyqxBUp
         tfiAtueQMGBSLrATlEYOY1AEky9Tk94PZhXV7pmRjxndka0MWgCeBFjIidivyvVzoNJe
         U68g==
X-Gm-Message-State: AOJu0YzVvILoNWIg5o7+mgv2ber3h8tmGbDU0nSq0AEDPEicD31WAiHa
	/Js6N/8yDlHqsgoOeTx0VB0Fi1cs2Hg0Lprrh7RE8gOEIkQAcdQ08MSP5PzkuTs5oeIbFWpcSz0
	LjIDBHD4BlKUq72VYM1IXXOKllRcEE+6tJHU=
X-Google-Smtp-Source: AGHT+IFJSxMFx2m/nfGMYc3PentnbIB10+EVtLxFAassduhlxuKgf4hYLijWvdKDxUKhqZfP+ePNXO9ntenzvxrDzMw=
X-Received: by 2002:a17:90a:ac9:b0:29c:7566:a1d6 with SMTP id
 r9-20020a17090a0ac900b0029c7566a1d6mr5392036pje.25.1712842172783; Thu, 11 Apr
 2024 06:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Valles <aledemoraga@gmail.com>
Date: Thu, 11 Apr 2024 09:29:22 -0400
Message-ID: <CA+2QE3HqPiB7kLCj4Pdvy3WByG78rStwxtYu2E_mrA4bTHh6Qw@mail.gmail.com>
Subject: I think there is a diference between git version 2.44.0.windows.1
 behavior and the git doc page.
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, it's a pleasure to greet you,  y was reading the git doc and find
a paragraph what doesn look like comply while using git bash in
window.

I'm encouraged to write to you to see if anything exists of wrong
typing in the git doc page.
