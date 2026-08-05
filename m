Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D8384CE8
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918617; cv=none; b=uaBm7++z7CbmMA/t7bkHl0U2jIn8ISHlMyjSWoNgZmhMSvkgYMbZrbYZG8Gyl1aISYbkLjnt1TYnh7S2HCaFxYjiU16MaQrI4HkPLosFY7vgIZdECRgVadbcWmjGcit33sZaZGowwTijJznQCX88rVPKtxemtVvEg6JPbQZonHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918617; c=relaxed/simple;
	bh=sGmhD3UokkjhFXtWE7WkYxWGCS9hSVEmqcHNKurig1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1Ho7umYJfFJN3xWSA+csgaw8ZYLYR7DS6SnzoWvt4UyagKntspbA4hGlLM2+mEWwtyWi/rDjEAfl+iARIjDgreqT3bjJGXTSbeYj6bRhAIVwtfzYIgXIwoqggsp/MclXlA9KQ4WM48QS3p3/nLdQP5keScvJcfzqhUo5FSdT9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fdJwi1WA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CyHWNmZG; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fdJwi1WA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CyHWNmZG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA273140015A;
	Wed,  5 Aug 2026 04:30:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 04:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785918613; x=1786005013; bh=nBq3ZhaBzu
	BDpnorJuh2bZyPq12vHtYcmr3C1kPbmZw=; b=fdJwi1WAyztTukHJmHMU2n/G0C
	n/ug+0/lw8gM5wqWDwCMoidqk5LXJE0fra4LLbj5kKUz3TwA/7Vhtf1zsz2DNdl5
	mogkIpuxTbqvZqiRE1WYb+vsfstJiRBv1l1BGM3/hWhEwha5FPPHWxzbB2ShTlT6
	5kwbpSQh6/6wJuyDWToL1ks7fW8DX/QznwtcTxbiITOWHkQhlOusSLjekgZmtax9
	E7aWmEHjgm4O1QY0nHbpeiSbM+n0+HAffJ6zQtbQ8+Sq7PWQEYe+ung+015vLbca
	Cu29SEjW8g+NF/cC9O9PnK2pw9Ezy9uSW8rj18lOptGFxxJEoMpQZXKmZQpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785918613; x=1786005013; bh=nBq3ZhaBzuBDpnorJuh2bZyPq12vHtYcmr3
	C1kPbmZw=; b=CyHWNmZGHwNOEb6Iq0Sc6KZBhB4eRqtEMD2ib/3G9KXaQKdpZcq
	NaMQ87qGoabbp2CgbOF2CE7zAcDBWFWZIPNUMYfq4ruoGoci0Ujv6NF3ZFVNfbd2
	SuHo8vK3vXk0BERqK9QgLRgmXIAQbWI61sSZRm9mnw7MxPMa9UXqXydRn80o9E7j
	9kAUAwZYrMd8wp/kIDEOOPHj1lcB0YSczsiM4gdpGwehOjYj7R19KjfKIrc6lHHX
	wiQzy+3e8fZRZXfrthtDlYVOvzSGYfIfcxl1hrPQ2rEv4Up6iKdWPYfp9JV2i85f
	A4zroVkh+xVwLiB29kZclO2gTgrFxD3fhlQ==
X-ME-Sender: <xms:lPRyarStN5uv5n9WkQSr4c2LOJLWymq2DVNAWMUU2bvkFX4ww-UFBw>
    <xme:lPRyahtjQWT1_fl8OHVSzMNAzr9YxqJnAdekaRuI14Mcj9dIVsAffucxsSDLl1oNB
    KgJ8w9jn2FG-y027YPTVwQO6R74VeDqztF08CSxMTGQKDl894Yxv-Y>
X-ME-Received: <xmr:lPRyalGkRbdGq4kTKVnvGrWSBnx6Q6lM6NX9hxb-LH-FdmjZ5IAaVVF3LLraGX9CQKPQu5swMTlhozJ9IPL0rtukUpjKC19esw9mzmdtUg>
X-ME-Proxy-Cause: dmFkZTE9Mkb0lFTjEz+spjUxgS8S6WpapGxLk9/ocXPXdKBTsfixIceF7h62j6ftrY4LkR
    XzccmF8WCB/lVDMZkHwbvrE5CKrb1wuB1a0odGog/4rDlnJXBTwgXAou4aVcaz99mHNj2C
    xDnhZtDwA0+cPB/rWKVJ6KkFQrKOEPj0tdrLAfqo/yK/nfi0dFChmx0pcuUD7uWSBevv3H
    MG9GLnH2voYUirW3zule4DbleFTYP/HaXV/aGQFu9T0XyOC8Y7hi7o7WSbMZ5kNYSbTGTS
    l1I5bCI32QiBwtO6+6RpobCiGugH7jLFG1Kfci1HvBylY9A30sVXiqEFQby6n3J/Yp9vJn
    sh1gcC98XUuS03VE8eCtYJ4fR96c5xEJvWhn0w8X7oBJN76CTPIYjav3yFugFIXo9g4oTN
    sM8f/3hYp0lNrZ5tktD3rxfdi2BcVmgYDSwyWdREbTC9nDyt43eaqfK9VkIrtPoqxbwBDe
    hfWmQmw6DKiQVUp1joNl0e4pWcObKmPcrEsEYWOM44n5j0rHMyxpT1zM1Aj6H4j7KGZKmR
    fG2OB3jBZeMGjkV2q4XczXVUPrLUY0vrdzEa7mkPZELX/cmT0Z5hH8p9Hj1mvLhiqxgo/J
    CLvbKgs5pUIhUHcEn66LZ9OIVPU/spMOZIZ4qXCpugSDYM/9IPAdWV90BL0Q
X-ME-Proxy: <xmx:lPRyaqxylWRADvPV4zKEFkfQiD6YojWsO82tUSgIANlxUDU2kL30Fw>
    <xmx:lPRyan1XP8DblLD9-lG70n1tdRAYu7sGZNMsSVi4qRAXVs6t8V3l4w>
    <xmx:lPRyaip1mkiqOTHbjQ27TWaKMUhyxd87nJZkwrpPzYzI62uW7dIJww>
    <xmx:lPRyasXXZZEXFbCBXkWjTRALF7OjU8h8X60jgKAs7t1cpfr2BjwQNw>
    <xmx:lfRyatwK5EIL8HN7vVJsi6WA-jxkISMh7pwQZArLmuYz-VUhHo0jVF5C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 04:30:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ac27176 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 08:30:07 +0000 (UTC)
Date: Wed, 5 Aug 2026 10:30:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Simon Richter <Simon.Richter@hogyros.de>, git@vger.kernel.org,
	Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Randall S. Becker" <randall.becker@nexbridge.ca>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] compat/posix: introduce writev(3p) wrapper
Message-ID: <anL0jMyS3v2alJht@pks.im>
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
 <20260716-pks-reintroduce-writev-v1-1-ea9038c884bc@pks.im>
 <a2676ec6-39d5-4220-8549-10a17daec668@hogyros.de>
 <xmqqfr1ig0hv.fsf@gitster.g>
 <xmqqwluuekbh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwluuekbh.fsf@gitster.g>

On Thu, Jul 16, 2026 at 01:44:18PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Simon Richter <Simon.Richter@hogyros.de> writes:
> >
> >> Hi,
> >>
> >>> +		if (iov[i].iov_len > maximum_signed_value_of_type(ssize_t) ||
> >>> +		    iov[i].iov_len + sum > maximum_signed_value_of_type(ssize_t)) {
> >>
> >> That feels like it could overflow.
> >
> > Isn't it checking if it would overflow (and dying if so)?
> >
> > Ah, wait.  The addition "(iov[i].iov_len + sum)" can indeed wrap
> > around, and comparing it with the maximum value of ssize_t wouldn't
> > catch that.  Is that what you mean?
> >
> > Would something like this:
> >
> >     if (maximum_signed_value_of_type(ssize_t) < iov[i].iov_len ||
> > 	iov[i].iov_len + sum < iov[i].iov_len ||
> > 	maximum_signed_value_of_type(ssize_t) < iov[i].iov_len + sum)
> >
> > work better to catch the three cases independently?
> >
> >  (1) The value is already too large on its own.
> >  (2) Adding them together would cause an unsigned wrap-around.
> >  (3) The sum does not wrap around, but it exceeds the maximum
> >      representable value of ssize_t anyway.
> 
> Actually, looking at it again, I think the original code is safe
> after all, because:
> 
>  * "sum", even though it is a size_t, is checked inside the loop to
>    ensure it stays below the maximum value of ssize_t each time it
>    gets a new value.
>  * iov[i].iov_len is checked to ensure it does not exceed the
>    maximum value of ssize_t by the first part of the condition.
> 
> If both values are less than or equal to the maximum value of
> ssize_t, their sum is at most twice that limit.  For an N-bit
> size_t, this sum is at most (2^N - 2), which can be computed safely
> without any unsigned wrap-around.
> 
> So...?

Yeah, I think your analysis is correct. It's quite subtle though, so
maybe we should make this a bit more explicit? Something like the
following patch for example:

diff --git a/compat/writev.c b/compat/writev.c
index ab2e223634..960673861d 100644
--- a/compat/writev.c
+++ b/compat/writev.c
@@ -12,6 +12,7 @@ ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt)
 	 */
 	for (int i = 0; i < iovcnt; i++) {
 		if (iov[i].iov_len > maximum_signed_value_of_type(ssize_t) ||
+		    unsigned_add_overflows(iov[i].iov_len, sum) ||
 		    iov[i].iov_len + sum > maximum_signed_value_of_type(ssize_t)) {
 			errno = EINVAL;
 			return -1;

I doubt the performance overhead of this additional check is really
going to matter :)

Patrick
