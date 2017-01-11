Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D948D20756
	for <e@80x24.org>; Wed, 11 Jan 2017 00:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934270AbdAKAZg (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 19:25:36 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:34116 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934253AbdAKAZf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 19:25:35 -0500
Received: by mail-it0-f53.google.com with SMTP id x2so24859801itf.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 16:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rVGKXEJdskBdRzlpseLmJ93liEeRXS9GkE+P2a/TgZ8=;
        b=AXIT1XuegFy5b9VqaW0SDcfO/Q8usNy/JPcyQqj4KMdq3Rfz9tB5BqhN2ULbvl1gOH
         qC5IYsjLu9kiHJaBy8zbxwtVSXEy//ooN/Y3TCcS40VGk3wUMqWutJ3hRGX7/qCLJP2w
         ADNvugeFBykCAEdsfPqs2wu9cFqcFeWg9FYrLdyUPNIP6L2Q0aeVtbWhOfwrdZ0BnBNA
         N95OB2bJMMfe6TDnRCRGzFTPUtd1ewhGETNtzmIOzLc4ayi9CnOD2D6RjDlfa/dyQryI
         ZquVhQqC8uaFFYJBD6EjZSf+i4yzXBjAgOuyhah9LHXTVHSXZ9e0HOCFj5p1Ags6zWdC
         7eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rVGKXEJdskBdRzlpseLmJ93liEeRXS9GkE+P2a/TgZ8=;
        b=r+vuKb0pRa8WaoCaDdMFqhyiLpQvhI8RyVI2bE/18kIyD/A8MaS8aXgCt3CFmZGlH3
         mlyBSWgAV1oIHKN2mbMlq0gWpCqGk6zN9lT/sP4n3mbvj9sijjmsH7CBS/wdAmUr8Yoq
         XuLyRdupLOrjZec5Mw2IcxLIMlbJXeg/wsBN+hoTctXojKp95FTXq6iP2KZSIaLh8QZs
         K/wokeNeI04rRv5rPMazfbVEied243ZuAiBgD3pYiqBxuIz2IFwxc2XRfGIpJ0vMFsXg
         KOeDh6sVAJjA0s8P3o+N+OStQBARmUrXi5yNxHo8J550kGTu3IEUBcDQW4qHO9wD1bkA
         KdlQ==
X-Gm-Message-State: AIkVDXJbzfnEpVAz+217/yqx372SfQVjlM2h6nnSvJ8Ilrvi05N5mAl5ZHZJr+34px8o0yEtlOg5ldG302Fa68+A
X-Received: by 10.36.141.2 with SMTP id w2mr2719604itd.114.1484094334630; Tue,
 10 Jan 2017 16:25:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 10 Jan 2017 16:25:34 -0800 (PST)
In-Reply-To: <1484093500.17967.6.camel@frank>
References: <1484093500.17967.6.camel@frank>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Jan 2017 16:25:34 -0800
Message-ID: <CAGZ79kbb8b=jLiwJAE7ktq-wYKce-152__aA3bU_uBnV1pbXqg@mail.gmail.com>
Subject: Re: git cat-file on a submodule
To:     David Turner <novalis@novalis.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 4:11 PM, David Turner <novalis@novalis.org> wrote:
> Why does git cat-file -t $sha:foo, where foo is a submodule, not work?
>
> git rev-parse $sha:foo works.
>
> By "why", I mean "would anyone complain if I fixed it?"

$ git log -- builtin/cat-file.c |grep -i -e gitlink -e submodule
$ # no result

I think nobody cared so far. Go for it!

> FWIW, I think
> -p should just return the submodule's sha.

That sounds right as the sha1 is also printed for the tree already, i.e.
in Gerrit you can get the submodules via
$ git cat-file -p HEAD:plugins/
100644 blob c6bb7f182440d6ab860bbcfadc9901b0d94d1ee3 BUCK
160000 commit 9b163e113de9f3a49219a02d388f7f46ea2559d3
commit-message-length-validator
160000 commit 69b8f9f413ce83a71593a4068a3b8e81f684cbad cookbook-plugin
160000 commit 7b41f3a413b46140b050ae5324cbbcdd467d2b3a download-commands
160000 commit 3acc14d10d26678eae6489038fe0d4dad644a9b4 hooks
160000 commit c5123d6a5604cc740d6f42485235c0d3ec141c4e replication
160000 commit 3f3d572e9618f268b19cc54856deee4c96180e4c reviewnotes
160000 commit 3ca1167edda713f4bfdcecd9c0e2626797d7027f singleusergroup

"commit <sha1>" is the correct answer already :)

Thanks,
Stefan
