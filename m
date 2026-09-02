Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE992571A9
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 04:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788323367; cv=none; b=iwp8va7pOHASLG48sYGuCVD6m2cw2hXpE/Had3mWTlpxtuSWokkDgWNPo2UEEKXsWPeBPvKCDrt3z2IH3DkTS767c1+NFViJK+XlPujC9lEdmZnjWU5SzGromOf12UmVZoGDy3HpQ0nes7LjqBf2Um4IrOYrRxzvc/GnWuLWinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788323367; c=relaxed/simple;
	bh=XvJp5h9uMG74pAvBp2NG/bPvBu5TKW5gaJph07bHdOo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UABF6kDrX09Bd4fngW31qxeUytxAMWVxmpa0ForMyLx3gkHVfrMG/fqRLTe2ywJCofh4P5rmPdCxG/4bjO0UnURppgB4IyBeDqN8dTka6mkOa2mKcfPJS0uCAeMk/Ju+rLXZ2b2jMl+5MkeMsdjI30UvrX79PpwHWzqvycjgpDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com; spf=pass smtp.mailfrom=wolfgangfaust.com; dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b=BJRUBnlR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GlIkn4Ed; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b="BJRUBnlR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GlIkn4Ed"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 913D1EC0086;
	Wed,  2 Sep 2026 00:29:24 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Wed, 02 Sep 2026 00:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	wolfgangfaust.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788323364; x=1788409764; bh=eBGWa96CWL
	sQM+2qWO+kfazQ+5fyi+EAZ9xERTWNSaw=; b=BJRUBnlRbxIU1Zu9DkOuMgW4T0
	YpXHxaReZPJKNjz5zrlO4fk6aRV5ashXqKpwp5wTPDdOgPpIRpSLkx3dwiF0ZnxM
	QDCO+QK+dxkx/FSs/igSPmOE7FpDqSxVRC/V3YSCq79e5xOyoSHKy3f/SFO6zivB
	Evw/NJBOZ+I5hJsFjaCTv+yrwgD4JsqqK1D4aaWOOlAwDOf/sikTu3L0DIxaDBn8
	1cqhWf3hc4eXD1nHjRYWG0aOSW1ZoXWAqTmnPDk/h7nxZI9YhkymoTT+i4DnfQq5
	iQrkpCJOUBjEiBa/8JW7O8uyFmmLWog1slEa4croPYIn1uxBMXLyZ1Kh6PLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788323364; x=
	1788409764; bh=eBGWa96CWLsQM+2qWO+kfazQ+5fyi+EAZ9xERTWNSaw=; b=G
	lIkn4EdC5POin9Q4wHT9BXLxFUm7ZF3xb5e4/ESnw0RdI3ukGVW3bTy17rhIv1/i
	v/jt0mbqLD1sEMQPYyJ7ejoc2SwY9zDayW/d5zljrIFrS+L+DwHhyOQVFjCj1gsd
	jaz2gYEaY08TYhxmy3d9qc55Dc/pmQuXjwLZG2RvdDQguUi0hINkhTyRccZ91Hvq
	LoI7bA9Qa/WAjdfK4C08UCV/odRz26jKG6CNgBX1VHoEFNWrMOwNFsv6ULWvaLej
	8yCmZYeL7hi6/lMOf7kFiOHnUlwxMmj86YspIasFXkg5BlR2HeDwUBYRW6jDQQDn
	5wizqNlrsTyTuljW+qCrg==
X-ME-Sender: <xms:JKaXap58ZulMseKOuClveQnsx-P1IC9GHFCj1wqI8KQrf-pV0I964w>
    <xme:JKaXahvXzzWE_rGk2lFuotkg-Vw_vzApsajZR6L1TBVtypiBGFaiMSdpwesIb5Vvt
    r-gtq_b7RsjxZgJ_z4O3EF5qYtJLtKq5ZkLJ0eCO4Bj3nF7SqEw4So>
X-ME-Proxy-Cause: dmFkZTFtEBwWvbOoTuQW4+cLTiQCysJPmHJylIodNF/es0bW8RuZBa1o3Uuip1S1dccB8M
    5sRiJppN1USlBHJdVgJtOhpURQNzMZeshNGTeeKBlD6yy2fiRi3w9Pxf7nhd4mUXTdRS+r
    Yz2tv5uZ5dH7mZTMce2Y8EPamClG8fkFeA9Q2M4hxfLc0rSFmgL9CMUgCvgWIQGj49uOPP
    DL7bFgJ7rE3yEgO4vKFMW7R0qPm8PB0P1DI3rdQ+JxCeapQ/i0QGtxqP/5Vz3fchertx7p
    3DzyoI8Cr2JbqM58N/ek7XNGFhGISR7rb+NwBHGfoB0xMvgLL5vRgoWqtCQ77ZegK+tFjh
    OZnB/2HnDCpMQnMmYQUUsZFvPHOMD8kdfoimTVbHaZHRB7BjBn6V/h4q5Tb2lNI0sERSFk
    f17w1MLauttcCEakA8BvftQIWkL8fRQT9WJvfFxRCkP2IKD4zqoQjeplgjwnFuGvADa11I
    ZAjYjV/5EZ0Fo5qSi2Nhh0YMo3kWkKRA6V7ZOsHV0zTbg6l1/kJw6U2uFvLjfj5O5/LFbY
    zOaaLJEl75+P7jbSSR5n0dVaHlHDmE1UERPTlzEarxGNy5TlCxi435PeSAcLsHoOzbcuzD
    nPXY/8ElS3lgPK6ErRZ0b9KBiMP3QOwCbEg/M0+TjqgFg4WS4gPpaFKbDnNw
X-ME-Proxy: <xmx:JKaXaoX85fGaw3JyKZrPEQVTVyG6gq6ieuQ_o7ZmhKDL53M6TDiw5Q>
    <xmx:JKaXakWGMqlFfCPtrCWYJvg5mPffFT28Jv9qb_vNnJnISurvPavVFw>
    <xmx:JKaXavekInenhE3c0EF5MHpHHNdasRPRUJr9wxqz-ZC1i3PIBb1Trw>
    <xmx:JKaXalWoOyprCGacMYf9JZ9-uCezBesNC8xhxwHW3M_ca_tEbxDTEw>
    <xmx:JKaXambttrwAOnK_ooGPbr-1_yCiXYb9ICUnI_JhTyg9KarZsaytt-pM>
Feedback-ID: ifd814412:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6047618C0069; Wed,  2 Sep 2026 00:29:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 01 Sep 2026 21:28:55 -0700
From: "Wolfgang Faust" <contrib-git@wolfgangfaust.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Aditya Garg" <gargaditya08@live.com>
Message-Id: <31d24dc3-3ef6-41cb-acbd-4cb4fb0d2338@app.fastmail.com>
In-Reply-To: <xmqq8q5kl4gq.fsf@gitster.g>
References: <761c3f1b-e280-48b1-a2ad-770b68be3434@slotpi01m90>
 <xmqq8q5kl4gq.fsf@gitster.g>
Subject: Re: [PATCH] imap-send: add --draft to set IMAP \Draft flag
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 1, 2026, at 8:25 PM, Junio C Hamano wrote:
> "Wolfgang Faust" <contrib-git@wolfgangfaust.com> writes:
>
>> The documented purpose of imap-send is to upload draft emails for sending
>> later, but it did not have any way to mark the messages as \Draft, so some
>> email clients presented the result as an un-editable, un-sendable email
>> even if it happened to be in a "Drafts" folder.
>
> I agree that defaulting to '--no-draft' is a sensible design choice
> to avoid breaking clients that have been working fine.

Definite agree; I elaborate further below.

> It would be helpful to know if e-mail clients that send messages
> from the Drafts folder without the '\Draft' flag would misbehave if
> they encounter messages marked as such.

Not sure how to find this out without doing a complete survey of every
possible email client, but I think it's unlikely to be a major issue:
any such client would already be incompatible with other standards-
compliant clients using the same IMAP account. However:

> Knowing this would help us
> decide whether to flip the default to '--draft', while keeping
> '--no-draft' as an escape hatch nobody is expected to use.

I think the default should probably be --no-draft anyway.

First, imap-send is also used for cases like `git send-email
--imap-sent-folder`, which would need to be taught *not* to mark the
email as a draft, as in this case it has already been sent and should
not be editable. We can change `send-email` to set that flag but this
does not help any external tooling that might be relying on this
behavior.
 
Second, as `--draft` requires a relatively recent version of curl, or a
(non-default) `--no-curl` flag, trying to turn it on would cause most
current systems to continue *not* updating the flag, so in practice
the behavior would change depending on the user's system libraries,
which seems very unusual. (Or, if we changed the curl version check
from warning to error, the command would default to being broken unless
you pass `--no-draft`.)


>> +`--draft`::
>> +`--no-draft`::
>> +	Mark uploaded messages with the IMAP `\Draft` flag. The default is `--no-draft`.
>> ++
>> +With libcurl, `--draft` requires version 8.13.0 or later.
>> +Older libcurl still uploads the message but cannot set the flag.
>
> When compiled with older libcurl, would the command error out when
> run with '--draft', or would it silently ignore the option?  I have
> a mild preference for the former over the latter.  Issuing a warning
> without erroring out is better than nothing, but people tend to
> overlook warning messages.

Right now it issues a warning. I don't think I had any particular
reason for that decision and changing to an error seems fine.


> Also you might want to consider adding a configuration variable,
> perhaps?  I dunno.

I assume you mean something like `git config imap.draft true`? This has
all the same problems as changing the default (in particular the
`--imap-sent-folder` case), though I guess at least it would be opt-in.

I also read in some past thread (I forget which) that we generally want
to start by adding a flag, and only introduce a configuration if there
is demand for it after the flag has proven itself.

> Thanks.
