Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE7C1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 08:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfGCI3g (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 04:29:36 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:34366 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfGCI3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 04:29:36 -0400
Received: by mail-qk1-f181.google.com with SMTP id t8so1567735qkt.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 01:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kZW3e8cOoW2oPZU4BnX+AJ4EBApwo1bJqb5FL60d9Wg=;
        b=NimTGtdmnATPNRZoqe4aBDjwX7oyc4N+FrozNXHcIhx0tnFswRa09zpHbkAQ1cM8kd
         TekZzsanFNsbqnxmQjBb2XZ7+z1ghOXFcfwmdbFsUnpOOjisMs6LW/WOTV1Dl/SzvflQ
         EvrUje68tckvf2KUnGG5glRb65nYGYwe7Y4ZSGbkqlDs3JxcJFgDS84r4wyZ1SfPmgJk
         FY7hsZFoNQOiw20/M/J+tRRict/StjdV1ATEVD7C1SdFHwxSahfff/MzJdtSh57gLfzp
         eWt+3gbOLSCgKibVPLrT8mCJUxjR6j5YTg8ChH3bOPfzEc+w1rBc2rH1ih4N0GYNFtSk
         Picg==
X-Gm-Message-State: APjAAAXJoxVBwDLb3u1JwxfglqcAQOK6VR2j2GIprpiCbIDjUn+EgTry
        pqHqOZQ1nTDPo1GxUfbjPsHDTOmAslw1IhHH6FFrv95u
X-Google-Smtp-Source: APXvYqyYfCYoFh6N/RCtbTi4iOD1rFBX/HvQXuiN7/aKO4yB7S4MqYFMZtjU2D3RMUAj2s2EJXP1Bi82Ol4YLP7qNyI=
X-Received: by 2002:a05:620a:10b2:: with SMTP id h18mr29258842qkk.14.1562142575223;
 Wed, 03 Jul 2019 01:29:35 -0700 (PDT)
MIME-Version: 1.0
From:   Julius Smith <jos@ccrma.stanford.edu>
Date:   Wed, 3 Jul 2019 01:28:59 -0700
Message-ID: <CAMPRpjUWBXCEagDB5RwsBTYSJWeypOeY47CGWOO95oZiSCTOjw@mail.gmail.com>
Subject: Submodule "git branch" says (HEAD detached at <incorrect-commit>)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

I have a repo with two branches A and B, say, and a submodule pointing
to a repo also with two branches, say C and D.  Branch A of the parent
uses branch C of the submodule, while B uses D.  My clone is in a
state (that I've seen often) where branch A's submodule directory
_appears_ to be using a commit for D when really it's a commit for C.
"git branch" in the the submodule directory says "(detached from
<commit-for-D>)" but this seems to be wrong.  I did "git diff
<commit>" in the submodule directory to show that it was the C-commit
and not the D-commit as it appeared.  Could "git branch" in the
submodule directory be referring to the commit at the time it was
first detached and not updating after a "git submodule update --init"
in the parent?

Thanks,
- Julius

-- 
Julius O. Smith III <jos@ccrma.stanford.edu>
