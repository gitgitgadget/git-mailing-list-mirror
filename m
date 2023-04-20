Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FC7C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 17:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjDTRCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 13:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjDTRCD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 13:02:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E02C5
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 10:01:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-506714f2c33so16170a12.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682010118; x=1684602118;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U5rv5xnMAZ/TUZ+9YvHjG9A0bmC0k4kshO7V9m8WtqQ=;
        b=w9DJTUuamub3iVwd93l+NS4Uq3Gj1Rk9L0BeHbHN4o9lhm56R//XWBRn+teIJBF2oo
         r6RTEEaSsgDOtxXhRwCaASFfW3mPDV6wnnrFchEQzOtRlk033I/mAv6HtbVpPxZX9OEC
         9qe9FGlVo5C5jMp7COzwlJeNqCa52fpPGZas5VFTkcn5O9jsHyJw0Y+2J2o9BcSRQrv3
         ip8ZcToggF9y5uQQhQP6DxzdGtFrJ5Bp8/pIo2xgDrTGzc0yGXD6v4a8OgZ2ef9zKCZK
         zcN8llXeg9tmCezLAyr2HzrrAzXJdNIA4ngc2UGX4wToGG8F9HmYwHagpgVJ6ta9cR6V
         eWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682010118; x=1684602118;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5rv5xnMAZ/TUZ+9YvHjG9A0bmC0k4kshO7V9m8WtqQ=;
        b=Y6jz/UrvWw9XE3KM5dexIzVHeu8Y3farMedoKXA+1xyELlflvp5W+Wi2B4cmevkZKF
         Ex/LpDpJPsavP9YV2orRKTj789FHntVzD2fXCiRNXKXTU3TT14/ccnMUWRmH2xqh+Sas
         9KlcVSRUD3rYVlXMESrqSmNW+77Xxqw8Lbzabw9isBouqmrTv+yXdW1hGWJrPzB1tqda
         zZPC12G/SWeeRTSKdbN0bWIMZ4h8MxXb1lNR/Vh9hTYFKWarhiDRdjg3yNXVYwJed9QU
         xFqoz4GXWTZ7geG83tWLyhKb2bHTkaoVGFHCI2tgYrT/fd3srALD1yMk6oSdBmbAXzGd
         5CiA==
X-Gm-Message-State: AAQBX9fVZqISulndRzgQ3BH7vslR1fxXjdLCsz642l59o/c+dZKbeZN3
        mwD9fYoCiswWNMRubpG4T0S8oVxVoG+ynZCWGJiPdguxf0bmfQQq7wmXPQ==
X-Google-Smtp-Source: AKy350aJ5z9fDtlY97ZDzzJHeUNMQSqwnvsxze1ulzUx9xN1c15yp96o8Ss4bXCg0WLTCopmnNQRq0Qux7+g/Pt6CMY=
X-Received: by 2002:a05:6402:1944:b0:506:c207:c979 with SMTP id
 f4-20020a056402194400b00506c207c979mr1edz.0.1682010117147; Thu, 20 Apr 2023
 10:01:57 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Thu, 20 Apr 2023 10:01:45 -0700
Message-ID: <CAJoAoZnoz9rsEEUGoG4BKMwW7r_Q-H2JcD_SVxuA_ykDZ33J8w@mail.gmail.com>
Subject: Video conference libification eng discussion - notes from today
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks, I didn't manage to send the announcement email ahead of
time, but the meeting these notes are from happens weekly on Thursday
at 9:30am Pacific (16:30 UTC for now). Here are the notes from today:

 - What's cooking in libification?
   - Patches we sent regarding libification
- Elijah's series
(https://lore.kernel.org/git/pull.1517.git.1681614205.gitgitgadget@gmail.co=
m/)
 - What happened in the past 1-2 weeks that interested parties or
intermittent contributors need to know?
*   Emily has been working on drafting a style guide for library code,
ETA ~next week
*   Glen is removing global state from config parse, ETA ~this week
    *   When you want metadata about the current value (like scope) we
use globals instead. Working on making those actual context for the
callback
    *   Elijah: glad to see us getting rid of some of that, these
kinds of antipatterns show up all over the place when I'm working on
those refactors
*   How can we avoid introducing new globals?
    *   Elijah: for example, diffcore added a new global for actually no re=
ason
    *   Getting rid of the\_repository is so daunting
    *   Emily: should we introduce some CI rule around new globals in
the diff? Update SubmittingPatches?
    *   Glen: tests which enforce libification also make it difficult
to introduce new globals in libraries. But in some places, like
setting something across the entire process lifetime, we don't have a
better pattern to replace it with, right?
    *   Elijah: in the short term, we do have dozens of globals;
should they go in one place (so we know where to get rid of them)?
Should they go with the file that is using them the most, or
something?
    *   Emily: does putting all the globals in one place make it
easier to tell whether a given path is using a certain global?
    *   Cem: Putting it in one file makes it really easy to tell
people they shouldn't introduce a new global! E.g. adding a comment at
the top of `globals.h` like /\* are you sure you need to add a global
here? \*/
    *   Emily: can coccinelle help?
        *   Glen: probably not, coccinelle runs over all files whether
they're unchanged or not
    *   Emily: does wrapping globals in a getter that traces help?
        *   Elijah: but people will just bypass the getter, unless you
restructure the code so the accessors are the only thing that are
accessible
        *   Cem: This is basically a global to singleton conversion -
but there's no way to guarantee that new globals follow that pattern
either
    *   Emily: I'll spin this out into a separate thread after this meeting
*   Emily: Is it better to add a dependency (e.g. c-tap-harness) or to
roll our own harness in t/helper/, for unit testing libraries?
    *   What else do we have to watch out for when adding a new
dependency to the project? Clone/build times? Licensing?
    *   Glen: Maturity/stability of the library concerns me, do we
need to patch it? Do we need to fix things that are broken there?
    *   Emily: We forked stuff like khash, sha1dc, xdiff, do we
usually send patches back upstream?
        *   Elijah: xdiff died upstream, I've seen people take git's
xdiff and then publish it as standalone xdiff (because we had so many
good patches downstream)
        *   But sha1dc we try to push back upstream, and we do have it
as a submodule as well.
        *   For khash=E2=80=A6 I think we just one-time imported it
        *   Elijah: We have some other weird deps like libcurl, where
we just use it directly from the package manager (or the Makefile has
to learn about where it comes from) plus a couple more like zlib and
some other one
