Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC941F97E
	for <e@80x24.org>; Thu, 25 Jul 2019 23:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfGYXmg (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 19:42:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36821 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfGYXmf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 19:42:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so52526212wrs.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 16:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bBG3WIpL/bZs9GC2GWedT06gxvwE7nrPwhBuGjkJo4M=;
        b=gq/7+lR4l0iyiro7YE8F+jyeJqnO0PCvFTIBzFePumiHrVhFOX9pprJo0COfYChHF4
         xeXjQeEOO5VpOXOngyvejd/q9TfQoyLoVYwSCisyibHNc2DKw/X9/2n7z5PUzc3rF3fo
         SxACd4V9cIbKKGQr/EdYwIyoR7zWnF1uhS4dmmwhlngcyAKrYBQUxRoiQnHJEpJp1y2m
         n01tfpSRIs9L0zWArSOW4McyQdk49Y4HHm+XmqIBB1n9fvLIrv2UtMaobPeLXPJ4o/U3
         vJx/mY1y2B4GAX2Zopfnt+zweo38KaVnFD/iDOvSCGacJedhMgH1980bJRu71kytMX2B
         AL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bBG3WIpL/bZs9GC2GWedT06gxvwE7nrPwhBuGjkJo4M=;
        b=aD5RafoH4qKHmM9Jnt5XDWyJ9s7wOuRo1V4hvT8SuCePE/amclMSjC83fCC6kQ0bqM
         SWeHIcCeRSOSneSy6ronK7rsbMejslOwep1aloOWYm0Qbu6LqSuChqOrmjK+GGdupfCq
         Dj/WMdiSupflkarsD+adB8YUu7I1vs4IWjnocnOHo9ivV87UToUSwhKY3myeoQ0RcvZz
         vyudF5Cexth3Qz1yBSjp0ROw+c3rh8Zqr5l9Zh1sZT7/TtKbZMihx4YDVZydu/IZOqa5
         Z5vZKDCFNR+qfkPxL7y1EJziQtptVBYznOrIMoiSARyidc6TuZacZqfTW2TiacO1Zw/Y
         1h8w==
X-Gm-Message-State: APjAAAVWv85ksDV16hzen+ZQtsTQqfrRJMaYWCatZO5dM8lNAhrpBAcR
        1/myoPA4chkG7u0BcgClatE=
X-Google-Smtp-Source: APXvYqwUfUBjHK5fW2m0KaCkAwCDs8fPeXJp7FksnQF2IA8bH+c3wqEPGb13F9oYs8BWVzJLZ8krsw==
X-Received: by 2002:a5d:5644:: with SMTP id j4mr15173363wrw.144.1564098153406;
        Thu, 25 Jul 2019 16:42:33 -0700 (PDT)
Received: from szeder.dev (x4d0c2ab6.dyn.telefonica.de. [77.12.42.182])
        by smtp.gmail.com with ESMTPSA id 15sm35737547wmk.34.2019.07.25.16.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 16:42:32 -0700 (PDT)
Date:   Fri, 26 Jul 2019 01:42:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190725234229.GM20404@szeder.dev>
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1564009259.git.steadmon@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 24, 2019 at 04:06:50PM -0700, Josh Steadmon wrote:
> Changes since V2 of this series:
> * corrected commit message regarding the different schema variations
> * cleaned up the Makefile
> * added comment noting that the validator expects JSON-Lines input
> * added a --progress flag to the validator
> * improved validation error output

* replaced underscores with dashes in the command line options to be
  consistent with the rest of Git:

> 2:  3fa4e9eef8 ! 2:  97cb6a3eb4 trace2: add a schema validator for trace2 events

>      +// Traces can then be verified like so:
>      +//   trace_schema_validator \
>     -+//     --trace2_event_file /path/to/trace/output \
>     -+//     --schema_file /path/to/schema
>     ++//     --trace2-event-file /path/to/trace/output \
>     ++//     --schema-file /path/to/schema
>      +package main
>      +
>      +import (
>     @@ t/trace_schema_validator/trace_schema_validator.go (new)
>      +)
>      +
>      +// Required flags
>     -+var schemaFile = flag.String("schema_file", "", "JSON-Schema filename")
>     -+var trace2EventFile = flag.String("trace2_event_file", "", "trace2 event filename")
>     ++var schemaFile = flag.String("schema-file", "", "JSON-Schema filename")
>     ++var trace2EventFile = flag.String("trace2-event-file", "", "trace2 event filename")
>     ++var progress = flag.Int("progress", 0, "Print progress message each time we have validated this many lines. --progress=0 means no messages are printed")

> 3:  acf3aebcaa ! 3:  a07458b2e4 ci: run trace2 schema validation in the CI suite
>     @@ ci/run-build-and-tests.sh: then
>       	make test
>      +	t/trace_schema_validator/trace_schema_validator \
>      +		--trace2_event_file=${GIT_TRACE2_EVENT} \
>     -+		--schema_file=t/trace_schema_validator/strict_schema.json
>     ++		--schema_file=t/trace_schema_validator/strict_schema.json \

However, the options used in the CI script remained unchanged, and,
consequently, the build breaks with the message "flag provided but not
defined: -trace2_event_file" (nit: which doesn't begin with the prefix
"error:"):

  https://travis-ci.org/git/git/jobs/563776273#L2238

>     ++		--progress=10000
>       fi
>       
>       check_unignored_build_artifacts
> -- 
> 2.22.0.709.g102302147b-goog
> 
