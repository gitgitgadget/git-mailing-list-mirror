Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88DF1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 18:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbfAOSgs (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 13:36:48 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:59723 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfAOSgs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 13:36:48 -0500
Received: by mail-it1-f202.google.com with SMTP id t143so3299528itc.9
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 10:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=icrRbYxZvb7kVZItBTkN7Wcifcil+ozK0kgwKm6HNYk=;
        b=rb1IuBSWmEluT6vf+9hP0cZAcfvW98TY40NGrzgo05Deqnr5qTdDLDK4efYTplUxib
         TXfUIRn+QVjKLOBmOGA5u5p4h+yY6VWg/gGLl61MB1BgpGLOuatnJCkVpDamqNb/uvA4
         4hlqITWW4LbrLLAgSIp+2Fvd7CV/a3l1FsPLLgRcJMOG2oUVuRKeMK1dcrfXZJDkIkWh
         bFBWEF1w3WWSPRdkQk1kEM3DN5Dcx2+oZMbSZNMSTRajZOCzma9ze2EYGSi3yeERaPKj
         m5+pgHwTJI0WPGbJlle/SaGqmUDoK1BbGAY7LqSWyH3kqgVrAYvsTu8LIVT602/6vYhH
         HYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=icrRbYxZvb7kVZItBTkN7Wcifcil+ozK0kgwKm6HNYk=;
        b=O14wGMK6jITI/fxlnCE14F4YCFk9L1FdrgQc1bIp3tcKVukymPEWTsa7aVqFINYuCZ
         I+untrpnNvVGoXuZyeFcUn0i/q7E6I9Ht9mgtxJuhzD9dZDsXUUbX207611DbB43b+Pz
         hzLnBj/+JmpYO2qlEKT0NMyLRfnPnt/cg3PiR1FD3h8tzxA4eX+y4lRCVx4Hvb5Px3Nc
         kSrNznLJouwMH/tpwYCmGJ69Ot5Cdkk798xeKb3/a1DmGP0OcoCUp0gsuH48dR5ZaFm9
         ZRDz0t9xIGdVa7sUeC0zTYeWVQBP2XqfcQ2G9nQuyrQvRlGeQaITq/h+fMHhb/6mswil
         ZF5Q==
X-Gm-Message-State: AJcUukeknBd8gNrCTwz7ZtNORN536v7F+e+DQ+esJICswJWPV0cNKCJN
        C8Oijvr127XCwz1Sl52f4H1kbQs4X3KVdTLoCXGf
X-Google-Smtp-Source: ALg8bN6Kpy5JSLEEtDQleW5Ii393wLksYYkIRgMp5hzBBe+SJ9ngOUXiR8DHm2IRacY+Rv9NyCrZFRAgK/M7vccYDVO4
X-Received: by 2002:a05:660c:4e:: with SMTP id p14mr3207808itk.31.1547577406771;
 Tue, 15 Jan 2019 10:36:46 -0800 (PST)
Date:   Tue, 15 Jan 2019 10:36:42 -0800
In-Reply-To: <xmqq4labuho5.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190115183642.253201-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq4labuho5.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 2/4] sideband: reverse its dependency on pkt-line
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > +int recv_sideband(const char *me, int in_stream, int out)
> > +{
> > +	char buf[LARGE_PACKET_MAX + 1];
> > +	int retval = 0;
> > +	int len;
> > +
> > +	while (1) {
> > +		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
> > +		retval = diagnose_sideband(me, buf, len);
> 
> This name of the helper does not convey much useful information.
> Let's think about it more later.

OK - after reading the later comments, switched to demultiplex_sideband.

> > +		switch (retval) {
> > +			case SIDEBAND_PRIMARY:
> 
> Dedent; case/default arms align with 's' in switch in our codebase.

Done.

> > +				break;
> > +			default: /* flush or error */
> > +				return retval;
> 
> Lack of corresponding comment bothers readers.  In all of
> REMOTE_ERROR, PROGRESS and PROTOCOL_ERROR cases, the other helper
> stuffs the message in outbuf in "switch (band) { ... }" and writes
> it out with xwrite(2, outbuf.buf, outbuf.len) [*1*], so I can see
> there is no need for us to write anything out here.  Perhaps
> 
> 		case SIDEBAND_FLUSH:
> 		default: /* errors: message already written */
> 			return retval;
> 
> or something to clarify?

Done.

> > +/*
> > + * Receive multiplexed output stream over git native protocol.
> > + * in_stream is the input stream from the remote, which carries data
> > + * in pkt_line format with band designator.  Demultiplex it into out
> > + * and err and return error appropriately.  Band #1 carries the
> > + * primary payload.  Things coming over band #2 is not necessarily
> > + * error; they are usually informative message on the standard error
> > + * stream, aka "verbose").  A message over band #3 is a signal that
> > + * the remote died unexpectedly.  A flush() concludes the stream.
> > + *
> > + * Returns SIDEBAND_FLUSH upon a normal conclusion, and SIDEBAND_PROTOCOL_ERROR
> > + * or SIDEBAND_REMOTE_ERROR if an error occurred.
> > + */
> > +int recv_sideband(const char *me, int in_stream, int out);
> 
> This is well described.

Thanks, although the credit should be given to the original author - most of
this was moved.

> > diff --git a/sideband.c b/sideband.c
> > index 368647acf8..842a92e975 100644
> > --- a/sideband.c
> > +++ b/sideband.c
> > ...
> > +int diagnose_sideband(const char *me, char *buf, int len)
> >  {
> > +	static const char *suffix;
> >  	struct strbuf outbuf = STRBUF_INIT;
> >  	int retval = 0;
> > +	const char *b, *brk;
> > +	int band;
> > +
> > +	if (!suffix) {
> > +		if (isatty(2) && !is_terminal_dumb())
> > +			suffix = ANSI_SUFFIX;
> > +		else
> > +			suffix = DUMB_SUFFIX;
> > +	}
> 
> It may be worth considering a further clean-up for the progress
> code, that consumes lines in the "switch(band)" below that are
> disproportionate to what it does in this function by introducing
> another helper function that is called from here.  When it happens,
> the above "suffix" thing should move to the helper function, too.

That's reasonable. If it's OK, I would like to limit the scope of this
patch to splitting the existing recv_sideband() into recv_sideband() and
demultiplex_sideband() (the latter is quite close to the old
recv_sideband(), and the diff looks larger only because most of it is a
dedent).

> So, the point of this helper is to inspect a single packet-line data
> and dispatch the payload of the packet based on which band it is
> sent to.  Perhaps call it with a name with demultiplex or dispatch
> in it?  "diagnose" is a bit unclear in that what trait you are
> diagnosing and for what purpose.

Changed to demultiplex_sideband.

> > +/*
> > + * buf and len should be the result of reading a line from a remote sending
> > + * multiplexed data.
> > + *
> > + * Determines the nature of the result and returns it. If
> 
> "the result" may be from the point of view of the implementor or the
> "recv_sideband()" function who called packet_read(), but a casual
> reader would perceive it more natural if you referred it as "a
> packet read from a remote".  "Inspect a packet read from the remote
> and returns which sideband it is for", perhaps?

Done.
