Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E02BCF6A
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917410; cv=none; b=ZA6caNn+mxEQpVV8dYsVP1b0t9oPDx9P176JcziYAQ7W7ifLzx02ZwBkeyZb7wMqQ0cZ3q8+7VXgtHG/FsyQuFvGjW3HU+ewT/7x/vRjGjpZwJzRlewyFoIoi7EKFo11tLzCm5wCkne4uPmtgzW1xZ0QRt8DVk7nkDOiCuQgXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917410; c=relaxed/simple;
	bh=IRGt1tdTAkJpAn8rflo9ww6T6fVOdCehiU5wN4Hm66g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UsVsEpRY6OHf7J+T3LiEydZg6npJgokWfS08HrFlx5xrbB7nbh2EBCdaqqTQS8f+S2iA8rtDZDxd4ZTFUqbHTxfgh6v4UDuokJcSBHA0hKV/V/y3ihDyggSqvaBAaheskqSIOQ5hCvA3TqrjjbqifT1bvAnhdYe7qxUNhVUBKPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=fvq6rBZn; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="fvq6rBZn"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tqFNu6fdW2ZSKtqFPu1NpE; Wed, 03 Sep 2025 17:22:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1756916549; bh=/jC+G46Q10IUoi9m8b078vm8JuooJE/wf+kF+CH7f9M=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=fvq6rBZnwTk0TzJIj0FrcD9SsROhap/IvYh667jltq3Ikj9XW7xqRGsNIk7rbCIwW
	 tHcTP3eUlD05+tqvRLWSdH9UA1lV1IC4mgWdSFj4sK/qHHwt4C8cyoIk+vsUW8d7pf
	 xd/xmVratbN84mIsrW+3CXow21VVJWB3ilkWUnnxT6EoujUxWNKGYItSrHegSGuhku
	 3WeMThryH9bO1Yg/Ge+qL244r8BQNFyImWFfVamRIZx655gLwW/X84I9Z+n25Ch8Wo
	 yhmLI7m5rBBGdG4v8G2ByXTxyUJCQ5LS/Eqlg2HWOnUrMWaZjSxEUrqsFvrb/JXyff
	 yWNmlGN5gPoRQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FfaUx4+6 c=1 sm=1 tr=0 ts=68b86b45
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=eYNoJDMsgFRSVVq3f_oA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <febfce4f-a609-4802-be64-e72d95837c10@ramsayjones.plus.com>
Date: Wed, 3 Sep 2025 17:22:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
To: Patrick Steinhardt <ps@pks.im>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 rsbecker@nexbridge.com, 'Elijah Newren' <newren@gmail.com>,
 'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
 'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org,
 'Christian Brabandt' <cb@256bit.org>,
 'Phillip Wood' <phillip.wood123@gmail.com>,
 'Eli Schwartz' <eschwartz@gentoo.org>,
 "'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>,
 'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
 =?UTF-8?Q?=27Matthias_A=C3=9Fhauer=27?= <mha1993@live.de>,
 'Sam James' <sam@gentoo.org>, 'Collin Funk' <collin.funk1@gmail.com>,
 'Mike Hommey' <mh@glandium.org>,
 'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,
 "'D. Ben Knoble'" <ben.knoble@gmail.com>,
 'Ezekiel Newren' <ezekielnewren@gmail.com>,
 'Josh Steadmon' <steadmon@google.com>, 'Calvin Wan' <calvinwan@google.com>
References: <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
 <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
 <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local> <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net> <aLfU5sEa-RE3X4G2@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <aLfU5sEa-RE3X4G2@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBwzSR1o6Z64RtEN3a/gA51G9QLXtMH44tbm4fKWrBYKJpDfTkLcXgqLIxTkw7Ndh4uixD0WFyoqKxfyoYJ1wYgArD9U+c9XmKI5Cqufj+lg/xLlMgnu
 wV2vPpLctvpP2NZ4ufueJ4wUbUVuLLqnLXNWtz/uhRINvSZ3XbW2fdCjtdW8kqXGkRNAMFhyUuD3WUrQpt57Eq3YtAgiJVg0n9o=



On 03/09/2025 06:40, Patrick Steinhardt wrote:
> On Tue, Sep 02, 2025 at 05:27:10PM +0000, brian m. carlson wrote:
>> On 2025-09-02 at 11:16:19, Patrick Steinhardt wrote:
[snip]

>> I'd prefer we not wait that long.  I'm doing some work in building the
>> new loose object mapping using Rust and it's much more efficient than
>> writing it in C because we don't have to sort the data when we use a
>> BTreeMap.  The code is much simpler, shorter, and easier to write.
> 
> I still think we need to be mindful around the community though. I
> understand that we want to have Rust in the codebase, and as I said I'm
> in favor of adopting it. But we also have a certain responsibility with
> Git given that it's used by almost every single developer out there.
> 
> A compromise could be to ease into Rust: we adopt Rust, but before Git
> 3.0 it is entirely optional. So Git will continue to work alright even
> if there is no Rust compiler available. On the one hand this plays
> nicely with platforms that do not have Rust. On the other hand it also
> allows us to slowly iterate on the build infra for Rust, because I'm
> very sure that there's going to be issues there initially.
> 
> With that we can:
> 
>   - Build confidence in our Rust tooling.
> 
>   - Figure out things as we go.
> 
>   - Give distributions and other platforms enough time to prepare for
>     Rust becoming mandatory.
> 
> I think adopting Rust as a mandatory dependency out of nowhere would not
> be playing nice. It may require significant effort from distros to adapt
> to the new reality, so we should give them time to do so.

I agree with everything you say above. Thank you for saying it. ;)

It is somewhat unfortunate that 'xdiff' was chosen as an initial
project for this, since a git without the ability to produce a diff
is, well, practically useless!

[I don't have any objection to making the rust code optional in this
case - it should be easily possible to have both C and rust xdiff code].

I have already stopped building git on cygwin, since rust is not
currently available on cygwin (and I'm not aware of any effort to
port it there - although LLVM v20+ was recently made available).

ATB,
Ramsay Jones



