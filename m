Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ABF020A40
	for <e@80x24.org>; Tue,  5 Dec 2017 21:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbdLEV03 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 16:26:29 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:46641 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdLEV02 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 16:26:28 -0500
Received: by mail-it0-f44.google.com with SMTP id t1so4735472ite.5
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 13:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d1z4Jtbz1tq2HmM+T/81ty4QJ9VW4kbcTl2qjjWlzFA=;
        b=bKOVYKy5VPiws1wm2EMa6HFROgQmVUEepS2mpUpe+y7I0RUF6lIE04b8XPAGX4xogI
         TxBoyCGr4+1MXfQhpt7OYBGFHnNnq0kiIFxcTMsDp4/wt5HxGpN0JYbiYOzyNBMP2721
         iX42zfDq10nzQulNnLhxUfV5igoBGb4r7CSAnA9GqQaA/ewbHtmifUXsHOyLBDSY3/gX
         AFp4LefBc/2Q2nFFqvAf8At6HVZimjM6CRf9PawCiSXWCSm8gquuy1Kmir5sr4ZTYVm6
         gw2gzFR1BLnmW2+yvaa8QeWNBJ9kuQSIjd7IRVOJlOFUfbGWuVqsgkHhaxNsg9znGlYz
         b3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d1z4Jtbz1tq2HmM+T/81ty4QJ9VW4kbcTl2qjjWlzFA=;
        b=A1XdVWjZKGrlFQBuEPK7G4qGOtu3TDduXdAcJCDifcjarhH3BsOfmDg38koEcDyS0X
         jb0sQBsRSnoo+BzZ1Jcvbc7OnIdPJiYVegbJi//RsDRXwoX6t3m9lv70uodVvXUMDlCK
         OUIGbWNTvYM8U3NBPUqDLwXHmayu9Y2eTFFQLRZ8t2UGBrYEPXAer/dG78Kby1RYlAG3
         0GBnpGe0QBGcPecf0npA/0hvbA/1lsYpKq5Bh4Jm47XdYPh3StwidGttAxELrkHOA4xx
         gRUn7F/fl+FhxO4qb0oZ8WsmAGjpyLfryEKoHiafPBaJ81Hdn+isoqLm4K2ot5McUO+p
         Z3Tg==
X-Gm-Message-State: AKGB3mKuf41U3GU/IHZbZy+K24Ggdneg/OomJ26teNol8+EKqTyxsxbk
        WLQjxKqu9SMdspzC9CC1KNlAOg==
X-Google-Smtp-Source: AGs4zMa23HaWlhE6vyDSgY9ofjiR7hEm/rGrmV9Wn+Rf6ue+85et55uoiY7W+6pcyiCJlEdBXbMdMw==
X-Received: by 10.36.127.198 with SMTP id r189mr10702931itc.116.1512509187776;
        Tue, 05 Dec 2017 13:26:27 -0800 (PST)
Received: from dnj.pit.corp.google.com ([2620:0:1019:0:5840:7173:18ff:ed41])
        by smtp.gmail.com with ESMTPSA id f68sm448401iod.36.2017.12.05.13.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 13:26:27 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     j6t@kdbg.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, dnj@google.com,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
Date:   Tue,  5 Dec 2017 16:26:25 -0500
Message-Id: <20171205212625.6616-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:

> I don't know what I tested last week; most likely not the version of the
> patch I quoted above.
>
> Today's version, with the tip at 5d7f59c391ce, is definitely bogus
> with its quoting. It needs the patch below, otherwise an unquoted
> semicolon may be expanded from $(pathsep). This would terminate the sed
> command, of course.

Thanks for checking! The patch that you quoted above looks like it's from
this "v4" thread; however, the patch that you are diffing against in your
latest reply seems like it is from an earlier version.

I believe that the $(pathsep) changes in your proposed patch are already
present in v4, having been caught by Johannes, so perhaps you were using
an older version of the patch as the diffbase? That change only appeared in
v4, so any older version would have had the previous incorrect quoting.

I think the reason that is necessary to remove the single quotes is not
because the ";" is terminating the `sed` expression, but because it's
terminating the entire shell stanza, causing the shell to execute two
commands:

1) {"sed" "-e" "s=@@PATHSEP@@="}
2) {"=g" "-e" "s=@@INSTLIBDIR@@=..." ...}

By including the ";" within the single-tick-protected `sed` argument, the
shell receives the entire block, "s=@@PATHSEP@@=;=", as a single string.

Also see Johannes' explanation here:
https://github.com/danjacques/git/pull/1/commits/57dc265478692ea2a395fc61fa122cb73ce58dc3

Could you apply this v4 patch series and confirm that it is working for
you? Or, if I am mistaken and your patch is correctly against this "v4"
patch series, let me know and I'll try and figure out what I'm missing.

Thanks again!
-Dan
