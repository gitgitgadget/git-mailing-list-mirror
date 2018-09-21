Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661D61F453
	for <e@80x24.org>; Fri, 21 Sep 2018 05:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbeIULdJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 07:33:09 -0400
Received: from ICGRIDDB04.SEAS.UPENN.EDU ([158.130.57.72]:34180 "EHLO
        ICGRIDDB04.SEAS.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIULdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 07:33:09 -0400
Received: from [10.13.0.14] (helo=ofb.net)
        by ICGRIDDB04.SEAS.upenn.edu with esmtp (Exim 4.89)
        (envelope-from <frederik@ofb.net>)
        id 1g3EGG-0000og-PN; Fri, 21 Sep 2018 01:45:52 -0400
Received: from localhost.localdomain (unknown [173.239.75.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id 8FC0C3E868;
        Thu, 20 Sep 2018 22:45:47 -0700 (PDT)
Received: from frederik by localhost.localdomain with local (Exim 4.91)
        (envelope-from <frederik@localhost.localdomain>)
        id 1g3EGA-0000XZ-K1; Thu, 20 Sep 2018 22:45:46 -0700
Date:   Thu, 20 Sep 2018 22:45:46 -0700
From:   frederik@ofb.net
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] some documentation changes from the beginning of the
 alphabet
Message-ID: <20180921054546.GA11082@ofb.net>
Reply-To: frederik@ofb.net
References: <20180919201231.609-1-frederik@ofb.net>
 <xmqqzhwd2jcq.fsf@gitster-ct.c.googlers.com>
 <CAPig+cR04cjf-D_hUgKhOSUAhHd8py7BM4-HOyE3VttV_ufXFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cR04cjf-D_hUgKhOSUAhHd8py7BM4-HOyE3VttV_ufXFQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Patches are welcome.

I'd be happy to patch git-contacts to link to the message you just
sent, then maybe someone more qualified would know where to start... :)

Frederick

On Fri, Sep 21, 2018 at 01:18:30AM -0400, Eric Sunshine wrote:
> On Wed, Sep 19, 2018 at 6:49 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Frederick Eaton <frederik@ofb.net> writes:
> > > By the way for some reason git-contacts shows more names when I run it
> > > on the patch hash than when I give it the patch name:
> > >
> > > $ ./contrib/contacts/git-contacts 222580cb60ee64f7b81fed64ec8fbfc81952557f
> > > Sébastien Guimmara <sebastien.guimmara@gmail.com>
> > > Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> > > Eric Sunshine <sunshine@sunshineco.com>
> > > Junio C Hamano <gitster@pobox.com>
> > > $ ./contrib/contacts/git-contacts ./outgoing/0002-git-column.1-clarify-initial-description-provide-exa.patch
> > > Junio C Hamano <gitster@pobox.com>
> >
> > I've never trusted what git-contacts say, but the latter one
> > certainly looks strange [...]
> 
> I don't use git-contacts, but the first invocation isn't consulting
> just a single commit but rather a range of commits. From git-contacts
> documentation:
> 
>     Input consists of one or more patch files or revision arguments.
>     A revision argument can be a range or a single `<rev>` which is
>     interpreted as `<rev>..HEAD`, thus the same revision arguments
>     are accepted as for linkgit:git-format-patch[1]. Patch files and
>     revision arguments can be combined in the same invocation.
> 
> So, you are actually running git-contacts on the range 222580cb..HEAD,
> and 222580cb isn't even one of the patches being consulted (due to how
> the range syntax does not include the argument to the left of "..").
> To consult just that one commit, you'd want perhaps:
> 
>     git-contacts 222580cb^..222580cb
> 
> > [...] as,
> >
> >         git log --no-merges Documentation/git-column.txt
> >
> > makes it clear that I have nothing to do with it ;-).  Perhaps the
> > tool gives too much credit for Signed-off-by: footer, or something.
> 
> Since git-contacts can be used as git-send-email's --cc-cmd, it can
> potentially be invoked many times, and it's a slow command (due to all
> the "blaming" via git-blame). As an optimization, git-contacts limits
> the timeframe of the blame via git-blame's --since option, with a
> hardcoded limit of 5 years. So, the git-blame invocation made by
> git-contacts for this patch file is:
> 
>     git blame --porcelain -C -L13,+7 -L23,+7 -L43,+6 \
>         --since 5-years-ago \
>         4a189fff51b1^ -- Documentation/git-column.txt
> 
> Since the lines changed by the patch have not been touched within that
> timeframe, git-blame assigns those lines to boundary commit 128a96c984
> (Update draft release notes to 1.8.5 for the fifth batch of topics,
> 2013-09-20), which was authored by Junio, which is why he shows up as
> the only "contact".
> 
> If we remove the --since restriction:
> 
>     git blame --porcelain -C -L13,+7 -L23,+7 -L43,+6 \
>         4a189fff51b1^ -- Documentation/git-column.txt
> 
> then the lines are correctly "blamed" to Duy via commit 7e29b8254f
> (Add column layout skeleton and git-column, 2012-04-21).
> 
> The "Limitations" section of the git-contacts documentation says this:
> 
>     Several conditions controlling a person's significance are
>     currently hard-coded, such as minimum participation level (10%),
>     blame date-limiting (5 years), and `-C` level for detecting moved
>     and copied lines (a single `-C`). In the future, these conditions
>     may become configurable.
> 
> So, this sort of potential issue was understood. Felipe's
> git-related[1], from which git-contacts arose, eventually grew the
> ability to tweak these hard-coded values via command-line options. The
> same could be done for git-contacts. Patches are welcome.
> 
> [1]: https://github.com/felipec/git-related
> 
