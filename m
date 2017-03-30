Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5456D20966
	for <e@80x24.org>; Thu, 30 Mar 2017 20:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934778AbdC3UPO (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:15:14 -0400
Received: from zandvoort.avirtualhome.com ([96.126.105.64]:46290 "EHLO
        mail.avirtualhome.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934618AbdC3UPN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:15:13 -0400
X-Greylist: delayed 1220 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Mar 2017 16:15:13 EDT
Received: from [192.168.1.161] (pool-108-40-123-60.bltmmd.fios.verizon.net [108.40.123.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.avirtualhome.com (Postfix) with ESMTPSA id 52178174C2
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 15:54:51 -0400 (EDT)
Subject: Re: ttk error when starting git gui
To:     git@vger.kernel.org
References: <0fc69c73-73aa-5355-264b-a7c55377eec2@lanl.gov>
From:   Peter van der Does <peter@avirtualhome.com>
Message-ID: <4addfbdb-1289-7958-87e5-8d8caa9febfb@avirtualhome.com>
Date:   Thu, 30 Mar 2017 15:54:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:53.0) Gecko/20100101
 Thunderbird/53.0
MIME-Version: 1.0
In-Reply-To: <0fc69c73-73aa-5355-264b-a7c55377eec2@lanl.gov>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/30/17 1:01 PM, David Shrader wrote:
> Hello,
> 
> I get the following error when trying to start git gui:
> 
> Error in startup script: wrong # args: should be "ttk::style theme use
> theme"
>     while executing
> "ttk::style theme use"
>     (procedure "ttext" line 4)
>     invoked from within
> "ttext $ui_workdir -background white -foreground black \
>         -borderwidth 0 \
>         -width 20 -height 10 \
>         -wrap none \
>         -takefocus 1 -highlightthickness 1\
>         ..."
>     (file
> "/home/dshrader/opt/toss2/common/git/2.12.2/libexec/git-core/git-gui"
> line 3190)
> 
> I get this error with the latest released version 2.12.2. Two older git
> versions are also available on this system, and neither has this issue.
> Those older versions are 1.7.1 and 2.3.3. I don't see a call to ttext in
> those corresponding git-gui executables, so that is probably why they work.
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
> 


It looks like the git gui needs TCL/TK 8.6.0 or higher. Since that
version the command 'ttk::style theme use' has been changed, which
allows the command to be run without an argument and then returning the
current theme used.
I believe RHEL6 use Tk-8.5.7 but I can't be 100% sure.

-- 
Peter van der Does

Facebook : https://www.facebook.com/petervanderdoes
Twitter  : https://twitter.com/petervanderdoes
GitHub   : https://github.com/petervanderdoes
About Me : https://about.me/petervanderdoes
