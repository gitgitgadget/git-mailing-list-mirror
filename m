Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4BA430BBC
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772361853; cv=none; b=qjE6/rSpNq3QddeyabIunFb5BB1ovdJBnayjjIHe+hXtlKY1PP5kieRuBA6JIpEO5i/vtZoIPmygkR8cLeiBciP2IOiA07Lqr+rnE/jwncQGx65jRJ8P05LA9Mkm0VrhcrD6gfQ4U5Or6v+FtMUW9IeiKtzjYwa0b95zOWz0YFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772361853; c=relaxed/simple;
	bh=2EarzREDWNac0mXTVAPZwq87/Z/u0PjEEUXaLz5Eu6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4REIFKVLCTPb9qkyl22iP3fyHQkTblQtbRegPc2AFBp70Wl3r7vesqK2lrDn52i6Q6gmSADp3z/9dAApj+qwSRGiFVEyyUQofRF2jXzxXtAOPc349ld2rXxRs6liIzRQsN6U8v6RM4PAfSSKmtcbXSnZ6iToW8/kmv89DIQMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR2qlcVG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR2qlcVG"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-480706554beso40762485e9.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 02:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772361850; x=1772966650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q7TtlWyWtY9q2mee7Mm+PZLRB69cfZ8sHhL2WV5f2NY=;
        b=cR2qlcVGq1Uhsr4lQuFavqjZmIkvdrbWj7Q/1co0IhS9hslHL5PgSedBtWiKO4kLjd
         VNqAWAzFgMQYlc4Ctecyx9fsOxYeM/DCo38UYbUG9tvI38YrDUhHY/oqxQsSttpN8AOm
         LAgMn2TO4LdqP0UPiTzHsfpCEWkwyP6FItQdie+nlvysaxuzcpDv4KhsyVpvsR39UV4E
         EXxXtL24THmOwJQPXXelisez4uQQqLS8fPnKFtY9pok5hWN97cAwbrS/6UtVdtSVVRA6
         Ek1HnuaWi18bIRfPyN3iBt0Jun/BhNpMPJnWOfldWazqKUcRCWlOXSlVKy7kj+4uiCXj
         1yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772361850; x=1772966650;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7TtlWyWtY9q2mee7Mm+PZLRB69cfZ8sHhL2WV5f2NY=;
        b=cDDGz1u6Gm0nL+3v41ddE+GypM1yJlnAhUgVjxUEPkt2apoF5KvgYAcRNvmlXCXjGA
         Lf5MXapVAXnNXUHj/9dAWGJQikK9+UDPJjt5Lp/svIJ9pll4hpEqzetlwTAeaxhMKHFd
         iBPkYnH/XR+yk6lNDDWWXDE3kg+Lbcridz8yfERVTdHNA09kNUYST8VKPwEXADLRZTZT
         HzqN8nrchB0+7T6Q37he0N6xLaHh3v4zunLefn8vaOkjPtbI1kSJqe0SlZFCotUT/7Ns
         kjezWWSv7YmLvHe7PGD466Dr3GR/4TK/4CXo/tFQHIXw6zYxryMQZ31yGQU16p/qLyYS
         1LIw==
X-Forwarded-Encrypted: i=1; AJvYcCUzWZy/4669gE8SD8FP8lknDbbbmbrVbMEpQOE5sX1neV6jr4v/VIe8WyYoeaJLnmv3T30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgVPsz0Iw0O1nAvnXK9VT1N5z9L2Pmw1XzQWpsftJJdrKR6d1u
	brSEplW2Lvm/PLpNP8wgRbHfxfbxL2xngjtPmmSH5rHabxlt5YrTURzn
X-Gm-Gg: ATEYQzzOOiIMHpHk2b7oRhKVz+p1RpLI8xTva05gen1vd6LxWv3r8Fj/Je2xjjgf03m
	lArQwx1VCK0hMqx7giZK5is3mrzz5NErwKQTHQaKSySxSQzwfVTWBEWISFZr5G5AE3D6X7aY4W+
	ScohF2TfFqrteSZzci9sX1Q17cfnomZbJKAVE+KJjZdi0btnoLp1OyyAtp/3pKcyatMIzQfAX8W
	wyfr1WC8rKTXCE8zhi/giACN/sDdMPmt4sTr4De9laI+MD6sghu3B61p3YW7guA79XPGdep1xRQ
	HRyhKpybN7+ehAA8Mcbgv1HzXgDRF/KYBcHExiSRGBbwsNZG8CVf2O98f7xtjcx0S3egQKT36cv
	60NbniIdxHzHzp91kFDD6bqH7IiPZxWdDdUO71sefuomShVRIlaI0KCgGEHVio0laqGGo0uMCdj
	XwKT9g6RTb/8OIAgb2BnN6Ebhz8E+DcuVs2c6aG6v/svicBC/kqz76+BfexYT+RQWATOoZPw297
	wJD4Q==
X-Received: by 2002:a05:600c:4e56:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-483c9b9eaddmr150124515e9.11.1772361849972;
        Sun, 01 Mar 2026 02:44:09 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b841absm250945435e9.13.2026.03.01.02.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 02:44:09 -0800 (PST)
Message-ID: <c074cec5-eaac-49d0-89cc-d2ac9d605e59@gmail.com>
Date: Sun, 1 Mar 2026 10:44:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: sandals@crustytoothpaste.net, kumarayushjha123@gmail.com,
 a3205153416@gmail.com, jayatheerthkulkarni2005@gmail.com,
 valusoutrik@gmail.com, pushkarkumarsingh1970@gmail.com
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lucas

On 28/02/2026 22:05, Lucas Seiki Oshiro wrote:
> Hi!
> 
> This patch series adds support for path-related fields in repo-info, based on
> what we already have in git-rev-parse:
> 
> 1. The two first patches moves the path formatting used by git-rev-parse to
>     path.c. This will allow us to reuse this code in git-repo-info
> 2. The second patch add a new flag --path-format to git-repo-info, similar to
>     the flag of git-rev-parse with the same name
> 3. Add the new field `path.toplevel` as a proof of concept.

How does this effort relate to similar effort at at 
https://lore.kernel.org/pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com 
?
Also note the suggestion from Junio in that thread to use 
"path.working-tree" rather than copying the name from "git rev-parse"

> This arises from the fact that I didn't know what should be the default behavior
> of git-repo-info when dealing with paths. Some ideas were:
> 
> 1. Add --path-format, just like we have in git-rev-parse

I think that's the best solution. Having different defaults for 
different paths like rev-parse is confusing and having different keys 
for absolute and relative versions of the same path gets rather verbose.

Thanks

Phillip

> 2. Use what rev-parse uses by default
> 3. Add keys for both relative and absolute formats
> 
> In this case, I'm using 1, but I'm not sure if it's the best option. One
> downside that I see here is that git-repo-info won't be able to return
> a relative and an absolute path for different keys in the same call.
> 
> Since there are many people interested in contributing to git-repo-info, I'll
> leave the remaining path-related fields to them :-)
> 
> I'm CC'ing here:
> 
> - brian, who was the original author of the `print_path` [1]
> - Ayush, Tian, Jayatheerth, Soutrik and Pushkar, since they expressed interested
>    in contributing to git-repo-info in GSoC. (I hope that I didn't forget anyone)
> 
> This patch is based on top of master 2cc7191751 (The 8th batch, 2026-02-27) with
> lo/repo-leftover-bits merged.
> 
> [1] fac60b8925 (rev-parse: add option for absolute or relative path formatting, 2020-12-13)
> 
> Lucas Seiki Oshiro (4):
>    rev-parse: prepend `path_` to path-related enums
>    path: add new function strbuf_add_path
>    repo: add the --format-path flag
>    repo: add the field path.toplevel
> 
>   Documentation/git-repo.adoc |  8 ++-
>   builtin/repo.c              | 67 +++++++++++++++++++------
>   builtin/rev-parse.c         | 98 +++++++------------------------------
>   path.c                      | 51 +++++++++++++++++++
>   path.h                      | 23 +++++++++
>   t/t1900-repo-info.sh        | 69 ++++++++++++++++++++++++++
>   6 files changed, 221 insertions(+), 95 deletions(-)
> 

