Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594A41B7E1
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251221; cv=none; b=r8hswQbbArYsQEQnCnNsQGn5oQ3JpKE4nRqS6de3f9XXOMHXpi1+KSDbVSf1b1TlB3chGdZQmw3i+jeIr1mWoB+IKmlrGUifN/B9NLbbVjho2sO8V8D/fyAnezgNHJoAY7kk9uMCr6Kdd2+/KPbh7cJr6PDw5ECakOChAbvaBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251221; c=relaxed/simple;
	bh=9Jt5wek2lIBvusAX+n5BnYTBdtkIQjAtjJPb/OIu8v0=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=K4IkgqP/bOCzbOy54bJ4Troyi8CvtRILCcplaewjMb6Sm3xNoxkEoX7/QA/t3TveuzrYweotBJSmD+uvOixA3hVzTN1WvsZc3EXzo5Xad8XEwlHtSArYJ5MfkRpobso0bO4GeR4Kzwdmvrk5NV0zNFU1ZcNaBKhU+RVGZFuKYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Otc25koF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Otc25koF"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e05f6c7f50so545087b3a.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 12:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707251219; x=1707856019; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Jt5wek2lIBvusAX+n5BnYTBdtkIQjAtjJPb/OIu8v0=;
        b=Otc25koFr33quQy773SAXTAl/9D92kR+D6vgCg2cAiXyF4fISR2jF2m0PC5/lopP/F
         rRLKIcLTw7bw0lALTf4cMOb6QLYaJrO6bpjbI1cZmpjVDf+yCd3d8FivYgF8JuJGAGvB
         cNge/0+3hZMq60est88i9MLIO2fhQexWCKV2wx4BDJkmtQ0EMzu8omzVkhO8tYg8KGzX
         GcoiC4EMiqOlbi1IVjGY6bHYXfSEKYUg9X3KAvswAr/AE3WV8knt0lA44iHJUZ60KAph
         w69wY6L24roYPGPwIqT8cZ7ry0shWTpd+1Y0b1fgL/joMVt/xbFUqQoaGd4XQyaslcQ5
         YV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707251219; x=1707856019;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Jt5wek2lIBvusAX+n5BnYTBdtkIQjAtjJPb/OIu8v0=;
        b=roorb38kwapRZY+i1RaxwC1oihG7b0U96zVVUnM/6TK42O4NZG9gOSfYDIDcguw5ZD
         m5437ny9nZO2S5EIcuPbPJ22mZcKZKQ/dJn3N5VFlc93LZDkWfCqCditz4RjIp5LUf+8
         Jq1dRjw1iskshO/efzVmp3l6CIFtorPmVnMiHpqwe23ynbXrJfjWfHiQyD0GyQhCZn+r
         AAD1hDoREZgQj0lQeQ7yjCP80Z8SPUF1POCivi7+VjySPbYOblQdG4ckwCoCdAV+FiUH
         7dYY3GLFhOAjOchnTx4QunUshYYXnjkBTbFo9U4GgssGaK12qG60LhSB5eL9C6lml/8Q
         LqQg==
X-Gm-Message-State: AOJu0Yx1ZzRuTYRdu8QZqlRMbKVYLIMullExssCqukxaKa3fgaH+ZzYI
	ReYmdLcs9EcJa42ErVCEw3KQe5My51jSTiOPLOhE4uxMQYzqdzHFl5RTozb9Y7Y=
X-Google-Smtp-Source: AGHT+IG8Q/v5pOxb3hNXeLYRo40BDj9aWXLa+OGr1zPDt6jYlTzv0Pt/1CV2s96EN1MdoYBw6vY71A==
X-Received: by 2002:a05:6a00:c95:b0:6e0:3efb:cb4d with SMTP id a21-20020a056a000c9500b006e03efbcb4dmr800211pfv.23.1707251219088;
        Tue, 06 Feb 2024 12:26:59 -0800 (PST)
Received: from smtpclient.apple ([2409:40d1:101d:6931:71fb:92bc:bd9e:5395])
        by smtp.gmail.com with ESMTPSA id gu14-20020a056a004e4e00b006e03c68ae9asm2505139pfb.16.2024.02.06.12.26.57
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2024 12:26:58 -0800 (PST)
From: Divyaditya Singh <divyadityasnaruka@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Query about gitignore
Message-Id: <B7F364DA-27E7-4BDC-93EE-32E6430B6ACE@gmail.com>
Date: Wed, 7 Feb 2024 01:56:34 +0530
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.400.31)

Hello there,=20

I hope you are having a wonderful day.=20
I apologize if this is inappropriate but I wanted to ask is there a way =
that I can make my .gitignore such that it ignores the entire parent =
directory of a matching file.

Thank You
DV=
