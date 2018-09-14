Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9B9C1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 05:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeINKtn (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 06:49:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35317 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeINKtn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 06:49:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7-v6so3840313pgf.2
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 22:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=33HfMDdsQP1OqL/Tj8eRTlCwTX0Yz6/+GgYZouO6hfg=;
        b=SrVaudCNrN4A3IQRX3LTo4EdGFHSVhyhq+jl2Q0O6vCLuEtN63vSin8+pGD+EFn6yA
         N9/NvuxJurIRpCf2rM3Ae532Wl+8dRfCDYPtec1j7wugun/480hfD3QZczK+fAbQih7r
         HEuJ7hISFi48g5UafIHERfJO9hOOWkRR25QVsAMwD+Mw8qAtldDKPF4mmPfMhpINOB6l
         73JAQ0DGgK4xnNVjBAQvztAo4WwyzrO/VUm9WwqPpCc/MHgEyLK2473QD/MJMHbi2QfR
         1sfm3jI+GSKIZH2ozQDOs8DcNN4zdKPBTvicixdxG47OCo5CjzCTEpJWT7Z+vIYBthxn
         2sRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=33HfMDdsQP1OqL/Tj8eRTlCwTX0Yz6/+GgYZouO6hfg=;
        b=abPb9SCAflycpP1W1wqIITuW6S4BtkXJstKWbPt+sk40KdjO+c0Feb/xI9wKEoFGKh
         NB51TOqGoYEo6MaQxQNY6Ekhb+kCr31DJWPYvtjEFP4bCluJu4fJIWrZIT7I9g4uhD4N
         fD1lInDNOAECteibKQ6J/F69nyDGggriH+JwqTzCmB51+WcVSZM0MXzuFPBto6oxMKpj
         bNusNszkFcu8UkAj8wZ4gG1Jj+DYh2AHi8kY1p7f6who2hB/KIlITJGyYSIRJ43afT8Y
         5lY8z9EaCEFmjgpnyQscyElXzeVNozEtD/YSmrGNEocbmZxfHOHUnPrbNNjzUusPKYEC
         1h9w==
X-Gm-Message-State: APzg51DlzQZwRSHlX8eQIIHDQtNyLLzetV0ris4xU9w6I+jD/7ojstWb
        H1OduG/oShF19O++7o2yUzA=
X-Google-Smtp-Source: ANB0VdZ/qHTmsvY3FR/EL5pwwMIOe8x3ddD88bEwM27QsoSt6h2GSXTJDew840SK1pUKRVrxTZeGww==
X-Received: by 2002:a63:4386:: with SMTP id q128-v6mr9860566pga.353.1536903414414;
        Thu, 13 Sep 2018 22:36:54 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id w16-v6sm13907814pfi.101.2018.09.13.22.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 22:36:53 -0700 (PDT)
Date:   Thu, 13 Sep 2018 22:36:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: Add proto v2 archive command with HTTP support
Message-ID: <20180914053650.GA219147@aiede.svl.corp.google.com>
References: <20180912053519.31085-1-steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912053519.31085-1-steadmon@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Josh Steadmon wrote:

> This series adds a new protocol v2 command for archiving, and allows
> this command to work over HTTP(S). This was previously discussed in [1].
> I've CCed everyone who participated in that discussion.

Yay!  Getting ready to read it now.

For the future, "git format-patch --cover-letter" does a few things
that can be nice for this kind of opening message:

- it lists the patches in the series, and a diffstat
- it puts [PATCH 0/3] in the subject line so people know what to expect

Thanks,
Jonathan

> [1]: https://public-inbox.org/git/CANq=j3tK7QeBJOC7VNWkh4+WBNibMJJp5YUkd9te5NaYwukAow@mail.gmail.com/
