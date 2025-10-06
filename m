Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2FA1DF254
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778444; cv=none; b=IwCVN06jelOaa1i+UUXwKFHMhgxnI0eM3linbxuUXvwz0iGXSDa6WILX8F7WDLw3OybArlit26Rnskb3pn6+iQE9YqiM7axpl6dd6rBUw3eGS2riV0/nPZ7K0OTlq4WTFZGpy8M0ivRSua+QivUfXoMiy0RmT9p0p2rM7hu6Ac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778444; c=relaxed/simple;
	bh=zjmXgo+gYpFOG+D5+7kj8UGS6UCYVP5uoj9Zbt3+zCM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM4HKBLYpeM6ArVUVz1EOQ+SE1EfYVmsD7ZQ/U55uGBk8yun5ZyC3VJLUveilKtUxnZyW/afy8pX0Q3zzgJrIO1xd8b8WJMl65Sow4v0tWXV/ta7SkLhHAVn9JUZqz5iMv/CYNXFyqLuSot3qhhN/Xx6Xw9DlecOEE+xP8jJQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=JRGx5F+T; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="JRGx5F+T"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-91122373653so223817739f.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759778442; x=1760383242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a0SaqHLukSe5Qk5A/dD/z2fERTujajpNtLxLjcukwGM=;
        b=JRGx5F+T3HtBCPPGkKrEPgLgHfrWYdQZKk3hj0aMjg8ah0hfw0BKwCDqy21Zqnou+E
         5LQUIzqWwEYJShUSy/hMIRffcfyclPpXbpaqeIQTUBYmPqpIaMjJo3gxg3r6ieza5VPL
         uRvcCoble0fg6OZlxYHuJ2Modn2br3HViQspQQstRc4BUYM1E5pXFoJ1Y4LVTfoKJmvP
         apcDN/0j4CENrv93iajxoxhVjVcFUL9lFh/N52Akz9xTRGtr4HP33zRQb9wfmkJlzSRT
         pnUFIPSQOdpaC7U5/2cs4g7eeSD8nj9+QQOGcY++lPW5bKnUtUdpJ+NUgvYsVxBSEMwW
         O1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778442; x=1760383242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0SaqHLukSe5Qk5A/dD/z2fERTujajpNtLxLjcukwGM=;
        b=s/PYrDT23iNSaXL5+4P81zq7jiZSb5yAwmwjmWtWFCSIwh2Odrezbz9XNQ7D6ZkXXl
         Q0mIAZEb8ngq7ZeY7b0nOzAgPppnwTcujOOFZBL0z8IgvVV5HpmJOSVekvRB+Kpt70c6
         e1JrrkgvG4DEqAK9WGCMSDNCJcpWEiH2XrwMCcEvwMbi6Pqt2XOY4I9/qst4KCTw6L2K
         meGEFWBUoN1iiQK/FXNw088l8wgT+6xSWHqZcOZdBz4Hj8pfd5ToyCPRpcsvN2+RTMqG
         IFEBeyNH/ssY/OzB96XIjfDXTnYTp3ggUmkLVi5DnvIdPWU5iCT2/OxucpV96kQ1vG9y
         rmFg==
X-Gm-Message-State: AOJu0YzM5OZyu2sXnT2tRPRYfuvX9iQLu9wYyft9lddXdc9qu+jxePim
	f1ZlrwefXr0rQTXY+rNONINRKJygpdNQdmy3LIsFLXepqklBOPpwq9TOOyFJ/TGglhSL5FlkuBL
	hvT0rbICf3w==
X-Gm-Gg: ASbGncspiQPqMf4HGh/7T+PlBBLOKzQkKloXVCQRkrq1DgZX+7/qPgCtOR+Mi8LDPsL
	Xp3b1MeRlvlrqNH+lLPWfufhTE5kCbeKfX2AY/fH+LEyqQJtFObmE8DF9KbrRUbHidq2LsxMMA9
	wNVW0TbRqs0QlDp2JBnssMlUlMpiqI815LYY+eODD6BoyYTdE8Dpu09DBzZX3MCfe54rr0g2cp6
	IUdQw0XP9HVtWiCLfFFT3wpMPpjDkpMAVzlE03Q4Lki4NiF21zkn6BRYR9bvZLS/cwGaLrOHPKj
	Swy+jHCX48jdew4Sr3JIELlPsrUtIhM6lLbuS7TBL+2NoZYq4H3DjBXfA/Dc+/d2kr29veoy4ch
	T1a0TjMPg3FupWcTufULc7mVoUTk8yoUmzPy5D2w6Prx8+uawyL99GhHkmeAkltN9Po9DK3LWLe
	5P6L/f4Y9cMyeK11KArpKxSpuNl9OyISyjZ+mpj9c+lFJVMo1xIg==
X-Google-Smtp-Source: AGHT+IF8s5bACpou9M1qCR6UYIAswDY+s0e0wP9nlo3rEGWzg+WiZNKb2rXb4XWSjadxfAShPqOS9w==
X-Received: by 2002:a05:6602:6182:b0:929:a709:911d with SMTP id ca18e2360f4ac-93b969376f8mr1634805539f.2.1759778442226;
        Mon, 06 Oct 2025 12:20:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93a7e3a6ab7sm495218939f.12.2025.10.06.12.20.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:20:41 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:20:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [NOTES 10/11] How can companies respectfully engage contractors to
 work on Git?
Message-ID: <aOQWiOOp2pz6n8Kg@nand.local>
References: <aOQVeVYY6zadPjln@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOQVeVYY6zadPjln@nand.local>

Topic: How can companies respectfully engage contractors to work on Git?
Leader: Emily Shaffer


* Google hired Collabra to work on patches on the list
* Should they be doing something specific to indicate they're pursuing these
	patches on behalf of someone else?
* Taylor: So long as they understand there's no obligation from the project to
	accept the work
* Having a short note in the cover letter to indicate who is sponsoring the work
	(if it's not already obvious). Mention during review if you think there's a
	conflict of interest.
