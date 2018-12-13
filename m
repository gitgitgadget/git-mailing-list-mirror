Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0360620A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 06:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeLMG3b (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 01:29:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53599 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeLMG3b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 01:29:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so1101828wmi.3
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 22:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=6+YfLSlpUJesvEUGQEy6cidtFnlQLQPXJrv0Oyk0C/M=;
        b=O80Ci4dS2gCIYBXA7SG3TWfMS2Wnk0/6P0w6EAGQ89vJ6GXckRn5GyrKUTSg/onYN2
         6jBDhguWx7GIYAtGrXmLFPTTOhuPCx6rvjXls/Iz6qRPcQDQH95MCQniVD+OXD8d1mPo
         ODnF908dUvHvBTqgauz0OoFNoPajXpLnwv18JpeBr8yxn71R8vjnXuEpsrpPWr4FMcyk
         wiBjoBuG/tn1yh3yUXu0An2tq4bAk4VoDe+s0LTpPTxNy9K9QjjJVGo2CV7OK9t2fgmq
         FaXCaqqOgA+gsReMKLbPsQRDADecduz21AjSSCIAFbt8qcITb5ALWk86R2Qntn/dEBNP
         yEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version;
        bh=6+YfLSlpUJesvEUGQEy6cidtFnlQLQPXJrv0Oyk0C/M=;
        b=jnUfwk7rjiLtEg0qShU6N4tjAOhXh5z3Gl1vd7Mxly11vx2LwD3H7j0dCw1kDDUaEg
         aIieWHW9LmK+MVe7PG+2WB9KW00AZMHudzbE8hKb+J1thcf6H9o3HVXSwA8/CSxSl4v3
         XmPKo8FQ76xvVmTLxqzJA/Duh5PAMddvesrNGlDOI8slliVQV2fiID1h1I/ocYNM7Zdq
         GyiS6/nUcwrP6nnsA9NF46sc6/ObsQhn6ynEXbD0mInaCY+QjbA9/LxvSjdnP594KCEh
         UnvNf4BYcdnJZWgGJTBYn+6EQHJusqxx8bGvWPq7h7t4nQjjcM7UrbWEbBYzTT0ENg36
         DXbg==
X-Gm-Message-State: AA+aEWZkMBo06E02ZHugl6a3bnZ6wXBAfSJ0Kj4AxEYbZyIPsMYVdfOo
        qF+wHa25xU1NMchk2m4hUYXNzrr9h78=
X-Google-Smtp-Source: AFSGD/Wzh+LRWN5NkLevftnOcnI35AVwgSzZzjNn3+7I4d5QvikB99BUbjb/yW0bMT2+Jxxv6/ecqg==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr9290134wmh.40.1544682568676;
        Wed, 12 Dec 2018 22:29:28 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t199sm7617692wmt.1.2018.12.12.22.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 22:29:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Preparing for 2.20.1 brown-paper-bag maintenance release
Date:   Thu, 13 Dec 2018 15:29:27 +0900
Message-ID: <xmqq4lbiey7s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is an excerpt from a draft edition of "What's cooking" report
for topics that are about an immediate 2.20.1 maintenance release,
with five topics that I plan to merge to 'next' and then to 'maint'
soonish (they're all marked as "Will merge to 'next' and then to
'master'").

They'll be in 'pu' but not in 'next' in today's pushout, but unless
I hear breakage reports in time, I am hoping to merge them to 'next'
during tomorrow's integration cycle, so that we can start the new
week with 2.20.1.

Thanks.

--------------------------------------------------

* ds/hash-independent-tests-fix (2018-12-12) 1 commit
 - .gitattributes: ensure t/oid-info/* has eol=lf

 Test portability fix.


* jc/run-command-report-exec-failure-fix (2018-12-12) 1 commit
 - run-command: report exec failure

 A recent update accidentally squelched an error message when the
 run_command API failed to run a missing command, which has been
 corrected.


* nd/show-gitcomp-compilation-fix (2018-12-12) 1 commit
 - parse-options: fix SunCC compiler warning

 Portability fix for a recent update to parse-options API.


* js/help-commands-verbose-by-default-fix (2018-12-12) 2 commits
 - help -a: handle aliases with long names gracefully
 - help.h: fix coding style

 "git help -a" did not work well when an overly long alias is
 defined, which has been corrected.


* js/mailinfo-format-flowed-fix (2018-12-13) 1 commit
 - t4256: mark support files as LF-only

 Test portability fix.
