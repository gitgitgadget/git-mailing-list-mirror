Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8876035
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675763; cv=none; b=AtqPy7g8Dpj2YkT8hlNZOpdC8+0DQ5jPUZkWNjUkOvVKlAHVqud9HVU0Ksp25tROP1Qq0k6z9/mAuhOz5tZ57RbOEEFdOQ2uUvQJmfVjLsiqcj+G1ZhuaIsY7HhoW6f9b1frs2E/8Xa3pS1k9ELHJo/kVGQiQEjS5nEHX3HMBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675763; c=relaxed/simple;
	bh=X9W9q1iT+aNSznt5TEntXr4QSksdjCm/dQI+tG+meso=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LcYA2Odm2Sj1T6YgogHS59VGEQuOaFl7czz/UA4XO3NQUQ9uCtclYSoHj7BklZDpScgVltmvCSAeecjf5cViRW/QQ8hDR0DpexOEMIwH1bYjnb7ZsGWVw1UGYCNqAPRV7A1VtfqRaHcqPOldca23JRJBLs7ZqKDFHnhVwg49RY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEeq2EGt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEeq2EGt"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso263413466b.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731675758; x=1732280558; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X9W9q1iT+aNSznt5TEntXr4QSksdjCm/dQI+tG+meso=;
        b=SEeq2EGtul6L7j0dXY508wfuAqv59D50h5cF9ulTpxc1F4GKTkpalCdQWnqi+cFYoM
         X1HLyqBPeJrA03wWP32FOBZNdOCrCD65R6Pmh1qqdxrNB9wEBW2V2PQtnp146EhEPL/k
         bdZKwcp4krsPMJRJmgbST6A+vhZ0lQOGzAC4EckkOyiv6seVEN46X36BtJeMBU4yXy1D
         C5eyb34neW4/zkKuhjRomyVTOzSm8EgTbUtNvuwmF2N9EvJa9VqvczBtPUqztd0pnkSl
         wzIUzgoX/BdlELsEP9j2e/tdIfh0msEhtBSQ0HBV7URGg7/Y7TQ8WGtKEY8h7IDazlvL
         ibHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731675758; x=1732280558;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9W9q1iT+aNSznt5TEntXr4QSksdjCm/dQI+tG+meso=;
        b=Iu7ya3lfOTUW8eMWcq9xyZ2+rKCSBxE5X8RxuFbCdHKhHAUhLS7CwIvqZNv/iGGBXY
         D12rtfVx6NPEzbp+cHnr/Z5RCnizbSh0OPVLQK0MXunsLk+SEfHyOnhfcwcApVROdKd8
         7yJpnVxxsSQ69GpQ9pwSp7V0JOMLVtq+hPSqPSdFhKxsEuIFoaqv5B2Dnh1KVjRN2n6u
         IJ5iB5xo7t6JfUXyp8DxL4awmp44JNmDzosZVrOcVO3OK1F4f1qMNp16S553Qgqa9KS5
         vlZJsBqGfraelx5RAMqk0cUFhWwVE9XMT/+Tayn8wULdiAVyskG7ucqoQtp7SwCRzjMn
         cKTQ==
X-Gm-Message-State: AOJu0Yw5QcM358sZe/vxKbQp5wkOA0E0c8JX7Ewzmq9wH0ehG3oY9hlE
	1WVQT9tEKckYX+amlP4LSejtj52QxmgHxTMDLnwu70mUlgwseioK6IlhzUutrniZG0cZX0tdyeh
	ToBWKxunEvxUW/KbyIzFWsqH5xjLZ2uYIFJuw2g==
X-Google-Smtp-Source: AGHT+IHzlHCJRsyBSNTtIa3e475lbOXAQnZ0H11uUAl/PudcnVSH9w/q9cA7TGSR5+LRwpgKued980ydySijH7b71JQ=
X-Received: by 2002:a17:906:f588:b0:a9a:212d:4ecb with SMTP id
 a640c23a62f3a-aa4833f6c5amr230988266b.12.1731675757729; Fri, 15 Nov 2024
 05:02:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sachin tiwari <sjtiwari007@gmail.com>
Date: Fri, 15 Nov 2024 18:32:21 +0530
Message-ID: <CAGoMMr+f4oqgDqq_1h4cV39GVRd8fgzEzHgBP8fJsJ+HAgiwqQ@mail.gmail.com>
Subject: Bug Report
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sachin tiwari <sjtiwari007@gmail.com>

18:28 (3 minutes ago)
to git
Hello,
Title:Git Clones Repository Even After Incorrectly Inputting Personal
Access Token (PAT) and Leaving Password Blank

Description:
When cloning a repository using HTTPS, Git prompts for the username
and password. However, if a Personal Access Token (PAT) is mistakenly
entered when prompted for a username and the password is left empty,
the repository is cloned successfully without any authentication
failure. This behavior should not occur, as Git should ideally reject
the clone operation when a PAT is input as a username and no password
is provided.

I hope this will explain enough. For any more information , please let me know.

Thanking You
Sachin Tiwari
