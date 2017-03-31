Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1346520958
	for <e@80x24.org>; Fri, 31 Mar 2017 07:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932275AbdCaHCY (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 03:02:24 -0400
Received: from smtpq5.tb.mail.iss.as9143.net ([212.54.42.168]:37859 "EHLO
        smtpq5.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932263AbdCaHCX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 03:02:23 -0400
X-Greylist: delayed 1053 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Mar 2017 03:02:22 EDT
Received: from [212.54.42.136] (helo=smtp12.tb.mail.iss.as9143.net)
        by smtpq5.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1ctqIX-0004wY-Es
        for git@vger.kernel.org; Fri, 31 Mar 2017 08:44:37 +0200
Received: from 53546d64.cm-6-5b.dynamic.ziggo.nl ([83.84.109.100] helo=jessiehernandez.com)
        by smtp12.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1ctqIX-0002Sj-Cn
        for git@vger.kernel.org; Fri, 31 Mar 2017 08:44:37 +0200
Received: by jessiehernandez.com (Postfix, from userid 112)
        id 1B29020262; Fri, 31 Mar 2017 08:44:37 +0200 (CEST)
Received: from mail.jessiehernandez.com (localhost [127.0.0.1])
        by jessiehernandez.com (Postfix) with ESMTP id 7FC022025E;
        Fri, 31 Mar 2017 08:44:26 +0200 (CEST)
Received: from 217.150.190.17
        (SquirrelMail authenticated user jessie)
        by mail.jessiehernandez.com with HTTP;
        Fri, 31 Mar 2017 08:44:27 +0200
Message-ID: <916067befdc828e5d33dd3c1817989e7.squirrel@mail.jessiehernandez.com>
In-Reply-To: <0fc69c73-73aa-5355-264b-a7c55377eec2@lanl.gov>
References: <0fc69c73-73aa-5355-264b-a7c55377eec2@lanl.gov>
Date:   Fri, 31 Mar 2017 08:44:27 +0200
Subject: Re: ttk error when starting git gui
From:   "Jessie Hernandez" <git@jessiehernandez.com>
To:     "David Shrader" <dshrader@lanl.gov>
Cc:     git@vger.kernel.org
Reply-To: git@jessiehernandez.com
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-SourceIP: 83.84.109.100
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.2 cv=NIalwwyg c=1 sm=1 tr=0 a=O0j+lLEKKvAiBX9A7DJArw==:17 a=8nJEP1OIZ-IA:10 a=6Iz7jQTuP9IA:10 a=xW32CO1-kzYvlF_nd80A:9 a=wPNLvfGTeEIA:10
 none
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hello,
>
> I get the following error when trying to start git gui:
>
> Error in startup script: wrong # args: should be "ttk::style theme use
> theme"
>      while executing
> "ttk::style theme use"
>      (procedure "ttext" line 4)
>      invoked from within
> "ttext $ui_workdir -background white -foreground black \
>          -borderwidth 0 \
>          -width 20 -height 10 \
>          -wrap none \
>          -takefocus 1 -highlightthickness 1\
>          ..."
>      (file
> "/home/dshrader/opt/toss2/common/git/2.12.2/libexec/git-core/git-gui"
> line 3190)
>
> I get this error with the latest released version 2.12.2. Two older git
> versions are also available on this system, and neither has this issue.
> Those older versions are 1.7.1 and 2.3.3. I don't see a call to ttext in
> those corresponding git-gui executables, so that is probably why they
> work.
>
> Here are the steps to reproduce:
>
> 1) cd to existing git repository
> 2) run 'git gui' (no gui comes up, and the error is printed in the
> terminal)
>
> I'm running on a RHEL6 based system. Do I have an insufficient version
> of whatever git gui uses for graphics in the later versions of git? When
> I try 2.12.2 on my personal workstation running Fedora 25, I don't see
> the same issue.
>
> Thank you very much for your time,
> David

Hi David,

I also got this problem when I wanted to build and run git 2.10.x.
I have added the following change to git-gui/git-gui.sh

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 5bc21b878..5ce59ef94 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -894,7 +894,7 @@ set default_config(gui.fontui) [font configure font_ui]
 set default_config(gui.fontdiff) [font configure font_diff]
 # TODO: this option should be added to the git-config documentation
 set default_config(gui.maxfilesdisplayed) 5000
-set default_config(gui.usettk) 1
+set default_config(gui.usettk) 0
 set default_config(gui.warndetachedcommit) 1
 set default_config(gui.tabsize) 8
 set font_descs {


If you guys want I can submit it as a patch.
But i assume that 'fixing' this by disabling the feature is not really
what we want.

-----------------
Jessie Hernandez


> --
> David Shrader
> HPC-ENV High Performance Computer Systems
> Los Alamos National Lab
> Email: dshrader <at> lanl.gov
>
>

