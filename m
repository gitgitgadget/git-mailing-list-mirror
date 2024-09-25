Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625E0155733
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272262; cv=none; b=tyHLxN/7MGevumaZry3RTfAmFqPmuVIIdEQakarzukkAvM4pDfcMaCH03A9Y9O+T1mvzsjpV+/l1/rhgb2UBXYWWXpm6udNZJij+gmYFAXCq1u3IWXRRzk1Gb0cjv5mbLYYloCjG8KY9z2bdA8Ot68/ZDWEEFIl8vp2ynbyRDxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272262; c=relaxed/simple;
	bh=vUFIz3i/UL6ciY9Xjgzm7M/J6pDooQ2138bwnlGatxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0gNK0tODpeniPs3fbGikR/XHuki05zzCxITpJAil/B/9rzKNnt2OoShJ1n5cZtVIbqGp5kg4vy4fpKPiZHfPgOW9JsQ/9jf8gfqzakTXVq/GQde40Nc48hziqf3JdqvKWsXVt2Tpv3l/wrVMLsNJSDNIgdjSRh8OOPYf3hcXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAV7DhYW; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAV7DhYW"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5f24d9df8so3175628eaf.2
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727272260; x=1727877060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUFIz3i/UL6ciY9Xjgzm7M/J6pDooQ2138bwnlGatxM=;
        b=PAV7DhYWnKAA5TNwv99NcHFKTS0mvkcxJodW2e0D88zfcQg27Mz7lSm25CqytwNTUD
         eIiOdMueoN8q0vXghD6GJxZjHBoa+UwB0/VHW3k7KXauSguFRgcQEIdLs2205bqI60pL
         CZBuunmrxdaPe8olSroFu4w7L2HQ6c3VOJFRkL8kqCZaZB3CaZ5F5wHVX+k22dYSAz7s
         3Y0aA7TThcxI2Rz6sORF9Qq8TNlTBNcnTwcpr62CRFPjP6xIIe02QspzTSwIhs3/rUsS
         LfQKHJ10EtUWr4tHNWOKisO5HWyNUvN1N5rLhsYv24yFbfmWDNEuDFXUURyzhm9R9zyu
         MNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727272260; x=1727877060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUFIz3i/UL6ciY9Xjgzm7M/J6pDooQ2138bwnlGatxM=;
        b=i46zWV1VhLtqr+Mlqbva4AvmXQCrlgo9u7Ot+vO8QXaXzhC46iZAv6aqQjSCm6KRmd
         bPNWdUbXQjMf1zlobZj6cKMvdQ+wNO1I6CFGn1tP6xfBuMs8w4lJgXCT/Q1XZGbfldB9
         +bw7HAPW6FrB/PtlfcQElcsmcIN5J9/psIX7jmONnQvPqcGu9ZJ8llLwz+Ker+L376iF
         A0LLOLBArIBuRQywERVxD82T3P/9ztkYTPD51y14vIJIQTRttl84vrYkD5XFAV5qFrQv
         Krb691W70hGguA3k5c9jW5DHF7zfoiwech0Ym0W25mwrD21SxNUmE2cUtx0EPWI2mCSD
         2Qww==
X-Gm-Message-State: AOJu0YwJ2ZnWqWuvPTdqhFTemhwinhG8zq0FKXz5aJOREuhrdeX2Ugqg
	YqFmJWpOxEV61c9mJWFrdE3wxmkYFds1EA60OLFEDHkKRgOt9u3gX7T8Jw==
X-Google-Smtp-Source: AGHT+IGrfjr8xG4dN4+GaQc93p8KwhocqImXD5/k9rKY/y6POMXasXj181r9zGxKzvx8tqMVEZMbVg==
X-Received: by 2002:a05:6820:602:b0:5e1:de92:6b4c with SMTP id 006d021491bc7-5e5c69ffe74mr1763866eaf.1.1727272260185;
        Wed, 25 Sep 2024 06:51:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:1a:6e9e:b1cf:6f9a? ([2600:1700:60ba:9810:1a:6e9e:b1cf:6f9a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e5bcfbd7f1sm965244eaf.16.2024.09.25.06.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 06:50:59 -0700 (PDT)
Message-ID: <8b6394ef-9ff6-4fb0-bfdb-3bf02b2f4bdb@gmail.com>
Date: Wed, 25 Sep 2024 09:50:58 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: The maintenance tasks will never run if maintenance.lock is
 accidentally not deleted
To: =?UTF-8?B?5YiY6ZKf5Y2a?= <liuzhongbo.gg@gmail.com>
Cc: git@vger.kernel.org
References: <CAN477tHJnVnOKfUsG5G9QAVdzYvmUuC8A8Vxt8mtHB23fd=hAQ@mail.gmail.com>
 <cce1d054-911e-407e-bc26-1c0bac4dd8e4@gmail.com>
 <CAN477tFqDM64NsoXYKww7Xh7rNajMGn0DK062AjxDOmp+_7Lig@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAN477tFqDM64NsoXYKww7Xh7rNajMGn0DK062AjxDOmp+_7Lig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 6:26 AM, 刘钟博 wrote:
 > Thank you for your response.
 > On Thu, Sep 19, 2024 at 8:56 PM Derrick Stolee <stolee@gmail.com> wrote:
 >> At least, I haven't been able to find a reason why Git would be
 >> failing with something like a segfault which would also cause leftover
 >> .lock files.
 > Yes, it is not necessarily a problem caused by git failure. I think it
 > is a natural
 > shortcoming of file existence lock, which cannot guarantee that the lock will be
 > released when the process exits abnormally.
 >
 >> I can speak from experience of previously having a lock timeout
 >> that this could cause problems where maintenance processes start
 >> running on the same repo concurrently.
 >> [1] https://github.com/microsoft/git/pull/598
 > I read your commit and explored more. Perhaps the file locks provided by the
 > systems are a better choice, such as fcntl() on POSIX and LockFileEx()
 > on Windows.
 > They can be automatically released when the process exits abnormally.
 > If there are
 > no objections, I'll give it a try and send a patch in a few days.

I'm curious to see how this would be implemented across platforms.

I think the maintenance.lock file is a particular case where such a
change would be welcome, because we are not writing to it and then doing
a rename over the non-.lock version (like we do with many other files).

For that reason, you would be creating a new API construct, not
replacing the existing lockfile API.

Thanks,
-Stolee

