Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED4B71F405
	for <e@80x24.org>; Thu, 20 Dec 2018 21:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389771AbeLTVhM (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 16:37:12 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:52448 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728808AbeLTVhM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Dec 2018 16:37:12 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ga60E-0002xh-AR; Thu, 20 Dec 2018 22:37:10 +0100
Subject: Re: rebase: Ask before doing anything not undoable
To:     Ricardo Biehl Pasquali <pasqualirb@gmail.com>,
        Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
References: <20181220173348.GA5203@localhost.localdomain>
 <20181220182653.GB4823@alpha> <20181220211147.GA7426@localhost.localdomain>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <53e97c08-1eaf-5f83-a699-5666376bb4c4@virtuell-zuhause.de>
Date:   Thu, 20 Dec 2018 22:37:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181220211147.GA7426@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1545341832;ec705715;
X-HE-SMSGID: 1ga60E-0002xh-AR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.12.2018 um 22:11 schrieb Ricardo Biehl Pasquali:
> Ccing the mailing list.
> 
> On Thu, Dec 20, 2018 at 07:26:53PM +0100, Kevin Daudt wrote:
>> It would be anoying for users to have to constantly confirm when they
>> run git rebase --continue. Rather than asking confirmation, it would be
>> better to make it easy to go back to the previous state.
> 
> I meant confirmation for --committer-date-is-author-date
> option.
> 
> As Thomas said, it should be possible to undo the action
> using reflog, although this seems not as easy as it should
> be yet.

The git rebase documentation has

ORIG_HEAD is set to point at the tip of the branch before the reset.

so doing

git reset ORIG_HEAD

does reset to the state before the rebase.

For avoiding the original problem of --co completing to
--committer-date-is-author-date I'm using the alias rc for git rebase
--continue.
