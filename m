Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEDC277029
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534558; cv=pass; b=NAHz0ign86Ik20tfrCsLKlUg+kUJcRFvcnzM7j3+RVzf0fE/YK+PWUqTqywYAIPtLS62RHg5Z1Ff//xWX8+ErpWVB/A6n+dCWnUqUZM7knRoBN5GvfU21SYVhD+OpBS8I38R7GUJUrle5QmzjhTtiqxIOTWepd8FMwf21/YeqZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534558; c=relaxed/simple;
	bh=/IlMeLKhlBPLcvwCnhiJRYmsHo/fhryA10CPgdjHTC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8RzFJ+61oNj/0Y+zQbo3WwfFpyyklA2MTjkKQVx2xCfhRHIQ7TNhE2AzRvpNEe56gHGZ6rKivjEx+oLIAgfR6r3fiPAQ3GW7i9Bakndlf3wcc9JYlprO/yASC5QIAiotC8EVZO39RW230w0naU+WHZZ8LIatvJTX9y+YLM61yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn1/B1Vg; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn1/B1Vg"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84832ec2615so107556b3a.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 11:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783534557; cv=none;
        d=google.com; s=arc-20260327;
        b=qosJuodtnuudVlYOQ73uiQJ8De3RcSNAMMbA0KWJe/ewHsaOAvRcLPYZMEieF0XG9a
         p6ypECDSj4GoRcgRIA3/dppf1bO3NwaauvnfEQQQQR/CBVo+U01vcDTW4+NwQCJLtzzu
         D421pLSaqEHuzCcgJVyRpNuvrQx/BqOU8sk223IF7ZALzTwAsrz+Q7hlLDJ1xN3xWAm6
         1FNQ/KmoM10J4/4gcgIa4T5G0wFxP407Mtw+VdadSJGHnhoJMbMDxqG3KGN6I5uqzuxz
         bOYnvebb1lLccuuogmM8VFiQD3kdOmyb45ItKXE3su4e5l3fGrbEVTsNOsGEn6gHVZSA
         27uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/IlMeLKhlBPLcvwCnhiJRYmsHo/fhryA10CPgdjHTC4=;
        fh=xFkGNlwBTIbSQlTAuP7IICOn+9qF32ywGtU2a0gtYq0=;
        b=Noh850ECNivqKZIeGAEXrOsBLeTp23C71VaqwxJ90npqI66YVc64wDrn25ER8bDus0
         7XPjsj5Izd6j9/xKvDzsj0IQqpbS+EB5TGpQYA/lIBfrgwVKEnRNwgtEEvB2Wk406Wwp
         vzRcWxAKDRdu5+nQ91HhVjqrB6U1Paoem3qN9bIsFD1cEZ2pbgM5feZ5WnA9WEe9TxnL
         AeJyj3iNNHB0Kf9oKZZtXYNy4GiBSTLc7Vmi9eRZ7e6VgHyA7FUqHR3jQtFMYQkEfKHN
         1pWUhYZpWNWw/1ExDzLzfGHpg1rOyjIf2dAblyWwf+zoIdejRFwMJcQmrc7nvw1OWyD9
         Y2Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783534557; x=1784139357; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/IlMeLKhlBPLcvwCnhiJRYmsHo/fhryA10CPgdjHTC4=;
        b=nn1/B1VgVoONDNTLCRTMToni5x3AFg3c2LrdY5EE4xlLWCAowqXqBJf1/pZPmB1Nx2
         VI9FA5KO7O8wgpXd/j+WDYsDywnjFyQ0BpNfCOc3THWXuFMUaOoq3AYQ9C6S5M5Fld7O
         u502jpZtJUfNKnKiHVctmN9tzCs4uYhb7rQ2lM9QCCdwRuyflceAG1nH+ZwkPq6b0vrD
         oGe24JM+6R5w7EePmYA10BvjMHvz4iPAZy3BM9m3wsex9doQjjlU/qFE2nvF1EtXdcLE
         HUgFi4xicPO4Gbfz81VygV72Cb1Tv3Ow5wr3OjaoRh23Zp0LibiVWyK4MsrceBa44Fus
         MKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783534557; x=1784139357;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/IlMeLKhlBPLcvwCnhiJRYmsHo/fhryA10CPgdjHTC4=;
        b=DnJbNO4zVgrjeHTTV+kc/ohELyR2ffkp9DFJpmfdYtkns8ymgkrGzoP5V61FYDRMqQ
         oE7SEmygxTuF1dG1tADiBosHVXaYVI03Qhtv6IrvGO8nqxqmliFTpRhYhBvIhV4xdU1D
         Do6vCtwFwDsLFKR5OaKjAH3trrdY8EUrk8LN9xJez50SNdAcsoUpDCRpDilDvfw3Vt6j
         IU5wW8NuXiMo1JOcs321T+j0CkyMp42ldvtbTjn5/3H/xkvEHkwmqSrnNAlb+cID0gmO
         SEF0S1sJvSBidQbrhIL9850rOoZHEskHpBHlTeH5qHLtgD6fZs0fe4ZUCb5IGIR2MIMI
         t0BQ==
X-Gm-Message-State: AOJu0YyA1LJGp9jchNyJ8UOsU22nBXVl78N6xfmj8Bd6vnRACAq8D+dO
	kBPix+mCsvPGOCVsC2Bf6LhKfrF+ROL9YGeiaD1OX+x3XMusWbR+PZs3GQ/lEBHUWfenc8yvaxg
	WvvASvGt82ZsbX1owrsacvK0vPDkPhbbvydJ+tho=
X-Gm-Gg: AfdE7cluyg1hqpBiUrjwHgwK3gpQIu/MdsF5vHZ1d283cWO7vXgeSNgFhYjTaCgik3l
	WeaYHfPUQIlY14twcX8od7uL9QbklrXTH5AXan7j8ZeP3/0ETLGiBCmUrO7USceJ5FXuxUsbU6N
	Y/m32xpqwLMMB7gJha8AWQ6qLPui3OHs5MaHLjpiR4aS35KdJ1TUWcAZxW+LWpLHpMz5o9t3gzE
	vxSH3FOHWEI4gJxUkS1kcD5FXrLDjZdhzQRikhX4HLd8nBHJa4qbfpznZ71Zk2uqZNYsv4ajYO/
	cB3GojwfW8RcVPaHGvkVYvxvb9p+Tj8Ku8p6rK/zLNLvG0TpNgzZk5XUUgziHXSIRmQt039JNuK
	s25SI5P7idWbOK+ey
X-Received: by 2002:a05:6a00:4292:b0:848:2c6c:dfe3 with SMTP id
 d2e1a72fcca58-84842ee3fd6mr3818259b3a.17.1783534556890; Wed, 08 Jul 2026
 11:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGWgyh_WJ2mAgbJ2agp9UQm8iyR=eq0xWjdYT59CC9fZTnAbzA@mail.gmail.com>
 <CAGWgyh-Udy9p9yF_8EDnVgK4bxyG9BsX1gio8oKr0G9b-sdQFA@mail.gmail.com>
In-Reply-To: <CAGWgyh-Udy9p9yF_8EDnVgK4bxyG9BsX1gio8oKr0G9b-sdQFA@mail.gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Wed, 8 Jul 2026 23:45:20 +0530
X-Gm-Features: AVVi8CdKwW-DO6VXLOg3o8FOdRxlyz1heSwsDrhMwL9fZcbL8Gmm7W6HofYJQJU
Message-ID: <CAGWgyh9154HAPs-YoMz6G02TfcLe3CCcd93TJjg6e+hQsmZxVQ@mail.gmail.com>
Subject: Re: [GSoC Blog] Week 6 : Improve Disk Space Recovery for Partial Clones
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

My latest blog post, covering week 6, is now live:
https://siddharth.shrimali.info/#post/8

Please feel free to review my work and share your feedback.
Always open to discussions! :)

Regards,
Siddharth Shrimali
