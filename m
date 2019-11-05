Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E73811F454
	for <e@80x24.org>; Tue,  5 Nov 2019 05:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfKEFVs (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 00:21:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44346 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfKEFVs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 00:21:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id q16so8780272pll.11
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 21:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBKjzKc8+d/TkzGZMbl/ZdZfgKM3LArAR7oSxWwHdqo=;
        b=dr8r451kn3okcdbaHGSvDc/9CHRBSCUQKJxXpbr2TqKLoXyqC37UgTEJjy5pAMdLfw
         4it/R2OdyDJnrXcywM4uSb5bzebyRizFPZMexo/mASkZh5VwK3VCAzVXFpRy/Ofa7/2r
         218rwwgtkQCZ+clX7mnKvluROu1m4V9Z2LhHMyt0jEJ3V2jgXwmYG2TT6AU3ITc33klf
         mcvOMgEYfcZ5HERM6YnXM5mCqkZsYPB+sfDS+B2phcj5o9GnAkDBlqdAT9LMeF5a5rDX
         WvHVKdobs4ckWrung6NYp6g1UYY0iH+O5J15c1w1zzUS5cwe/i7Ty/2EmEIIpi/dicXl
         cz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBKjzKc8+d/TkzGZMbl/ZdZfgKM3LArAR7oSxWwHdqo=;
        b=cz0m01DGPtmbTMUpZfB/K3go7q+Y5flwQo1jcts/JYenu/pHXXBYanlpWrInYdDdB5
         Yia7yEX/lhf2pmJ6trryLoCYTZ1bpSEHupDSTekuyv60+iF2f5lexkOKICv+A0dxvd+/
         DhsFCa29XPQt+LH0DxtyU6l05tEmL2U41ZwtDEKsjZVw+nlfkQOUomsol8aRRognThVA
         j7AJwuR75bhvLFRcmySMV7jQpZ6Kw/dip1ZQmuvVDgrXHLgrocA/ozqg2xwyq6Z6GmOj
         Gj1B+tTaCbUfAktRR58Dx7AOaxu8dx+CSlQPPYkvz/fYLyxuWXzCyQV8gCDWVcQcSsHc
         ABkQ==
X-Gm-Message-State: APjAAAWOkrAsvNcQ0nIjicMiESyoyWto9gnI4b66ajpNyYpm7EDr9W5m
        ECtKvQpSd/npw/9l39jU8mHJKRySkJciSw==
X-Google-Smtp-Source: APXvYqz04xuSBkn8UKob8C1PPSiZfE7fnMkE2CWuQIk7kgU9h4lbOR+gcNGqjgzS7C2JwpdFcZA8Bg==
X-Received: by 2002:a17:902:6942:: with SMTP id k2mr1664276plt.64.1572931305620;
        Mon, 04 Nov 2019 21:21:45 -0800 (PST)
Received: from localhost.localdomain ([73.96.104.150])
        by smtp.gmail.com with ESMTPSA id h6sm3852884pji.21.2019.11.04.21.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 21:21:44 -0800 (PST)
From:   workingjubilee@gmail.com
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, johannes.schindelin@gmx.de,
        gitster@pobox.com, Jubilee Young <workingjubilee@gmail.com>
Subject: [Outreachy] [PATCH v7 0/1] Revenge of --bisect --first-parent
Date:   Mon,  4 Nov 2019 21:21:40 -0800
Message-Id: <20191105052141.15913-1-workingjubilee@gmail.com>
X-Mailer: git-send-email 2.24.0.1.gdc0fb1c0fe
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jubilee Young <workingjubilee@gmail.com>

Hello!

I meant to introduce myself quite a bit earlier, but alas, the world is
the kind which also results in version control systems being critical
instead of merely desirable. At least, for software development. Yet,
time marches on. I know you have quite a few applicants to pick between
for the Outreachy internship but I would be honored if you would grant
me your consideration, nonetheless.

...And if you would merge this patch, too, if it's (finally) up to 
standard! This is the renovation and update of a long-abandoned feature
branch begun by Harald Nordgren and extended by Tiago Botelho some time
back. The world caught up with them, too, but one re(base|animation)
later, these works live on, zombie-like. I did my best to understand
and integrate everything with the code base in spite of the many
changes introduced since. There were many recommendations to the last
iteration, and a fair number of changes were integrated essentially as 
they were given, with the most extensive work being in the department
of the tests and refactoring them to reuse the originally generated
commit graph.

My cursory experiments seem to yield the desired result, and the tests
(which have already proven useful, to my dismay) do pass, so it seems
relatively sound for a first try. But it's possible I misunderstood
something and it still needs work. If so, please let me know so that I
can fix it and at long last, this patch can live again!

Bonus reading for context (most recent first):
https://public-inbox.org/git/20180828123234.44582-1-tiagonbotelho@hotmail.com/
https://public-inbox.org/git/20180622123945.68852-1-tiagonbotelho@hotmail.com/
https://public-inbox.org/git/20180528092017.19022-1-tiagonbotelho@hotmail.com/
https://public-inbox.org/git/20180523120028.36427-1-tiagonbotelho@hotmail.com/
https://public-inbox.org/git/20180510191259.78044-1-tiagonbotelho@hotmail.com/
https://public-inbox.org/git/20180509215728.57046-1-tiagonbotelho@hotmail.com/
https://public-inbox.org/git/20180411225534.48658-1-haraldnordgren@gmail.com/

Jubilee Young (1):
  Implement rev-list --bisect* --first-parent

 bisect.c                   | 56 ++++++++++++++++++++++++++------------
 bisect.h                   | 17 ++++++++++--
 builtin/rev-list.c         |  9 ++++--
 revision.c                 |  3 --
 t/t6000-rev-list-misc.sh   |  4 +--
 t/t6002-rev-list-bisect.sh | 54 ++++++++++++++++++++++++++++++++++++
 6 files changed, 116 insertions(+), 27 deletions(-)

-- 
2.24.0.1.gdc0fb1c0fe
