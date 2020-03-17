Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5232DC1975A
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DEE2073E
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9pORQZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCQSAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:00:32 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:41915 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQSAb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 14:00:31 -0400
Received: by mail-lj1-f172.google.com with SMTP id o10so23981242ljc.8
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Yi82vDCD7QS1Rsc95YCsUUIT74uDD8lUBW3C5LMvRTE=;
        b=O9pORQZVIWK8Vh+xKe7ZPu+EA0zHqy5fvRuGD9PDayQ2UFbaLGzhIy71BRSPVNi3Ee
         eY74VehLDPSL5fiGLjRDNEbqIZZ8zSt4K9oZkAHflaAwan9RsmTU7MQrsZbIvf9UKf0M
         uwFF+YyJwseCv12VR2TIw4paYALM0bCp6CoKdQNeOG715cOvSXduPhEG2fUJXE9qRjyg
         3t3Ui6y6AyZMEl+pPDpWLpQpIXZ2I52SgjpBilk494QPdoaRPFs45V7jn5GfxwI4UO0g
         s/lR3chPIhF0rnUfwWA64iyFX166wHGdNiyCKRpbLFEB0n2iB0+7CEejBX8i1SjglTqj
         OCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Yi82vDCD7QS1Rsc95YCsUUIT74uDD8lUBW3C5LMvRTE=;
        b=qL2cgrILIb8pDBgktnrM/b1CwMSwNVygduyvzW0791dLg68Twr/kKJrZ8GaassnOuq
         f2bTDqeIzBrcgcKG0fzAl4oVNduCwjkPfpuEVDd0jYNvR+K918j/+UUvlKBrsJgTscjG
         AdvtPSXmt7dw9fD16CS9Bth1xxvnInylm5fYrjEyFIlNue9O8f68VNUrAmTdOci9haoW
         W12p/8dCMLZEyXrmi7vR75Gqs8zKWvYsXetwyHxSQswVbawhZhXUZXphF2oMnu2S9pii
         L0PDzSb7cwqXb8DTvFEwTfG176Yu17CmB+gegc72z0qy8sl+1QXd3Skz4kwoNlU+udsH
         KqtQ==
X-Gm-Message-State: ANhLgQ2HbIRpn1oMMgyeX+d1IYfDriLlqhdCdqy1BXHWY3yugFgEC62I
        hRxhkL8fBx4FO/rIWVYOjGgN+QQN6l0i2sq7lF8=
X-Google-Smtp-Source: ADFU+vt5EdCOkW1xKtQmg1Db5VBJ/xbYvEqTWTJvS/Cs6RWtU1vGVLbqX5lkGtBUo/3PfnzApQwJrKhdd0cgy6OgooE=
X-Received: by 2002:a05:651c:1068:: with SMTP id y8mr3749377ljm.191.1584468029867;
 Tue, 17 Mar 2020 11:00:29 -0700 (PDT)
MIME-Version: 1.0
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
Date:   Tue, 17 Mar 2020 23:30:00 +0530
Message-ID: <CAHk66fv-fRZdUFC978sKUT_b7VYi6S2f2vdTQ6iB-wcCznnBHg@mail.gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
To:     jnareb@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings Jakub

> So perhaps we should expand "Commit graph labeling for speeding up git
> commands" idea, splitting it into two possible ways of working in this
> project: the more technical 'Generation number v2', and 'Interval labels
> for commit graph' which is more of research project?  Which should be
> put first, then?

I would suggest working on generation number v2 first because:
- We ship improved performance *sooner*.
- I find it easier to shift from simpler to more complex systems.

On a personal note, I would be able to do a better job at working on generation
number v2 than on interval labels. While reading through the papers mentioned
was fun and full of a-ha moments, I find building things more
fulfilling. I would be
glad if either you or Derrick opt for mentoring it.

You could read my proposal at the link below. It is very rough and I haven't
proofread it yet. I will send out a more formal proposal once the direction
of this project is decided.

https://github.com/abhishekkumar2718/GSoC20/blob/master/graph_labelling.md

**Too long, didn't read**

- Commit graphs are small to medium-sized (compared to problem sizes observed in
graph-theory literature) sparse graphs. They have unusual properties compared
to more conventional graphs that can be exploited for better performance.

- Most of git's reachability queries are negative and using a negative-cut
filter improves performance more than a positive-cut filter.

- Implementing and maintaining a two-dimensional reachability index is hard
and does not offer justifiable performance gains.

- We plan to use corrected commit date as the generation number v2 because it is
locally computable, immutable and can be incrementally updated.

- If git ever considers a two-dimensional reachability index, either post order
DFS, GRAIL or an index based on commit date would be good starting
places to explore.

I go in more details about GRAIL, FERRARI and PReaCH, explaining
briefly how they work, their advantages, and disadvantages.

> Note that for example "Convert scripts to builtins" idea is in similar
> situation: it is also many projects in one.

Regards
Abhishek
