Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72007200AE
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588700; cv=none; b=eb2/KPM9PxkNXbeOMpb05CJPHnV6cuLMyBHncqtqWJj33jgxg1rQKYfMV6p05TkBZ1/Bx4x+YCGctj1pOF+QpGeNf3kFi99Tv27Ay7T+qY+JvHHLM2hbmbbKHGmoRfhIAKzAieyhwbUnSzzmUqdHWAfUbaQgLzynQ5+8aGJnx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588700; c=relaxed/simple;
	bh=8WZIDk5PaUv/ZTFMJoyKKF1sntDtcVmcdCh2XF5XLCc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=MjYy/mN1WqiFlLYJtsCswqEBBukSlChF9Z/tzjVO/E2rjitp5BHrsgRiOYmpL6X0VbJnPaq+TpVaIqDMVIEtoP6dXbH9ySHGR9q0kYdoVQ1t/QtRjABBYAoPmGMYy0OgFoj+hMt6G6OMu3l1soSptfpuCpeWkny/QiZDcp3Nd+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=JnvBZeGh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mAQ0EuAO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="JnvBZeGh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mAQ0EuAO"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6AEF3138023D;
	Fri, 28 Jun 2024 11:31:37 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 28 Jun 2024 11:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1719588697; x=1719675097; bh=d/Z3miZDJT/qjnXXTA8mdtgFIml8oyVj
	id2q/eh+iCk=; b=JnvBZeGhTa2hcxbMwTntTOq5PeQjotvAF1NVsurbImYg1cTe
	Yb9FT7bixQ5PudQ/yKgR7EbnQptXLZmad6cgcfGTmlmQVkftaDL+Lj8mDaVtknGC
	InPiLuEtkelcRnr6AJwhvnwgwNlR+DBjWya0bQMksQ+DIJTyRZMP1cqcMFiwMGfw
	04hLj8N4/0lZVaVA3mYZnRDwgO8nfAvaALjkUNJgBt1QIO6FvZTBto6W/A15MujV
	Hl2iBU3snAJmYBTrB4neKs4XAo8XEZefitHRprgTTN3aXL55nt7rufks3nzsleV/
	yo8em06LR/e0kfxzQJNG2g4Fdjiz46W84FVRTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719588697; x=
	1719675097; bh=d/Z3miZDJT/qjnXXTA8mdtgFIml8oyVjid2q/eh+iCk=; b=m
	AQ0EuAOQig4QtKRPnou2X//KdBNL70Plf4UCzA+Jz0a89UU7yCw61MVOOrUYwR+t
	YrxH/OtEBd9WAzcmXZaRTxPhGmfElIvNS7pjLeOnGB9w6eXJZm7u8+yj9UxXYgZR
	gZPyVwnIob0c/URU/MbqtfNKsA/qEg8DhseV73CCbcr9sEt3QZo1rbSOSQ+lmFoh
	Vh+UxAhx4VHStHT1DzfI86N+FN82wrCS2HogXgiyknjQ/omE/SMRIvrFirqfvi6I
	d2cSZK9unJ419LqYE8hWqLz3nZkuirrk10l0WIzx04ueykgaEsxQwWFDemY8zMz2
	GlvWEJSXxVnr5Fa3Q0mVQ==
X-ME-Sender: <xms:WNd-Zh69o_4ctNauc0CiCY3w3j7sLXNNdvJegf6z0_zT_Mt6PIBmRJU>
    <xme:WNd-Zu6VPisOpbZ57by252Su07WZIPHmOqV4k__0vHmbsallK6PP1ifiJLK6BdTVR
    c7kvg1bXkPI57fwpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdejgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepjeetvdelleegfeefhfeuffevffeiudeh
    leeiieevhfeguedugedttdeitddvfeevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    dpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:WNd-ZocCIjd2b5lCnB-htpg6IU2eFOEySwUUTUnF6MQLscXYYby5Ug>
    <xmx:WNd-ZqLJF7NM8f3WQGUU-iuYZITmRGxjFQd9-JgJvW-3UoEUQqUnFg>
    <xmx:WNd-ZlIq5DndEWNpC6OMbHJsTXlWgL7_WeXwubEFJ9qeIaos4aakgQ>
    <xmx:WNd-ZjxNqkSOpOjh2zdAR7Cvfp9pOI1n6BacLSQLHupPY03XWQ1lbQ>
    <xmx:Wdd-ZuWWGuPnhQxRDCtlXsppCLQWnkbiE4gJNpABJIkQ8h0hg4u2lzvc>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B3A3C15A0092; Fri, 28 Jun 2024 11:31:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f6abd59c-ea86-423f-9172-79779932418b@app.fastmail.com>
In-Reply-To: <xmqqed99k7xo.fsf@gitster.g>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
 <011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
 <xmqq34pqlyou.fsf@gitster.g> <F64F4F3A-EF82-4281-8A75-0DDC8FA65D4B@gmail.com>
 <xmqqed99k7xo.fsf@gitster.g>
Date: Fri, 28 Jun 2024 17:30:08 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Phillip Wood" <phillip.wood123@gmail.com>, "Jeff King" <peff@peff.net>,
 "Patrick Steinhardt" <ps@pks.im>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>,
 "John Cai" <johncai86@gmail.com>, "Aryan Gupta" <garyan447@gmail.com>,
 "Linus Arver" <linusa@google.com>
Subject: Re: [PATCH 1/4] refs: add referent parameter to refs_resolve_ref_unsafe
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024, at 00:44, Junio C Hamano wrote:
> I found the previous occurrences of the same problem:
>
>   https://lore.kernel.org/git/xmqqjzm3qumx.fsf@gitster.g/
>   https://lore.kernel.org/git/xmqqh6hkxox6.fsf@gitster.g/
>
> The last message in the thread
>
>
> https://lore.kernel.org/git/CAMbn=3DB7J4ODf9ybJQpL1bZZ7qdWSDGaLEyTmVv+=
ZBiSeC9T+yw@mail.gmail.com/
>
> says that the original user of GGG found what was wrong in the way
> the user was using GGG to send and fixed it, but unfortunately we
> didn't hear exactly *what* the breakage was and *how* it was fixed.
>
> Aryan, do you remember what the problem was and more importantly
> what the fix was?
>
> Thanks.

Yes, Aryan didn=E2=80=99t explain what the issue was. But Linus Arver (+=
CC) in
that first thread/link figured out what was happening in his case:[1]

> I realize now that it's because I copy/pasted the "Cc: ..." lines in t=
he PR
> description from
> https://github.com/gitgitgadget/git/pull/1632#issue-2068188239, such
> that when I pasted those in for the PR description for this series at
> https://github.com/gitgitgadget/git/pull/1694#issue-2187804953, it
> carried over the email addresses as Markdown-formatted hyperlinks.
> Currently it reads
>
>    Cc: Christian Couder [chriscool@tuxfamily.org](mailto:chriscool@tux=
family.org)
>    Cc: Junio C Hamano [gitster@pobox.com](mailto:gitster@pobox.com)
>    Cc: Emily Shaffer [nasamuffin@google.com](mailto:nasamuffin@google.=
com)
>    cc: Josh Steadmon [steadmon@google.com](mailto:steadmon@google.com)
>    cc: Randall S. Becker [rsbecker@nexbridge.com](mailto:rsbecker@nexb=
ridge.com)
>    cc: Christian Couder [christian.couder@gmail.com](mailto:christian.=
couder@gmail.com)
>    cc: "Kristoffer Haugsbakk" [code@khaugsbakk.name](mailto:code@khaug=
sbakk.name)
>    cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
>
> when I click on "edit", where the last line must be from your manual
> fix which GGG picked up. I've cleaned up the PR description manually
> now, and for this message I'm also attempting to clean up those square
> brackets.

When I read that I assumed that Aryan had made the same mistake.

=F0=9F=94=97 1: https://lore.kernel.org/git/owly4jd741ph.fsf@fine.c.goog=
lers.com/

--=20
Kristoffer Haugsbakk

