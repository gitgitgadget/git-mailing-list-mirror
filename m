Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A437A1FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 00:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbdBNAjx (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 19:39:53 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:34732 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdBNAjw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 19:39:52 -0500
Received: by mail-it0-f42.google.com with SMTP id k200so12505338itb.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 16:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=taDi1u33z40wdeyhC1BLVeNQ9IbbcYt5I+CzdX7oC9E=;
        b=riL/fD5/AYaq5BRsvR/t+petVYzuZ9LdPbKqI2knwh3m2QSIw8OHPJ467uqf+JF4xn
         zJI6gn8sSdhaMqtf7xGcbdh3quMangE6Y62vJ/86iAPbOhR/A1qaouvaJpD2jppJel/o
         djaJTw1mayx83PFiZWOUwyL2PJqlNdNMYmoKR2njhhTs4kF0TPQ37dSHx5JcOji66lRW
         rKCyaqFWaddZvoGYzFiDZnaE9NCgk11bdGk8yUNuaEKVe3UKpdDH27ddSs4AtuF8vnU5
         B1l5aa1tsLsOOvc4lBW2so/FmjRN1g9Kb5XUPWz7Ug1cL+14eJOos1Hh62TV9c/IAab5
         Sg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=taDi1u33z40wdeyhC1BLVeNQ9IbbcYt5I+CzdX7oC9E=;
        b=RwSd/9T87O/Txwzsu4AR1bO6Y+HPiLQrPZVMD7EEL6pbb6DoAZn2TcABaq+TXjXgDP
         I9hMLhm/vTnXiEDaecVR1tMxGjDouKpnoKVEGNyl/MgIGxckm4c1o558cXbU3p/UzmkX
         Upi/QL9szABqBDbxdS3XClm5oHFw86aO/tQYEWaLyxveVNDaVUx70gFcf8cJFMvVPyUT
         XZI8Ga4nW/yApV6wMrclHc4GzsaaXfq8vh6WoaHQHix6aoHsPupW0gD92NZ2kGJSvDS9
         TKhjTE50iYc61WMxH05CCyzaYxEA3impVEN5GWOjC9o+/0R/U7VqGlXa1SjD/nwWOmP3
         A2Ow==
X-Gm-Message-State: AMke39l86lQTEZYM/rr4ZclF1tsqLszJCE1tClg67tFTVQH4PC0vOITPJVMITZpi/4BbTKIJ
X-Received: by 10.99.234.83 with SMTP id l19mr30012005pgk.114.1487032791506;
        Mon, 13 Feb 2017 16:39:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:e866:6cde:4c31:f226])
        by smtp.gmail.com with ESMTPSA id j78sm22955965pfk.39.2017.02.13.16.39.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 16:39:50 -0800 (PST)
Date:   Mon, 13 Feb 2017 16:39:48 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC-PATCHv2] submodules: add a background story
Message-ID: <20170214003948.GA94368@google.com>
References: <20170209020855.23486-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170209020855.23486-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/08, Stefan Beller wrote:
> +STATES
> +------
> +
> +When working with submodules, you can think of them as in a state machine.
> +So each submodule can be in a different state, the following indicators are used:
> +
> +* the existence of the setting of 'submodule.<name>.url' in the
> +  superprojects configuration
> +* the existence of the submodules working tree within the
> +  working tree of the superproject
> +* the existence of the submodules git directory within the superprojects
> +  git directory at $GIT_DIR/modules/<name> or within the submodules working
> +  tree
> +
> +      State      URL config        working tree     git dir
> +      -----------------------------------------------------
> +      uninitialized    no               no           no
> +      initialized     yes               no           no
> +      populated       yes              yes          yes
> +      depopulated     yes               no          yes
> +      deinitialized    no               no          yes
> +      uninteresting    no              yes          yes
> +
> +      invalid          no              yes           no
> +      invalid         yes              yes           no
> +      -----------------------------------------------------
> +
> +The first six states can be reached by normal git usage, the latter two are
> +only shown for completeness to show all possible eight states with 3 binary
> +indicators. The states in detail:
> +
> +uninitialized::
> +The uninitialized state is the default state if no
> +'--recurse-submodules' / '--recursive'. An empty directory will be put in
> +the working tree as a place holder, such that you are reminded of the
> +existence of the submodule.
> +---
> +To transition into the initialized state
> +you can use 'git submodule init', which copies the presets from the
> +.gitmodules file into the config.
> +
> +initialized::
> +Users transitioned from the uninitialized state to this state via
> +'git submodule init', which preset the URL configuration. As these URLs
> +may not be desired in certain scenarios, this state allows to change the
> +URLs.  For example in a corporate environment you may want to run
> +
> +    sed -i s/example.org/$internal-mirror/ .git/config
> ++

Maybe we can try to brainstorm and come up with some clearer terminology
while we are at it.  I was trying to think about the "initialized" state
and I may be the only one but it seems unclear what "initialized" means.
I mean I already have all the information about a submodule in the
.gitmodules file, isn't it already initialized then?   Maybe this state
would be better named "(in)active" as a module that is interesting to a
user is "active"?

-- 
Brandon Williams
