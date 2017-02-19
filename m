Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4859D201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 12:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbdBSMpd (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 07:45:33 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35667 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdBSMoM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 07:44:12 -0500
Received: by mail-wm0-f49.google.com with SMTP id v186so54742804wmd.0
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 04:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gal-ro.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6mOUsR1feb+IxejWK6bkL51PXWGrh2V856FfZsu61XY=;
        b=aVHqLflz7izMDYCa/6WRk4PRbbv9gkpgCRhcO/YbxnfJqIxQCI9xnI1akyUCAMbPw2
         hB3eEQ56v40RF0pCrvvsmXsfS7S3zbeS6En4oXQrzPgo9y/fL5GGL29oX+uwIv7ZBN+Z
         VoU2sygQLcMITOkZ+of0/mu0l13x7pVLceAZSrama73fGUlbTlYqA3njeyJfTXh0KqzH
         4Hphza+0cZWxpsFqZtBsYiuvFSKoYID8YuqcJvgdev+9RYmtkSPZiCAu/EMKY1FMRcn4
         soJTzG9yJO4ZvsREq4Y7sXTjL2qvUa0yJVIpGVuzggEDD1auVXGFzpH0GAog1vKT5kIf
         yyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6mOUsR1feb+IxejWK6bkL51PXWGrh2V856FfZsu61XY=;
        b=oblXQVy07mXDXM9+WkvWRDwBMwLWDzor2RwxLu+fxtYtB4moCrDXWB1MSnkiUh568q
         JjSV/IM43BgUOZAcM8aryOyuUJzHHJMGm7tup3zwhXGaF4187j7FQPWLac9CCVxENy2p
         43zMwOeDOrJxtw8vOhv9jdaxKgAqQw3E8AXN/8oOqqfdykuliC/sNmF+C2rqxlQ6+KPv
         h1x1+dlxrDZIS/eXWcmBwYXxUXVflFPhXGy1DQxLzesBQDFfSlhSe/unVragvh2NGMyb
         Ddo21YUeGCMCI9tf8/2mNxfGYrhyddR4HwZVM94gvF6KTmsZEGjJPWW0HWqdsI+p7jLh
         2Kbw==
X-Gm-Message-State: AMke39lOvSq/K06dv/8ij7+BvPbhxJgYtACMURZ7w4XT5tDHU6n3bK90oNXa4spCPOmgXsN01pSpprF9504BTQ==
X-Received: by 10.28.216.130 with SMTP id p124mr7374759wmg.58.1487508217400;
 Sun, 19 Feb 2017 04:43:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.226.6 with HTTP; Sun, 19 Feb 2017 04:43:36 -0800 (PST)
X-Originating-IP: [77.178.200.206]
In-Reply-To: <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
 <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com> <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
From:   Alex Hoffman <spec@gal.ro>
Date:   Sun, 19 Feb 2017 13:43:36 +0100
X-Google-Sender-Auth: YttHYCt2cSuhI0RiS6TRbBYjzWs
Message-ID: <CAMX8fZWarm6wqtaazkWiUeSdsw_FThxWV1U6zV0iEtssdmvrOw@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Stephan Beyer <s-beyer@gmx.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Below is a correction of the first proposed algorithm:

>--o1--o2--o3--G --X1
>    \                \
>     x1--x2--x3--x4--X2--B--
>      \              /
>       y1--y2--y3
>
Step 1a. (Unchanged) keep only the commits that:

        a) are ancestor of the "bad" commit (including the "bad" commit itself),
        b) are not ancestor of a "good" commit (excluding the "good" commits).

The following graph results:
      x1--x2--x3--x4--X2--B--
       \              /
        y1--y2--y3

Step 1b. (New) Mark all commits of the resulting graph as unconfirmed
(unconfirmed=node without good ancestors).
Mark as confirmed all descendants of commits that user marked
explicitly as good (e.g if user already marked its parent/grand
parent/... as good right before starting bisect run).
Step 1c. From all unconfirmed root commits build a set SET_GOOD of
those with any good parents in the original graph (root commit =
commit without parents in the resulting graph) and one SET_BAD for
commits with only BAD parents. To build a set means to ask explicitly
the user (or the command passed in git bisect run) whether any of its
parents is good. In the example above find out whether x1 has any good
parents or no parent at all and if so add it to SET_GOOD, otherwise to
SET_BAD.
Mark as confirmed each commit in SET_GOOD and all its descendants.
For every commit in SET_BAD delete all paths from it until to the next
confirmed commit. In the example above if x1 is in SET_BAD delete the
path x1-x3 and x1-y3. If any new root commits result (commit x4), redo
step 1c with them.


Step2. Continue the existing algorithm.

If this improvement works (i.e you do not find any bugs in it and it
is feasible to implement, which seems to me) the following would be
its advantages:
1. An assumption less, as we explicitly check the assumption.
2. It might be quicker, because we delete parts of graph that cannot
contain transitions.
3. It returns more exact results.

VG
