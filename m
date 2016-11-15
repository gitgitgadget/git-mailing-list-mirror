Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D2B2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 22:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbcKOWPe (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 17:15:34 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36028 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbcKOWPd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 17:15:33 -0500
Received: by mail-qt0-f179.google.com with SMTP id w33so84903616qtc.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 14:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R2XaJf6x0B8bMTll07Fy+3wU7BmXFzyBxKr3+RfKEEg=;
        b=e/IjIOOWn4Qo6zwW3r3Q8OepeHZsTwIaC32ccIsv+s+qGmiQzMk9uTKghsjz/j0oss
         yqO97OjSy311Pqbi/MJwYRJ/N2D5M5l5DJjn+GID8gShyt74JzMwTNy7RnTAKARh0cNi
         7PkpB0xGNS+fLOpykynB+37SoibWRdlM15O14gmGFa+GJMLVt7yDutKIWyhiPECAsbNT
         wNTmKK1LM3LF2iGDvuF8qxx+KmE/DWAP4rA023++TJTeQvzpdS0hMeaIJkTIGYnTeyPm
         7xqip2Rl563Npudaa8ZvVUi1RnjfePnd6b2h+pB/Pow/9li6HNKsrKec+MN/ZEqM0MuY
         I6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R2XaJf6x0B8bMTll07Fy+3wU7BmXFzyBxKr3+RfKEEg=;
        b=kZzRzol8s2vioeGdjzp4W/SDlxrf392b99E+VcYk4wiO943DKmjxtFc2/n3gSSeL3Y
         dv0irGcOnYM6TPZ1fQnwX2Ib0mRG2z/qKnVegXb6oaFEr2pmOAVUBFJQTKz0nU7g0nC6
         kfqmO1k+Pb9AoSJdYU7dPD7hpCSTln84BmH/1LfuzJi3B2fdJDM9XXjzve9zo3SNgku9
         4C66DqDB+RqmSZFtTciu0DcNgTHJDBBPS5IKmzO+cqam2U7FRVDnd1Qi6bJu7V7o4x3H
         bNtfRb99PLsjN8TGMh5C6fnb34hgsEuxklo8Oc8lPsn27LPhJmhN+84Ov3pyV6THo2ha
         rCAw==
X-Gm-Message-State: ABUngvc6zxMQjo5uueDoLEPDFgtKl/1npdQ2DhtFmPzzb8QcXNIwo9lFHgByyLddHTF/sijGaMnEHjmci+Jwj2re
X-Received: by 10.200.49.235 with SMTP id i40mr12764716qte.170.1479248132239;
 Tue, 15 Nov 2016 14:15:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 15 Nov 2016 14:15:31 -0800 (PST)
In-Reply-To: <67e11474d4fd8ada2652809cf14f6c4d96be55ff.1479221071.git.hvoigt@hvoigt.net>
References: <cover.1479221071.git.hvoigt@hvoigt.net> <67e11474d4fd8ada2652809cf14f6c4d96be55ff.1479221071.git.hvoigt@hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Nov 2016 14:15:31 -0800
Message-ID: <CAGZ79kYBf_B4ZQ7CoTt62ZR-qXhHNBEWem5K-r1eOPrUPYufrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] serialize collection of changed submodules
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 6:56 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:

> @@ -560,6 +575,31 @@ static void find_unpushed_submodule_commits(struct commit *commit,
>         diff_tree_combined_merge(commit, 1, &rev);
>  }
>
> +struct collect_submodule_from_sha1s_data {
> +       char *submodule_path;
> +       struct string_list *needs_pushing;
> +};
> +
> +static int collect_submodules_from_sha1s(const unsigned char sha1[20],
> +               void *data)
> +{
> +       struct collect_submodule_from_sha1s_data *me =
> +               (struct collect_submodule_from_sha1s_data *) data;

nit: no explicit cast needed when coming from void* ?
