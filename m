Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792911F6AC
	for <e@80x24.org>; Thu,  5 Jul 2018 14:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbeGEOeG (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 10:34:06 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:42758 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753510AbeGEOeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 10:34:05 -0400
Received: by mail-yw0-f195.google.com with SMTP id y203-v6so3021969ywd.9
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kSrPBD3r1qJQco1oGMSxvXrm4ZtqKFOnSwgmKvOvj7I=;
        b=1NyXwLyzjzoSVJjrUB6C77FbhBMsp+ME5Fw50ahI0DmEX2IR+z2Ve8aNgeFUhYdyXx
         eqJd3FLAmCR+jRU9I33ypbjEefugrc9kCXz4/oNliuLTzuDG+CpNk4gyj141brJzWjiC
         UGQUtZZ7P+PSI9kOqQXorqu+4AnluX2gUQ729yltbG39mgCvO9bk1pm+ctz7Ek4kCjw3
         RHA52J8hDCTQ5cnfsT5XkyKZKNMQFsJr2LLzXJTOBuCb03FU2KMvQ2V42SkSchC7ECRL
         2+l9FDoBa56XB79cEF4tYBmR2gJ4o2Ub4BJadIYlzm0TN5BOEtNuU2LUhuHnWe8gJYzX
         qfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kSrPBD3r1qJQco1oGMSxvXrm4ZtqKFOnSwgmKvOvj7I=;
        b=tA1G8gvKFcUZQWAkgMRFmySCtwNtLJwOrXAZ+H7nWdquDlne1xdGoF552rCpk4mX5K
         55NwZ4OF1HoH7AjJoC2I2umCWYlbTfnLOcR/QsEyxtJqsQURb9KJPRU6E2hBMu/G9AvY
         tR0COzdT4eDdjgLoLTxfhk9kw8pB7+ULN+z02S/9/s68dCQThq3ug6y6iapuBStXNxLK
         losj+5zoPyFbqDzA+1hOHkf+ODxeAPhg6eiyHAsVWXE1YZl8qgC2E5YQHHJMSkjwSxis
         25obPx/OoB6uYTPRq4SKOVGPUr+IWrBJjf2zHlmalq+gXmk6kPA4oKAUr77EgW5hQDnC
         Qazw==
X-Gm-Message-State: APt69E3GBwrPW738DLSuU5Hb6Cq74LKcbMSP3kyPlGu0zJkapX09vkYl
        I7fiUJLQzQL2qO77qdQV2qmwMw==
X-Google-Smtp-Source: AAOMgpfp+qbllhFhrz8xygx4LxWkkkw2kInjGRIG0hICd6ecA4gIfaN36JU/h4NdEA5vUG879KcCBQ==
X-Received: by 2002:a81:390a:: with SMTP id g10-v6mr3051963ywa.239.1530801244484;
        Thu, 05 Jul 2018 07:34:04 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id c74-v6sm2585834ywh.17.2018.07.05.07.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 07:34:03 -0700 (PDT)
Date:   Thu, 5 Jul 2018 09:34:01 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v3 0/2] grep.c: teach --only-matching to 'git-grep(1)'
Message-ID: <20180705143401.GA87330@syl.attlocal.net>
References: <cover.1529961706.git.me@ttaylorr.com>
 <cover.1530654455.git.me@ttaylorr.com>
 <20180705142110.GA10192@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705142110.GA10192@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 05, 2018 at 10:21:11AM -0400, Jeff King wrote:
> On Tue, Jul 03, 2018 at 04:51:52PM -0500, Taylor Blau wrote:
>
> > diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> > index 0de3493b80..be13fc3253 100644
> > --- a/Documentation/git-grep.txt
> > +++ b/Documentation/git-grep.txt
> > @@ -17,7 +17,7 @@ SYNOPSIS
> >  	   [-l | --files-with-matches] [-L | --files-without-match]
> >  	   [(-O | --open-files-in-pager) [<pager>]]
> >  	   [-z | --null]
> > -	   [-c | --count] [--all-match] [-q | --quiet]
> > +	   [ -o | --only-matching ] [-c | --count] [--all-match] [-q | --quiet]
> >  	   [--max-depth <depth>]
> >  	   [--color[=<when>] | --no-color]
> >  	   [--break] [--heading] [-p | --show-function]
> > @@ -201,6 +201,10 @@ providing this option will cause it to die.
> >  	Output \0 instead of the character that normally follows a
> >  	file name.
> >
> > +-o::
> > +--only-matching::
> > +  Output only the matching part of the lines.
> > +
>
> Putting myself into the shoes of a naive reader, I have to wonder what
> happens when there are multiple matching parts on the same line. I know
> the answer from your commit message, but maybe that should be covered
> here? Maybe:
>
>   Output only the matching part of the lines. If there are multiple
>   matching parts, each is output on a separate line.

I think that this might be clear enough on its own, especially since
this is the same as BSD grep on my machine. I think that part_s_ of a
line indicates that behavior, but perhaps not. On GNU grep, this is:

  Print only the matched (non-empty) parts of a matching line, with each
  such part on a separate output line.

I'm happy to pick either and re-send this patch (2/2) again, if it
wouldn't be too much to juggle. Otherwise, I can re-roll to v4.


Thanks,
Taylor
