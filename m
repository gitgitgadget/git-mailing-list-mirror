Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D741D23B
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693583; cv=none; b=V028sY/xC/SSyrARq3BeIGXMGqLyUhEoUw4n7EhiKOYZN/AXp6YNQMh6MGQuAExVCGL39rYVYODkD5sKjhDYs0e5MNfEt4rlj4yh41Tw8EIMHFzcFFoZYMjlNsg15yxgqWxV49Zv/7sScN2SFZRuAWiIwOjyRgzYDA3EG5LPvko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693583; c=relaxed/simple;
	bh=BRnltEBhFu1gtvMG/He5GW+D3CPA1u4U55d+wFpYuA0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BHZqDQLMEfjcvUNDMIULZvgR8TPAn6h8/ILicsdxSb1GjKZ02d5hsX0KULhkKRQdqUF2fcBR6XYUiYMr1DRBdY8TMbB9kxF5yL0JreRG/AB+1TpF/8MpwQmx9peKRxlcGQk26OFuIrh7FRsZ9wq7diYw+9LgR6KVDWyay/Uz6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Fu6JMP2T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TYtugvQ5; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Fu6JMP2T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TYtugvQ5"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 71B411D002E6;
	Fri, 14 Aug 2026 03:46:14 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 14 Aug 2026 03:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786693573;
	 x=1786779973; bh=Z8ExsTiniYL1u5P2PPF8zlANSkb/UT+2P7830Qxb8y8=; b=
	Fu6JMP2TsZ6yu0+gB0FBH3+8WFckODqmdFw1J7RwkrfiReMe8KevUKq8hY39OP0p
	D4oTNLMojdubJ7JPJXrm+nafkqZadCLVmWOYIl4kZB+47+aILrMCvISK41uiTg06
	Jwc0und9c2r9ndJYDQ/egbpEvMjQAVMYNSJRUDz0PnMUByJ66h8SlSxr2IEgoZS1
	GpRkMr2fMEpRUZW/FLVMpCZKNLx70+cfGMDbfyCAbhzfN0arZKzCf/QPcJTNA86G
	/3BfVqus8bx4l/dXZwV3n3bG1F49cnXGs0NZBLJw/854cQulEyXnTYLv5/QgUNNW
	7bWqWvh9L7yI0ed5rEzYPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786693573; x=
	1786779973; bh=Z8ExsTiniYL1u5P2PPF8zlANSkb/UT+2P7830Qxb8y8=; b=T
	YtugvQ5q5gJ8eg2Ngm+Qbz4ONLTrK7EQlGX1MscjfEAn7lWlj+HN8BjFN5oBZ8XB
	6GYW0rO/+HB3SDIGzOno5uSNW98mDhzik3f44g5xdTys1ylfVov12cmDC/cmi8ei
	W/jV4Oo2CNH0RdGHdOLy70+VzrNqARdbTrfmTU0J4nLDYpDyfkosxuu01Ynkj7Xf
	UAAF66uyAORvxFEe/T4bXuuEwcqT8vsOdCRpK6k4HUr27hoirz6m32FHZp2A5EkO
	tOg894oYJIREqSEbk5B951axMYibrJ7xSxpb7a8JbkjLxKLFVSydgBhWaqtTOQMx
	Pdell1EvBCIhyeD5r5pTA==
X-ME-Sender: <xms:wcd-apcgD3oFgyFey0cul8dXqI13xKg89NBR7vhUynBi0-la1wG1Fb0>
    <xme:wcd-aiBee2jP3m_RUdBHSpu3MSSMLTPL-RHMf7wRzr-Xyd2exN8XVcEaIoz3Mlx_h
    oddok9zOeMH2VmlWb1dGFxUcAcYxuuxCOEFNvHbrsYETicPUZeehQ>
X-ME-Proxy-Cause: dmFkZTFGZllbr40L9eXyKi7LLyLeS32OIlXbUEr9edFGMMf8KWTzSQ6/RLiTY8wI6VKZkV
    ZjJvLZ5Ceaaj/dBQHhguGLDdWnz/J7RSptIfDlXFiCnOEskSo6/Zcq90uOCgIxdDNNre3t
    e+gSyfLK8S4UQ0K0EId6V3dXFrXrU12pYlF80INg72Y41nah+doHvD+mmsp1VI5qOVNcAW
    wKMjTzbCJNX67LU2lnRqUpuYqcAN6a4kyeO1U/rxDQMN6L6yjLFDBWuWl1uthGiODhCpMb
    6+NKRhpe2dxJ2e/J4PwijgEOKbZ7QUnAkppXtTj6rz0LQ2M2OGwtHBZkKGwiyXXDRwr6aw
    QFypM/or1Uqs0tQXl3E/K9F9rPQesf9ADapx9iBnELNYgl+JrPAvOX+xwOkdX+5g+WpRlN
    CG1QW0Snulb/DV+1a863kRWBISPNkdiVROhwKCEMDQtosGLDJglvksOH8WfK3LK6s+GEbB
    OzX511EnudmB8dGqWDrshiosV9MC3c3rL9TLVYZGCLhyJPrfGrG6WJWLM7pVd8i1uw5KZD
    mY6/z29Myd+vnInZQ8YjualpWe/R89HQZNGNA7XDf0srIBvjNGe33bFEjo2153gfpFKi1u
    zDap5pb+f7UohqZb0eHxvAJvhPsV9K2PP6KHGHqYJ4vFGOjsw3xkvXrsSqJA
X-ME-Proxy: <xmx:w8d-asBjLk8LWyliqYA-mI9tHI6GPBADG1RqOTvzXqUViWW1ReorBQ>
    <xmx:w8d-agAjAF-OzYKFP_Gc8Qr59wDWqNr1CuRRDvN4fdopEYfE5LpOQg>
    <xmx:w8d-avqjlgsCFEzsHKkbnu99D0XNso_XSXvnrpxMM7M4Qb9guVbIuA>
    <xmx:w8d-ainH6kBJSFLr9PLAVWFsVl2FG_b3RK-h9705HRORd5YZwpL6hA>
    <xmx:xcd-ap0rifR9mhwAgHO3X6A-5vSUei-JXg3OVF4qdUHAAi-LBanenxwz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id ABE2822C0078; Fri, 14 Aug 2026 03:46:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzsVqDuXP2Wg
Date: Fri, 14 Aug 2026 09:45:49 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Patrick Steinhardt" <ps@pks.im>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <ef8ee6fb-ef3d-4a83-b8fc-121448d58e53@app.fastmail.com>
In-Reply-To: <xmqqfr0hqzvl.fsf@gitster.g>
References: <synopsis_block.af9@msgid.xyz>
 <V3_CV_synopsis_block.b64@msgid.xyz> <V3_synopsis_block.b66@msgid.xyz>
 <xmqqfr0hqzvl.fsf@gitster.g>
Subject: Re: [PATCH v3 2/2] doc: format-rev: use [synopsis] on code block
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026, at 03:01, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> This code block uses the placeholder `<subject>`. Let=E2=80=99s highl=
ight this
>> placeholder properly by using the `synopsis` block definition which w=
as
>> introduced in a34d1d53 (doc: convert git-show to synopsis style,
>> 2026-02-06).
>>
>> Yes, note that code blocks since commit a34d1d53 can, on synopsis-sty=
le
>> docs like this one, be immediately preceded by `[synopsis]`, just like
>> the command synopsis is:
>>
>>     [synopsis]
>>     (EXPERIMENTAL!) git format-rev - [...]
>>
>> Cf. verse-style:
>>
>>     [verse]
>>     'git name-rev' [...]
>>
>> Acked-by: Patrick Steinhardt <ps@pks.im>
>> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>> ---
>
> Has this been tested with both AsciiDoc and AsciiDoctor?
>
>
> https://github.com/git/git/actions/runs/31751206776/job/94617158587#st=
ep:4:4886
>
> Curiously, it does not fail for me locally (by default my builds use
> AsciiDoctor).

Nope. :/

My change uses a code block:

    [synopsis]
    ----
    ...
    ----

But the ones in `pretty-formats.adoc` use open blocks:

    [synopsis]
    --
    ...
    --

I=E2=80=99ll do some better testing next.
