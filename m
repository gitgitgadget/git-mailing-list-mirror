Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823261F463
	for <e@80x24.org>; Thu, 26 Sep 2019 19:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfIZTaJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 15:30:09 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39509 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbfIZTaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 15:30:09 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3E41060006;
        Thu, 26 Sep 2019 19:30:06 +0000 (UTC)
Date:   Fri, 27 Sep 2019 01:00:04 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: git-gui: automatically move focus to staged file before typing
 commit message?
Message-ID: <20190926193004.jspiirmb4ejxznjo@yadavpratyush.com>
References: <CAGr--=KMJmYtVaATFkOPcboAdkLvpZFbWAo4QAE0-uC6RL4Lqg@mail.gmail.com>
 <20190914211509.sjy6lh2rlcl32lj5@yadavpratyush.com>
 <20190914212732.plymb3vnz3dv4rmc@yadavpratyush.com>
 <CAGr--=LmhE9m9V4Dq8Zt0aXqdThzrNnWSnxWawVZiLYTKbL2ig@mail.gmail.com>
 <20190916180059.aifw5r4c4k5o5hur@yadavpratyush.com>
 <CAGr--=+SNO7GuHH-dE_ZnrJDCa8tv8EA5LMrVGwsMTRpxhzEZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=+SNO7GuHH-dE_ZnrJDCa8tv8EA5LMrVGwsMTRpxhzEZA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/19 08:33PM, Birger Skogeng Pedersen wrote:
> Honestly I'll need some help to get this one implemented. The only
> implementation I've got working currently, is to change Alt+4 key bind
> to do the following:
> - Focus the "Staged Changes" widget (which will select a path in the
> list, if it isn't focused already), then
> - Focus the "Commit Message" widget

Why are you changing the Alt+4 binding? This means your feature won't 
work for people who use the mouse to move around in the UI (which I 
suppose would be a majority).

Did you try binding a script to the FocusIn event of the commit message 
buffer? You can do this like:
  
  bind $ui_comm <FocusIn> {your_script}

I'm not sure if $ui_comm is the correct widget, but you can experiment a 
bit by printing something in your_script to find out for sure.

-- 
Regards,
Pratyush Yadav
