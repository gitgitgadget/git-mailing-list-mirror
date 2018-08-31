Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF9101F404
	for <e@80x24.org>; Fri, 31 Aug 2018 06:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeHaKjq (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 06:39:46 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34421 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHaKjp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 06:39:45 -0400
Received: by mail-it0-f66.google.com with SMTP id x79-v6so4142203ita.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 23:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=62cYG3d9HQhvtnjzXhroafZn/f4qFxMgSUt3uWlSsf0=;
        b=YeFdnuFhFLuXWygHCr0I8Snb1BKalV/W0KB0B1GWNcrk2cbXz3I4H6GE9xOnqZjoOC
         oKvhPJu/ul1TYJ+k+VYm5xx6f86KU5ZVXSPKCkHXLod/tyJkra74lNUZ8BaRHhda1tCJ
         C74mCp7cjckkJs5oOC+g6DawOKyYyotTdv4zpRLp1HJQr+fqSmQgevMWIkvhlsqjk+g4
         IyWCrzd2+O0zC+WFdV60JSDqDEvVaXtj54mSIocLe4Tro7UMQxlJmHAxZxed5oLzWY7+
         JVYWuw8rLmIQSxJIvD38zz8sEMobrL1EPsElQP7h7LsR8tMKsgxrARMfmJqabMeOSMrs
         bQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=62cYG3d9HQhvtnjzXhroafZn/f4qFxMgSUt3uWlSsf0=;
        b=A5LJzgBGXILdsFjWe4wBCHQS+MBdshauP7TgOi3ndD0BkA3smgcoMIbT7rE4zo9Vpz
         LtP4J6E6oJv856MUM9Rw1cXXD3WI1JDyhE/yxDHr2hth7WlnCpVVhybdQ6lNk/kxtdro
         4Bhk1qWChM+xIKvcsVCvBLicb1h0cq+cqVvEnPwx+YLK97RVtcwsnjXUVlWTm3YMBtA/
         HXbvBofAXDN75aD8sPY2ye1kw4K5twPcZ+MucDJpOxYJSETpWKq0kj8zt0gDxEz61S+j
         kn6ENX/plHoLCcXR6D+Q9sU6pNuNEXQpatDFHlD4IO/UMZCndSg/uBHG5fhzopLy7mBD
         Pddg==
X-Gm-Message-State: APzg51D4PWa0F9DGNrDW1Vp/Ku71nSpfujCjgFD0buCOhmSrLRWqkBno
        geWgtoU08eCKsZYJUvXtxfkq/T0V
X-Google-Smtp-Source: ANB0VdaAZhZWxb6+ux9/VY8LxBghOkrGJosFh6LL/aQx8Eab4javfhmsz3RN8yCzoF7ItEY7APbHlA==
X-Received: by 2002:a02:6f1a:: with SMTP id x26-v6mr11748480jab.131.1535697230348;
        Thu, 30 Aug 2018 23:33:50 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id k18-v6sm3734531iom.73.2018.08.30.23.33.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 23:33:49 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/3] doc-diff: add "clean" mode & fix portability problem
Date:   Fri, 31 Aug 2018 02:33:15 -0400
Message-Id: <20180831063318.33373-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.352.gb1634b371d
In-Reply-To: <20180830195546.GA22407@sigill.intra.peff.net>
References: <20180830195546.GA22407@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series replaces Peff's solo patch[1] which updates "make clean" to
remove doc-diff's temporary directory. Rather than imbuing the Makefile
with knowledge specific to doc-diff's internals, this series adds a
"clean" mode to doc-diff which removes its temporary worktree and
generated files, and has "make clean" invoke that instead. It also fixes
a portability problem which prevented doc-diff from working on MacOS and
FreeBSD.

[1]: https://public-inbox.org/git/20180830195546.GA22407@sigill.intra.peff.net/

Eric Sunshine (3):
  doc-diff: fix non-portable 'man' invocation
  doc-diff: add --clean mode to remove temporary working gunk
  doc/Makefile: drop doc-diff worktree and temporary files on "make
    clean"

 Documentation/Makefile |  1 +
 Documentation/doc-diff | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.19.0.rc1.352.gb1634b371d

