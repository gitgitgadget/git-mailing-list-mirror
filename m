Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B1D1F463
	for <e@80x24.org>; Tue, 10 Sep 2019 12:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfIJMJG (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 08:09:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44139 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfIJMJG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 08:09:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id k6so7554803wrn.11
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 05:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aG9wWHHM0hFjteFmiJz14453HW38Wq/7jDrImKxh53Q=;
        b=GtI2aVE+SEPSWVKVlYnmIpDhL20bwpfLIhMEC13xo/Yo5/Wbf6Da6XdOHXt3WbxtcZ
         1kJHsdn+Q2wMcGBBM1TSJBc6dNCm5Cl8pXHFhnm4b01pRF58JHo3Rj7kPoPYAwWRbMe/
         KwQ4K+uIFX7Ojsn2ym8XsoT02W75d9yRc5cdJIrUgCQYqrvLjDHIAhk65uf4WsbqxBT8
         WQ4kcxscoU6WHq2ihCsRSmh2ux2+Sl1A2NjOnoSFsNtnsBT5l7bIFI0i1s0rAeJc8s+S
         O9eE/bDDTylqRXtup3g9VQoNwXteA18YbEWlX5xpuKhuKwQpvFu9pIhfnNdJMp6CzdQg
         VBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aG9wWHHM0hFjteFmiJz14453HW38Wq/7jDrImKxh53Q=;
        b=bqJ9z2bu13FGz9EkPQqXzkK9mUiBjkCoB0ZBlEiZF75SSjRh+zCAalfxJxXZWfpApI
         j/zyFIN0ASXB/C9mud4PS6SlupHZh44vxa3UhyzFDfXKy0uLdy5Py1Y6z5yhHGmvS9V9
         H6cxnGUGcqYACJtyAfe61q1NG/HFNiGZLgzrRIgJjZ+5j8I8WCJ/JvBB3+MISBCFvVVz
         GtFo6l2vkXyrYo146qgvF75EWfXtTt+PTXIDCqBGkt/WLSsFfcJk5Cq4aIyVZs3JYcRd
         F/MXYIhKv3PxSqozQKamEXSaHW8GMIi7pwvjzjcX37eOcVLzMvmO4oXI6z7kMe9ie1d4
         IyUg==
X-Gm-Message-State: APjAAAU1vvOo8T05U4kqiM1LQy9m5QNq3meXOvqyJ5GjUkJViLvwmser
        Fu8RGu/l/26la/kxV6t+lbw=
X-Google-Smtp-Source: APXvYqw5iUQ53DwXC2197blv08hIay9yzR+gO8vbvQp9Ed+xrW8Wf6Hbd3uSeQbUagmtOqSJfO7rHg==
X-Received: by 2002:adf:dbc6:: with SMTP id e6mr9610240wrj.149.1568117343126;
        Tue, 10 Sep 2019 05:09:03 -0700 (PDT)
Received: from szeder.dev (x4dbe1e6e.dyn.telefonica.de. [77.190.30.110])
        by smtp.gmail.com with ESMTPSA id u22sm33745355wru.72.2019.09.10.05.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 05:09:02 -0700 (PDT)
Date:   Tue, 10 Sep 2019 14:08:59 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] upload-pack: fix race condition in error messages
Message-ID: <20190910120859.GG32087@szeder.dev>
References: <20190828153944.GA29715@sigill.intra.peff.net>
 <20190828161552.GE8571@szeder.dev>
 <4d5773f9-4637-d8a3-d683-82624950f319@gmail.com>
 <20190829141307.GE1797@sigill.intra.peff.net>
 <131dfa37-0f65-f0c3-6f30-5b6eca12d9c0@gmail.com>
 <20190829143805.GB1746@sigill.intra.peff.net>
 <20190829215818.GG8571@szeder.dev>
 <20190829220630.GH8571@szeder.dev>
 <20190830121005.GI8571@szeder.dev>
 <20190904050441.GB6488@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904050441.GB6488@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 04, 2019 at 01:04:42AM -0400, Jeff King wrote:
> On Fri, Aug 30, 2019 at 02:10:05PM +0200, SZEDER Gábor wrote:
> 
> > On Fri, Aug 30, 2019 at 12:06:30AM +0200, SZEDER Gábor wrote:
> > > On Thu, Aug 29, 2019 at 11:58:18PM +0200, SZEDER Gábor wrote:
> > > > On Thu, Aug 29, 2019 at 10:38:05AM -0400, Jeff King wrote:
> > > > > So any fixes there have to happen on the client side. I am still
> > > > > confused about why the client is writing in this case, per the argument
> > > > > in 014ade7484 (upload-pack: send ERR packet for non-tip objects,
> > > > > 2019-04-13). It would be nice to use GIT_TRACE_PACKET to see what it's
> > > > > trying to write, but I still haven't been able to reproduce the issue.
> > > > 
> > > > It's the "done" line:
> > > > 
> > > >   + cat trace-packet
> > [...]
> > > >   packet:  upload-pack> 0000
> > > >   packet:        fetch> done
> > > > 
> > > > In the avarage successful run that "fetch> done" pkt-line is
> > > > immediately after the "fetch> 0000".
> 
> Thanks for all of your persistent digging on this.

Yeah, I can be easily distracted by an interesting looking bug... was
told it's a character flaw ;)

> I had forgotten about
> the "done" packet, but it explains all of the symptoms we've seen.
> 
> > So instead of immediately die()int after write_in_full() returned an
> > error, fetch should first try to read all incoming packets in the hope
> > that the remote did send an ERR packet before it died, and then die
> > with the error in that packet, or fall back to the current generic
> > error message if there is no ERR packet (e.g. remote segfaulted or
> > something similarly horrible).  This fixes the test failure with that
> > strategically-placed sleep() in 'fetch-pack.c'.
> > 
> >   https://travis-ci.org/szeder/git/jobs/578778749#L2689
> > 
> > Alas, passing a 'reader' to a function called send_request() doesn't
> > look quite right, does it...  And I'm not sure about the stateless
> > communication, it still uses write_or_die().
> 
> And thank you for putting this patch together. I had taken a stab at it
> a while ago, but got discouraged by figuring out at which layer to add
> the "reader" info (I had envisioned it much lower in packet_write(), but
> it is clear from your patch that fetch-pack does most of its own
> writing).
> 
> I agree passing around the reader is a bit weird;

I considered renaming send_request() so that 'reader' won't look that
out of place among its parameters, but all my ideas were ridiculous,
e.g. send_request_and_process_ERR_pkt_on_error()...

> I wonder if we should
> be representing the full-duplex connection more clearly as a single
> struct. But I suspect that creates other headaches, and what you have
> here doesn't look _too_ bad. As you note, it probably doesn't cover all
> code paths, but it at least fixes some of them, and gives us a template
> for addressing the others.
> 
> >  	} else {
> > -		if (write_in_full(fd, buf->buf, buf->len) < 0)
> > +		if (write_in_full(fd, buf->buf, buf->len) < 0) {
> > +			int save_errno = errno;
> > +			/*
> > +			 * Read everything the remote has sent to us.
> > +			 * If there is an ERR packet, then the loop die()s
> > +			 * with the received error message.
> > +			 * If we reach EOF without seeing an ERR, then die()
> > +			 * with a generic error message, most likely "Broken
> > +			 * pipe".
> > +			 */
> > +			while (packet_reader_read(reader) != PACKET_READ_EOF);
> > +			errno = save_errno;
> >  			die_errno(_("unable to write to remote"));
> > +		}
> 
> One unfortunate thing here is that we could block indefinitely in
> packet_reader_read(). That shouldn't happen, I don't think, but since
> this is an error case where we've been cutoff, anything's possible.

Yeah, when we use different file descriptors for reading and writing,
then any error on the writing fd doesn't necessarily mean that there
is on an error on the reading fd as well.  I mean, we could get an
EBADF or EFAULT as well, but those would rather indicate a bug in Git
than an error with the connection itself.

I wondered whether we could avoid blocking indefinitely by looking for
an ERR packet only if the write() resulted in ECONNRESET or EPIPE,
i.e. that indicate a connection error.  I suppose 'git upload-pack'
(or an alternative implementation) could be buggy and could
inadvertently close() the other end of the fd that fetch-pack writes
to but not the fd where it reads from, so the write() would get
ECONNRESET, but then packet_reader_read() could still hang on the
still open read fd.  I'm not sure whether it's worth worrying about; I
mean a buggy 'git upload-pack' can do all kinds of weird things that
would lead to a hang.

Anyway, after write_in_full() returns with error we could first print
an error message with error_errno() and then go on to look for an ERR
packet.  So even if packet_reader_read() hangs, at least there will be
an error message for the user to see.  It wouldn't help automation,
though.

> We maybe could get away with using non-blocking I/O. We're looking for
> an ERR packet the other side sent us _before_ it hung up, so in theory
> we've have received the data before any FIN packet (or EOF on a pipe).
> But I'm wary of introducing new races there.
> 
> It might be enough to put in an actual timer, waiting for an ERR packet,
> EOF, or something like 5 seconds. Or maybe I'm just being overly
> paranoid.

I think the timeout would be the safest bet, but then we would have to
pass that timeout parameter through a couple of a function calls...

