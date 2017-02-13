Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E702E1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 23:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbdBMXJm (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 18:09:42 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:36268 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbdBMXJl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 18:09:41 -0500
Received: by mail-it0-f50.google.com with SMTP id c7so8157789itd.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 15:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sx+a+a5TxyW7JBmm1KZp0YN7/87bm3lrtS31rkEZmW4=;
        b=vMcaXxf/IJAGqZWAyIFh0wt3Pd3M30zXVgBu2f6crQ6g7lkyuSJ34VGaPKsrZ2tQB+
         dgHTQjxd/SvfFMA7vDG1DT4Z/28JSZxQbn6n8Cc+ZevxDvST4Zkgu8/eK5pF4A9hs1m5
         pXUHraAP9wlYvjkghh7XlaJMM5j2a1tpWb55tH2MeBcixRzyL0hgeNmSDw8Sjj8L5U/F
         +CGmw2g9GSIcNh5iuJK/PZ/Uu6hczQ8GztsYcpVJfZheXxhs4LJ7lmMA8WTqoUyeUqIp
         jVHDzWCDuL/yC67WRPTGbBoMkibLBG5pJOH/JP5pF5jkkqTHQGjk5URPp3okQlVDdC/7
         woUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sx+a+a5TxyW7JBmm1KZp0YN7/87bm3lrtS31rkEZmW4=;
        b=W4rZqhkVfv5ZvJUn5M17NYCbTjma7OMFf+FxGIjb0WSFC28K+IG28hZ82ouFgY0OWj
         thS4D5LOfmk3j6gOYFfvpWUjp36m9EXgBUNqpRBoxz4PldhoIIH3hA0A6DBBDaI0EqTl
         R4KYGLQuQf8NfMCbGNNIY9e9H2ZYzOwl0dg4EURb3IGi4+cWeUnPDMCRHG1vlYfUqgAg
         wjQXxqZWepMkP7OIfprZxngGQvObxfB9pqsRdy1H9rwn3parD4+mZRdYhk4kw16GtLgZ
         EbBOwrQVYYpEencV9J88S4D8BnOYXdrux7PPikxxGAWKtXN8IFvDcMY/7dn96dKmXrpu
         AQfg==
X-Gm-Message-State: AMke39mQaexpzKnrPPLMsjJPyMh/v0qxLdrT8HgGdXwPfRbpKEt3Qa85TP+N0YQTo0nesv8MrTKWeSmVffCdhiwh
X-Received: by 10.36.34.79 with SMTP id o76mr808029ito.116.1487027380875; Mon,
 13 Feb 2017 15:09:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Mon, 13 Feb 2017 15:09:40 -0800 (PST)
In-Reply-To: <20170213152011.12050-8-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-8-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Feb 2017 15:09:40 -0800
Message-ID: <CAGZ79kbJXUY=UGvHtkeLLj-qMaoOyTwa2dr3-FqEdYi8eFs4LA@mail.gmail.com>
Subject: Re: [PATCH 07/11] files-backend: remove the use of git_path()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +
> +       if (submodule) {
> +               refs->submodule = xstrdup_or_null(submodule);

drop the _or_null here?

So in this patch we have either
* submodule set
* or gitdir/gitcommondir set

which means that we exercise the commondir for regular repos.
In the future when we want to be able to have a combination of worktrees
and submodules this ought to be possible by setting submodule != NULL
and still populating the gitdir/commondir buffers.

Thanks,
Stefan
