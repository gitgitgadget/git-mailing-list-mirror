Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45A201F461
	for <e@80x24.org>; Thu, 16 May 2019 18:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfEPS45 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 14:56:57 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:39817 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfEPS44 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 14:56:56 -0400
Received: by mail-yw1-f73.google.com with SMTP id h186so4044876ywc.6
        for <git@vger.kernel.org>; Thu, 16 May 2019 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QRf+y5z6mJNILCe9kEONzoEobEj3meggrzQXPLuMWFY=;
        b=q5xau4BKeFAxM50347weg6GWDKRCYTPW823yyVVtqOsI2WTtDju5mGAk5ARAIWFHSx
         lBDxNv5mzOisPjxnzFwzfN11NvbIUQwVx8YW+dmj9CObEzCRWsqYsA6cDFqBIf0HgIii
         r9iOkHX9ux366kpcWi4XFuc8fE2QQGwGVvRXN07Lj1Ao1nU5HASbBg6xUbiBVG1RJ1tE
         wqen2UHVIVRbpxZuHM5i4ySxg8iF7qgrgMPqO3DQM/lYtOEU2KRlcVg4fAvMyxVy7mCa
         PcdCpQQvkHDwvlEaenc64NxHouHU8BFs5PH/3QXSPwd2RSbbg9cIXiibeAQsh98pVg7+
         Kxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QRf+y5z6mJNILCe9kEONzoEobEj3meggrzQXPLuMWFY=;
        b=gTJOsm4RBOE6G7dit5cHjU0QvFUoJ4nIYDk2czM/AHIUJEEzp6nN9uAqZupdEL8k5e
         m2sswWjoDJ1ixVURjfCcjz9SMB61ZaGI5sCZtt1yKkHdo0cy2PADsnb5f65+HdHGYdhh
         Ay3ZB/9rc0+v0nCoT1wjqdd8d952JRQOm6N1fkS6FFWMPmQYzasBr1Ab/6V9Vg1UU0/s
         xx33fV/1w/sODjYUGGMKAWCEjXGfzJ2pCNU7HYmpozm6iP7dHv3EDP3I6oomyD+vEM9z
         /dZeTKAy+BfvDTH4lnkEg8GvwQIHgjzE57mkFEsC2Q8QizxWjxpfOSXvvn2aeV9SckbX
         m8cg==
X-Gm-Message-State: APjAAAW7oGiFEFu33I3bSQdtR8npyd5M/hKsVv7TvIDXjmIw4rfzSAM+
        /VB26kjZ6SObMp8YPl6/dtKD2M46BRE=
X-Google-Smtp-Source: APXvYqyi3N68NXCkyqwDuOtu+sOxR4UkUvjULJMV1bkKJtM6JFCABh+Ne+L2O40IXgNuILbyp4Eu4PIc1Thq
X-Received: by 2002:a25:9989:: with SMTP id p9mr24436414ybo.157.1558033016154;
 Thu, 16 May 2019 11:56:56 -0700 (PDT)
Date:   Thu, 16 May 2019 11:56:48 -0700
In-Reply-To: <20190514001610.GA136746@google.com>
Message-Id: <cover.1558030802.git.matvore@google.com>
Mime-Version: 1.0
References: <20190514001610.GA136746@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RFC PATCH 0/3] implement composite filters
From:   Matthew DeVore <matvore@google.com>
To:     jonathantanmy@google.com, jrn@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a first stab at composite filters. It does not actually support omits,
but the biggest difficulties of the implementation are already addressed. So I
decided to send out an early version to give interested people an idea of just
what is needed to implement it, and then give them a chance to change my mind
(Jonathan T. especially was concerned about code complexity).

Thank you,

Matthew DeVore (3):
  list-objects-filter: refactor into a context struct
  list-objects-filter-options: error is localizeable
  list-objects-filter: implement composite filters

 Documentation/rev-list-options.txt     |   8 +
 contrib/completion/git-completion.bash |   2 +-
 list-objects-filter-options.c          | 132 +++++++++++-
 list-objects-filter-options.h          |  14 +-
 list-objects-filter.c                  | 272 ++++++++++++++++---------
 list-objects-filter.h                  |  31 ++-
 list-objects.c                         |  45 ++--
 t/t6112-rev-list-filters-objects.sh    | 108 +++++++++-
 8 files changed, 470 insertions(+), 142 deletions(-)

-- 
2.21.0

