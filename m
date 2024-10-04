Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD63D126C04
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033360; cv=none; b=ix7HIj6fAFz6KBq3DgpHWnn8boWQv9L0RtYv3SFlZjf1dyTXsymOzWVfZk6pFbm1qBKiwhx1GB9+KMGDAtOnR7Sl2X2I2Vd/UNYLtKvpkm3MxqtPnRDwStwpzZ/l5QFkgFmrOsgLH1KJRJIPbHgoSe6VhjijHdIExppWS0UuJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033360; c=relaxed/simple;
	bh=L8wVKyxncZb7ac2ch9/MzyozVYxLPcDZL32hWyFSwOc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jUnYOnzZV1urVOT48CrDXA8G7RPwPp5dwNPltS/T1ZUFZ+L+IF6gPQluOz3vgPZedW+wKImzrmFj2FLVci+q3ql0N9v3BM25F4Jk2Q9YXw1NpUpE5KQ0oAGuEZ7U4xiD0yNj9L1w5rwiwF9Iwj+JtiurV1VT5/8B6TEZ7CsRF9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9AWPn+0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9AWPn+0"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8ce5db8668so302255466b.1
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728033357; x=1728638157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2kqU9G4HeAcAvSMz01xQPVjhVkRDi+KLC2sgH6w3qM=;
        b=W9AWPn+0yB+0uGZ30mhmoeKrR3Fdck1sZzNArUIsBC8RiEMQqRh5BI3HJUnt/dS57P
         XfF+Doh4gIrdEwyI/yAlQrPOl41cCSq2tWZYR5NZDCME1A6oe6Nurqfi/SPm+TGROEvL
         pFz837jvaL5mWFjRW0XCrJU2TvAN+aL9kPjMRK/Fm5oJ0dbEw/3DOjf0pMeJ6KV509Jv
         D2o/mjIRt4k8ZNHuFKawiqUZW944Jg+WNGamTyxR4cMwspgwwWuyP4eCTyQdGI/JEzvI
         EYfyeALPXbxL8xjcBkUp0r3NW8lUp3igDl7cyQZTKauje/HYn0aqzdXx7HxeA3CfARft
         J4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728033357; x=1728638157;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2kqU9G4HeAcAvSMz01xQPVjhVkRDi+KLC2sgH6w3qM=;
        b=aBzb/f2RMxI1/6gr27hQ2AdEaloJRFglo66B6ALPMMEvwi3OptD0n/hdf/RPrptSnI
         oJ5QVw5b/7u6kg/9BW8PoqF5Yct+IkQflAuz4GU+hKrg1WT5ucAuzSjetXeu89p3Hw32
         xBfyBGslhLydzQvWUZvLBew6MbQoyDrMDm+mezqMzGfC82DyykgrlVgbzwqP89Wyvr66
         TNFtC1rSrJoTnzaT7mUOgCuyWrYG1nbsVx9wQiX/2dNBHuiJWfYE9W+DwvuAl8mjPFHB
         MpK5ffrklpj3WlKPBVcdcBSDEUhZAWiypWMswrG05Tij54GnTdkko40MkhoaYI+qWHGB
         Tu2A==
X-Forwarded-Encrypted: i=1; AJvYcCV1ubd47gpXkiocUYQ1I6mk2YKoItemDIXEiQc5c4jrSNA72zUMRAwZzURoO3YQ9d7Ekgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxll4FV7iBWPyHlneEPwg0fwe7oZnf6B9vfa+K0i+MP+cLdf0Cr
	7NJuIf/xjUxKhWHEpbTqYH5h6kE+jNn9UczsAyp1567J43ixfbrrhe/sdQ==
X-Google-Smtp-Source: AGHT+IHjMayIRhJAsYiHPOg9X60TuXkkwLFmThAj/Z1AP+JbwuWeB+2md7D6pXLdjmJRv0XW7X/j7w==
X-Received: by 2002:a17:907:3f8a:b0:a8a:53fb:d571 with SMTP id a640c23a62f3a-a991bd04ec2mr233966166b.11.1728033356653;
        Fri, 04 Oct 2024 02:15:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99100a3533sm200120066b.2.2024.10.04.02.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 02:15:56 -0700 (PDT)
Message-ID: <6c0b8681-95ca-4224-ba89-7582fd731565@gmail.com>
Date: Fri, 4 Oct 2024 10:15:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: "git worktree repair" modifies the wrong repository
To: Eric Sunshine <sunshine@sunshineco.com>, phillip.wood@dunelm.org.uk
Cc: Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>,
 git@vger.kernel.org
References: <E1sr5iF-0007zV-2k@binarylane-bailey.stuart.id.au>
 <CAPig+cQ8=Y6sVvN_dBo_GQ5nLkQ4GJ7AM6mE2kt_2QV7CR0omg@mail.gmail.com>
 <3b579ddd-b386-4daa-ad63-1e75522b7462@stuart.id.au>
 <CAPig+cTkpLLoTxTa-8xfycNGFibN_M71+kkHtT-wgp6HRPi-aw@mail.gmail.com>
 <4781ff6e-c20a-4340-851b-c9d324d1fac8@stuart.id.au>
 <CAPig+cTop=2+k0XbqYbsCTbJVo77evY+_a+FqDV_ziKf2q+Dzw@mail.gmail.com>
 <87afa860-52f4-414a-82da-09e7eeac1301@gmail.com>
 <CAPig+cSSDnq_kh9ERuYZmUCNrVvWmGFF8OSfBCy8bHrkx6fz3g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPig+cSSDnq_kh9ERuYZmUCNrVvWmGFF8OSfBCy8bHrkx6fz3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eric

On 03/10/2024 07:28, Eric Sunshine wrote:
> On Tue, Sep 24, 2024 at 9:53 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 23/09/2024 19:52, Eric Sunshine wrote:
>>> On Thu, Sep 19, 2024 at 7:40 AM Russell Stuart
>>> <russell+git.vger.kernel.org@stuart.id.au> wrote:
>>>> Interestingly, people (including me as it happens) start out by trying
>>>> to emulate the hg approach using a single parent directory to hold a
>>>> bare repository, and the child worktree directories.  Then they discover
>>>> bare repositories mangle the remote links, and give up on the idea.
>>>
>>> Can you provide more details about this "mangling"? Although the
>>> use-case you describe was not directly considered in the initial
>>> design, worktrees hanging off a bare repository became an
>>> explicitly-supported use-case not long after worktrees were
>>> introduced. So, it should work properly and we know that people use
>>> worktrees this way, but we haven't had any reports of mangling in this
>>> scenario.
>>
>> I can't speak for Russell but a while ago when I added a worktree to an
>> existing bare repository I had to update remote.origin.fetch and
>> remote.origin.mirror because "git clone --bare" implies "--mirror". I
>> also needed to enable extensions.worktreeConfig and ensure core.bare was
>> set appropriately.
> 
> Thanks, Phillip. This is interesting information, but I'm not sure I
> understand what the actual problems are that you encountered. When you
> say that --bare implies --mirror, do you mean the other way around?
> The documentation states the opposite; that --mirror implies --bare,
> and my own testing seems to confirm that.

Sorry I must have mis-remembered - it was quite a while ago. In my case 
the bare repository was set up with --mirror.

> That aside, I played around a bit again with bare and mirror
> repositories with worktrees hanging off them, but didn't encounter any
> anomalous behavior, which (almost certainly) indicates that I'm not
> exercising it thoroughly enough. Thus, can you provide more detail
> about the actual problems you encountered which required the manual
> adjustments you made to the configuration? (Does this also imply that
> Documentation/git-worktree.txt could use an update to discuss how to
> use them with a bare repository?)

"git clone --mirror" sets up a fetch refspec that forcibly update 
"refs/heads/*" when fetching. This means fetching overwrites your local 
branches and I think the fetch fails if you have a branch checked out 
that it wants to update. "git clone --bare" does not set up any fetch 
refspec. In both cases there are no remote tracking branches to base 
your local work on.

> Regarding core.bare: That's one of the settings which is special-cased
> (hard-coded) to work "properly" when extensions.worktreeConfig is not
> enabled, so it's not clear what problem you were experiencing in that
> regard. In my testing, `git rev-parse --is-bare-repository` correctly
> reported "true" in the bare repository, and "false" in a worktree
> hanging off the bare repository even when extensions.worktreeConfig
> was not enabled.

I've a feeling I thought I needed to set it because I didn't realize 
that core.bare was special cased rather than doing so in response to a 
particular problem but I can't remember for sure.

Best Wishes

Phillip
