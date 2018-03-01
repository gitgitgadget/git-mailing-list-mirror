Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539931F404
	for <e@80x24.org>; Thu,  1 Mar 2018 01:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935683AbeCABnA (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 20:43:00 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:43485 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932134AbeCABm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 20:42:59 -0500
Received: by mail-pg0-f52.google.com with SMTP id e9so1689057pgs.10
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 17:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=myLrxwp7Ayr5zQA2TKrOZO38cWpaDxBh0YH2cCRzXXM=;
        b=Imp4NbyDOn3c9XhWSZNdcx8PPwLdMeNPBCkdNYOgfAFObzSbY9tI8zZI4FW1acXJfH
         2OP58PbH8XgaLyr8MvZAfC++srlsot9bv8bzyQdtvfBdRTAFHsCalJkMc3H0oCYhxYpy
         0dPt6BAJBQ2Ls3h71xCkVzXqcJV6KengBeSS0z6kRUYJEAw1gy+SXKNCUcdhwqZq3XbU
         gx0ti6YUuRuM6j8v2TAYHoaQApPNoOpkLfVPzqsJ0UWLJW6IPpCTt4RTyqmFGeVV5l1H
         JzTWsbBb0ue7dGRPKJKI8FwKLIVUGxVVovSao+dhtFRRBmnv/fqfYmJwHNBtZjF2cykB
         oJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=myLrxwp7Ayr5zQA2TKrOZO38cWpaDxBh0YH2cCRzXXM=;
        b=SwNuhV4m7GxDSdpOLZ397CmrsYBTPc2TUjdP3pXHcYnqQ1GAQLwus2Alsj8BjYtlQK
         Y21t6N7PJpJDcZH5+XH1wwwbl0Rs6KHXSYxLQlUApdTCKT2qcETCbZeBYFNzx1mcvRQw
         NHqjZWmFq0TIuHjMInH5Sz0geHOwPSkvab161MmUs4lc0/VVQh7rSEXNM/b1xLazNFpa
         PDBY1P4fWpm2JaaFhvYKq4grOYKbJ2TFQNKsR+YoFa96Nh8Koxs1HddyiN/i/tkmheLH
         Us+A1hfAA7HCKcWnJrrX3JlHjbeUPY0ZB+ycJf9mFKe/aCNDVkFBkJ46gTOYApMMB0t2
         DUmw==
X-Gm-Message-State: APf1xPD5Z6PX5ZasN4YVsdN2341JPyjyQ3KyFK6PsKyL6ZjaDwP1vRHF
        4N2JMipQjBFsRRo5Hk34Uz66IA==
X-Google-Smtp-Source: AG47ELtJ6glI7y8MAZhIVwFtENVL6wSvHkYRlfSI+g/Z6ISayGIiZX60CAAsm/apveEyP2vIwJFwGw==
X-Received: by 10.98.202.138 with SMTP id y10mr160651pfk.184.1519868578126;
        Wed, 28 Feb 2018 17:42:58 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id r30sm5664027pff.7.2018.02.28.17.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 17:42:57 -0800 (PST)
Date:   Wed, 28 Feb 2018 17:42:56 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        igor.d.djordjevic@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: The case for two trees in a commit ("How to make rebase less
 modal")
Message-ID: <20180301014256.GD87122@google.com>
References: <CAGZ79ka6PXgs+JDicaQYWYSKgEthj0A-2bBaRcdp_0T2H+sREA@mail.gmail.com>
 <a2c44a68-9fc6-5998-6d84-aba73ea65a61@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2c44a68-9fc6-5998-6d84-aba73ea65a61@ramsayjones.plus.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01, Ramsay Jones wrote:
>
>
> On 28/02/18 23:30, Stefan Beller wrote:
> > $ git hash-object --stdin -w -t commit <<EOF
> > tree c70b4a33a0089f15eb3b38092832388d75293e86
> > parent 105d5b91138ced892765a84e771a061ede8d63b8
> > author Stefan Beller <sbeller@google.com> 1519859216 -0800
> > committer Stefan Beller <sbeller@google.com> 1519859216 -0800
> > tree 5495266479afc9a4bd9560e9feac465ed43fa63a
> > test commit
> > EOF
> > 19abfc3bf1c5d782045acf23abdf7eed81e16669
> > $ git fsck |grep 19abfc3bf1c5d782045acf23abdf7eed81e16669
> > $
> >
> > So it is technically possible to create a commit with two tree entries
> > and fsck is not complaining.
>
> Hmm, it's a while since I looked at that code, but I don't think
> you have a commit with two trees - the second 'tree <sha1>' line
> is just part of the commit message, isn't it?
>
> ATB,
> Ramsay Jones
>

Actually it doesn't look like it.  The commit msg doesn't start till
after an empty newline so that commit has an empty commit msg.  Here's
one which you can see the msg when passed to show:

git hash-object --stdin -w -t commit <<EOF
tree 76d269b57d3c4283922216f84a2850e99f561ccc
parent fa0624f79f9d5765d09598b003124b3cf0b9acdb
author Brandon Williams <bmwill@google.com> 1519859216 -0800
committer Brandon Williams <bmwill@google.com> 1519859216 -0800
tree 76d269b57d3c4283922216f84a2850e99f561ccc

This is a test commit with multiple trees
EOF

Of course the extra tree is ignored, but fsck doesn't complain and show
happily shows what it knows about.

--
Brandon Williams
