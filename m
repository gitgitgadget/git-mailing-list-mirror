Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F012BF25
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 02:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730341710; cv=none; b=gfSg32dluTFiLcUuuEZoyXhNt6NvVg8yL58Bx9S5EeQOLxpinsWtPbeWV2EVmw6VnllMMzz5nF3zWuVK+pVYc7bhEi1LE4MNSEedumI8axf6+E/U7kDbOCcBBh+CC1hiTZTLBoEOdzq0pWy/4C5NR3uNrGqlqvnab8WK8H0uTtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730341710; c=relaxed/simple;
	bh=c2322hAQXlqFCrLt/mE5n4H5VrGbTwQqsQvAyVFlBk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p18eGsqwrwFWw/yJvzcjsEUVHcXJLQrxB+aVoTQhCemFYWHdqinTkbhIe1XNnLazGIR/Gr6e5sLV28rF69VTy6DzvrgicKjR0KfUKbVOfMxs+QL+qGJP4C+W1ed/n+7hQ9d9ZREwgJRr2FkWNRa+nyy7+vi2NYkh29NGZ7BoF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHSJ4J8U; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHSJ4J8U"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e30d1d97d20so429584276.2
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730341705; x=1730946505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2322hAQXlqFCrLt/mE5n4H5VrGbTwQqsQvAyVFlBk8=;
        b=LHSJ4J8USVgX5PdivIF27vrHfGTDvCv4H6zT58OmhRFTqbGcj5Xmf63VPiWfKfcmGW
         GjYGf19qqU5NUFsQ1sODkc3/ifnmMqNWBg+Gspsyt6z/r/i5SwhsBgWdWYi3Y77CIVTs
         HW7Yi1U5vpRYTXATVWZ7MCPwZ56vrdfsQAACDTVz1UeecbZK7xI021Noz2ouubBlN/2C
         gX8nMGXJn+PE2B8nXC7QaABhbruhI+CdrXQO9WT9hihK3i5xEYa/6rfDugqw/tUxLjkJ
         m2UZ5AQenFeGyUIVt93bp13yAPVjicQpFFmy2s1xXCNYc+2p8JTAWO/WP66gbglpvIkH
         K8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730341705; x=1730946505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2322hAQXlqFCrLt/mE5n4H5VrGbTwQqsQvAyVFlBk8=;
        b=W0G0x0zPp/g90axaW2PjcF2X5XzT6orsRxC74bZwlDn7ciud5bRIHiOHyURpTZrFeI
         /Ip9ap9wb7rzNOS0xdrhz5NcXmCfkcrsyc6pPgGMH/0NspjsCDI5+qOz086VNYDVSQ6g
         v5BkCNw2h8WC3MUpqAgyRYBjdsYQ+KbxtynymvfpdkeIiFkkvxLfjGSVJtbsV3TrJi0m
         ExOue9uIwPlaHaPkUXzHtZ7ctOhNTLjkKQTE//HKZ7JFkSIddNbLU4ZilEOmdmCARFmS
         utcrdE33BGbkEF2/7rjMreYCMifUDmV+IwwJf7B9ay34nkBN5SZLtufgb0U+V72BLKQA
         tIPw==
X-Forwarded-Encrypted: i=1; AJvYcCXELlNp9cM3aVo8afl8erBHJtEF9ug335COjM57R3JxZ4BitZ6umkNb1L0sWppG/kAxI+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOFyogeuk8rySJShof8R3GxholxQteNEnSMvFDw6cGj7chYsO
	PeZZM6BotJmcx43zpP/rKG0vmy9570qzjWeDKhX6GSMgOOybrzYp
X-Google-Smtp-Source: AGHT+IGatd/vnpYZfaryiq6es3hsjufdZzkBgti16A8n8CBNfEpzcKb60BkMjeLLQC5HZB7BF6/mxg==
X-Received: by 2002:a05:6902:70d:b0:e2e:4329:dc33 with SMTP id 3f1490d57ef6-e3087949de0mr16746103276.7.1730341704735;
        Wed, 30 Oct 2024 19:28:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c963:384a:338d:bad6? ([2600:1700:60ba:9810:c963:384a:338d:bad6])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8acda83sm98720276.41.2024.10.30.19.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 19:28:23 -0700 (PDT)
Message-ID: <9aa2471b-0850-4707-9733-d3b33609f5f2@gmail.com>
Date: Wed, 30 Oct 2024 22:28:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] pack-objects: add --path-walk option for better
 deltas
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
 <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
 <ZxbLFLDgCm6wLmB9@nand.local> <Zx8lHzDyqyBpzrAE@pks.im>
 <Zx/AGrGTN2mQZqGs@nand.local>
 <00d80855-0530-4384-8d2f-5370ace9c0d5@gmail.com>
 <Zx/I+9icWGsRz11x@nand.local>
 <85d3c75c-d7c2-498f-8afe-34c49337ba37@gmail.com>
 <ZyEjHOcf9A4eMSFG@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ZyEjHOcf9A4eMSFG@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/24 2:02 PM, Taylor Blau wrote:
 > On Mon, Oct 28, 2024 at 03:46:11PM -0400, Derrick Stolee wrote:
 >> On 10/28/24 1:25 PM, Taylor Blau wrote:
 >>> Unfortunately, there is no easy way to reuse the format of the existing
 >>> hashcache extension as-is to indicate to the reader whether they are
 >>> recording traditional name-hash values, or the new --path-walk hash
 >>> values.
 >>
 >> The --path-walk option does not mess with the name-hash. You're thinking
 >> of the --full-name-hash feature [1] that was pulled out due to a lack of
 >> interest (and better results with --path-walk).
 >>
 >> [1] https://lore.kernel.org/git/pull.1785.git.1725890210.gitgitgadget@gmail.com/
 >
 > Ah, gotcha. Thanks for clarifying.
 >
 > What is the incompatibility between the two, then? Is it just that
 > bitmaps give us the objects in pack- or pseudo-pack order, and we don't
 > have a way to permute that back into the order that --path-walk would
 > give us?

The incompatibility of reading bitmaps and using the path-walk API is
that the path-walk API does not check a bitmap to see if an object is
already discovered. Thus, it does not use the reachability information
from the bitmap at all and would parse commits and trees to find the
objects that should be in the pack-file.

It should also be worth noting that using something like 'git repack
--path-walk' does not mean that future 'git pack-objects' executions
from that packfile data need to use the --path-walk option. I expect
that it should be painless to write bitmaps on top of a packfile created
with 'git repack -adf --path-walk', but since most places doing so also
likely want delta islands, I have not explored this option thoroughly.

(Delta islands are their own challenge, since the path-walk API is not
spreading the reachability information across the objects it walks.
However, this could be remedied by doing a separate walk to identify
islands using the normal method. I believe Peff had an idea in that
direction in another thread. This requires some integration and testing
that I don't have the expertise to provide.)

 > If so, a couple of thoughts:
 > ...

Since the incompatibility is in a different direction, I don't think
these thoughts were relevant to the problem.

 > OTOH, the order in which we pack objects is extremely important to
 > performance as you no doubt are aware of. So changing that order to more
 > closely match the --path-walk option should be done with great care.

This is a place where I'm unsure about how the --path-walk option adjusts
the object order within the pack. The packing list gets resorted to match
the typical method, at least for how the delta compression window works.

This would be another good reason to consider the --path-walk option in
server environments very carefully. My patch series puts up guard rails
specifically because it makes no claim to be effective in all of the
dimensions that matter for those scenarios. Hopefully, others will be
motivated enough to determine if the compression that's possible with
this algorithm could be achieved in a way that is compatible with server
needs.

 > Anyway. All of that is to say that I want to better understand what does
 > and doesn't work together between bitmaps and path-walk. Given my
 > current understanding, it seems there are a couple of approaches to
 > unifying these two things together, so it would be nice to be able to
 > do so if possible.

I think this is an excellent opportunity for testing and debugging to
build up more intuition with how the path-walk API works. When I submit
the next version later tonight, the path-walk algorithm will be better
documented.

That said, I don't have any personal motivation to integrate the two
together, so I don't expect to be contributing that integration point
myself. I think that the results speak for themselves in the very
common environment of a Git client without bitmaps.

Thanks,
-Stolee

