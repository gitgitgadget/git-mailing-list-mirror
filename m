Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23FF81F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 22:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeKYJeO (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 04:34:14 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:36504 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeKYJeO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 04:34:14 -0500
Received: by mail-ed1-f47.google.com with SMTP id f23so12895174edb.3
        for <git@vger.kernel.org>; Sat, 24 Nov 2018 14:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=OfEMHV3oHcSrv4Gmy/r1S8b/SR3WbMSCFVGCEEaLRWg=;
        b=FThH0p9IBtx9iOT0+uTS6zcn+YSoQNvKuPR4x5JtRZ/JJcOCJvRqJUSqHD07sfiuSy
         uyUkGpBg8OnqgEqVFbE/CkUjTnPNEqIwu4//Z2asFj8/RqapsBV4tSZKX9ToXXECAUnm
         YRjhnvXHua8osb6teg2M8AgnY9IS+u9gabCXvSFAu0Am2zZzZKyjCosMn/GYfmWe784M
         XZhT42iL11FNsah8/Xt65L5CDtOEd6VG5WfHIn+WWYWP/KWu0FvniMxyMup7JcmT+luj
         OiB/HzknZ5qmpd/KmYF2Vh3DEGIVLMF4IoCv195rQCWE0RLSUt4MQkIgQSVe9cv/8Fsk
         jJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=OfEMHV3oHcSrv4Gmy/r1S8b/SR3WbMSCFVGCEEaLRWg=;
        b=b3dRcerEd8zDlVmaQtGfITrg3ng/QqG4nm5263fN+/LANsMj5RlVYSPzNiVx7Q9bFJ
         pYqEn3rJzsL8F0CO6D2UvOspRI+NvajHSRZqAn8gjmTrZVa5jBkP/5MNJeEGnEVHyp/2
         FNzYTT+CBKcV/iAiMmDYO2/vqDp9UVF/Jme1iKkfk3lS629pgG8//CGKxXpbBLq16LRO
         FIC6Qf1e+IlpOVQYTvVXvs3L3C24JTSGPRTRj3NDthKX2Atg1d33vEMf3UP80BLfGZyS
         CGuXTuj+gQLbO57i3Vh4jqvSuQIjGTHTiPkevpbi+ZHWD/JEX33dNVxTW5NOuVpxOvSj
         XyWA==
X-Gm-Message-State: AA+aEWYA/XdKi4PXOoLL8KU+ld7CZmvyx1qdh38k+ftIfLznn2qZzY4M
        B7rjj8S7rQEO06Gi/4oVXrI=
X-Google-Smtp-Source: AFSGD/VVBAMmjxehA87EBmxO1hG/SFMZgH7vMVP5t3PnvDWjSDprqB3E0jTSp0A4J1PASMuK/QEpRQ==
X-Received: by 2002:a50:880d:: with SMTP id b13mr17326658edb.68.1543099481132;
        Sat, 24 Nov 2018 14:44:41 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id g37sm9614039edb.85.2018.11.24.14.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 14:44:39 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How to efficiently backup a bare repository?
References: <CA+BUw6gjfpiHhy+jYzxeO4NDOKiMUH0XZ3-c5o7ygdKBCKWm2Q@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CA+BUw6gjfpiHhy+jYzxeO4NDOKiMUH0XZ3-c5o7ygdKBCKWm2Q@mail.gmail.com>
Date:   Sat, 24 Nov 2018 23:44:37 +0100
Message-ID: <8736rq14fe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 23 2018, Guilhem Bonnefille wrote:

> I'm managing many bare repositories for development teams.
>
> One service we want to offer is to let developers retrieve old state
> of the repository up to 30 days. For example, one developer
> (accidently) removed (push -f) a branch/tag and realize few days later
> (after vacations) that it was an error.
>
> What is the best approach to do this?
>
> Currently, we use a classical approach, backuping all the repo every
> day. But this is far from efficient as:
> - we accumulate 30th copies of the repository
> - due to packing logic of Git, even if the content is mostly similar,
> from one backup to another, there is no way to deduplicate.
>
> Is there any tricks based on reflog? Even for deleted refs (branch/tags)?
> Is there any tooling playing with the internal of git to offer such
> feature, like copying all refs in a timestamped refs directory to
> retain objects?
>
> Thanks in advance for any tips letting improve the backup.

There's no easy out of the box way to do exactly what you've
described. A few things come to mind:

a) If you can simply deny non-fast-forwards that's ideal. E.g. for some
   branches you care about, or tags. This is how most of us deal with
   this issue in practice. I.e. have some "blessed" refs that matter,
   and if someone rewinds their own topic branch that's their own
   problem.

b) You could as you touched upon have a post-receive hook that detects
   non-fast-forwards, and e.g. pushes a clobberd "master" or "v1.0" to
   some backup repo's 2018-11-24-23-39-04-master or whatever. Then users
   could grab old versions of refs from that repo. I do a similar thing
   at work to archive certain refs (old tags), but without renaming
   them.

   The advantage is that you get all refs ever, the disadvantage is that
   you're not going to get a copy of the repo as it was N days ago,
   it'll need to be manually pieced together.

c) Git could be made block-level de-duplication friendly. I was planning
   to work on it, but it's a small enough itch that I didn't care, but
   initial results look promising:
   https://public-inbox.org/git/20180125002942.GA21184@sigill.intra.peff.net/

d) Note that if you're e.g. rsyncing repos that are actively being
   pushed into you're likely to sometimes end up with corrupt repos
   unless you're very careful about what you grab and in what
   order. Best to backup repos with "git fetch".

e) If you're burned by one-off cases like this dev going away for 30
   days you could bump the default expiry that comes with git from 2
   weeks to e.g. 6 weeks. It's still a manual process to recover data
   (with fsck etc), but at least it's there.
