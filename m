Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C41F472E
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741899864; cv=none; b=HH+avEDOXWGXIcDnzfttDuPPQR5lAUDieMdRH5QiwW6urVKVRGV3Vop3wk8dD1NbGtqElj/6W+szxWelrSMItDxUvoy6oqwpuoUtRwjVBTfG2IwtWgX260yLyUJVtYO3zWbxzpjC+hshXv/YQnTjHZl4RPeraTODLK07JR1lFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741899864; c=relaxed/simple;
	bh=ZOfidTGKkkQyGmj4IpOeaXoI4fWzC81dJ653jIFJB9E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=C6vb+ZXUfYO2CkXxuWrVTj2XxFYdf9hWbIzsoWDhixofLWcpAmUcNBR/2/COcKD1QYswhEu2JrnyeHbv1ufL83GRxAdNFhR9HVacNVdg2dXrP/oSWM8OsDKcIIYsDtaKSj5JzotsFQLJGamdKtmyUGIqVzELt6NbQF4lJn4wjHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZuPnNgo; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZuPnNgo"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e637edaa652so1219678276.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741899862; x=1742504662; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CLs/Sz6tz+GQosEUz7cClU0+aD8ht+UKLz9ka6JMchU=;
        b=LZuPnNgoxpP6sCXzuvWfs/K8nRwZJKnR4kihmFPo6U0uV+lbuunYwzIDWfrckQ86ss
         l+oTeBnNAt+qx1OM+4lHfZBthU1hw4EXsjhIwIBN7bnyRzl5/L19TVcezJH11Z+NIgd/
         89fMaA+Z2Zbbvmx9/8Wt1mR512fHjtGxpzYknM/+JOzgUc/d+q9ZW9o01Kc0YriiNstB
         O3RBvb4UUPstyIv32MEQ6LUOgsoTIzjMZKgSm2rJ2U4yrVxAcenAHlxoK9AVcCFFB6qw
         JGx3FSHqqmQxqS7Aln/NajXrvuRjbl12IQY1IhowswEpMB/0cbDX7ah8HQ60GN3k0HS8
         EkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741899862; x=1742504662;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLs/Sz6tz+GQosEUz7cClU0+aD8ht+UKLz9ka6JMchU=;
        b=D6cKOEMd8SMWJvBCEJfu5nw3eBeDUqKLMotrkWcnVWTy76tfwm1dAqYIHv74fdm/EG
         zFNDqf3qAlXTJFKnSAXVlRyliR4MUQ8n39RoUFWQpRRq4LJbPe278efwc4K9jjDjT97C
         B5qVKg2tRcB4DygMqqjAMsvDCy1zTluZCnR0cKk7A6HrUI7u9Z9egVILIQ5x2MnHD2es
         7Hz+a209GZNAXkXKlvcFe6Dtp8xsb12xrfJezr/0r1NfFMFt5IeI2VwWS7H3xYIHgrkm
         DCZEloH1qmHhkkSLDE0FT7KtKkT3R2JRhYUBNpNkfs6wbanmAyHv4ur91XJMXk0nGSYL
         qoKA==
X-Gm-Message-State: AOJu0Yxqx+/+QOFyVv2v2EambyTvvOB0jdIwg0KcDxyo7RKnfcC2c+o+
	q1jDWs7/+l2V+D7klY7htWRQq70XzPhoZKJDnLytI8uIvRGeYHr7MVIRSmBmnA5hbwHWLYzSk0F
	knwjm3UkwRBUYdib4kQCJ52mw7QmQWerzQHU=
X-Gm-Gg: ASbGncsxINVNna6M2biPKhAulYA0Xh1fxIdOvHCl32CbHWcGv7xQVxKU4GKXGFgo30n
	mrywsQleNeGhfU49tq+UNU52Rh4PchEOl2rjNOAB2mLNMYKxTj0YcXMD3is9rpEcbndQX/WOWUR
	XhyvpODpISKC1+wPLOa8Q9rUO1j2E2rkIgry2G4Zdd2KmbPC9YRZr/gVO9xiA=
X-Google-Smtp-Source: AGHT+IGiIbOrXGvakrBI2dIpeW4tPEkFKfK7nkFYeOYueR07fSY1b9Wv/LWNvNmxbAluImLxzUCVDMYtf/vP1lWvKs0=
X-Received: by 2002:a05:690c:670e:b0:6ef:4ed2:7dfe with SMTP id
 00721157ae682-6ff420baf9cmr16801457b3.31.1741899861885; Thu, 13 Mar 2025
 14:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Fri, 14 Mar 2025 10:04:11 +1300
X-Gm-Features: AQ5f1Jpio2CSg-HOYYWZOCK8LvfZ8TRNPpZQR5Pa__AA1FyYD54_gYEfLAAoPn8
Message-ID: <CANrWfmRq=7Q=vCPgmcLcek=fRsw83BPqTX7gTpcLb=JpQpYZEw@mail.gmail.com>
Subject: `--ancestry-path` documentation has wrong graph
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Git - git-log Documentation --ancestry-path[=<commit>]
https://git-scm.com/docs/git-log#Documentation/git-log.txt---ancestry-pathltcommitgt-1

The graph for `--ancestry-path=H D..M` should contain commit C.

Code:

mkdir --parents -- './repo'
cd './repo'
git init
branch_default_name="$(git branch --show-current)"; echo "$branch_default_name"
git commit --message='a' --allow-empty
git checkout -b branch1
git commit --message='b' --allow-empty
git checkout -b branch2
git commit --message='d' --allow-empty
git commit --message='e' --allow-empty
git checkout branch1
git commit --message='c' --allow-empty
git merge --message='g' branch2
git checkout branch2
git commit --message='f' --allow-empty
git checkout branch1
git commit --message='h' --allow-empty
git merge --message='i' branch2
git commit --message='j' --allow-empty
git checkout "$branch_default_name"
git commit --message='k' --allow-empty
git merge --message='l' branch1
git commit --message='m' --allow-empty
git log --graph
git log --graph --ancestry-path=:/'h' :/'d'..:/'m'

Output:

* 9e6572c - 2025-03-14 09:54 (1 second ago) m (HEAD -> refs/heads/master)
*   9598130 - 2025-03-14 09:54 (2 seconds ago) l
|\
| * 3579336 - 2025-03-14 09:54 (5 seconds ago) j (refs/heads/branch1)
| *   a144397 - 2025-03-14 09:54 (5 seconds ago) i
| |\
| | * 721743e - 2025-03-14 09:54 (8 seconds ago) f (refs/heads/branch2)
| * | ceaf310 - 2025-03-14 09:54 (6 seconds ago) h
| * | 30e22bb - 2025-03-14 09:54 (9 seconds ago) g
| |\|
| | * 0f44e94 - 2025-03-14 09:54 (12 seconds ago) e
| | * edecedf - 2025-03-14 09:54 (13 seconds ago) d
| * | b4c952f - 2025-03-14 09:54 (10 seconds ago) c
| |/
| * 11851d5 - 2025-03-14 09:54 (14 seconds ago) b
* | 70c1b91 - 2025-03-14 09:54 (3 seconds ago) k
|/
* 029edb2 - 2025-03-14 09:54 (16 seconds ago) a

* 9e6572c - 2025-03-14 09:54 (1 second ago) m (HEAD -> refs/heads/master)
* 9598130 - 2025-03-14 09:54 (2 seconds ago) l
* 3579336 - 2025-03-14 09:54 (5 seconds ago) j (refs/heads/branch1)
* a144397 - 2025-03-14 09:54 (5 seconds ago) i
* ceaf310 - 2025-03-14 09:54 (6 seconds ago) h
*   30e22bb - 2025-03-14 09:54 (9 seconds ago) g
|\
| * 0f44e94 - 2025-03-14 09:54 (12 seconds ago) e
* b4c952f - 2025-03-14 09:54 (10 seconds ago) c
