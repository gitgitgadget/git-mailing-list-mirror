Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120636;
	b=sCDwg+gX6fUKKmbFqg+kEa6MXSYYtfLmflIGnKo+XqFisdPGcfGrKiLiT8RvFZ0jvATg
	 pAAddu7wlteiF4TKNPmdQJ26JKIyODs1+W1faAwXzSkIP9kMQ8vXCnrxyAgpBYPA4uAII
	 r41h4EGCCzPDx495K96JNvH+4sJ1iElocg9knMHrzD9/vpFchWw89T5N0yeZlbSbxc8og
	 59sAYIXKDk3cIjVj2UaR4hWNNIbM3WLWXuxrVSLlwJ/ThObOj2vtbLVhaoaKUeGEicTQl
	 no/ZZxd8bjK4RejIAVdNCk6XD7bm8ZPSqExiwDkoDJm2llDeQ5T3iINizpVcolryjjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DbzIlumBx1vkp+oGrP2I+GWgieeQtjMkRzhl82GR52I=;
	b=YPSpC7NT2FP41Nvs3cc97ymUY/UW3Fc6wvCJA0i63gcbGj+IYv2pg4F8GTYsTtigIrap
	 AVemQaYAdm6WE+wEOs61EwSDsB9+QE8tWip5IFvxpQXLxe/kXcuPhTKZWTaue3cciF/hX
	 velxDKvok1scNZCFsBOZNcCUHwvYdVzeSPslOPZxd8paQPIl4L/jkjsigifdxx/o2Frsl
	 6yJhLn9AdTQDH12ImpbNj7EQdJiMHUF62wDUW6NKwOMSEHH46amEFXGqLjWyEaVhvr7YO
	 N9+wvtRg5WSu0DusEyyfH8fvSHCJG5Rj9HRSHy2QtNB6UFytikxrVbdUDgP6FTmw62A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wOuoanDw;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A48F606A320
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A48F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wOuoanDw
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so450565e9.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793120634; x=1793725434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DbzIlumBx1vkp+oGrP2I+GWgieeQtjMkRzhl82GR52I=;
        b=wOuoanDwjEB8nIJ+Cm7GQ3pZpHI1BXWe5OJLLCw5lWfzyislaa/5MQhrjJRlvCFcdG
         Ka7eIKmwZ/DtEmodSY7pX+Gh/DkuYYstDali76RkXtfP/oeIUDH1EG60YcJ3U+jzJEH6
         l6kphjy9VBJDw9YN9JfAmj4IozZ+Sh8SemAFCpIDtuE2YgztCBmqdMqhw/+nQcpNMJY7
         zixTOteohiVFMn4loeVkYGxpPyzfiUbT0rc3okdmhPWON504Lq0RiQq3bdPLuTP8P6NU
         PcsehaiyPVvVwsm66WcBLy3/gF4fWPqcxrIC3iLszJmtUhSAuteCMpxMrzSQAWAuuOFZ
         0HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120634; x=1793725434;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DbzIlumBx1vkp+oGrP2I+GWgieeQtjMkRzhl82GR52I=;
        b=KVhC2LlXK923enrDbdMQCPFnHuksNfJdLikVbw+5A6xrX0esSU1X4uO/etemdeSNhf
         UE9NiyeeC5iYeKWqd4xJcFsUjuUFE9HUVcdxZxtWg+XSBgzkK16tio57r2KZW1CNjQ9+
         4Iltbac/K1frjGbx7bolY1pEmCNGsZjWluDAcWC3qWIp19gskP01opUE+MV4O/soJ95b
         g3HKJkxZ6Cz8xourPDojC9LidspkqC4uvQHopmtnNpEDvlES5KlAJhydH0uuuXL7xRaw
         9Ib9KWsk0IdGpejQaQb4Zj/s/nMltC3HkKYGjQcFkrlD3KE2ribzmZtqhCBx0iXpnkR3
         WDkw==
X-Forwarded-Encrypted: i=1; AKwUvBwrO1WkRuMSqiazMI+kZBPJe15arYKvpLICqA/BmOj5CHwsEooJRyWF0B6l+ZABGGQXBrQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2/XWVnRH9J82XOHJORK4T+cPlkM/gmv7WCjQQJloHJ0q988xo
	6Z1FDNFu3IN+YQhgKl0wQZlTgLzDBC+weU7O+BBwBVS5pf7v2yciTOlH
X-Gm-Gg: AYBFou07VpAKlOdDLxcdMt1jgnOuPpVJwiEVqK+AfUyKSD5PXV1nQXvqdzGroWV1XT3
	QaXB1QB6nv+INoueEL/2+hHUjPB9S0stJhdSRp0vwekvoR4bvigvp2NTfmmkNZUggK7d1b7WOyW
	VQOfDU0FYFeD1r75oZlF1CBnjWqmjaW4MnATVLWzmOJwp0SeoubOpaLkmqCkYY5RiK1HjAxDD7a
	mw0ESEUjq5zzunrhzPK5A6hIxqxYJWxN3Nw9kkG17XVT6PNSaYZvTUVHAneEovAAADR92ump4zg
	Xv0qwpPwrpF/C/xBsN8uO4p3PJ/oWFyYr/CooVn5pRpT+m9WahGo7yYD+CBq6A6AFhsVXSogao8
	9afdBdeJOEUnUd7688phntR/DvpPSaYJaL5fSpTyFtqswHxsLAHdCXnwcwY0pzWrJjagtK8h/6X
	LNxISfLigsuUEGRP4LP2jadlK5fQZdgKfvtLxcvs6fZ4gmK1ydFJw7AzwFqJpCapOjbngfctAqI
	t5O7AE7ZAZ8smQI2Z30J7voivednrchnrKtTPdfyx1Ht5JuY5Hckhrlkiqzs5GkZfN9erX+9gn3
	cyeH2LRfyW/1F62gNEByWAngWTgar7Us/A==
X-Received: by 2002:a05:600c:474a:b0:4a1:d97e:cd60 with SMTP id 5b1f17b1804b1-4a35ac91f2amr219230005e9.16.1793120633681;
        Tue, 27 Oct 2026 10:03:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92d182e4dsm3613405e9.2.2026.10.27.10.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 10:03:53 -0700 (PDT)
Message-ID: <7438f8e3-4969-49a9-a0b0-41520ee35aa3@gmail.com>
Date: Tue, 27 Oct 2026 17:03:51 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
 <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
 <CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
 <CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
 <CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
 <xmqq33ttxw9h.fsf@gitster.g>
 <CAHwyqnW=W=XnRs210h1VxA5KWxdObwihCty6Gthiwh6+hDkD8w@mail.gmail.com>
 <xmqqcxswtqd0.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqcxswtqd0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/10/2026 15:48, Junio C Hamano wrote:
> 
> I actually do not think we should have master next seen on the same
> remote.cabal.fetch configuration variable.  It is a multi-valued
> variable, so it should read more like
> 
>           [remote "cabal"]
>                   fetch = refs/heads/master
>                   fetch = refs/heads/next
>                   fetch = refs/heads/seen
>                   refmap = +refs/heads/*:refs/remotes/cabal/*

Doesn't that cause older versions of git to try and update the local 
branch when fetching, or is it only when pushing that we'll fill in the 
right hand side of the refspec with a copy of the left hand side? If we 
use a different config setting for "what to fetch" then users that want 
the new behavior can unset remote.<name>.fetch and older versions of git 
will fail rather than overwriting local branches when there is no 
refspec on the commandline.

Thanks

Phillip

> 
> And without these remote.cabal.fetch configured, but with
> remote.cabal.refmap configured, this command line
> 
> 	$ git fetch cabal next
> 
> should work just like
> 
> 	$ git fetch cabal \
> 		--refmap="+refs/heads/*:refs/remotes/cabal/*" \
> 		next
> 
> I think.
> 
> Thanks.

