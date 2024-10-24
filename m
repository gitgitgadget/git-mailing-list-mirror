Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147461AC445
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756770; cv=none; b=Xtk7ZuZr/jiwESNPeb/dTLYyPK32aKjJS96d2c6Uene+mjhdG7fM7Mllp8IB5ugtynoE916Hp+G2jhzMIVLIHubMqztTKZbnsgqjeMYJqHzx09RCQoaVTPslrho7QfRJ2M/0GeFBVJru/seiKcJbYJVN770RUekicHiEusDkxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756770; c=relaxed/simple;
	bh=eWnP9cEAL+b7TkJ7CX+aT27eOEZyQaVfm4tKqGbayfc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZPN34ucXES918Q4iRFlsuDfXnhkqCro9dULvqJh9fqxe2+eJlRJv3kOy1+i41Eb+YB/iZGCVq8wUgpCa2rj9FeP/xl31e9KnK7fFwwtz2zUAG+l3VAYdGvpOjndiEwvXW/STLpf7S8D5/JW2zjYAukqJjW9n/V70lWVscswSd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L19OfWCy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L19OfWCy"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c8b557f91so4465035ad.2
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729756765; x=1730361565; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWnP9cEAL+b7TkJ7CX+aT27eOEZyQaVfm4tKqGbayfc=;
        b=L19OfWCyGjgiirVaNyQAmPNfu2/QhqLcd83LxrgSjRotTBkcOJZaQr+w4TvbiHi47J
         Q1DI9NGz+kq9EWMjbsfG7pWMha8GFHxcYku6PLNragEADPN87uX1+ct52lpz0K3GaLR8
         kIji5MEMY1MKzlOBupNMbFuzup0qqWRNKTYTVkObUo4S+7KJqCfeNTmUJOd/IVvFijZr
         FWoAR4NUJZFheZUMnP7JemBclmufE/iQlXwT08AEHKL2lY/JRWFk+zdMW706rx7Ftnj9
         XdsSEP5yHvf5jfL4846YlktiEA5z/w8HLOcoobyP5c5rJUjEuvfHWocA+x+3n5YNn7Za
         T8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729756765; x=1730361565;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eWnP9cEAL+b7TkJ7CX+aT27eOEZyQaVfm4tKqGbayfc=;
        b=FF/EzIC5ocqh4UQcXELDJLA4G6PqKnvxun0dEmmdHD2FgM62MVZ4SAZXnusj7gtsZL
         ftYCvkaCgOAcPjgZmOpq1OWKtxVAwAbGdcgdQDp+mjr6WnHvKc7AdC70coepqVKf9LMp
         zRVqtdL9duDP4nX4jhrcwkTh5UL4HtdujNtcHBLnb1W643SUcpk7dphHJFg7JtDwFfy2
         HtccwvVbTXJAX30/knmeKGJ86lTz3vOKdsgeHiyHSCaSvNbiE/RCOXD1q26qK5AmvlWh
         Ssny4nbVCmdtZRWWQXK2cDzQX53moiZ9NY0oiJH+sGL4FDUXBljhls2hKOqDksEiGmpK
         zOCQ==
X-Gm-Message-State: AOJu0YyV1KaR9AOtX/Y8s1rDg+4N0cIAlbLdz+7BHAhIjCpBomC3MZ5Y
	ihHbIwvxzS8T9wlrCxFqqYa/jUavB45vcyn44v1cO8rWU89H122MgNnfPVNB
X-Google-Smtp-Source: AGHT+IGOQ4iIAPrpoLfeCewXo3J10I+nPTHKMN1TbPb0cmxCdF+RQZIpT9bTs5k5QXVbSuU0tnmfiw==
X-Received: by 2002:a17:903:1cf:b0:20c:7d29:7281 with SMTP id d9443c01a7336-20fb9a38d70mr9333505ad.52.1729756764905;
        Thu, 24 Oct 2024 00:59:24 -0700 (PDT)
Received: from [192.168.0.4] ([61.246.51.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0c0e4fsm67843685ad.174.2024.10.24.00.59.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 00:59:24 -0700 (PDT)
Message-ID: <7038bb3a-2aad-4bde-bd46-f2bd2ef659d1@gmail.com>
Date: Thu, 24 Oct 2024 13:29:21 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Subject: [QUESTION] Can I merge --continue with --no-verify
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I recently found myself wanting to continue a merge after resolving
conflicts without having the pre-commit hook run:

git merge --continue --no-verify

this fails and prints usage.

Digging the source, I can see that in builtin/merge.c:1378 we do:

    if (continue_current_merge) {
        [...]

        if (orig_argc != 2)
            usage_msg_opt(_("--continue expects no arguments"),   
                  builtin_merge_usage, builtin_merge_options);

I see why we would want this - the --continue flag makes the merge command
perform an operation that is very different than what merge normally does
without this option and therefore the usual options do not apply.
However, I think
it does make sense to allow --no-verify - it feels very intuitive to use
it when
bypassing the pre-commit hook is desired while continuing a merge.

Thanks


