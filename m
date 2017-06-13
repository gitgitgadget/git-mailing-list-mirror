Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A051B20401
	for <e@80x24.org>; Tue, 13 Jun 2017 01:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbdFMBiV (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 21:38:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35036 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbdFMBiV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 21:38:21 -0400
Received: by mail-pf0-f194.google.com with SMTP id s66so3648097pfs.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 18:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kev4wEAqWaT8+r+FSkpPvss8ZsBCq+QR5OKGccqTVN0=;
        b=fj3Ykq6OVgitY4P7BfAPsY8FkcNWiHhmlyA/NA1j5uLYlArNmOeuQLNSrrpljDW1PI
         k2eWshRxcvk9Q1fUkYJQiMDrMbxtW7W3xIhlbXTxKicCaLy63Cjj+bI+/e2mZaNGu/Nb
         D1tq27Ge6xridBI3nSrnEZsumKdrkrisSr4X5lpR8+RQKQ97hLZghHKD11dz7EGYw+bA
         KZjLX7PmIPC7Y1Crlk4bJbrZpZGYJkqJiKKfMI9tehcslF/U8/TFF9xCqDwmk/nQNgBg
         LZFsIdVpVY3iWngmIjgN4Rq9EYYaSXEgo3fu/61vESxfMKtRK8+Gc9RlaC3EaXj2fxWb
         nlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kev4wEAqWaT8+r+FSkpPvss8ZsBCq+QR5OKGccqTVN0=;
        b=o2+qsPzNqzPawgzNcIj3yJjTHMfopetPKKznKmWnhWBlzfzwahqvmnZjQ2CskabgbP
         5zru8FvB0k7ncuIffdbvkxXUy0y4pI3hO8nGUh0cSgt229TzIPa4Dd4cDkpAP8dtIX8T
         H8/6nULhN0HC+k5GRJYHwwg+Q+Y2X2VCrnvUF67OXxTvxEtbF6J3GwlZAQLzZ6oE4b8j
         NSXIn7/NjGKMBltEQxzamTfGiS/ph8fZhe+xk9lCa7uSVPDid2wtebaXXJfsxGYfJqSM
         y+7T7nrEpyZWs+81SSFJrYVY92sp/KUh6FAn0/9Fhz4COlKdUT0QxCxixak+f3uMA8k6
         wt6g==
X-Gm-Message-State: AODbwcDJrxohldfiStOa0SityyXkWxnvzkO7oaJWxlSxrtdAYv7uUyo4
        xtB9c2nB+sp0JQ==
X-Received: by 10.99.119.6 with SMTP id s6mr48943100pgc.215.1497317900389;
        Mon, 12 Jun 2017 18:38:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:e453:89d5:deb:c7b6])
        by smtp.gmail.com with ESMTPSA id h123sm19491231pgc.36.2017.06.12.18.38.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 18:38:19 -0700 (PDT)
Date:   Mon, 12 Jun 2017 18:38:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 4/4] config: don't implicitly use gitdir
Message-ID: <20170613013817.GE133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612213406.83247-5-bmwill@google.com>
 <20170613010518.GB133952@aiede.mtv.corp.google.com>
 <20170613012337.GH154599@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613012337.GH154599@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Brandon Williams wrote:
> On 06/12, Jonathan Nieder wrote:

>> Alternatively, could this patch rename git_config_with_options?  That
>> way any other patch in flight that calls git_config_with_options would
>> conflict with this patch, giving us an opportunity to make sure it
>> also sets git_dir.  As another nice side benefit it would make it easy
>> for someone reading the patch to verify it didn't miss any callers.
[...]
> And I don't know if I agree with renaming a function just to rename it.

I forgot to say: another way to accomplish the same thing can be to
reorder the function's arguments.  The relevant thing is to make code
that calls the function without being aware of the new requirements
fail to compile.

[...]
>> Brandon Williams wrote:

>>>  	opts.respect_includes = 1;
>>> +	if (have_git_dir())
>>> +		opts.git_dir = get_git_common_dir();
>>
>> curious: Why get_git_common_dir() instead of get_git_dir()?
>
> Needs to be commondir since the config is stored in the common git
> directory and not a per worktree git directory.

*puzzled* Why wasn't this needed before, then?  The rest of the patch
should result in no functional change, but this part seems different.

Please add some explanation to the commit message.

Thanks,
Jonathan
