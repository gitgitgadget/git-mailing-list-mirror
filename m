Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1CEF20372
	for <e@80x24.org>; Tue, 10 Oct 2017 00:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755935AbdJJA1g (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 20:27:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32832 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755826AbdJJA1e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 20:27:34 -0400
Received: by mail-pf0-f193.google.com with SMTP id m28so31198520pfi.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 17:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R5RR9KbPoVoYH/jIX5M8wK0otx0KQzQhv6LKkm7oViY=;
        b=k6nmP34amQl/m7BolVlgGeh9cA0nCk9DUcoMXrAqz7yXGQdgYk4jJ/79vfkVlMM/7T
         bHo6liErdQKceM21BR7iXBzsslsgFddYo6Afl2kOnYM0YTpCQYDSDBh2cxXLNJz/lvZP
         cpfDnsnc1/9f75JcUXFR5fmlikdyiZur3PjjvB0TZMAjmBXAhc4KthcTMhJYOeKXp1pj
         DJK0dBkiyX4Xtn/a1c55W+ZBPEN0OJ4jlucaQ6kmf1jyQYTXIkc01qnuAEh4twvFjeJX
         P3m7o/JeokIitGYmWlfYhqGRtloF9pck1bH25FBgH9vlL3Th3+ccHHZcn5ZQu0KSlygE
         ovuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R5RR9KbPoVoYH/jIX5M8wK0otx0KQzQhv6LKkm7oViY=;
        b=GP+fv57Y6Tf2DJ0J27FEPwIjdqHZJXVUfmuKI/mJIMhrSzvibP7m/T4LOuqm7Bq92O
         ZfPS97abLIkJybAyf/zeH4XC0gJxDNadjVTLr0Zr6dMB/nEaBWzDrnpaCqnFa12VRox3
         sTDTKXlX2t53BDXqpcA/6W3l6UzpQEp/Z48ux6i8jRsyiY959u86xgNsyBiIznoAbDWm
         UMAH6+E+DKYsAvQEhh5kTxYXCKe4TCJVgWHOirOYX+oozlX4KoCmd2I/PzZQ/BVj4RRW
         VviYPecDp3YYO+MipSl0awxQEMgjWUk5Hs+g+JBHr8aavEzyRzRDWg8+3fgAlwfasDAv
         edJg==
X-Gm-Message-State: AMCzsaVPfF2pA45Cm+rRj4GHFJhABanoQPld33irfsqyUh/uFke2K96O
        GUjz6A3311o7+79SbmBhuw8=
X-Google-Smtp-Source: AOwi7QCUDtldV9XcgKmvMYiterAgH5f72mYW2V9+3mJRY9viozgCde7gJCvzYV5RSnjuYyxrImm5QQ==
X-Received: by 10.98.133.4 with SMTP id u4mr11732461pfd.79.1507595253757;
        Mon, 09 Oct 2017 17:27:33 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id 74sm12714794pft.184.2017.10.09.17.27.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 17:27:33 -0700 (PDT)
Date:   Mon, 9 Oct 2017 17:27:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] submodule: spell out API of submodule_move_head
Message-ID: <20171010002731.GM19555@aiede.mtv.corp.google.com>
References: <20171009220615.27541-1-sbeller@google.com>
 <xmqqtvz7rh68.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvz7rh68.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:

>> +/**
>> + * Move the HEAD and content of the active submodule at 'path' from object id
>> + * 'old' to 'new'.
>> + *
>> + * Updates the submodule at 'path' and files in its work tree to commit
>> + * 'new'. The commit previously pointed to by the submodule is named by
>> + * 'old'. This updates the submodule's HEAD, index, and work tree but
>> + * does not touch its gitlink entry in the superproject.
>> + *
>> + * If the submodule did not previously exist, then 'old' should be NULL.
>> + * Similarly, if the submodule is to be removed, 'new' should be NULL.
>> + *
>> + * If updating the submodule would cause local changes to be overwritten,
>> + * then instead of updating the submodule, this function prints an error
>> + * message and returns -1.
>
> This is not a new issue (the removed comment did not mention this at
> all), but is it correct to say that updates to "index and work tree"
> was as if we did "git -C $path checkout new" (and of course, HEAD in
> the $path submodule must be at 'old')?

I don't understand the question.  This comment doesn't say it's like
"git checkout" --- are you saying it should?

The function is more like "git read-tree -m -u" (or --reset when
SUBMODULE_MOVE_HEAD_FORCE is passed) than like "git checkout".
Perhaps what you are hinting at is that read-tree --recurse-submodules
is not necessarily the right primitive to implement "git checkout"
with.  But that's a separate issue from documenting the current
behavior of the function.

> What should happen if 'old' does not match reality (i.e. old is NULL
> but HEAD does point at some commit, old and HEAD are different,
> etc.)?  Should the call be aborted?

No.

Thanks,
Jonathan

>> + * If the submodule is not active, this does nothing and returns 0.
>> + */
>>  #define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
>>  #define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
>>  extern int submodule_move_head(const char *path,
