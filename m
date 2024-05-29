Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513E161933
	for <git@vger.kernel.org>; Wed, 29 May 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972680; cv=none; b=JlhSsjqxHnTalMckqlTYcB8Q7TawPWeDzoYcEor6CLbwaVNw/nG7b8oUk2fd5n3wQUf5UsFHQdS+g21aXTE38Aqxdefm4vLcVUt0fUyiXa9a2wCka557yrFinmvbtxJKd4K6fR/zOOjZD+FGNje977M9GqIrsm9miV9mqIWTnIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972680; c=relaxed/simple;
	bh=Cj06/OJQ6hFsrG6rJwOqU0vId5v3FHkXy10xtNQxDk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2VKcaZJQ6flpBigVTRgMvoi0uNSWU8JByF3qVjSnpxfJSuGVEGINVb2h0Hxzw14y/dpspuAvWbidFhrejOXOwhz5Mp40loDHdemZyWTBUsZIpqcw4MvghuZtaIGk1XlCj7y1Jvj5xH9JMOIcgXtpHpMEaksGxRWrrV8q8izU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx2J4W+D; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx2J4W+D"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f4a52b9413so12151335ad.2
        for <git@vger.kernel.org>; Wed, 29 May 2024 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716972679; x=1717577479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uFflzuwCSb0eTumy+qpYjRSWP4IVqRnq3NM1tUf6lM=;
        b=Qx2J4W+DlFP0SRSuD9eP6fiHkiU2tWUmvQBeiYBTQg0N9P98V/jEgCABx0vmnl9dlf
         cjVFxqDjDE7qTxVqliRAAfo2B7nXUe7uSOJz0yMEGnkLvkZCTCX+KuJMt+hx/DRRO+a2
         bwKPgF6d4/QK7wQNotXzSvxYVD4nTx1DifrZ1iea1bpl2Zr7Mw1lUPcEHm2KHpz5enh2
         zn8d6Iky/Mbjhhfh41iFOHPXa2OgMgbUCntsDSODWXXP9u/vAoxTfBTTlbBGKV/JGcfp
         k8l9+X8RmSLJ8rGvRc7zX8Iy7eg3UQPDe5uj4AJOvtM8V+PSQ4FpU2IbhhwAQmn8g2wS
         7iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716972679; x=1717577479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uFflzuwCSb0eTumy+qpYjRSWP4IVqRnq3NM1tUf6lM=;
        b=c8ngp3G90HSSVsCYeg9zPqBGF2fSCzSh5pjWt+nz7yubkyZiZngzbqddUTyPbtiv9a
         6Sg8YUWFuORWRm6NE+dfPWbkcl1sLgSJV0cHlQBjH64HyTTZyqjCxRWK5C3yhxe3AU5g
         yWc6LxfzjlZt55AVn9ifpcPLlu0yPFqc95+LD6WbJOch7WY6npG3XKIrDozbiH3tEc/l
         WrkpzKa1bv0WsYiBxtdn1Bgc/PZQlIeb/Q6U/8foXhUvBsh66SkUyP4O4gUfmWDNqppl
         SfqOZD1nQr0ZDyKSHrS7JLQPIjemnyFCJiI4e9hnZA95WeK8mVYnWVUEYtGxCOhezUXJ
         jhag==
X-Gm-Message-State: AOJu0YzFTzqGn6b55V2sk1e2SQuJKYuewBnXCcxSTxDFTXXKBI5FO/F8
	/dQD9SIbNhmtNOHalmwtuoJMXHec7L2fxyuPLCyn1XnXE9xXf1Al/srYw68b
X-Google-Smtp-Source: AGHT+IE8m3/O98/mr5GCeLCcJOJ7uViaK/6akcr1dpKZvDZVgBqEA65pxj0M5mlbxiG3gXzFld3oUg==
X-Received: by 2002:a17:903:32ce:b0:1f3:488a:bc54 with SMTP id d9443c01a7336-1f448d3510bmr177008615ad.36.1716972678517;
        Wed, 29 May 2024 01:51:18 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7592c1sm93467815ad.57.2024.05.29.01.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:51:18 -0700 (PDT)
Date: Wed, 29 May 2024 14:21:14 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #12; Tue, 28)
Message-ID: <twbev5csmtfuwzqqj5otzjs7jgkzewoq2o2cyncqvj522fkoji@5znglrfbw7yw>
References: <xmqqle3t36a6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqle3t36a6.fsf@gitster.g>

On Tue, 28 May 2024, Junio C Hamano <gitster@pobox.com> wrote:
> [Cooking]
> 
> * gt/t-hash-unit-test (2024-05-27) 2 commits
>  - t/: migrate helper/test-{sha1, sha256} to unit-tests/t-hash
>  - strbuf: introduce strbuf_addstrings() to repeatedly add a string
> 
>  A pair of test helpers that essentially are unit tests on hash
>  algorithms have been rewritten using the unit-tests framework.
> 
>  Will merge to 'next'?
>  source: <20240526084345.24138-1-shyamthakkar001@gmail.com>

I've posted a new version to address Patrick's review.
Link:https://lore.kernel.org/git/20240529080030.64410-1-shyamthakkar001@gmail.com/

Thanks.
