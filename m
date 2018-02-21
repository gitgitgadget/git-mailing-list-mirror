Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F6211F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeBUXq0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:46:26 -0500
Received: from mail-pl0-f41.google.com ([209.85.160.41]:41629 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbeBUXqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:46:25 -0500
Received: by mail-pl0-f41.google.com with SMTP id k8so1854895pli.8
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 15:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/8VrpoFJwh1nhtsLpq87d8tP801GO9GyyCpCNcQmig=;
        b=GlDcUIfiVXPAatZALtu1Qq4UdSZJnHR2uUr9IM7MzRbf5TqPE7Dd0HBMkCRqMRpFi4
         ZyoyLkqX9u4oLDM9gr5rDP/OxpQhIKGW9Tx/oSXzmbfGVS2XyC8/T1g+wNV3HIOyFs7D
         /JLIA/A6XvD1xmOLVuAfL+T3nPM+cQXG7TfTkmqPCUNF3+PAlULDbK6qpe4j25heiasd
         eO5z/rzgomE+2X6tXFKw1/Wy8tGHw4K2v7FMVTynJc+hmwtk1L9mstQpgHxM4eU9JFtQ
         LQUX4/oxyUSVAwa9kvF5yTPN2GQyXII67d29LK8axTFNQfeS5ivVgnIjrsv7B+94vVO4
         Q9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/8VrpoFJwh1nhtsLpq87d8tP801GO9GyyCpCNcQmig=;
        b=JEW08uyAaxnSh/q13/Q9exB2taZxQnI4i1DGj4Ly5hU9PojXV1QMtCwCdrYuKR7Bk+
         S46qXjpOVSPyyo9TBRrdN2k4aIGZvtiGGn2IsQijApBdhvKF3t2A35X14b/W5E2pzpSx
         GtxAgTrrr7XUl3lfDk1WJbsxlOF8ehWQWCu1qB4F0LaWsHEq+YJpuVSOpc/xzX1qRLLh
         CC/SLmjAcquKx/iqUdcFIK/Kckpj8AncHJYy8HX1UpHNeHnM5Bkq6HUbnahRp0TBJULD
         OEpcNKfY95H6yfFxSvBYRZiW3Ic0WK64F7OLqRdh9ky41pWj4cBmp+nK0h3igF5Wj8Al
         eJhw==
X-Gm-Message-State: APf1xPCxcyoZd4gM2B1kaVshunkRKztrLXaFX8k+Z6EFHTIxKC5uKxuV
        hWfDUOoMYdYJvdOZi8Xw2wD01Q==
X-Google-Smtp-Source: AH8x227SJF8vJ2glNBwUMMj/U8PbzVUJTCabQZVT7ov5GMKnXrsWbVvyYzl8exSAOpL0QJibUvQP/Q==
X-Received: by 2002:a17:902:8484:: with SMTP id c4-v6mr4581158plo.271.1519256784824;
        Wed, 21 Feb 2018 15:46:24 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id l64sm70107116pfi.46.2018.02.21.15.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 15:46:23 -0800 (PST)
Date:   Wed, 21 Feb 2018 15:46:22 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 20/35] upload-pack: introduce fetch server command
Message-Id: <20180221154622.f35e69f0d8c6bb54e40a299a@google.com>
In-Reply-To: <20180207011312.189834-21-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-21-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:12:57 -0800
Brandon Williams <bmwill@google.com> wrote:

> +    want <oid>
> +	Indicates to the server an object which the client wants to
> +	retrieve.

Mention that the client can "want" anything even if not advertised by
the server (like uploadpack.allowanysha1inwant).

> +    output = *section
> +    section = (acknowledgments | packfile)
> +	      (flush-pkt | delim-pkt)
> +
> +    acknowledgments = PKT-LINE("acknowledgments" LF)
> +		      *(ready | nak | ack)

Can this part be described more precisely in the BNF section? I see that
you describe later that there can be multiple ACKs or one NAK (but not
both), and "ready" can be sent regardless of whether ACKs or a NAK is
sent.

> +    ready = PKT-LINE("ready" LF)
> +    nak = PKT-LINE("NAK" LF)
> +    ack = PKT-LINE("ACK" SP obj-id LF)
> +
> +    packfile = PKT-LINE("packfile" LF)
> +	       [PACKFILE]
> +
> +----
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
> +	  by sending a "done" line, the acknowledgments sections can be
> +	  omitted from the server's response as an optimization.

Should this be changed to "must"? The current implementation does not
support it (on the client side).

> +#define UPLOAD_PACK_DATA_INIT { OBJECT_ARRAY_INIT, OID_ARRAY_INIT, 0, 0, 0, 0, 0, 0 }

Optional: the trailing zeroes can be omitted. (That's shorter, and also
easier to maintain when we add new fields.)

> +int upload_pack_v2(struct repository *r, struct argv_array *keys,
> +		   struct argv_array *args)
> +{
> +	enum fetch_state state = FETCH_PROCESS_ARGS;
> +	struct upload_pack_data data = UPLOAD_PACK_DATA_INIT;
> +	use_sideband = LARGE_PACKET_MAX;
> +
> +	while (state != FETCH_DONE) {
> +		switch (state) {
> +		case FETCH_PROCESS_ARGS:
> +			process_args(args, &data);
> +
> +			if (!want_obj.nr) {
> +				/*
> +				 * Request didn't contain any 'want' lines,
> +				 * guess they didn't want anything.
> +				 */
> +				state = FETCH_DONE;
> +			} else if (data.haves.nr) {
> +				/*
> +				 * Request had 'have' lines, so lets ACK them.
> +				 */
> +				state = FETCH_SEND_ACKS;
> +			} else {
> +				/*
> +				 * Request had 'want's but no 'have's so we can
> +				 * immedietly go to construct and send a pack.
> +				 */
> +				state = FETCH_SEND_PACK;
> +			}
> +			break;
> +		case FETCH_READ_HAVES:
> +			read_haves(&data);
> +			state = FETCH_SEND_ACKS;
> +			break;

This branch seems to never be taken?

> +		case FETCH_SEND_ACKS:
> +			if (process_haves_and_send_acks(&data))
> +				state = FETCH_SEND_PACK;
> +			else
> +				state = FETCH_DONE;
> +			break;
> +		case FETCH_SEND_PACK:
> +			packet_write_fmt(1, "packfile\n");
> +			create_pack_file();
> +			state = FETCH_DONE;
> +			break;
> +		case FETCH_DONE:
> +			continue;
> +		}
> +	}
> +
> +	upload_pack_data_clear(&data);
> +	return 0;
> +}
