Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499E3B52FB
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349089; cv=none; b=sCrAC+U0sRr8HHQ3AleT0nOooVVWrKbJxNzwsAowmJ/vipPZh1NjLc2QhOgAqeo2h3vfh7mJ49QmWAJ0S34Myhe0+TnotabvUfuji03wv7Qh+tfxRPeutSnvdXxsJEEjCYKuH8cgWBbUbRkZ+1NTD9ujYnwDe5PbwY+sc8QFZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349089; c=relaxed/simple;
	bh=zLhAUHGK1qV6A9w4rC35+A/SEs3qCvD4n+bAUWvXgUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZhQhbflXz+GQozrCHsJX5xCrvzeq5/b7q/i3yraLN1MdtbBBY1yilfOLXAiBJKkWUymwpcI+Q9A67T+JSveCxqFp0Hq8gzcXJDhnGM8bw+ECImSO5g+mAgxocQpOVjtw1QSULwRlForoVpamod4i3BEiNDhyNRqRW8lLbfaWOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pqo2rG5F; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqo2rG5F"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a10d130b37so710424e87.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776349086; x=1776953886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQFrnzkZ4Nm/lwIFw0rAvN9mfxJzMtpp7s36uLOPCQk=;
        b=Pqo2rG5FTS7t3fvDoeUvMFaIUJOB1epTZbURsD1GK04q8EAU2aLkP6mBaCwzcE4sKr
         NjxQ6YRgrsa4+FyJBxxoyqB3LNn599YA0NmbqCLIViBRPR4p2Lj1ymsi/nDBv/Rq6/YE
         WJA475SJjMtgoKhBaFwVcGKxzbiRNMPklBwPD7KTs1Ih0WBZAJt8LY6kX4HP2D4sRYON
         mVrEdgBrcvsO9KeD8thmABxWPrp+lZj4zB9z4ZxuxSsoWFoNPkkBGLAqOGyq4BJGmFX1
         2kk+RnW7APOR8VBA+H1tShpmuFLYIphShQv82DtunjJuvz4tUI4jEBFxuqDGC3tmMaUh
         ALBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349086; x=1776953886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQFrnzkZ4Nm/lwIFw0rAvN9mfxJzMtpp7s36uLOPCQk=;
        b=iM3VgR9vNVuWRERyDtkj4OuGdlKE2uzAm8xC666vfkkNUqgqWuPDv3q7fy9Ms2gE/t
         S/Gaz3kdgRe8PnDUajf8jKO+E/k2xN3ypfxckwhdCgzbuu1iYkceHMrGWMA9rGzYE/tE
         hPuJVtChQ0HAVOj5Rj6fCNof/qut4HGIJtDrNWbfJ9nrJY9Xf5knDYsRUvYsMUA8RQZn
         RsoTGNEDH85j1J1yv68CmdzmieeecGKyQj59Ymky7Nkfkp5nv3YXGfO/KaE4bmTMKx9P
         Fm1Ph0PZvVwvYChnAAw9vjWVOpd1o4/RXWkbPYn4qtWnVecs3B7O3BnrQrB1QUhp9brk
         O1CQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jwBuQzxsIiYME74gNv6W6XZnRHwPFe9QR7VDlFYvkcu21/PkCXTnpjPsPC0pbg1ItHgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUq1NH8SODd4gGLUONIZS2/k9AtSbjU/OJSoQrLqLBRLqkfYsF
	JNYRx+gpYgkBGFxQLbFvxfSMHlLJpUiL3Pdj0GUZKp6pI0rOehSwkPFN
X-Gm-Gg: AeBDietjjcgv/Jvr31RwgzX35+Fcn/7bhdCVpJK6+geH4BZGREaLQhFzafeL8lEZ/gf
	9Tza42epTIU9t5T5ipBoFdSF+MRwythZDfRoa9I/Mfz5dVisj+agx1ZAJlZmPBOzD9vSrwj+V4r
	hNxdAwsVrODDEL4hry3luvFDd/nH8XC+6Fms4kmtmuPmLi2Hw/Wc7OKLSAFM8Z/vYUbuM8dSqCf
	TMU31SqW7EP8Yi360nv3mxm0s1E71EjMut7yYjnifPXOvZ71DlHCzrTWN49fO7Q7SoCQTaU/81h
	c9vYfun5o/z9LlQkb32Vijv9WdLn+wjwCLyIhw0DFD6En6EYxaByd6her+VgS/YOvxQFrPWUfg2
	R3RpfhZSomijwVyWw7CXMr1XhAPyjqMvhgaLuYo83Yt6hPJ+1NfZSSGCTLX4f487A6vxw/TdHkE
	SSQ+Rs/5D1JBMfWLdcbSAwXQY8cozrjleUwAZ9BNQpp0e6fjq5MB0FsfamQVeQ6WyqMnpL3A==
X-Received: by 2002:a05:6512:3e14:b0:5a4:b02:66b1 with SMTP id 2adb3069b0e04-5a40df72e59mr1274826e87.9.1776349085760;
        Thu, 16 Apr 2026 07:18:05 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a40a308521sm1318589e87.74.2026.04.16.07.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 07:18:05 -0700 (PDT)
Message-ID: <98503549-00ca-46f9-9f48-2a48131cd29c@gmail.com>
Date: Thu, 16 Apr 2026 10:18:03 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Backfill fixes and edges
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2088.git.1776297482.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2088.git.1776297482.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/2026 7:57 PM, Elijah Newren via GitGitGadget wrote:
> This topic fixes a few minor issues in git backfill (from ds/backfill-revs
> this cycle), although some might see the third patch as more feature than
> fix, and the first two patches are pretty minor and probably do not merit
> consideration before the release this late in the cycle.
> 
> Overview:
> 
>  * Patch 1: As a wise man once said, "Sending arbitrary command-line
>    arguments to setup_revisions() creates an opportunity for behavior you
>    are not expecting. For instance, can users...supply --first-parent? What
>    happens if they add an --author filter?" ;-) I think these particular
>    cases might work, but other rev-list options don't make sense, so let's
>    error on ones that don't.

I know that --first-parent was one of the options I _did_ want to
include as a potential option (it helps focus the set to a "core" of
commits and we can get more on-demand off the core if needed). Yes,
--author is a little silly, but it didn't seem necessary to block it.

I agree with the reasons you gave to block _most_ of the options you
blocked. The output-formatting options don't need to be a hard failure,
but that could be a later improvement. For now, I think your change is
entirely positive so doesn't need change.

>  * Patch 2: Making documentation more consistent with other commands
>  * Patch 3: Tweak the ranges so we actually prevent on-demand blob
>    downloading better with a new --[no-]include-edges flag.

I gave notes on every patch, but no meaningful changes are required.

Thanks for helping to polish this feature!
-Stolee

