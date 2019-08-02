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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A2921F732
	for <e@80x24.org>; Fri,  2 Aug 2019 21:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437095AbfHBVAb (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 17:00:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36000 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfHBVAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 17:00:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so36616388pfl.3
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 14:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKlK6n7W3D4iaqk3z/tJSKn0hGKOwcg1MmNy9HRKj+8=;
        b=QClXEVtpqVuQtdJiovB+hXJuQR11ytUb+0XVf+71r8IUUA4F8reQ4dHgxmLaFQdwWP
         bSexLFV5rhBh3fKd7Gqf7/nXE0Z2fccpFZsj9OWeybHb8W2sBSL3N2f375kZs2faIQme
         ywg99FAgXDfVwzr/nA2/CIOMYxbPK09t8d9tm1rq8423a0sjCYKywmhENN1eOMkzLuTL
         5O94mBDQ1jJAg9Fbhp0H7Sk6Sh6bVzfTvK95woGuXIdJqArapr1iRov6utHQW+vttO1R
         P8wVU+ruPBxBFfgjCSvwH5o5AJ9/yguEyxaTdnEvGcx1rcp2Q/EVIRF+ssAm/9GCexZh
         HT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKlK6n7W3D4iaqk3z/tJSKn0hGKOwcg1MmNy9HRKj+8=;
        b=j5O7mTty2iwOtccVUAGZnJOSh+AVuVXJHIH82bSYEwsHTcjOEqr8cPqYx4cYTtlFnw
         k/g7lnO0ZJtvszJyRiTBpUU0l2c77+XLz1UEk2YRUiqnLVnueV855oryUZ+0VVdGNbC0
         hDsVo22NqdfwTCW6vzythSFFl7FmVKNG3ue6CF4P7Pc154yy1TBoVVKdwyDs97OLykl9
         PJhzDimyeLw9uUkg45SgWhLu1WIYu9EndhufTHWPHgGjGWyfRociKI78q5EAMQqfgeSz
         /+y8usqF8YXnArRvbcMUs5d4gA75PokWSwA/7QEW+ClIUlDRuCocWwff5TPHNe94pBu9
         H3dg==
X-Gm-Message-State: APjAAAXoshiRpcFXKXD3He6BdzLCmYLTLk/Ec3wUPymZZ2FsOS2kSIVG
        LQlfFhfuqeN4T9ztWCiD22c=
X-Google-Smtp-Source: APXvYqwEDa9OK4J7AfdBf+7wI04/EwXpjr7CIDSzqGYW3T6cONQ+cQBNrxEZvrMI3fXE9xZfRFB0OA==
X-Received: by 2002:a17:90a:2305:: with SMTP id f5mr6424918pje.128.1564779629875;
        Fri, 02 Aug 2019 14:00:29 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.226])
        by smtp.gmail.com with ESMTPSA id 201sm92327121pfz.24.2019.08.02.14.00.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 14:00:28 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v2 2/2] rebase -i: support --committer-date-is-author-date
Date:   Sat,  3 Aug 2019 02:27:31 +0530
Message-Id: <20190802205731.13794-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqqwogdtzxc.fsf@gitster-ct.c.googlers.com>
References: <xmqqwogdtzxc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Fri, 19 Jul 2019 15:36:15 -0700 Junio C Hamano <gitster@pobox.com> wrote:
>
> [...]
> Hmph, are we sure that author-script is always available at this
> point so that a call to read_author_date_or_die() is safe?  There
> are three callers to the run_git_commit() function and I am not sure
> if codepaths that reach all of them prepared the input to the
> read_author_script() helper.

Functions do_pick_commit() and do_merge() always write author_script
before calling run_git_commit(), so,  we are sure to find it on disk.
Furthermore, commit_staged_changes() only calls run_git_commit() when
rebase is stopped (by merge conflicts or 'edit' commands), so we are
sure that the previous invocation of git must have saved author_script.
In all other cases, we fail as we should.

> [...]
>
> In the same function, we seem to be grabbing the author ident by
> calling get_author(message), where the message is an in-core copy of
> a commit object, which suggests me that we may not necessarily be
> working with the on-disk information read_author_date_or_die() is
> prepared to deal with.  Are we sure we have the needed information
> on disk so that read_author_date_or_die() will read the correct
> information from the disk?

Yes, in that case, we can re-parse the author date and re-set the
env variable while we are in this if branch. I believe that the
information stored on the disk is same as the information retrieved
through get_author(), please confirm or disprove this.

> [...]

With all this knowledge, I'll polish the patch and re-send it.

Thanks
Rohit

