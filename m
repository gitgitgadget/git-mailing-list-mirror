Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C58B11F803
	for <e@80x24.org>; Wed,  9 Jan 2019 22:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfAIW5p (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 17:57:45 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:35026 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfAIW5p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 17:57:45 -0500
Received: by mail-it1-f170.google.com with SMTP id p197so13573974itp.0
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 14:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vORHJVhUDV3c1ml0qoY+PK2/k+O+0vkOKxiZDcHf6IQ=;
        b=o4zHhxKPOjjKhuRD1GJjAr0hVjgm9gnW8ExY3nJL5gz3aWCWpSE+TUMBFxedTFQDWc
         rTuaqiHNNww2nyYNrbwJTXNK8AMRZYvDEPCUurabl/vgEeqazxncomWtjLGm8y9PxHA5
         btjTYccQETWGp3uIkYnSuBmDgBFm1gAKg7yqpLxJzcIB14dXdwv15Kr3IRn8aJ9undPL
         NCDrqB902aWAJzAEE0Kk9IDMK4U/7At48o4ajY5SqXP6N2VwGI/MTlf0EF2ua1RJh9jj
         hn8cEN4dJ6VijLjFJXyAu54CVQClturTdZZkYSh507BPJ50Jp/oobfxOxv3UF+2Lf014
         3RAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vORHJVhUDV3c1ml0qoY+PK2/k+O+0vkOKxiZDcHf6IQ=;
        b=bcchvOJ4yewlUVzWTR70ChxMIexGvbEWb4Li13AZvnLb57ipxPR1JZWHuOCFvqGf8I
         //25CtacWzDLJqWt31Sd6QBJPxYa2jec+7OKWIqE0tW+PqX3Pd2MpN0IITm6PgIx8fa/
         wJ6g8f27sBe38CuIE435grfPJnYkuiNQIw5WgcWS+fsWyKjB1JvmEQW5U1opLu0cGLVT
         Lfo31f6GMtMKxvT/TTp5Z1asY2NySBEs+8QqwxVrxr0hlwLuvpuCvqlIj1ny6iDOhy/x
         BZ4xe8GM491JHikl+LKUD5z1VQadI/drQtfIsr0J1zbLr1QFj6JIcqOBCnnQ4qmBCtdI
         dhYQ==
X-Gm-Message-State: AJcUukf+YPwwMuACTrAxRHaTRckR0SsqvqEand6unWPbs+0w+a0o+WJp
        KQtv5kEE2pM6F36kVf5ugwXsLSqcdusSEPW05F0kTdzj
X-Google-Smtp-Source: ALg8bN4G+SKVRmV7s52GzYM8e8ArttLouZM6Wl1xoN3Zri6VveqrssNxoTzENiETXZ7xFD8nXM5lJvqMJKwV1RObEHI=
X-Received: by 2002:a02:359:: with SMTP id y86mr5133194jad.1.1547074664496;
 Wed, 09 Jan 2019 14:57:44 -0800 (PST)
MIME-Version: 1.0
References: <951cafaa-877b-4815-862f-5ffc43e6976a@googlegroups.com>
 <1413fbaa-8a83-0f43-afcb-5cb67683b505@iee.org> <CAPktr3k6GmYkTE9=0jcs8+4BEeeAnvQa6daxnwcqTwrL91Y-ug@mail.gmail.com>
 <20190109162045.4mit42qvnz6fpb3j@tigra>
In-Reply-To: <20190109162045.4mit42qvnz6fpb3j@tigra>
From:   Daniel Fanjul <daniel.fanjul.alcuten@gmail.com>
Date:   Wed, 9 Jan 2019 23:57:08 +0100
Message-ID: <CAPktr3kR521rw1n0Sw-q-gkHQrc3wwLyhSo=aubrDTT3-sLhUQ@mail.gmail.com>
Subject: Re: [git-users] git checkout file with custom mtime
To:     git-users@googlegroups.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The mtime of the files in my working copy change when I amend or
rebase or checkout different branches or in general when I use git
commands. I carefully store the mtime when these files are generated
or overwritten and restore it when it is going to be read. The tool I
use is https://packages.ubuntu.com/bionic/metastore and does not have
stale information.

I do not know how git lfs will work here, it handles large contents
but I doubt it will handle the mtimes as I need.
