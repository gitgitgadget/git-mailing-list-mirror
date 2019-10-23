Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285D41F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 19:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391060AbfJWTAf (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 15:00:35 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:42485 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387929AbfJWTAf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 15:00:35 -0400
X-Originating-IP: 1.186.12.46
Received: from localhost (unknown [1.186.12.46])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 472D21BF209;
        Wed, 23 Oct 2019 19:00:32 +0000 (UTC)
Date:   Thu, 24 Oct 2019 00:30:30 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] git-gui: allow undoing last revert
Message-ID: <20191023190030.6vc6sbwpwzssxgzo@yadavpratyush.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190828215725.13376-1-me@yadavpratyush.com>
 <20190828215725.13376-5-me@yadavpratyush.com>
 <CAKPyHN0Kh8eKjzXink3YtE6wRrOgpzTYyPmLnbpbxPt3LFsvig@mail.gmail.com>
 <5b62b4a7-67ad-9e5f-d4a1-9dce7bcfcb6b@kdbg.org>
 <CAKPyHN1V+gDdL=9eGvHmC7sv_bJPwv9kCvDu2f8sL_kPhAzRAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPyHN1V+gDdL=9eGvHmC7sv_bJPwv9kCvDu2f8sL_kPhAzRAg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/10/19 09:46AM, Bert Wesarg wrote:
> On Mon, Oct 21, 2019 at 9:35 PM Johannes Sixt <j6t@kdbg.org> wrote:
> >
> > Am 21.10.19 um 11:16 schrieb Bert Wesarg:
> > > Dear Pratyush,
> > >
> > > I just noticed that the 'Revert Last Hunk' menu entry is enabled in
> > > the stage-list. But I think it should be disabled, like the 'Revert
> > > Hunk' and 'Revert Line' menu entry.
> > >
> > > Can you confirm this?
> >
> > Technically, it need not be disabled because the hunk being reverted
> > does not depend on the contents of any of diffs that can be shown.
> >
> > The entry should be disabled if reverting the stored hunk fails. But to
> > know that, it would have to be tried: the file could have been edited
> > since the hunk was generated so that the reversal of the hunk fails.
> 
> But the "Undo" changes the worktree not the stage, sure it indirectly
> also changes the view of the staged content, but that is only a

I don't think the "Undo Last Revert" should affect "staged content" in 
any way. In fact, if it does, it is probably a bug.

A more detailed reply is to your other email. I just wanted to clarify 
that an undo _should not_ affect the staged content.

> secondary effect. As I only can revert in the worktree list, I think
> we should be consistent and also only allow to undo the revert in the
> worktree list.
> 
> And I think it is independent of 'does the undo apply at all' question.

-- 
Regards,
Pratyush Yadav
