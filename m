Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6159020248
	for <e@80x24.org>; Fri, 19 Apr 2019 19:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfDSTGw (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 15:06:52 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:48729 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728803AbfDSTGt (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Apr 2019 15:06:49 -0400
X-IronPort-AV: E=Sophos;i="5.60,369,1549926000"; 
   d="scan'208";a="379321771"
Received: from dhcp-13-174.lip.ens-lyon.fr (HELO moylip) ([140.77.13.174])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2019 11:44:44 +0200
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     BOMPARD CORENTIN p1603631 <corentin.bompard@etu.univ-lyon1.fr>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        BERBEZIER NATHAN p1601409 <nathan.berbezier@etu.univ-lyon1.fr>,
        CHABANNE PABLO p1602176 <pablo.chabanne@etu.univ-lyon1.fr>
Subject: Re: [PATCH] [WIP/RFC] add git pull and git fetch --set-upstream
References: <20190409125205.13754-1-corentin.bompard@etu.univ-lyon1.fr>
        <20190417160138.6114-1-corentin.bompard@etu.univ-lyon1.fr>
        <36559daca9d84f7a91933add734020cd@BPMBX2013-01.univ-lyon1.fr>
        <86h8av7ian.fsf@univ-lyon1.fr>
        <04f23ebf83bd4aff90ee9ca88cec984e@BPMBX2013-01.univ-lyon1.fr>
Date:   Fri, 19 Apr 2019 11:44:44 +0200
In-Reply-To: <04f23ebf83bd4aff90ee9ca88cec984e@BPMBX2013-01.univ-lyon1.fr>
        (Junio C. Hamano's message of "Fri, 19 Apr 2019 04:46:04 +0000")
Message-ID: <867ebq72ib.fsf@univ-lyon1.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> writes:
>
>> -u::
>> --set-upstream::
>> 	For every branch that is up to date or successfully pushed, add
>> 	upstream (tracking) reference, used by argument-less
>> 	linkgit:git-pull[1] and other commands. For more information,
>> 	see `branch.<name>.merge` in linkgit:git-config[1].
>>
>> Probably the reasoning was to make a symmetry between "git push
>> --set-upstream", which mentions "pull" in the doc, and the new "git pull
>> --set-upstream". However, I do not think there should be such symmetry:
>
> Yeah, if "git push --set-upstream" affects the settings that is used
> by "git pull", then the above description is good.  Does this new
> "git pull --set-upstream" affect the settings used by "git push"?  I
> somehow did not think so.  It records the remote and branch used by
> this particular "git pull" invocation in branch.<name>.{remote,merge}
> for use by future uses of "git pull", right?

It also affects push, in the absence of a branch.<name>.pushRemote
setting (branch.<name>.remote will be used).

-- 
Matthieu Moy
https://matthieu-moy.fr/
