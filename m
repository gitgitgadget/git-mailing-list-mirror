Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AC741F463
	for <e@80x24.org>; Thu, 26 Sep 2019 19:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfIZTPu (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 15:15:50 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37827 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfIZTPu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 15:15:50 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 493BEE0006;
        Thu, 26 Sep 2019 19:15:47 +0000 (UTC)
Date:   Fri, 27 Sep 2019 00:45:45 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: disable the "loose objects popup" dialog?
Message-ID: <20190926191545.ro7w6lbtlpbyxpk7@yadavpratyush.com>
References: <CAGr--=K15nUcnsJWOP87uMMjeQmTgAeO_6hnr12k2zuNQjNyBw@mail.gmail.com>
 <91e5b3b0-08f9-66a8-ebdf-90effd34c888@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91e5b3b0-08f9-66a8-ebdf-90effd34c888@kdbg.org>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/19 08:54PM, Johannes Sixt wrote:
> Am 26.09.19 um 19:31 schrieb Birger Skogeng Pedersen:
> > Every once in a while, I get the "This repository currently has
> > approximately (some number) loose objects." popup dialog.
> > 
> > I don't want to sound arrogant, but I find this popup along with the
> > dialog showing after that prints the result of the compression,
> > immensely annoying. And I've seen people mention before that they
> > would, in some casese, rather not have to deal with the dialog[0].
> > 
> > [0] https://stackoverflow.com/questions/1106529/how-to-skip-loose-object-popup-when-running-git-gui
> > 
> > I get that git-gui merely wants to resolve a performance issue. But
> > personally I'd prefer if git could just assume I always wanted to
> > compress the database, and automatically do it without bugging me with
> > the popups.
> 
> I dislike the popup, too. But I want total control over my repository:
> No automatic compression behind my back, in particular, when that
> expires reflogs, and git-gui does that.

I agree. Doing stuff like this in background by default is not the best 
idea IMHO. If the user asks explicitly, fine, but don't do it by 
default.
 
> > I propose we implement the following options in git-gui:
> > - ignore loose objects (do not show the popup), disabled by default.

Reading the Stackoverflow link, it seems this is already possible via an 
undocumented config variable "gui.gcwarning". I haven't tried using it 
though, but I see no reason for it to not work (looking at 
git-gui.sh:4141).

Maybe we should add this variable in the options dialog, so people at 
least know it exists?

> > - automatically, silently compress the database, without prompt. Also
> > disabled by default.
> 
> What about a configurable limit, but still show the dialog?

Do people really care that much about configuring this limit to warrant 
something like this? 


Talking about auto compression, would it be a better idea to let users 
disable the dialog, and then if they do want auto compression, they can 
just run a cron job (or the Windows equivalent) to do this on their 
repos? What reasons do people have to have this feature in git-gui, 
instead of running cron jobs?

-- 
Regards,
Pratyush Yadav
