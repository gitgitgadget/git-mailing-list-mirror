Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F64C1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 15:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbfJAPXM (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 11:23:12 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35064 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfJAPXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 11:23:11 -0400
Received: by mail-vs1-f66.google.com with SMTP id s7so9654928vsl.2
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khHDIMPMyPOJ02u4xm4i3w43TP0O+yZlzOIIRHJP6zI=;
        b=N/CgQykHw+201YO2yU76YAaEVoXYG8P2BocDiuocFkKPEXqHxIWxAxtH65yO6oi4oj
         Nftv4ICiqOIrYP8ktj/hCTNS/VZR1oB3KBTZVTinrx4omk/xwgcvLYhgIU5zMuoO0Pcy
         +w5TwXV0luej3zYZ7VyrXxOv6YiJAmNtF854MxDEbdmeh9dmnES/jCFlDtr1ZHZUAkWn
         4xVNYPBXT3OS+oyyXivfpWCqOPoPJ7iY5x7YrVq1HKCd/xsazODbumj6zs9pXkIhtvEw
         n/00/IxtE2JemtAXct48Uj+j28Qp9EHP63QJJZKLtBjPgl+DKl7xy4gHpMPxUcalgojs
         D6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khHDIMPMyPOJ02u4xm4i3w43TP0O+yZlzOIIRHJP6zI=;
        b=pXGRUbbMfRVu9afUSyiEzuhrjp95i902yEj4m1VXPEtt8jsI84j615oTvlE15fW1iR
         UCtg6bmEBIU4GnoDOWfUZadY+PzNTxXr/7f7nyhEvfaOHXm8luxfn/b5jUkXfEzydYWi
         0/xCpmX3yOTW2f2iWO2wBDhU5Q3o7S+4vH7NOSDnao3w3is0++4ELSLL3CPITRH2Ofdh
         BqqQT+VWfm8qFCEy5EqVk6oFYV9g0jlB1moajvg4+K3C5COeKnxo91HtxRV0q91Zk6B8
         fMLkUTiJySVZfNvWV3EBX/bLR0c+QMpF5tv1BOabnorjLJ7EHs8kGwqU4lxsQU85xUsq
         YBCw==
X-Gm-Message-State: APjAAAXYW/RaGlyCN3ty3OTGl1To/DxXcTDVYPiZBnLv8Xa6rk+LSkJg
        /HBneycT4MMD/ASZcTt+9epVOup9DB8X61U9i6IrXg==
X-Google-Smtp-Source: APXvYqyth43RXg9ZpwXe4RCtBCfmCTBrzoUOxMn23TnMnmuWDOY96aZ2DAdYtxm0e8r1vmde4a6sRvGiA0IM1IHUkCE=
X-Received: by 2002:a67:2e43:: with SMTP id u64mr13221868vsu.75.1569943389513;
 Tue, 01 Oct 2019 08:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <97013a71289857767100d6a4adcb39ca99b2b21b.1569873171.git.bert.wesarg@googlemail.com>
 <20191001142401.hhg5dtefj6qg66dd@yadavpratyush.com>
In-Reply-To: <20191001142401.hhg5dtefj6qg66dd@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 1 Oct 2019 17:22:57 +0200
Message-ID: <CAKPyHN2qSudnEMfokp5-BXBDU6_kcVv3aokNUYdqZOnMXYVzYw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] git-gui: use existing interface to query a path's attribute
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 1, 2019 at 4:24 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Hi,
>
> I don't see any difference between v3 and v2 of this patch. What changed
> in this version?

nothing, but 2/2 changed.

Bert

>
> On 30/09/19 09:54PM, Bert Wesarg wrote:
> > Replace the hand-coded call to git check-attr with the already provided one.
> >
> > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> > ---
> >  lib/diff.tcl | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)
> >
> > diff --git a/lib/diff.tcl b/lib/diff.tcl
> > index 958a0fa..0fd4600 100644
> > --- a/lib/diff.tcl
> > +++ b/lib/diff.tcl
> > @@ -270,19 +270,6 @@ proc show_other_diff {path w m cont_info} {
> >       }
> >  }
> >
> > -proc get_conflict_marker_size {path} {
> > -     set size 7
> > -     catch {
> > -             set fd_rc [eval [list git_read check-attr "conflict-marker-size" -- $path]]
> > -             set ret [gets $fd_rc line]
> > -             close $fd_rc
> > -             if {$ret > 0} {
> > -                     regexp {.*: conflict-marker-size: (\d+)$} $line line size
> > -             }
> > -     }
> > -     return $size
> > -}
> > -
> >  proc start_show_diff {cont_info {add_opts {}}} {
> >       global file_states file_lists
> >       global is_3way_diff is_submodule_diff diff_active repo_config
> > @@ -298,7 +285,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
> >       set is_submodule_diff 0
> >       set diff_active 1
> >       set current_diff_header {}
> > -     set conflict_size [get_conflict_marker_size $path]
> > +     set conflict_size [gitattr $path conflict-marker-size 7]
> >
> >       set cmd [list]
> >       if {$w eq $ui_index} {
> > --
> > 2.23.0.11.g242cf7f110
> >
>
> --
> Regards,
> Pratyush Yadav
