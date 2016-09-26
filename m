Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E5A209AB
	for <e@80x24.org>; Mon, 26 Sep 2016 18:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034924AbcIZSiT (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 14:38:19 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33137 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034836AbcIZSiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 14:38:16 -0400
Received: by mail-pa0-f52.google.com with SMTP id fn2so3250675pad.0
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A9dCRln5ZgfMkhGS6ETt57Swsx9QQ9Rue7hAtoxXXXI=;
        b=fzx+X/q6UK70jAA6JA8PclMQrWwJz4nPgDrmcvhBfrr4XTosdvM6aqpq0n0IhZQEVQ
         Nf9oqHx4RUbD4R1pjDcKg2Vbh5DEHmFG74THGHDK1LJU/6RTb4vWLC1zA2tK51+pyy4j
         U+yzQO5RlqkqlwlAe/yp+hUVqpuV6pUhgwPfVvFJp4QGrORg3DKMmvfL5QzX13MQhHid
         CSS4lqHvP4SLbQ36xj6+4K46Oh1WN8K7lwZHw+oqNUHMsIQKTkP8FCzBrL7KkbmQeUmK
         AGrMZpNMnrpPpwLYwYQryne35rt3BIRWtXzJamP+QJWF7mzjAYeJlFsRuiVPtKoPMeKG
         ZlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A9dCRln5ZgfMkhGS6ETt57Swsx9QQ9Rue7hAtoxXXXI=;
        b=cmAEfSBzOeDvQfpWEdOEW1Q5QjcfJwDSZCpJrMo35X847+Xjj/Z/LDfMmcd1T0Y8v/
         eN9Xvg46QC1WlmVEeKxIcQkSC5kD0ZJQ5Jg/ZnzKSWacb4Sw9lnheCaCM9ccWjwhon2P
         YZu991eDlgF3jyk7MdFhdHGhQJJ4lQgyMbN2WztbGT82Xt8+26bBLTzqxLpIAHL9HVWc
         o2ww1wEpXrSgIByZ5JdvSBZR2DcGFaLxwpjVWI8NUDIVe+sDtNko2bnfZrJObZAOlr45
         XDyL5PfCn0+SReMctE4Rvkzegw2fIWEJnU8Zb6viyNowgETPCMGyqbsdD0l2f8xwVyIG
         rUtA==
X-Gm-Message-State: AA6/9RnWw64prOqbt3YHkLiIRBQk66D0rPaV50iTWeTqOughH5tUOAycAu9rOG6ZP3dIDNdw
X-Received: by 10.66.26.49 with SMTP id i17mr13697759pag.145.1474915093928;
        Mon, 26 Sep 2016 11:38:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:2c34:dd90:c538:3321])
        by smtp.gmail.com with ESMTPSA id a137sm32751515pfa.72.2016.09.26.11.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Sep 2016 11:38:13 -0700 (PDT)
Date:   Mon, 26 Sep 2016 11:38:11 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] recursive support for ls-files
Message-ID: <20160926183811.GA5123@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <20160925071744.2qcz7cntc7xxpjqv@sigill.intra.peff.net>
 <20160925163244.GB66080@google.com>
 <xmqqzimvygdt.fsf@gitster.mtv.corp.google.com>
 <20160926170429.GA3624@google.com>
 <xmqqponqseya.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqponqseya.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/26, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > In a previous email you mentioned that this feature should be completely
> > hidden from users, which is why I removed the command line option for
> > this latest series.
> 
> I may have said something like that; I do not recall, though, so a
> more accurate description might be "I may have said something that
> can be (mis)interpreted like so".  Sorry for the confusion.
> 
> In any case, an environment is not "completely hidden from users",
> so it is not fundamentallly different from a command line option
> anyway ;-)

No worries, I'm still trying to get a hang of all this :)
True, that wouldn't be completely hidden either.

> > If that isn't what you intended that I can
> > definitely add the option to git.c.  And you would rather we perform the
> > checking in git.c to see if a subcommand supports the prefix versus
> > silently ignoring it if it hasn't?  I'm assuming this checking would
> > also be done in git.c?
> 
> I actually do not care strongly _where_ the check happens.  It was
> just that in the subcommand dispatcher would be the single place
> that is easiest-to-implement to perform that check, that made me
> suggest that.  We already have various bits like NEEDS_WORK_TREE,
> RUN_SETUP, etc. so REJECT_EXTERNAL_PREFIX (or whatever its name be;
> I do not offhand recall current proposal) bit would fit there
> naturally, I would think.  Of course, non-built-in commands need to
> protect themselves separately, if they want to.

That makes sense.  I have an idea of where the check could be made. And
with those flags it may make sense to have the flag be an indicator that
the builtin is ready for submodule type commands ie SUPPORTS_SUBMODULES
or something along those lines.  That way we only need to add the flag
to each command as we go (instead of all commands which don't support
it) and just make sure that the flag is set if the submodule prefix
option is being used.  How does that sound?

-- 
Brandon Williams
