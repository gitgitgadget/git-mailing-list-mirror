Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F1931FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 17:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbcGSREk (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 13:04:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753153AbcGSREi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 13:04:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 512312B08F;
	Tue, 19 Jul 2016 13:04:37 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DIrRAhgfrcLDV3FIFmvFm6+85Cc=; b=B1MLdp
	VXsV1dk3TMgu3zztg2xfB5eROTSdvTwJTHXNqnvw1m4cM17Jr/JUZyr2XE/kV7sM
	Liik6SaEyspv0HK1H9Rc7ZN0h2nmca5RwhaUoN+DSVP04fHqYmcPomWaNKr1FS6e
	Hi4mW1l/nkFkRCtq4Kp4LnpzMILi9sVTSCCyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HUIB14BxS8He3xrroNyWa+fT5h4K5rOu
	m9gfFWWoPmTMBy93JSNkmXhB1NF7MuPsYj4YSx5H7vdWXjGbZDO3Y915vJRhRvCj
	57dVyZh3SAkigre/L2xn0IBj1UiaFcOlU50m2iXp1ziBERlvZCtPMODoNOP7xBK4
	bk+FvEhy0iA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 49BB42B08E;
	Tue, 19 Jul 2016 13:04:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7C062B08C;
	Tue, 19 Jul 2016 13:04:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Shawn Pearce <spearce@spearce.org>
Cc:	Parker Moore <parkrmoore@gmail.com>, Jeff King <peff@peff.net>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
Subject: Re: [PATCH] contrib/persistent-https: update ldflags syntax for Go 1.7+
References: <CAOiOGAcqsdMD0j_ZUdvvGiA9Bd6bUmfvxziN06Rw81f_pO7cgg@mail.gmail.com>
	<20160716051800.GA2845@sigill.intra.peff.net>
	<xmqqfur6isyr.fsf@gitster.mtv.corp.google.com>
	<CAOiOGAfysmjBxcK-VwscLWBdun4rNsRs85p=foBxETvQw0J1Jw@mail.gmail.com>
	<CAJo=hJviMd3tWe_HUmh0M0Y2TOCwwrZX14hdyivPSYQ1ck052w@mail.gmail.com>
Date:	Tue, 19 Jul 2016 10:04:34 -0700
In-Reply-To: <CAJo=hJviMd3tWe_HUmh0M0Y2TOCwwrZX14hdyivPSYQ1ck052w@mail.gmail.com>
	(Shawn Pearce's message of "Mon, 18 Jul 2016 21:49:15 -0700")
Message-ID: <xmqqoa5th84d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF6C957A-4DD2-11E6-B487-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> On Mon, Jul 18, 2016 at 9:32 PM, Parker Moore <parkrmoore@gmail.com> wrote:
>>> The label does not even identify the version of the source in any way, so I am not sure how people are depending on that feature anyway ;-)
>>
>> Would it be a better solution simply to remove this build flag?
>> Alternatively, if Git wished to support Go v1.5 and below, I would be
>> more than happy to send a patch with a dynamic lookup in the Makefile
>> based on the output of `go version`. I would be more than happy to
>> submit either patch.
>
> I think we could remove that BUILD_LABEL entirely. Colby liked having
> a marker so he knows what "version" a user is running, but without any
> correlation to source here it just isn't that useful.

Inside an organization where people use it as a tool supplied by
somebody else, who is the designated supplier of it, build-stamp may
be sufficient to identify what "version" a user is running.  If we
wanted to do a "here is the source that was built from", the logical
place to pull that information from would be ../../GIT-VERSION-FILE,
but the mechanism to embed the information would still be -X var=val
(or "-X var val" for older Go).

So unless the "dynamic lookup in the Makefile" turns out to be too
gross, we would want to keep the mechanism and just make it usable
for versions before 1.5 and also after 1.7, I would guess.
