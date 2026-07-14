Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C760368282
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013402; cv=none; b=NVh1kXojptpFSk01H8cyFkWrHg3qsl99ETnEJOyHpEuLBsW9c4dGBxPauAVOaUGrGh+5KQqttD9MS2QKux3/8EJvB1WCXxdrLSGLswFdwWZESc+3ifJoXr2uoErlqIYxfQXS+o5Z8skZ8mZ31P+yDw7xWkroufrEebMBMtHCR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013402; c=relaxed/simple;
	bh=LNciG4Xbq8k4n0CrM8m5M2iAAqAGTzJsCmftMlzi6p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnKvgGo3lqBbPuYs5PWszLI2f2Q8vVrEKO+1X5QzFLiP8Y37zFAYB0QJbFnhl+avdrSXOBUM78FJjOqqgFqB5zW4Jj8R9NKjVzZ78rddP79PWfoGdocszNsVVq3OBeu/LLSzBI2ac+gMH7RrJd0Wj9QveFwIZtiEaJO9YyIpEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRi0JwuC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRi0JwuC"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceaf8a1265so27891745ad.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 00:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784013400; x=1784618200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uQWje2rmnSnmFOoDvQOjywle7MjFOSMIyJ9OJpqMCDU=;
        b=qRi0JwuCPEuYKQKDVynCsCOyNI1+9YIipT/z0nxkHXf7Jd1DctWxbvG4CYZETOoNx8
         OintUV4fYxNzTiyUmSv+JItYeQmOv4xIfyJbbCunmq2FomJz9rdb8gJqyVfQBtw21Nki
         fGVzLCOOIyEijlO3gHeuRfFyh0GlYIR73quYOOoeY+xVXDEcFYkOJlod50BpYrVj60JQ
         Wd21NDnDerofqqOAMyb1nN8Y+bzRsvDHpqvEBL7pjE2xsBOslJvnjFuHfYRj/83WyPuz
         1fiyyGAthfa08iIGxGmAi1W7XYpF2hBuCEgHjSvupEDlYB6ociSK9UHlRdNsbfOFeSi6
         qdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013400; x=1784618200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uQWje2rmnSnmFOoDvQOjywle7MjFOSMIyJ9OJpqMCDU=;
        b=YERjLXGAX06596z8p9KYP6AVlJCsnewUtQT4FJJcYsopO5+C9/fGFViIQzHSQRqo++
         qVUbYhv2/dHXFehC9P3f5ShACuzkl/QgrVXkwqDya8dw2YNs5lMED8j+RLQK1H35V+o9
         o68huTD/jyrsSbhpFrUFHNkwMNEEzR/sTgPIsQXJZ6utkZv/ihgse003T34O2at8AvkL
         iysqCX3hO7xlp2YVmKZwc9GDHWwtie7nkQ+vjf6M/r2kUnX5avscfvtcSauFmiovqHsG
         mp+qnoh1hWU5lHH89nT6J+tewRJ9ITBpr3MJiH5vcZG/TJ0sb1w/gMEMtrSCN/4gOyY8
         LiWw==
X-Gm-Message-State: AOJu0YyxjkIoANmR/EEN33andjx3pPO9CWEDlagU8KblvwFEO+3bXGCr
	PdqroaJzk8j7KSUlp+4p6hl78fHQ8ccJufH1s1QwuDbTyO4M641hdtICW0K1pzz5
X-Gm-Gg: AfdE7cmVLjmvW11mXzMYvDolMIVRxva3RBkam5ZDSa/MiPKDgm5VbPem/GNfYG5ZVQs
	joYeThUXwwjTbYgSBrLz/+Lq/Qo39sBvkf8ijascnIggKfiYP+4GvfmZV7jje+tb+hd6mNLUl8Y
	8ivyt5C+8GWoDsg28UXX3+N4mT08nQTx2x0F93Y4BbHfIu1R+by9rjkmh4b/+ne/zFsEYX/g/uz
	SzMwzgGsdzZiF2tAgA9VlnP2cvhJloYAuqx22Ji17T7oAB7TYVd4eGc+66EK13o3A9WwykNJ9rx
	phnATq9o9l/OJSrt+LDssBoPn360DiXwp/byMoc+aZzlURIhECbllejnpvtsDXjSAw1yu7/ZazH
	TzytRYJ6JPVuRFfTdqjaR3uZMqfZovKIHgxf9H4SWvQQaAwu1jh4wPKhO6Uq1IKSofw4mkS+yJb
	c7FisnEKp1ZeL2sBTXgj+ZKbkdmAOitD0x1OowmQ==
X-Received: by 2002:a05:6a21:9d91:b0:3bf:a0e5:99a5 with SMTP id adf61e73a8af0-3c35754e3c6mr1493573637.47.1784013400294;
        Tue, 14 Jul 2026 00:16:40 -0700 (PDT)
Received: from localhost.localdomain ([14.141.116.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm83465759eec.19.2026.07.14.00.16.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 00:16:39 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH v2 0/2] t1100: modernize test script
Date: Tue, 14 Jul 2026 12:46:31 +0530
Message-ID: <20260714071633.35446-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260713140142.27898-1-diy2903@gmail.com>
References: <20260713140142.27898-1-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the microproject cleaning up
t/t1100-commit-tree-options.sh ("Modernize a test script").

Thanks to Junio for reviewing v1.  The only change since v1 is in the
commit message of patch 2/2: it now uses the present tense ("is
created") to describe the current behavior of the script, as suggested.
Patch 1/2 is unchanged.

  1/2 converts the tests from the old backslash-continued
      test_expect_success style with space-indented bodies to the
      modern quoted-body form indented with tabs.

  2/2 moves the here-doc that creates "expected" out of the script's
      top level and into the existing setup test, so it runs under the
      protection of the test harness.

t1100 continues to pass all 5 tests.

Shlok Kulshreshtha (2):
  t1100: modernize test style
  t1100: move creation of expected output into setup test

 t/t1100-commit-tree-options.sh | 59 +++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 30 deletions(-)

Range-diff against v1:
1:  45f590f110 = 1:  45f590f110 t1100: modernize test style
2:  f74c71c104 ! 2:  36ea70be9d t1100: move creation of expected output into setup test
    @@ Metadata
      ## Commit message ##
         t1100: move creation of expected output into setup test
     
    -    The "expected" file was created at the top level of the script, outside
    +    The "expected" file is created at the top-level of the script, outside
         of any test. Code that runs outside of a test is not protected by the
         test harness: a failure there is not reported as a test failure and is
         easy to miss.
-- 
2.52.0

