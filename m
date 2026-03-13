Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995BD375F92
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773434181; cv=none; b=YhO+1OEBUMpYUoKBBLR3MfUJBhi0yS2hv2jeKq995x18GqJUi+9dcT0OaGj3o1hB6QbUdN8t4PCeJLkKk+jswi2aeEt5IKKPp2W19bPB64uHKsb/Mij11zGyJWtomFAoEiCEAqhYiZwXHg+ioOcqb4H9DmN53RX08kafMEAYMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773434181; c=relaxed/simple;
	bh=7oH5GPlv/91TiwDfQjX3LRpFFYMDQm6iEk4HjfvdGyc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=hyGN6zdO00m4or2St4uKEZEPWLuvxbsdJufGX5yWe4CVJ+EAg9zsoTPsq7W0BEWbGxXJ2MRnPpZnvE8Xr7UlX0MoB0E6D7+VTkdi/jWsGrHavY/bQeHTDxidV95DGkudcdhxl9vMa3fw2SbqRcjxpKdTlkogtvvaj4DWMzOhcsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZBnkFao; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZBnkFao"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a13e1cfa45so3100286e87.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773434179; x=1774038979; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vbjHjGaews5aETex4OnNg1PqkpI+JyRbm4xvMfbgJPY=;
        b=QZBnkFaoUl7JfJ2DvFWKOOcqI3KpWGpYIUbiwuYVyA9QcN9Q66F1OlbkRiIav/VtgV
         Tc49wfEMUTwMC+Do5ePo8OAnR6j5vezAu7nmocIBgp6jeSeTUbYKdGSPOOlK9jueGFUV
         fIsp7qWk3PKDb3ssSrjARjS9bWnXdLqeaDUg/LoOSq6p4WY/ZNlXdad+VTtI0WOVS29O
         xGVymE87R0Djlm/AkIYH1asrijmZCKzAnW7TzszAvttrGpEJ/+0qhRljtkC6YKcH8zbJ
         TWAPKPlvM7z6v/fCa4BkdE4tjQpIedP/7VAc/y8mUHPciC/3TVDVJ35ecOeICq97AN42
         rSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773434179; x=1774038979;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbjHjGaews5aETex4OnNg1PqkpI+JyRbm4xvMfbgJPY=;
        b=eb3gk0rCJNo0ZtirwaA3mUDuyRgE3F9rR89TG7W67bO9UQT3Tqvy8LOAvlCVYf4Fzd
         SqMMjAZrhRNr9q3V5zl6e2yiqn3GIlsfrxZ2hBW0cb5uf8eLIaViDHRsFFvD1DqoOvqO
         Miwic/mD8n61zDIke+Lo3NfrKAOKHsa33YSODYpthnEKdfsMSY7KFYpvwQv8h6+K5iwG
         bnuyYPZxmadaUtXRuE9NYw8wPB3CWwVOuzDq6w10ng2ZB6rv1lsE4Y4WZ54zjjY6PsMz
         1+npV6IKRrLSlujlqKlLGmNFJxm3zOoGMCHRf8gWKg4VoLDBv7sJm0iBS28U4KDbO4BM
         52xw==
X-Gm-Message-State: AOJu0YwHMyef7l4vEljddub4TPOtlr+VmOdr6fRy76pTzVlbVeLoGZ1m
	tP2n/wvniZBYTNxZmeqNqzUkHU8eLOwI6NVGqkn8ktqJoaATtsS9lLnnxZRqAtFVqtQ=
X-Gm-Gg: ATEYQzzXXjuEdxQy42H0ziv22/+mXRglS8+wMaeyHzmrPjEXrstPhhrFadCsEnE0aLF
	jxoH2DLb04D0nsm+CQvr7X+6iMDoqFChd4oPXfjDfv6ThI2CgGgg10mVVjdxMTM2NsQUgT9bdui
	STUNwB4IxtYMkbYDboaitdyZonrXiy8LZOWiu/c04B/2ROjEskHMvzuAdVY/Lk1l0wrFRuJQJDh
	qeta+RR03J1RGqbOV7+ys6wfCI2GE2Fs8C4tWqs1uS7q2MMQf29/Tuo3+l8Skml/r6duafkqL7H
	R+jZ/R+76dHipQYNLTPRoCc2K8uCMr1RpyEPjfE9iO9Rw/i5Qi3frdWjDQtDAKZ8HdKGZbOE8ys
	F10O/kqmUy+r7amQspLKdzNOzlSv1ocR7vZiUgmcW51PZDIsxWQ+sgxwV/OLZxN327m6TxON59y
	fy3Rj8Y/xx0BeA/8MGXvxaRsg5DBDC70F/Yj9xgZ2ad7R9ZSvbDucRTj4gf9Vh7rjDFGVDTvc8
X-Received: by 2002:a05:6512:1413:b0:59e:1954:1d3f with SMTP id 2adb3069b0e04-5a162b3bb6amr1345616e87.44.1773434178590;
        Fri, 13 Mar 2026 13:36:18 -0700 (PDT)
Received: from ?IPV6:2a02:2168:8772:9800:eb6d:4393:98f8:641a? ([2a02:2168:8772:9800:eb6d:4393:98f8:641a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a155f33e07sm1797492e87.4.2026.03.13.13.36.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 13:36:17 -0700 (PDT)
Message-ID: <2c9651da-6c1c-471a-a239-5a60576251a6@gmail.com>
Date: Fri, 13 Mar 2026 23:36:17 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andrey <butirsky@gmail.com>
Subject: bash completion bug: git range-diff: no --diff-merges option
To: git@vger.kernel.org
Content-Language: en-US
Autocrypt: addr=butirsky@gmail.com; keydata=
 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
 VVOdns/k4krQA8QXLlOOXh+F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

--diff-merges=, --no-diff-merges, --remerge-diff valuable options are 
absent for 'git range-diff' completion.

These are the options presented here:

|# Options accepted by log and show
__git_log_show_options="
         --diff-merges --diff-merges= --no-diff-merges --dd --remerge-diff
         --encoding=
"|

But they are not included for range-diff:

|_git_range_diff ()
{
         case "$cur" in
         --*)
                 __gitcomp "
                         --creation-factor= --no-dual-color
                         $__git_diff_common_options
                 "
                 return
                 ;;
         esac
         __git_complete_revlist
}|


[System Info]
git version 2.53.0


