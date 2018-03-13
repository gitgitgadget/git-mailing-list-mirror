Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C48821F404
	for <e@80x24.org>; Tue, 13 Mar 2018 16:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933875AbeCMQUJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 12:20:09 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:47085 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeCMQUG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 12:20:06 -0400
Received: by mail-pf0-f171.google.com with SMTP id z10so59857pfh.13
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/34f0syhBVpgJtOLKnUSfVc1+oQUeA23C3jUY+Hs/k=;
        b=mAG8mpZNv2/JGSVHcNa45DC7kIHZDEvs2/ev8x13uJzRA58s+kmGBrzsnBnP5nh4ly
         4aO6hUPLEYuS4fCmGoMXBJ2/Ec0yVJsj9uT7/qxanSDy61sN8nkLY/yHkSwWSoWOm1j8
         adHItXerEB3GxzppfMdQMma1b16aLRnwwRDEVnwkPgnH2QKhBSjGmfAVmEOoLJ3UKjK3
         T5sN7x3EBti/HVuxqFD/brFfbYoUIJNEm1ZV+cMJ5tq3mQzqDDwIeLYcp/xF7S3rNAV+
         J1yoBbbgbumGw6sG4YUbcbiIqcgqAeafARyRtcSbpDrFaSTH2v4U9ho5IJm3Kh3lJTIO
         XUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/34f0syhBVpgJtOLKnUSfVc1+oQUeA23C3jUY+Hs/k=;
        b=AVaL9Qk8Eu6UPX5oj8jhcZv19bh73cGfYc9QTU8VU0WvNv8WqfymFk2v4kLCwO4MvR
         XiZDm1w+nYSufJ7nNhUJD07ljAtAL03YlNHaemT7UGux9U6jrk3ZXLM2IxwNn6UQbC83
         qwszbtm7rjbGAgTWg1rVjyh/XPHGCoWm0tJqMbvfxfVIttLDD0aaKM67VeDy1P1QGBF3
         4wMF61F885os1WzSscCEdE027N8N09dygTUza0LeDYG549zCICv7uFZQlrAyGR78a0E8
         1n2iaAf4hJXC2Y4/edC9ESFNBBsyLDQF43e30ThdZ8IKJMaBTxSc0J9rnSVGPy/jIsho
         L3Jg==
X-Gm-Message-State: AElRT7Eh10LWFmFVXHPjrthalIa9fGDYBuERqVBDGUk93gmH/TLNhDgY
        Zu9AoWPYK5R/wPaEPMDsaqIN8Q==
X-Google-Smtp-Source: AG47ELsE0aoZM/LUtKzhY2zTgr7bk5bqPBS0g88V8QwcFTmBXoBUr9wM5DKzsk3Z4PDFLUcAq55iww==
X-Received: by 10.99.100.6 with SMTP id y6mr956559pgb.254.1520958005848;
        Tue, 13 Mar 2018 09:20:05 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id z7sm906279pgp.55.2018.03.13.09.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 09:20:04 -0700 (PDT)
Date:   Tue, 13 Mar 2018 09:20:03 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 20/35] upload-pack: introduce fetch server command
Message-Id: <20180313092003.109ce9254b376e7fdce338b0@google.com>
In-Reply-To: <20180228232252.102167-21-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-21-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Feb 2018 15:22:37 -0800
Brandon Williams <bmwill@google.com> wrote:

> +    output = *section
> +    section = (acknowledgments | packfile)
> +	      (flush-pkt | delim-pkt)
> +
> +    acknowledgments = PKT-LINE("acknowledgments" LF)
> +		      (nak | *ack)
> +		      (ready)
> +    ready = PKT-LINE("ready" LF)
> +    nak = PKT-LINE("NAK" LF)
> +    ack = PKT-LINE("ACK" SP obj-id LF)
> +
> +    packfile = PKT-LINE("packfile" LF)
> +	       [PACKFILE]

I should have noticed this earlier, but "PACKFILE" is not defined anywhere -
it's probably better written as:

    *PKT-LINE(%x01-03 *%x00-ff)"

or something like that.

> +    acknowledgments section
> +	* Always begins with the section header "acknowledgments"
> +
> +	* The server will respond with "NAK" if none of the object ids sent
> +	  as have lines were common.
> +
> +	* The server will respond with "ACK obj-id" for all of the
> +	  object ids sent as have lines which are common.
> +
> +	* A response cannot have both "ACK" lines as well as a "NAK"
> +	  line.
> +
> +	* The server will respond with a "ready" line indicating that
> +	  the server has found an acceptable common base and is ready to
> +	  make and send a packfile (which will be found in the packfile
> +	  section of the same response)
> +
> +	* If the client determines that it is finished with negotiations
> +	  by sending a "done" line, the acknowledgments sections MUST be
> +	  omitted from the server's response.
> +
> +	* If the server has found a suitable cut point and has decided
> +	  to send a "ready" line, then the server can decide to (as an
> +	  optimization) omit any "ACK" lines it would have sent during
> +	  its response.  This is because the server will have already
> +	  determined the objects it plans to send to the client and no
> +	  further negotiation is needed.
> +
> +----
> +    packfile section
> +	* Always begins with the section header "packfile"
> +
> +	* The transmission of the packfile begins immediately after the
> +	  section header
> +
> +	* The data transfer of the packfile is always multiplexed, using
> +	  the same semantics of the 'side-band-64k' capability from
> +	  protocol version 1.  This means that each packet, during the
> +	  packfile data stream, is made up of a leading 4-byte pkt-line
> +	  length (typical of the pkt-line format), followed by a 1-byte
> +	  stream code, followed by the actual data.
> +
> +	  The stream code can be one of:
> +		1 - pack data
> +		2 - progress messages
> +		3 - fatal error message just before stream aborts
> +
> +	* This section is only included if the client has sent 'want'
> +	  lines in its request and either requested that no more
> +	  negotiation be done by sending 'done' or if the server has
> +	  decided it has found a sufficient cut point to produce a
> +	  packfile.

For both the sections, I think that the conditions for
inclusion/non-inclusion ("This section is only included if...") should
be the first point.

> +static void upload_pack_data_init(struct upload_pack_data *data)
> +{
> +	struct object_array wants = OBJECT_ARRAY_INIT;
> +	struct oid_array haves = OID_ARRAY_INIT;
> +
> +	memset(data, 0, sizeof(*data));
> +	data->wants = wants;
> +	data->haves = haves;
> +}

Any reason to use a initializer function instead of a static literal?
