Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D51F3B101C
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955209; cv=none; b=E8g/ejk3D8A/6ZU067kDcUD/YVH6lOnUTTunNjVy5l/Uu/vUuLvXC3yke3wiVc6JtSeW+1if6J+XUe11U5t7nvbpnr5rh2oCVLHOJz15+5f9XkUkAciFMILi2WkgEn9I83qmnY1S7pLzdqfzFJDx53NuGwzNFJmYYDN+yeisf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955209; c=relaxed/simple;
	bh=MHx/ubSjlVPtjCLuWNfzF7z6pBFPPTJj88zcvGOa9nw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DeELHAnCVRbLutzHLakAyur7EUH1A/9J0M3d1LqQjAM5otTmhNiQJhxbT62Q24/1pNv7nfW7ZKs74uvq1T6M+fxEOOcaAMzCmLiWcKagnTZuj7rny17vqT3D8yXkalSG3chF7y/hppX++z6joqdtU6Lih9at3LzfL6iIuojM3CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaWGxGg5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaWGxGg5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so27847685e9.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2026 01:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786955206; x=1787560006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zaaEoK1OMA5fzJjR8fxDO1t3QS8Gy8Ch3qN0G3d1xWs=;
        b=RaWGxGg5NtO+aP+WHyzHpnZiRnmS7DrqsRwJtusD+ouDURrJKrLLwodl0jn+KbyQYx
         IU4G102jV+46h3EiJXzATgwdiL/nUkOxHYMBH78YEN9smMJN1+za6MzpvH4FbwvcTvd0
         mM+cHGdH1a4DT6GfyrnN+AUuW2j/SGEAgdNdgFrj2zYe2UfEv8UwdvNNQMmq0pHkMovC
         tcn7u2Nhh8X04p677Orv5/AcW/++FBvsa6hykcjT4I+46Qddx3BglHYkbw+tIDtxYuvr
         1VC2M6oIpsQ6ARnvLpySd+4qW/brxFK31YcRlrNEII81HaHF+F3PeThq1YjQ1w3J1lyF
         kkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786955206; x=1787560006;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zaaEoK1OMA5fzJjR8fxDO1t3QS8Gy8Ch3qN0G3d1xWs=;
        b=FiwlSzC1xA6EOg2hw8loNkJDKMUNG+1LT2P+IFBzt6Yql3Ac0ReezTW/bPd/rKiED4
         YhEwCsGG6EEWDFemr/QCKGztYGZMuDiVVSgShh1NLrTahYgGYEVzGmLI76TyFDtCJutw
         ExePjI8VSVchmGBRCslelp6ycNZ/m3QPpe9Fb2qa2e5YDCSYt8bPpTNtj2xtRe03Johe
         sH+br9X8H2vqHoFxvPUB2CFsZM14grJGxR2RJAnSXHHHv9RPsXExf/Pk0doQdKZ7v7ws
         aRgzetBUHa8d0bJ1rP5bhPlDQv9E0miBGntKiY/CVZ28gpWoqtGMk0wJWTAULLclRH2d
         Vnig==
X-Gm-Message-State: AOJu0YyepaJJmrU64STtDfBtJBs58HaUmgq2dVNG/6eEsXF9rLpuh5wa
	7M/i+l1bISEpHyv9P00dEDtTLE32XpkZizQ3IfA0YGuYttcvQ/VXcDoy
X-Gm-Gg: AR+sD13KdP8n2u2fVHEk7O0InCqpiEm3IWztpROPwPi+2WQgSPnnFqikmwJ4QYU6Uyo
	4VUlN/TjOTaPFyXatyv4qc8h3dy5Fhc3sPSCVyv5e6vdyZeeC18igPktDaMFhKphSbN1KDA9uW0
	n3x5LrmtLVweZBIWZCzdBfgw+E+hwUjtH2L1Tr5Bz1C/V9xzfOiHU55tRElKXqCwA3VnECbgabL
	/Gvza4aIyuoXiYRvQsVHFJPHZfLi7x7imwwMpKeSNN+7iV+WtXRSxb6/flTTZxo9RxVFmOLyJgL
	rYfiSvUkmzbQhCblj1AYTdJ2h8mSv7AspKQaFzY2y9Fj7AGnk5BVbzJcr6ltyE1fdykqdwL1cUF
	RkSHUGR2rbjo3i/YPrLXqUn5qiOlnYjjRw/v0WhquQ5uZfZhck11byiEHtoP7GD8kGIUz+c6e+N
	WGo09iwMhiMv0Tm+ol9UwELsdd2k5m2/hza7pKC9e3dEfASVhN8TWO/obu0oT5Mm1DgWTSEhBmA
	/ldwpsiwfWezlZdIMLfVQ/U+OxbErgv8dTONQ1NJ4U=
X-Received: by 2002:a05:600c:6088:b0:499:7219:122f with SMTP id 5b1f17b1804b1-4998792adf6mr418488515e9.4.1786955206440;
        Mon, 17 Aug 2026 01:26:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d063a68sm19940465e9.2.2026.08.17.01.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 01:26:45 -0700 (PDT)
Message-ID: <f34669ad-9157-4f13-a3c1-c0abbc660497@gmail.com>
Date: Mon, 17 Aug 2026 09:26:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v13 7/8] history: create squashed commits without editing
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Matt Hunter <m@lfurio.us>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
 <pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
 <8b3551d0d4ecb360775ea29507ee262c7bf9cd42.1786088371.git.gitgitgadget@gmail.com>
 <xmqq4igyszeb.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq4igyszeb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2026 18:28, Junio C Hamano wrote:

 > "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
 >
 >> Inspired-by: Sergey Chernov <serega.morph@gmail.com>
 >> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
 >> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>

Thanks for the Helped-by: trailer, but this and several of the other 
patches are missing my sign off from the fixup patches I sent. My sign 
off should come above yours to reflect the chain of custody.

>> +test_expect_success '--no-edit uses last "amend!" message without an editor' '
>> +	git reset --hard three &&
>> +	write_script editor <<-\EOF &&
>> +	exit 1
>> +	EOF
>> +	test_set_editor "$(pwd)/editor" &&
>> +	echo fix >file &&
>> +	git commit --author="Fix Me <fix.me@example.com>" --fixup=HEAD -a &&
>> +	git commit --allow-empty -F - <<-EOF &&
>> +	amend! $(git rev-parse --short HEAD)
>> +
>> +	The first reword
>> +
>> +	More detail
>> +	EOF
>> +
>> +	git commit --allow-empty -F - <<-\EOF &&
>> +	amend! three
>> +
>> +	The second reword
>> +
>> +	Extra detail
>> +	EOF
>> +
>> +	test_commit WIP &&
>> +
>> +	cat >msg <<-EOF &&
>> +	amend! $(git rev-parse HEAD^ | tr a-f A-F)
>> +
>> +	The third reword
>> +
>> +	Excruciating detail
>> +	EOF
> 
> Care to explain why you need to (1) eat the exit status of the 'git
> rev-parse' command and (2) munge the commit object name by piping it
> into "tr"?

I chose to put the command substitution in the here doc, rather than 
move it out and use a variable because it was more convenient and it 
clearly shows what's going to be in the subject line. To me the benefits 
of that outweigh the minute risk that we'll miss a bug, that's not 
triggered elsewhere in the test suite, where "git rev-parse" produces 
the correct output but does not exit cleanly.

It's piped into "tr" to check that

	target = lookup_commit_reference_by_name(s);
	if (target && istarts_with(oid_to_hex(&target->object.oid), s))

uses istarts_with() so that we accept uppercase object ids.

> When another in-flight topic is in effect, this test will break due
> to "amend!" followed by a string that is *not* an object name, as
> the other topic declares that uppercase letters are not valid in a
> hexadecimal string.

I've just had a quick look at that other thread, it would be more 
convincing to me if there was some explanation of the security issues 
that accepting uppercase object ids causes. While I appreciate brian may 
not be able to talk about specific vulnerabilities in particular 
products, it would help to outline the security issues in general terms.

Thanks

Phillip





