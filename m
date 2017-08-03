Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EDE91F991
	for <e@80x24.org>; Thu,  3 Aug 2017 20:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbdHCU0G (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 16:26:06 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34511 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdHCU0F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 16:26:05 -0400
Received: by mail-lf0-f41.google.com with SMTP id g25so10758065lfh.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zlRSyvAXe34GNxmdU3EkvijnMeO/3Dk2U4KSbQQ4MD8=;
        b=LCBdikGgIXNkgxrZB/EKVUjlxIV7Yqig1mLhn+T1FuvIATF4D4hSvr4QAj4AI72rni
         yj6B+OXp4piu1yBKBg42tWKigCbRCyqQGdE8Dc4lEoA3796gMuw44onFS/PmyRwdSAJp
         aDw6gpI6wL4emIVMvnk8HFDHv/gORCvQ7mnCsg7T4vrOwkLArYiqikjof65KBbpueEIa
         B4/R7iJW/mT9bLndWmM7tbfo79s4umzJnVHES6WtuyWBPqcuuTA6ZtqPPsHOJcFgEgAD
         IsAIqHa7ivYWiewy7XePPHeP8x6iUGeFhY4JKvPAXY+ZRSQZytPurw7G7vjCaT/++dNA
         Ntmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zlRSyvAXe34GNxmdU3EkvijnMeO/3Dk2U4KSbQQ4MD8=;
        b=WB0dNkLq6SGiOHq3OvmOguQI6wRxmiu8W9nDvLiRY4yuK5s03j/wcsoNPVyfs8qUwG
         iuSIvkYngq2AdL7KV08COnxoy/AJT9xFd3Te3f+BagDJPa27MIELrCwFrhTP18pkfloO
         xD6bTOkimbwBtjRLR/7GbvBK9PpzP3/qU7o27bIlDQJ+UgqayrUHhOmFjHyzC05CVbOt
         EXPUhXJ07TetKUOAwumIRMekbya5dSZ+lqrRVcRSb1KUOHoyRwZuGLxdOnZdwJe1WUQz
         Za5bEwvxxsVMz7zSQ2Etc9bWuyjok5hHXVdlMmG4eyjdyjwEZP9V9rXDJEIIPzwh35cg
         svKw==
X-Gm-Message-State: AHYfb5iMMTvGEXq+FgFfThkGn7DJrYJlYlH2JnSDEfQ1x/X9QrtSG6KB
        1xqtmWR31DiBrZduCiV5zHLKiit1OPHm
X-Received: by 10.25.232.41 with SMTP id f41mr18191lfh.90.1501791964051; Thu,
 03 Aug 2017 13:26:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 3 Aug 2017 13:26:03 -0700 (PDT)
In-Reply-To: <20170803182000.179328-9-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com> <20170803182000.179328-1-bmwill@google.com>
 <20170803182000.179328-9-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 Aug 2017 13:26:03 -0700
Message-ID: <CAGZ79kZOLkJEJE-Rtid5LfmwgQ_AVnC0Mm-GwQJFOL+1SWB-nw@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] unpack-trees: don't respect submodule.update
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 11:19 AM, Brandon Williams <bmwill@google.com> wrote:
> The 'submodule.update' config was historically used and respected by the
> 'submodule update' command because update handled a variety of different
> ways it updated a submodule.  As we begin teaching other commands about
> submodules it makes more sense for the different settings of
> 'submodule.update' to be handled by the individual commands themselves
> (checkout, rebase, merge, etc) so it shouldn't be respected by the
> native checkout command.
>
> Also remove the overlaying of the repository's config (via using
> 'submodule_config()') from the commands which use the unpack-trees
> logic (checkout, read-tree, reset).

That was a mistake that I introduced with the checkout series.

Thanks for fixing it.
