Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6217C2
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731544062; cv=none; b=M5wBcoIGKex/FPd+9s7IqewxKdu8Z85ZmFaDnGRjzhyQZ9gah/3Yev1EIJ5jfIq5ffQIzP13BvIbU6fzfUQz+nMvkgSBxeOcuAM3ZI02sibpfUdldT5WwqMzAZ9e0W7/bTwapciGvD6nBmMYow+TigsTPnTldP7raA9Kcw4PlR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731544062; c=relaxed/simple;
	bh=TWqo+hyu9ciZWINzE+Qpl8eR3cZ1bhy805Evq6m9jME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7QfreACQMlPfGpmAFsdbUJA6ds8tl7x7/O1+Brpz3i/MOwwlPQgGR8rhSp0lENMFxTsZrFwGKo8DNerVX58mAqwTZi5UBNA0Mc5NX0Ujso0eAUmnfm6tKkBEhE8uk3kXAtV6fOAkg5u/Cs/BdsrK+lh+ZXxo/PY6anwrSzqJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mayhew.name; spf=none smtp.mailfrom=mayhew.name; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YQvvzTLW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mayhew.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mayhew.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YQvvzTLW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 30B0711401D4;
	Wed, 13 Nov 2024 19:27:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 13 Nov 2024 19:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731544059; x=
	1731630459; bh=WWzymM0l0G6aIoIznsa9UTJCPuvtSl3/huarBYIWRdI=; b=Y
	QvvzTLWTekDFU2rYdkNvyIA1pTeb+W6oE/NB4iiK6AGrgybRb5JSG3SUpLMt+jrh
	otLCrv+3zr68RQYdK2NsFvmE8oq5Dne6eaHgdmSXDd1D2ESkDZa+XHRGTdGQy0/T
	kllAfgIwAOJk99r9UM6JSBzgYjMwjvESSiVJVi6C/yeFRaQNBebx7HVy75q2bcdU
	eNpAbtzALuT7EhwfveaWEzCzlLTWqTmS0gvefzXyMa+xJ4684R8EvADE5J+wnepq
	gnaa5FuCZoxaEYQ8TnfS7rhAOC9HxwsahvZodR17uECVIJ5OOv3S3TYnF8D3kQex
	RshcKEoLhOfmbdhhEhZwA==
X-ME-Sender: <xms:-kM1Z5f5lJxZe9-0hV59iQhBvsFBloVOwXOQyIbPLs1KeorW2mpMQA>
    <xme:-kM1Z3ML1tSzesii26DiK9VXwHJl8orU0OFOCMjmvS3hkRXLXcjAGJsq-xlCN1lLs
    i40JDlZpV-CDEPNfX0>
X-ME-Received: <xmr:-kM1ZyiK0Cwp8CaicduoqQZLlWWyGrc1B7JhOvjd9iHUzSVRCUYq0JN9pXIka62p1j2rKM2wY8dmdMO5_PsvjALN7K7x0wn6gGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomheppfgvihhlucforgihhhgvficuoehnvghilhesmhgrhihhvgifrdhnrghmvg
    eqnecuggftrfgrthhtvghrnhepgefggfdtveetudekjedvudegjefhheeihffffffgtdfh
    udfgfeekkeefgfevleffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepnhgvihhlsehmrgihhhgvfidrnhgrmhgvpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhguhigvsehgihhthhhusgdrtghomh
X-ME-Proxy: <xmx:-kM1Zy8vrsIzcctR66YzUpLwW6fj6LzzeU_t-f-vuzfWRbEwTQ_D-A>
    <xmx:-kM1Z1sVJuBxxei115Ni6KsepFcuPwTfkCA_RGYhEqJ2SfjAtkZ-Zw>
    <xmx:-kM1ZxF2McJmtCji19Gqla2ogXVuF9GHXWjfcJknuaF9JlWX58kVKw>
    <xmx:-kM1Z8McbCdUPLBxt9PFcEss6-q7zz3oBn_8Edh2QKOhGv-wjvvhOg>
    <xmx:-0M1Z_Jg7dSH46tbfN171voss5o9t3etVigABzhYWUc2QEz1hjAIQwgN>
Feedback-ID: ibb8947ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:27:38 -0500 (EST)
Message-ID: <e039fc2b-ba2b-4845-9a2e-58edcc003d87@mayhew.name>
Date: Wed, 13 Nov 2024 17:27:36 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Strengthen fsck checks for submodule URLs
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Victoria Dye <vdye@github.com>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <20240110102338.GA16674@coredump.intra.peff.net>
 <d9f53fe7-6570-4aea-894c-942e12e012c4@mayhew.name>
 <xmqq5xoqahbx.fsf@gitster.g>
From: Neil Mayhew <neil@mayhew.name>
Content-Language: en-GB
Autocrypt: addr=neil@mayhew.name;
 keydata= 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
In-Reply-To: <xmqq5xoqahbx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13 Nov 24 15:40, Junio C Hamano wrote:

 > Neil Mayhew <neil@mayhew.name> writes:
 >
 >> ... immediately corrected by another commit. However, the bad commit is
 >> still in the history. It happened 6 years ago, so there's no
 >> possibility of us changing the history.
 >
 > I think fsck.skipList was meant to cover such a case.  The idea is
 > that the blob object name of the bad .gitmodules file can be placed
 > on the list, and the rest of the "bad commit" and the whole history
 > can still be checked for consistency, without triggering the warning
 > (or error) resulting from the offending .gitmodules file.

Thank you. This explanation is very helpful. I hadn't noticed the 
existence of this config option, and using it does indeed enable fsck to 
pass on our repo.

 >> Is there any possibility of "loosening the fsck.gitmodulesUrl
 >> severity", as Jeff suggested?
 >
 > Isn't the suggestion not about butchering the rest of the world but
 > by locally configuring fsck.gitmodulesUrl down from error to
 > warning?

Again, thank you for the helpful explanation. I hadn't fully understood 
what was being suggested.

 > I personally think excluding a single known-offending blob
 > without doing such loosening is a much better idea in that it
 > prevents *new* offending instances from getting into the repository,
 > while allowing an existing benign and honest mistake to stay in your
 > history.  Loosening the severity of a class of check means you will
 > accept *new* offending instances, which may very well be malicious,
 > unlike the existing benign one you know about.

I agree that skipping a single object is better than loosening.

However, there is a bit of a catch-22 situation here. The problem in our 
repo was reported to us by someone who was unable to clone, because they 
have transfer.fsckObjects set globally (and initially didn't realise 
that was where the error message was coming from). Someone in that 
situation could in addition set fetch.fsck.gitmodulesUrl=warn globally, 
but as you say that's too all-encompassing and it would be better to 
skip the specific object. Unfortunately, this is difficult to do when 
cloning, because the configuration value doesn't come automatically with 
the repo. A local skiplist configuration value can't exist until after 
the repo has been cloned, and adding the object name to a global 
skiplist doesn't seem appropriate. It's possible to add the option to 
the clone command line (with -c) but that's starting to get quite messy 
and in any case many people wouldn't see the instruction even if we put 
it in our README.

I don't think there's a perfect solution here. It seems like the best we 
can do is to put the object name in a .git-fsck-skiplist file at the top 
level of the repo, and add a section at the end of the README telling 
people to configure it for all three *fsck.skipList values if they want 
to use git fsck explicitly, or implicitly via other configuration 
values. We would also need to mention using -c when cloning initially. 
This information will probably be intimidating for most people, and I 
wish we didn't have to include it, but hopefully we can make it clear 
that most people won't need it.
