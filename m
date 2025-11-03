Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0532C931
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181416; cv=none; b=OcuPbN80oM/Mv0rqH3jkLcHRlxv36k0eUHh3pr2hDXSeUWgjB/O22nVeLNTOfnp9+WHpPjtuWRjetVq/tWFlQUszupNDJYGpimaOE4JTl5nUJjbVLmrSo7cFOVfoeZ39oJECX3HM8bHJdbKpc/i3FdXANCV+cjdAO28RvOt/7Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181416; c=relaxed/simple;
	bh=1EhIrgRsyZEfOPryphzYhdXSHJNnygNxvLtbQFy9vbo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lqZDgYyqxI7TcWdjKlpA44d9SLMV8bvGyAm4HIPcIA7sd+lF1CLdQAI/xXA5U1g4L47KUEJDQnXfJOjnWCR0OsfTKTWskwZY9sNXG1/94rld3+PmmzL2Y2QrBtY/72Dv2ye6/0hf64ydGp5LaSi2cxCCJVr8u/gg0AmnGD2M/4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN9CI7bI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN9CI7bI"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d3540a43fso43798365ad.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 06:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762181414; x=1762786214; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9u9rhRkvp3wUUitCWZ3s+OWgZUlQU3OTKUz1TcN5fs=;
        b=FN9CI7bIIB8ZDaGirzUtlroUVFL3JaIcPf88rpGFzJAfJGdJBv1Veh5FN83z9vnl1h
         /OH2Qyk27BDZ/w5KjNoFy20W4Sj3DDv+eSBlClvzgduxD0cS6nhOuXQCN8MwgYGyNVVT
         UH81JCgJzEvQze87KetiGPfk+GD189UNWchMgiF6UrJmSz1Hzman1W1qrlMQwuSsDj/t
         pEawgFGfnIwlTcPo4FoAJyg2rFbFO4QIJpp/c+24VDluJsLYtMHZzFWMbNg/hLJ4n7fw
         LnDA9A+/Y4wzvQT39BPaJ9uBTP9TJAS/KDz+JFV0i6PWz9QTld+VW67ntVjZ3c3nUS9p
         J0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762181414; x=1762786214;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9u9rhRkvp3wUUitCWZ3s+OWgZUlQU3OTKUz1TcN5fs=;
        b=h9rsORwW92nvf/HOy9CSa/hnbxnKl96fcVOBDLb5aODNgBn3/4U6NZADB/W12U3Fem
         UNYVdBNZ4RX+NjHCvih+8oYGLr0fd/bB7XfoRz9E+WkUMmPXCUJuJ4Ht1xhUV+cpEjAp
         rRxiJrpEO3Gm/geH4xk1XMAZlfmbKTiBglKFyRGSZlo1UTSiVZzmTlsIaGagYvVPLDNu
         y/Ze02uNUt4TBzG6irRtfYILOBJSQY9cD+TYKWN9SX+z9QJSBzvySCLoPpjVGeUBiOzj
         AhyF875JOZIaEIfmA7kt2LmJ/5d2ECfyNbcyPpy4QuDQ6vGz3bUEwhH1fFhcb3NoHGJz
         B5aw==
X-Forwarded-Encrypted: i=1; AJvYcCUHU/Sdfc3hwK0m45Lk5+vPWyVTqaQ6IMOeKyAiQgF2eUKsseXhkB16wznw79Ki+SfY9Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmlr9gFeTdZKmx5BANfA4Eh+vjnZt6qfhCJ/Jj2goVh5RMHMKJ
	7X5Z2IEsujjxiMDSRpYZyNYCJb702sm8MdwWzrbU3i9EwDwObTcjw2TF
X-Gm-Gg: ASbGncts6Ch8djC4+mAeBLbPmconp26tkZmCEp4IOAw7RcOZsLSj8Ami8tnC6UYICn3
	KRxM5mHJQS83TjebHKjEHq2CH8oKFX2Gs8EqMnu9a5feVvggCiUAXlSX0y4m0QEDUKvJDfY832o
	+WGNQsGmyRzXXS1p87gBAq3MtLPBafhCPwi6z/y0f5Dg6fa2uNX46vn/fNCGD9eRHRFozCYvWp+
	dN/LDxVKVLRRqaYlQJ8mpJ7XDs23nT/iikLLhyFOwh/XjUlNmuMrv5WTQLNuxwSgDOOJpZFSVRM
	AS6LR1oLlnVthxrMC/Hvw+Bdaa/kL6b6qa295mL+sOUTeAjX+/ukilkgUFRfKVCxKW/GO1MrmG2
	h39H/Pq0lzDmP9+lHebecD898DwaUYS8bdVK/mlEdC3q3V+8BH0bILTUl/9oJTrGOyXsT3K99Ww
	r4QuWewK10uNmjO/a8Sfi4sZus0DMi8U1wSIy88BMDB58LVr+nuQ==
X-Google-Smtp-Source: AGHT+IHs73avCY16HPIExleVYeQRq2+HJxBM7aMtzMI9wYLfEqENO2XzrfSVmjd/9P0o0ulIY0+mnA==
X-Received: by 2002:a17:902:dac5:b0:295:70b1:edcf with SMTP id d9443c01a7336-29570b1f38amr90684445ad.36.1762181414423;
        Mon, 03 Nov 2025 06:50:14 -0800 (PST)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29546185f17sm100091115ad.31.2025.11.03.06.50.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 06:50:14 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: What's cooking in git.git (Oct 2025, #12; Thu, 30)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAPig+cQm7xY4ihQk=pA_4kVGnrvx3tt+CnsFxOhx7=6TB9z3Hw@mail.gmail.com>
Date: Mon, 3 Nov 2025 11:50:01 -0300
Cc: Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D3762761-3503-4DD0-977C-DC30B67A1212@gmail.com>
References: <xmqqpla43wcp.fsf@gitster.g> <aQRaRuBtt_r7SamL@pks.im>
 <CAPig+cQm7xY4ihQk=pA_4kVGnrvx3tt+CnsFxOhx7=6TB9z3Hw@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)


> Agreed, a re-roll is likely warranted for this series, not only to
> address the comments I posted, but also to adopt a very sensible
> suggestion[*] from Junio.
> 
> [*]: https://lore.kernel.org/git/xmqqwm4gl7fg.fsf@gitster.g/

Indeed. I intend to send a new version soon, but I'll be busy
finishing and defending my master's until next week.
