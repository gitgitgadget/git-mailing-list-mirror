Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1871F20A26
	for <e@80x24.org>; Fri, 22 Sep 2017 16:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbdIVQpK (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:45:10 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:49418 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbdIVQpI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:45:08 -0400
Received: by mail-pf0-f175.google.com with SMTP id l188so809993pfc.6
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g1gbG3VU9Myb89M4kH2UKbVh2L60a0dE2yhyxCXSh9c=;
        b=aNXfYiOlJZbtBr4nm7XCQ0UWlPq9q+1+d2w7WCMUXViALB10zDGTdG46ZlS6o/QZLD
         n97wndDQM2zqf2Cwhk8wzvtKmF1zW2d9H5KhKMI6+S0TjCzy2e1o9jd413mXTnOjU7eT
         LEhxY0x1i2CqHygRjHRjjt0LDxILhPHhfEWf9eDOsCDs0F0gkBo+1qyOI1Wa18I/Bqbx
         1XJchvNFpImUjg1ToSc72yn2zg0GCnr1mbfY7ly+86VSk78MSx2oT05HC4tkRj79339S
         15C22KTuDzHbgohMQRBuoyZMwmXafL9D/4X9skHr3LbEqV5E9QoJmBzbkdWt6C77fptg
         cMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g1gbG3VU9Myb89M4kH2UKbVh2L60a0dE2yhyxCXSh9c=;
        b=iXFXtgBe/QKPfpWAYm2yu2TqAKh4MMb3QUQDP5sONSH18So2LlUTMVOPTJYyQYkIna
         4RZbQlXrAE+OUG+qVE907/0GDEV/5eGK/x8O+/BeUKiWHQPrVOTfQyy/gGnLvym74AoW
         sp4rtUvOLknuYF7mWBFEKLAKsPZNn+luE8MWItw+cM+3wUHUhar5lFIKsIC0Ki8N3oF8
         aECDLAzZ+lYoViIj4o2AVJCZUMKzI/fcVdROc1VIOAFU/pxfvd3ppA2d2v3Leb0Vf8H9
         XHjZEvl09jI8hILK86A+VlFxGZhq9Vs6f38S1fj3jR45lHjywwdSDlngVp8bJ4NVU8gE
         vzuQ==
X-Gm-Message-State: AHPjjUh36ThKsnWN7ZWjKGg0M+xWF25I61quWgxQUT3qbQJHX1w9jooU
        Drp9ChuQPot86ydS5182OT9Gww==
X-Google-Smtp-Source: AOwi7QB1uSzEgIhH47elEzHJjuUln5WGdBIutfODbf30nzxCo7egAmsTd3gZNB5vIzMYQZ9sieqQPA==
X-Received: by 10.98.69.136 with SMTP id n8mr10006491pfi.291.1506098707169;
        Fri, 22 Sep 2017 09:45:07 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1986:3ebf:8c68:2a02])
        by smtp.gmail.com with ESMTPSA id u31sm288979pgn.70.2017.09.22.09.45.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 09:45:06 -0700 (PDT)
Date:   Fri, 22 Sep 2017 09:45:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, peff@peff.net
Subject: Re: [PATCH v3] connect: in ref advertisement, shallows are last
Message-ID: <20170922164504.GD77641@google.com>
References: <20170922000004.GB77641@google.com>
 <20170922000801.22560-1-jonathantanmy@google.com>
 <xmqqd16jmtjb.fsf@gitster.mtv.corp.google.com>
 <xmqq7ewrmrzo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7ewrmrzo.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/22, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jonathan Tan <jonathantanmy@google.com> writes:
> >
> >> Currently, get_remote_heads() parses the ref advertisement in one loop,
> >> allowing refs and shallow lines to intersperse, despite this not being
> >> allowed by the specification. Refactor get_remote_heads() to use two
> >> loops instead, enforcing that refs come first, and then shallows.
> >>
> >> This also makes it easier to teach get_remote_heads() to interpret other
> >> lines in the ref advertisement, which will be done in a subsequent
> >> patch.
> >
> > Sounds sensible.  This still replaces the earlier 1.5?
> 
> Well, it does, but it also invalidates how the new "pick the version
> offered and used" feature is integrated to this callchain.  I guess
> we'd need a new "we are now expecting the version info" state in a
> patch to replace "connect: teach client to recognize v1 server
> response".

Yeah given we go with this patch, which is probably a better cleanup
than what I attempted, then I would need to change how a client
recognizes a v1 server.  That would probably be easily done by adding a
new state.

I do think that once a v2 protocol rolls around we'll probably have to
do even more refactoring because I don't think we'll want to keep all
the version checking logic in get_remote_heads() for different protocol
versions which may not be interested in a servers ref advertisement, but
that'll be for another time.

> 
> >> +static int process_ref(int *state, int len, struct ref ***list,
> >> +		       unsigned int flags, struct oid_array *extra_have)
> >> +{
> >> +	struct object_id old_oid;
> >> +	char *name;
> >> +	int name_len;
> >> +
> >> +	if (len < GIT_SHA1_HEXSZ + 2 ||
> >> +	    get_oid_hex(packet_buffer, &old_oid) ||
> >> +	    packet_buffer[GIT_SHA1_HEXSZ] != ' ') {
> >> +		*state = EXPECTING_SHALLOW;
> >> +		return 0;
> >> +	}
> >> +
> >> +	name = packet_buffer + GIT_SHA1_HEXSZ + 1;
> >> +	name_len = strlen(name);
> >> +	if (*state == EXPECTING_REF_WITH_CAPABILITIES &&
> >> +	    len != name_len + GIT_SHA1_HEXSZ + 1) {
> >> +		free(server_capabilities);
> 
> Is this free() still needed?  After hitting this block, you'd set
> *state to EXPECTING_REF before you return, so nobody would set
> server_capabilities by hitting this block twice, and an attempt to
> do so will hit the die("unexpected cap") below, no?
> 
> Or it may be a signal that this patch tightens it too much and
> breaks older or third-party implementations of the other side that
> can emit more than one refs with capability advertisement?
> 
> >> +		server_capabilities = xstrdup(name + name_len + 1);
> >> +	} else if (*state == EXPECTING_REF) {
> >> +		if (len != name_len + GIT_SHA1_HEXSZ + 1)
> >> +			die("unexpected capabilities after ref name");
> >> +	}
> >> +	...
> >> +	}
> >> +	*state = EXPECTING_REF;
> >> +	return 1;
> >> +}
> 
> >> @@ -123,76 +208,26 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> >>  	 * willing to talk to us.  A hang-up before seeing any
> >>  	 * response does not necessarily mean an ACL problem, though.
> >>  	 */
> >> -	int saw_response;
> >> -	int got_dummy_ref_with_capabilities_declaration = 0;
> >> +	int responded = 0;
> >> +	int len;
> >> +	int state = EXPECTING_REF_WITH_CAPABILITIES;
> >>  
> >>  	*list = NULL;
> 
> >> +	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
> >> +		switch (state) {
> >> +		case EXPECTING_REF_WITH_CAPABILITIES:
> >> +		case EXPECTING_REF:
> >> +			if (process_ref(&state, len, &list, flags, extra_have))
> >> +				break;
> >> +			/* fallthrough */
> 
> OK.  This fallthrough is because expecting-ref is really expecting
> ref or shallow and once we see a shallow, we no longer expect ref
> and expect only shallow.  So from that point of view, an assignment
> to set state to EXPECTING_SHALLOW could happen here, not inside
> process_ref.  I mention this because in general, passing state
> around and let it be updated in helper functions would make the
> state transition harder to follow, not easier, even though
> refactoring the processing needed in different stages into helper
> functions like this patch does ought to make it easier to see by
> shrinking the outer loop (i.e. this one) that controls the whole
> process.
> 
> I think if we split process_ref() further into two, then we no
> longer need to pass &state to that function?  We start this loop
> with "expecting the dummy ref (or other)" state, have a new
> process_dummy_ref() function check if we got "capabilities^{}" thing
> and do its thing if that is the case (otherwise we fall through to
> the call to process_ref(), just like the above code falls through to
> call process_shallow() when it realizes what it got is not a ref),
> and after the first call to process_dummy_ref() we'd be in the
> "expecting ref (or other)" state---and the state transition can
> happen in this caller, not in process_dummy_ref() or process_ref().
> 
> Inside process_dummy_ref() and process_ref(), there would be a call
> to the same helper that notices and extracts the server capability
> and stores it (or barfs against the second line that advertises the
> capability, by noticing that server_capabilities is not NULL).
> 
> Wouldn't that make the presentation of the state machine cleaner?

I mentioned this when looking at v2 of this patch, that it would
probably be cleaner to remove passing the state variable around the
place and updating it inside a helper function.  It would just make the
logic simpler to follow if 'state' is updated directly instead of
indirectly.

-- 
Brandon Williams
