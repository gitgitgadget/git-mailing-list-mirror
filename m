Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9315665A
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984789; cv=none; b=J0kcltu7irg8JkPc5WCbo2aKUBa9Bze5eeP0F0ubhW/Bom1h6a5/HMaShPxDSh5KrbqcGQoVPDT0ceOHM3pbdQIRVgnyO7evArhWBd9iO1lXpwHUZpO6Q+jtXDZFJsxeHf3YbM+ZSYQs3il2wnjp1ut9uk/7Wt5fway7KYLenQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984789; c=relaxed/simple;
	bh=dMNNZKW/hwK0W5bb78cAkZYbebvauKYWSYzLab8O7jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgK/UT5k5ywGQmyV19J/1DzAUdhyaWgX7Kqc+b7VqC88nDA5uZ9hk5na6PcwQ2zCVHiWCqJK15L8g8B36rcogRqqi4hWRnX6nO3PaujK/k/LQLx+YN8F45lP5dhETkedqQRAn7c/PR+GJ2aY2EfciXPQcdNJ2SNy4NM4Ixb02/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akRvJbmk; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akRvJbmk"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c1acd482e4so1180810eaf.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718984787; x=1719589587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEUhrcGidqcVbEuaK9o8AD6BCimiBHJ8OZqzOIIHqK4=;
        b=akRvJbmkCA2/sVGFFYaPtxHj7Vb4t47UO5nnpQio4t0FQ6ODpalmR5p5/V+FZwyM3X
         00kXE3qVNycuBCM5zPT2UhoQtBlWdouddD6vxOzVChNe46mnjZpjeA0bcs7R3TCnWNC8
         PEHi5pvO8yKK7uX8tTA37GbpIhN+sBKhfoT/r35gkKYZRj975/IaNhoBlbcP5TQWzh9G
         kk0GVYy5bpo/EuGWLxqjMhbxfne8FnkE7HM3Tj81MPOYtEv9LES1JMGTWbaXSVgsWvuu
         OlUuS3nDIUz+ZVrbepXamujHDQ0KNCIVHofDaxBbdLBVEnZwtrz7lbGCNQTFm8JI1ZGc
         ycNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984787; x=1719589587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEUhrcGidqcVbEuaK9o8AD6BCimiBHJ8OZqzOIIHqK4=;
        b=XZMw6ANzuWfgSeO8BobZV4Ziu27kILhoVcBxH41EYY2hL7HE8Qkq2AtO1y8Qdj+dyJ
         +pd8IAl7H9x74gIduOnaiIKQzvrdU7cMHR6ziq8TW5A48aLemCU68fUYBKaWSODHvTXp
         7PeY2gBTemPbO4DFxczOoIwZWotedaH9n2jvEIJVF/Hkoew4Hv4zQUgtwY9PRyHI/TTU
         MTCMlAmvn0blEQjvQ63zvxFymO26CjsD6cpAjrlH6BfO0nm3+Ht35cV6ZaTUWR784/DC
         JthjsplPg/PWRvG067E9j/aFIxguHfMM9k25XLOEJb3mXl1VruasuW8dvH7voZHtiD2Y
         7N4Q==
X-Gm-Message-State: AOJu0YxNYESMXNKHl+tSGeSRMNzhdy2akpBEOMZJmazikuYtzokYnD3I
	FjZj+pPEsj3pNWkuiSPSwIFELB9xn6IfXgcZi5LH0/iin4+mthBhB6uYWA==
X-Google-Smtp-Source: AGHT+IEVinJvZjmnG9LigazBEzl1DF4EC2HTpI4AoJ2V+k8w7dPGx6eoMDtuiVJeXR5I7E26pnl2dQ==
X-Received: by 2002:a05:6358:590f:b0:1a2:991:a3c6 with SMTP id e5c5f4694b2df-1a20991a43amr743194655d.29.1718984786741;
        Fri, 21 Jun 2024 08:46:26 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:3f9b:a900:bce2:445a:248e:77bf])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8c3780sm96027785a.71.2024.06.21.08.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:46:26 -0700 (PDT)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: [PATCH v0 0/1] Teach git version --build-options about zlib+libcurl
Date: Fri, 21 Jun 2024 11:45:51 -0400
Message-ID: <20240621154552.62038-1-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simple series adds the zlib and libcurl versions, if any, used during a git
build.

As an example, the following is appended to the git version --build-options
report:

        libcurl: 8.7.1
	zlib: 1.3.1

Randall S. Becker (1):
  Teach git version --build-options to know about zlib and libcurl
    versions.

 help.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.43.0

