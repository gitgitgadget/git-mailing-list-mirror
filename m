Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74EBC1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 18:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfFTSTF (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 14:19:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39232 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfFTSPo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 14:15:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so1715398pls.6
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XqI6HO8XFXyXmAIYCazOnVt253B8ZImecNAcZ8Gqa0s=;
        b=XwjWEWaaCYaXEWqvTqWlvz9n8kgq1sQ+ievliY0pbdsl1QSSpUPDUSLbRozxbelKca
         7Ne2mbgfWM/p1aEPUAC4NISt3WXHMgHc/4jznql6ctmHpcaibisrJ1r5c0ulMLHzKzW7
         SYXlOjZOIzolU/0MUFBm9M8oY6b5hEHqLFhr+3vd9oX+alB2gUb9z4bshjKYsCZMcnP8
         8P/uFNMO/RE/y0ZiBfKa2UaQxUmQkkiHUbYmmjER/XM5PrxXdutt0keeI8BRG8nTHN9u
         ukJxBY9XWRXVbowlBqKVKAL2XgDqLg5ZicZXbpY0jUh0o+fOVypXBGJbhKud3WeWvY4E
         PiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XqI6HO8XFXyXmAIYCazOnVt253B8ZImecNAcZ8Gqa0s=;
        b=qLO7kbM/vngd4piYUh/3c61BQWxaAJskEeKHKt2H75gxMMXy/Yy7/crnwVP/7HuPX1
         6Oi2MMqypYssUn2iq+n2Y7NV/IsEWRhVRnB48IVxwtvm/yjqp3cAU8OG1HJaRV4OK9le
         rtaOL5bYCneK1yd7HpQxtJDjY6IS65H9OJdIDhwLPJy2FW9gVg4hmVbclyaW29BAvFgS
         vj7e4modogPRfqwgHiUZiC/lQOqA5R28vwsMZQUV9t1W+C0abch/C9xG40u1/v/pzQY6
         8Fd0ccd0FMzrucUKxp6CEzH7jadQRw5eE2IBXynWFfl8RR5g3pRm5wa9J4Y4AtyZy1VK
         toyw==
X-Gm-Message-State: APjAAAVMPvSZG9e2J07nQxpjUv6LkhK8MbCQwUkKTTWOX7euwP+yx5Xg
        zSbmVnmVojyO7H5OMeK7I+mXfQ==
X-Google-Smtp-Source: APXvYqxZDsTDDekRVNNRkNaDBu3H6WZdsZv/IqQLOVY/tqI3atvyEwzpA+ulfK6zOYMwVWiklaNmiQ==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr123999915plf.246.1561054542963;
        Thu, 20 Jun 2019 11:15:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id b29sm157075pfr.159.2019.06.20.11.15.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 11:15:42 -0700 (PDT)
Date:   Thu, 20 Jun 2019 11:15:36 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [RFC PATCH 3/3] trace2: add a schema validator for trace2 events
Message-ID: <20190620181536.GE42943@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com
References: <cover.1560295286.git.steadmon@google.com>
 <7475c6220895d96cdc7d25d6edea70e2f978526b.1560295286.git.steadmon@google.com>
 <87v9xb7x0q.fsf@evledraar.gmail.com>
 <20190612162341.GA42943@google.com>
 <20190612191818.GB14949@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612191818.GB14949@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.06.12 15:18, Jeff King wrote:
> On Wed, Jun 12, 2019 at 09:23:41AM -0700, Josh Steadmon wrote:
> 
> > The problem with the existing validators is that they expect each file to be a
> > complete JSON entity, whereas the trace output is one object per line. You can
> > of course loop over the lines in a shell script, but in my testing this approach
> > took multiple hours on the full test suite trace output, vs. 15 minutes for the
> > implementation in this patch.
> 
> It seems like it should be easy to turn a sequence of entities into a
> single entity, with something like:
> 
>   echo '['
>   sed 's/$/,/' <one-per-line
>   echo ']'
> 
> You could even turn a sequence of files into a single entity (which
> might be even faster to validate, since it would be one invocation for
> the entire test suite) with something like:
> 
>   echo '{'
>   for fn in $FILES; do
> 	echo "\"$fn\": "
> 	cat $fn
> 	echo ","
>   done
>   echo '}'
> 
> though I suspect the resulting error messages might not be as good.
> 
> Obviously neither of those is particularly robust if the individual JSON
> is not well-formed. But then, if we are mostly interested in testing
> whether it's well-formed and expect it to be in the normal case, that
> might be a good optimization.

Yeah, as I noted in my reply to Ævar, ~20 of the trace lines generated by the
test suite are not properly encoded. So if we do something like:

  $ GIT_TRACE2_EVENT=$(pwd)/one-per-line make test
  $ (echo '[' ; sed 's/$/,/' < one-per-line ; echo ']') > list
  $ validate list

then most validators will only tell us that the file as a whole is malformed.
If we validate line-by-line, then we can just count how many malformed lines we
have and make sure it's within expectations.

Alternatively, we could just explicitly disable tracing on the tests that
generate the malformed traces.

> 
> I also wouldn't be surprised if "jq" could do this in a more robust way.

I'll go take a look at jq.

> -Peff
