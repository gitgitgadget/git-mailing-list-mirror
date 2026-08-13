Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58F34CFDD
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640446; cv=none; b=joqUX0VEQX5+bDFLRDR8WM+1ZXnnhCgHmUnaE7jKGjZNuDeUkfhZyI2fMy6wB5u4NKnG072SP+9MA32cv0aVvN1PWcY8JiiC4bPrryG1+TnfAgc02u2X3R/LrEuqhyXZ/X+SEwhPVEs9UHAtsWmM3WaFDrdon4j08mb0ku6c6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640446; c=relaxed/simple;
	bh=i8L6MY801rMkElM6uqydkKhMaMrZ1WoDJUPI+2yz5F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZA5likmJ3f8lglB4XNqFFkp/Lc2aIHLH9HaTqzGE+5WQIp+h43dvhIK825riNo4SMLmHvI3DX0dZHM9si0c4W/NFQUzsYTwaaT6PYlOvhUSxmLmpx2y4IzS0MkMVCHX5ca+Wyof9OY2edrr6f5AQyTJUAh+5BLKD0LAu9AzGdLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OohJqHjS; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OohJqHjS"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e7c6ec9dbso6770185a.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786640444; x=1787245244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fl83H4lGGTp4HzCOEm90SNUU7bOTTSYyZJruWWIEo9I=;
        b=OohJqHjSOJ/+6MCsc9ygiemzTHg73zjeOrC6uPrvzuhBjf7tBSf397YLLx67dvxVEW
         b5F9EiIKbe1S7wE4WQSPhH1xEiziR1enZWts4fwEf4I1cNcUKbKwymyrTSLwgIcseHEF
         uQ4whKONtScnbXnyIVMXiRYEvO5Y7lSULTYJucUWbb8etZzBx5mjWpHn/aY8gGHsLsS5
         KfcJsGxVgcEsEsXlfyZETahUtDqh9UgqMQqQtaVaxxQotnbq/olfEY9zveK3y0ckC6ku
         SUyc0fkG667INMTE0/u/Gk3YeeFay7+Z6G+8FMSs10JlHatS82hdbLLZGAt4jw/ftq9u
         bHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786640444; x=1787245244;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fl83H4lGGTp4HzCOEm90SNUU7bOTTSYyZJruWWIEo9I=;
        b=jFkiiBq/VPTMFPWAIMlTti5sVZrYNsON6+302bSftoksrnqq5c52ma01MJJGUVgx99
         qYSP487riFBN07q2DEhxJKq1+3YCd20q7mDmLv3jCJMSKHETapNPyoF74OVruvpcamG/
         o0Rqzk+KAd5uyvWtxlcdJqZnj0iFsMmKBoZtijuKpaRsIVK8yeYU7BIMJMUe8nhowo8I
         MeZew4awNjud+fUp2BDTxFpD4l36aLRs/qnHTSFd1T21nI1jhfe4t1YO/fCFjwBxMO/o
         Vy/mRdka/znp/wVWsKjHw6vGyVJGK1D34nrq+el5WCrWr9jN35JL3dX36isBe2GBb8Dd
         yBtQ==
X-Forwarded-Encrypted: i=1; AHgh+RoQ0jYnRoGZv9AGKSN2uoiI+3IX6vFwOj2PuDDvKTNL4IMa1Yu5waI7fNTi8pgdM4xrlIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7m6ThE3zIOH6o6Hx7Xw+NJMsCh0uKhE8BYSclHer85dn0OTlf
	S3OGXfcj/bKb8WoEWvQmzlzpsNDGtgE8xyavICBRyX/BJ+WEWAz1gvdx
X-Gm-Gg: AR+sD13s8l7XC6njEfUpD04b9ge3EH8NfGHWs0bSKjh2wxpoxu/ENftHVI3u57P+osU
	WA/zsLGXnKJhkTbqsU3FGv5xdR9x2eXkedItCLi0YpJNE6XOKG82hy24K7WB2jH5ONJHJkOCbaX
	rTqSJIQRBYjsM06XK6hLSmYmre94KdXhxppzUF1oYwZzjcsactHL1kp+tmWOzauv5AiO6qYvU/s
	fx0zapOFiLpnKpcm4mPBhFzyJlZTOuH26XzaZCHcz4FWDDR4E3QXntghfai0D7zhI0c7Spe/4n8
	D7RF/b74PwJU4tKyebR+PqbB11OMI9AqgYBzxmOoIBwqkgtmR8zc3Wl9EU3Rep86UBy9CAujHEj
	gMIhRcQogacwqWylF8+c01I0kPViwE3rWj+/r9b0MyklXiB4zlqSQHM0zht6f5Z3xE9jHNm6DVc
	jfXRdlpeWf/oqwh2+dm0a1mc+UXHtU+voNHpBYCVEjPnfu+Vgrjq5LRRUssuXrj7zbg1JHM/yLC
	XaUmT1ZlDHV7fbDNaSfsVqHznxXdVZcH874
X-Received: by 2002:a05:620a:6307:10b0:930:fad2:fd with SMTP id af79cd13be357-936bf902ccamr630384285a.17.1786640443828;
        Thu, 13 Aug 2026 10:00:43 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce2189c1sm23881985a.33.2026.08.13.10.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 10:00:42 -0700 (PDT)
Message-ID: <787b9472-d9ac-4d1f-814c-f7be9318ff55@gmail.com>
Date: Thu, 13 Aug 2026 13:00:40 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] gitk: use more natural language for labels of
 color preferences
To: Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
 <pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
 <45d5b05281cd4f3f43290d128d631a47975225f3.1786540582.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <45d5b05281cd4f3f43290d128d631a47975225f3.1786540582.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/26 9:16 AM, Johannes Sixt via GitGitGadget wrote:
>          markbg      markbgcolor {} \
> -                    [mc "Marked line bg"] \
> +                    [mc "Marked line background"] \
>                      [mc "marked line background"] \
>

Not a new issue, but "marked line" is not a good description. What this actually controls
is the background color of commit message text found by search criteria in the gui, not
lines of text, and (as far as I can tell) never any text found in the patch text.

So, perhaps my observation is best deferred as being part of a different topic that would
make the search function highlight all matches, not just those in the commit message.

Mark
