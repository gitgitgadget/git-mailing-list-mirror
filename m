Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29E4B1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 21:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932277AbeCMVgc (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 17:36:32 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:43911 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbeCMVgb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 17:36:31 -0400
Received: by mail-pl0-f48.google.com with SMTP id f23-v6so557108plr.10
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 14:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cashBcOJuH++5sKmhfogZySx+FNt+Sa5mv/lUcmVcnM=;
        b=T1hcuOFsAz/7Q6DoiEp2jOKojSBnDy9e6T0f0FS2bs7Fc7cS9vDu8VNEe17smIlnAk
         eBlK/TVQtrXPoye/No7e43KAMmqmcIx3qG96kjuNBv/avtwh8HS+kjZalceuTqX+nqT4
         fpKjkW5Z0kVj/MIJggsN0987kEZNfO9KcQsqF4BqxRmHjREAzsLKOkR24D7rmBXT2PI0
         EIUjSseezRMa1RjOzBw62rOgD4G35MYeadrtbg3g5e6pOs92eXi+5gcojfeSpnlmrEyV
         mydLeh2BnWZ3+aewxxyoY3XqNhaoiX/EKpiJqSbW7NaVvyUkV9foj8kvs32tpKWrpBU/
         lV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cashBcOJuH++5sKmhfogZySx+FNt+Sa5mv/lUcmVcnM=;
        b=k5du7FzRoxhdcJeUHjKtbPyLdtjcCLajpWHOYJUDxwQMTwV//h7rJGnvXAhpvC2QZr
         UvAgHgX3mHnNqOBB7rI3NxILEIzal/lhyLwBleR6J4mGUiRfjjXcFSy45+PKgP7wssw0
         uBDepO+Kf5fCK6HsFa/DsO09ug7boW4XLYYkBQnsNT/xkY32QNXR/zeAa1xgk/4XXVgK
         /1SkRnB5UNdAPTCfca4DIAPLegcS6U8fiKDmq2Xo5j4XVYBFyEJhdpHkh2rBbHVSuQWb
         SBAPVPcL+m8JuJXmlC9cRNoiJbUpbcFA4iNe+BmlJAnpY3iIz4H5b1zUqvh0g+Z9C1Xp
         +1Yw==
X-Gm-Message-State: AElRT7EewIXZpEvpvnnoTlFUTw1hO+F9KXuSU6rbTJqTNbuhl3qe6ZRT
        EiiwH6+zMH4eqdUBrSbmBqQ=
X-Google-Smtp-Source: AG47ELuUqw4+yO3LbYikae8CtJhoFo0C+LRegMcUWbdsIyc8JnVNc1eb9oujTbRcDQeob3Qbk+0twA==
X-Received: by 2002:a17:902:bd4b:: with SMTP id b11-v6mr1827482plx.225.1520976990476;
        Tue, 13 Mar 2018 14:36:30 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s68sm1523537pgb.43.2018.03.13.14.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 14:36:30 -0700 (PDT)
Date:   Tue, 13 Mar 2018 14:36:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] shortlog: do not accept revisions when run outside
 repo
Message-ID: <20180313213628.GB147135@aiede.svl.corp.google.com>
References: <cover.1520680894.git.martin.agren@gmail.com>
 <78669e644b64fc10c34adb59717d2039f81cb092.1520680894.git.martin.agren@gmail.com>
 <20180313195640.GA147135@aiede.svl.corp.google.com>
 <CAN0heSoP1oVWH0YAFNcL5LG_K7TsmKMAHUA_TiDacVdPtWjTZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSoP1oVWH0YAFNcL5LG_K7TsmKMAHUA_TiDacVdPtWjTZw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren wrote:
> On 13 March 2018 at 20:56, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Martin Ågren wrote:

>>>                                                       (So yes, after
>>> this patch, we will still silently ignore stdin for confused usage such
>>> as `git log v2.15.0.. | git shortlog v2.16.0..`. But at least that does
>>> not crash.)
>>
>> I don't follow here.  Are you saying this command should notice that
>> there is input in stdin?  How would it notice?
>
> I have no idea how it would notice (portably!) and the gain seems
> minimal. I added this to keep the reader from wondering "but wait a
> minute, doesn't that mean that we fail to catch this bad usage if we're
> in a repo?". So my answer would be "yep, but it's not a huge problem".
> Of course, my attempt to pre-emptively answer a question only provoked
> another one. :-) I could phrase this better.

Ah, I think I see what I was missing.  Let me look again at the whole
paragraph in context:

[...]
>>> Disallow left-over arguments when run from outside a repo. Another
>>> approach would be to disallow them when reading from stdin. However, our
>>> logic is currently the other way round: we check the number of revisions
>>> in order to decide whether we should read from stdin. (So yes, after
>>> this patch, we will still silently ignore stdin for confused usage such
>>> as `git log v2.15.0.. | git shortlog v2.16.0..`. But at least that does
>>> not crash.)

How about something like this?

	Disallow left-over arguments when run from outside a repo.  This
	way, such invalid usage is diagnosed correctly:

		$ git shortlog v2.16.0..
		error: [...]
		[...]

	while still permitting the piped form:

		$ git -C ~/src/git log --pretty=short | git shortlog
		A Large Angry SCM (15):
		[...]

	This cannot catch an incorrect usage that combines the piped and
	<revs> forms:

		$ git log --pretty=short | git shortlog v2.16.0..
		Alban Gruin (1)
		[...]

	but (1) the operating system does not provide a straightforward
	way to detect that and (2) at least it doesn't crash.

That detail is mostly irrelevant to what the patch does, though.  I
wouldn't expect git to be able to diagnose that third variant anyway.
If we want to make the command less error-prone, I think a good path
forward would be to introduce an explicit --stdin option.  So I'd be
tempted to go with the short and sweet:

	Disallow left-over arguments when run from outside a repo.

[...]
>>> +             error(_("no revisions can be given when running "
>>> +                     "from outside a repository"));
>>> +             usage_with_options(shortlog_usage, options);
>>> +     }
>>> +
>>
>> The error message is
>>
>>         error: no revisions can be given when running from outside a repository
>>         usage: ...
>>
>> Do we need to dump usage here?  I wonder if a simple die() call would
>> be easier for the user to act on.
>
> I can see an argument for "dumping the usage makes the error harder than
> necessary to find". I mainly went for consistency. This ties into your
> other observations below: what little consistency do we have and in
> which direction do we want to push it...
[...]
> I think it would be a larger project to make these consistent. The one
> I'm adding here is at least consistent with the other one in this file.

Ah, thanks.  That makes sense.

>> Separate from that, I wonder if the error message can be made a little
>> shorter and clearer.  E.g.
>>
>>         fatal: shortlog <revs> can only be used inside a git repository
>
> Some grepping suggests we do not usually name the command ("shortlog
> ..."), perhaps to play well with aliasing, nor do we use "such <syntax>"
> very often, but it does happen. Quoting and allowing for options might
> make this more correct, but perhaps less readable: "'shortlog [...]
> <revs>' can only ...". Slightly better than what I had, "revisions can
> only be given inside a git repository" would avoid some negating.

Sounds good to me.

Thanks,
Jonathan
