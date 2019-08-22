Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CE771F461
	for <e@80x24.org>; Thu, 22 Aug 2019 14:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbfHVOUM (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 10:20:12 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:38103 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbfHVOUL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 10:20:11 -0400
Received: by mail-qt1-f181.google.com with SMTP id x4so7857250qts.5
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=CQH3AFWAxB6QkEbJVgnLN2s/IDMldRrxU1SfwPOOt8M=;
        b=p0H8Nd0ns4eP2UVxpJlFcSOH3RG/LFg4Ysd+fb24vTUnSDyMJQR0vWIU2OhbUoGon+
         jjhTgPYmZQHGcG6p9vZQkr9HWxNNxT3UEXR+fT+gL9V8YFUnaCr4y7aNwYG0rZvAJi6h
         BnFgL23HMOCOzHcXp46Fa/g3I4D4YT/YA2hKkbQAQJ+Ke7n2HW3VGRs572REaD1bOsNc
         I7vU5Z8cECdPSJYKcEUC/0YjQGaqxwRMuMT2PQKeAmF8JIlRc5AM9kJbg/yTYvvS6Jlg
         DET7GikO3LkvlMN/K9pO3Owia8WqcWhvZ54GBGlItS0OzhJi0fSr+sKj+9R7P52Cy0fU
         Fkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=CQH3AFWAxB6QkEbJVgnLN2s/IDMldRrxU1SfwPOOt8M=;
        b=RYC3/hRd+8wjhXuPXkh01XGSGDhLFhbXyVxT3WxmAAm4g8grfmryq+75Cq+E5voIFF
         O9ZLz9/dJoasid4Hm/LQ1vgm/aTH4ksNDYgM15ioQT+zPm1sNjJpLyLyPl1zcO2bDwMd
         r9Fhfs/cl3W2fdQc9gQIYarbxj4T5QtDaafTve+NrnUySBoDXswnaClF0eMCyFhm1uJW
         KwlP92x4/xsLKWW7obxQfxCtUVm3qMlFBn2gJF2n7ymaek3u2b6See3TRljR/ydmlubr
         qtvxW4tObBk5hctA2oCxfqlz37vyebx/pvczEZAN5BnOP4a02ew2KQGixtft1+FxZifY
         KnXw==
X-Gm-Message-State: APjAAAWPZ6REfWeVhIro2Hr2CiN+TwBC2IOmH6Qt4SwSqSKW1UchlI2w
        Vs8r7AgMBkiKX9dfO3FWoN5yyWFv
X-Google-Smtp-Source: APXvYqwKJB0B3QJ3xjJsQGqId7giYPQguspqmgbBWspBtclgWchIhXEu70y5wmryEH6YTCq73QlLLQ==
X-Received: by 2002:ac8:289b:: with SMTP id i27mr36791073qti.67.1566483609883;
        Thu, 22 Aug 2019 07:20:09 -0700 (PDT)
Received: from localhost ([2001:468:c80:c105:7957:4d38:5080:74ec])
        by smtp.gmail.com with ESMTPSA id h1sm12636522qkh.101.2019.08.22.07.20.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 07:20:09 -0700 (PDT)
Date:   Thu, 22 Aug 2019 10:20:08 -0400
From:   Charles Diza <chdiza@gmail.com>
To:     git@vger.kernel.org
Subject: v2.22.1 and later regression wrt display of progress indicators
Message-ID: <20190822141928.GA3163@323642-phi-gmno-clahs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By 2.22.1 at the latest (and continuing into 2.23.0) there is a problem with the display of progress indication during `git pull` (and possibly other commands, I don't know).

I'm on macOS, and this happens in both Terminal.app and iTerm2.app, on both macOS 10.13.6 and 10.14.6:  In a standard 80-column wide terminal window, cd into a git repo and do `git pull`.  The chances are high (though not 100%) that one will see this:

remote:                                                                         remote: Enumerating objects: 82, done.
remote:                                                                         remote:                                                                         remote:                                                                         remote:                                                                         remote:                                                                         
[snip a large number of duplicate lines]
remote:                                                                         remote: 
remote: Counting objects: 100% (82/82), done.
remote:                                                                         remote:                                                                         remote:                                                                         remote:                                                                         remote:                                                                         remote:                                                                         remote: Compressing objects: 100% (5/5), done.
remote: Total 111 (delta 78), reused 78 (delta 77), pack-reused 29

It used to be that there were *no* lines that appear to consist just of "remote:".  I say "appear" because most occurrences of "remote:" are followed by a bunch of spaces rather than linebreaks.

Charles

