Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792477761;
	b=arqRrH/LAKxjE+3Tn2mzOhGLhSSxS5gyWYCNKWyvPW1/da/Kkn1EXLtuY5kGfJUkOZ9I
	 vf/r0G3cZ0g9Y2B5fVL/o/ecZ9q/md3RUWa2pYmey6siLqq84T/OsIov8holHxB1zCcpi
	 /V69bvQUyG+cm93bypE8ZGCZZMDhJwJzxGbcmxfUKe9Gm7OhKMpsL3svhmaV8k17/0QSu
	 wdg5MGqaj0CFNUvYFIeeQJazQvp7o4V1R1k5GGd1wgWbePWmKXOQntSxdhJ8yGupHnjN0
	 vDROiUAlcEOL2fTPZ5pJScryceVQdaBjBN4x49/GkinEUzkTSWL8OrjoufPiFjpfAWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792477761;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PfllKreIYm+LF6Z2SSSp7onqHC0gnqcBq2bF6tXodS8=;
	b=W5sbePYCXdayS9nMAM9MtUhevnYqkzTNcSeA59v1RatshCAzq6Axf/l1vz9aBYqm/jl8
	 Ssu6S/1fLaoNrEPBS0FbSRwNWNvQE/s5xrPCIKe4/sFj/6DfSwGM/FGE8bjZuVA09oigr
	 v1SgtKxoSFH5XYRjcf14PynbGHFOeeIavi44dVIWmrG9agIr9lS9akvq0Bj7EfG5nktK7
	 vsNwee6YX3ovZMboU45ZnZjW7rSk4MLulqYr93r6Yhc0SGbaEd7GNn/egIuTzFM9hrGVg
	 CvVTAo5AD9x9s/X98Km0me+gSho2Dawb706A6pHS4s9EVSOAhGg6Chc1Jo8p/r9MQtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Dyfy8QiU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ymr8EAf0;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC2606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AEC2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Dyfy8QiU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ymr8EAf0
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CF84EC010A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 02:29:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 20 Oct 2026 02:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792477759; x=1792564159; bh=PfllKreIYm
	+LF6Z2SSSp7onqHC0gnqcBq2bF6tXodS8=; b=Dyfy8QiUKpAoUF8lkvtolJzuqx
	GxohsI1NuZ1aFbMbe6vjIBp+qJqtLx6DVYfkZnOyblNfen12zy2c6wXGRMB8Q/of
	uDM+XLo/N42uUXfOZ/Q7CQy8pfVzSPsLQ+Di7vPtg1IztxqPzIeJitCMWXWK9P2c
	kM6vzKr6B0b6m2BbmnK6tOaz9lh/8B9Z9YMLhaJshzos7V7P6wzSoF6tkuTN4o6q
	OXKn5BB2ktpz862iJht3T4ponMLtC6MN1h4jb5p48I37C+i4QfREml+ikZ5yzHBJ
	S46zsjijNRznsD7MXot4ImE7ScBgkI/0sx5FXBf3Azk28HBvpcD0w7Ean8Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792477759; x=1792564159; bh=PfllKreIYm+LF6Z2SSSp7onqHC0gnqcBq2b
	F6tXodS8=; b=Ymr8EAf0LfZ5egqveImWgTa2+cKmaKQPQeLsET5dWNB5PuqUIY8
	nN5hNwqZfiQIA0uA1vqY4yvsBtlVk41PEwA4pZ8jCeoiN/+fCEEr5GJQm44o3pNk
	HLFh4MEp8L9sTnJlr0F5idcg+jqyR4NFrDOnagOvkuzzvJw/uSmBsFNG25Qf5pHw
	Fu5bfaYS76zzOoQ1hHH19Lv+b1CCdhj7YNmjNYYmb/ffVcXwCn8cgVyr+lYZFXRJ
	6NUebzw2l6x3Db+PvsrAfBl7y06J3ZFN+e1Yh9RviLsjGVxcxCcAwYlpK0WDzZPA
	JZbcWUnQ0yQ6InmMzTaRxiOyt8VJ5IKg7XQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792477759; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:roVOrQTpET2c1pmQHCc/9cWGhldf1bhILVqOmoE8dAvOXPw
	w6FyG3oZrkOp+++7C9ziykOWMKLd2wnuGTd30kG+NiIa+cxMNeKjWEdXcOAoYNKb
	tDUxLzqsIVIIdC7h3z/Yxed+INFU9M6jGrVzpDgc5XjjnmAVuj0zpG4zJWihpJet
	fUaz0oj74VMcOKsGSzC8/zkqikDEXsO3fm6l6l9mE1QsdsGVvK3R7Ba7rv2QQhfi
	32xZXnezwS+px9cnc+w0bcHWjq2hSB3OOZdg2hNiQSLJvVJGKim0GmR2SpDGMs+k
	Moo4HYs8L4Q1dWgJDMbQDRSczqvIG7iqxMgZkZQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:b/kV6lumR7m/0lMqIsEiPfDTWXcZRfGT/GCpu2BBPFg=:C8T4agIMLkUvk1ufQi5mqRHigL2Wn9+OwyrgIjo2ZMk=;
X-ME-Sender: <xms:PwrXar-ssqPERCYrPNsMQafKZZkXCM0D7eNTjCahHhoG9H35oJg-kQ>
    <xme:PwrXavIeLc5sB13unH_zrtfFgqKPn7phumpEcfYARyV0p6ChwhsAA9zTzZV5RjFn0
    BsU_YDvjQT1LYG8wHB-Tl8Gd7-xoY9EjA9MU9crnLvIJVu8fq6_gII>
X-ME-Received: <xmr:PwrXamahmeoOKuIPwjfiea3MdirMKiUeKiUipA1Ey2JbG39HGiDcOCZy4zZNS5ivNgyp8Q>
X-ME-Proxy-Cause: dmFkZTEvzUy4iICaimyNp09hix0XqbzvDDTSeZCVuLPurOZd/buXilhznK+rt/WxBs4Zpa
    ghVy9LToQTQcfNApTOciTAZCF++LX7jPhnLYAIhmEKiPm06Hp2G+qi3qqFzHaqo48Go4fK
    cuzfudwMQl8HXFKJEXhrQqMnvxa8pN77mKDkWhNDt2nMtE1GCALJvEO/qeO9xaNuf5zIB9
    1+1SVfVoTF1UFwU1KfBvi9yR4U0nCfSygj0dxqu68XELClcsVG+eENZ+p6Ai9Pa8MH2zSf
    ntFdn308G/rSs+lKinqviquezYTuh6Bf5ORvdjl9Lj5ylk14fmF0IWGozu2FxXCEUQkKMb
    aPZ1NG7LPOHXPW8q8FdxlnavKhjZlDcxBosrleujLl4NKcxprLAqNUlFJD0kHqnPz/RuYl
    +k9ZSaST1iz0I5Aglndawiy05yfAKM1NsXQ2VBsTMCABJqdLBiDE4Rea48Jo26UO8GebgR
    8QVyzdJx+L992z4wz6aGEigJVnhKN2Df4B8ITYoemvbvwC6tFYiFzcaENCmbv/FlDuBNvf
    thp+nxgxtmRaCRbonQzactskenQmyL6njsj7QdjymEWk/ReGx5MqYRHxMRdleGco3pDcN5
    udAIXiq4FMnCCyNV6U5vG/E3G6GoJTGeCOJCL8ofU+LmD+m9rt1TMYAhLg6g
X-ME-Proxy: <xmx:PwrXahLgPRGEARNHD_tfyxppK18zrbWrs6_dg7jvB-yZ5zeQflCD6w>
    <xmx:PwrXakAPooWruZqPed-YWJa__1ZZReFn6MPAFk_XfsdVt7-00T2qNA>
    <xmx:PwrXamp_RRmdE6bH4R-sa-eR9K1HUsbGi_gNrotLESIeomvC_eJv2A>
    <xmx:PwrXaviFmwIuvGNz7pmMyp60BRotZExt3sxgQcAdcTiqAEqRDzfIaA>
    <xmx:PwrXarIrKhZAjQGYKjOn1cv-g1uhduSSMvWcq1nKPDtlDlGqq5JrtBh1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 02:29:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c19be542 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 06:29:17 +0000 (UTC)
Date: Tue, 20 Oct 2026 08:29:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: m@suozzo.co
Cc: Matthew Suozzo via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] reftable/record: bound an object record's offset count
 by its length
Message-ID: <atcKOhm0Kd5XryAg@pks.im>
References: <pull.2255.git.1791989883899.gitgitgadget@gmail.com>
 <atXK0ska_v2rFn8W@pks.im>
 <41edbeff828fcb4a2f3bc903802b14e3aa66f46b@suozzo.co>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41edbeff828fcb4a2f3bc903802b14e3aa66f46b@suozzo.co>

On Mon, Oct 19, 2026 at 05:14:08PM +0000, m@suozzo.co wrote:
> October 19, 2026 at 3:46 AM, "Patrick Steinhardt" <ps@pks.im mailto:ps@pks.im?to=%22Patrick%20Steinhardt%22%20%3Cps%40pks.im%3E > wrote:
> > On Wed, Oct 14, 2026 at 02:58:03PM +0000, Matthew Suozzo via GitGitGadget wrote:
> > > From: Matthew Suozzo <m@suozzo.co>
> > >  
> > >  An object record's count of offsets is a 64-bit varint from the table,
> > >  and reftable_obj_record_decode() allocates the offsets array from it
> > >  through REFTABLE_ALLOC_ARRAY(), which takes a size_t. Where size_t is
> > >  32 bits, a count of 2^32 + 1 allocates room for one offset, and the
> > >  loop, which runs to the full count, writes an offset from the table
> > >  for each varint left in the block past the end of the array. Where
> > >  size_t is 64 bits, a large count only makes a large allocation that
> > >  the decode then fails to fill.
> > >  
> > >  Nothing in Git reaches this decoder from a repository: a block of a
> > >  type other than the one wanted is refused before its records are
> > >  decoded, and the object index, the only reader of object blocks, is
> > >  used only by the unit tests. The decoder is still wrong.
> > >  
> > >  Each offset takes at least a byte, so refuse a count larger than what
> > >  is left of the record.
> > > 
> > Sorry, but this whole commit message reads very AI-generated to me, as
> > it is both overly verbose and hard to parse. I would welcome it if you
> > could maybe touch up the message for normal human beings.
> 
> yeah it was AI generated and i copy-edited it. it didn't feel too
> excessive since i wanted to be precise about the issue's mechanism,
> scope (32-bit only), severity (not really reachable), and describe the
> fix.
> 
> any pointers on how you'd reword? remove the exposition?

It's hard to say. With AI-generated commit messages you very often have
the feeling that you end up understanding everything and nothing. It
just feels off in a way that is hard to describe, and consequently it's
also hard to say what exactly needs changing.

My typical suggestion is to not use AI to write your commit message at
all and instead write it yourself. Commit messages have always been the
place where you can demonstrate that you understand what you are doing
as part of the patch by properly explaining it in a way that another
human being understands it. And I think that role is becoming even more
important now: in a world where we cannot trust that the contributor has
the slightest understanding of what they are contributing, they need to
go the extra mile to prove it to us by having a well-written explanation
thereof.

I know that this is putting more of a burden on contributors, and I'm
not a fan of that. But I think it's becoming abundantly clear that AI
does not really give open communities much of a choice, at least not if
they want to keep standards high.

> > > diff --git a/reftable/record.c b/reftable/record.c
> > >  index 1fce441930..96eceddca7 100644
> > >  --- a/reftable/record.c
> > >  +++ b/reftable/record.c
> > >  @@ -589,6 +589,10 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
> > >  if (count == 0)
> > >  return start.len - in.len;
> > >  
> > >  + /* each offset takes at least a byte */
> > >  + if (count > in.len)
> > >  + return REFTABLE_FORMAT_ERROR;
> > > 
> > This check doesn't really seem to match what you're describing. What you
> > describe is an integer overflow, but you only check for a very specific
> > edge ecase here. I would have expected for example that...
> > 
> > > 
> > > REFTABLE_ALLOC_ARRAY(r->offsets, count);
> > > 
> > ... this line already detects the overflow and then refuses the
> > operation. Because `REFTABLE_ALLOC_ARRAY()` itself already tries to
> > check for overflows.
> > 
> > That being said, if you take a look at `reftable_alloc_size()` you can
> > see that the input is both of type `size_t`. And _that_ is indeed broken
> > on platforms where `size_t` is 32 bits, as we'd potentially wrap. But
> > that fact is not even mentioned as part of the commit message at all.
> 
> isn't that "REFTABLE_ALLOC_ARRAY(), which takes a size_t" in the original message?

Ugh, no idea how I missed that. Probably because my brain was sucked out
while reading it.

> > So overall I'm not convinced that this fix makes sense, we should rather
> > fix the source of the problem, which is `reftable_alloc_size()`.
> 
> that felt like a pretty disruptive change i was hesitant to put up as
> my first patch but i'd be happy to make the change.

Hm, I wouldn't call it disruptive but rather holistic. By fixing that
one function we also implicitly fix all the other callers that may
currently be wrong. And in the end nothing really changes for callers
anyway: I'd change the parameters to be of type `uintmax_t`, but the
return value should probably remain a `size_t`. So we'd continue to work
just fine in all cases where there is no overflow of `size_t`, but we'd
properly detect cases where the parameters themselves already overflow
it.

Patrick
