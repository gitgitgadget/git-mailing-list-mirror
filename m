Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED08E20951
	for <e@80x24.org>; Fri, 17 Mar 2017 22:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbdCQW2r (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:28:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36473 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdCQW2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:28:46 -0400
Received: by mail-pf0-f195.google.com with SMTP id r137so6115836pfr.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 15:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TsUEKicbt1zvyxQXd+5VpVnso94nrxYUD38HlMbRD2A=;
        b=UbHgtECNW5Djri7SjPQVfU7ZtBrGyIBeRE9EI1XIRiplfFalugoWdhWQNIltJoKw3n
         0ph0P2nqf6OEVj08rvtN1muasCUqGwlzO423N9uLjoQ3wmpP8x32HZi+5EeLRqjh/6rP
         kKRPTJM1d59Wq5eTspTD9vk89qFAJn/DL6pAOBh8/0qBeTol/rWtZLg5fBvQfxn7dpbs
         MbhwurtpyCywI8K7cBwXDabDGJXIJWEwKZLJ4OG28WA6myZBHHSCUGeV2aXlILoS0mPQ
         yoDOpp7pP43cz8bWkPAzVdslFNpIiXd05koTmeu4I6W3dms//EOtNtWgah+jaXiGBY+S
         qyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TsUEKicbt1zvyxQXd+5VpVnso94nrxYUD38HlMbRD2A=;
        b=Sul5sJUDjvfbdb/fpDTWcUHiNqyqFbyB/Vao9NcYRwsj8r+HNwI1ty1IBsa/ptJcLk
         HmjTtzSl0yqrhKVAZ2w2TRhOgPoi0+//fkdkvRw3AjOmw9esyOOYfFuuYBA9J4nFiEft
         WiwPH/ezPTYGTpm4BfKW9O1MI+Xkc1DlRDWCHk9fl4s5kOPUP7xwbs/UglBEjjEEk7H9
         RO8rtMkEPI0ksyMCfSqM7zkOI9t8LieskZx9NzbZvAfW986kpdtXUWVxWStBZbixCR4Z
         0CWQYoKeU35+vS5B9hrTuiY0uHmo2yh9kJBNLhbExqOa55co8AA5bJ69AhNQiSOnLbg6
         Rcrw==
X-Gm-Message-State: AFeK/H3AHY5velwLApVeZXd5vbogWod+ykVqZJUkh2wbKtOY90X5Bv92hrzX658gsr0YcA==
X-Received: by 10.98.71.7 with SMTP id u7mr19870016pfa.76.1489789725194;
        Fri, 17 Mar 2017 15:28:45 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:cc9f:ca23:5f26:6394])
        by smtp.gmail.com with ESMTPSA id f205sm18703797pfa.35.2017.03.17.15.28.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:28:44 -0700 (PDT)
Date:   Fri, 17 Mar 2017 15:28:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     szeder.dev@gmail.com, email@benjaminfuchs.de, git@vger.kernel.org,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Subject: Re: [PATCHv4] rev-parse: add --show-superproject-working-tree
Message-ID: <20170317222842.GP26789@aiede.mtv.corp.google.com>
References: <xmqqmvcv1jz9.fsf@gitster.mtv.corp.google.com>
 <20170308230742.5185-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308230742.5185-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Add the flag --show-superproject-working-tree to git-rev-parse
> to make it easy to find out if there is a superproject. When no
> superproject exists, the output will be empty.

I'm a little late for this, but think it's better to comment late than
never.

After this patch, git rev-parse has two options relating to the working
tree:

	git rev-parse --is-inside-work-tree
	git rev-parse --show-superproject-working-tree

Is this inconsistency necessary?  Now that there is a "git worktree"
command that allows making a second working tree for the same
repository, I would have thought we had standardized on work tree as
the name in UI.

Thoughts?
Jonathan
