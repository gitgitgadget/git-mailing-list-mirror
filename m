Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29CD91F667
	for <e@80x24.org>; Sun, 13 Aug 2017 18:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbdHMR5j (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 13:57:39 -0400
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14]:12259 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751025AbdHMR5i (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 13 Aug 2017 13:57:38 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dgx8q-0003Dt-16
        for git@vger.kernel.org; Sun, 13 Aug 2017 19:57:36 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id whoN1v0015BuuEg01hoPFd; Sun, 13 Aug 2017 19:48:23 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id B1B3E45D4512; Sun, 13 Aug 2017 19:48:21 +0200 (CEST)
Date:   Sun, 13 Aug 2017 19:48:21 +0200
From:   Martin Koegler <martin.koegler@chello.at>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Martin Koegler <martin.koegler@chello.at>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 5/9] Convert various things to size_t
Message-ID: <20170813174821.GA30330@mail.zuhause>
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
 <1502527643-21944-5-git-send-email-martin@mail.zuhause>
 <CAN0heSqu0evvo7dFPwWvgEthoafCVZmJKbRftBbHRhtN_du4HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqu0evvo7dFPwWvgEthoafCVZmJKbRftBbHRhtN_du4HQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 12, 2017 at 03:27:21PM +0200, Martin Ågren wrote:
> On 12 August 2017 at 10:47, Martin Koegler <martin.koegler@chello.at> wrote:
> > From: Martin Koegler <martin.koegler@chello.at>
> >
> > ---
> >  bisect.c                | 2 +-
> >  blame.c                 | 2 +-
> >  builtin/fmt-merge-msg.c | 2 +-
> >  builtin/mktag.c         | 2 +-
> >  dir.c                   | 4 ++--
> >  dir.h                   | 2 +-
> >  6 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/bisect.c b/bisect.c
> > index 2549eaf..0580c82 100644
> > --- a/bisect.c
> > +++ b/bisect.c
> > @@ -131,7 +131,7 @@ static void show_list(const char *debug, int counted, int nr,
> >                 struct commit *commit = p->item;
> >                 unsigned flags = commit->object.flags;
> >                 enum object_type type;
> > -               unsigned long size;
> > +               size_t size;
> >                 char *buf = read_sha1_file(commit->object.sha1, &type, &size);
> >                 const char *subject_start;
> >                 int subject_len;
> 
> Would this need to be done in a patch where read_sha1_file is converted?

I missed this first, because it is debug code requiring a code change to be enabled. 

It probably should be merged in my second patch. On the other hand that patch is already considered too large.

Regards,
Martin
