Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D45A1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 05:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeCMFbM (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 01:31:12 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:42006 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751217AbeCMFbL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 01:31:11 -0400
Received: by mail-ua0-f170.google.com with SMTP id b23so8415608uak.9
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 22:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pL/UdisPWlsiyNBI6QMiaDyuBlvR/4tHFFzBHKnVw8o=;
        b=szTRk4biR5YI1QWjJfQL2pyMNp4LTxU9U6Vwv5nHy2067pgmxhxLjwuJA/001E0+rl
         J2A05ufxLTBEj88py8hX4QptvwcBBMkszimKx1lLf9KQms74qtoShYuuqYPCBP6nf/8J
         MJiv6HFzY+7xcWfuHD8vmTi3K7jxcic9vQWHeFreRI5FKrEc069iXtsm3ZoSbpKTHnQZ
         ipGCFCtMd8OTwZeByYehZuVjp9GJv4l5WjuRWfDeHJt8JRa7wgFPPYocEmthLt0308Y3
         OfOZ+puxQuwVH2nb4yj2IeVLpu0yQtoC3AqMPP3M801qHSY8jYVtahVJc7OgQa7YDiQz
         F1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pL/UdisPWlsiyNBI6QMiaDyuBlvR/4tHFFzBHKnVw8o=;
        b=PQRGoE9u1SvT4ixgoo6sSwBCj+pvWyjrvUE0FgQ+n1Fgf6ODicLEHt8v90WtrHcdZG
         V+vvbYybTDrMel0m5pLSJ1XrKjGqNI4PqAY6U8RFlpxpMRKggcKY3QuVMwlu70BzH9MJ
         17E3cANuGIQeX92K0oM4AT33QP+projghD+svMO8GNAjm7S1Gu1z4N3lOvG0dMw43XTP
         qkeFYNQMNtuxjbxVCleUMIlsXPDBrzqpGfBQ37U1ketpMF8hkq7GBfqcptxq0pCJfUaH
         BxiuG5isU03IaWF6MysSh8Ota6vU4nptiAgEa9a7sN0va9PPJjm/8Mjftcy4zX/h/rSc
         PAeQ==
X-Gm-Message-State: AElRT7GC8i4cniUVU10Z7CZrxnObXenUxZLY3CJLx/2XgDpZjJHUiJAE
        AsCl63HFkuCJRUjhbTrijaLiG8RvBgify0gQY+c=
X-Google-Smtp-Source: AG47ELtEA1+FIYlb86Eun7bhHSAKQDJPgScUA0aY2XCoBZiEwVwtJjoQXcpx7KHt4tp8fwMoD7KMusJFLy3ErPuqduY=
X-Received: by 10.176.25.216 with SMTP id r24mr7338007uai.156.1520919069825;
 Mon, 12 Mar 2018 22:31:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.191.140 with HTTP; Mon, 12 Mar 2018 22:30:49 -0700 (PDT)
In-Reply-To: <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <20180312184734.GA58506@aiede.svl.corp.google.com> <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 12 Mar 2018 22:30:49 -0700
X-Google-Sender-Auth: XGAgowbCDgvHTfYmkcGHrHQ8F2g
Message-ID: <CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com>
Subject: Re: Opinions on changing add/add conflict resolution?
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While I do not think it is a bad idea to add an optional way to write the
contents of conflicted stages out to separate files, I do not think it is a
good idea to change what happens to add/add conflict by default.

Two integrators picking up a same patch that adds a file separately
and allowing them to diverge before they are merged should not be
all that surprising, just like two integrators picking up a same patch
that changes an existing path and letting them evolve independently,
so from that point of view, I do not think there is fundamental difference
between edit/edit vs add/add and rename/rename conflict. The latter
certainly would be much rarer, but that is because edit happens a lot
more often than add.

There certainly are cases where conflicts is easier to resolve when
the merged tip versions are unrelated or diverged too vastly, with or
without a common merge base. As I already agreed to, it would be
useful in such a case to have an option to write the conflicted stages
to separate files to let an external merge tool to examine them and
help you resolve them. But that is not limited to resolving vast
differece between contents involved in an add/add conflict, is it?
The same tool (which can be driven as a mergetool backend) would
be useful in reconciling the difference between contents involved in an
edit/edit conflict, no?

If anything, if rename/rename behaves differently by always writing
the result out to separate files, it is that codepath whose behaviour
should be fixed to match how add/add conflicts are dealt with.
