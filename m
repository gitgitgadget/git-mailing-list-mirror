Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520173;
	b=IE5NVJPQVX38YJFhDFf9TK7GarTg7cwkuHIU/eGkTDfVdqXYEjCQamq5qGgmy38ZBvXr
	 GhviEOkvZ/tborgJ+FHFNnuEd+xvGWfIgU1RCgu3L9MxXTjs9veGw6wX1A+AEk3LytHFl
	 H8oXQBAWOgNH+hl9EEneUM/RfWkNCjoqPgefiks5JaZeWRBmrWPou9BMHrf1TvGxsR5cV
	 o6V6Z6PznuinWPBe7VffMoZzYMY0UbdY6oLqC3VRcYC2HnL5tYrScI7d8WAZZdNqZyUkR
	 ALu4yOryYLx8UjIcoF7bDZugjqshEbnXCB/ayTBpZdmQ8UEZ7noDIX/QQPGhVUquaTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7R5Z2W+gksXIstTYhmU3Hs+4c1yLvNBGUq4XOfAdXI8=;
	b=L2Uc6lIw9tnbI43lfnC/Sbw8ZltuHFO1gykLHbuUw4kZukZ8PDsQ5/0R8ReJva3cI7T3
	 fcHGagJYVoSPma7iTirfXgDUrdCQ7GrampG2QtF/UnOQJzLlyX6N+svDbv0bp3Yf72Zx6
	 JyW3rGVqVMQeTF0lqqWjp3WI/p3iTc70TNTuRZnfQ8kJvSECwzMXaBLLRVa7npeX5j4TS
	 Rb1dxTmlgyh8jflgQqnSLyvI61B6qcXftkZh5Z+4PSJslXkRVnouhar45Uk/ZkdZjgNgC
	 qqbrI4VYNurUTpELpqYItzDrNQS24d1lPEYA9lXyEJspcNVXopv5tFA+CEn5F0gKsBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="acX/Y7PZ";
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0E606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27A0E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=acX/Y7PZ
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso1408873a12.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 11:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520171; x=1793124971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7R5Z2W+gksXIstTYhmU3Hs+4c1yLvNBGUq4XOfAdXI8=;
        b=acX/Y7PZXvOoJGSr55vpPQxgx9osygGbnllbqh8rhSAW2/VAYs5HUy08d3/aRf3EQQ
         +czkTIvOPQIwDzSxDYcRvdOc7S+sw3RPxoBU8qSAFkKbnBftDUKR42WmiLs6z2v3Q9BF
         q8QqPPpqNMNF8iGpoEWfyIRAqB1mz1EM+0qroW/+MiQDZSPqOvkbH+qz0uO1G1M70saO
         8a56gRU2SaO5UQ0KKysQS81eI6vt40PPm8N6NXaC6XkU6ZFCnIeQpV6jAU8givdkMrmM
         vKF/a2nhCaqoQachkAYMkKdcurrXuxCi8kqqjNpayBoiB5O94QE1pxtb/WsmGwpgyEWg
         vg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520171; x=1793124971;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7R5Z2W+gksXIstTYhmU3Hs+4c1yLvNBGUq4XOfAdXI8=;
        b=h46nKxSHXquXcJW96FQH8/nxm1azStqIXtoOVr6vBKaEuWjHvASAGDCfCIynbWcvZX
         mEGZ941j92SMM6J5xlhEocaxnhkIW4S1SRiZGkEm5o7+Gu4808xlz0GB7dkJXLfTiHp3
         nGiU0OFQTruVzDddsJ369drQ/7RBlIJGq2aEgNOrEet+AAq+t6Ffkr1IoS752OiGmDJd
         iXiA7nRATqGsFrtqIyX3FZhioKfWT86560gUUOhNupo9aZVRiagg5CvcEM+DyVx8sTI1
         ItTFbbgLsc9Y3aODbilCcCaF3Pt8bcSicr6aTVlTWNuOsJ2CAgFkNBPWYG1PGg31dD+R
         4Gjw==
X-Forwarded-Encrypted: i=1; AKwUvBxPcwWwWQqcSQ8jLSX86GdS9l5dKY8Y9goksYj59hIMtuXe/8/+ryUjI3OUD5HIBGfFzqU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJf85KLzVo5Ufr8vqeMMRB5nQ/2K8KhSQTx3o6pR1wBlKSbscvO
	p4sJ85lSSEwt0zc2yD9COhb4O5WaZO2EaWar8yj3aIRqcMSHSACNi4A6r0pKxg7qcUXajA==
X-Gm-Gg: AYBFou05uR6xLCb/tMMbMR1E/1DMIF13S8XVRVLR4gyoZcRslgHT7pgV92vdLEhlOoK
	bNg0aUkgn0LM4lu9iH8G4QbxUOlaYpkXiCwW/BYZ40KsSNtQRXDWaQuwAWc1mzppK7e7gx8FBL9
	ivDRLEVB2GR9s9AT7O4QMPAdxsxqCqYSiq91Oc+LgtC/Jpo8xHgQ0u6eWsqY6vBum4FuGGb1EjU
	iqkUEMtsJMlP9fvLyv3gbGzPgsSixaj67PLLbLQlq91UCPbNbZRG7YGMIClJzf+QAoMuDu3NNdJ
	PDGKTIpn8e2e432ZPG+vQiNYs4kAzp33ruNOl7pWpHUq2xy5ceCp+K0m8kh1aLWOoHGbAomFTih
	iAAW17E+BLkg1T1l3Z3JHZ/6PWkbtcYtXOyGYQa42BZKsEJNT/dENwdjr270xiTa/cNI6lijC+E
	Px1FWo7PbWKVCtAfY79X34dTej0VtkxXB1R06mQNX3yxbizgOWc+dPC/3tNW4ASCqa/bH5aetNY
	DxSpoMuXuQOew==
X-Received: by 2002:a17:906:478b:b0:c46:7502:db74 with SMTP id a640c23a62f3a-c46799c88c5mr160566b.23.1792520171154;
        Tue, 20 Oct 2026 11:16:11 -0700 (PDT)
Received: from [192.168.0.172] ([217.71.1.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678faa02dsm2329366b.40.2026.10.20.11.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 11:16:10 -0700 (PDT)
Message-ID: <fce11abe-6d7e-495a-8729-c3a62c52c113@gmail.com>
Date: Tue, 20 Oct 2026 20:16:09 +0200
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] doc: git-rebase: update incompatible options
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Li Chen <me@linux.beauty>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Julia Evans <julia@jvns.ca>
References: <20261020150923.5595-1-omri.sarig13@gmail.com>
 <xmqqjyncxrur.fsf@gitster.g>
Content-Language: en-US
From: Omri Sarig <omri.sarig13@gmail.com>
In-Reply-To: <xmqqjyncxrur.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/10/2026 18.24, Junio C Hamano wrote:
> Omri Sarig <omri.sarig13@gmail.com> writes:
>
>> Several options in the rebase man page link to the "INCOMPATIBLE
>> OPTIONS" section when the option is no-longer incompatible with any
>> other option.
> There are several options listed in the section, but only two of
> them are "no longer incompatible".  So either:
>
>      Several options in the rebase manual page link to the
>      "INCOMPATIBLE OPTIONS" section, but a few of them are no longer
>      incompatible with any other option.
>
> or:
>
>      A few options in the rebase manual page link to the
>      "INCOMPATIBLE OPTIONS" section, but they are no longer
>      incompatible with any other option.
Will do!
>
>
>> - Commit 1a66d8c6f6 (rebase: remove --allow-empty-message from
>>    incompatible opts, 2023-01-25) removed "--allow-empty-message" from
>>    the INCOMPATIBLE OPTIONS section, but did not remove the link to that
>>    section from the option description.
>> - Commit a74b35081c (rebase: drop support for `--preserve-merges`,
>>    2021-09-07) removed the `--preserve-merges` option from rebase, which
>>    removes all incompatbiilty references to `--ignore-date,
>>    --reset-author-date` and `--signoff`.
> After seeing the explanation for the above two options ...
>
>> Additionally, `--onto` doesn't link to the INCOMPATIBLE OPTIONS section, even
>> though it is incompatible with `--keep-base`.
> ... readers would naturally want to know when this happened.  It
> seems that when the '--keep-base' option was introduced at
> 414d924beb (rebase: teach rebase --keep-base, 2019-08-27), the
> description for '--keep-base' had the "see incompatible options
> below" but the one for '--onto' was not updated, and the manual
> stayed that way ever since.
That makes sense, I'll add it.
>> Update the description of these option, to have correct references to
>> the INCOMPATIBLE OPTIONS section.
> "these option" -> "these options".
Will do!
>
> Also, notice the commonality across these three commits?  They all
> predate the latest tagged release Git 2.56, so as a fix, a change
> like this should be prepared to be applicable to the maintenance
> track for that release.  When queuing the last round (v2), I wiggled
> the patch to apply on v2.56.0 while running "git am -3", but perhaps
> it would be simpler if you prepared your patch on v2.56.0 on your
> end?

Sorry, will fix.
I've read the SubmittingPatches#choose-starting-point documentation now, and
will know for next time.

>
> FYI, here is what I queued for v2.
>
>
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index f6c22d1598..b84b14f02e 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -217,6 +217,8 @@ OPTIONS
>   As a special case, you may use "A\...B" as a shortcut for the
>   merge base of A and B if there is exactly one merge base. You can
>   leave out at most one of A and B, in which case it defaults to HEAD.
> ++
> +See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
Given that the maintenance branch predates 2fc11e3382 (doc: add more 
AsciiDoc
cross-references, 2026-09-25), none of the other lines have the AsciiDoc
link.
I'd expect this change to be:

++
+See also INCOMPATIBLE OPTIONS below.

to match the rest of the messages in this file.

Is this correct, or should my patch include the "final" version of the line,
with the AsciiDoc link?

In case the line should be without a link, I guess that the link will be 
added
during one of the merges? Should I provide any help/support for that in the
current patchset?
>   
>   See TRANSPLANTING A TOPIC BRANCH WITH --ONTO above for examples.
>   
> @@ -332,8 +334,6 @@ See also INCOMPATIBLE OPTIONS below.
>   	and this option would override that behavior, allowing commits
>   	with empty messages to be rebased.  Now commits with an empty
>   	message do not cause rebasing to halt.
> -+
> -See also INCOMPATIBLE OPTIONS below.
>   
>   -m::
>   --merge::
> @@ -487,15 +487,11 @@ applying (in terms of the author date).
>   	Instead of using the author date of the original commit, use
>   	the current time as the	author date of the rebased commit.  This
>   	option implies `--force-rebase`.
> -+
> -See also INCOMPATIBLE OPTIONS below.
>   
>   --signoff::
>   	Add a `Signed-off-by` trailer to all the rebased commits. Note
>   	that if `--interactive` is given then only commits marked to be
>   	picked, edited or reworded will have the trailer added.
> -+
> -See also INCOMPATIBLE OPTIONS below.
>   
>   --trailer=<trailer>::
>   	Append the given trailer to every rebased commit message, processed
Thank you for the review, it is really appreciated.
