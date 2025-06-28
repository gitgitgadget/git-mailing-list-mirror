Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CEC17A30F
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751123460; cv=none; b=Z7NzMEB4n8fTyqI0wdQRiQe6XUUR4XFJTl1af3tuN/Kzu9Bqp3HHYpA45lOJiPDnLzfkpiDiOOO+unIAlSUqTcS8oMYk4B9IVkxftXIXTyXB+2JkLiDgQyH/Jr9MS6MDJqVj5FarC0/Wi3AzhDz86UuoECUvi6MLF+d0htwJ8KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751123460; c=relaxed/simple;
	bh=rzU5w68cJW+YCNLW8e/8Os7bFftaeoZgB3lq4ksEwOo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h3KkhQ3fiS6HdhjBxYTeCOlW7SH6wNaNyvoOvRJO86DFi73JA+HFdlyD4fLqKa+M0862M5coXkI5nc2JaRkcu4U7PO13Hk5ScVhFBS635d920IGY1IsEUd78VC3LOACdb0dmCIp6pX/D8ZcxrYSZqrquRmGS2sEL5nactL7E4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGAlr/rj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGAlr/rj"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4530921461aso20149055e9.0
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751123457; x=1751728257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2KeMkeYdDTQazqnmGcfB9hhuQC5xdbEe7zq+/F5UZ4=;
        b=TGAlr/rjXtO+yWh9vV9OjpI15TRy2juQv38jTw7Kl3KdzlEBrn3wRkJzy8ilokeXqe
         NaFJ0zbEWpVr1KBOQM7vFRY7qRcMmBgXnLaEUlab6YzJeU9Xi0qp4xGzSaKbPesWtmTz
         APPsS8v/lSr5DqY5KCtfrxhrwI0d1WGX48tOC64p4ZWYgE6Y1mI8p65F47EqGCujhKDs
         4D7asWYR2WjO2Z9oyziAYW9QTkPHLqNxXVjm5RHbXstaXvRtL0bZau01Rr2hmEE0Kp+/
         m3fZwVfXpKtmxqVKnCjKcrh0nFAIu0MWW3s90eKL1PeZct/n7oOKoEGKXUylXTcDARSQ
         qAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751123457; x=1751728257;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2KeMkeYdDTQazqnmGcfB9hhuQC5xdbEe7zq+/F5UZ4=;
        b=rxlEZbuQCi2sywsZj4pC/B0UQP4fHj+cWFWHH3khYREBBpNO1gn6ed8VlHMq2xk7aF
         JzxSP/FsFdEa568B/v4pVka9wQ42lVYAD2GNxyDP91lyff4OTGr4A4+YJ3lQkOsY7dI9
         CGRApQPy//0WHbEBpNIImxBdwb3n8HaybWR0q4N4TuVSxGKqbSqpAar469KJOFvp7lNj
         Dx4ktNhWbnG6Lwd18TNGtzvPzqrA80um5fwTUJHZwPl38ZYAcVidMbRgTc9mi7F7gOsf
         LwZf3APNP4KEPVTHdixCOV/G94oUpPfHrdKifc1CU0KAXy0WAZl9Ek279mndZdqILvhN
         dQrg==
X-Forwarded-Encrypted: i=1; AJvYcCVgBGGEI/5wed3BC9ga0iIz98zLWQ+MZ4LVCLanp/WDKNIGr5MvcNcKymxC/GWUVevK74w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxspKv358eUoFSa0z/Kxe5MstjkhatLE3qHHA9zioeZgWnCx2eh
	GFRhmoq6LnQxaYjuQBOQ6orKBNttuIDRZglD5ug2uda52D7jHJJ9p/y+
X-Gm-Gg: ASbGncuqdt4Hi7oPnZFJFNbM0b/ucfeepBXFtXZ+//Myh2ew/UCdQDlSPoV5lNFY2QZ
	lu9Pp0K6RhBBTvO8+qubiZ1ywI6AfxpfQlrpC53YwRgtV2tNxat2kKVo1DlOldfgYS9ohXhfeDv
	dvX+cvH4Hit4VWa/d+8ngopFYrnakCkyo5TNTl2M2e2XQXXKDAQZpIAb6ssnPNNY03vyOLp0QdZ
	+vtKqL4aR1uzZx37sQ31lrWAeDNCBgNVc5wo68a+4Mg4/6WN4lvAPb8uTkK9pVctsdaayZUCOru
	8zNn6M+iCJmhlNmh8+SnXb5L0jiTaVuDYT6MOtC9SBgdrDqaVKcPOTx84+3/mCvVnklmmFqblHQ
	5t6h1lm1pS+fGlBKyEfIxHlxpatJJX4z+3Bjeow==
X-Google-Smtp-Source: AGHT+IGqim3hyVUhT+r6xfxCFEp4W3B1p1aR329dLYsOE1kBNR+LUR3/q+kX4iHmuY1jmDEw/LkFyw==
X-Received: by 2002:adf:9cc2:0:b0:3a4:ee40:6c85 with SMTP id ffacd0b85a97d-3a90334192bmr5821320f8f.54.1751123456573;
        Sat, 28 Jun 2025 08:10:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f44dsm5495969f8f.87.2025.06.28.08.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 08:10:56 -0700 (PDT)
Message-ID: <e1e31f27-4c17-4a48-b46d-47c56d2d290f@gmail.com>
Date: Sat, 28 Jun 2025 16:10:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH v2] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
From: Phillip Wood <phillip.wood123@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>, christian.couder@gmail.com,
 git@vger.kernel.org, shyamthakkar001@gmail.com,
 kristofferhaugsbakk@fastmail.com
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250626221631.457725-1-ayu.chandekar@gmail.com>
 <91982162-b138-4bb1-81fd-6f9185801c99@gmail.com> <xmqqms9t8cfd.fsf@gitster.g>
 <f39a3285-574a-45c6-9646-04eb175f4770@gmail.com>
Content-Language: en-US
In-Reply-To: <f39a3285-574a-45c6-9646-04eb175f4770@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/06/2025 14:38, Phillip Wood wrote:
> [1] For some reason adjust_comment_line_char() will not select '#' as 
> the comment char if it occurs anywhere in the message but the other 
> candidates are selected so long as they are not the first character on 
> any line.

Sorry, forget that - I'd misread the code
