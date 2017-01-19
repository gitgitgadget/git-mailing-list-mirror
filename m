Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90C420A17
	for <e@80x24.org>; Thu, 19 Jan 2017 18:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbdASS0h (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 13:26:37 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34127 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753966AbdASS0g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 13:26:36 -0500
Received: by mail-pg0-f48.google.com with SMTP id 14so16114549pgg.1
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 10:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZLUBc7EGU7o4BW0N/KcQnu8KlVm43ncM6i5vSvUVOCA=;
        b=AV+/H5cYzesb9seStdDepybjtxrv2UliHkLXU682QMMYR8zuCfuc/Jyc+Tss6razNC
         VwoAlMZ1J5kOBHiRLRbokgt47ofSEmaChtMTtFjueXS7Tn1imnkYcyUgrR/Q5JjrWjrz
         fPZ5/5OD55fSj29y4uV1BQ3O7bbf/AdrFpxB+3HtJcdtTbLdU4gTbVvt4y8ETmr5M7wD
         zXJMNzP35rBU0QVOI4LwZr1rajC1fXAGaUKDv6k0oJAYyl9EAKyOguCp5744Fd3JLce+
         2im8Jny8Y6DHkbraLBi+osagm5ZUIskSmxTB0iI94Vknede6jiVy+4R5PBlIshblKMWd
         IDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZLUBc7EGU7o4BW0N/KcQnu8KlVm43ncM6i5vSvUVOCA=;
        b=gFsu2kkFLtOXDYp7YVwqKAutvVELyaP+o7rKP+jj7aX6d3rvLTmcLws3Q55gCOHO10
         57Pyjnn5S3mgOTr88ekemvnnkWFEdh7F7YBU5jKbPW9S1hsL1r/aGPIg/LkMxbQz+V3x
         Jo8MImCibg6RnN2/1CopxdwJcBkWfCL+fVxkeFv4YNa+U5MwEMzVwYKfHSMWeGUNsHlY
         6BMuJrvczr+1HfNiImJ9AlpDUQOF+cBFbVgxmdlznPnIUJqGQChCV0aZQNrYzOVzLvG6
         hRXgs/GFXpcF3dRCwkdYlkQ9IhIJK9uAx79VG3W/FdsG3pjJcI06Y7fU8c2IPXTgw2tA
         OzBg==
X-Gm-Message-State: AIkVDXKbWAzbeDnR08+Po4fWAOjRRmP1Eb+Cug+ER0wjZna3kPj9Rp5STD4PgemLpCUYMrd6
X-Received: by 10.99.167.74 with SMTP id w10mr12106220pgo.2.1484850395550;
        Thu, 19 Jan 2017 10:26:35 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:1d68:bc5d:3a1b:2ccb])
        by smtp.gmail.com with ESMTPSA id q145sm10577154pfq.22.2017.01.19.10.26.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 19 Jan 2017 10:26:34 -0800 (PST)
Date:   Thu, 19 Jan 2017 10:26:33 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [RFC 0/2] grep: make output consistent with revision syntax
Message-ID: <20170119182633.GG10641@google.com>
References: <20170119150347.3484-1-stefanha@redhat.com>
 <20170119165958.xtotlvdta7udqllb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170119165958.xtotlvdta7udqllb@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/19, Jeff King wrote:
> On Thu, Jan 19, 2017 at 03:03:45PM +0000, Stefan Hajnoczi wrote:
> 
> > git-grep(1)'s output is not consistent with git-rev-parse(1) revision syntax.
> > 
> > This means you cannot take "rev:path/to/file.c: foo();" output from git-grep(1)
> > and expect "git show rev:path/to/file.c" to work.  See the individual patches
> > for examples of command-lines that produce invalid output.
> 
> I think this is a good goal.

I agree.

> I couldn't immediately think of any cases where your patches would
> misbehave, but my initial thought was that the "/" versus ":"
> distinction is about whether the initial object is a tree or a commit.

I think this is also the case, I couldn't think of another case where
this decision wasn't based on if the object is a tree or a commit.
Interestingly enough I don't think we have any tests that exist that
test the formatting of grep's output when given a tree object since the
test suite still passes with these changes in. Which means this fix
should probably include a couple tests to ensure there's no regression
in the future.

-- 
Brandon Williams
