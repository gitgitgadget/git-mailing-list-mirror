Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85E351F461
	for <e@80x24.org>; Tue, 20 Aug 2019 08:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfHTIJo (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 04:09:44 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:21478
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbfHTIJo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Aug 2019 04:09:44 -0400
X-IronPort-AV: E=Sophos;i="5.64,408,1559512800"; 
   d="scan'208";a="316712595"
Received: from dhcp-13-116.lip.ens-lyon.fr (HELO moylip) ([140.77.13.116])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2019 10:09:41 +0200
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <Matthieu.Moy@matthieu-moy.fr>,
        Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org,
        corentin.bompard@etu.univ-lyon1.fr,
        nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr
Subject: Re: [PATCH] pull, fetch: add --set-upstream option
References: <86zhoil3yw.fsf@univ-lyon1.fr>
        <20190814134629.21096-1-git@matthieu-moy.fr>
        <xmqqlfvv6417.fsf@gitster-ct.c.googlers.com>
        <86blwlcylf.fsf@matthieu-moy.fr>
        <xmqq1rxgyl99.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 20 Aug 2019 10:09:41 +0200
In-Reply-To: <xmqq1rxgyl99.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 19 Aug 2019 13:04:50 -0700")
Message-ID: <86zhk4b6m2.fsf@matthieu-moy.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> That wouldn't make the commands really easier to type IMHO, as you would
>> still have to pull at some point, so it's:
>>
>>   git remote add main http://example.com/project-main-repo
>>   git pull --set-upstream main master
>>   
>> Vs
>>
>>   git remote add --set-upstream master main http://example.com/project-main-repo
>>   git pull
>>
>> The second is a bit shorter (saves the second instance of "master"), but
>> I tend to prefer the first to avoid the overly long "git remote add"
>> command.
>
> I do not particularly care about five extra keystrokes.  The reason
> I prefer the latter more is conceptual clarity of it saying "I use
> 'remote' to set things up, and then use 'pull' to get updated" (as
> opposed to "I use 'remote' to set things half-way up, and then use
> the first 'pull' to finish setting things up and getting updated.
> I should remember that I do not need to give --set-upstream to later
> 'pull' I used to get further updates").

That's a good argument to add a similar feature to "git remote", and
it's a good idea for a microproject in the future actually. I admit I
didn't consider this possibility before this discussion, thanks.

I think I'll still appreciate having the possibility to "pull
--set-upstream" too:

* "git remote add" is ran once for a remote, "git pull --set-upstream"
  can be run several times for several branches.

* In practice, even when "remote add" supports "--set-upstream", I'll
  very likely forget it, and by the time I run "git pull", it'll be too
  late to add --set-upstream to my "remote add" command.

-- 
Matthieu Moy
https://matthieu-moy.fr/
