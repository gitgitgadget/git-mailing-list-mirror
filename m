Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D7B1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 00:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbeIFEl1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 00:41:27 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:43198 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFEl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 00:41:26 -0400
Received: by mail-oi0-f49.google.com with SMTP id b15-v6so17129135oib.10
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 17:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYF/7hsjTr67eXqPc/NwcimEeszNH+IJSOK+xppd9Rk=;
        b=Y4dYuE3W0tkQlaakHIu9+kABqy7iT17iAzfVJT6vJE7ZbU1tYmhVcgXX36ypijBaWs
         4ELbbhYV4km7Xy29dTd1yN//dKZpeUQMvH8NjBwoimYue1IuLKbh03xXAlFkL8MpDrbC
         GoL598IkO3Xjipsrc0NaEdA4prDF3gDP1zk+jq1rZsTEjUoy9r9Nt0lryoXfofK6dsT6
         RTwelhgMtjjfQNkJ42CGeYMp7bfpq9ikL6XIaDaNe02fihxB5iRf100+VSPtrtw9KhaF
         aHcg+QWIjBScDMest36BBeKGxuqgi4/njDj1DHySV062PODTQJ0wIdJccS2woytQGftq
         a5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYF/7hsjTr67eXqPc/NwcimEeszNH+IJSOK+xppd9Rk=;
        b=Bm0fyvHSwnggxnRXtGttfWbwD6+r3bnOTXJy7WVFHNsAMQ3AITHyS4xD65Qd1Xvssl
         unhzGpwyRcWGGXXmGmnxhUutw2C0cv5DXPNhVtyRMT0vxB6x3p6dKoaLGAq4zIyT4q+E
         GIUgPSkronPtHJL7y/tVgoOY0C4pf4g0t+8NkzgMnk1CtifQQGAJLaz5/TB2fVpvroOx
         /GhC2zuG0bGpS9oyiFOMfWafYNo5a5v0JEXlxGBa4gr4uaRiiNYAFVhmLTOLC9LiRo+2
         QZuXIWwoy1YC0UkcqYOUwsit5vR+pOoBPkY+an7L5uSKbRhA2Rx0Np33hwy/HcqIn3Tz
         g3lw==
X-Gm-Message-State: APzg51DwmZ+N5bhzs00YPV995jL/YZmAY/q7G5sg7ANF8aHWnnKDwdX3
        sMeO7FfR261O1vlkLT4NAsg1RabCgUuvVH7H6WJosGEo/Q==
X-Google-Smtp-Source: ANB0Vdaj7TeGOOjg87RTRcZy0XUl601WCi+aG3KLKgf8f1SiO7L4O6Tw2cIwhc0UfHBilcF8jnkpSMdseVq+3SDxuko=
X-Received: by 2002:aca:cdc2:: with SMTP id d185-v6mr183152oig.350.1536192530297;
 Wed, 05 Sep 2018 17:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1536081438.git.matvore@google.com>
 <956f0c704f5492680928f4dc9ce9411e7f80bba4.1536081438.git.matvore@google.com> <xmqqwos16li9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwos16li9.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Wed, 5 Sep 2018 17:08:37 -0700
Message-ID: <CAMfpvh+m88Qb9mAPXuVMAhuUiUdzzEzFDLZ+ee6-OtxFHf4g_g@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] list-objects-filter: implement filter tree:0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 4, 2018 at 1:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matthew DeVore <matvore@google.com> writes:
>
> > @@ -50,6 +50,10 @@ static int gently_parse_list_objects_filter(
> >                       return 0;
> >               }
> >
> > +     } else if (!strcmp(arg, "tree:0")) {
> > +             filter_options->choice = LOFC_TREE_NONE;
> > +             return 0;
> > +
>
> This is not wrong per-se, but I would have expected to see something
> like:
>
>         ... else if (skip_prefix(arg, "tree:", &param)) {
>                 unsigned long depth;
>                 if (!git_parse_ulong(param, &depth) || depth != 0) {
>                         err = "only 'tree:0' is supported";
>                         return -1;
>                 }
>                 filter_options->choice = LOFC_TREE_NONE;
>                 return 0;
>
> so that "tree:1" is rejected not with "invalid filter-spec" but a
> bit more descriptive "only tree:0 is".  Accepting "tree:00" or
> "tree:0k" is merely an added bogus^wbonus.
>
Good idea. An interdiff for my fix is below. I didn't add a test,
since adding a shell test for every trivial error doesn't seem to
scale, but let me know if you disagree. I did of course try provoking
the error manually.

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index a28382940..14f251de4 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -50,7 +50,17 @@ static int gently_parse_list_objects_filter(
  return 0;
  }

- } else if (!strcmp(arg, "tree:0")) {
+ } else if (skip_prefix(arg, "tree:", &v0)) {
+ unsigned long depth;
+ if (!git_parse_ulong(v0, &depth) || depth != 0) {
+ if (errbuf) {
+ strbuf_init(errbuf, 0);
+ strbuf_addstr(
+ errbuf,
+ _("only 'tree:0' is supported"));
+ }
+ return 1;
+ }
  filter_options->choice = LOFC_TREE_NONE;
  return 0;
