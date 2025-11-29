Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6701F31282A
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440924; cv=none; b=b5yUWq1P9vvK1OD9qoYz4uJI4VAKK5TlRd5Ahct9egV1LicJ9b4cEt3a/6ox3U7IOxV7mvPb/ZZpJBojXxPfYHorVE6xmq5q8C0UVPfijw5VgnswC6uTrw58bUpT8sptBZehnwxVQDc8yGHmfnKs3YT61YrgTa4c9QoYrjhje4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440924; c=relaxed/simple;
	bh=miKtS8gVeLBQxEb1qhafBvJeGFIR8q5A5wiQrIWCScE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mTfobh3dw58rW2xhK/21yV22hdDAuK0IZlU+1WKifBRU1ESh0hvOt+nkveivDVe0cah9fB3IqZuCmEZmF+vanmboeyxUMcFVQ5b6sjrzaaQdgeKSgYUFr3jwVD+Q2A/oyZkUStbAQ7zrI5leh7sVDnqu+VS6mv+VWVMTQXs1vFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da2KW+L9; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da2KW+L9"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8823dfa84c5so28846906d6.3
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440921; x=1765045721; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDI6RHdU35FaQH8EQ/fZmzFLT4U35ZFph/RzRv+jlX4=;
        b=da2KW+L9HDVRyiqfCsLjKfXwDrov0myWYUIdgFP76dby0Oo9otULJZKfTMnr+laZtN
         epH2ODdZYI7xcFNb1YPoFuFTaBs1YZ2Gq5sTeBRs5GbQ2D1hF1Kr9uSs1hlKWupSMsb7
         9bIuVG7VILvBXgZYOsWc+GP3acKHEGoponeyLFTehUp7m+dNjqSk+gzBAKxErouW/ni0
         GHpsWdkqo5ItoOXofwutpmYEr7yYYUPJPwbdVZzcxaSkBaLgyFWiwtm6SJqCNuqr6NAr
         wwxf4hU9LZJ7AWwP3d5HdcxnceidjojE0fZvbgqwnywDwj0CrQHdtv8ly9FvHnW/SZe7
         3GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440921; x=1765045721;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rDI6RHdU35FaQH8EQ/fZmzFLT4U35ZFph/RzRv+jlX4=;
        b=bQeQEITJrStc4NXDpSRO88so/HNezgGLQBZ8YiPuOAnbF3u3DcPkoWVxb3YgB3NvPe
         eH6XECVqV2TRy6NDe8pzAVv7n5t1ym2mcmbSue2QFzE9toX8nKXuzQi5pXxXymfuT7cz
         usXZi7Sze8FVkJi1MooJM05YnZzdC8pOllFyyEkX8ZE/3TvcJVo+c7pncwYE7ATlPgaS
         6rQS/QHI1I/ImIK46PDz53/8hkVR6dkmt/qOZheZFcg7lEBeHmjdzQIiZEkZaYbgAp2d
         n/4bJaX2W2uIJVsmqEiTQvAqgrdVMXQeBysYx/OihMtxKHvIF4Rqp9IwcLELvRCeA4KY
         +4Eg==
X-Gm-Message-State: AOJu0YzBRb4Hhg6ZmAYmiG5NCs6rAPTAbjFv5/WhB7XhiPRy9CbrybtN
	e540VONw+WtRxqmHWSqzA9ddc8Wfdo6ALqetzn8RZ8/j4et02+eSE/nQGdzfwA==
X-Gm-Gg: ASbGnct8gsw8TBUGPqUJ7qzZh2rJtZq68Hv/NisjjRvpLa3eSTl9za0W9f/oN4REUDy
	Qls7yv4Vud0oy72uO8C6jcCgENV3aJ34fH7SUsVEYiqKgqmQ9iVQ3kJVwxT6BA63u9NtMdQ0Tm3
	yPnaFctF5xLvW8g+xBqim+t9aqQiHHyvFshqQOopcaDYF6QKAr2wwxHnwsdibthRe8WIbVtZ324
	vZtswfcNl4MJ+j8ruWiYpI7Cuhk3rvlH2U/6JZ8YD43yDAarpVqLKQ7MWLldrkzO93o4yDIJ117
	kD3VW6U7wI2xXNPNOSp2UuQ4g5YYKybToCkjnuJ31CYUtwVgSMPMqmjHzk+hcvHozIXLNs6mrLw
	6YA4wVi7HqJqtFjT+l6mfZg0LC3xzj0caq0LeL41h/vEOv07g6zM6RutVuR1KMs8Tsl2Ejl10WC
	PiUOmJuI5pWPS4
X-Google-Smtp-Source: AGHT+IFr+Z38/v5hRTrV+m+1oS5s6wxdycwXWldp1qR3ZlyCQHD2oxdvOzQAqem4qvQp3v68/5y4sg==
X-Received: by 2002:a05:6214:4014:b0:882:52fc:9acc with SMTP id 6a1803df08f44-8847c524befmr510218486d6.52.1764440920974;
        Sat, 29 Nov 2025 10:28:40 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b8fccesm51503486d6.51.2025.11.29.10.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:28:40 -0800 (PST)
Message-Id: <b622ff822c367f20ea2c13fea7f404ea2c01f452.1764440906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 18:28:25 +0000
Subject: [PATCH 09/10] t6423: introduce Windows-specific handling for
 symlinking to /dev/null
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The device `/dev/null` does not exist on Windows, it's called `NUL`
there. Calling `ln -s /dev/null my-symlink` in a symlink-enabled MSYS2
Bash will therefore literally link to a file or directory called `null`
that is supposed to be in the current drive's top-level `dev` directory.
Which typically does not exist.

The test, however, really wants the created symbolic link to point to
the NUL device. Let's instead use the `mklink` utility on Windows to
perform that job, and keep using `ln -s /dev/null <target>` on
non-Windows platforms.

While at it, add the missing `SYMLINKS` prereq because this test _still_
would not pass on Windows before support for symbolic links is
upstreamed from Git for Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6423-merge-rename-directories.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 533ac85dc8..53535a8ebf 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5158,13 +5158,18 @@ test_setup_12m () {
 		git switch B &&
 		git rm dir/subdir/file &&
 		mkdir dir &&
-		ln -s /dev/null dir/subdir &&
+		if test_have_prereq MINGW
+		then
+			cmd //c 'mklink dir\subdir NUL'
+		else
+			ln -s /dev/null dir/subdir
+		fi &&
 		git add . &&
 		git commit -m "B"
 	)
 }
 
-test_expect_success '12m: Change parent of renamed-dir to symlink on other side' '
+test_expect_success SYMLINKS '12m: Change parent of renamed-dir to symlink on other side' '
 	test_setup_12m &&
 	(
 		cd 12m &&
-- 
gitgitgadget

