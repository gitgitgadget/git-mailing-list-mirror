Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D85DC04EBE
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0360521775
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgJHI2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 04:28:34 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48283 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHI2d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 04:28:33 -0400
X-Originating-IP: 103.82.80.144
Received: from localhost (unknown [103.82.80.144])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 760906000F;
        Thu,  8 Oct 2020 08:28:31 +0000 (UTC)
Date:   Thu, 8 Oct 2020 13:58:29 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Basic dark mode support
Message-ID: <20201008082829.h4wno3mntb4kk6oo@yadavpratyush.com>
References: <20201007111333.iojf5dbwoxbnie3z@yadavpratyush.com>
 <20201008082004.5643-1-serg.partizan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008082004.5643-1-serg.partizan@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/10/20 11:20AM, Serg Tereshchenko wrote:
> > How do you tell git-gui which theme to use? I had some trouble setting 
> > the theme and ended up adding code to source the theme files and then 
> > set the theme via `ttk::style theme use`. I hope there is a better way 
> > than that.
> 
> Yes, there is. To change theme on the fly use:
> 
>     echo '*TkTheme: clam' | xrdb -merge -
> 
> To set theme, add "*TkTheme: clam" to ~/.Xresources and run
> 
>     xrdb -merge ~/.Xresources
> 
> There is lack of dark themes in default tk installs right now,
> i'm using awdark: https://sourceforge.net/projects/tcl-awthemes/
> 
> To install theme you need to unpack it somewhere like ~/.local/share/tk-themes/awthemes
> And tell tcl where to find it.
> 
>     export TCLLIBPATH=$HOME/.local/share/tk-themes
> 
> I had to modify version numbers inside awthemes package to make in work,
> but hope it'll be fixed upstream.
> 
> Here is blog post which explains this in greater detail:
> http://blog.serindu.com/2019/03/07/applying-tk-themes-to-git-gui/

Thanks. This is a bit complicated to be honest. I don't think we can do 
much about the "installing Tk themes" part, but we can certainly make it 
easier to select an installed theme in git-gui. A config option like 
gui.tktheme would be good. Something to consider in the future...

-- 
Regards,
Pratyush Yadav
