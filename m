Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526C11F404
	for <e@80x24.org>; Tue, 13 Mar 2018 21:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeCMVt3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 17:49:29 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:47035 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeCMVt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 17:49:28 -0400
Received: by mail-pg0-f52.google.com with SMTP id r26so451662pgv.13
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rXw/dE0bfj8fwirinwvPYTSleTEL4InFvn13r26EEGE=;
        b=LG98evH0AttmYhr9DGNF8ZyROuOf4YRy3cSsWtEM6IudaR2j9/ELWBWk7P4zBoqeln
         DDWnN1Y+/WtZTpJ4X+ft/4+bxx/6lQFbmqrzC+N/ZCYNpxnrk3LfR8TAnWfD9G7qWpkq
         8DVpTND3ox0tCWFse57E1Ei8o4X1n8Vw0WLM0kUPVawPS6toZagHvrqmSnSEbu+8tfDd
         nWP6Cey0epZTTBBJndMqFu/2kDHWnQ9dSY3gySR64oV4A1dShl0cZKrgq1tWa0qXSILP
         ojI2F0Fan7UOdhgCe6m0EPTsAHHo/oHkp499g5DsaN34BKbJJ5DeHOyy17yO0XBV0tGE
         /GjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rXw/dE0bfj8fwirinwvPYTSleTEL4InFvn13r26EEGE=;
        b=Im+cDQaQXv7lQti05XEZBkw/4lOy1tcG5BqOwICTpMegL/vtSeQ52XUTtqzzmODjM8
         3cjsyop6AV4x6Jd4RNbXOiCvpUf7/MCA08Pr+URhzpOsoIAk1XcFrbeSUhOiqN6QKD7/
         QSNL5O4i6nPfzyWWsDMTtFFtTyIiCZ69kRMTjZN+127tSNNNZv3fN2SgSXmu8E5m+tRI
         dJGZPjPC0hwbnVKOWcNGmaZ/GDSTjdYMr+KhpmEaE0CsqPWcJWcfbRrw8cP/v8ABJJOL
         IBUi8PkYCLrMcRBip2G9yHYR38/ULJ19RXQkxHCncEnps5M4YetCAfaXcvZmdRenxLHs
         4UAg==
X-Gm-Message-State: AElRT7EIzfdR6yJysJ8uvmYAHA2/oJ3LUYsQR/+pWOB1QquM2JXxx/kr
        CdJY+q4OBCWyGl7TIMdfh3IbA6/bgjE=
X-Google-Smtp-Source: AG47ELtMqiVh8exsHE5F5P682TeI2rDp7M2T7dQVjtCoYO5SHOK5iZ1/FjGKpJdwPIiWsuWg/8/MLA==
X-Received: by 10.99.113.94 with SMTP id b30mr1690735pgn.196.1520977767211;
        Tue, 13 Mar 2018 14:49:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id n14sm1992715pfj.154.2018.03.13.14.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 14:49:26 -0700 (PDT)
Date:   Tue, 13 Mar 2018 14:49:25 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 20/35] upload-pack: introduce fetch server command
Message-ID: <20180313214925.GG7638@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-21-bmwill@google.com>
 <20180313092003.109ce9254b376e7fdce338b0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313092003.109ce9254b376e7fdce338b0@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/13, Jonathan Tan wrote:
> On Wed, 28 Feb 2018 15:22:37 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > +    output = *section
> > +    section = (acknowledgments | packfile)
> > +	      (flush-pkt | delim-pkt)
> > +
> > +    acknowledgments = PKT-LINE("acknowledgments" LF)
> > +		      (nak | *ack)
> > +		      (ready)
> > +    ready = PKT-LINE("ready" LF)
> > +    nak = PKT-LINE("NAK" LF)
> > +    ack = PKT-LINE("ACK" SP obj-id LF)
> > +
> > +    packfile = PKT-LINE("packfile" LF)
> > +	       [PACKFILE]
> 
> I should have noticed this earlier, but "PACKFILE" is not defined anywhere -
> it's probably better written as:
> 
>     *PKT-LINE(%x01-03 *%x00-ff)"
> 
> or something like that.

I'll document it as you described.

> 
> > +    acknowledgments section
> > +	* Always begins with the section header "acknowledgments"
> > +
> > +	* The server will respond with "NAK" if none of the object ids sent
> > +	  as have lines were common.
> > +
> > +	* The server will respond with "ACK obj-id" for all of the
> > +	  object ids sent as have lines which are common.
> > +
> > +	* A response cannot have both "ACK" lines as well as a "NAK"
> > +	  line.
> > +
> > +	* The server will respond with a "ready" line indicating that
> > +	  the server has found an acceptable common base and is ready to
> > +	  make and send a packfile (which will be found in the packfile
> > +	  section of the same response)
> > +
> > +	* If the client determines that it is finished with negotiations
> > +	  by sending a "done" line, the acknowledgments sections MUST be
> > +	  omitted from the server's response.
> > +
> > +	* If the server has found a suitable cut point and has decided
> > +	  to send a "ready" line, then the server can decide to (as an
> > +	  optimization) omit any "ACK" lines it would have sent during
> > +	  its response.  This is because the server will have already
> > +	  determined the objects it plans to send to the client and no
> > +	  further negotiation is needed.
> > +
> > +----
> > +    packfile section
> > +	* Always begins with the section header "packfile"
> > +
> > +	* The transmission of the packfile begins immediately after the
> > +	  section header
> > +
> > +	* The data transfer of the packfile is always multiplexed, using
> > +	  the same semantics of the 'side-band-64k' capability from
> > +	  protocol version 1.  This means that each packet, during the
> > +	  packfile data stream, is made up of a leading 4-byte pkt-line
> > +	  length (typical of the pkt-line format), followed by a 1-byte
> > +	  stream code, followed by the actual data.
> > +
> > +	  The stream code can be one of:
> > +		1 - pack data
> > +		2 - progress messages
> > +		3 - fatal error message just before stream aborts
> > +
> > +	* This section is only included if the client has sent 'want'
> > +	  lines in its request and either requested that no more
> > +	  negotiation be done by sending 'done' or if the server has
> > +	  decided it has found a sufficient cut point to produce a
> > +	  packfile.
> 
> For both the sections, I think that the conditions for
> inclusion/non-inclusion ("This section is only included if...") should
> be the first point.
> 
> > +static void upload_pack_data_init(struct upload_pack_data *data)
> > +{
> > +	struct object_array wants = OBJECT_ARRAY_INIT;
> > +	struct oid_array haves = OID_ARRAY_INIT;
> > +
> > +	memset(data, 0, sizeof(*data));
> > +	data->wants = wants;
> > +	data->haves = haves;
> > +}
> 
> Any reason to use a initializer function instead of a static literal?

Its much cleaner and easier to read than it was when i was using an
initializer.

-- 
Brandon Williams
