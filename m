Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C1741F4DD
	for <e@80x24.org>; Mon, 28 Aug 2017 07:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750841AbdH1Ho3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 03:44:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:59542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750735AbdH1Ho3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 03:44:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2ED5ABB1;
        Mon, 28 Aug 2017 07:44:27 +0000 (UTC)
Subject: Re: Automatically delete branches containing accepted patches?
To:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
References: <8AF4A868-628B-42AE-B75E-4DF19F7C7A89@gmail.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <5c316336-19b4-c78e-6d14-001c2ff1c34c@suse.de>
Date:   Mon, 28 Aug 2017 09:44:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <8AF4A868-628B-42AE-B75E-4DF19F7C7A89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You could rebase your branches onto the upstream branch.
Once all the patches are in, the SHA1 of the rebased branch is somewhere in the history of the upstream master.

I use a set of scripts I've written to handle multiple branches:
https://github.com/nmorey/git-topic-branches

Using namesapce it knows which branch is against which ref. You can autorebase everythinmg. It'll tell you once everything is merged upstream:
$ git auto-rebase  # alias for branch-autorebase
REBASING: dev/cbuild-cleanup on origin/master
REBASING FAILURE: dev/cbuild-cleanup on origin/master
REBASING: dev/cbuild-return-code on origin/master
REBASING: dev/suse-spec2 on origin/master
INTEGRATED UPSTREAM: dev/suse-spec2 just made it into origin/master
REBASING: dev/udev.md on origin/master
INTEGRATED UPSTREAM: dev/udev.md just made it into origin/master

You should be able to either hook up something for auto deletion, or use the few helpers to detect the merged ones and delete them


Le 27/08/2017 à 20:44, Lars Schneider a écrit :
> Hi,
>
> I have lots of git/git branches and once in a while some patches make it 
> into git/git master. If this happens I would like to delete my branch
> with the patch automatically. That's not easily possible as the hashes 
> on my branches are, of course, not the same as the hashes on git/git.
>
> How do you deal with this situation? Do you manually delete your 
> branches or do you have some clever script to share?
>
> Thanks,
> Lars

