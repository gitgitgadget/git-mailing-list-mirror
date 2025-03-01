Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D829A0
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740790080; cv=none; b=ffqtEkjXwW5EdlWIJvmf+tIpMP3gAf/Ao1/BcjUKX1WFR0QOlbG7Xhjd8yfSICLW6/u3ua7vAlsni3YjPr/iCj7Q+iyM6fGid00rWaQnzt/su03mLuA6CHAxrjsluh/XpCBtxqs4xOP58HGrwTvciShNvjfqqPCnmByOU5QvzNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740790080; c=relaxed/simple;
	bh=rDFYUFVUBdekhN9LpXCQWOZ4trFVkN9qDmM9vE2aSFQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OPknw2NvIGnsBV0r8oMy0Es3jhe9M9l9ynubXc9nJhI71JU/PIAonjzwoq3wI1Zn2Ci7hKmV/oV6AtiHnejWAWlfXThJXWOcLWWEmQRCuE2lN4OLKuvVyDB26Eheem3OOjNYEXk33GdafSB5neRieMYulVPvI6QF7pr7cPiQV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts+3ary2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts+3ary2"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fecba90cc3so1702012a91.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 16:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740790078; x=1741394878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/nuYGs7aTFJ2ESQ4aCZ/Fa+UvZw0RRZhuGEHExcxy5g=;
        b=Ts+3ary2hk7EgEOcVIZSk46vv0D2Q3V0efUFQkj0zE8LJCYCvRAUL4HAGpdr9DaWGR
         jdzbx/bAxBuWd2G8zwY/mWFjp+42ddw1d5AiT0Sv/ywrpLAB5NdVQt6ea9XiLzHKwa1e
         aFf8rQv+zNfw86ooF6V7iqCUQH0GR6dxEAvEGzAXpzsWe8SFp+fjT1wO16t3R24M3loK
         01HstUnrCmMKP1kDimwFEOVWJRKB5vL3WRLvakH4jOHZG+nk+9fa+Mfi8OhjrjpCK4RY
         jy9BA0iYSC4NRC0FtplxEaulwO8XuUWOCeQBnJ5IV1J84xm4OI1lN8TO+V8O5Os//CEy
         poHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740790078; x=1741394878;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nuYGs7aTFJ2ESQ4aCZ/Fa+UvZw0RRZhuGEHExcxy5g=;
        b=da4E6V8JQyhk1Og4wgiRX2IGWv0VdblaLHs4m0HyKeLZADl4LXyp9VeWCtmQtnOLms
         NKBamXXV1KaWnQL38adRVoO+o5Ut876StItVW3+8VXIiQ4ZebZhYuBncmxJZ+v9VAg+M
         soxM69+BhxRXmSmq72n/+d3bNJn694+ZuZacCFNzRjSZqPOumkSQktadceFPw11Ol8ru
         SXyTKVzbVsh9OXF/6eTG3ug+Q/IgoeJYmnwURk0XEXMd7rq1XwvWhRDRLSaKh77QCXzk
         HQHZEY7r/4w3ZCIOkC9Ddw+U5Y1WhlUHi7AxI+KXrD7tJL/e4hFn77Q+wTDC7ccTxpIK
         oRTA==
X-Forwarded-Encrypted: i=1; AJvYcCUbZNiwHAmxERgEyhzwCq7N5aa+m6z+yEswFCXqXI6R6ZJYe+VEus9nWbM/s2CyWqdmqHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSGVVPMWaDsTeOC/PHqQYYQaEVOo0188QJVTqfMwzM5iE0j/5Q
	lR7WjsPCh1XLOUHsI7/tdMJAUO4796QqTk+uCNZOzXSoJzIflBbj
X-Gm-Gg: ASbGncuocU9bKrZGxc83/jf2t9K+zv7fljGyWcXB+ak3QU2CH3d6Bnv9KASspIE1rX8
	GDn7jhuT8m0AaYTT2IoqqbDiqES0Z7HdcpjI3og3PCKCD4QhE69aRZkBpl/T4Kr1gfGcvsfcjGd
	Bmw1Kc8Py3EUN+OrT9TVI8B0JLe+/kHbr5E2QKqXwCHapCRsmcgQTQ7HrLidOp3ex6qKDcyacfj
	R12Od5ggBMjSUAcwqR7WtOAfMqMnJqHHTNWjIwSXU+pUaXHBrIwvmlE2t9pj/OP7CPeFUKIZtIa
	4ewOyxTin4eAYNBYlH5KZfeFUNuPpMdW5rXMCKCariNB6cfb+HJiTqU=
X-Google-Smtp-Source: AGHT+IHz1sTZOGGLuxtPdwwRuggAUU3AL8EGGuJRF7H0ZYkO3LRy5AtRuV+XQ/cUA398JgzIJEdrBA==
X-Received: by 2002:a17:90b:4b4e:b0:2ee:ad18:b309 with SMTP id 98e67ed59e1d1-2febab2edb2mr8196660a91.3.1740790078464;
        Fri, 28 Feb 2025 16:47:58 -0800 (PST)
Received: from ?IPv6:::1? ([2401:4900:4a98:2ab7:aa4:84de:3895:1030])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2940sm39510215ad.25.2025.02.28.16.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 16:47:58 -0800 (PST)
Date: Sat, 01 Mar 2025 06:17:55 +0530
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Jialuo She <shejialuo@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
User-Agent: Thunderbird for Android
In-Reply-To: <6C29409D-691B-471F-B08C-83E14D35EE13@gmail.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com> <6C29409D-691B-471F-B08C-83E14D35EE13@gmail.com>
Message-ID: <F59FB3BE-59D7-4233-A75D-F756678ED9E7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 28 February 2025 8:33:38 am IST, Kaartic Sivaraam <kaartic=2Esivaraam@g=
mail=2Ecom> wrote:
>
>Christian, Patrick and Karthik,
>
>As you're already members of the organization kindly log in to the GSoC p=
ortal to read and accept this year's Program Rules and Org Member agreement=
=2E Let me know once that's done=2E I could then add you to this year's pro=
gram=2E
>
>Ghanshyam and Jialuo,
>
>As you're new to the program, I've sent you an invite=2E You should've go=
t an e-mail about it=2E Kindly sign up via the same to read an accept the P=
rogram Rules and Org Member agreement=2E Let me know once that's done=2E I =
could then add you to this year's program=2E
>

Nice=2E I've added all of you to the 2025 program=2E You should be able to=
 access this year's program page at:

  https://summerofcode=2Ewithgoogle=2Ecom/organizations/git/programs/2025/

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
