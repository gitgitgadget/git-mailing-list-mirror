Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536A11FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 19:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdBHTun (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 14:50:43 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:33098 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbdBHTul (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 14:50:41 -0500
Received: by mail-io0-f179.google.com with SMTP id v96so125075939ioi.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 11:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NdWtJbHXsUg0MwE21TGcKSHuMkZQvTNbaDd1dhVSlNI=;
        b=Zf51BrOvBNuvgTeqAPkGkVSs+9vBW9qn0jWhc868yF5+5TmOeX/HRtd8/fsjxtiyKN
         dLnYyA8b55wOH4PMPv5mvwGFd8gv7gUtlCw2a8l653f7LtVKRaPpe1pnCD75XX886FHH
         p0NEUVK4pjK6WyMRsbUwoAv5zH9lZ+J7Hc48Eku/ZvdLzvTVg+PC1r4WAhdhvKE24jDl
         jAQQHtQk9UUS+JurOcMEH84cuUt50nXMjRkBMb85K8o3jk6wafpQE8vyF02cDcIKoE6Y
         JlkjzNptpBh/DcycXvLAJ0jSv5ehCg9No6SB95QCrKFsXNJb+WjyPPHp9/J/RrNPJH7U
         16og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NdWtJbHXsUg0MwE21TGcKSHuMkZQvTNbaDd1dhVSlNI=;
        b=Tn6Bc/Mpixjalwrliwg0Kq5E1qqfDmdU2Q+2ibOmF0Fm6ojy6g0Cqfj8lDfPZRLgBJ
         EbHZWDjlZ+aWRsgbWW6XT1RbfcnX470ZSVGF5vI1aR/zVaJSx4a3+OBNeAAQ3CXF4l7s
         TkB0ibdOJWPw8ISAa/WdODm10pVIG/T919dGdcssA9bgh8iir/Il4DkaGMjI4/1A0ql4
         XHM9rlTGHokIU3Fe/4Or7XKF4O+7iVn//Be68qqxFL99uphW4aODOyZq4LTdOVXQcHwi
         NqG0GIu3Io3/vsaIfoUlU3XdWt80sS6lLM+aWx9xC5SrRJrwpeL5MtnJ+5P//mBpat9g
         ZX9Q==
X-Gm-Message-State: AMke39lKdAxrVjvf3fP7oeVNoPN12ofNk6e083JQO6V3dQE80hE2iAYUXXYV754z4znsEIVlseEb9o61T4LCt8h5
X-Received: by 10.107.16.14 with SMTP id y14mr10290988ioi.164.1486583440476;
 Wed, 08 Feb 2017 11:50:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 8 Feb 2017 11:50:40 -0800 (PST)
In-Reply-To: <20170208113144.8201-3-pclouds@gmail.com>
References: <20170208113144.8201-1-pclouds@gmail.com> <20170208113144.8201-3-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Feb 2017 11:50:40 -0800
Message-ID: <CAGZ79kZk1Chq1R-anz0RC+0GDEubGm5kEQOsy5bz9zwCYEi9nw@mail.gmail.com>
Subject: Re: [PATCH 2/2] worktree.c: use submodule interface to access refs
 from another worktree
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 3:31 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
> (**) At this point, we may want to rename refs *_submodule API to
> something more neutral, maybe s/_submodule/_remote/

I agree on (**), except that I am not sure if /_remote/ is a better name,
because there is already a concept of a "remote" as well as
"remote-tracking" in Git. (Usually it is not reachable on the same
FS, but resides on another machine).

So if we were to do s/_submodule/_remote/, we'd have e.g.

    for_each_ref_remote

which could mean that we do networking things to obtain the
actual remote refs or just talk about remote tracking refs.

My gut reaction would be to s/submodule/alternative/ here,
but we also have a thing called alternates already.

So we're looking for a name that describes refs for both
worktrees as well as submodules. (Not sure if we can generalize
to also include alternates, too)

And the one thing they share is that they have their refs
"not at the usual place", e.g. not at .git/refs but rather at
.git/{modules,worktrees}.

  Recently we had a tangential discussion in submodule land
  about the different places, when adding the
  "git submodule absorbgitdirs" command, that moves
  the submodule/.git directory into .git/modules/<name>.
  We chose "absorb" here as the name, because it
  was moved into the .git/ area.

So maybe one of:

    s/submodule_ref/unusual_ref/
    (to emphasize it is not a regular ref inside the repo, so:)
    s/submodule_ref/irregular_ref/

    s/resolve_ref_submodule/resolve_ref_out_of_place/
    s/resolve_ref_submodule/resolve_ref_gitlink_pointed/
    s/resolve_ref_submodule/resolve_ref_linked_pointer/

would be my current thinking.

Thanks,
Stefan
