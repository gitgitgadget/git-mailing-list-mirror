Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847887080E
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766746732; cv=none; b=F4ho/pw47orAzCSX5VVxBEAwkJQZJDQkYaFfyYTM5QoDELxvuDY/I60X1Mt/bPUsRwg/BnHk2V5f0gWbUnxjO8MEBHkEAy7EeTRXNy5HRPq12n6HhLGcyHVfBzBknEHeUwI8/Ho5ClCCObdecrljpBXlfVw563qq/8Ey01d6Sdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766746732; c=relaxed/simple;
	bh=LjFrayKgMrmbdp9NdLypkG5g2aDDN1TRVjgixhd8Qsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rTuzpS9RdBRuW0jVwSEZgPFE0WPXofYPez7g5LJWq0rkFqL5z6DmqyzanzochNdMz3oPD3olp018Ja78sI78e6JnF4j5OFWzK52tP5ArDGrmdv4XvUyf5E8SlozT0dL8eOP2dVobDAzdsjJe5yfNGAhsd/pa6Chth1iYLeIMMAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbD8Smsi; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbD8Smsi"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5958187fa55so5428034e87.3
        for <git@vger.kernel.org>; Fri, 26 Dec 2025 02:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766746728; x=1767351528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjFrayKgMrmbdp9NdLypkG5g2aDDN1TRVjgixhd8Qsk=;
        b=lbD8SmsioAatQvlzxAQKRma/74OTxy7+aTffEqeLYdhRaBurSjomZuo6fgJ7zfHzRU
         VIzdeIbpSaR4JxbfRpsgq6R/9HkuR0uEkzu1dB4P7z2vcSCp8Mj69weUEOQ3NNuuxBlG
         TYM3EmMChSGpndZJqbQQVyOLecFv3voAOgnvfW8z2znE45+BIGxg8pey4fq6sOnbxWQU
         KP2AC+sUxo6dqd4PkuovEVSEfK0heJnC/nh+UX2ps0TIiwQETNjowJM05TY85vxsZgSj
         qsw8ByZdfrSjlb+E60A4xFIj5HFfFk/wT5lDr0bPPbJjflhi+oZhkelicalexLl3ZVzX
         cjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766746728; x=1767351528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LjFrayKgMrmbdp9NdLypkG5g2aDDN1TRVjgixhd8Qsk=;
        b=G97EzZeKyK4Y28xyb4uCYnsXdFzdSUKeM/uFUUnVS8ygzVfk9oevKzhdWzQe0OlYBW
         qkw2y5payl8w8wo1eemyVGjwdsYoN0ns2/iAV4wavLiCogNyHE+yH/us6bFSVuy959jB
         pEFjrXnxAFL0V/rKuYEkLnT/d76nvxX/rIq/0fpzhfYElMxPWZXVsefngOLrPtmFEfUu
         F1cbtGMtGGLRLez2EEJpEGfBEpNgChAiRF2JeuuU5XT063xyqfjH7wSv462MANGVjJQC
         IWFda20TMnTiqoyLLBmv3hqi8rt7ZmpVS7LPtEpfkexbfvai6zCL7Q6wkS5a8j/JG+3v
         9TsA==
X-Gm-Message-State: AOJu0YxJl/N6E6S4/ke2oCSI5M+XUHJSJWMEUBI7lz0qZ/RU6ZmVbsWw
	glmV2ojGDvYLVIOvzPJSrG8BBAITklwpXL2jCtzO/G8x6v1bqLQO2MRd
X-Gm-Gg: AY/fxX6wa0HI32wY358IL8MMYjTi6omWpsO8EJrYGn9DhXg0kBVThz9sx5t4we3rsCk
	ZB5B8193PQdhN6or7VEIYT6Ych5FwekCUxsC1iY2G6MCFaub6kpP9nTo5u77/Fdhkqep/pEAr/t
	uSdvwqRpRgJdv+Viwr3EVYQjG/LVk8HgNt7k/46Hlmt9MxxUgHLROacdTNy3WOrcqqcyH8zMjc7
	n9XgRiozpGQFFA6QfeNUQaST5cctpAmU1jdoZQxb4WgK0DoSrZFTbC3s3UUhTPVwh82XxgwfzQ/
	eGAcA6gpkVSl6ljAfRrmVogFNSy7bMUL4CmQJVnkAi/46wO651JmjO86Rgz0AmBcHvcEtEg7Kr2
	xwAt2tAFftdTi1ljvxWlK0k6Q/a9Pp4ZxAyHZ/u3b4RlB+UdoTxoa+9l9g3J3ooBptETPKChaqB
	9Y2eWx4dTbv81FOUbyqGr/xRPXzrr/mwDcara2uQ4hHwtY6jly7g/w4bu0kK8riJy4E5qAw+8=
X-Google-Smtp-Source: AGHT+IFbQnN23kKAFQDEOuGJWFy+NBqlyhawsa9fzgZtO282Hv0WRbq3vKrmGSKxgW9oc1GaosizQA==
X-Received: by 2002:ac2:4e04:0:b0:597:d764:7443 with SMTP id 2adb3069b0e04-59a17d34de8mr7574723e87.22.1766746728254;
        Fri, 26 Dec 2025 02:58:48 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5eb2sm6450200e87.1.2025.12.26.02.58.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Dec 2025 02:58:47 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] status: show default branch comparison when tracking non-default branch
Date: Fri, 26 Dec 2025 11:58:46 +0100
Message-Id: <20251226105846.75864-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqikdum29t.fsf@gitster.g>
References: <xmqqikdum29t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, I appreciate all your help! I feel like a bit of a bull in a china shop here.


Merry Christmas!
