Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707C51F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 19:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfJKTMx (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 15:12:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42006 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfJKTMx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 15:12:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id q12so6622304pff.9
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 12:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2knWcstd7K/LYq2gdPClQgkYFbjgLTZ5jNzvSmxqoMU=;
        b=StLOa1QtQCAXrKMXvcB8SoDUM46heotaZi8wL2to8h9EMUzpeenDmOt6Sf55puoQbb
         kx3yyHFrDhs0eJRWwAbXSpdykzccFFEPpd8gWlh4YxCvxWsr3GqDtzY74hEZg4WBmxrG
         WBUsVUI7Exka9cZylzjdv4Bvlpns2ObvyLVCDMqkFWuWgWWwBrQwtGGOTUMEect8I32U
         LvcBw6ZV7OVPAE/Y2sjnRGfw30Jbnq5WgqIhZ9JPggPQxihYf3wtK+H4RDd2hBSDSdI8
         8isJqEkWifK5AYC2tvAwAcSKJinC0wGLNlFDdjzVr98DmRiihWOfRIrAsiRzR79rx4oC
         VeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2knWcstd7K/LYq2gdPClQgkYFbjgLTZ5jNzvSmxqoMU=;
        b=DD3K/91CFAPBFy3JG+dwNhIxmcbwRk2XtGUmBBR18e7F38LTunz6V0Te3+OY7uJuYX
         ZDWRjVd0SugPNx+aPC7uxfLzJG6+iYFpUcYy2ZcKI9RqeLad5ykw+9ouQYbMNn3nVg5H
         kexnfU4gpPnbuixc8J97UlzSRxoCAGXeKO/PY4q3McUwt0Pv7JQ7jpBx5NFC7vxeeTIN
         fI/juzgdhFzNU7TdSp60FGYVKc9WTmYQ1HjBoZqV1842gLkndSWOr9q5asel6M6O/MU1
         UC0FYlS0tqJfNKiMuPJEdub042gptRJSLHncwt/YwIuxyK8yNXXvaKAXyS7xaQI4X2Ko
         ijZA==
X-Gm-Message-State: APjAAAXJ7LfzJHKqXsvt1LPEYnRQfFrjykPGND+K853AZRSSfMXT4PSR
        jRJ9osNYVuC+3u6RJiCX8Rf9gws1
X-Google-Smtp-Source: APXvYqw69aVMfmgXyGoHl1v7CJtz46Le2sc+fgLcsz+IvO3OUUK0SFZghnUwCsPxVCsogFbrQm5BuQ==
X-Received: by 2002:a17:90a:37c5:: with SMTP id v63mr18619744pjb.3.1570821172132;
        Fri, 11 Oct 2019 12:12:52 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id g12sm15783691pfb.97.2019.10.11.12.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 12:12:51 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:12:49 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 0/3] format-patch: learn --cover-from-description option
Message-ID: <cover.1570821015.git.liu.denton@gmail.com>
References: <cover.1566285151.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566285151.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all, since 'dl/format-patch-doc-test-cleanup' has calmed down and
merged into 'master', I think now's a good time to revive this topic.
I've incorporated Philip's --cover-letter-from-description idea (and
shortened it so it's not so verbose) so now it should be a lot more
general than the old --infer-cover-subject.

Currently, format-patch only puts "*** SUBJECT HERE ***" when a cover
letter is generated. However, it is already smart enough to be able to
populate the cover letter with the branch description so there's no
reason why it cannot populate the subject as well.

Teach format-patch the `--cover-from-description` option and
corresponding `format.coverFromDescripion` configuration option which
will allow it to populate not only the body but the subject as well.

Changes since v3:

* Change --infer-cover-subject to --cover-from-description

* No more test cleanup patches (they were merged in
  'dl/format-patch-doc-test-cleanup')

Changes since v2:

* Break 1/4 into many different patches (one per paragraph of the
  original patch)

* Incorporate Eric's documentation/commit message suggestions

Changes since v1:

* Incorporate Eric's suggestions for cleanup in all patches

* Add patch 3/4 to make it clear what is the default value for
  format.coverLetter (since format.inferCoverSubject was borrowed from
  this config but it also did not state what the default value was)

* In 1/4, rename all instances of "expected" to "expect"


Denton Liu (3):
  format-patch: remove erroneous and condition
  format-patch: use enum variables
  format-patch: teach --cover-from-description option

 Documentation/config/format.txt    |   6 +
 Documentation/git-format-patch.txt |  22 ++++
 builtin/log.c                      | 114 +++++++++++++------
 t/t4014-format-patch.sh            | 172 +++++++++++++++++++++++++++++
 4 files changed, 280 insertions(+), 34 deletions(-)

-- 
2.23.0.17.g7cce04acd6.dirty

