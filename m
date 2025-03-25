Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC71991D2
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742946900; cv=none; b=BWu29MXCuaPj2ZH86NcYDf0VUX9k7nw29mkHQFqUdjThIixo2GVn3Q7QwcZI88eBVd7+EcfRnUaRLi9JRri9HG65NPw/IsklRRaSzYYGbq/FThwt4ny+xNUo/i9c038oAoN+c4KX0CNR+qxzUnQ1bPHxxP8cTnxi1Q2fsUuDN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742946900; c=relaxed/simple;
	bh=xOaQw5FsIlMUhaVroM/f9V6L8GgsGvsoeH6vOfJ8Cok=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f+M1mUVmOO18YNsqQwXV2fkrjwZ9aCQzcaN4F1IBd4MKsVK8h7IZVv1lm4awWRRzXxwyY8f4OydLOaTZqpBJxzPBphRC/NE5YQa/NdmVMsMrvGGi5BuJCXjV0dD1I7jWvwhy3LCANP/u69yEqrKbT3S73fOidiKe8Oq5ccnRX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOEGpKUp; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOEGpKUp"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8fce04655so57011786d6.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742946898; x=1743551698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JeNx24paOjhvkoeQdZR3IKfpIlAPc70/TLXMcVBBzyM=;
        b=LOEGpKUpQZUYuuD1Px97tsFFiB6ZYl0xSttvTbIMFTYqdIwjMKo9C2JjUpBA8iAiqH
         8Aq81uScyrM40C7LqitrYGvcuIOSJ565pShZxJ+eMQz65WD3G5WM99kLZ0/jHNQ95IM/
         VSNeciMZ/8tHPIpMD/8Wd47zXHLw/5uGyZ1u/XCKIKuDvIcoIqdkLerjgh1PKvkjq9kp
         iWmk9645fsyUklPcJmU9O+tEzJuvZmrGZQ0ekFNrTrOX9PKjQWpCMQ6y8rrW/qE3gMXH
         cncUIT0uAmYMPxLgY8z6lr6UypF2PHH7WSwmyp0ozfMTTpnBbBaSO8sKbqeP8pEIFVBo
         KOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742946898; x=1743551698;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeNx24paOjhvkoeQdZR3IKfpIlAPc70/TLXMcVBBzyM=;
        b=dZM1OhsN1VS6VNK56MB8QxwtnEBvRHk6lqeWA89t52XhKoTwlv/S3fR9dO/GsWbo8L
         6k8Sx0hA7VchOKtLwUKoTFIElza3OpkVv6jC/U7SgGJaRvse4XwQW3rT8XUCpmwyBBWe
         Sczwy/IfvGmRv59SacS6SsnVWrf+T3wiPznDlsedxgwpNXl7YeYduvTsI2t+4UspUrXW
         PUCBMFlVhW1Fu67054ltFwJOzf6A/OFcTKF18OFzdCzCv0iDnrH/lee4mRlb89gONVv9
         FlDVUNA9KghqWfvVKkL4P/QCzTWNCTHGVK/EoPQtHpljk5EB4ceX08C3kyLi9QGer08O
         qXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4w+6IR7HBtqQI+4K6WhhrkWQX+shYEvJ7xcgrUVAK2qnvLG5enEL/CLpD9pHwFAmpxeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0es6qJX0Ul2W9I9YuSGfIom1VrbXIZwYrNVa+LVsho2s1immQ
	G8xHV1IhdRofo9yTx0QND28Uec7P38s8MozqgskMTBTfEWPdieJE
X-Gm-Gg: ASbGncsVEfbhSftdYycneFWd0o1z8MQUCACF1LQ3qpmXFH1miHTUEk2clJbwWSCi/5J
	IbndsAX5vKHxZI5uW3auQU7Ywt+UxUJ2i3AwgFAFkCdta5/d0UnZ9IZaqGOsRwJedwvBIGSe5Zm
	hxw3rROizLG5BOEv6dEc60ShFtS8+QO3eJF3eJPi9AA7Gx/BumIK81u1gJ98GPDG1nfTstx942M
	Ec76fiH5D7TDSJ47y8Jg55/eQldhNAH5RK4mqoCv7fJVzioGdV0fWnGouCOdKnaN/1qPT2mBtP+
	wlnQ/Bvspg5D+Nk3IkJjUlVh2NawQB9oBPQb78dFyum5yfzuy4balDwJPPcQU9yuRrUb9l6KYLY
	rwlCFFcnNDDPBm1JruMF0QQ==
X-Google-Smtp-Source: AGHT+IEm4xlNkBktAb4quSIMnczsFjbw2JqythWrp0ns/I+sr/J9NvfCe45hilhkc+IclXB5dghFUg==
X-Received: by 2002:a05:6214:2e0b:b0:6ed:1651:e8cb with SMTP id 6a1803df08f44-6ed1651ed94mr26248646d6.17.1742946897535;
        Tue, 25 Mar 2025 16:54:57 -0700 (PDT)
Received: from [192.168.1.174] (c-73-143-206-114.hsd1.ma.comcast.net. [73.143.206.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f5e3sm61208036d6.43.2025.03.25.16.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 16:54:56 -0700 (PDT)
From: Nikolay Shustov <nikolay.shustov@gmail.com>
X-Google-Original-From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
Message-ID: <6977f08e-3c49-4bcc-9ab7-e3cc61a78396@gmail.com>
Date: Tue, 25 Mar 2025 19:54:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Nikolay.Shustov@gmail.com
Subject: Re: [Question] Moving from Python2 to Python3
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <022b01db9d99$e68785c0$b3969140$@nexbridge.com>
 <Z-MgpuxFQ3xEgvsU@tapette.crustytoothpaste.net>
 <66e39a95-09a3-44dc-ac71-a6c02b5949c9@gmail.com> <xmqqtt7glmut.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqtt7glmut.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

You are right, my answer was over-engineered.
Instead of speculating about what else needs to be done if one decides 
to set PYTHONPATH, I should have just advised to use the OS specific 
method on setting up the "default" Python as Python3 and be with it.
Well, unless the dual Python is needed (git-p4 running with the Python 
different from system "default").

On 3/25/25 19:19, Junio C Hamano wrote:
> Nikolay Shustov <nikolay.shustov@gmail.com> writes:
>
>> git-p4 is designed to work both with Python 2 and Python 3.
>>
>> However, changing just PYTHONPATH may not to be good enough.
>>
>> In general, it is necessary to make having PYTHONPATH value and the
>> version of Python executable which application is run by, to be
>> coherent: Python executable has to be able to work correctly with the
>> libraries PYTHONPATH points to.
> Hmph, but isn't that the core competence of those who package Python
> to their target system?  If we run something with /usr/bin/python3,
> without any strange customization, that binary ought to know where
> it should pull its associated standard library files from, and we as
> the language users do not have to worry about it, no?
>
