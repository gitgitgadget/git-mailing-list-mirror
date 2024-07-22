Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A852907
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665686; cv=none; b=RB23vCLnIZOk9+4i0nQf7QUdTKm855uez6h22LDn8D4r6Y4rFd3ijsM1/BUrOOo4w4M1NBFvBsgLT/ySQ7cUMZ2i0jBTsYK+KXR0ZXxVqNpqab5sTxEUveINy4uH601smKffO3DeNjh4hHbpM8YBv8DfSW67WPbOj0Z3MZJVwqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665686; c=relaxed/simple;
	bh=8b8MPo2lZIydaDBpcIKdIPJbA/BhPBkaaD1pONZwtpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EG9URHpVFBThSOocff4qf7hwLBSPTsPr+EX0JkbnViZUDNjFi3VgJ77VRgLlOmbl/MdZ/DC/+cIDq2C4e59rED8U0QTSP6wYTMCbzaU80cZuwXWohYoAAGpLMNIOkFvSrxUoetd3BPaakb580NKzVLtN4vbD3WVyUSJLdqqPXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BKhG/kS0; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BKhG/kS0"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FFB822DDF;
	Mon, 22 Jul 2024 12:28:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8b8MPo2lZIyd
	aDBpcIKdIPJbA/BhPBkaaD1pONZwtpA=; b=BKhG/kS0zguYT8ELND2DKIVa5B8A
	0as3DV1UlKjGCIJvTNz9r1+JhNAtWk0ngI163mJTcCTyJ+1dhU0Vlc1TSf7lnXFx
	MLsVtzRSynyupYNhmjCRJXsnoHew1xjieFERMEs2LiLvy4AHl767dMw7FY+PGNIG
	9pwBKDk7l1OCjEg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A12322DDE;
	Mon, 22 Jul 2024 12:28:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7967722DDA;
	Mon, 22 Jul 2024 12:28:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] asciidoctor: fix `synopsis` rendering
In-Reply-To: <xmqqr0bnfwap.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	20 Jul 2024 17:01:02 -0700")
References: <pull.1749.git.git.1721507416683.gitgitgadget@gmail.com>
	<xmqqsew3hdmv.fsf@gitster.g> <xmqqr0bnfwap.fsf@gitster.g>
Date: Mon, 22 Jul 2024 09:27:59 -0700
Message-ID: <xmqqy15te6i8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5D309CC8-4847-11EF-A82D-9625FCCAB05B-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The rendered result is bad in the same way with or without this
>> patch applied, and "git clone" manual page is simply incorrect by
>> mangling a handful of command line options.  A recent bug report in
>> the thread that contains
>>
>>     https://lore.kernel.org/git/xmqqle1xjm1s.fsf@gitster.g/
>>
>> gives us more details.
>
> With Jean-No=C3=ABl Avila's {empty} patch applied, would this patch be
> still necessary? =20

The answer is no.  I managed to reproduce the problem your patch
fixes locally, applied Jean-No=C3=ABl's patch which corrected the mark-up
to avoid losing text in the [square brackets], but the problem still
reproduced.  It really seems that the `monospaced` text that are used
in the SYNOPSIS section are rendered with display:block.

I am not sure if forcing any <code> that appears as a (direct or
indirect) descendant of <pre> with custom css is specific enough,
but that certainly covers the breakage we see on the page.

So the difference I observed between git-clone.html and say git-add.html
is purely coming from use of `monospaced` in SYNOPSIS, and not
because the unintended triggering of a feature by [text]`more text` that
Jean-No=C3=ABl's patch fixes.  With or without that fix, the css tweak is
still needed (it may be overly generic and may require us to tighten
the selector later, but we can worry about it when somebody finds an
actual breakage).

It is unfortunate that all .html files ought to be generated in this
project (in other words, nobody writes HTML by hand), but asciidoc(tor)
insists that docinfo for html backend must be stored in a file whose
extension is .html, which caused a "huh?" Ramsay reported earlier.

Will queue.  Thanks.
