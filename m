Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF441B040B
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753543413; cv=none; b=X3szZpc+iCtmrDx5GiLJw+4UpGSDsJD5xrNS5uGeIjVrRWem7zV/SV9O6ibCSpaLKIzXnJSTivaajuM0b49zZig1ooq+fS7ioDPUaRNoLKY4Il7W7Rsgr1zkQHy0xMyDL9BbV+mrJQKkVvCvVZJLi76F7Lb2gWRplont20uajc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753543413; c=relaxed/simple;
	bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
	h=From:Content-Disposition:Content-Type:MIME-Version:Date:To:
	 Subject:Message-Id; b=NGmfVa9KQhI2QeRLH/FGHs1SvThGUCLj7ZB/cvEVAOqyga43XvZdM7eegy2nq/WW1pcUBqFuk681fcCySjM0rQZQIYWpTuBGReukCqqlv3nT3u+qD5K8HkGGHonHYQgnq8n2kPuaSsDU9e9D+7gplbc9eBdvTH82nVVMkWX52Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9lBdyij; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9lBdyij"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so16840865e9.2
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753543410; x=1754148210; darn=vger.kernel.org;
        h=message-id:subject:to:date:mime-version:content-transfer-encoding
         :content-disposition:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
        b=J9lBdyij20nTJyRKylfKEGhbTSJw1vIyyaUCSkbrSzhksfnaISHB9mUcXnbYgUDi57
         ePVSKUbPS9uTF0sZVONugA13kgncp7j1XF88oFYjzUftJQwRVpBxzHytfUseQ34uzZxR
         gltcHwBl/nyH8EXPvYeOehR5aG+yKEAcQcl4/ru17vhRi5wF6N4gh4gTm0KZzAZuAXvI
         z21t7U+P6bqE0tVp3yDFCfKVqen6aDwwomv+9JpE8+Y7jdhSx/h/czRLKFcl4EfefyL/
         VFGxPEls5x2kgEzH9yCyptd562ryBR9g8J+o8cSwloVIpBPDDVj85ckZ4Yd4gIOa4gbD
         l+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753543410; x=1754148210;
        h=message-id:subject:to:date:mime-version:content-transfer-encoding
         :content-disposition:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
        b=BZgBLTPmjYonpQKWO3Yiczwb43ULFpA7RKlG45BYZyfLdFWlZ2Im4mXvOXSyNSJrTJ
         aT4pDGZqZgig8knxPhufkUcZriLs2MsCgF5s7ygNO5w9JGWmGhOO5+0727CGZ+fzS9Hk
         vz2lkOEoAckw2xB8b4E9jVqPJPDkHdadhUcI+DqNINnZyX17sCsVOgGs8qvF8rSr8IG1
         tpsZfocqwJb3NnWIeWUv6oQoQf9KhDPQzEvVZo3qBgaHlyQ9J/RtIzu3/n4IPR5np9sK
         rup4AbYv83BvbtMy2sG8SMEfunY/5BQTDr9tLYVT3gNDPu7lXX0FHMI5x6qXc8pv8hWm
         TfrQ==
X-Gm-Message-State: AOJu0YxV3qEWdH233K+5ZW6RkzayQfaKsY4zKYBt0nmdYwxPP7ebHZCw
	kK0E/rrwJbUSFzlolXtgchoymur2AxquxmGbey6vwQlgn+oyx19rsCqV8ScaAg==
X-Gm-Gg: ASbGncvmo7ZQLEvJLizK+QpNzprm17M9O0TaWoN7ruCQeP6QTWWjgjMYwZqzLfT2Srb
	5qknwEhylA9IKQQ6rzW/UbXUSHwsjVEA0ESY8MDEih99YcpdIHMY9WeqcundOoOh6yWgEyOH3NR
	9UpDLSAthhp87GKYy+VVN6Rl1l94P1b4fa7BRGjfE3alFfftyEScJim7LD/KwL1oyFvzenoxGnr
	8s/03hLw60PO9N0oAobV2Q/wLSQK5+y0YZzqv3oDt/sZT5+W9jT9uhp8jGmZMFX8cRpTkJjYpX1
	MueGCXvV71w3xx7eHwzzwCA8zPNYOa8RL6efF5g41W8uTRwlXZfI67HtRjZb5Q7CzpYz5ZR+78M
	K461zPJOLV7+LOnFUo8KuDccSI04Mi5KCnBuxFfleo+2E88u02m89W8Re/zC1moLDY7vkF1qw
X-Google-Smtp-Source: AGHT+IHf4Wx9wbzrwaEGUyY4dXNBoyfhrkZMt2d333YuHIoWib+iYWO4i3uuKlSugX3tx4HdbLYHMQ==
X-Received: by 2002:a05:600c:8412:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-4587d76cddbmr16623985e9.7.1753543409848;
        Sat, 26 Jul 2025 08:23:29 -0700 (PDT)
Received: from localhost (92-184-97-145.mobile.fr.orangecustomers.net. [92.184.97.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705378f4sm92862535e9.2.2025.07.26.08.23.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 08:23:29 -0700 (PDT)
From: Victor Duprez <duprezvictor4@gmail.com>
X-Google-Original-From: Victor Duprez <duprezvictkr4@gmail.com>
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Jul 2025 17:23:28 +0200
To: git@vger.kernel.org
Subject: [RFC] git-secure: add explicit authentication before push or clone
X-Mailer: smtp-cli 3.10, see http://smtp-cli.logix.cz
Message-Id: <1753543408-749582@smtp-cli>

Subject: [RFC] git-secure: add explicit authentication before push or clone
To: git@vger.kernel.org
From: Victor Duprez <duprezvictor4@gmail.com>

Hello Git community,

I would like to propose a new Git feature: a command called git-secure that=
 prompts the user for authentication before executing sensitive Git operati=
ons such as git push or git clone.

Motivation:

Today, Git operations like push or clone can be executed as long as credent=
ials (tokens or SSH keys) are available in the environment. While this is e=
fficient, it presents some security risks:

- Users may inadvertently push changes without noticing.
- Machines may store tokens or SSH keys in accessible locations.
- In the case of theft or shared systems, these credentials could be silent=
ly misused.

Proposal:

Introduce a git-secure command (or option) that prompts the user interactiv=
ely for either:

- A GitHub personal access token
- A simple password generated by a secure third-party password manager (opt=
ionally linked via API)

This token or password would be used only once, then securely discarded fro=
m memory and disk. It would provide an optional extra layer of control and =
security over Git operations, especially when working in untrusted environm=
ents.

Prototype:

A working prototype script is available here:
https://github.com/VictorNafs/git-secure-hub

Example usage:

$ ./git-secure.sh
Enter your GitHub token or generated password:
GitHub username:
Operation (push/clone):

Thank you for your time and feedback.

