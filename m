Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3978329E76
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178451; cv=none; b=HNozkwg6BF1ilK6mil2F4szjPEa1qpjvYA+LFWCuQcQLyQKMHU0SfOiWChrq4rc80mPNNrH7gAE2Qh/FD6fgc60UF0BytDl1Tpr8GuWYAvg/l5DufUBJiXTC0RWRNXVp3YzUWCi+8Ijv38t5uKAhQE1f1m7Sbv8bdW3kqqLxcAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178451; c=relaxed/simple;
	bh=6CFHAm1oahRSvqJuZ52qzFiVOpw5gVEAAL2to5uPRDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9UQ43FJlv7IEn7Wjgjphkt7CRzPAvV6INt+6+WiRoMSZ0awx90YVnqmiQUEeGu6JKx+4zhKjiARMO4SDYVqhJb/IffQJ7jJRDNHO6a5apnkaEssPQ0FkLhsDqEoZkxPAQS9Nzj5S+Brf7C56CooGPBkUrt4vtaFtPoC5CYgHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIWtYbiC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIWtYbiC"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a78e381fc1so10183645ad.3
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 06:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769178446; x=1769783246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilILrxvyZ9WjHTM6DkhPf4sUkxQFoXXep8baIzpyo/4=;
        b=ZIWtYbiCuY0MRT++i0+9ea25Ia4cFq8Lk7pzDWy3exSuPU5fBXrTeLRGCLsJrwfZlN
         5aq/XUDvcHm+8kjPV6CnCs8dwhjcTgNGzlPrQHXEaw+D3nYiKMPSCH0w3aFnmwaJoKkm
         EmW7GjrXz0slDzTdEgWhZtOBziE6izkm9FKbB3HAWx/GkFciUqX8OqK8cC4iVqkDRSBQ
         S7juxRH+jsf3A30xCpMkEAiLXjr89IcR1cIyctz/uBRLhtbhDimMdE8KXRTFqbRiLDwm
         /yDLmStVxV8pAydLnILQfFK66o8M2jedVXUoWTOBW2M6+ij6FuLWdCtW1Mr5O4vH7Vc/
         yemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769178446; x=1769783246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilILrxvyZ9WjHTM6DkhPf4sUkxQFoXXep8baIzpyo/4=;
        b=vAEnDjezcfltqILOob4+Aex82kVUq7OB9WiY3HID3dy278pVO9ykp27I8nxgWKlJ+L
         1AuiMy40YWNK3VRhcitwpOVOy2GuChDBkYpQaarCvKlT+bhg01CBq+AT/V+9Q9q6aevS
         zbTrn46uh3Ir+FPCGFH/QpsakxuP/Qk2XZ2QS9mXd7DpHZXKzXueCQWFcu5E7LkkowIj
         iCtxW0jDFaFYqjxjgfgtHIuOzkTQ6656O2lun6JILwKpTd22qPFpxbvV/wZcpnde+DWL
         IL3qKhr1UeUlfSTa0XtGcMSeY4SsOfcYCNhmYh0BBucKGsGzNqVqDGuJIEgWpN1a+HLp
         ONbw==
X-Gm-Message-State: AOJu0YzADPWXOkKKclxLBnAgEvTxnk9SY8P81C5PqPsa0IRvM+8i19N0
	6wmopzFGoe1+cUG1hyNLWB2kcQf+BU3j+mcuuWKVrikw2xiPo/s7tc0kskT3+w==
X-Gm-Gg: AZuq6aKylE8d55h3yxFY+ppMDJjqBN0O4pVULy6zCNyKapI/62+ijk5UaueUmG1U2Y5
	gODgN+wbPxNouX2wpYoUwuvfDBtd6XI/cyuoNeXyyXoWhtaC+2CgicmyFwkDJG0Fti9fads0emG
	q1y8zX+W7z/XiOQnCOz5xOuFa6/SoGeB99H4iiZAjdwqw7r1XiW8aaBxHeV9YkCIa0uvKB5LOe/
	ju12j7BfhpromqrRxkShgLKUJCnw+U4qazH4k28frp5LS6tJlif4OSTsv+oRshbWOHn/S6Z2AMj
	nPPQ8X0iuyns+8p3RqtTy/kUqqlyiHr7GcMK8gB5wRqxJrgwrDqHOmM0kAA7AQENGVBmPn+PaNp
	qn2RxwGrL71BnsXtiK743T6Qd9Euyf/sneQ6a0zf9GGFX+fU3oxKtchoZ9u4ePKVnWsGiUK17Lh
	yn9R5w8ymlBhOr3+vjz/mQHOSP2iLViUWM
X-Received: by 2002:a17:902:da48:b0:2a0:f0e5:3f5c with SMTP id d9443c01a7336-2a80ec52c87mr11681485ad.34.1769178445936;
        Fri, 23 Jan 2026 06:27:25 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802f978e0sm22406925ad.62.2026.01.23.06.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 06:27:25 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH v4 0/1] subtree: validate --prefix against commit in split
Date: Fri, 23 Jan 2026 14:26:56 +0000
Message-ID: <20260123142658.15516-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
 * fix indentation in the case statement
 * add a regression test to ensure --prefix is validated against the
   target commit rather than the working tree

No functional changes beyond the above.

Pushkar Singh (1):
  subtree: validate --prefix against commit in split

 contrib/subtree/git-subtree.sh     |  9 +++++++++
 contrib/subtree/t/t7900-subtree.sh | 22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

-- 
2.43.0

