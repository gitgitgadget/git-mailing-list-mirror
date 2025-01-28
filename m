Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD5F1DE8A5
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738088778; cv=none; b=dy1L7ltRPy45PyItd5tjGbk3mbFNunhRi009GUXWQba2Qr8rzjFMntvGrBkel7fRJIJ7pTYuC/Oi2jUKpaAZSgvPvuISMjbq3DNTYmh5ar7+Z0wj7ZxzNIilCxnR09fRs4wztbejBHcbNWRN2BdYx7yAUafYnLGRaFV/7cNG1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738088778; c=relaxed/simple;
	bh=yUZg751eqpPeZIiRtLuu26vmwAbAemI1IC5vOVr/Pvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KElzew4rY7H5qr1oX1GchYbkr7NWh5p15DeWtaiPXlVL8nePqH0ICi65P47oNAR6aMOZPLqYJfO9C/1KZP5moSGov2DYEnHyu8iFEhSmYaQP2ksJAABNSeJa6Q89/0wM3aLUVLFYTySXWGTVB1Xd2awCOlhHw2hcnO51p3sCogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CBqhEuOw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=foXVjaqZ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CBqhEuOw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="foXVjaqZ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 70DF51380C70;
	Tue, 28 Jan 2025 13:26:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 28 Jan 2025 13:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738088774; x=1738175174; bh=mvTdcnr3zk
	jynDZd2xOWW0zdlUO7WKORnb9PcZeC3Oc=; b=CBqhEuOw26Uj88in+lJBQMB1I2
	Jfiw8mYz4IrC7Ef4PWJpVJ/noymrvExMx10ahzKFBXwNEe7DnQoKn0yPLx/hcOAR
	0TeyIuvD5HMODhBZaEe7JrAIi0mf8Lv0cwNqR3o0YxKpqc5Y1vhw0lH0DOObCi+v
	w6pmzXt6N9SCmVub9Gup905rjA7yO0DCN/yM+zym58Q4TheLqfcRq11HljfJB3yE
	Z2kLCEi4bi+s4TU91tqXI64FL+6xMMPsayV0BrHVm3XPPnko7l16K54gMW2fvizE
	5SWl7+BE9V1+fOPDTnTMXRz5JPAptyQUUSIMAYT8xnATxeVCCfKfvMemUgnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738088774; x=1738175174; bh=mvTdcnr3zkjynDZd2xOWW0zdlUO7WKORnb9
	PcZeC3Oc=; b=foXVjaqZTuhpe8NdcEDyDG5mAUJml1Eu+BpXC1Dbjx5zGrGMuLX
	ifrkQVV2pH/gOpAKlWknUtPLYjbnp2XYL32Ap0RbVIsy5NpzYgcV7R68b1nIE2PX
	qHcdcAy6faHCGwQPKvpq/AsG6Zz7SFzSZ4tbSvnZvk5ZM+RPORGjaJgTLXN5rtPQ
	Sdzwg7LcUujJ3FEpNTZpSv/OXc4Vuurb5LiSRufh8gcNrn4zwDhVjJl4iPeRCVb5
	i+DT85stfuMtNP22BBBhO2Yqqwc0PqQVJ8NKGWkHc8vY16rlSxfTnORcnqht6Y/f
	FLRWuNM/O7eqjUUU9GwC4ZEaRbAgyGMy9Iw==
X-ME-Sender: <xms:RiGZZ_I1w9oF2eFyaVKXJYIWxWMpPM776tn1M-0nQwSh0o-PYjvlmw>
    <xme:RiGZZzKAo2ba9AGN4wXharyFsLbd3jZTaz6QNq9wTGig74seFSPMvkdxFB8nalDnr
    mTjCudk9ffT4RE7jQ>
X-ME-Received: <xmr:RiGZZ3vZQhqNrOpf1J5L5CfVybAyt-0TDgsz4O51qvf_bevfaV3N2Gl1NMStE3l8O_kPHJ_ohNT4NwHK2hNpgcXurlDxUIiGvwLX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:RiGZZ4aHIqp3WCLQh68tyghMWND_oV6GvIqRV_UK1pWv-TS_hWjq0A>
    <xmx:RiGZZ2bcQdZTZvncUX3jkafF0bIIiSmk8ZtNMEfnqydJfmiqFsseaQ>
    <xmx:RiGZZ8AX_YiYOT8G5cyZYck7WlYDj2_--N-1SE7gUdb8mooT3Q83Rg>
    <xmx:RiGZZ0Yut44OZBVSpSbUfntHI-MS7flW0KAwi1dyPxAnkcZeXlyGQg>
    <xmx:RiGZZ9X_aap6y49JLyVW7mCuhtLayik2AfGxbZH5pzD7LX4Ailk1mZbb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 13:26:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #07; Fri, 24)
In-Reply-To: <xmqq8qquom4t.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	28 Jan 2025 09:59:14 -0800")
References: <xmqqwmekvubv.fsf@gitster.g>
	<20250128164606.GA1688180@coredump.intra.peff.net>
	<xmqq8qquom4t.fsf@gitster.g>
Date: Tue, 28 Jan 2025 10:26:12 -0800
Message-ID: <xmqq4j1iokvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I noticed CI complaining about a missing include file:
>>
>>   2025-01-28T15:51:45.3979314Z asciidoc: WARNING: difftool.adoc: line 16: include file not found: /home/runner/work/git/git/Documentation/mergetools-diff.txt
>>
>> The problem is that the line was introduced by another concurrent
>> branch, aj/difftool-config-doc-fix. So we can't fix it independently on
>> either branch; the line does not exist yet in brian's adoc branch, and
>> the file is still ".txt" in Adam's doc-fix branch.
>>
>> It has to be fixed in an evil merge of the two (or brian's rebased on
>> Adam's, which has since graduated to master).
>
> Thanks; I had this one on my radar and I thought there was a
> merge-fix I made somewhere, but it is likely to have been lost
> during shuffling the order of merges.  Will take a look again.
>
> Thanks.

Here is what I'd directly apply to 'next'.  The merge-fix mechanism
knows about the same change, so when I merge the bc/doc-adoc-not-txt
topic down to 'master', the same tweak will be made as an evil
merge.

Thanks.

--- >8 ---
Subject: [PATCH] Fix mismerge at 737049d332

The world order after merging the bc/doc-adoc-not-txt topic
is that there is no .txt files in Documentation/ hierarchy,
as everything should have been migrated to .adoc suffix.

There were a fiew topics that were simultaneously in flight
that got graduated earlier than the topic, hence needed an
evil merge to adjust.  This commit belatedly adjusts the merge
result to account for them.  The same merge-fix will be made
when the topic eventually graduates to 'master'.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/difftool.adoc                              | 2 +-
 .../technical/{api-path-walk.txt => api-path-walk.adoc}         | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/technical/{api-path-walk.txt => api-path-walk.adoc} (100%)

diff --git a/Documentation/config/difftool.adoc b/Documentation/config/difftool.adoc
index 6cd47331a9..4f7d40ce24 100644
--- a/Documentation/config/difftool.adoc
+++ b/Documentation/config/difftool.adoc
@@ -13,7 +13,7 @@ diff.guitool::
 	and requires that a corresponding difftool.<guitool>.cmd variable
 	is defined.
 
-include::{build_dir}/mergetools-diff.txt[]
+include::{build_dir}/mergetools-diff.adoc[]
 
 difftool.<tool>.cmd::
 	Specify the command to invoke the specified diff tool.
diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.adoc
similarity index 100%
rename from Documentation/technical/api-path-walk.txt
rename to Documentation/technical/api-path-walk.adoc
-- 
2.48.1-325-g31d6edeeb9

