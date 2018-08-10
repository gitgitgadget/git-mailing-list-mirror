Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406571F405
	for <e@80x24.org>; Fri, 10 Aug 2018 01:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeHJDkV (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 23:40:21 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:37770 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeHJDkV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 23:40:21 -0400
Received: by mail-pl0-f45.google.com with SMTP id d5-v6so3304624pll.4
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 18:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RSDyJfDWLRLjEDVXhZ6AYqEqB4G/4Rhv8ACo65KrAW4=;
        b=BY8xM0rtKmagQuodCLbs2ZWKAAE2KhsARKjnst5QgNQloNDT8KzNuuUSWCFZJtmPDJ
         oml5+XO+YM2+9eBaNGRDCBZ4E+AFkHbK5fiMXMT22j2CJXEqsKL9r5WDULY34w3lCGw8
         yzG8VYf8tWwP3avkghbrJ/A7mJxEVXQtRWCtxlwg1RZ5DQYp0ZV+n+bnyKE8RScAU0KO
         h9ynn/Cujr/vI4sq8ADuYp+opdiEnfdUt0v5yo/m5EgekGyGL6Z0SFaJvT0OthxYJosO
         t2RJkMeXzzphQy5Z1fguuYnHErGli3/BRqRDyR56Wl3yPNO5luG2eIck6hqo/470Q6ns
         Kjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RSDyJfDWLRLjEDVXhZ6AYqEqB4G/4Rhv8ACo65KrAW4=;
        b=izOuPacuwUKlKaX982Zyakw9g+H7X3prxTLuUXzAG1mzViFreEgwu/3uDJQLtFX7Bo
         /MYD0gWuHBsMWx+hlmYCSO5I7LEeKdKMBsyfSueQQNtbBW2GKyauQiq//tWYA7t88ajm
         tOT7K5FRoH13bdONjRCJsxXnsGjbL6f4+6Q4mdxmVoninpVYELNc3c1ZlG71JhfRQZAs
         kZp8Sxb/oqfzO73s4vSOLEmEDN/QgB8kAEDgAF1JeMpyOSFTZ1U9OkAHTI4xiYqvnfS8
         7YKrXiC5ZUkfTYrUAfC7MgQrN8NW+Ail3zpmPX/lCQMXdr93aqusYJGIA2EBkFYw/QHA
         BRQA==
X-Gm-Message-State: AOUpUlF6lUPPSWGglS0FMqBlaFlGrbJc2oaJhuvRRLqJE/oKNgmjUuBe
        bbPLBamLxFBqcR8+E+n+0u6JLIuO
X-Google-Smtp-Source: AA+uWPyhvRadOtD2w8angfus+rGk9n5ggrTSGeOALEy0P8exqvzxWqOSEM4NHZ4JbcOqDTgJDKOIOQ==
X-Received: by 2002:a17:902:42e2:: with SMTP id h89-v6mr4063394pld.69.1533863572436;
        Thu, 09 Aug 2018 18:12:52 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p19-v6sm18051158pgk.28.2018.08.09.18.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 18:12:51 -0700 (PDT)
Date:   Thu, 9 Aug 2018 18:12:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Bartosz Konikiewicz <izdwuut@gmail.com>, git@vger.kernel.org
Subject: Re: What's the use case for committing both the freshly created file
 and it's exclusion in .gitignore?
Message-ID: <20180810011249.GA82458@aiede.svl.corp.google.com>
References: <CAAdU=LuNn7qdXf81C3-3=0uh7NOSihm3U3dfDcXPiKxfaZMaFQ@mail.gmail.com>
 <20180809195845.GE32376@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809195845.GE32376@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> Bartosz Konikiewicz wrote:

>> Steps to reproduce:
>>
>> 1. Create a new file.
>> 2. Stage the file.
>> 3. Add the file to .gitignore.
>> 4. Stage the .gitignore.
>> 5. Commit changes.
[...]
> As far as I know, that is not an intentionally supported workflow. It is
> merely the result that .gitignore is only considered when adding new
> files to the index, not when committing nor when updating the entry for
> an existing file.

I am not sure I agree with "not intentionally supported".  It's a
little closer to "logical consequence of some intentionally features",
because:

> If you are asking as a more general case: why do we not complain about
> .gitignore for files the index already knows about, then I think that is
> useful. It lets you override the .gitignore _once_ when adding the file
> initially, and then you don't have to deal with it again (and keep in
> mind that the pattern excluding it may be broad, like "*.o", or even
> just "*", so simply deleting it from the .gitignore is not an option).

This workflow is very common.

> You could probably accomplish this these days by using a negative
> pattern in your .gitignore file. But I think the behavior in question
> may predate negative patterns (but I didn't dig). It's also a bit
> simpler to use in practice, IMHO.

Agreed about simpler, even though it's not part of any of my own
habits.

In retrospect, despite the precedent of cvsignore, calling the file
.gitignore may not have been a great idea.  Some other name that
conveys .git-prevent-me-from-accidentally-adding-these-files would
make the behavior less surprising to new users.

"git help gitignore" has some notes about this.  If you have ideas
about moments in interactive use where we could print some messages to
make the behavior less surprising, that would be very welcome.

Thanks,
Jonathan
