Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D32941F404
	for <e@80x24.org>; Sun,  4 Mar 2018 02:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeCDCTL (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 21:19:11 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39113 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeCDCTK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 21:19:10 -0500
Received: by mail-qt0-f196.google.com with SMTP id n9so1675307qtk.6
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 18:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=rzJOWunxwf5Xtiaq/jNMUrX4G8sGYfJFSpzNjartGPQ=;
        b=RycZlRJySzetMZiRZMKiX4B6VQx8eTPqf2iIVsXI095yyzukIxRBJWwgKMQh3aAwiQ
         mjZXKI1vp0FZe2flnzCl+pngmi6J4/AzUbCZ7uIgkjQXIPTXiaduwfCVhnvIjF3nyLCc
         mzkEy5+h6WqBz34Hlh+1i4qS9420b2jNk6fzUxh2BsJGwoSLr0eZvZ061my2ZvtVl4wU
         H2/gmf2c0z2T8BzDWTRrVREnTQ95NRvRowFmbQTN5GHf6RfhktmIcl7HF/GoLapj5syK
         sGzYxlsXtesaj/gGna9xrt+aZ8WU1qmi5/s3SRcOTI2G4duMDs8T9zyLbycn/ZBs6Zzt
         urCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=rzJOWunxwf5Xtiaq/jNMUrX4G8sGYfJFSpzNjartGPQ=;
        b=WTDGdghO1/97QhoxoKFEXwjGpkq9V+ybxu+8liMxDhUpMLuVz200ZIbfGgXf5s8FKC
         8ZaAizAcdLS4qC4MniND8g5iD9W5a45OwiWohEUVPP1BM0M4naneyfUYGHc9W+VJgVgT
         IRrFV889g7wQbspM2NHJQJYVmP8r6yP9bfds2XlcpCiOkkysxDB3aLtSfqVqmgwOGCOE
         2X+tDlZz/prNkIig0SvuSBubXlf5/KEPVwoS+A021RP6077TviyAh4Z5MPY0P6SYHykO
         6Uo9D4SrnfBeUsgg7JhOyJEn3fG/4xVHRWhCtf9d4Qmfk3KQoRzhBFAHO8j48uBIl9UQ
         7Beg==
X-Gm-Message-State: AElRT7EudCj4ATJC215smJcQVShoN0av9XIOx0+T/Kj1L2PRNdnKhgKS
        GbUePOgpxIjPy9xU2G6T0iqWoq2AqxwRMDQL5Y0=
X-Google-Smtp-Source: AG47ELsSzMp2QsrmdL2/0bGzHk7+ZzHG+hQQnz1Pcy04lipfgfBVzyHNw7kjSzSWUODA/zCH4ya89czWlD26IpGRhDI=
X-Received: by 10.200.12.198 with SMTP id o6mr15613637qti.246.1520129949929;
 Sat, 03 Mar 2018 18:19:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 3 Mar 2018 18:19:09 -0800 (PST)
In-Reply-To: <20180303113637.26518-7-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com> <20180303113637.26518-7-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Mar 2018 21:19:09 -0500
X-Google-Sender-Auth: rDljYi15FGZIBNqs4Z9rQgo8AFU
Message-ID: <CAPig+cRV7eRWMdONVNrFwF86Zbw=_hY-L354MNT54wwazjJRgA@mail.gmail.com>
Subject: Re: [PATCH 06/44] repository: introduce raw object store field
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 3, 2018 at 6:35 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
> The raw object store field will contain any objects needed for
> access to objects in a given repository.
>
> This patch introduces the raw object store and populates it with the
> `objectdir`, which used to be part of the repository struct.
>
> As the struct gains members, we'll also populate the function to clear
> the memory for these members.
>
> In a later we'll introduce a struct object_parser, that will complement

s/In a later/Later,/

> the object parsing in a repository struct: The raw object parser is the
> layer that will provide access to raw object content, while the higher
> level object parser code will parse raw objects and keeps track of
> parenthood and other object relationships using 'struct object'.
> For now only add the lower level to the repository struct.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
