Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576480629
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145237; cv=none; b=dPMCOaPKZ/FhcV2rJ8rnsle0ppBPRf5BJokuYbjjhCZRgTdTOO/SCihKZn8/rAbr1dRUQ86WU1f5vQap7LDbraVPtJmS0SKO2ahnSGSRVEZFZMsfAH5tzgu8x4sTY2Jf15lSlFGCJCm7sFKudbYfJm8dtQtAqrb5tSzmBWD3UaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145237; c=relaxed/simple;
	bh=yjaT4qwhQNN5BLODKhHrBP+Faj1R40gutXQXvO3P6+A=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=jO1ZMwp4qq1csqZs/inYFV54iiudNJbi257CiWnDUftDshEHBg176KF8UaUSJdHZM59wxebPrMYL04Y8GOnMQ5pH7poM2kWgw9QmuUa0YBGNQW350cFu/Il3tOMEzzpoMjcZjYGdKqYs+3tBongnrHz4evqoxn5yz682JlMPUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=AuCRTX6u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lcYA/2z3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="AuCRTX6u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lcYA/2z3"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 864B213800E9;
	Fri, 22 Mar 2024 18:07:14 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 18:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1711145234; x=1711231634; bh=c/R+g6f91I9HUQDCmGjF9axd7WEq/b56
	1MqeK03bnVs=; b=AuCRTX6uABH5oKAVVaJ3L3Hvw9/A65aB5aam2Fqyi8RLbXA/
	MYAEFmmGfUtxHXwi9VBNwzYdUJQbAfRwc57FcMIUzwylyS8TZZWCGiBHu9BsuNrE
	qPpG7WnKpyRPA+rZGxBCieyoyJuRsYcIpZz7zNYoMh31poUgW5gHDpKdD99zN+Fm
	Md4VgAUltf2n6MAHQwDTHZqCDwB0yPlpl9UzqPpnsHAfsFywi4yJa6khhsqfu3Ut
	agPfiKY79veWseiEPQP2THY3lZCSimy1jBvGb+7pqFM2b1Yafo9HehmMt5TjckdB
	8zZPb1aKZCRAzIUv7BSG41EoyBCogN5qktaT2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711145234; x=
	1711231634; bh=c/R+g6f91I9HUQDCmGjF9axd7WEq/b561MqeK03bnVs=; b=l
	cYA/2z3maEEOYe3ZT1TYKqezN/l7D729nyQ0WFTATwhyzCdMNxFMkkYwQFj5fDUn
	lq5XJOLfb05p3EmxgxAHKLUnvNsvhQXyvaR9WUJi46FrY6IJru0Uiom67yVwWmBI
	DlCwkZPHRNlWKpUCpsSw0BdjW3hmNqMphJbvb2LsVvbK5BEatuTzGoYQUeKzkqzI
	bCkFNzqX50YhgH0GDzybSvwxWXSpV6zX97hl8QEDXnBJ1Pg4ijbjRtOhBZ4Rk01a
	kvpXACZuQyC0eEfeReRYwEty+3RQ3lLdG3NHlW38BPaX+SvSHvOhYlccVr/to31U
	BKnvDG0oHRSZrnmoDWDLw==
X-ME-Sender: <xms:EgH-ZaL7O_uo-kBIR1TbUdtDYgdm6F3vcC2EPaSO4dFyAygO314uxnM>
    <xme:EgH-ZSLM65mdVzLYqK7AkyrZkHmle9XyDYsOdSsWp0BnWCcTJ0BFt9ZKamhPBvPlF
    fIpudIu6URSF7gtzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtvddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    eptdekudevtdfhleeuveehffehvdevieeuieehheduheevgeeuteetuddutdefleeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:EgH-ZavOhAXdpkFEOEsDpJxM3fJUrPf63lmdWkUWwXQyAKx4Zr4mwA>
    <xmx:EgH-ZfYMwb9qeUTBCS9zBzKJ-nueeUysFa6BBqqY4meYRONl5Ct_0A>
    <xmx:EgH-ZRZN45l89ORICyNoQVI4yOKvSemJjK0i6zyS0ytviuwOllZs-Q>
    <xmx:EgH-ZbAyOGKYDyFXDyj1p80iUiljDx7zfl9JUFi5By7EZNBJ722SLw>
    <xmx:EgH-ZQmnJo4VWi37FI8GX_CkKNuHRd9fjKZG_jVCEg_tYskzwJmggg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4D4A415A0092; Fri, 22 Mar 2024 18:07:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c94e0ba2-87b9-4272-afce-67f5faf0275f@app.fastmail.com>
In-Reply-To: <20240320003533.GE904136@coredump.intra.peff.net>
References: <20240320002555.GB903718@coredump.intra.peff.net>
 <20240320003533.GE904136@coredump.intra.peff.net>
Date: Fri, 22 Mar 2024 23:06:53 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] format-patch: return an allocated string from
 log_write_email_headers()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024, at 01:35, Jeff King wrote:
> When pretty-printing a commit in the email format, we have to fill in
> the "after subject" field of the pretty_print_context with any extra
> headers the user provided (e.g., from "--to" or "--cc" options) plus a=
ny
> special MIME headers.
>
> We return an out-pointer that sometimes points to a newly heap-allocat=
ed
> string and sometimes not. To avoid leaking, we store the allocated
> version in a buffer with static lifetime, which is ugly. Worse, as we
> extend the header feature, we'll end up having to repeat this ugly
> pattern.
>
> Instead, let's have our out-pointer pass ownership back to the caller,
> and duplicate the string when necessary. This does mean one extra
> allocation per commit when you use extra headers, but in the context of
> format-patch which is showing diffs, I don't think that's even
> measurable.
>
> Signed-off-by: Jeff King <peff@peff.net>

Good presentation of motivation here.

> ---
> I don't think the extra allocation is a big deal, but if we do, there
> are some other options:
>
>   - instead of an out-pointer we could take a strbuf, and the caller
>     could reset and reuse a strbuf for each commit
>
>   - the after_subject stuff could become a callback; we discussed this=
 a
>     long time ago (I had no recollection of the thread until finding it
>     in the archive just now):
>
>
> https://lore.kernel.org/git/20170325211149.yyvocmdfw4zbjyoi@sigill.int=
ra.peff.net/
>
>   - this log_write_email_headers() function prints part of its output =
to
>     stdout, and shoves part of it into the after_subject field to be
>     shown by the pretty-printer. I wonder if it could just format the
>     subject itself (though that would make "rev-list --format=3Demail"
>     even more awkward, I guess).

I don=E2=80=99t quite understand all of these alternatives but the first=
 one
makes sense. Leave the responsibility to the caller. That could work.

--=20
Kristoffer Haugsbakk

