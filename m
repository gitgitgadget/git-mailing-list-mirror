Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A4701F404
	for <e@80x24.org>; Mon, 27 Aug 2018 17:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeH0VT6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 17:19:58 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:43294 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0VT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 17:19:58 -0400
Received: by mail-ed1-f54.google.com with SMTP id z27-v6so8745781edb.10
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=23k0GqK7sZuJRg5OEHBX4lX1Jb6rZnlcGzY/wg18564=;
        b=GolY+7lR9sJpxinYBCzgQDt2IfF0wMIM8eIMTqNsLIjncILjZo9FKzLIJsCp1EtJKi
         +noqtYuGpNci2lxGmqP+hrbNIK9cKFFpGOvm7TYLzr5WlKLdZK49TDo659Im07tav387
         Bca8+ih39ce7yOc/z1M0njGwPJF4lIE2J/WRp5MYr03vlOiTS93sO5lu8Ffxvz3v/FL/
         abFU73GSY32wuO8CGUkedZk93KgKaUkATB45DnyOowf7DuPaEFM2vadPzpSuzhxXkNpo
         vzVNBaiA+AzS5kjdPCHD71vaLAvtXA8n7z4bQ0+cPJokZKaMf+hmNwNm9YqStbCXpuGj
         RqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=23k0GqK7sZuJRg5OEHBX4lX1Jb6rZnlcGzY/wg18564=;
        b=F39gp5HWYJMcoEUoCx/4iN52thE6q8eXkiTPzortkPLbAdiG0qc/2VWNYHoBtEHCLP
         +nSL5J+CNGfyp6D4fOCOHtkx5JqmsA5ccqI66Mft9DBThlIY6WZzU937dg0PUKWG/rzs
         PDeMsWXyCGJInHrlx4ZTugyEGssSCuxjP3dBSgOvPqiDWY2SFaXkUJEOgcIzwClXVZUH
         yzt9HEch9qJGAp0DcOfLvQox+pno9oK21DGG6v5I65TjxBD1kb0NpzydcIEYzQIF6dLg
         KA4Q+ermC5UWcuUrSouYAPgaLdgcnMTIuVEByY7HSHZH/Cxs8F53lbSX5gVbSYGg7B/n
         NO2w==
X-Gm-Message-State: APzg51C44N7u6PSI0MQfbuACxlhfFDGls/T5bAmL5xr4jz0fxJo3t7Le
        OnCs3IAtcZTfej3gCogI70JyjZEQ8rStEMv4ue8v2g==
X-Google-Smtp-Source: ANB0VdbrHF4PieqioIuyVwiyUlaeK/n1YcsgFgTOIa8tEoVPylFIiXcuN/DH+OTzcCHB8tZNYzhcbMDdkrZs20G63Sc=
X-Received: by 2002:a50:b603:: with SMTP id b3-v6mr1016435ede.181.1535391145944;
 Mon, 27 Aug 2018 10:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com>
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 27 Aug 2018 10:32:14 -0700
Message-ID: <CAGZ79kas5TsCi0yN7mypH53A1iOveGNmQ03BkmspEH1-NfZgBg@mail.gmail.com>
Subject: Re: [PATCH 00/21] Kill the_index part 4
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 26, 2018 at 3:03 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> This continues the journey of getting rid of the_index at least in
> library code. The focus of part 4 is diff code. Since 'struct
> repository *' is passed around more (and even more in part 5), I take
> this opportunity to remove some the_repository references too.

yay! Thank you for continuing on the_index!

>
> Besides some small conflicts on 'pu', like the previous part, it also
> breaks 'pu' because of API changes. The fix is trivial though, just
> prepend the_repository as the first argument for the broken function
> calls.

This sounds like a problem. I said the same when sending the
object store lookup series, which ended via
3a2a1dc1707 (Merge branch 'sb/object-store-lookup', 2018-08-02)
in master, but I do recall Junio being somewhat unhappy about it[1].

By just adding the argument to the function, it might merge easily
but not compile, which would have to be fixed up; and that object store
series seemed to touch a lot of functions that were also used in series
in-flight.

I have since lost track of the refactoring and focused more on
submodules again, but plan to come back to more 'repositorification'.

> After this and ~20 more patches in part5, the_index is gone from
> library code.

This sounds promising! I'll take a look.

>  diff.c                 | 259 +++++++++++++++++++++++------------------

Ugh? That sounds like there is an interesting change coming.

Stefan
