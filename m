Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ABE01F404
	for <e@80x24.org>; Sun, 18 Mar 2018 01:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeCRBnG (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 21:43:06 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39672 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752295AbeCRBnF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 21:43:05 -0400
Received: by mail-qk0-f194.google.com with SMTP id j73so7554409qke.6
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 18:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=a5MJDx/rAYaGm+r7I/kKZdyLdNnPkXV6/UeqFcAT3Uw=;
        b=j4xpZu/R/hqzm1SHYRYAg5bq2DIl7hTo9opmznFMjbqtwfmeDgEYEx+wcDiuqvn4Pn
         Mve+umDmmmyeLzduyLfA4+m8+8crDzVCVDL7rJxSEgeF1T9aJ21/XE1Ld8ZrEFcJkiOv
         flO2DnTvQZINCTCfAykqZNPKXs9suIx+YxL6V/ZUiO/60A/MA4bMPiwcz36XnnJ1onGa
         jnlwheJiQ13jth7Gs6jUQb47HH3ZitigTQ2hbetp0Pr/KTn50KQuJzi8ockh1bQ546m/
         YVNP/9L5a8SnKBqswqmVAqPHR2qPepIc0nH/3awBfiALxKp6vd5Nh9OpG2kYj7e15x0b
         NFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=a5MJDx/rAYaGm+r7I/kKZdyLdNnPkXV6/UeqFcAT3Uw=;
        b=cziyjwaovHC0zSWico9lJ9Czk6TvIO97ckHEp3HXoL3ChuwwqEVn+vsI93yqycoeuA
         F4UPzHWpMB/q/lheAfNUNcCSbZrmPXSqIvwYhAQIIuKEK3OUKu9S1jC0HPjks+KYnZsX
         3yuuBI63QfDOBZOvMIecr8sFSnxQFfkI+0fN5bjCO6MKoyIz/aQ0KsmJij8pMImtt/Fe
         8pLPBbmYviEHYAf5h7JLHfGrobuhJLl3/HN2aDAqFzwnA2Qx88EdtpI7LQxD+XW1emsZ
         7/6g1bAlhH7mTDPKmcQ+yBv+A3rfTY9xtzx6iFrC4LkejioUTjeWchMlD4C0CLOZAOY8
         Svvg==
X-Gm-Message-State: AElRT7Gnc3X9XWzEC2iRcim9fR111J6aVaN/OMZRqEVYYEbDf30ObwdV
        sqezeurs/mP5b4CkjUqZbjLwQDFCp3SUysRJLO0=
X-Google-Smtp-Source: AG47ELtcXNPAoMgjkXxiyTiD4tXuRUDwSVvqvhDMpVsQJV4s5/r5gdh4YHjC3h9aKLqrV/313U3z1vbTNYnUE+cXMYM=
X-Received: by 10.55.74.2 with SMTP id x2mr10540792qka.314.1521337384385; Sat,
 17 Mar 2018 18:43:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Sat, 17 Mar 2018 18:43:03 -0700 (PDT)
In-Reply-To: <20180317191138.GE2224@hank>
References: <1520366804-28233-1-git-send-email-eddy.petrisor@gmail.com>
 <20180306202149.GA160269@aiede.svl.corp.google.com> <CAK0XTWdY6rfKu_s8Am6dh9njcFHqSAz_54PhW6V09DuGwE-h0g@mail.gmail.com>
 <20180316213323.GC2224@hank> <CAPig+cR5ncp9eMZ8krgy19A6g1Uqjx9dXTkus4r1QimD5Uwk0A@mail.gmail.com>
 <CAK0XTWcNySGgwgFgCPDnZ+m=2hfEgswHbJKYeu+LQfuQ9_=shQ@mail.gmail.com> <20180317191138.GE2224@hank>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 17 Mar 2018 21:43:03 -0400
X-Google-Sender-Auth: xj04YvbMaxdbR1JvmSRZhEVUBHs
Message-ID: <CAPig+cRPkjDhedmvzuABCLD6+umsHP1w6ptw5BrezDx-gnWDfQ@mail.gmail.com>
Subject: Re: [RFC PATCH] git-submodule.sh:cmd_update: if submodule branch
 exists, fetch that instead of default
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 3:11 PM, Thomas Gummerer <t.gummerer@gmail.com> wro=
te:
> On 03/17, Eddy Petri=C8=99or wrote:
>> vin., 16 mar. 2018, 23:44 Eric Sunshine <sunshine@sunshineco.com> a scri=
s:
>> > It may be a disservice to remove mention of git-blame and git-shortlog
>> > since git-contacts may not be suitable for everyone. Instead, perhaps
>> > advertise git-contacts as a potentially simpler alternative to the
>> > already-mentioned git-blamd & git-shortlog?
>
> Not sure how much of a disservice it would be.  I think of
> SubmittingPatches as mostly a document for new git contributors, for
> who I think we should make it as easy as possible to start
> contributing.  Interpreting the output of 'git blame' and 'git
> shortlog' feels like an extra hurdle for new contributors, especially
> if someone is not familiar with the mailing list workflow.  I do
> remember wondering exactly how I should interpret this when I sent my
> first patches.

Okay. Mentioning those commands (in addition to git-contacts) is an
opportunity to educate newcomers to Git the tool (not just to git.git
the project) about additional ways to engage in project spelunking. By
"disservice", I meant that that educational opportunity is lost.
Eddy's suggestion of reversing the order, thus mentioning git-contacts
first is a good alternative.

However, perhaps this idea of educating newcomers to Git is misplaced
in this context; such spelunking advice may be better suited to a
general Git tutorial than to SubmittingPatches which is indeed
specific to git.git. Given that reasoning, then my "disservice" view
may be wrong.

>> > Also, would it make sense to mention Felipe's git-related[1] which is
>> > the original (and now more configurable) script from which
>> > git-contacts functionality was derived?
>
> The reason I chose 'git contacts' over git-related is mainly that it
> comes available with git.  Mentioning both again makes things harder
> on new contributors who already have enough to think about when
> submitting the patch.
>
> I guess in the end it comes down to who we think the target of the
> document is.  To me it was always people new to the project, which is
> why I think the single command there makes sense.

Fair enough.
