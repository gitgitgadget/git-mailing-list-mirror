Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB136D4E1
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792091; cv=none; b=eEfsWLYonvNrrXa8WVcQBPa24mvSdA4U+GID0hCe5mM+BmCADKDE7U84Adxpzp3p+a2IHcJLiYRwwZkBkzBdjyN3yd4jcvp2qu379xlpkr2iHCLRDfEIt/Jiu7sAewIE3uOxjJ4A9n3Y7gioB+rSw+IO9rUNWf5uBJIo3yJ+q8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792091; c=relaxed/simple;
	bh=Mq+xio3vxQ4Sd+LWTDBRU9srHnoqQH2KmBaDNYvKiGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OiYlY1lowqIX/xmlJ4WQ6GRSr0Kc8H0U7Zh91ux5trpaJlLrQ4H1mCv1ijcycsQrzTQhtuD9Pa4Q1xI7Li8qlfRo4dW1E5tv95lb0y/UgJE1i2nKjpIpxVPAUe/zVZ/MAIi6Qq85ngJIAUaI0gd8E6PG6BknKRz2GVuLOge8vkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7vVXPRO; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7vVXPRO"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5338322d418so412501cf.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790792089; x=1791396889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FwlGkNmTsW8UbGqrk9nuyeWHk6VwSjlZBSz9VOVQMRU=;
        b=S7vVXPROrtnviABQW7HMpQjHHgoROhp2BlNr/DImGKZmEBVu6HkLEDxzATk+8Di2a1
         mD9wUAFh0D7wThhMH3sVC29iahzxBbaiSrZfpx2kgMdZdmffvaH6HdxAm1qlgDA4+5s4
         euf2MNAjxYf6ZA/FqYnrxJRaMVTZmdx0fiaAxIU6LIEmlko3lSDEfJabNpY1vyfXiFoB
         WtZJvklFVorRfOlJBMr34FQoc5XjphK3ReCD1OpWjlyPD3tLZhsIDlrnHmuq1kkdooR3
         SQMFhY4jjXDsFJA8BTjUjm8Yv4pMrsRONruV9VoqV81/cqj3FXkm+CfEBoHQpLd674KT
         c0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790792089; x=1791396889;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FwlGkNmTsW8UbGqrk9nuyeWHk6VwSjlZBSz9VOVQMRU=;
        b=E6msTgEzyY7/q35xJtoEAyRbZVDaPWrgXsLPnyDhTty+UMrr71DQ/K8PNMdu5lgnWm
         WGfDENC7o/iqkzQnumKZ0q+ubYP71I2TzpnfQKF/xTc3I2sd9NtcqiCsPKAqazsgHryN
         w2mn5Yrj7KR0vGzwGEtYAJL4LBDByBp80RfToxrJ4f7w5jujnRPVfFKhIR1MLVQF3iSP
         mTfxzBZ+mVcwYCFTS9w1AHt1cyF0LIbkiKq4tzvhp+A3xFzZHuJnbxpkLhOyvcVBz6Wm
         DIuigFiR2lmQDa1KV2mrFZpNKwL41OCLlG+Ov1K6hliyjEoRre+JX61DkV8uLI/+/N4Y
         CsFw==
X-Forwarded-Encrypted: i=1; AKwUvBzEp9v40yPot72NjhM4vYgxiy5qYpQH3v1sph8YasUPHiQShuWDEsc5HWQx01So7baj1qg=@vger.kernel.org
X-Gm-Message-State: AFuF++lA42g+CNAA1nMvR5HUwJ09PlscUQtvbH58x9mb+W8gwqZTl83E
	IwYqF25dGvRaF95a9380g1tw20LEz2b5dWWsgnjj4OUxfqyHg/GOLIH+q0VewQ==
X-Gm-Gg: AYBFou2kZpVw6brdHbfo9OvHlDlHcaqQfPrYiRPE4nixszekpWjpmn40XNCLQ9UVNRN
	p7PqcOGeqLE2jxXZ6pxWLkyO6iCGhk/ha2Cix+KFk++70G1Tzbb+92peDUt7b2e6CSpavh11tuN
	7IrJkQETymLtUfqhhVUdxTnycTDCZFtXkqrLKxwDB6hXLi8XkDBlZ/0RM16IsbeVgY+gD/uCYN2
	3fKf8+ZFdwdRQctJ8tWQQokUs1V1M4DvdixLiWMldFt/iZhVykqBUTb7QrKn7cxdOVzeFnl4FIw
	FstFRdLWlfPP5n4u+GYWTuKbxfpAphYYNTAXIBIVRAycnQcfdS56xnCQJ3Xs1vATIxPRDmT78/v
	Fzltsehrcrhcjfd+vO+C1mxZDTvsdzQTlS1Y7QuiCmo90KYXjqEgw9MktHmIdlekP4Ahc5FuSWC
	vE19SzBLMMBZ4ON5Uo7mBGqVJXgdANIfULoDYkn5nazSBK6Qqd1pjPqfaB8AiX1GRymhw8bXH83
	O6QxlIUb7YeCjRXrrJpUxCSoyej1MZXzPzv6IW/wdF1kHOiNGmaAsuPm/QphPiotHg7DjfFnjHq
	ph12Ca47jKSzdGX4ErH9m/fOTI44JbIEK3B3h222CQZ95X/zYwLXA2FUoBw6/LzMYGIPvPQTD7P
	jT4/70jN/CntyfCYdG6tOwogLIDnCL0OOH7I=
X-Received: by 2002:ac8:5a42:0:b0:532:7ea5:f33d with SMTP id d75a77b69052e-533834c8a2bmr8312681cf.34.1790792088811;
        Wed, 30 Sep 2026 11:14:48 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5338255fc6asm6183791cf.31.2026.09.30.11.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 11:14:48 -0700 (PDT)
Message-ID: <ed1b9048-d438-4143-a224-fa0e28d4fd42@gmail.com>
Date: Wed, 30 Sep 2026 14:14:46 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] Add --dry-run option to git-backfill(1)
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/2026 8:21 PM, Pablo Sabater wrote:
> [Cc'd Derrick Stolee for his work in the backfill(1) command]
> 
> This series adds a --dry-run option to git-backfill(1) that reports how
> many missing blobs would be fetched and, when the remote server
> supports the object-info capability, their total size:
> 
>         $ git backfill --dry-run
>         After backfill, 48 blobs would be fetched (1.20 KiB).
> 
> If the server does not advertise object-info, only the count is shown.

This is a helpful capability, but I'm not sure the size check counts
as a "dry run" because it involves a network call (and possibly many
depending on --min-batch-size).

Perhaps a different argument would be better, such as --info=(count|size)
to make it clear what level of information you want to know in advance
and thus how much effort are you willing to put in to discover this. 
> I am not a git-backfill(1) user myself, but it seemed useful for users
> to know how much data a backfill would bring in before running it.

I'm not sure that we want to add a feature based on speculation. Git
is a collection of "itches" that the contributors needed scratched.
The work is motivated by real needs.

While I can see some benefit to curiosity, I'm not sure how much this
would prevent users from making their decision as to whether they
should run backfill or not.

> The number of missing blobs is the sum of the number of blobs to be
> fetched in each batch. The object-info capability lets us ask the server
> for the size of each blob without downloading it, so summing them gives
> an estimate of the total.
> 
> Note that this is an upper bound rather than the exact disk usage:
> object-info reports the uncompressed size of each object, while the
> objects end up stored compressed and possibly deltified in a packfile,
> so the space actually used on disk will usually be smaller.

I don't think the uncompressed size is a useful metric here, as it is
likely astronomically larger than what will be downloaded. How will
this help a user make a decision?

Thanks,
-Stolee

