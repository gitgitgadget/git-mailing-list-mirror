Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8164DE739
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473157; cv=none; b=uIJ7T2wQgRwkiEZ1ApACj4f66yTMsLEkaQOX1+Dg20IH5MU2DvBAy1QL5uLjWYAXXUhzET2u+pAVlwlGsrW+NsMkvJBQR5b9vJOONSl0ccMeCtVqLBn34uqfNDFhgoj0prxTXVzDDu3HdNIbqCf/krqoq2d/UHBTgTxCOJ9hjVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473157; c=relaxed/simple;
	bh=G9uceI7FUPRnBodzQ8WxvMrzsklqRmA2H+UCzg2Ow/Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VxgnrZTeAVoXsen96nEj5AGiyjGvspJebadZ1zheFka9I4y3kPdVM+RQPOummQtWATdZEfBZLNW9acYEizloGAcdymfWiMVKmWXN6/YuqgKyJglU3mzxWedhskQUqPm38UGTaFds7yYp5MQCrmX/EWiYSi2f2miIK0mrHOZOIKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/5Q+NHv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/5Q+NHv"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a168355946so28999145e9.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791473147; x=1792077947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IUJ/DFZAmv8EAIxc5oYDWKYZAG7sJNvTwvg11ZnPH3Y=;
        b=C/5Q+NHv9CVUkyW4ZgmLBkUJKP8Q5JsKoGNv8TXcJsNQ4V3CCrBTLr2u8f4gCdDie0
         6ihLI9HDc74xUNKEcni7kQf0x0w2Tm471yqKeWCxAYPLId530mkSrm7FJMJQF2CJoQqa
         bMIImh4zVtV/L7yqFOvvAtB+IOe3i3vEcCJLicfSxZp+Fy384YIymE2sKJvX5WjQOxpp
         8y1IsbCDgyB/yg74PB3XYl5zvgy0eYE7aqXra4CqgXw10yf3QQbek16S1+OstE4IopeH
         2lCi0scKCtuYZdt8toDpy+BVTko0+Dij08DhB5nROeJmwA6o9fBynMO1YXHX1vsxcHz9
         Ll2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473147; x=1792077947;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IUJ/DFZAmv8EAIxc5oYDWKYZAG7sJNvTwvg11ZnPH3Y=;
        b=h0Iyey0dCXNm77mg4Hax2l+NWQI8PUa9LDW/qN8wzH95n9g21Tpj079yAZ/3JS5nZW
         EYgWsNIGAggNeddYTJmshvi8m4a63kTcn1eSlLDhWxiWL0CX5wGROcunOkdoKxdLk6i1
         rXTLQ4cF3SpT6T6/WFOx3Y1ahIXyu3wzQW/BH0Ci94y2EvaduqyW7yQfRiIgwJYBOCs/
         sxoI4ahXMjIqFbcvpdiPEblBZxeEcknwqfV/SNgUGxcD06Q/LIUrC0FJJLSOUBas4bD5
         HnRLAmP1W/91fJJUdGm9oTWG5OB5ieCmTJD5QA6VqQHfaWZWPoYBfPYWb6Yx6aNVTSFp
         69Zw==
X-Forwarded-Encrypted: i=1; AKwUvBwp7NaFyVWg5DPVcuxi0uPxqWUbgs/qjJDChxOBhw0ghT4afokU92+ZnzoNla8CSRJLsiI=@vger.kernel.org
X-Gm-Message-State: AFuF++nklEE0KlVvdr0v+5fN+YHPSK+Qu8V1NMY3VLFHlvBW2kY1Csiz
	Do8PpJ6gQz2yaGWAJV0g+vszv9SpFx+EQcUf/RaEWCdoXEN+tAYQL2nF
X-Gm-Gg: AYBFou2ycZeSi6s7DfaIDKH+7b9thysezTPGyqcjv7QSzFRP1k8J8DSP6dq6sAmV7TG
	Xo9JkUo90hs5g0OsasnvIlvaBesT9/iJBc4ZyBcNT+jomJpejw8OmlXgaPeT8Y0yGCp516kk5yl
	7/eOKIFCOvl+9F1GP3nh/O9KlwdsiuYTxY8UykOnzYZszDjIhblOJ/Wt5Mbz338z7GQVxKguXHo
	QxE01XsDJXwk/LGV0GWTLRw35Z5CZFkfw+eS/axeNSCFljojPCZy9CHnw8m9pnF7dTdOYnKBCeb
	wbf82UyOyo+859wOHRUPDU07dJsas8Y8xJvVmV6Vy7YieBw4W9HKo62h28TJ+nTQdmHQSsAumpK
	26RbrK6lxKPvXqLnRvW4BXIwzi3McGB5WAQJI04PeZKqxTy6IRjJGpH7eG3HTHcsH3MFW+9Z3qO
	sROk0qqmkFZxfI3xBFWMKzaPdVRpn7CvBlgL+QSwHzGMeQkXLtgznvfb4QswHOMrb8owMK+FNoP
	KMYc+1Qu2EgoWGOVprw1xtpvLVQjAZLeTCaSAD27wTuA3Dg/siP
X-Received: by 2002:a05:600c:548b:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a18045f729mr108561115e9.29.1791473146443;
        Thu, 08 Oct 2026 08:25:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db653d833sm124537f8f.54.2026.10.08.08.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 08:25:45 -0700 (PDT)
Message-ID: <61ae371a-225c-4400-b878-8547547d1269@gmail.com>
Date: Thu, 8 Oct 2026 16:25:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
 <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com>
 <CAHwyqnVoMnO_fYGJ0N29bQv=Lh5naZ0jc5uSpiS2urQMZVG5-Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnVoMnO_fYGJ0N29bQv=Lh5naZ0jc5uSpiS2urQMZVG5-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 04/10/2026 23:28, Harald Nordgren wrote:
> ...
>> If you know your repository only has squash merges that were not rebased
>> it would be a lot more efficient to just look at the trees and
>> merge-bases, especially in a blobless clone. Having an option to turn
>> off the patch-id based detection would probably be useful in that case.
> 
> Maybe yes, but for users I imagine they want the interface to be as
> simple as possible.

Agreed, they also don't want to wait to find squashed merges they know 
they do not have.

> I'm iterating on the code on my side (sharing logic between branches,
> etc) and it became fast on my local Git repo. If there are no
> performance concerns then would we still want the option to turn it
> off?

Even an efficient implementation is going to be a lot slower when it is 
trying to find branches that have been squashed, so I think we probably 
do want a way to turn it off. That's especially true in partial clones 
where we'll have to download a bunch of blobs to do the squash 
detection. So long as it isn't diabolically slow enabling it by default 
is probably fine.

Thanks

Phillip

