Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4EA2EBB80
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908447; cv=none; b=gKSprorKK34WPrMMxcAX534GGw16g7dN6IB5V8b4nz9C2zHourJGU4NWVyRVlmQlLu3LiLru1MdF31ZLxpKI416kq7k6ar5rar1K42DQYTuZlbKyOxn7J80Sf/NzDTr7dTJi+grHqTpzefYgzNULVIRRMDHIV/+TPQEd8Fqy0eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908447; c=relaxed/simple;
	bh=I/xmaBiLPlBm6/T/NyH9GTWq0g6WcUdGGd82LybMk4Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ET1xjp7oKw+JVVlrgqxZQ8CWlx1BEspkhgWPlmeokpJJFrC4GVdpu9Opz9crxwzgWWRW25YJVxCE2oCUvkezvc5pJAGrKbG9PGyhNj366YW7Qm2/ydc+IqKME96uPIQmQELY+7gqr4UBeA/LeS9d9L4VBLP+tzvT8B/uKKS6W5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTuFdJGR; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTuFdJGR"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4dfd1f48d4cso50347191cf.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 00:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759908444; x=1760513244; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/xmaBiLPlBm6/T/NyH9GTWq0g6WcUdGGd82LybMk4Y=;
        b=dTuFdJGRbKahugpS2yNyzbCYVsg3c0WSrrKL0fEJQXhclmArGxBdrh3JSxSEHVLITF
         DoevDWRuy30efXILwapdQoCzC2BTd/Jr79kBv/5N9UQwJ1mFe71NKC7aAHrafX+7Yi1m
         z0DZaUDBQUI6zK+YJY0yLxCQFCPbEYARUrQhRLg1p4+tV9kagl9JWVH9EXn+5HQVbBCZ
         0gFFv24GFu6atqnX2eXSuFkLNEqZTm8WqPGcMGKoQv1lNBkJR6/ovkzyAywTgTNUY6wC
         cShjwVpLLRndK3WY+kIF7mahjPSr+iWbhdlgXuI4Am70LSySYIh3qSm26khUAI0l43DX
         HhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908444; x=1760513244;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/xmaBiLPlBm6/T/NyH9GTWq0g6WcUdGGd82LybMk4Y=;
        b=Bfo7D4jXZst3xGGm5BoRveOQmgXC6qpsIXfi6dhnr2IxlRjabNSRyHkCs1sxglbz/x
         5dLNbROs8c8s/e9357X0kmZh+r2vj/I9gjnQ0J8WZyHd2tVs7FK4iuRy9cH9tzWdnFja
         UHdYry97srP+pi9tV8EMPq78YjbDRrlV0ZHPNkVueU6OocHAcdRlsckAQmE3Y6V29pdM
         kOEUqkclUSPD+Ql4X9ltRbSb7Mhsn9Q0O2ovwjl1mJIsHKTkY236PynFRyMeonmt8fj5
         RjqBccIIY6POfmXE1rBgO746n8PGzx/r3eLHY/uZRN+irJQNOKUc4m1MJ/tOD9mpB8KD
         xQwQ==
X-Gm-Message-State: AOJu0Yx8EFi5/HJnKK8KUZ7zXwQtcTSAXW4nMsJKZmXyvmOuxjAZMydA
	H9gM1wExxlpE/5WK/qDPRX10dA43/7saemGRYVmrnBZQbQn22SKaCcUuwEacn9pZdtrOjyTUHqr
	3MunoJ9RfUD+d/nVCQDwxYuY/J1jtd/74eD0vxV3s02/w
X-Gm-Gg: ASbGncvKP4kpOmt7uKw+fIdMd4DZZGYTwgLltivgPJica5oDJCn4Q2QXfV+XhReW+e2
	l1wa3EU0mdh6UT70A5GxFmblPBHgsRVjxqWY+On3tzBwO5+yk7bFxFrHkeRZy1IO5KlXG3tEbNq
	yf/CuwucYuk1VyMXfaKlwSCuGcF19LpZRs5wCGGZfUrE1smcdERkLgKxcM7WRX1oxcaiqpqWhxn
	TBkapr9lmsACccb4yMiby1vWgKXp+Gx5i1f6uaxAq7xBKxwq4++mkA9Nss+WeMhIpEI
X-Google-Smtp-Source: AGHT+IGcG1uFNQHKpd9TfZZdOvuJ5dfhrGurEOTlrmO6WZGz0IzmGUL6RBF3+tFzFG/UpLESWR+VjPyJGw3W9hFZHpo=
X-Received: by 2002:a05:6214:2308:b0:79c:1b67:2cbf with SMTP id
 6a1803df08f44-87b2ef7a5d4mr26004626d6.61.1759908444354; Wed, 08 Oct 2025
 00:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 8 Oct 2025 08:27:12 +0100
X-Gm-Features: AS18NWCpy8_8U3E7vj7zePoFAzuYjXBaDABNbrt-m5EqPGYOevDKGKUnel1zSCg
Message-ID: <CAFpMFfDMmvbKMNGbmqA=d_+x48kiefT_SGQ3M9m8ST9871UE2A@mail.gmail.com>
Subject: [Outreachy] Introduction - Rosemary Ajayi
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Git community,

My name is Rosemary Ajayi, and I=E2=80=99m an Outreachy applicant for the
December 2025 internship round.
I=E2=80=99m interested in the project =E2=80=9CRefactor in order to reduce =
Git=E2=80=99s
global state,=E2=80=9D mentored by Christian Couder and Usman Akinyemi.

I have experience with JavaScript and I=E2=80=99m currently learning C and
exploring Git internals.
I=E2=80=99m looking forward to contributing to a microproject and learning
more about the Git codebase.

Thank you for maintaining such an important project, and I=E2=80=99m excite=
d
to join this community.

Best regards,
Rosemary Ajayi
