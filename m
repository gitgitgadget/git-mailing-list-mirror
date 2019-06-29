Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16D21F461
	for <e@80x24.org>; Sat, 29 Jun 2019 16:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfF2Qiz (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 12:38:55 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39070 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfF2Qiz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 12:38:55 -0400
Received: by mail-vs1-f65.google.com with SMTP id u3so6140395vsh.6
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMugqz7iwctZU3kQRcJYRcd3q+jcgmr95vpMgUc6Ybc=;
        b=DgHAxwkFBAiez1aJvSa+5KCHw8KhhFcwHr4eFbl6KbRGrRmes+18KNMKoa1KOUR5GM
         do1FdiOLNIJ2vtO4joQcWfc1Fj4+MU8sUNOTjBlaThAjUUN5RShUvSjorcWHPV3qpdyr
         DfwlXqXGsEM8AHgTUKKnxCnG0D+8p20azJoPX8LXRQjIn83ZqbSths/QZqo5uj1yG3P8
         aoVDmGMThSsAt9CpWibWRJv+4IpWCEWCNQI6khHblp6sni+BUnG+7N0UB0KX50s30joK
         BjMSg/skEd+3I44jVewpiorEDSfbnRHTkBQmMxIndDDfSX8Mj7ScPdDRV1MDWG3+qcyR
         9hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMugqz7iwctZU3kQRcJYRcd3q+jcgmr95vpMgUc6Ybc=;
        b=fTeyJ8ZDpZA6VR6zYouTc5qRNu7vh+RGfab2fL57+oJxxXg2yQp8WnJg7619IVjtj9
         dB56KkvJd8YBnUBHwGoxv/FiMqwNNfDwluSkif6qXdoBqrpQ+XBEuJHsFSXW6nMbVJf8
         crGakcbzEYrkLqkGpF7KDpDsCcOSAuC3taMQril64l6Klkw4KsgTAnDJyM/r3D9zDCrw
         6EG9mDBlAWgRn+Sn5Y634cfFIXsXSoRFlnX24VoVtz6EKTCyJTiRN5fqEvy5zmiYQtW4
         2n7ThvTIm7o5rl7okL7NRqPxP5D5tIAdhinCYdc719jxnWW0FqXgHLvE6AB7azsynfd8
         rEug==
X-Gm-Message-State: APjAAAU4SrwfpDICnzRrfcBvQ17BdlrSwtPxpfsxt0lNOH6b7usrwzIs
        61j+R6nyCcFNRblsI90xJ2K8njqVoGBHVRoetmk=
X-Google-Smtp-Source: APXvYqz5Z2gUidLbm71aHLUd5GQJaCzIeMCve9zKC+wwoPktJJkMMmxfBLPIgZLvIPRhUR1vekJXXWe5IQKlbu5moN0=
X-Received: by 2002:a05:6102:252:: with SMTP id a18mr9849885vsq.53.1561826334393;
 Sat, 29 Jun 2019 09:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
 <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com> <20190628064103.GA19777@sigill.intra.peff.net>
 <20190628093751.GA3569@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1906281452251.44@tvgsbejvaqbjf.bet>
 <20190629003057.GB3094@sigill.intra.peff.net>
In-Reply-To: <20190629003057.GB3094@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 29 Jun 2019 10:38:43 -0600
Message-ID: <CABPp-BEyq-9sj_9wxLdh66BJqqjQ80a8sCpXd_cMCArAHnM7kA@mail.gmail.com>
Subject: Re: [PATCH 0/6] easy bulk commit creation in tests
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 6:32 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jun 28, 2019 at 02:53:26PM +0200, Johannes Schindelin wrote:
>
> > > > It would be nice if we had a "test_commits_bulk" that used fast-import
> > > > to create larger numbers of commits.
> > >
> > > So here's a patch to do that.
> >
> > I like the direction, especially because it would make it super easy to go
> > one step further that would probably make a huge difference on Windows: to
> > move `test_commit_bulk` to `test-tool commit-bulk`.
>
> I actually considered going directly there, but I don't think it would
> make a big difference. In the biggest case we dropped 900 processes to
> 4. If we really want to drop that to 1, we can:
>
>   - use a temp-file to avoid the left-hand-pipe subshell
>
>   - add a feature to fast-import to say "build on top of ref X", instead
>     of using to use rev-parse to manually generates a "reset" line
>     (maybe this is even possible already; I searched for it, but not
>     very hard).

It already exists; quoting the fast-import documentation:

"The special case of restarting an incremental import from the
current branch value should be written as:

            from refs/heads/branch^0

The ^0 suffix is necessary as fast-import does not permit a branch
to start from itself, and the branch is created in memory before
the from command is even read from the input. Adding ^0 will force
fast-import to resolve the commit through Git's revision parsing
library, rather than its internal branch table, thereby loading in
the existing value of the branch."

>   - add a feature to fast-import to have it check out the result of HEAD
>     if it was updated

That'd be cool if you could work out the various special cases; it'd
be nice to avoid the 'git reset --hard HEAD' afterwards that I always
do.

> The third one is a little less elegant to me, because there are a lot of
> questions about how to checkout (e.g., with "-f", what happens to
> deleted files, etc).

There's a question with deleted files?  Why wouldn't you just delete
them from the index and working tree?  The more interesting questions
to me in this case is what to do if the index or working tree were
dirty before the import started; that seems like a mess, though maybe
it's just a case where you abort before even importing.  On a similar
note, though, there could have been an untracked file that is in the
way of a now-to-be-tracked file that you might not want to lose.

Elijah
