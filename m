Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA851F463
	for <e@80x24.org>; Fri, 13 Sep 2019 17:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfIMROR (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 13:14:17 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46707 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbfIMROR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 13:14:17 -0400
X-Originating-IP: 1.186.12.20
Received: from localhost (unknown [1.186.12.20])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 620BC1C0009;
        Fri, 13 Sep 2019 17:14:15 +0000 (UTC)
Date:   Fri, 13 Sep 2019 22:44:13 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] git-gui: convert new/amend commit radiobutton to
 checketton
Message-ID: <20190913171413.ofdlnwpavh6lp7l2@yadavpratyush.com>
References: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
 <20190911201500.6utotzdrwsp6qoe3@yadavpratyush.com>
 <CAKPyHN1YNWbZoJNTnGN4_Du+3Scf0bEpAYJyR_mB8X2fkfAwLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPyHN1YNWbZoJNTnGN4_Du+3Scf0bEpAYJyR_mB8X2fkfAwLg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09/19 09:35PM, Bert Wesarg wrote:
> On Wed, Sep 11, 2019 at 10:15 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> >
> > Typo in the subject. s/checketton/checkbutton/
> >
> > On 05/09/19 10:09PM, Bert Wesarg wrote:
> > > diff --git a/lib/index.tcl b/lib/index.tcl
> > > index b588db1..e07b7a3 100644
> > > --- a/lib/index.tcl
> > > +++ b/lib/index.tcl
> > > @@ -466,19 +466,19 @@ proc do_revert_selection {} {
> > >  }
> > >
> > >  proc do_select_commit_type {} {
> > > -     global commit_type selected_commit_type
> > > +     global commit_type commit_type_is_amend
> > >
> > > -     if {$selected_commit_type eq {new}
> > > +     if {$commit_type_is_amend == 0
> > >               && [string match amend* $commit_type]} {
> > >               create_new_commit
> > > -     } elseif {$selected_commit_type eq {amend}
> > > +     } elseif {$commit_type_is_amend == 1
> > >               && ![string match amend* $commit_type]} {
> >
> > Not exactly related to your change, but shouldn't these "string match
> > amend*" in the two ifs be assertions instead of checks? If
> > $commit_type_is_amend == 0, then $commit_type should _always_ be amend*,
> > and if $commit_type_is_amend == 1, then $commit_type should _never_ be
> > amend*.
> >
> 
> AFAIU this now is, that the former 'selected_commit_type' was also
> used as a request for the commit type, you set it to the desired one,
> than call do_select_commit_type, it will than check if a state change
> actually happen, and if it was to request an amend, which may also
> fail, it goes back to !amend.
> 
> Thus its not an assert.

Thanks for explaining. While I'm not the biggest fan of this design, 
let's just keep it this way for now.

-- 
Regards,
Pratyush Yadav
