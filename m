Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A1FC20248
	for <e@80x24.org>; Wed, 20 Mar 2019 01:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfCTBFC (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 21:05:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40017 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfCTBFB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 21:05:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so847836wri.7
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 18:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=R/D5Lu///bpOB4m2aj2O5Qlzf7lpXHfjlXg8/BZK35o=;
        b=iTh2mT8ZGIElzyQ3GlVXPrOxTO6vD5CSAW2Ti4/khHic6KuiDbbN423siM5h2VEw3+
         bMQH1+P1+lO10ZaLGy/hUJhQMdmMSoA8wsERaDo0G8VsFqZr6ddlE2B1Ig2CIyH1qzUJ
         OmJlBXhwtosSS1uJMisp8egK6mVLSO0mnObYedqTr9e2UIpT16QDhBjNjgfQaFh/Xotv
         RCdG1Ah9SUcTlu+T8c1UoMNCtxqX72ze21o9eGeODue8F7KO8SZbqoEAel58nGVMzhW0
         yyk6PtqIYhG8+uHBSmf3yK2BBZ0gIsRZ9k/e/M+mVPWQmz++EH57WzRuo/VuwZ3nHSCF
         vs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=R/D5Lu///bpOB4m2aj2O5Qlzf7lpXHfjlXg8/BZK35o=;
        b=J9kSvwEVA33xElMECzohZA6DX+oeNPXzXrq+youL8uWRPg5feTy7T8OpIoRMJBuueo
         ikyn84pfBcyKlQ5uoT/HGyUkE5PVKaOrxw26PzajQHwmLhlLjHCzUJFQzkOVH98vavun
         u7qeXJfa5gYNPNOQkhDC782p3rBCA2f1Rxzak9iYTsbF/ronrULWSmqzN9KDel8rhVyp
         3TA5odl9UZdohC9ER9AVbyypJLqVwZNnXFELPqCt2b/VPyrSrgRCp3wO5cor+PGne6n3
         yw5Yd+1hDyyZ3/Kj200QwYjIZrXwhQaYIn0WNDLHfWgmI8gBkmUe+A1seYsDtzVsqPkt
         X75Q==
X-Gm-Message-State: APjAAAXC2RINVUKI2x2zhDhDHKIh8ipdxwEfK2PHjZMf/O5i5/1rC4eW
        RQCtweYd6tG7ONPHm5FYuys=
X-Google-Smtp-Source: APXvYqzHOO5pkV1bMiVVWe57m0HaHKb6ClpdxbYUDCGAXvDMKMswoyoKi+6CG6nDPN6+03PbS/1iuA==
X-Received: by 2002:adf:fecb:: with SMTP id q11mr18549202wrs.252.1553043900010;
        Tue, 19 Mar 2019 18:05:00 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id u14sm399085wrr.42.2019.03.19.18.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 18:04:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [REGRESSION ps/stash-in-c] git stash show -v
References: <20190319190503.GA10066@dev-l>
        <20190319231826.GB32487@hank.intra.tgummerer.com>
Date:   Wed, 20 Mar 2019 10:04:59 +0900
In-Reply-To: <20190319231826.GB32487@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Tue, 19 Mar 2019 23:18:26 +0000")
Message-ID: <xmqqsgviwe2s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Subject: [PATCH] stash: setup default diff output format if necessary
>
> In the scripted 'git stash show' when no arguments are passed, we just
> pass '--stat' to 'git diff'.  When any argument is passed to 'stash
> show', we no longer pass '--stat' to 'git diff', and pass whatever
> flags are passed directly through to 'git diff'.
>
> By default 'git diff' shows the patch output.  So when we a user uses
> 'git stash show -v', they would be shown the diff, because that's the
> default behaviour of 'git diff', but not actually directly triggered
> by passing the '-v'.

A more interesting use case would be not with an otherwise useless
"-v" but a real option that does have impact to how "diff" works,
e.g. "--patience".

