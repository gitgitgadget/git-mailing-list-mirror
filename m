Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475781F404
	for <e@80x24.org>; Thu, 16 Aug 2018 23:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeHQCoa (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 22:44:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43522 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbeHQCoa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 22:44:30 -0400
Received: by mail-pl0-f68.google.com with SMTP id x6-v6so2822865plv.10
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 16:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cCPlHTwzx2ESj2Hz5q5nrjhg9QolTRYMrOJq/OKoZEo=;
        b=knLxADGj06PEISXWIKnEEPD9fiQKieYqzx56+t62ySRiJpkC+ZOKCstafbCGs0YwTL
         fBGkrL5RKEvf/8rdj+IxEJnEDpdNXMD4d1IjyQewdfRikqY8fVgom5zVDaOs9eoS8NrS
         tzijH9IGAaI6NXNNU5GltZx8oKHesYU2MxSjRuC84VKLqz/HNi/j+Dx0OWcqyppfTJGd
         8aLpn0vcOze4PjktDaL+TudSEH3k9vxsHFY2UJ/V6DyYt1J8MIx6xBPnMquSHlrraOys
         q0t7S+V/r6y8YwdWjm4PR/N2Px8L3vSVWaPz0oS0sbZkUZWp3OFriLuzz2nPAt3Ypra6
         uenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cCPlHTwzx2ESj2Hz5q5nrjhg9QolTRYMrOJq/OKoZEo=;
        b=M0TUK8oe9NYcnJLsR5e8oxln9yDVfG9IFbfNTAXtv8Qfz/hNDH9aH0fhPhAfFp3Lth
         ojmRns131+QjH+nNQwljLGsumk0jC19gJI7XthdB9OqO/atmCSti6/MQIVDus/2v1avW
         Rg2PPHJtmtcD0GPYBNdti1clAbNFU77XBd/V+fouHSN2F7u0q67PxhVF0/uDzR6cRNjy
         P1zaImcYkAVWavyvfiWP3nmYMYeKSm2XgjHpAyjT56G/fsFtFiFXLAeWZhI32d4MWOm9
         CqYQA+FXZeXBVPuBDcAXQykBIqmVT6SUBvCvtjNnC/vzgg7wYxjqUPKzOj0eHgr88rlF
         e3kQ==
X-Gm-Message-State: AOUpUlEc8FoFX8Jg9pjdHnJdExERe+SZ07wENwRtXPRaoRirY3hwPXZ3
        3DVIrMksfnKKy3v0uSrkV5w=
X-Google-Smtp-Source: AA+uWPy9bgCoS5aucRIbTpCRB2VEMXQeOMpbgVjnaypZfyKv83YUyZ/lK6OnA3JqAZ4pNlRZ3+D75w==
X-Received: by 2002:a17:902:7247:: with SMTP id c7-v6mr31299045pll.79.1534463006500;
        Thu, 16 Aug 2018 16:43:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k64-v6sm395093pgd.47.2018.08.16.16.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 16:43:25 -0700 (PDT)
Date:   Thu, 16 Aug 2018 16:43:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Agis <agis.anast@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: git-clone removes destination path after permission deny
Message-ID: <20180816234324.GA66961@aiede.svl.corp.google.com>
References: <A1C23FEE-55CC-4888-9BD5-1C4566E83A38@gmail.com>
 <450A55F6-A4B8-4841-8814-FC7365EFE43E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450A55F6-A4B8-4841-8814-FC7365EFE43E@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Agis wrote:
> On 16 Aug 2018, at 15:08, Agis <agis.anast@gmail.com> wrote:

>>    $ mkdir foo
>>    $ git clone git@github.com:agis/private.git foo
>>    Cloning into 'foo'...
>>    Permission denied (publickey).
>>    fatal: Could not read from remote repository.
[...]
>>    $ ls foo
>>    ls: cannot access 'foo': No such file or directory
>>
>> Is this expected behavior?
[...]
> Nevermind, this is does not happen in 2.18.0. Apparently it was
> fixed somewhere between 2.11 and 2.18.

Indeed, this was fixed by v2.16.2~5^2 (clone: do not clean up
directories we didn't create, 2018-01-02).

Cc-ing the author of that change (Peff) so he can meet a happy
user of it. :)

Thanks and hope that helps,
Jonathan
