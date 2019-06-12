Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DEB71F462
	for <e@80x24.org>; Wed, 12 Jun 2019 16:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440217AbfFLQXs (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 12:23:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38263 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440150AbfFLQXs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 12:23:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so9957067pfa.5
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MAcaNd1AEPWqJ44gUO54PcnmXQPXqt4cIfsRMqBv7yY=;
        b=n5r+DkzXU3DoGb8ZwNvZMcJvBxcIbCTGa37eC5kXzGRLOcQw/kzrJGdrCp9btkgwu+
         cFmK/fc6ekQD/bFgjXrh2e8ymaODwiNWqVW9SGA4g0yOUF6tBkN5NvAxxF0oUKZdW3xu
         RvEWoqeoc1xB0ZdXC2Ca3yUar//KeRd1gJZUhppNjb0q2P7UQ+JfpY0K/LJrsZkYWDkX
         61aCpaKAnODzBOTVdG3tWKPMwBoH70DVJoZGeRJhBiYk95xTSL7V3+QNwiU5rpXQSikb
         XQlpyny9ygh9KnLK+XUHNzqpMC0hIAWclC883CEWa0b7gZs/ukH7s80jXe/zXgpSeP27
         80aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MAcaNd1AEPWqJ44gUO54PcnmXQPXqt4cIfsRMqBv7yY=;
        b=LAyqO1Q9G896T5KkQ8MQBwbwcsF89HDSLGLPtZF4haQ0HYTaHnGm9c320m3EnGeBWi
         2VrwLK8gcDT/0pCcycO9/ppSTtqBBmCGY4stZxUt7nab+Of59T49zcX0Asy5JTJcDH3/
         ba+q08FJyGXrgfcxDZdsi1FsXL43P4819/Rqf5II9zholpkzYiLyyEdr5x9VlnZfxZhj
         e75LZpFESDBxHwG0n9E/OXE7av24wLnysECqFpVT66LmaIyykdmWwhjLfp2IoDcSw/Uk
         FYTOVQ6HQV+9CiLoybsGtCyLnnbYGlzIbgF/B1fQHQJNMHhlftllgCLo5CHenBYBsnwH
         7UiA==
X-Gm-Message-State: APjAAAUE4eFSPpshieFiW/+qrS2aSreDhzaRjjORX2Fv7bJ3lxzp4tjC
        iwqUD1AW4DEjVPLaBe/L3cCVoNHoMZ4nLA==
X-Google-Smtp-Source: APXvYqzGWCAjgjrwsQ8z1Icr0yPUkdOWRQhr7aUnlbbaJ79AhouvSqMGmUU6Veo4l2t83nvZ1fKBLQ==
X-Received: by 2002:a62:82c2:: with SMTP id w185mr66945934pfd.202.1560356627041;
        Wed, 12 Jun 2019 09:23:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id m6sm19573pgr.18.2019.06.12.09.23.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 09:23:45 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:23:41 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [RFC PATCH 3/3] trace2: add a schema validator for trace2 events
Message-ID: <20190612162341.GA42943@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com
References: <cover.1560295286.git.steadmon@google.com>
 <7475c6220895d96cdc7d25d6edea70e2f978526b.1560295286.git.steadmon@google.com>
 <87v9xb7x0q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9xb7x0q.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.06.12 15:28, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jun 12 2019, Josh Steadmon wrote:
> 
> > trace_schema_validator can be used to verify that trace2 event output
> > conforms to the expectations set by the API documentation and codified
> > in event_schema.json (or strict_schema.json). This allows us to build a
> > regression test to verify that trace2 output does not change
> > unexpectedly.
> 
> Does this actually work for you? As seen in my code at
> https://public-inbox.org/git/87zhnuwdkp.fsf@evledraar.gmail.com/ our
> test suite emits various lines of JSON that aren't even validly encoded,
> so I can't imagine we're passing any sort of proper parser validatior,
> let alone a schema validator.

Yes, it seems that gojsonschema (and its dependencies) are not very strict about
encoding. I also had an alternate Python implementation, and it failed to parse
lines that were not properly encoded. I just had that version print out a
warning with the number of failed decodings. I believe it was ~20 out of 1.7M
events.

> In terms of implementation I think it would make sense to have a *.sh
> wrapper for this already, then we could test via prereqs if we have some
> of the existing validators (seems there's a list at
> https://json-schema.org/implementations.html) and e.g. run a dummy test
> against some small list of git commands, and then you could also pass it
> an env variable with "here's the trace file" so you could do:
> 
>     GIT_TRACE2_EVENT=/tmp/git.events prove <all testss> && VALIDATE_THIS=/tmp/git.events ./<that new test>.sh
> 
> And it would validate that file, if set.

The problem with the existing validators is that they expect each file to be a
complete JSON entity, whereas the trace output is one object per line. You can
of course loop over the lines in a shell script, but in my testing this approach
took multiple hours on the full test suite trace output, vs. 15 minutes for the
implementation in this patch.
