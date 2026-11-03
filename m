Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741056;
	b=UDlvqaoVzf3vUvT7NTe9k+m1Ubl4R855icIqVUZ46+CkIn7s9J0XJZs/uYVLAvB7CEEP
	 LgXSR4XeCoFyliIR6mQTG3NGPpwtJqaD5Z9PopimKeSGRFSHP4iKdWM8BJQRV914Z/+N2
	 9MazeXiunu3SFaq68PTWKYXaxivudU3wF/bUjonMe119L12JGOKiJtQl86VJXSk+mb7aB
	 shrMePPlUUo0PJmTevqYJxqbMctiE73/094W930HHum92dQSzj+2/dD2tkc6FVVrD5o68
	 T/V2uPHD56pQhfzm2aK6cmAkfE2BEwOvev3yElazSN9q3xs/7/n1bWq26LGyn+KjRbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PCC4NGhVNXiTfK5WNBjWZEI05BK/wFGNiH8Ucdfrtj4=;
	b=QHf8/7DP1LZs5mHvdv6/qa+o/4ob6thk0tWOXilryky9kv5h4OKyFhl/Nn/r3TjZVou1
	 dwbyoBdHKti8zpGEWZI7Xz4Vi0HBYsOzIxCeJPxg+BaGz67SiMPoZXWXIaukVQKPyuqhV
	 +0DehY0wyEBDQIvCBIca5j5i1VOgHemYCRCNAasA/eT6hgYjpkIHjWr8jDYoJu+qD8c9r
	 AzFN0t5yDOShTQRmBUE1BN7Sp7ZKuQOJmUUtu5hHjUWx8ZwNfHRB2G4RzVNePiFOv67+b
	 AFYlinwpVPL0VAgIyggU6UShHipOR2HgF5YpG13/uvr4b+Wnij824M3ovc4O36Rr3AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rAWpxHAK;
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C2606A32D
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 21:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A3C2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rAWpxHAK
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4f14642adb4so35676b6e.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 13:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793741055; x=1794345855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PCC4NGhVNXiTfK5WNBjWZEI05BK/wFGNiH8Ucdfrtj4=;
        b=rAWpxHAKImn/HDB11ZyeI3zjyQJrykkdrAALWE47h7cj9KdeSU7OIAnRIuALiJxRyH
         J9Y4KNQ5zZdAtEg9OhYcu+cLJwO5xYyzY4YEUSxgPB3LuXjbU1yzsBVx/uimB1XYR+Gx
         j/vikAzm0BFDP6GS6qL6MDLjtiBTZol9EDm4I9gHd+NP3lo5CClIYn7xZJhgpypCLaZ3
         SKeWQEZ8fyuPa2yztfI0VKuSrort3F8PtD3+KbzhZTlg6yiZXsg4M4qKCjejR8mU6kEJ
         o2vIIBZKIY9Rwjt8RXSSW6q7rIYG5mpAKnczMcg+hX8p4uGlBH0vDtb33dQJRj03X5/z
         l7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793741055; x=1794345855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PCC4NGhVNXiTfK5WNBjWZEI05BK/wFGNiH8Ucdfrtj4=;
        b=bSHYByqjUKxEiUhmTaSo7GlumUqNzqBQVffhBeCrSoYZo7HbwvzmDPcZrjpbY5gcyv
         DUA4aQgCvsDjF5wpK/HTDCqDSOcKL+don0ePwPuqpKhyzVncLpWQ6nmfMpXPwSIyqEIy
         pNlL6eHET9x2ViYTugqk8pkf7AFo4Jd2LM2PjP5yrhXHVT98EICc1G+/Qkc1sE8/ikaS
         gREI446q/2nlS3DeI9V4XiOOc4Dv1NvR+Zv7ZqwiEHffpfFtx6SDd2cP3bocsCNvY4eH
         Eg6fHZwYo3/3pAWsBZ45pfIeUCR19RH/EDB//W5VakGt+sROqVHdiD6zNogE85CWGeXl
         iqjQ==
X-Gm-Message-State: APuU4Z9pFrS/yd2K9hJDZY/5Go3WAAmcMb+lCs+ECOiH2V/Q2Lsyk6a3
	wA06GkceMRhA77idl3a85Bbh/4iBqENVSaETcnSPs3J46LnXzo+01vUCFWTJdw==
X-Gm-Gg: AYBFou2xNdV4l9humxfhUxbJrPuHAukykQBibCvyHzE23AmHSgm21iskF4RmUFzgWQF
	olllnEMtEtOqoJbqpYEzYy1wcMb+d8RLCz+JiumNv0axLCd1KFtqZ77KGin8yPXLPAyLYdoIhkh
	RBhS9gAB7QSQYcK95AqlaMQ0dqsvir/tXeC8yRZRToZqtO+mAXJssRXNkcG3wWJQ9rCY0EeboTv
	YJK9zTm0n9VPCqrbb0tv2I6Wx6Sw5GeZDX+0CoxDkj2ypZT+6KjhcVdXv8fXY7D4ql+X5LvlY25
	5LKban37HPUSaYJcaSTa5QDLKxgx9dkAsjtGTuobxo3WtIVyceYdTM0/mYOHnwJI69O9+IrRGaL
	EQj+tIjVg0phQjQG8EjjbT8XwC88iZs4+SAuOXzKojjiohB2cQEfGn5B41mNsyIEmXyEa6J9kkE
	XVwMlNQxf/keD8lIesZdb9jOupVW/WtkuKUSBtoCmUAi4DkXvS5kvwO7rn2aE3U6OBts8GqsCUX
	tdhyYPPjjEqf7hvfHz89cc+leb0AjwwjQp2tiq0MBAWZ8skpPzH45v6JavRXy2oOTWBpP04pif7
	57RgPK5HRQJbIYPrTumdohl0ec+H9PEAcAui8HiB7OgBOHHJX/HSa488PeHGtjKAM9nt
X-Received: by 2002:a05:6808:c3ed:b0:4cb:818f:d571 with SMTP id 5614622812f47-5640df3d5aemr10238928b6e.25.1793741055116;
        Tue, 03 Nov 2026 13:24:15 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9c7bbcesm15628b6e.1.2026.11.03.13.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:24:14 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/2] object-file: small error handling follow-ups
Date: Tue,  3 Nov 2026 15:24:08 -0600
Message-ID: <20261103212410.1389988-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This small series is a follow-up to jt/odb-keep-lockfile-fix to address
some feedback that was submitted after the series was merged to next.
Both patches here make some small improvements to some error handling code.

Thanks,
-Justin

Justin Tobler (2):
  object-file: warn on failed unlink
  object-file: return error on index-pack abnormal exit

 object-file.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)


base-commit: 750f5de7dfe9a4062f95088212b063f189d50e91
-- 
2.56.0.173.gf57c9a7388

