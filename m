Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A241420B8
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117462; cv=none; b=J0fUiHNE/68QNMFJf1fdYS+OMrTf/DVA9IAplwsm5LDRBlE8auK5WP3Cdb78hDEuw+PzAOw+K0qBsAAYqqkhNCHodxS+EY3OgHLcQpZ/FBMetoaJQVv4F7VhkeK1iFnumWzSTwMqq5MqI52Hwmuz3Q9ofhayf7ABcKeSYUglxbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117462; c=relaxed/simple;
	bh=5IOTybMJT7aMBmhEoYMDbN59YqzWG/D4zNwGovL9ERw=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=gaWiGlPobfl59epKHjXKgLnmUjBfM5kxF2awTvimPdycFS10vaN6w/QDfDTYMFTvCz6uJT7LPTehBmxZMX4ndUsOuxOnjUA/adKLms2njBwjEIfdWOhLPdMHPFRV9Ah5nKwcUdgIaqRXifXNIq52NHhjaN7hb7+XDJY0ARF5IaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQ+ZdNRc; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ+ZdNRc"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7873eaa0ba2so60918685a.0
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 13:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708117460; x=1708722260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmcPr6gJkX6rxO7aerudKnbiWlK+nOcj2fIzlUDjTbE=;
        b=bQ+ZdNRcliTBB33Olyn6ZvbIttpDKmhoik9BxiJJlo7NLXm0po4Pb/y1Q5Z4mxFcqm
         YAapS/8GKV3ZyobHVmUlSi+UBIz+RuIz0sfRjIZGinfhR05zsO1N9F6jbKyZ3n9efVdt
         3xbcc73HMBwRe435FyT3XL1Ygb9PBjvMevI5souSwja1qtgzab4TOq5/HwHXA/rOAk2x
         ZGtA1+0friwtc00Y0hoBabLPiW7Yf/eyAo4VMChtEe53VOfiqin2zzM63W3gYfHM5+f0
         IDWjSwJV347nR6wrBKuzdZnXsixxTzBIA6Yji8TSGOJp1Mj5BllN8dg1oj51wHr/40UX
         MRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708117460; x=1708722260;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmcPr6gJkX6rxO7aerudKnbiWlK+nOcj2fIzlUDjTbE=;
        b=K+oORkY965j/jfOhgZBcsxkNC5AzR3hLMLeroNZpA1Au38inKEJw12jElvkk8ulKso
         EKAlS6BbNilI0Tvx28yltWX/ITL6WjWwWNJZDgQP5BK912tsxUeENNfscqkI3/0RJcyP
         iNEaibwbmCL9Zi6Tx4zp5xDotrpvUfBPJJ3ll2k4uwnewanEIUD4Ua7rkTEoQj7sureu
         Pi0j5zfxZPndCq/PnaAy5RmtdOXv/sNksA6TMwME/F/faaxRmL9eS6mzMNXghJbX0k9C
         HKj9OGInQyAitYs8b3VlBan3yRMtSNbd4zAV/izoo0YPR18dZL5zzkyXomJQ7J2cetM9
         FRSQ==
X-Gm-Message-State: AOJu0Yxu23ZprLzSHjMFeMG1McnLOsp4WW6xS2KjlRWH7qS3wF5ObWB8
	8f9sgUbDdT9Qr8wrKF72Q46XlLkfoWlHd01PNjVxx43j/RtB2gK5Ejbgn4uA
X-Google-Smtp-Source: AGHT+IG6xqBN6yMv7Mqyc3Y0gVmCoaOa37VNupJ7KwdFuahdwlt6BWb7AmxNymC2z47dt8trSoqp6g==
X-Received: by 2002:ae9:e005:0:b0:785:53cc:ba81 with SMTP id m5-20020ae9e005000000b0078553ccba81mr6365810qkk.42.1708117459677;
        Fri, 16 Feb 2024 13:04:19 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:3855:1496:5298:e845:1591? ([2606:6d00:17:3855:1496:5298:e845:1591])
        by smtp.gmail.com with ESMTPSA id m6-20020a05620a290600b00785d97bdeddsm278762qkp.99.2024.02.16.13.04.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 13:04:19 -0800 (PST)
To: Git mailing list <git@vger.kernel.org>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [BUG] git commit --trailer --verbose puts trailer below scissors line
Message-ID: <8b4738ad-62cd-789e-712e-bd45a151b4ac@gmail.com>
Date: Fri, 16 Feb 2024 16:04:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit

Hello,

I've just found a bug in the current master: running

	git commit --trailer="key: value" --verbose

puts the trailer below the diff, and thus below the scissors
line (and so it is discarded).

I checked that it works OK in 2.42.1 but not in 2.43.2 so it is not
a new regression in the 2.44 cycle, but I thought I'd write now in case
someone spots the culprit commit faster than me.

I'll start a bisection now.

Cheers,

Philippe.
