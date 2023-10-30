Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2772A18639
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By8lGDgB"
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6BCC
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:13:38 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a29c7eefso6601864e87.1
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698678816; x=1699283616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/LWUTfnViMjKqbK7k9k67NrJHgb5zbNo6yT90t2aCMk=;
        b=By8lGDgBDJ/eObSIQFPRChTC8skzwL+29k2nlB6w6NSUTTM9Us/rvl4vEBLbbTL3o0
         BJpS2MK3xCt/vwpPVNss4PDrdHjsfFyEf81/P8xIc+rzyQm0lcKbW4MJma5QGMW1VGGL
         zHU+Y/gTFmR8PNJGv1ZMuMxYIbQxE1p9VWvGwUZ4yQBh+Az5upq8VkRjc9qI/AQQhs0m
         gq4l3+PfcLR1ZuFtf7id1f4Aok+mmGXeGUtPYOjUN9zGJ8DoGXOGI+iTFEBZGGxentLV
         rpeMCOltMEUTtEnUxyA9gwUckd96KdffFzQBj5IKPYoZXBfrw7ynzNUQLCobI3FviqsV
         HFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698678816; x=1699283616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LWUTfnViMjKqbK7k9k67NrJHgb5zbNo6yT90t2aCMk=;
        b=B7eUN8Z++lbhzvo11CKHrKJ1ajnmNfyVLoZDYOf/FYcFXcUn/7hjVBJ19svTZlBObU
         cDNGc6OFIlDzphl6y3g4NeoHx3w7MEV4pAQCcJyjsI90+j05D9Lz1z3WxJKk2TS/uCog
         u8w/PLw5u64qIn12xR+fB2jpOZSzpyryC6GBhdot5OVcX4Q0hbsJuE7IR+sxBlWvZh5a
         HZXi/4Ni4H8Bq78nlbTxYupdv400/tCYlsYlixFeFmUg71YE/Qe9H80ADPYQq4nsW8xh
         s0+kcYTTsiWB+u811ZLYuJ9kLR/pDtS5WrVhjm9DkttPW3DV48jYWEvJMjZrW3NLleZE
         uEUA==
X-Gm-Message-State: AOJu0YyoXqGMyPxwuhCZNZ3C3pafB1VQYq5ztveaB4MToYebcyUSWROT
	KAN7vdERepa9NECiDv8xXja5WoQg21o=
X-Google-Smtp-Source: AGHT+IHNYnYy7uhYVjyeeo8dLtLMLK0TyYvNXdyEmqyacNJNLtpr8boFw6YQcuvf1pmyc2KcZ6OIWA==
X-Received: by 2002:ac2:4c94:0:b0:507:96cd:e641 with SMTP id d20-20020ac24c94000000b0050796cde641mr6262089lfl.51.1698678816273;
        Mon, 30 Oct 2023 08:13:36 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d4605000000b0032f7fab0711sm4984651wrq.93.2023.10.30.08.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 08:13:36 -0700 (PDT)
Message-ID: <d675b51b-c50b-43e4-b127-650c0e24d3d0@gmail.com>
Date: Mon, 30 Oct 2023 15:13:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 7/8] ci: install test dependencies for linux-musl
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <cover.1698305961.git.ps@pks.im> <cover.1698667545.git.ps@pks.im>
 <f150d61a1ceec5dd6cf370c3f4421a3e2d9f11a3.1698667545.git.ps@pks.im>
 <ZT-l4qDDNloizjxl@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZT-l4qDDNloizjxl@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 30/10/2023 12:47, Patrick Steinhardt wrote:
> On Mon, Oct 30, 2023 at 01:15:10PM +0100, Patrick Steinhardt wrote:
> But once fixed, tests do indeed start to fail:
> 
> t5540-http-push-webdav.sh                        (Wstat: 256 (exited 1) Tests: 20 Failed: 11)
>    Failed tests:  5-11, 13, 15-16, 18
>    Non-zero exit status: 1
> 
> Seems like another thing to fix in a separate patch series.

Yes, or we could just leave it - I had not realized before that it was 
only the musl job that was not running the httpd tests (I thought 
install-docker-dependencies.sh was missing the packages for ubuntu as 
well). Given that, the status quo does not seem so bad.

Best Wishes

Phillip
