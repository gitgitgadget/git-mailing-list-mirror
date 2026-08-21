Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864AE3B05AB
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298399; cv=none; b=e/RbXtRwE+n2py55p48KqYPm2yDbw4MQh52YvEQCQiwkyLPfRyH5NlgWMpfdIgQGZbNp44ROXuDoOzQk5VedtFjW0Xf8AsW1aNk7C8G61lS7lF5Um0jGq/URAQ+obZZVgR+P+xmmaSxfQrXkdVxgx/C6EHrAsPTeLjRH+IuY3eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298399; c=relaxed/simple;
	bh=Xbj9EAV0oSwYI4uKu+j+qEHBrmdYREK1rWVIu5IwgbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwxz7XZChT8BEhjbDxHnEY1WuLRd3y/jHTUtcR2w+1vRzLKwa6q3JmVmrZnVFibwzQMeD6tqt9N0cN4Irk0MXSKmMO64juV1KVvd2jS9kkJoVY4qeU8T/2z+TEpds7h4yh0hiNVrZPT/R9UWHTHO/SWLaWlvEnUIEWKEQ6EnyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BqBo7Yo3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a9wbaAzR; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BqBo7Yo3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a9wbaAzR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 90A8514001CB;
	Fri, 21 Aug 2026 03:46:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 21 Aug 2026 03:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787298393;
	 x=1787384793; bh=Jci4WOozCp9qqM9s4Qin4CgTSmkHi1B8bipzzT14ZzE=; b=
	BqBo7Yo3oxjLht1XyR2/Tv+Mf3jNup4NHXI8pG9HFuH0roH2tqRPGiMy1q/3myhS
	ZCuRQbtf6E9gXPrl1dYXVRetQZ/ShLYVxWYjEgZlM/e+LneWpQQ2YCg0S6YO5foU
	FBXpA6ZL40/zEVTUDdCXyrrWj08tqnWHTlMP0fDuDqUaj5T66GcY9d7VzGRxMSCW
	yQpRfKbk0RlbWQPPh5gryITfTcLlyyISPUsNaD76U80ZckXZ77JEODw48PCqWVIy
	PDmACeZJVLs60ElFJjj2/bDfaEtJ0WGeSm6IoF8et4FjudBRkcWnK3GEd41on1r7
	d0JhEMLXZz6xyiDWtqt/Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787298393; x=
	1787384793; bh=Jci4WOozCp9qqM9s4Qin4CgTSmkHi1B8bipzzT14ZzE=; b=a
	9wbaAzRiXMOKDuaBQfwrtvhR2j2F5hhDbXqipT9LjAqCypqIpjU1HwKqqISgk2TY
	bC/zbXiEbsxMN3ttWsId9NxqNxdnhmnV3h93CmPJVSR//9QdtwLpcoy91vd5B3W4
	VQMLuOMwJlmTePFixmW+Ev/2y3upT6r/JG+UQ/ScdJzz4yonM2mj0pmR5I1omJ1u
	xBQxKcNueF+Hj12dkuHb/HY3HuLNhpgQSMrPRSlnqE6ZL2ZDbfGTEML/yceAGXnp
	/fewi1Ga53IiDOjlR+jR4NEPL7C64tQ0PbhVsfbD86HhoMymbMCc0oJ6w5OPdBmy
	xVjwrGTCMk5PdrdVUKCgQ==
X-ME-Sender: <xms:WQKIalCKkexspeNt1TnBU-oFhOwHneBRWt3yLM8xYmvrb2vvIkLN_Q>
    <xme:WQKIaq-7zQ_DCK3XWfzenJPcEWdUiefdgHDOHtdhmHl4hIhzua-UR56jI0tFx5vTe
    pkePzvJg8R8XqxBxPZtxzqIh4DP0-4-x2ifygO9_efiY0o7sLoDBNc>
X-ME-Received: <xmr:WQKIat8rCo3wvARftXqzW2jCHmFQUJbgosjlzM7xJFin_erJZzpQCVbVAIqsWFyQEjJOy_8ecaVdF_2iRdqSg7YD3aAnliJ2olQnaOlyr4U4>
X-ME-Proxy-Cause: dmFkZTE+9Q812+P28Nm1LdlgUs77SaDAieOpkP+KnyVbxMAs1+3NvYwJrU7Q4t4VisRQmT
    41DZfcUVx0bY7x1URPMUexqpYpCDVuLDeXdZgQF2lW6EhKRcS/IrYGmAYc80b1ggdyAnox
    q6vt8NqAT7PomNSXvNwmt1Ln8iobVRTreXNOSZdwMjKo3jllrrNP4QfzDMKdT9UqCvHGHO
    ZGH7htVw3DwAN+CW5p3h+aCGJgQZ2VZt4B3X6ldusE4WaOCPsEaIvR0I4Eu5HrrJg1QgWK
    Gn//kwW88obP7OIcdGXN9IvU29ReTBTw4UzUVoYmiOHG9p1ERcJhtqJ8lz/DwLQ7kYw4eD
    85vEXcpQFH9+/OeaEF8p6fgdXH+fN0kq6N0I5642YT9iWrGtkrXoFahaotMaddDCwavQPh
    OGji2TEOp8j5EAlUCs2Faklp+JbDCAwkjbmrfei9IihC/wbICucCn+da26OS8whvDa0/+w
    iKJghcIx3wv9Z3hWmHo8+/6B2GQBZl8XSGKLnYc14AmR5z39sAb6ocIgFne6SjuOVbYfX6
    FBpWW6iEQTLSZTQeBZIFYsv6ZplGDJpVQV+n/RU3WWUDBsjSPSWSNipKHKROSa8iclWYOG
    SpleDcjrawXlCeMdKlGeRLGGDGl2Sxgm9Zlbyu1ttekBSxcM6B3zpTUObk3w
X-ME-Proxy: <xmx:WQKIapeLHe080ydDAf4KQkuvptc4cYXGlJ4EeLAjXp5A0ll0ut62AA>
    <xmx:WQKIauGUk4wcNngBmhiEwXPUdeWID62dGwtUts-Vv1nfzDh2bSqXdg>
    <xmx:WQKIavcKltoVsoSPEWiy4JUeAMG7xEQZ4KnlSRNJE1Juwzy89lYRBQ>
    <xmx:WQKIagGfQ5vZOX4IxKswy9YjK0n1Mq371JI8xqKj_bpeF1L2akwrYw>
    <xmx:WQKIaq82Cn8vRvAvhA0rKYPQ9nIBtAUupxk6Hh6GsigrffxRMTxJg109>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 03:46:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44629ff6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 07:46:30 +0000 (UTC)
Date: Fri, 21 Aug 2026 09:46:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 5/6] bundle: get (mostly) rid of `the_repository`
Message-ID: <aogCTy4-DYYhS-VK@pks.im>
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
 <20260817-b4-pks-odb-generate-pack-v2-5-4c8a96ccfdb3@pks.im>
 <xmqqik5866di.fsf@gitster.g>
 <aoPtDyISRa0mVXRa@pks.im>
 <CABPp-BE63m2sB4-18JUiYDK+UXaCq9z_=A8JAutvjn155_HWZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BE63m2sB4-18JUiYDK+UXaCq9z_=A8JAutvjn155_HWZA@mail.gmail.com>

On Thu, Aug 20, 2026 at 10:42:49PM -0700, Elijah Newren wrote:
> On Mon, Aug 17, 2026 at 10:26 PM Patrick Steinhardt <ps@pks.im> wrote:
> > On Mon, Aug 17, 2026 at 09:47:53AM -0700, Junio C Hamano wrote:
> > > Patrick Steinhardt <ps@pks.im> writes:
> > > > diff --git a/bundle.c b/bundle.c
> > > > index b64716f252..a9330bf0d3 100644
> > > > --- a/bundle.c
> > > > +++ b/bundle.c
> > > > @@ -1,4 +1,3 @@
> > > > -#define USE_THE_REPOSITORY_VARIABLE
> > > >  #define DISABLE_SIGN_COMPARE_WARNINGS
> > > >
> > > >  #include "git-compat-util.h"
> > > > @@ -21,6 +20,13 @@
> > > >  #include "connected.h"
> > > >  #include "write-or-die.h"
> > > >
> > > > +/*
> > > > + * NEEDSWORK: this function implicitly depends on `the_repository` and is not
> > > > + * available because we dropped USE_THE_REPOSITORY_VARIABLE. We can remove the
> > > > + * declaration once it's accessible via `repo_config_values`.
> > > > + */
> > > > +extern const char *get_log_output_encoding(void);
> > > > +
> > >
> > > Doesn't this defeat the whole "drop #define USE_THE_REPOSITORY_VARIABLE
> > > as a mark that we are done with this file and no longer need to
> > > worry about it going forward because we won't be able to compile if
> > > somebody adds a new use?" premise?
> >
> > Yes and no. By removing the define early it allows us to not reintroduce
> > new references to `the_repository` by accident, but carve out a single
> > exception for one of the functions that still depends on it. The
> > alternative would be to not do that, and if so there is no guarantee
> > whatsoever that we won't introduce more references to `the_repository`
> > in this file.
> >
> > So I'm still leaning towards keeping this as-is, but I don't feel very
> > strongly about this. Let me know in case that argument doesn't sway you
> > and I'll adapt.
> 
> Would it make more sense to do this the way replay.c does:
> 
> #define USE_THE_REPOSITORY_VARIABLE
> <a bunch of includes>
> /*
>  * We technically need USE_THE_REPOSITORY_VARIABLE for <X>, but
>  * do not want to use the_repository.
>  */
> #define the_repository DO_NOT_USE_THE_REPOSITORY
> 
> and remove the declaration of get_log_output_encoding() that you
> added?  Alternatively, should replay.c be adapted to the way you are
> doing it here?

The benefit of removing `USE_THE_REPOSITORY_VARIABLE` completely over
stubbing out `the_repository` is that it will also remove a couple of
function declarations that implicitly rely on `the_repository`, like for
example `get_log_output_encoding()`. So I think it's a slightly better
mechainsm over redefining `the_repository`.

Patrick
