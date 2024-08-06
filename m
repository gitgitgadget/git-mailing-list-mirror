Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C23C485
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722968429; cv=none; b=ExhN8yorEirsBqvMwqQ3SuCrphgsPjK6zvk2eOtisDPo8crMm9ivz99MFYqVFySDFQCW3gvI0UZKJVFeAEYJQpUunPL06OD8Y7PSxTXdLJhaeua6MwldpwsUss8ivS1elPdCY8P/5Np2iQrCzcmkEOHf3+LArMdOE7zzYqQXk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722968429; c=relaxed/simple;
	bh=yBDdilngWVR332mWJ5RYR6o/zTMZ0ISwZW1iB5Ecs3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aw1ab0Dma2q/zpyHa1LIVTbRE8eYR+riHhyE5QWyPTm8WOgzqo3wmUbbKHxx8X3XFQGxzgL9Z6nV6qhB7XSYWoH0gtaNbpBlsa3+us96AVdL2NdeGxNueHKI4lGYf4hja/5TA9CjuqiENwW/t1P63YIgf2GoshnfUUsyl66dXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5b1e33fa8so564942eaf.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 11:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722968426; x=1723573226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OR2Y2HLQbc7Vm1RrhFfkFYvBnulhBvN0F/GqxOuyzY0=;
        b=HTYkWt7xPa7l1Wymd4NRQEF5S7s3sWN7reAwf29H9pAD6Oa2bF6X8iCibc20n+tV4l
         o/mHntDkCK6NISQZCgFQINCJGx85bVc63cYFK3hfrGWtK5ggFj2PRte3yn8nc7DMur/5
         OCunAXCTRAm+q5HF6/6oW/6Z8X7KcVzYdOKxExiOFiZL8QR6r6UoabDJvl8f1kGS6mKm
         fePRyER5/yEgI1eqqyzJkKIvUuuwbN4sCDZUjkxJ0oislvEmSML5z+XNT9t+fKT9ITa8
         V8zyQH3XSqp+DN9CtEvss9c1ffh07oncZiXXlqViKI0Zomm2+ai4oSVO78Li14hXdYuE
         FoPQ==
X-Gm-Message-State: AOJu0YwklLB1URsv/cr8w9PCAjo1KuHnZPLqNWfCsh5sTrq4rOJuRYAv
	IBLWJVeLDvkZY0BeDwxf1wo/Xvr7GjhMyBTf0NY5GH5l31YbD7a6fCi6hZY1qjCldiXwyvZv2y3
	H+btNyZMk8e9j10RF1f++eKs08as=
X-Google-Smtp-Source: AGHT+IExLMFCleS5qP+mgBlBCz68/ky31mVgC7+Emkrhn8zRDt7jsvz5kHbAJdfTEsa5q77ieawDTWGWbgnTdRadWEo=
X-Received: by 2002:a05:6358:7301:b0:1a6:b034:b381 with SMTP id
 e5c5f4694b2df-1af3b9fed0amr1963873655d.3.1722968426354; Tue, 06 Aug 2024
 11:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806142020.4615-1-chandrapratap3519@gmail.com> <20240806142020.4615-3-chandrapratap3519@gmail.com>
In-Reply-To: <20240806142020.4615-3-chandrapratap3519@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 6 Aug 2024 14:20:15 -0400
Message-ID: <CAPig+cTLzdUf9D-u4YWURPb-ymGM9xgi6Ckc_wQGgORDmMHP-A@mail.gmail.com>
Subject: Re: [PATCH 2/6] t: harmonize t-reftable-stack.c with coding guidelines
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 10:21=E2=80=AFAM Chandra Pratap
<chandrapratap3519@gmail.com> wrote:
> Harmonize the newly ported test unit-tests/t-reftable-stack.c
> with the following guidelines:
> - Single line 'for' statements must omit curly braces.
> - Structs must be 0-initialized with '=3D { 0 }' instead of '=3D { NULL }=
'.
> - Array sizes and indices should preferably be of type 'size_t'and

s/'size_t'and'/'size_t' and/

>   not 'int'.
> - Function pointers should be passed as 'func' and not '&func'.
>
> While at it, remove initialization for those variables that are
> re-used multiple times, like loop variables.
>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
