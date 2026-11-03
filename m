Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736855;
	b=pjirFcM7vKzT1jqxNwcPIIdNFxz9G1NpKzqFoO6sc9EEgZZu5zIrz80SSya+SoT9Kwhj
	 NDMvLXULa7ZdsYJ3KvY8rtqzrqFKrnglvuhnkZjiLyjYuueSGCcZVPkHvxJmJpogve1cC
	 eXCtR3WOYTFBWM9/S+LL9XlHLuyO7kkmuB+fCgMYa2TixzBCmAMLS8MeHspZlc0qeeBb9
	 mloFxBdf3mWlJxu/Dfl8jDj8OL41iD9Lp5yU4Ru+wg8Dan2xKHhezeV+usN3+ilWib0Z8
	 jFyGmeqJI8TdHs6XjVWS8DokZp8sR3/4UQ6dJmEfWTfkqMWrMbLAYkd/ffQ6zwxx71Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736855;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=qnTqUj3HnVtJDzsOslVpGQUzTW2R5NY+INSdF4SZQY0=;
	b=CUNxSzR9rIGmuoJOzCw1Eac1+Atn7VM10KfGGeD/OQWhmHryCRDeF2W/ltydwzg0FF34
	 z/gT0DzbCyRZeToLm51GhQ9fPlKmYc1DWSx9TbPPXVnnh9iXCa8t21yabXkodVQy5bb3h
	 KcFo/nrzqBc9IiRmh0qQeYFeqV2ri5xwYkzQWefux5TolSj9PrskpN3CvUcLRsUKCzSij
	 66KrtsXUu++ibHM2utZPELEcATdR8lIgheI6h2IPEgOOfijHzTJ6ELi8w+TF1tdv6PrkL
	 ttMznXQUofJ+VcWGz6H+Qs20IJx+cJKFGEhRdxNd8RORTrGGQG2+A8hv6jgON7w06TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=ajjYBTej;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=y8Jyg1kG;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5A606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 20:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8A5A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=ajjYBTej;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=y8Jyg1kG
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD3271400068
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 15:14:13 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 03 Nov 2026 15:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793736853;
	 x=1793823253; bh=qnTqUj3HnVtJDzsOslVpGQUzTW2R5NY+INSdF4SZQY0=; b=
	ajjYBTej2K93SIEQxTRTDIA9aJDP2MilbIHVoxtMi44xyC1tKYMcqkZslqB3mjC0
	xcpMZDNl7sZ8/bAKYPJyxbUwQyZGtxYhqvuGiAdiZduY+q+umIVT8xsyTy9+88qj
	jLSz+/ewjBYIk2WIBvE/Uf55G+fNNWDcWQnvnE5FwIcYRoSfv79OJJnkywlThVIr
	sO02JHRBifaGJCxMidCOht5MVT6hIqljf0JBIH0Cy6sB6+wxruiJ1inIkopuCOYB
	SqOK5KBmPDcnMug/+zL63Ip5l9GwFUrV7FzusNV4ufb9RP1geFRMZjkKU05wqo4A
	d/r9MN6IOf4ttvEXmHSb9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1793736853; x=1793823253; bh=q
	nTqUj3HnVtJDzsOslVpGQUzTW2R5NY+INSdF4SZQY0=; b=y8Jyg1kGVnz5Aq+rk
	c8489+wC8xAYU/IadTGH/IZ8KV5c5qd4okaxT46ckYXjOdZMCS5uJX63lK0VkbMZ
	p50QdV1F01PsPjCzQX8zVunrtVLbB+ecKJJWnJUy52hJEA/QT7A2oD2qtFBlrt1/
	Xwpy0YJpuMiq+I0BvrivEq3M0af96ULuZWyktrtMQe1dS5W2xfqRU0OztA6SRfu6
	08enVm4gkgFS5pJVUUZh3PiSwbahdBwdfMyB9stJfYJDXB8+1M3wYf+HTO7MiJaL
	pCSDh0r1NspwmqGOlEx9pur5zvJilpRlHW64jIYh4k7WLJQUwFiZOc14MocMPpaM
	BUckw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793736853; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:B/x5cKGli39X8C3JwrzmFSTiY2NZ2tOtFrHgMqD3Vc2pzg4
	FNpfpqtFFjhJkXNcFEt5lT8y+S4v8U+P4ckrDx9ufFQ+qGaPcrGKTxyMGtkm194a
	zQGRsF7G0H5jaUrFNpXkrwda/qMS3bYgB3H7RHOY+qxzrcSCkFafM1FsC7FkG+7c
	ikJ6wQmCDlgLC6S394ZFDl3FYUzLbjAJG1J0so8wmfVZBOZVq1eVLpH89a0FC7/p
	R9qx6Khr8fTX27HnV4JT5BOBOGS3OtnJbNEkVbMVEtzNxwgFCY3Kfust34zd3j16
	Izek+Lju++/fTtdwXHT/SlolfHd5lrIwNLfUNpQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:c9PnOMGTtEEx6csreG+idvX6oQ0Eviopa0drXlX14jc=:1YNo0YGfbgp5fN6PeA4cUD2T2k31uPy341hM58w8GBA=;
X-ME-Sender: <xms:lEDqah-OgPbLIPTaRbQA-T5YDVFLGbP8UWm-u8T-WtvVoMidZs8iZDo>
    <xme:lEDqaggxjzacvmvjeBRP87_RZ7LdvU3caBk-UZ8t-GIHV7sGlWLtdeYUSnb5X1ONG
    am2Tzabeertuk0fKIGFjQcutYOR9YyIwQJcLaidmGqqriW9n3KWb28>
X-ME-Proxy-Cause: dmFkZTFAeoEyF5lhl/5o//GFy+imKtSex/G1KPyXpDSlV5WkFHDqarxQqVsXY4w069fuW2
    FLufEGexb2qlvUvXaLZL+78DiiU9VxzUlEWtwk/cRACTv0xbw7DEdHzz7HJDwGgeiJnA9k
    MRv1Q1o5MnEDOXVbiUmdlQDH0AMYkOGA1cpGu0slseE5RwTeV85cpsLSTUdUKtVYgIpuEZ
    nCC3skOX6EF5Pq7mAfVlrCZwM/rbdw0AbNobKuSG5z4hFeteC+CqCUuU9RkWLFJKg4p8zK
    wvYGs50KUpL6B/v+OW8x/3y45tXf7bQV0Brvcth3K38SF563r97q/e0vzw3TQUVUoOFLph
    5UYlmNZm1pVglZ0GDUb7DuccYkmDKAxfSc5Kf5DfxGKdnD0GYJus2rfGon3tKL1OFtqfbl
    vMFM0/xCgg+3KBSKhNdAjXpAEAbuVmuIU6qD5BObljmZfpXPaQq2IEj07ISUDNKeYP99N1
    YjD2NKeECuHjZPD+qSp6/pgb28nGgAw8BPQGWCCVb344+w4ocIIsCXKCc64Y2qnNPuA3Tx
    Izffnj+3My7e9R5H38lujxVNXhc8GHr5PqJwwcxzEyto9+Yv95gyDY9iYI4ECGINo3GKj6
    36JN3DTXDLgW2ghwNqlVhsfk43/ngCeQ6gt2dFTC+hQv62DnryWAfjbrEIBQ
X-ME-Proxy: <xmx:lEDqamthAslCJdqQWZqo4pXBExNRmC0u0C_V9MMkH18LYtBOQ7oqXg>
    <xmx:lEDqarYdo7rIUQrKi8z48PAyQpRZcwMoX1oJJVUPxwKPLJ3jUUAO0w>
    <xmx:lEDqauofEt3UsSy65fYW4Yr94bVVQGTod04zpWfkiFLGu78oqRUz2g>
    <xmx:lEDqao-_xoI_OBFCej5EFT-aNb-pty-1Vvrkmh8IEwkpGp9E5bqMrw>
    <xmx:lUDqalAUZ1E-gl3442cLyX_wG_mUteHuh7hh_rBXIoek0WXQZGMdqSfK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 266F922C009D; Tue,  3 Nov 2026 15:14:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 21:13:37 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Message-Id: <de4f4f35-500f-4d82-acfd-ca601444f2d2@app.fastmail.com>
In-Reply-To: 
 <CY8PR17MB6236D16AD8CD80720FF1342DAE692@CY8PR17MB6236.namprd17.prod.outlook.com>
References: 
 <CY8PR17MB6236D16AD8CD80720FF1342DAE692@CY8PR17MB6236.namprd17.prod.outlook.com>
Subject: Re: Interaction between pre-commit hook and git commit <pathspec>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 3, 2026, at 20:58, Kevin Lyles wrote:
> Hello, folks,
>
> The documentation for the pathspec option of the commit command claims:
> "The contents of these files are also staged for the next commit on top
> of what have been staged before."
> However, that appears to only be true if the pre-commit hook doesn't
> modify the index contents.
>
> Here's an example pre-commit script:
>     #!/bin/sh
>    
>     git diff --staged --name-only | while read -r file
>     do
>       {
>         git cat-file blob :"$file"
>         echo '# Extra text'
>       } |
>         {
>           echo -n "100644 blob "
>           echo -n $(git hash-object -w -t blob --path "$file" --stdin)
>           echo -e "\t$file"
>         } |
>           git update-index --index-info
>       echo '# Extra text' >> "$file"
>     done
>
> This always appends "# Extra text" to the end of any staged files, in
> both the index and the worktree. It serves to illustrate the issue,
> without getting into the weeds of what my pre-commit hook is doing.
> Suffice to say that my hook is (sometimes) modifying files in both the
> index (to make sure the updated contents are committed) and the
> worktree (to reduce spurious diffs when file contents are changed).
>[snip]

Reading githooks documentation for
pre-commit. To me it reads like the use case
is validation/checking, not any mutation.
This doesn't sound like a reasonable use case.
