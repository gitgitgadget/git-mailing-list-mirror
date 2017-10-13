Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F28820437
	for <e@80x24.org>; Fri, 13 Oct 2017 22:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbdJMWEK (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 18:04:10 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:55668 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbdJMWEI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 18:04:08 -0400
Received: by mail-pf0-f179.google.com with SMTP id 17so11366924pfn.12
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 15:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gXR823umuxujz/8j9U3IDxOKOZLZ9chFKc3yVqLKP9M=;
        b=G2PWcQCosqCq4vtTyXa69BhZ+KlZjRpYYrqmCiD1A1/moAzhZvoP07t6vDG1g/wxK+
         wxhtlO6dNDF6xUXWVz9YGgpSzxdJfdduCmGuUGnIppt+1F1ED5KFAgK6ebCArwOi9UAn
         uxqskugnkVs+fQjDz+vHb3WR9OkU4ubCDuDAKBAQhjzbaWI1ZQqr0BYfnNr0jUkjodGA
         f6sbbPP/4NmVdex4aO0hCTQXrqqsHfzKBgZW5q7O7JTM5kJ4r5V28Yp1yuMNwFzZfm+L
         M1NUa8KqQvFVt7VbUCLIo1NDeXtM+8krCh5SYClfoSyfC7nuY3VxPhhcnIBXUbSNcokL
         LSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gXR823umuxujz/8j9U3IDxOKOZLZ9chFKc3yVqLKP9M=;
        b=t9b+qYtuKGFQPO5FYtiPlfiwQFBWW/DLc29fdkM6aFktVSULEinq9R+GbZlrwqR1nh
         yHAfi28SSrSyZ6g4GusfLa/MpDqpxNRcBHW+vf6mrbdw5KwRvPNxJ90E25pTDTF0q8iw
         3R3QIHbdmabEGEb1YXJmXkugftd1wSGFk8xZSDVB4q1xvGsNDCnPAXDL7B/Or+He8rI7
         iAXXal8gqy/c980lT5N3ZEmDVp5+9TbCaXdgpYAI2kg+DjSd92J5xzeiE9o0lSQAqbQD
         gs3wzaK7kevbYfLRK3h6BmdBu8G8XQ7Gg9HeGy5hkL395IC0MVm9HM01aj4+R7PoqLzK
         fM8A==
X-Gm-Message-State: AMCzsaXZM8jhW9KopYhV68/kMc1gjnS2XRRtVdojSWJO8sgWN3wVOB82
        9mRh1KRulB8PkJ3JAjLmj7vviQ==
X-Google-Smtp-Source: AOwi7QA8AwqBj2Zbe9EbGmzHD5Q4JR19+b4N2d/yBe/ug1xUI2/YBVAWU22AwOGDjJOT5bAG1Mf0RQ==
X-Received: by 10.99.124.88 with SMTP id l24mr2295908pgn.397.1507932248077;
        Fri, 13 Oct 2017 15:04:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b031:5884:4d4f:f3a9])
        by smtp.gmail.com with ESMTPSA id z76sm4181303pfi.117.2017.10.13.15.04.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 Oct 2017 15:04:06 -0700 (PDT)
Date:   Fri, 13 Oct 2017 15:04:05 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 04/10] daemon: recognize hidden request arguments
Message-ID: <20171013220405.GA101395@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-5-bmwill@google.com>
 <20171010112416.107a7325cef61cd2425d6204@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010112416.107a7325cef61cd2425d6204@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10, Jonathan Tan wrote:
> On Tue,  3 Oct 2017 13:15:01 -0700
> Brandon Williams <bmwill@google.com> wrote:
> 
> >  /*
> >   * Read the host as supplied by the client connection.
> 
> The return value is probably worth documenting. Something like "Returns
> a pointer to the character *after* the NUL byte terminating the host
> argument, or extra_args if there is no host argument."

I can add that comment.

> 
> >   */
> > -static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
> > +static char *parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
> 
> [snip]
> 
> > +static void parse_extra_args(struct hostinfo *hi, struct argv_array *env,
> > +			     char *extra_args, int buflen)
> > +{
> > +	const char *end = extra_args + buflen;
> > +	struct strbuf git_protocol = STRBUF_INIT;
> > +
> > +	/* First look for the host argument */
> > +	extra_args = parse_host_arg(hi, extra_args, buflen);
> 
> This works, but is a bit loose in what it accepts. I think it's better
> to be tighter - in particular, if there is no host argument, we
> shouldn't be looking for extra args.

I disagree, you shouldn't be precluded from using protocol v2 if you
don't include a host argument.

> 
> > +
> > +	/* Look for additional arguments places after a second NUL byte */
> > +	for (; extra_args < end; extra_args += strlen(extra_args) + 1) {
> 
> Assuming that the host argument exists, this for loop should start at
> extra_args + 1 to skip the second NUL byte. This currently works
> because this code is lenient towards empty strings.

Being lenient towards empty strings is fine, I don't see any reason why
we should disallow them.  Also, this code already
requires that there be the second NUL byte because if there isn't then
the code which parses the host argument would fail out.

> 
> > +		const char *arg = extra_args;
> > +
> > +		/*
> > +		 * Parse the extra arguments, adding most to 'git_protocol'
> > +		 * which will be used to set the 'GIT_PROTOCOL' envvar in the
> > +		 * service that will be run.
> > +		 *
> > +		 * If there ends up being a particular arg in the future that
> > +		 * git-daemon needs to parse specificly (like the 'host' arg)
> > +		 * then it can be parsed here and not added to 'git_protocol'.
> > +		 */
> > +		if (*arg) {
> > +			if (git_protocol.len > 0)
> > +				strbuf_addch(&git_protocol, ':');
> > +			strbuf_addstr(&git_protocol, arg);
> > +		}
> > +	}
> 
> But I think we shouldn't be lenient towards empty strings.

Why not? I see no issue with allowing them.  In fact if we error out we
could be painting ourselves into a corner much like how we did with the
host parsing logic.

> 
> > +
> > +	if (git_protocol.len > 0)
> > +		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
> > +				 git_protocol.buf);
> > +	strbuf_release(&git_protocol);
> >  }

-- 
Brandon Williams
