Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3D5186F
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705635610; cv=none; b=O+qf897DZj+VndpskMNQLFSvziOQYpe0LrNfEyL8HW05/vag537J9r49MPYh0v563+8UNGNKnxuQckpp8Gdk/g6waY726oCLxZUywAdx+KnksL41uMHB1Xqw+h+lIT9dNdwUgRKwlUU+ajxMuAIUR827l+bqBzcaTvpakaZgxrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705635610; c=relaxed/simple;
	bh=OwOZztkDpHmNUyUqyy3BfL7EJ/K02Dk1EBKTW6VADfk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=iwIKadjdTHpORUb8qljT0PUSQ6hGkqkvIQ8mkScPRdnDBTqRl2WhqlgYzQLYL37YI9kjWGUIQDHWZ9Vru14K98uYH7FdWlPjrlT/1GCjhaIfw1wypGDOBj57t6TgPUwSgMku6ZEO8bBcABjpLungXa74CwBac4GBudyZX2lPpNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTyiFRH6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTyiFRH6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71b62fa87so3069825ad.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 19:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705635608; x=1706240408; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otZiv98SURSo3TnqfiTuSD3BcMFwm3tXUNpBJZxoBio=;
        b=fTyiFRH67X9KKEFMS5kZN5xihPsipYfX7N7vWJJQgrXy0hIO9cKzdcikn3P0OUCpBc
         DU5vzXbh/UW865eIqEDe80j3mAfMpxXUYASJUyHM38CGM4ZPs88cmU/BWl6i6bHmFVGw
         RyXrIwKFyeMLmcnPWzwDu/DeRPmcp9frx5aIvFvuPFk7BSG6wE3wbyyJhDnwgbnwRB34
         ebL9lKXd2/2TbCnKXbiG12g90NDkugfMERwM1islJfwlHFbjv3xk4qBWHktqHCkajMuh
         Nm5V4OLqdm/416Mtimi6zNVZnf9yVWkICX0cXkNTM2syn52/2UFwZiVak8i49X12ggO7
         jAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705635608; x=1706240408;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otZiv98SURSo3TnqfiTuSD3BcMFwm3tXUNpBJZxoBio=;
        b=hYWbkRIpIVdDA9RwpJ0e3RDUreO6TgYneYpNQCTGhJQpq1MVylrJsXSonsb8B26rUm
         CW2jb+WpTDMaQY+GgNe0Pot2tO7wgbrLaR0Ra8+KIVVQA7gPR1pI/iDJLcNg80+KuofJ
         ZybWxgfIpN6XxLWKjWwAePUZZbCmTp0FxXvnQRKQ3w5402nL8JTzm3KUDnFQETTNomwB
         3UZ16lkD5POp7JWsGPSW+FlKlp8md+tA/CgTfaNAzYwd2zk1thU/EVU37HDVcUy4p09P
         ZG79zSlvLjep5rk4L9yCkx50bRPvYcrstjlHb+7ANaZX5vD1twwy2+Za6I9TCZPtLlC8
         EQSw==
X-Gm-Message-State: AOJu0YyRhgqCe5VyLzU/mJfmqjQojbDJBPKd6T9/boxAgbs0A8vanbJf
	wbi/3YUyVwUh/bF0BkMlbBz/fYiRu3FEjZkJP+k04KaMuvcdaY+AFszWbliLPN8=
X-Google-Smtp-Source: AGHT+IFjc6sr2tXWel+Rl8a9V04QOMhtP+vu+5iHD2qbZlV8Asb5mbqBEfhwKIY61KM4tDh5v115sg==
X-Received: by 2002:a17:902:e886:b0:1d7:19ec:2eaf with SMTP id w6-20020a170902e88600b001d719ec2eafmr526561plg.6.1705635608238;
        Thu, 18 Jan 2024 19:40:08 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902d11400b001d717e64f0esm677639plw.87.2024.01.18.19.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 19:40:07 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jan 2024 09:10:04 +0530
Message-Id: <CYIDCZPQN2H1.1ET0CTP07NMYR@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t0024: refactor to have single command per line
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.15.2
References: <20240118215407.8609-1-shyamthakkar001@gmail.com>
 <20240118215407.8609-2-shyamthakkar001@gmail.com>
 <xmqqfryunsd1.fsf@gitster.g>
In-Reply-To: <xmqqfryunsd1.fsf@gitster.g>

On Fri Jan 19, 2024 at 4:48 AM IST, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> > -	( mkdir untarred && cd untarred && "$TAR" -xf ../test.tar ) &&
> > +	mkdir untarred &&
> > +	(
> > +		cd untarred &&
> > +		"$TAR" -xf ../test.tar
> > +	) &&
>
> I think we assume "$TAR" is modern enough to know about the "C"
> option (see t/t5004-archive-corner-cases.sh), so
>
> 	mkdir untarred &&
> 	"$TAR" Cxf untarred test.tar
>
> without even a subshell may be sufficient.

I suppose '"$TAR" Cxf untarred test.tar' is not a valid syntax on
alpine, since it was breaking CI.

Instead changed it to '"$TAR" xf test.tar -C untarred' in v3, which
is how it's written in t/t5004-archive-corner-cases.sh, which passes
CI.
