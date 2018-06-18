Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFBD51F403
	for <e@80x24.org>; Mon, 18 Jun 2018 23:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936997AbeFRXnH (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 19:43:07 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33539 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935955AbeFRXnG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 19:43:06 -0400
Received: by mail-ot0-f195.google.com with SMTP id h6-v6so20560296otj.0
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 16:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QaU15/a6Ya6cfgCnoN5nE1UfXIC/e3cOFThjTrD1oec=;
        b=kpe6xqRjbv48rvRi1hmfvz6WMYPJuD8/gjqvCHJ0GCvA1fujwPZ+VpDxVQDXxv2xej
         nDt37M8lxO9bJ9AXR5vzYSxJ1MpTXFzvVIB9JGu2C8H6aEKBCcZGe0MHw/0M2sjYehsH
         iSvSy3Msx8oB00CL2e75rvL15op38zUP90b4y7/jbr0AUqbZ/uRGONXCPd+YhjF5Rh3n
         iftCu/O4/Vkg0oMXyTd8g7ZVNelxxOOQdPHDtriOCfoWUi9TDw+rc5dp5RqIyR6KlRxf
         iasK4gjT8n8GII7naOLnYs9WsZ/DLqyrWjL+jBQpb1gPUhfMQvuyRxfcgMo1uNE+haVt
         UeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QaU15/a6Ya6cfgCnoN5nE1UfXIC/e3cOFThjTrD1oec=;
        b=CIZzak+Pb5SHBztHriTBjpVzmXiiMMTxkiSn6qoNpLZ9/2ADybhT5EbsMokIec4U17
         YTusfYWOrbPMR4CHbwl+56okUQbnWFcTdiM4UPvV11pVR9q7H1IaXsyhXqvcJSYCyevh
         2q9CL7ir8r3sRRMr/1f7dP5H0hnf9nGmYXXsgGGKasoIwIwh/21qsDeS5RkoGxrNWfOF
         InOxkrwj/wySc8hchnDYWT/w00RFk362ZVqoaEeUxRvGMcs2UMYHDnnth27tHElFJECA
         bj+jlYUSxPS/ezYB0wESEPdEY2lG6EJKSFqPSs1g1C+SiEnN+ugw/oktyMZmbIuzPNRZ
         7XRA==
X-Gm-Message-State: APt69E1Jv+SUGCJ3Q6z2ymnQ5an1Hn191ENKxb7A4kn/NyJpKkmi31WS
        mRseHSUDp+0Ts/K3u4eF7w9JOym+f7o=
X-Google-Smtp-Source: ADUXVKJM3lcbhbcejYP7hNFfRoTCjkyLknEN9YYSk8P0tEUM190QZglFifVLdk3mLzQ1/4CqlXGC0w==
X-Received: by 2002:a9d:3334:: with SMTP id f49-v6mr9619874otc.380.1529365384641;
        Mon, 18 Jun 2018 16:43:04 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id a202-v6sm8557989oib.28.2018.06.18.16.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 16:43:03 -0700 (PDT)
Date:   Mon, 18 Jun 2018 18:43:01 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <cover.1529365072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is a ``fresh start'' of my series to teach 'git grep --column'.
Since the last time I sent this, much has changed, notably the semantics
for deciding which column is the first when given (1) extended
expressions and (2) --invert.

Both (1) and (2) are described in-depth in patch 2/7, but I am happy to
answer more questions should they arise here. Peff and I worked on this
together off-list, and we are both happy with the semantics, and believe
that it covers most reasonable cases.

The notable case that it does _not_ cover is matching the following
line:

  a ... b

with the following expression

  git grep --column -e b --or -e a

This will produce the column for 'b' rather than the column for 'a',
since we short-circuit an --or when the left child finds a match, in
this case 'b'. So, we break the semantics for this case, at the benefit
of not having to do twice the work.

In the future, I'd like to revisit this, since any performance gains
that we _do_ make in this area are moot when we rescan all lines in
show_line() with --color. A path forward, I imagine, would look like a
list of regmatch_t's, or a set of locations in the expression tree, such
that we could either enumerate the list or walk the tree in order to
colorize the line. But, I think for now that is #leftoverbits.

Thanks especially to the last round of reviewers for their detailed
feedback, and I hope that starting in a new series will be OK. I figure
that enough has changed that I'd rather not clutter an already busy
thread.


Thanks,
Taylor

Taylor Blau (7):
  Documentation/config.txt: camel-case lineNumber for consistency
  grep.c: expose {,inverted} match column in match_line()
  grep.[ch]: extend grep_opt to allow showing matched column
  grep.c: display column number of first match
  builtin/grep.c: add '--column' option to 'git-grep(1)'
  grep.c: add configuration variables to show matched option
  contrib/git-jump/git-jump: jump to exact location

 Documentation/config.txt   |  7 ++-
 Documentation/git-grep.txt |  9 +++-
 builtin/grep.c             |  1 +
 contrib/git-jump/README    | 12 ++++-
 contrib/git-jump/git-jump  |  2 +-
 grep.c                     | 95 +++++++++++++++++++++++++++++---------
 grep.h                     |  2 +
 t/t7810-grep.sh            | 63 +++++++++++++++++++++++++
 8 files changed, 163 insertions(+), 28 deletions(-)

--
2.17.0.582.gccdcbd54c
