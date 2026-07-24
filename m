Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB94317D
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784918263; cv=pass; b=IzElHJEjAM0H9JMz8zjK9zTKlZlhsRGjsz+yjIoV9E/ELZhq1YC2vHtBKXnj11pyzMrYa3OYUmVDuddR4HX5NU2N2/y8+TnmeW7AEeqB0GmPxtqyzVCKh5I6WLYoiw4T1klQli/7cPLTq4DKNo2P2+b/P6gFTG0ptRvkDExla4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784918263; c=relaxed/simple;
	bh=WxR/1qImOyre8y1yXr0GnY5UKhZHzetiharTo7Vha2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BY8l0k+JLyMSlReWyAMcDXSn+zT7Rwir0LRIPer7e/wrEqpKe5s0Glrt2aOnkJxwEGJFlKQ+TZJ698L093wXpkIMAYo1oRB0hKeQqMlFA1jmyyAib0COEtxCjKecB2j0yfWIa7BOpXoI0civhBeTz4ko4yVR357u5x8tftmD9Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FW2RP5m8; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FW2RP5m8"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbb85186d43so477354a12.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 11:37:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784918260; cv=none;
        d=google.com; s=arc-20260327;
        b=AcW8aJz881nHN/84spqDkATXkYFQq0kjv4r1BaImW1tJuHe06UC3X7e9NR4E03GEf4
         yh+9vFGpMUTIhMwnj2K6uTe85ptqcTHYO+qMZRvuFgzAemYscMpz7FSoQJb8uUPWMQtM
         iSAtcNT1UiKvAE1cPOSLty/tLoVyESIX40xeKZ3L+TXWZutuRU8DdDZi79r8uobZRpCE
         Xi+e8ynIXIAJobDn16W+ZNfUAOxyT4fQboDXOTyOHP8zQCLGwmSU8NkCSrH96Ut5Ls4+
         t3w0JtnM+HFyN+roOR6MtrgYSzdTUBlGEpabkpADtAqY8Oh8PvHNofsD3cyVS4cnGqAO
         NG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WxR/1qImOyre8y1yXr0GnY5UKhZHzetiharTo7Vha2Q=;
        fh=mJp7zD/aNhugTOnrL8dQ02PHrLAVRLvBineKoPiKXAA=;
        b=WAxpCBXmDJh5SUYjlrg66Btw0moAnwp5FTLlmZJOU4XUfryr9UzsNTgx3HH7RXLokR
         4UeVy8KdX/Cd+pvFkOzqvxUvceC0WL1m08dslbQmdyJYFiWUeWvYsWb5zczDpPGqxGyE
         iDEQj9+PQA3Gu5kUz78BVKfFcAInWfUBtXtzOq1mypLrg3qcsi86Hgq6WN+Ta/6cMLr4
         lE4OPpsuTs3c8n1AJX7aaVb9rNfOtmwPgnKfTJUJZK+xY0anBesPM5sgO85yJncu/tzQ
         jkzB6J5diN5K1YT7ZCVHmkzDHACLxFC1FVgUNx/GVowgSH3U3hSVI58U5PA7JCQfm3SW
         CZmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784918260; x=1785523060; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WxR/1qImOyre8y1yXr0GnY5UKhZHzetiharTo7Vha2Q=;
        b=FW2RP5m8jDktKXKyaaQZNz5Ltix+iXkT/FqkqokeabiIxtfe3pMMn4HyHxfmbIG8Rx
         dIq4qPrbUqZAMbaMEaD5Dd12VyiOOk628buI7vz/YJgiGbT0COM0G1DPcKXqVgcIGOPT
         Wp60lui0JKSZhHiFu4VdbO4sc1A+0UeRDCBXHIOj4L+PDkYP3cOTyJfFVDJgasuAWjxV
         h1HyVM9THfNR0fj8/Qz78U0Y5E6kZzITCDq/BPbErTEEmrHe6hAtlwPIdAmVVPw0Wn8c
         xiKk9/j0s79f8Vgek1IRCOuS4KkdZYCz3ZSIcTjOLysqUvxWUIXafTigYGy3fzxJHVPT
         pRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784918260; x=1785523060;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WxR/1qImOyre8y1yXr0GnY5UKhZHzetiharTo7Vha2Q=;
        b=E2NWfktXYM3uvr23wDgYAvEeDsjk2eX+F4g+RS2sUCWzM3L1bTUbHxDwGI9FPBCUEJ
         olSSGHx/mseAu5FFOLdxPlHHNTnGpIZQwO/bRTL8zElTygPwTe0b1kDWPTfedQ1CPRwA
         YODEOtKFdV4rfVNPisKJBdXswHcB3j9Vi40HmO3asYD1ksIoFuhQabANW55iRSzE5jXh
         NdN6JzMB6zbLXkixKZKwwv75sYjX8yDVl82GkIyQzZfuFNoaFtVKDdAyFAt1KMqlTyRB
         EljngooizZpU/CJodvvGe1FCYRNzO4OHe91DATytKTQ2izU3Z6uMBPYjIgnSIafuK76B
         HIDw==
X-Gm-Message-State: AOJu0YzuWX8W8AU73T8T0sTyduTBv7xMY30qRWR6eD/7ELqy4esFUUTE
	u2o9kP0ynWTP3efs/kIY8vMfTv8OAdvwVQejrwUBwEy2mcTMSrU4ql/wo1Qf0raeLU3JJ0BgSUN
	s2rZHlclK21VuKfOaArhngO1DUxkcrJYfeQ9i
X-Gm-Gg: AR+sD11pll+nakPy0Yqo/zMCP+CjVE8Qe0gIVcTUIaVhnqbDtljbNvw9oIcKN/dvU8Z
	kfTI4OIGzn7LaL9O3YbDMWxQse6rHBuarQ/6XFUUkNAkKTCDpQokE+vTbfNzmnh5IfgQsLz+LTD
	6jTtS3NSFMWmBC/4514N8cug+Ot8iJS6yegcUMBqceB8zc2eG9NLe4GuotRrGn1gWRNauPUfc2r
	D4UAWYWvh+wGW02lxuRBaYh1gYeAfRtfrslv11jGb58jaiozMQ5YQNAjKzHNKMhocurjJJs2UKz
	c2/c4YOhjZB7EY5LmnTNX1X42Pq8jhgRvmPhH9CL+r5cQ7cqaZpPAWyr7RYwjMekKKXagxxbVmz
	xnnu34A==
X-Received: by 2002:a05:6a21:4c11:b0:3c3:76a8:c0f with SMTP id
 adf61e73a8af0-3c44af6d829mr9704517637.4.1784918259874; Fri, 24 Jul 2026
 11:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGWgyh_WJ2mAgbJ2agp9UQm8iyR=eq0xWjdYT59CC9fZTnAbzA@mail.gmail.com>
 <CAGWgyh-Udy9p9yF_8EDnVgK4bxyG9BsX1gio8oKr0G9b-sdQFA@mail.gmail.com> <CAGWgyh9154HAPs-YoMz6G02TfcLe3CCcd93TJjg6e+hQsmZxVQ@mail.gmail.com>
In-Reply-To: <CAGWgyh9154HAPs-YoMz6G02TfcLe3CCcd93TJjg6e+hQsmZxVQ@mail.gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sat, 25 Jul 2026 00:07:03 +0530
X-Gm-Features: AUfX_mzwuE9Vm_s047YoQPn6GOgZjBNvC14hBfYgUalD-WBZYgnGUyarZfArsuQ
Message-ID: <CAGWgyh-fXm2WdAqZDjYeHAuucniWnoathQvsFP+rDsKvxrs+eA@mail.gmail.com>
Subject: Re: [GSoC Blog] Week 7&8 : Improve Disk Space Recovery for Partial Clones
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

My latest blog post, covering weeks 7 and 8, is now live:
https://siddharth.shrimali.info/#post/9

I have combined both weeks into a single post.

Please feel free to review my work and share your feedback.
Always open to discussions! :)

Regards,
Siddharth Shrimali
