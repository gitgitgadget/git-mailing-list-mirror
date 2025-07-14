Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1127470
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511577; cv=none; b=Dijn41mAwtdsmrorwoYfPAQLQRjSzVEREWzCPXMNV1QFu/hQpXlXL9FrcfiRmNpU4tyVDlfOXXBLOS/TOyRL1K7y6iqRlBDNBQEcvnhkFHtX2MwyVg62bIc8JABZt2CSN5tEkyz0MjwITBw/ww3JxzyxxzBc5GwU3IdWEuAhm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511577; c=relaxed/simple;
	bh=T/o6ziwteOEVYMZQiG+YMtyCbo+AWmLMAIRkODLXCJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lt19HE3y4TTNb9Ldk0OtJlPJOQA2dwpFFRI+2o5Dr5JV/YLxjQcMGlojpO1xWf9B0InBFl3q4wayzCvqfRs2VPJbF17eKEXSXuRe5Lq8D500OnJ0+PXpIv6P1EKtyWdnJXfsXw8beA+QMh0MObteEbkY3yY1e+6UM8afpmqA8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fb514c8e18so5047646d6.0
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 09:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511574; x=1753116374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/o6ziwteOEVYMZQiG+YMtyCbo+AWmLMAIRkODLXCJM=;
        b=w1pGSMU41RT3/QlR0ZhvYr+TKypNrzx9UFldnjwFeNBz7vtpB9u+M6iOUhB0+v5vKg
         h5efsx+HhjsfmyjpkYE4u9TeH773S+NCSxfogRkWd6+OEl/T8JM/p4tQdZsl3+Tj6JtX
         pZcq/mK64ADMCUAiCeL9GC2XtpAdxne/x2UxepkL9DPy94g+bSdHxEwpj4ewg5at4bJ1
         B8IyVnXFwAf7iyxaeasQFGmMuYvIFdLkGXeRHPCMAwS5oVVTpx+g0oHJMcKaQoKGM/ir
         Tc9Mi6jXLYj3El2ds3EC3ZASjhSPKw7nF+HXbLy151Nl5jL+r2vX99KAlTJjYIL0Ki+b
         kXrw==
X-Gm-Message-State: AOJu0YzEE6PbLP1HeygLGhVSLdqNgKx9w6ywHntDfoMY2iPwqvtSJypD
	FmINMQ3uGYxKICh3/NgKC6F1O/JgVJG+VqrRlZucZBuHcjHucnC5NjeqBxfs83szXHwgZiPzJLV
	vx6bArQG7toz8IBwQsSVs0qyqfmKvTFs=
X-Gm-Gg: ASbGnctq8H84W+QOwSQEDXkm9AHnyy5he4SaNqy9oubvZXnVbWK89lgimxX+TMRXqmo
	/nq5P+G2Agu9blp/bhjiUYsI7BPLzLnZoRHKKFnp6E0JTB2JMA3zIMOjN+9zOk1GbsFeJxVPZKz
	aDhaKTzaYUtX7MUPfvARAI6UTOZ+yAzJ2YTqjjmGXgGjXhjzDgMOGPacKvvtt3W9i3m5qmOjoCM
	PTo6UopfK1dKwX1V2afHBUT9LdoLGN7iCrtLmvZ
X-Google-Smtp-Source: AGHT+IFHkyb0+aOKuRc9trnunsLnOIJm5E98Maj1jqDfUqbhusOh3LSv3MArE3jx7SqRfesUtSeAOeqzrIkzLJbHrxY=
X-Received: by 2002:a05:620a:179f:b0:7e1:a4c7:a819 with SMTP id
 af79cd13be357-7e1a4c7adadmr314711385a.11.1752511573744; Mon, 14 Jul 2025
 09:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk> <a0f9182aa20d0f956072a3d185a2d1288f1bd842.1752499610.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <a0f9182aa20d0f956072a3d185a2d1288f1bd842.1752499610.git.phillip.wood@dunelm.org.uk>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 14 Jul 2025 12:46:02 -0400
X-Gm-Features: Ac12FXwNpMeLGeFtvxUKMBiYi_3lUovU_KNaZVkld0vZl0mb6P-SA0vfLbk555Q
Message-ID: <CAPig+cS=tEO90WnATueFM8FumHcq9HkPrfa_JUCzeMkDaLsYdw@mail.gmail.com>
Subject: Re: [PATCH 2/3] git-compat-util: convert string predicates to return bool
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 9:31=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> Since 8277dbe987 (git-compat-util: convert skip_{prefix,suffix}{,_mem}
> to bool, 2023-12-16) a number of our sting predicates have been

s/sting/string/

> returning bool instead of int. Now we've declared that experiment
> a success lets convert the return type the case independent

s/lets/let's/
/type/& of/

> skip_iprefix() and skip_iprefix_mem() functions to match the return
> type of their case dependent equivalents. Returning bool instead of
> int makes it clear that these functions are predicates.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
