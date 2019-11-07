Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790501F454
	for <e@80x24.org>; Thu,  7 Nov 2019 07:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbfKGHtD (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 02:49:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35329 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfKGHtC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 02:49:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so859119plp.2
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 23:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qGQz9WuNfA5EF7FR+LkB5BE1oGbFMJkr9UmFsP2MTtY=;
        b=BnSxa6cxkYshmS3K+Vs3NdB8daGsc5HBB7hz68iHL9SC98g/4rB9EQsBJl8TI0yo01
         nNtCxMOsDJjkYy/c9LEL95P7m8mDA42Vn4lJ/pDlLro61LyA531Kw3ozH2hEwdahGkPn
         6ONzpU5nr+TuwPY0pVttyloNknwbn/7YiVNMlxcTOne0YkHfxji+V2Z8mTa0Qg65tfR8
         uP/wz/r7ITKk9BUwoO1ouD/4hprd1pLiMTkrOX8N8Ic3ZLEur3GCQdTDARelgg5886Tt
         kiozQNaes0Z49Jl5GJN1t3a/JcFcSexoJfmDbuDr0Pc+nB5/m2/4oPRGaRizsQoy9ww1
         A6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qGQz9WuNfA5EF7FR+LkB5BE1oGbFMJkr9UmFsP2MTtY=;
        b=MzNyt087aXLcnVvx565vmEK8QDsPr7W9wb/87v6t1PWvyEhDBtPINzKb8doPHRtrXN
         kUuQYAhDj26tJjp37KT7z7uhGuKoxB4DSpeH7goSLh0UCaWikOuPu4InSmdoSxIOhHCU
         JQmZ7Ugxy7F9L8i6bvyUQNXwTSt6LxvE+s45NLitqLQ5FIbRdotdctaVyrobQtNGW/hf
         wuLM6QSwxA6ZyZX0oac3TYWZOvii0CV537nUNahcGlkddNN/TZ9TRJyEBuUsHQNJ3jQF
         uTNUH5WguANaxZ4Hmyzk1MDhn8nRfyrJPSBt4X6VfkYZW4cwVDF3K8FbZQfSwm5uLrN4
         OAtg==
X-Gm-Message-State: APjAAAUsfn0UeUnXk4JbY/i2UfLN6mhO1URrzA3a97e9bN2mRCuP1uwT
        BsEeRT1yPhwdn2Oi1XqvJdJrAWoR
X-Google-Smtp-Source: APXvYqzvGTloUyrJponc2/rMUbcY3bbuBaIWFFEFCWmSeMq4DZAkXzYE+fz4J9oCboWLhH4i6USIxg==
X-Received: by 2002:a17:902:6b06:: with SMTP id o6mr2282452plk.110.1573112941971;
        Wed, 06 Nov 2019 23:49:01 -0800 (PST)
Received: from localhost ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id g9sm1098860pjl.20.2019.11.06.23.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 23:49:00 -0800 (PST)
Date:   Thu, 7 Nov 2019 14:48:58 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 8/8] sequencer: reencode commit message for am/rebase
 --show-current-patch
Message-ID: <20191107074858.GC8096@danh.dev>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573094789.git.congdanhqx@gmail.com>
 <36796e2b679cd8b2d341058e775db401f9abcef7.1573094789.git.congdanhqx@gmail.com>
 <20191107063223.GF6431@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191107063223.GF6431@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-07 01:32:23 -0500, Jeff King wrote:
> On Thu, Nov 07, 2019 at 09:56:19AM +0700, Doan Tran Cong Danh wrote:
> 
> > The message file will be used as commit message for the
> > git-{am,rebase} --continue.
> >
> > [...]
> >  	strbuf_addf(&buf, "%s/message", get_dir(opts));
> >  	if (!file_exists(buf.buf)) {
> > -		const char *commit_buffer = get_commit_buffer(commit, NULL);
> > +		const char *encoding = get_commit_output_encoding();
> > +		const char *commit_buffer = logmsg_reencode(commit, NULL, encoding);
> 
> That makes sense, though it's hard to understand the flow of this data
> through multiple sequencer invocations. I _think_ this would be fixing a
> case like this:
> 
> -- >8 --
> git init repo
> cd repo
> 
> # some commits to build off of
> echo base >file
> git add file
> git commit -m base
> 
> echo side >file
> git add file
> git commit -m side
> 
> # now make a commit in iso8859-1
> git checkout -b side HEAD^
> echo iso8859-1 >file
> git add file
> iconv -f utf8 -t iso8859-1 <<-\EOF |
> súbject
> 
> bödy
> EOF
> git -c i18n.commitEncoding=iso8859-1 commit -F -
> 
> # and rebase it with the merge strategy, which will fail;
> # now .git/rebase-merge/message has iso8859-1 in it
> git rebase -m master
> 
> # and if we resolve and commit, presumably we'd get a broken commit,
> # with iso8859-1 and no encoding header
> echo resolved >file
> git add file
> GIT_EDITOR=: git rebase --continue
> -- 8< --
> 
> But somehow it all seems to work. The resulting commit has real utf8 in
> it. I'm not sure if we pull it from the original commit via "commit -c",

Yes, somehow it worked. But, without this patch, git also warns:

    % GIT_EDITOR=: git rebase --continue
    Warning: commit message did not conform to UTF-8.
    You may want to amend it after fixing the message, or set the config
    variable i18n.commitencoding to the encoding your project uses.

Checking with strace (on glibc, musl strace can't trace execve):

> [pid 12848] execve("/home/danh/workspace/git/git", ["/home/danh/workspace/git/git", "commit", "-n", "-F", ".git/rebase-merge/message", "-e", "--allow-empty"], 0x558fb02e8240 /* 51 vars */) = 0

Turn out, it's because of: commit.c::verify_utf8

    /*
     * This verifies that the buffer is in proper utf8 format.
     *
     * If it isn't, it assumes any non-utf8 characters are Latin1,
     * and does the conversion.
     */
    static int verify_utf8(struct strbuf *buf)

Hence, your test is just pure luck (because it's in latin1).

-- 
Danh
