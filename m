Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D0820A10
	for <e@80x24.org>; Thu, 28 Sep 2017 21:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdI1V7C (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 17:59:02 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:47438 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbdI1V7B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 17:59:01 -0400
Received: by mail-pf0-f169.google.com with SMTP id u12so1515045pfl.4
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 14:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tOU8SSXZf+H0K6Sliqp9vvOw30MlPama3NSNyTlBatg=;
        b=Ty9Pw7jWDr7CErMggP7fn1Ey+6ips8aabGqGDFjFlDnr23ly07o66u8OVre4bzOoPk
         1AVZ9y29VXB4JtybU70ysQurYbm023k0lWUDsEr+NJD1Bs3Cc+RO7Bn2Q5dVc7NpXQ8o
         N7ykOPZZbK+fgCVdTdnG0EO0ypdy8pJzBTN67i0SIUXCbRdd+c6j1oUwdJUK/fXK2yw5
         fZrpHqy+TAn4FfdKMwDj7/96wFYfZczXTk/pfPS2/yX/cNUXGw7FFZJjo8ooU3lCTCpp
         b4xf/gE9K1quoyNRJCVCU3EYq/EmmbcEgSUXgrNeuIPkjYKTCt2a8xtTZGTBYdKS3vml
         N6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tOU8SSXZf+H0K6Sliqp9vvOw30MlPama3NSNyTlBatg=;
        b=UXXUisxqBL+3AbZl4U2N+P2knq+sU//J69Jelv6cBLbFtt9c2nhv5EuYxqVXKqDotj
         gBJllcMPZxbZGZTBz0RWmu+d/3YTpkwpdgcSeO66EOkNvMO/JjpzfU2dGl1f6DGtJ2tn
         zfZpxKMGcBbUz9GUZSuOJ+XullYBMkzi1b9YMiWv9+VYAHqlqu3xTsQ0altE8fi4d3yH
         yetgi/Z2FGlyHq3MhNERwa0YYynvNZo8f6TguMDobupC9mNIRWLnLVR3/yn4L5WSNxcw
         hoxSBLa33eOimOMVuJX2Heg894JLFx5ga0AThSC+zL7whbZWb9MqwHtMq1biGJ3gCVCf
         iwGQ==
X-Gm-Message-State: AHPjjUgoagGY8dnHnuXHan0RyVOX+n2OCzXdaUobdaCU0jSd/2mfsia2
        d/RdgkIz4jQUEFE7B+HY0w2QYQ==
X-Google-Smtp-Source: AOwi7QB1xDSEMPMPMCPsEL9VzGt8xxil8jrlcQ5PcZTRTj+l1ZchlqVHoB7GMRdGRlpY+JBNX2pr0Q==
X-Received: by 10.98.219.6 with SMTP id f6mr5464833pfg.59.1506635940503;
        Thu, 28 Sep 2017 14:59:00 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c55b:7140:f55d:7eed])
        by smtp.gmail.com with ESMTPSA id z89sm4275793pff.13.2017.09.28.14.58.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Sep 2017 14:58:59 -0700 (PDT)
Date:   Thu, 28 Sep 2017 14:58:58 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 3/9] protocol: introduce protocol extention mechanisms
Message-ID: <20170928215858.GB177031@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
 <20170926235627.79606-4-bmwill@google.com>
 <xmqq4lro7mab.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lro7mab.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +`GIT_PROTOCOL`::
> > +	For internal use only.  Used in handshaking the wire protocol.
> > +	Contains a colon ':' separated list of keys with optional values
> > +	'key[=value]'.  Presence of unknown keys must be tolerated.
> 
> Is this meant to be used only on the "server" end?  Am I correct to
> interpret "handshaking" to mean the initial connection acceptor
> (e.g. "git daemon") uses it to pass what it decided to the programs
> that implement the service (e.g. "git receive-pack")?

Yes, the idea is that the client will request a protocol version by
setting GIT_PROTOCOL (or indirectly set when using git:// or http://).
upload-pack and receive-pack will use the keys and values set in
GIT_PROTOCOL to determine which version of the protocol to use.  At some
point in the future they may even use other keys and values as a means
of sending more information in an initial request from the client.

> 
> > +/*
> > + * Environment variable used in handshaking the wire protocol.
> > + * Contains a colon ':' separated list of keys with optional values
> > + * 'key[=value]'.  Presence of unknown keys must be tolerated.
> > + */
> > +#define GIT_PROTOCOL_ENVIRONMENT "GIT_PROTOCOL"
> 
> "Must be tolerated" feels a bit strange.  When somebody asks you to
> use "version 3" or "version 1 variant 2", when you only know
> "version 0" or "version 1" and you are not yet even aware of the
> concept of "variant", we simply ignore "variant=2" as if it wasn't
> there, even though "version=3" will be rejected (because we know of
> "version"; it's just that we don't know "version=3").

By "Must be tolerated" I was trying to get across that if the server
seeing something it doesn't understand, it shouldn't choke.  Maybe a
better wording would be to use the word "ignored"?

> 
> > +enum protocol_version determine_protocol_version_server(void)
> > +{
> > +	const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
> > +	enum protocol_version version = protocol_v0;
> > +
> > +	if (git_protocol) {
> > +		struct string_list list = STRING_LIST_INIT_DUP;
> > +		const struct string_list_item *item;
> > +		string_list_split(&list, git_protocol, ':', -1);
> > +
> > +		for_each_string_list_item(item, &list) {
> > +			const char *value;
> > +			enum protocol_version v;
> > +
> > +			if (skip_prefix(item->string, "version=", &value)) {
> > +				v = parse_protocol_version(value);
> > +				if (v > version)
> > +					version = v;
> > +			}
> > +		}
> > +
> > +		string_list_clear(&list, 0);
> > +	}
> > +
> > +	return version;
> > +}
> 
> This implements "the largest one wins", not "the last one wins".  Is
> there a particular reason why the former is chosen?
> 

I envision this logic changing for newer servers once more protocol
versions are added because at some point a server may want to disallow a
particular version (because of a security issue or what have you).  So I
figured the easiest thing to do for now was to implement "Newest version
wins".

-- 
Brandon Williams
