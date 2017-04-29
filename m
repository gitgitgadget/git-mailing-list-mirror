Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EE3C1FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 20:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2998434AbdD2USR (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 16:18:17 -0400
Received: from ikke.info ([178.21.113.177]:53262 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755816AbdD2USQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 16:18:16 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id C807A4400E5; Sat, 29 Apr 2017 22:18:13 +0200 (CEST)
Date:   Sat, 29 Apr 2017 22:18:13 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Robert Eisele <robert@xarg.org>
Cc:     git@vger.kernel.org
Subject: Re: Bug: Git rename does not work if folder naming was changed from
 lower to upper case on OSX
Message-ID: <20170429201813.GA19256@alpha.vpn.ikke.info>
References: <10d4f73b-b4bd-4cf8-5727-cdaf10ab713a@xarg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d4f73b-b4bd-4cf8-5727-cdaf10ab713a@xarg.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 29, 2017 at 12:47:13PM +0200, Robert Eisele wrote:
> Hi,
> 
> after having committed folders with lower case naming, I decided to rename
> them to upper-case names. Expecting git to detect them as renamings, it
> started a new parallel hierarchy with new files, which I had to add/commit.
> 
> It was a kinda strange behavior, which I fixed by rename the folder to
> something completely different, commit and rename the folder again to the
> desired value.
> 
> Is this an actual desired behavior or is it a bug?
> 
> Robert
> 

Note that git does not store that files are renamed. So a remove + add
is the same as a rename in git. Only git status shows it when you for
example use git mv directly, but this information is lost on commit.
Instead of storing it get relies on detecting what (parts of ) files got
renamed, copied etc.
