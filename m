Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1268207FF
	for <e@80x24.org>; Thu,  4 May 2017 05:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754611AbdEDFpI (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 01:45:08 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36620 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdEDFpG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 01:45:06 -0400
Received: by mail-pg0-f68.google.com with SMTP id v1so756483pgv.3
        for <git@vger.kernel.org>; Wed, 03 May 2017 22:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qnDXiC2aA7iRNruL0TjAGC52bK3zP66jReO+kT4AhVU=;
        b=XxVULUxvVMFBqyBDwi1mtCwdKnAaMqrKpk/N3jhVVtO9eoJNU9lvPUz3ItSoUBAnWa
         bt04bV+nYNJ417FJ3YAvbFRpvqGWd7MN0cRLC0ZIXaWHsTH5GcMJ7t9Z1MCFWuNK4vbj
         rCp0Dbn1cIO1XU0HMqQvkGZ7joc942QxA1SZ7D2BvgRr+a8B9niytEBekBhE7/BmBSV+
         Y4tBp+D8KqE+6ufg6eQp6JpwjNn8VL1nJ/Drh4lWPUA8cH88lZ6qmWPmHU+VTxWCsYL2
         cPWgD8PaB3y5UwrJQtSvWn9sguCWTP3W98t90K1QfDwCvfKjed41pAGEiy88StGE2fsr
         tNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qnDXiC2aA7iRNruL0TjAGC52bK3zP66jReO+kT4AhVU=;
        b=kyVLN9gMmbJO5oAWGmpVknFqs+HzD1iq7UBvVJm1oPDP7Bua4a2FhVn0/M7a8HlkrP
         EZDNaXhMjKf7cc+5dtVgQxyyxTUZCqf9tBhz2xWPzul7hDCqNNTCMaWCGhCNrwsggEJm
         fb1PqltpZ/2WFH8jLgIU2RKPRtih+EYVWzxqNdTotLqnuon8/v+RZWQwyrBJGO2/sdRi
         jQsE2NF9cGwXUi9vSbg3FyH/NWtRxrggCC1I+yzp+guBbBrUMge3wWryl9/sE3bEw7TY
         ztSmz8g55f15pDFIN/GGPZGgGS3YaRJmVhFQYA7T/Ul+cOHFh9a9dAgIH+JaXVjdM+iP
         zPRg==
X-Gm-Message-State: AN3rC/7PL9dYVLQkqLBsxXwhFmIVyqLU3nKWUMVtSzF3Sa+34p2elkoM
        61FQwYqHL9dv3A==
X-Received: by 10.99.44.9 with SMTP id s9mr19670354pgs.132.1493876705679;
        Wed, 03 May 2017 22:45:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:21be:aa3e:8063:4b3])
        by smtp.gmail.com with ESMTPSA id 79sm1620206pfh.38.2017.05.03.22.45.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 22:45:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 00/21]
References: <20170420112609.26089-1-pclouds@gmail.com>
        <20170503101706.9223-1-pclouds@gmail.com>
Date:   Wed, 03 May 2017 22:45:04 -0700
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Wed, 3 May 2017 17:16:45 +0700")
Message-ID: <xmqqd1bp9nvj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Changes since v1:
>
>  - fopen_or_warn() and warn_on_fopen_errors() are introduced. The
>    latter's name is probably not great...
>  - A new patch (first one) to convert a bunch to using xfopen()
>  - Fix test failure on Windows, found by Johannes Sixt
>  - Fix the memory leak in log.c, found by Jeff
>
> There are still a couple of fopen() remained, but I'm getting slow
> again so let's get these in first and worry about the rest when
> somebody has time.
>
> Nguyễn Thái Ngọc Duy (21):
>   Use xfopen() in more places
>   clone: use xfopen() instead of fopen()
>   config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
>   wrapper.c: add warn_on_fopen_errors()
>   wrapper.c: add fopen_or_warn()
>   attr.c: use fopen_or_warn()
>   ident.c: use fopen_or_warn()
>   bisect: report on fopen() error
>   blame: report error on open if graft_file is a directory
>   log: report errno on failure to fopen() a file
>   log: fix memory leak in open_next_file()
>   commit.c: report error on failure to fopen() the graft file
>   remote.c: report error on failure to fopen()
>   rerere.c: report error on failure to fopen()
>   rerere.c: report correct errno
>   sequencer.c: report error on failure to fopen()
>   server-info: report error on failure to fopen()
>   wt-status.c: report error on failure to fopen()
>   xdiff-interface.c: report errno on failure to stat() or fopen()
>   config.c: handle error on failing to fopen()
>   t1308: add a test case on open a config directory

Thanks.  If the number of parts affected by this series were
smaller, it may have made the review easier to have the introduction
of a helper and its use in a single larger patch, but there are
spread across many, some with files that are touched by different
in-flight topics, and these "collection of smaller patches" makes it
easier to manage both while reviewing and also merging.

All looked good, even though I do share the doubt on the name
"warn-on-fopen-errors"; when something applies equally to fopen(3)
and underlying open(2), I would tend to call that with open not
fopen myself.  But that is a minor point.

