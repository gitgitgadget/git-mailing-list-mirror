Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322ED1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeBVSy2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:54:28 -0500
Received: from mail-pl0-f53.google.com ([209.85.160.53]:38909 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBVSy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:54:27 -0500
Received: by mail-pl0-f53.google.com with SMTP id d4so3391384pll.5
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z6tnR9PAGdAmCjr/mlht0nrbcOoRDiBQdsDoKn5SjlA=;
        b=YVmqXMClGh6nhDETyNlQ/VKpEZDejnYPYZFEmyvtMS+xG7JpuOedGX7vo+2Pw1mVLR
         IM5PZ/QZyPAVyw5yDUz1vCTyLkKFfjsvuZwhvcu1MQgKYO5rgpWYdiEZ3C7S7cSKKJCS
         qT0mMMoEjpl9bs1k8GKi01tKygNZcvW2XypbTHboTA/zphoXzxmAc2L80U9LT+jk/u5G
         ikNKyi7f8EXz1y78xulsTLcggGefN3nzyOgpACs/ZEAjRyYt/ccSUoLRwjUzJD7KvaPG
         V4IaJQxDAF0gOw7uKa3Mun2JOypCW4seTLOZrBmYLwwIvf/rcIgz7kbZJ9UM2+lmFNwT
         7QrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z6tnR9PAGdAmCjr/mlht0nrbcOoRDiBQdsDoKn5SjlA=;
        b=P9m3d1NwsBQUe7n4ZnV2Zdyg7L8IKOEdr3zgEMK1Z09Vzo1TU4O/BO6JRrNhYF7vrP
         xdHKsuoXUlQgVOfKlUgy/hDcVYeLpBZsFpUJso1kRS7+y7GCb/VDOntHj4biT5kjJIj0
         LwULoZOc+OT6gkNbkxdNg+jfgtw5oriB2vb8dM41rgjztVFykD5dQpnIOYlqGEKcMM3P
         V1Lg9HBzQ77yrMg45gdiXGy16yJLSer9XHjdp3vuafv5Ah0cTmtI0XdoCyAvR80YiD2a
         vLzxb3VWaCCLvE0l0MF7C2XZJv7qtzg0OngRlX+R3lwHxzNUSWV6fePZQ8eP337SrJGO
         UZoA==
X-Gm-Message-State: APf1xPAWQXxcQnoIZzLUHX5+jnQNysjw2kg0BrM7h4FVG9IrYVHZn+8h
        rJc5JLDJ8bYIBjzqNta5t0rPNg==
X-Google-Smtp-Source: AH8x226tUBCrADry2hEbt03zA6YvQqagmpS5ioYNLPb1sPQNQ0P0rJeD1AlDljfyAJT8CEznu0atrQ==
X-Received: by 2002:a17:902:788e:: with SMTP id q14-v6mr7528354pll.396.1519325319690;
        Thu, 22 Feb 2018 10:48:39 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id w3sm1092969pfw.30.2018.02.22.10.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:48:38 -0800 (PST)
Date:   Thu, 22 Feb 2018 10:48:37 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 20/35] upload-pack: introduce fetch server command
Message-ID: <20180222184837.GG185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-21-bmwill@google.com>
 <20180221154622.f35e69f0d8c6bb54e40a299a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221154622.f35e69f0d8c6bb54e40a299a@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Jonathan Tan wrote:
> On Tue,  6 Feb 2018 17:12:57 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > +    want <oid>
> > +	Indicates to the server an object which the client wants to
> > +	retrieve.
> 
> Mention that the client can "want" anything even if not advertised by
> the server (like uploadpack.allowanysha1inwant).

Will do.

> 
> > +    output = *section
> > +    section = (acknowledgments | packfile)
> > +	      (flush-pkt | delim-pkt)
> > +
> > +    acknowledgments = PKT-LINE("acknowledgments" LF)
> > +		      *(ready | nak | ack)
> 
> Can this part be described more precisely in the BNF section? I see that
> you describe later that there can be multiple ACKs or one NAK (but not
> both), and "ready" can be sent regardless of whether ACKs or a NAK is
> sent.

Yep I'll fix that.

> 
> > +    ready = PKT-LINE("ready" LF)
> > +    nak = PKT-LINE("NAK" LF)
> > +    ack = PKT-LINE("ACK" SP obj-id LF)
> > +
> > +    packfile = PKT-LINE("packfile" LF)
> > +	       [PACKFILE]
> > +
> > +----
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
> > +	  by sending a "done" line, the acknowledgments sections can be
> > +	  omitted from the server's response as an optimization.
> 
> Should this be changed to "must"? The current implementation does not
> support it (on the client side).

This is actually a great question and one which may need to be thought
about in terms of its application to future extensions to the fetch
command.  Since fetch's response is now broken up into sections we may
want the client to cope with sections being in any order and maybe even
skipping sections it doesn't know about.  Not sure if its necessary but
its an idea.

> 
> > +#define UPLOAD_PACK_DATA_INIT { OBJECT_ARRAY_INIT, OID_ARRAY_INIT, 0, 0, 0, 0, 0, 0 }
> 
> Optional: the trailing zeroes can be omitted. (That's shorter, and also
> easier to maintain when we add new fields.)
> 
> > +int upload_pack_v2(struct repository *r, struct argv_array *keys,
> > +		   struct argv_array *args)
> > +{
> > +	enum fetch_state state = FETCH_PROCESS_ARGS;
> > +	struct upload_pack_data data = UPLOAD_PACK_DATA_INIT;
> > +	use_sideband = LARGE_PACKET_MAX;
> > +
> > +	while (state != FETCH_DONE) {
> > +		switch (state) {
> > +		case FETCH_PROCESS_ARGS:
> > +			process_args(args, &data);
> > +
> > +			if (!want_obj.nr) {
> > +				/*
> > +				 * Request didn't contain any 'want' lines,
> > +				 * guess they didn't want anything.
> > +				 */
> > +				state = FETCH_DONE;
> > +			} else if (data.haves.nr) {
> > +				/*
> > +				 * Request had 'have' lines, so lets ACK them.
> > +				 */
> > +				state = FETCH_SEND_ACKS;
> > +			} else {
> > +				/*
> > +				 * Request had 'want's but no 'have's so we can
> > +				 * immedietly go to construct and send a pack.
> > +				 */
> > +				state = FETCH_SEND_PACK;
> > +			}
> > +			break;
> > +		case FETCH_READ_HAVES:
> > +			read_haves(&data);
> > +			state = FETCH_SEND_ACKS;
> > +			break;
> 
> This branch seems to never be taken?

Must be left over from another version, I'll remove it.

> 
> > +		case FETCH_SEND_ACKS:
> > +			if (process_haves_and_send_acks(&data))
> > +				state = FETCH_SEND_PACK;
> > +			else
> > +				state = FETCH_DONE;
> > +			break;
> > +		case FETCH_SEND_PACK:
> > +			packet_write_fmt(1, "packfile\n");
> > +			create_pack_file();
> > +			state = FETCH_DONE;
> > +			break;
> > +		case FETCH_DONE:
> > +			continue;
> > +		}
> > +	}
> > +
> > +	upload_pack_data_clear(&data);
> > +	return 0;
> > +}

-- 
Brandon Williams
