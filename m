Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A375A20756
	for <e@80x24.org>; Fri, 20 Jan 2017 23:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbdATX45 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 18:56:57 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:44584 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752294AbdATX44 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Jan 2017 18:56:56 -0500
X-Greylist: delayed 1282 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jan 2017 18:56:56 EST
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1cUiiI-0008UF-6k; Sat, 21 Jan 2017 00:35:22 +0100
Subject: Re: Idea: Add a filter option to 'git rebase'
To:     Philip Oakley <philipoakley@iee.org>,
        Git List <git@vger.kernel.org>
References: <8AED6D90D2B64AE3A63C6195CA983FE8@PhilipOakley>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <0bd00cda-65d0-eeba-d8b9-a839e76d8e88@virtuell-zuhause.de>
Date:   Sat, 21 Jan 2017 00:35:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <8AED6D90D2B64AE3A63C6195CA983FE8@PhilipOakley>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1484956616;a3aa4b1b;
X-HE-SMSGID: 1cUiiI-0008UF-6k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.01.2017 um 23:28 schrieb Philip Oakley:
> A recent question on stackoverflow
> http://stackoverflow.com/questions/41753252/drop-commits-by-commit-message-in-git-rebase
> sought to remove automatically commits that could be identified by
> relevant words in the commit message.
> 
> I had thought that the ubiquitous `git filter-branch` should be able to
> do this sort of thing. I was wrong. (It was pointed out to me that...)
> The man page notes that removing a commit via filter-branch does not
> remove the changes from following commits and directs readers to using
> `git rebase(1)`.
> 
> However the rebase command does not have any filter option to allow the
> automatic population of its TODO list with the appropriate
> pick/edit/drop/etc. values.

Well you can use an arbitrary shell command as editor, so something like

$ GIT_SEQUENCE_EDITOR="sed -i -re 's/^pick /edit /'" git rebase -i master

will change pick to edit of all commits.

Maybe that can be mentioned in the man page of rebase?
