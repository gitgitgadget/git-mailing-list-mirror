Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBACC484237
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823217; cv=pass; b=p7gg8SBxjj7VbsNtoUeDXnT/xuaKUbIZQhgz1jHtjP/5ZjSCmTQqz/dyl7IIaD0k5rD6dFsovQjBNOE8hrEUNG0BUOO8Qa3qLivVy/eRQ28mFoET/hV1sdXdTzgbrTGX/F/rs6Z56DV2LuOKPxoOGn7bkiQXt53jfAIOiDQLjl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823217; c=relaxed/simple;
	bh=pnZyTe2Z9ctu9l0CgZfgaNZJ/JWNKARp7LhFUIurbIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=du3oOTy4LoknWwHtob20qiNxzpOTJWJiQAxklWKDOTRPTtGBm8ZHAaIHveM7H2oEg1KIKvcJrhMcB67fk40x1rKVCwO1xVMguxtoTAO1p0UQAcKqkasJsf3oLF02etxpB+7vFjOWO8MzE5ikpN1ILrUozq6ifhh2JQb1qrrGrPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ip9Op/0c; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip9Op/0c"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b015532f7bso752033e87.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 09:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784823209; cv=none;
        d=google.com; s=arc-20260327;
        b=nrMEYUsyzjECq5iEJ/Impq0J1qHKwcc5hvSGcLX5YCG4xqd3PbEK5jcn5+eFkS3nfv
         RvCsGh6eERSSmS9FohHp+ECjZzI1AGwPNMcrobgTVf+kP1gWONaXH89rigFgZtU9kFOn
         P+FWjfZLr0h2ORdvL86WROLJ1Vcx3Qnjo2rhzhPjja5yUGXqCBRB2S6Fe9VhYw+zWbGY
         oTuMUE9TLPlfv9OdfbTlaYdITkf8JEwRKP4pNeCD7Ww46evYA4D26kneMk4Xg3aZuwjN
         8row9xKbY4co+JoD89g96TvaE/+4ZwXGsfrZKsTtV0/otRDaLD1pQ6uKKAn6LC23s915
         gMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=pnZyTe2Z9ctu9l0CgZfgaNZJ/JWNKARp7LhFUIurbIU=;
        fh=DJHZ7itWveYVdfezJsKgr6XLEjDMbfeXEew73fqN9oM=;
        b=T1ng8WZb8CsRrB4G6aLmaoc4egVFnHAqWffSvxvmYaWgPdjfmJZXF20YT45BVCPt9C
         BAturLOfRmnV0MjegIz2oUGT/2UvI7CdMcgkpoqprefGsjxVWdicm13DZlZnTciDlFhZ
         VWmJJNEM431i5sbnjWncJthMaeINThdP43TpJYa+z3Cr/BQQ4H0BX7T8/RGlYJNFnHug
         14Nvo7cIHBMdkN4H4FAyhr3K0D8BRlZt7vyiRoKgv4onYWbl5IQ8+kIT9T+BdmxyTPwy
         TRVyUT7G/ny+xWXHcHTyT+sNSAhZE95ASwiuCJTqqdoh47bONBmwi/ySB2EoLrg01Tp/
         mGAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784823209; x=1785428009; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnZyTe2Z9ctu9l0CgZfgaNZJ/JWNKARp7LhFUIurbIU=;
        b=ip9Op/0csQmD3rav92KYTmy6+tyOebDUBo+Hro14i43uRHeyncOvGiHpLXGcOtXGO9
         4kwLWzByZs8Rq+ElaEo/NE/DzanJKSgPtqXJFdIek2RNsFkaMu5380BXeIegGtSyWgXT
         7wFU6jSNqTtCJG1TFqGpxpAs940M020VMQpsTazPCU6ChTDTiMF54afxLbMqhNensVNT
         nvo7SsRW8oQiagWm4gjfteNrnsd5/Kll4KAwY3XEWWRa4pTR7PrxHh2VzwNgcaPBIQjO
         MvJG9kYZTw4H81tQ6QoUBrUPHs2Da/0r0GZYq3/yjiUnJVyheUtOk7FfqA2wpsyF1wXs
         DL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784823209; x=1785428009;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pnZyTe2Z9ctu9l0CgZfgaNZJ/JWNKARp7LhFUIurbIU=;
        b=KJVrqbEFlD1jCswyINHyWLKiBMUVazJVFm4Vt06B5qO2AV+me76MAbS51yVTdC1u2Z
         tcPcqlO0H7MFORAc018d0Jzi7W2W5Laf7g5/jZL8t060AO6k6CcrxaZODei3ZRn0LmXJ
         jI0wnBSuaGXWPHN10aZrOLAz/I+RxqxqukgtiXjupjEx0J83TubQdfhSE+sFOddGW7OO
         lYjMw2AtFg8fCrMgJJZJuGuXQD30d/ro7iffoDHFDRYcjW5N7XpCZg6UL+gEFHJ7FtnQ
         OZRplaH5Shg7rPXbY792JQJjRnCuv93AKogG+lAGM34thUqmLLukxU8djguz1yLqVY8Y
         mcrg==
X-Gm-Message-State: AOJu0YzbSAipkQsqrtwTHtx83eVkrVekkz1BkNgSm9VJcX9bND2dHz0z
	JqqDZSOs2CJj9bnw2yJV3Vk9ySX9YeusQk+uzQwLCxrZ7ADsVar+3y5azYh8EjTg9g1Z5zJo0YQ
	zyD7EAjwWLcIRY+EpEIKvagZowC47scy0vABy
X-Gm-Gg: AR+sD13/5eIzgEhzC7CZV09GL/gUc47JvDpK5QNGmx2/k2cLbekUHsyA8zqoy6C1eiJ
	oAHVA94r5F39htBKHGI7MvCfbOdNOXdeXdzEuPaMaGmeipdAZVfHGVGDY8CXt6IE8WPbo+z2QhJ
	UI+Y2qSpG0HVU9J0lN8qhOIfj0M9c1ASkn/EAhfvsGfReRZNOjGW7lL83N26iUccs7FlObYo7cn
	18kiSlCZf41+kO8Ift8V54eIMbYSICtPpknF/8T3u6wMSIRIJnSY3HN0O87ADDtjV4NtxAZu3uo
	cfhNyroRps2p8ZKPz+sn+W5iI6kBHYYpGQAtaJ8H2wpinpLhkWVh1qY5X301MqHNc4yyasvyH8F
	lpZ3G
X-Received: by 2002:ac2:510a:0:b0:5b2:a68d:279e with SMTP id
 2adb3069b0e04-5b2b2e59c61mr659267e87.14.1784823208894; Thu, 23 Jul 2026
 09:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLee083Whzi3b9CP3Hxrq_cz58enN67ZQq5r0koczKeU1A@mail.gmail.com>
 <CA+rGoLeNzxaTrq50jE=at=0ecnZ5Diy+Q-0McG-R+XFTQ7oMow@mail.gmail.com>
 <CA+rGoLe+n314hrbKBSU61Hn=uVQN+OqOF5AVt2gPOityUUL_AA@mail.gmail.com>
 <CA+rGoLdOjybHB7w1Wd0Or0wJUKjTOev7f1pZbj7dhAZRbs-2eg@mail.gmail.com>
 <CA+rGoLePg9MHE+OcVtKo5ho8ziNp9NBWAuWc4ZEZ2kevZf5WKg@mail.gmail.com> <CA+rGoLdMnLfVF91hP3c5bdLnAv9ViW2r9pR0yejK2kQNNWSBUw@mail.gmail.com>
In-Reply-To: <CA+rGoLdMnLfVF91hP3c5bdLnAv9ViW2r9pR0yejK2kQNNWSBUw@mail.gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Thu, 23 Jul 2026 21:43:17 +0530
X-Gm-Features: AUfX_mwnOUbEFmH3OVSd01BqdYsrG2_fV0v3qQBTO5K9tgma_4VsulC2JJ3Yb5w
Message-ID: <CA+rGoLexpn-U3d+NzjO5COEDzyAkmKXOaaeusZ6rXDxkOVYnGg@mail.gmail.com>
Subject: [GSoC] [Blog] week 8: Improving the new git repo command
To: GIT Mailing-list <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi!

My Week 8 GSoC blog is live!

https://jayatheerth.com/#/blogs/gsoc/week-8

Feel free to give it a read and share any feedback ; )

Regards,
- K Jayatheerth
