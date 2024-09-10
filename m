Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFF929A5
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935854; cv=none; b=ZOSyYlB6LMyHNYXdDX1ZzfgGI/nLLXvbrMTWyChWxpTJgareEDXp9JUcLIpkDS8Jj5B+nZ0hGv/oQyR0DSlz+XMwPnfUixcmzitqRREJsHh4ArdzE2oPvR+TLnI/jOQ4p+hGgSq//LplWGw9SnIPSowRXQ2k26HZd+qwjFoeBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935854; c=relaxed/simple;
	bh=6oE62cSVmG4TAQWEZX/8ew8LSZo5AcbKex0mO2rVFK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFPxGA65t0ggeD6TiE6n2fHRpOReQiIGJ3y10qb2JmPWZ4MxRAQQ5HfkmEi2hcqC2aFygiecVGu1rRbjICmN/IzbfB5aCuE5G0pdAxOs8tomLlRZjZn7lCBGhnggr88JjFNxjsAp/qylfs7GSMDD239qVLYPxeSn7E1nDdHObBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4qUjD7r; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4qUjD7r"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-710f388621fso532455a34.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935852; x=1726540652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFd1xf46N/KxWunZeGMqnlAsJplFG31WtVaivYsOp10=;
        b=H4qUjD7rma+ymZ7ur7Swza3/AulGLYk7p0/7WmYHfWjijFEHaCmEhww2F7c3myfltj
         S91rog6N9/bQk4JBT1Fs87Y7h9CCGGgRSZc3QYygh99GdjYM4x/CF8E4/tZz9tOYpB51
         7Vx2HA3JBPq8psvsr5eo4Z447DMBBE+aGXs4U0/GaLzk6VT4dNXZt3DddagNdcsXk0R2
         jixqeHkDBFMp6+33H6Z3X2x+n0U64FqXl1yb459OpZY9lnSvCc3yFcBLMqnh7pm/Ww+q
         +iAYjevbp5KTYJax+tBk2N9Rj8ELnrNSPcYgJyxFeH29sbH4Dqj4x+wRtpEV9RYevipm
         Cftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935852; x=1726540652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFd1xf46N/KxWunZeGMqnlAsJplFG31WtVaivYsOp10=;
        b=JD5cugL2sA/MFG3OGt3lzmi3CJP34uSRph7kfA32MN8Hhm1MKhzCVdUV5vqznpMX1x
         8E1e5A/6DktROtWThBFk3yLezcHMN6vq7y1rvCNcXIJEEq+mlqi7E25cJyEGQWddEySL
         UKIxuRiT9qEVgk9gyzbFdP/QSDe+bU6V2C0BtyXgJGvABiE7eV/hq/1QHtJIj4ZBqukh
         aqg1pELD4CftMB0ORf1ccnG6ITNr6hJTQXoi3YsgP+ofG+7ReWmnYBNXMbNciF30MgmL
         tfJjPEFFOVL3Ys3/AzqTLC+Ehl801a7Wj3X73XTbPuRhtTinWKJJfco7YvZAWaaqyT6K
         zxKQ==
X-Gm-Message-State: AOJu0YwJch8XcXpgAOEr6wsjVU+on2dpOW/IH8qwbpd5MIHEV0nX1T2v
	Asb8d7RKfTz2nGI/I8dSFPPrqn6WlfeDFAiZcCD5JFoL0dnOtJKB
X-Google-Smtp-Source: AGHT+IGBn3Asw5q5EOXeqBsaRe2ybyJGCkpycnyI0QNVWUmLELeaPYBoJtBY2wYsIlUOY/7IUvpCCw==
X-Received: by 2002:a05:6830:3108:b0:703:5ccb:85f3 with SMTP id 46e09a7af769-710cc26dbfamr12069631a34.22.1725935851968;
        Mon, 09 Sep 2024 19:37:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d? ([2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710d9db361bsm1698161a34.51.2024.09.09.19.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 19:37:31 -0700 (PDT)
Message-ID: <0e6dde0f-63e2-4db3-9225-9a8ca5e78eb3@gmail.com>
Date: Mon, 9 Sep 2024 22:37:30 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] pack-objects: create new name-hash algorithm
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
 ps@pks.im, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
 <xmqqjzfkr9b0.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqjzfkr9b0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/24 2:06 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> One way to find some improvement in these repositories is to increase the
>> window size, which was an initial indicator that the delta compression could
>> be improved, but was not a clear indicator. After some digging (and
>> prototyping some analysis tools) the main discovery was that the current
>> name-hash algorithm only considers the last 16 characters in the path name
>> and has some naturally-occurring collisions within that scope.
> 
> Yes, as I explained in the other message, this "collision" is an
> integral part of the design to allow us gather candidates together
> that may yield good deltas among them.  In addition, header files
> whose names end with ".h" tend to share a bit comment at the
> beginning of them in many projects, and the proximity (not
> "collision") of the hash value is used to make them delta candidates
> with each other.
> 
> I do agree that considering files at the same path from different
> (but close-by) revisions as the prime candidates is very important,
> but if you spread the "collissions" very thin by using "uniform
> distribution", I am afraid that you'd end up discarding anything but
> the blobs at the same path, which may go too far.  Having name hash
> value that are close by no longer has any meaning in such a system.

You are right that some "nearby" paths are lost in this change, and
this can be measured by trying to use this option in the pack-objects
process underneath a small 'git push'.

The thing that surprised me is just how effective this is for the
creation of large pack-files that include many versions of most
files. The cross-path deltas have less of an effect here, and the
benefits of avoiding name-hash collisions can be overwhelming in
many cases.

> I hope you can find a solution that strikes a good balance at the
> end of the series (I saw only the first step), but I suspect an easy
> way to avoid the downsides you observed is to use both.  Compare
> with a handful of blobs taken from nearby commits (the original
> object order is roughly in traversal order, and you can take
> advantage of that fact) from exactly the same path (using your
> "uniform distribution") before comparing with the blobs with close
> value (of the current function) like the current implementation
> does, may go a long way.

Funny you should say that, since the RFC I finally submitted [1]
actually does just that. The --path-walk option changes the object
walk to consider batches of objects based on their path, computes
deltas among that batch, and then does the normal name-hash pass
later. This seems to really strike the balance that you are
looking for and solves the issues where small pushes need to stay
small. It also fixes some problematic cases even when pushing a
single commit.

[1] https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/

However, the --path-walk option requires significant implementation
of a "path walk API" and my RFC doesn't even do threading right.
The --path-walk version (probably) doesn't work with delta islands
or other features the same way as the drop-in change to the name-
hash heuristic can. For that reason, I think there is likely some
long-term value to the --full-name-hash option even though the
--path-walk option will be better in many cases.

Thanks,
-Stolee

