Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006121F404
	for <e@80x24.org>; Mon, 10 Sep 2018 19:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbeIKANg (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 20:13:36 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39034 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeIKANf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 20:13:35 -0400
Received: by mail-wr1-f43.google.com with SMTP id s14-v6so14152568wrw.6
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DwuYdVpLNzFmGYmyF9leh/2EyZ3SOItQweAs7GCB8rU=;
        b=mVnItghGW3VLO7q7QzwbRu9XFqm9BO+lb9ytix4T/lC6qy9RQR9FLC2AN+JjWUNoVJ
         rZX9oWtsrFgHVB8zipfYihCi011mUOQ9Mr4qkH5JUWG+FGE3fNEqvX4q/LYXXpkItw0K
         8py1YlBSQfjjxjkEd76LiTC11gPpnCKiclMZ2mVHgWq7n1iiNdDs7jZp/KA5pzxT1w0+
         HykbXTlZSKgvQHYWNg97DgQc/+aHlvZX4RfpMV2VtXn/+82JlbRCy39CytkXf4QglHIt
         p9+e6EgSbEWErKnhAyMYhKise6XApXlYCJMXQ/NsIqzLNginEo6tl9KsS95fhIVV5wKT
         +aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DwuYdVpLNzFmGYmyF9leh/2EyZ3SOItQweAs7GCB8rU=;
        b=L4mTvmaWursMK+ZJeTt0qqSq7PI3ysxqKOrgG622H4Gg71bp4etdOfFgBBcDghvpo8
         +rJd2lH9UAUz0S7/ef18Asx1AofyL15mlecsI00AeXsTwIYz7i9xrfYGe9w2XjI666QR
         wHN10P8gHYmu3c1V+HpPPyXiMQtz5acz5rHPluO5ukFiTfqSVswGBLmZgKBHgHd2hbLj
         cXkTtp5/00D/RlsPiYOF4X/xKhAEo+a/gq7yNe8HeagzSpZKDdUXTgAAnlov3jeMIV7i
         l9jDkreuHVOjHap5ISznOPqE1Jp/ziJ8QqT/rYsFkMDD4ihaPvNAaqf45TVf+yHFA5da
         0/uQ==
X-Gm-Message-State: APzg51BNffAk7sAxWnZwYWKJQi7uaH0djZaN4sUSYp6RWY1dvDO5buLx
        EgbN5LY+92YcUwRiYrSYJfA=
X-Google-Smtp-Source: ANB0VdZhBEyW7/SASvTTVZJFvOW85gV+/aScM3RYnnnaxsD9sUPBeZslMHFSCQK9EfYh+a6bB78Iiw==
X-Received: by 2002:adf:a602:: with SMTP id k2-v6mr15374151wrc.181.1536607080707;
        Mon, 10 Sep 2018 12:18:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 60-v6sm18669237wre.82.2018.09.10.12.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 12:17:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Stas Bekman <stas@stason.org>,
        git@vger.kernel.org
Subject: Re: git silently ignores include directive with single quotes
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
        <20180908212256.GB31560@sigill.intra.peff.net>
        <xmqqr2i1thbs.fsf@gitster-ct.c.googlers.com>
        <20180910171422.GA26356@aiede.svl.corp.google.com>
        <xmqqa7optdbs.fsf@gitster-ct.c.googlers.com>
        <20180910183557.GD26356@aiede.svl.corp.google.com>
Date:   Mon, 10 Sep 2018 12:17:58 -0700
In-Reply-To: <20180910183557.GD26356@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 10 Sep 2018 11:35:57 -0700")
Message-ID: <xmqq1sa1tb4p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Updated proposal:
>
>   1. Treat strings starting or ending with single-quote as worth
>      quoting in config.c::write_pair (line 3269).  This would already
>      help with the original issue, since the config would say
>
> 	[foo]
> 		bar = "'baz'"
>
>      allowing a quick diagnosis.

This does not change anything essential from Git's point of view
since the previous round.

But I changed my mind anyway ;-)  Earlier I said "if we do not
intend to make sq special, we shouldn't do #1", and it still is a
good direction to go.

But making sq special does not have to be making sq a character that
quotes.  A character (or a character sequence) that is *not* quoting
can still be special---for example, we can say certain character or
a character sequence *must* be quoted, and make sq such a character.

That is, even if we stop at your step 3. or step 2., and did not go
to step 4. (which I think is a bad idea for little gain), we are
already treating sq as a special character, and step 1. above is a
reasonable way to start the transition to that better world.

The reason why it is a better world that have "must be quoted, even
though they are not quoting characters themselves" is solely because
that would avoid confusion for those who are not familiar with the
file format, even when we stop at step #2.  In addition to a single
quote a the beginning of the value, I think two or more SP deserve
to be such a "must be quoted" sequence, i.e. instead of producing
this result, which we see with today's Git:

	$ git config a.test0 "'foo"
	$ git config a.test1 "foo  bar" ;# two spaces
	$ grep -A2 '\[a\]' config
	[a]
		test0 = 'foo
		test1 = foo  bar

we'd produce

	$ grep -A2 '\[a\]' config
	[a]
		test0 = "'foo"
		test1 = "foo  bar"

but we can still interpret what we have historically written the
same way.

I do not know if step #3 is a good idea, and I do not think step #2
is particularly a good stopping point.  Step #1 is probably slightly
a better stopping point if the aim is to avoid user confusion than
step #2.


>   2. (optional) Warn if a value is surrounded in single-quotes,
>      encouraging using surrounding double-quotes to disambiguate.
>
>   3. (optional) Error out if a value is surrounded in single-quotes,
>      encouraging replacing with or surrounding with double-quote,
>      depending on the user's intention.
>
>   4. (optional) Start treating wrapping single-quotes specially
>      somehow.
>
> As before, I think step 1 is a good idea, but I'm not convinced about
> any of the later steps.
>
> Thanks,
> Jonathan
