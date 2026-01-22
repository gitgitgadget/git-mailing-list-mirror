Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393811FE46D
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094224; cv=none; b=rf8zjK6bLoE0maNfNObnwkhIwXM48Fpms8B5kBt0S0DdXXXIXFxSrOUvlPP7taxP4pd8xTKuvwlnRp3O7uI1hVd4321oA0DprE7Uha1+w2mKqZFQCcWTXg/tSpIM79IgOaV8nM8kAS3PLHSaz/MEHLmceVBunU/OP7MNOZuxnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094224; c=relaxed/simple;
	bh=2crv5OQg8WtAVESLCtkfrnWQwC7Uyt9jP3/7FZAuPZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vq9DifEktaSOiBKGq49FJqZMdydsDHVQt+am1RxVk2IxI7SyzdK3MgzqoITn5yK3tkDmHKtstVMuNrIifgFQZ2BCcaVneYAJnanTTR+uNVzb2CvaXLCPAqWipH7QYinWOZQI7nlxPmPMwkHm5YICbCTJ5/swMnYm6FrVXrS0cXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7mLRJ9u; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7mLRJ9u"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59dd9aef51eso1165751e87.2
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 07:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769094221; x=1769699021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+ZXDtes2tS6ONFhYnBuCimqlkhTxRyqJHlZHmGd6gM=;
        b=a7mLRJ9ulRdDiJXytmnKkMSYYXuQEdCMJmt5iM8phwCVCEuJ9lXrFYQByHFHXlJ5gl
         a9cT0dftxXDAwD6X5ZfR+62DV/1QX+4pRypQTuKbyxKT4wTMIeN82P/Ww+3zUpyYhW0i
         Xg17lYBQjfOJh4bQTpV42937UUjwVmHBudK9JSj2L7GVngS8K05xtBLMTqRZ0A1FnaAH
         pt8pk9oAh/tBYCaJ6jBZGODxx9vn2/e0x+Nc7LE0LCiUzuybZ4k4kmTWrPbTUzeTdAhl
         evP2adNL110Y7CxZrXwztQJr6sxZ63qdjLBMwz56+as3m45a8YCj/3wwsPwvfqAZaEv+
         nXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094221; x=1769699021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+ZXDtes2tS6ONFhYnBuCimqlkhTxRyqJHlZHmGd6gM=;
        b=GK4GcrD3Ex/+TI4Bbya/usfE8mLHUIH9A12DTXyRs9whQhKeKXCtCEBDUw7tBTdyrf
         HmOYJLUtuPmOcMlOKNoyq2hU6ttGwNkrcdiEByPynYInbH69epqAStgZmLAnYO20/Lgg
         xAkbgXBk1AcPTM3n7J64yI9q6wVEXQtVdXuRcDN+zq+fDBRgAuxVuwraqpJal/HtJ/vF
         8V8atIrRuASir/Red3b7UxIFqolFFH6VLlvKE+1khxFNVFOW2hOK/eZQ6rkJmS5ZFZW9
         F8yEI/ErCuhWeh1XieHoRcHO/xgsaDHLEbCvPey6YqQQEyjVqBH17hIh2PntYdhBM9/m
         2FOw==
X-Gm-Message-State: AOJu0Yz7KDQuJ5w586paQuIF3mMcV3nL/MUPU5hLdcw3nh7QVpSdn0qQ
	CT+zCJxz4IbbgA+7U3iopZOskyre73wD0QFtre4NRbmNoRJU+m/3Y9/v
X-Gm-Gg: AZuq6aI6bVDWawGDx12dK4HHx51JkeDL2NK1SIRNdyBH8hFfY+QAMeL4eOpZBx5Qo3V
	TxADRKBGgxkmmm20PNDeDoW9qsDbYkUkhOKOBjX1qP9fDyEBbzIwLoOzXVJmfKMdxFpDn9rwUuh
	8zcLvS1Kyz1sVR66Q4NChEAJqwJDpEvXIgzxRaXETuxDPs6Oxd68490xOk2+2dkF6pGcSnEe5Og
	DW5eQ81HFm+TvPBzncCpvi0tnD/AWp/uV84ygIIA1r+/UabAwc5qEGmSZRdqV/mYv7lqBCslCmt
	lEhRm/5PT1Y6T4JvB+vzP/X5csYEuCSJVDTlLMZmVYuG2zKpSwCB+8ccwJ0nT0odinTil0quxe8
	AzE5dy1ECAJXj1wSd+PJx5jr54lyuf8b3/6nMLK0u4tcmd4Oy1el1/FFhTU1BAy6YPqrITUEOFg
	432QFXoSILZvg1LfprnYLz0T/RMdUe4EHWmNp6gxIVq/7qyk4avrN7fOdpjpcrUljuhQAo3Ylab
	4Hd
X-Received: by 2002:ac2:4c4b:0:b0:59b:b478:ebcc with SMTP id 2adb3069b0e04-59bb478eca4mr5174193e87.25.1769094220741;
        Thu, 22 Jan 2026 07:03:40 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf353083sm5473812e87.41.2026.01.22.07.03.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Jan 2026 07:03:40 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net
Subject: Memory leak
Date: Thu, 22 Jan 2026 16:03:39 +0100
Message-ID: <20260122150339.65566-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqh5seu7jz.fsf@gitster.g>
References: <xmqqh5seu7jz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I realized now that my code would benefit from branch de-duplication. When
running it from the main branch (which has upsteam+push = origin/main) and
my git setting is this which I intended to run from now on:

    git config --global status.compareBranches "@{upstream} @{push}"

then it reports status twice. I have a small fix ready and will push it out
once the CI passes on GitHub.


Harald
