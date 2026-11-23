Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447945;
	b=FIW2yqRUgq9wavuiydt/i9D2ZgCvFYF4wCN/3sxHyeUNhiB6vwPXWzSAaRhZaKxv+nBe
	 vmiAZU7bTzGa8MolpCMkEXSr3tB0g21L6oAeo40QIWf3F0v2K9gWZums9STwERTa6UcpS
	 Zx932BAro+dbMnnkOUbPqrHSaWBWJxuH3bWpW58/FPd5NB7n79ZvFCyPAN709qUB2c+3T
	 ab8DW2jI/XRCgw3fNl6PaSTL3OqDF0EHmsHgGn4QJXfPPC2/tiiBmiNgfAy88nRJnM6Ib
	 mcpw8apwB649xLTQ/PXPaQgErAnRyLBOlm+ZcK7HjStUZxmvQyecaMi2y1vH8doLG3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9VvRj+7NPeE25uyO7TVjUhmYB5LT649+yug3U4hSdcM=;
	b=kQXzeayeXPE+rGALNFue7ymGrgJFaC8dSuVPNs5TMxtngNVMFCnzJgSUUd+gNts05f5I
	 2eYy5thT3l8My4SLsnubaf8zPz7u4v6AutcM7mvkodTlNUdLQ/7+2YjCQraOJK8BkyprQ
	 PnCigDjeIxzaRQH6W53w5MY02Y8qykXHp7GAuraDWzAvSv1DIRLq9iAqIVKxvaCmw7tYn
	 l/MuqJzBgMme47IhKa9BLn1ZqcYZ99AqIJZoF+eFptw3W1ZYL1iUzvvzD1DVnzKv+wwjC
	 lKiAgEhuylQd4Nq405ET3NI6Cn+mPbsMWmP15YejI6NzGS1ZOp5cJNj73qu2wXJ4bvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e9UFwtg2;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758F606A31F
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D758F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e9UFwtg2
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b8a1f59d5eso4304837a12.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 07:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795447943; x=1796052743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9VvRj+7NPeE25uyO7TVjUhmYB5LT649+yug3U4hSdcM=;
        b=e9UFwtg226ERKFS2wu9ujPtSR3UwJf27WzpWJkk4Fm9Cvf/NRe8lu5/4NVPKy+UQG8
         tSe4QRyg4+7zbV/b406CNIPmOIqNgFGmcQLnhPuM4bLlHQ3iZjbu1SaHwH1mqvoI88dj
         gTkjaYsCjgG0L/5dn5wakmGkFf2ye4vinUH+Yj+PZJcljoP+nZ/uPGjp4dByOQErGY1f
         RgxU6ZniQVUxYqu5TDa7/pyEXUyOr4th3w3IjoOzjF6u9J9eUcuIFFkeAK5d7acIRlw6
         3tFRlsb7wo7UZCzJi5r4x5CMOS14w96aRlBfsD7TI1sjFUPP13NJzXIyoommKCw4F5EC
         bu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447943; x=1796052743;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9VvRj+7NPeE25uyO7TVjUhmYB5LT649+yug3U4hSdcM=;
        b=wU0j6TgV9jp3Xc9naH5Rk7YxWuOij55mSdCc80ELHOVqJFI3+G/hBrzb5yEW5GpdJl
         zhj7kXFS+fU7cVQSaD+ZmatgkVW1MDAeo5DGV+/GlIe9/UH79wm9CVIhOQCCvM1BlayF
         2Yq455mn3+8zN9h9PGrCGK7LJHaL8Xog9l9p4TZk5hYGdkygaiAsfo6tPUcyuL7OOfp2
         GAAoufQbE39XbgJ9NVrMENUTxAL1zEiQzx7UZTyB9qd0RnP/jFbZNCKtctYbEcHVpd3x
         gnEbqWAQqNNiFN7xjlktJ65xJC5BaFp+oTXpOl3CUVdrKSrr21gH3ImlkofFVhM8Ltmc
         pdBA==
X-Gm-Message-State: APuU4Z8FKQz5dgj8oDF+4j7SFOEHEgzsHCzXEFzNDjeUP0KLOpvbT9y0
	ayBSECoF6ETfM/PE6fryvKUuJG9YRYBLt8QZ5tCJXWX2bQ7kscJqrdxw
X-Gm-Gg: AZFdTZexCK3ksbCS6nCymcotCbpjL3nJx1/h4TaKJN56ayxpYFfLH7p1UI0ZqWz2SAl
	/UemOzUPFFAusTcyxFnlkRl9yMDl862udeTVBvbMh7L3zfSrimYiOYusNjFjEBYzKKmGA0dR0MF
	Ew3xFjRf4h7rlEk7j9xESwOf8SPnIB4Mgl737hKtdo9dpVfXNcpawTETKkxVDv8l6qZKtrDjdVv
	nxiF0EfoLGB4EWRBe+MOZr1UV2TcrgyLkXtGFJijOexmi/fI/YUnUwH2x0sgHJTZbrfBAThIcHj
	VzQ/qYUIi0enaJijKZ/C/Q2nnp2FxPryLUHk9j21n/1F1eSpNnCFOU1ggF2YzvDtLIosCpopOJY
	CWbfkIl4M3bK71ABgKzGBTfO+CWOiMDI86M7xyo4GiyGr6fqTCLL/Be3uqTBywOw8ogNJ2Jhv6D
	x594/MR7mf0GZWZQBMwpdv3rl9gV66vMC/ZNiuZMfMie9/dzSQh11UiRQdXZ9ksO3MxaH0vvu91
	JxXbT85EQFZNueWrHcEE2tLCWjX3Y3QC+ZVxxoRjjQROiqsUnl5MCwj1U5fFkdrx8CI0TOL8a3h
	XjaWxTZz4TzCPnLF33S/Oh6iznWugOflyw==
X-Received: by 2002:a05:6402:1941:b0:6ba:7be9:ad85 with SMTP id 4fb4d7f45d1cf-6ba7be9aff6mr4520559a12.29.1795447942200;
        Mon, 23 Nov 2026 07:32:22 -0800 (PST)
Received: from [192.168.0.172] ([217.71.1.73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba37109c58sm5386915a12.33.2026.11.23.07.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 07:32:20 -0800 (PST)
Message-ID: <6954cd53-43c8-48ca-82da-35c673dee260@gmail.com>
Date: Mon, 23 Nov 2026 16:32:20 +0100
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
Subject: Re: [PATCH] doc: update-index: Format options correctly
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20261122152538.107580-1-omri.sarig13@gmail.com>
 <xmqqfqwsk4a6.fsf@gitster.g>
Content-Language: en-US
From: Omri Sarig <omri.sarig13@gmail.com>
In-Reply-To: <xmqqfqwsk4a6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 22/11/2026 21.19, Junio C Hamano wrote:
> Omri Sarig <omri.sarig13@gmail.com> writes:
>
>> Subject: Re: [PATCH] doc: update-index: Format options correctly
> I'd downcase "Format" -> "format".
Sorry, switching between different conventions bound to get me
confused sometimes.
I've already updated in V2, and I'll make sure all future patchsets
have the correct casing.
>> The update-index man page had references to several options, which were
> I take "had reference to" to mean "talked about" here.
>
> No, I am not suggesting "talked about" is better.  "has references
> to" (or "refers to") is perfectly fine once it is written in the
> present tense, as the early part of a proposed log message is
> supposed to give an observation of the current state.
Understood, I'll update.
>> missing the relevant markers, causing them to be formatted as text
>> instead of as references.
> But then "as text instead of as references" somewhat misses the
> mark.  These parts of text still refer to option names.
>
> They should be typeset in `monospaced`, which is the convention in
> our manual pages.  And that is the issue you are addressing.
>
> These changes do not make things worse, but I'd prefer not to see
> too many low-risk & low-value patches that address overly narrow
> issues.  If we compare the resulting text after this patch, e.g.,
Understood. My thought process is that by introducing these small
changes, we're able to make small improvements, without putting too
big of a burden on the review time.

I'm in the process of reading through much of the documentation, and
along the way, I try to note these small issues that can be fixed
easily.
Would you rather that in the future I 1) make bigger re-works as part
of patches, or 2) not send these patches altogether?

If it's easier, I'm also completely fine with dropping this patchset.
As you wrote, it is a low-value patch.
>> diff --git a/Documentation/git-update-index.adoc b/Documentation/git-update-index.adoc
>> index 9bea9fab9a..9b956216d2 100644
>> --- a/Documentation/git-update-index.adoc
>> +++ b/Documentation/git-update-index.adoc
>> @@ -57,21 +57,21 @@ OPTIONS
>>   	updates are needed by checking stat() information.
>>   
>>   -q::
>> -        Quiet.  If --refresh finds that the index needs an update, the
>> +        Quiet.  If `--refresh` finds that the index needs an update, the
>>           default behavior is to error out.  This option makes
>>   	'git update-index' continue anyway.
> with another manual page that has these mark-up corrected in
> Jean-Noël Avila's series from early this year, e.g., what e9a99ef2da
> (doc: convert git-format-patch synopsis and options to new style,
> 2026-07-23) did:
>
>   Prepare each non-merge commit with its "patch" in
>   one "message" per commit, formatted to resemble a UNIX mailbox.
>   The output of this command is convenient for e-mail submission or
> -for use with 'git am'.
> +for use with `git am`.
>   ...
> --<n>::
> -       Prepare patches from the topmost <n> commits.
> +`-<n>`::
> +       Prepare patches from the topmost _<n>_ commits.
>   
> you would notice that while we typeset `--refresh` in monospace now
> (which is a good thing to do), we should also update the enumeration
> header "-q::" to "`-q`::", and also "'git update-index'" in single
> quotes to use the same `backquote`.
>
> Also the way these changes are described in Jean-Noël's log messages
> is quite good.  You would want to imitate these messages.
Thank you for the reference. If you still want me to update the
current patchset, I'll update the format as was done there.
> Thanks.
Thank you for the review!

