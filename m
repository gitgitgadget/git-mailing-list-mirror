Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EDB51F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 17:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932471AbcHXRFZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 13:05:25 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38331 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932286AbcHXRFY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 13:05:24 -0400
Received: by mail-wm0-f51.google.com with SMTP id o80so36637557wme.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=isQvpR+nV5TSQuyiRXrn0nHr7WrUStDyqLwilHuVD6s=;
        b=QfS//PqXebiAcyS/gysPVxdYH5OHkYkfwIn3+cDpGt/CEFemNaTD3LDH2zkloN016U
         YPD9aCkhQXxV4kGLi33T4wpmwriBb3TEZMMDBeC/5X3qKAmTMq4ASipIvPWlnA6UkhIr
         Ba8vx028eX4HOEogKcsi5zFZN4zYZXZv15h33YxjKYiJx8UhWHUE3z43RezZFY7meoR1
         pBHwB2i+u/y4of1RidAUBxJMbqVTRaUOkn6N5HYmhubs7E+7GaYLLnt3O4X4Ugzh5Xsw
         Gz6bNahGwgIwZHvnttqLuJrJWTlQAVYHeViSslq8VkTzh/jLukARL5p7YNKgiv5FshKh
         aMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=isQvpR+nV5TSQuyiRXrn0nHr7WrUStDyqLwilHuVD6s=;
        b=jy8HI/wKbpGU98QO9NuqqR3JrwfJNPROZ1/ukf2X3BOMYoe+xtaQ1pVzb8fHJx/NSS
         4mSse/RfWrQq2rwy04oPoCu7QFoeD35PTAd/h2pNAtv28TuuXfx06LUeJc6rZvaJBwI2
         XtmV+1aoImYAG9rUNTqftTg1fGioU28gL9kTzk8/gSzkCHUwoXLVtaZpjnnAWfz0FhZe
         IFHSs5GwO9ppD3T4klg97AplPJSvQQYenyunmgqQYb+alya+tPQIuI53td+Gy5ms7aiQ
         bIhIjEQmWFB+9c6QT2HtVE5RiblUcw8dW5fDIhErnyCEz8PhnifAZckV9pkWREeaYmPb
         WtaQ==
X-Gm-Message-State: AEkoousWqHmJXVfsL+jCuySKng0E/81OwxjN9v/un6bxDKPF2bGk2Sa92k8nkxBg6KgWGQ==
X-Received: by 10.194.82.99 with SMTP id h3mr3600087wjy.9.1472058322398;
        Wed, 24 Aug 2016 10:05:22 -0700 (PDT)
Received: from [192.168.1.26] (epy16.neoplus.adsl.tpnet.pl. [83.20.66.16])
        by smtp.googlemail.com with ESMTPSA id 17sm11571931wmf.6.2016.08.24.10.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 10:05:21 -0700 (PDT)
Subject: Re: Extending "extended SHA1" syntax to traverse through gitlinks?
To:     Josh Triplett <josh@joshtriplett.org>
References: <9bad3d13-3257-2077-a734-f985c375b8d3@gmail.com>
 <20160821142634.dorgzldjvc3qiaby@x>
 <ab6e29c1-ea6d-c1c5-e69f-867c16cc736a@gmail.com>
 <20160823065359.34cirqig56fugnwy@x>
 <b2f7ff11-23b4-1065-2207-43f736c91988@gmail.com>
 <xmqq60qqu3rl.fsf@gitster.mtv.corp.google.com>
 <b264e17a-12ff-69ca-f130-78d2635a0f85@gmail.com>
 <20160824142024.xnaehfo2spw26apj@x>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <165ac159-29e8-10d1-49ee-e5ff6543d0d2@gmail.com>
Date:   Wed, 24 Aug 2016 19:05:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160824142024.xnaehfo2spw26apj@x>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 24.08.2016 o 16:20, Josh Triplett pisze:
> On Wed, Aug 24, 2016 at 03:16:56PM +0200, Jakub Narębski wrote:
[...]
>> Not really.
>>
>> The above means only that the support for new syntax would be not
>> as easy as adding it to 'git rev-parse' (and it's built-in equivalent),
>> except for the case where submodule uses the same object database as
>> supermodule.
>>
>> So it wouldn't be as easy (on conceptual level) as adding support
>> for ':/<text>' or '<commit>^{/<text>}'.  It would be at least as
>> hard, if not harder, as adding support for '@{-1}' and its '-'
>> shortcut.
> 
> Depends on which cases you want to handle.  In the most general case,
> you'd need to find and process the applicable .gitmodules file, which
> would only work if you started from the top-level tree, not a random
> treeish.  On the other hand, in the most general case, you don't
> necessarily even have the module you need, because .git/modules only
> contains the modules the *current* version needed, not every past
> version.

There is an additional problem, namely that directory with submodule
can be renamed.

I don't know if there is an existing API, but assuming modern
git-submodule (with repository in .git/modules) you would have to
do the following steps for <revision>:<path/to/submodule>//<path>:

 * look up <revision>:.gitmodules for module which 'path'
   is <path/to/submodule>; let's say it is named <submodule>
 * check if <revision>:<path/to/submodule> commit object
   is present in .git/modules/<submodule>
 * look up this object

In the case of legacy submodule setup, with submodule repository
in the supermodule working directory, you would need:
   
 * look up <revision>:.gitmodules for module which 'path'
   is <path/to/submodule>; let's say it is named <submodule>
 * look up current .gitmodules for current path of submodule
   named <submodule>; let's say it is <new/path/submodule>
 * check of <revision>:</path/to/submodule> commit object
   is present in :(top)<new/path/submodule>/.git repository
 * look up this object

You could also check if the submodule repository (as stored
in config) is a path, and use it if it is... but that might
be going to far.


BTW. all that reminds me that gitweb should handle submodules
better.

> As an alternate approach (pun intended): treat every module in
> .git/modules as an alternate and just look up the object by hash.  

This could be a good fallback, to search through all submodules.

> Or, teach git-submodule to store all the objects for submodules in the
> supermodule's .git/objects (and teach git's reachability algorithm to
> respect refs in .git/modules, or store their refs in
> .git/refs/submodules/ or in a namespace).

And fallback to this fallback could be searching through supermodule
object repository.

Storing all objects in single repository is counter to the design
decision of submodules (though I don't remember what it was), but
it might be done.  Still, Git needs to be able to deal with legacy
situations anyway.
 
>> Josh, what was the reason behind proposing this feature? Was it
>> conceived as adding completeness to gitrevisions syntax, a low-hanging
>> fruit?  It isn't (the latter).  Or was it some problem with submodule
>> handling that you would want to use this syntax for?
> 
> This wasn't an abstract/theoretical completeness issue.  I specifically
> wanted this syntax for practical use with actual trees containing
> gitlinks, motivated by having a tool that creates and uses such
> gitlinks. :)

Could you explain what you need in more detail?  Is it a fragment
of history of submodule, a contents of a file at given point of
superproject history, diff between file-in-submodule and something
else, or what?
 
>> As for usefulness: this fills the hole in accessing submodules, one
>> that could be handled by combining plumbing-level commands.  Namely,
>> there are 5 states of submodule (as I understand it)
>>
>>  * recorded in ref / commit in supermodule
>>  * recorded in the index in supermodule
>>  - recorded in ref / commit in submodule
>>  - recorded in the index in submodule
>>  - state of worktree in submodule
>>
>> The last three can be easyly acessed by cd-ing to submodule.  The first
>> two are not easy to get, AFAIUC.
> 
> Right.  I primarily care about those first two cases, especially the
> first one: given a commit containing a gitlink, how can I easily dig
> into the linked commit?

All right.

Though you can cobble it with plumbing... just saying.

-- 
Jakub Narębski

