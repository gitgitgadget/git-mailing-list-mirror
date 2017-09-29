Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1440E2047F
	for <e@80x24.org>; Fri, 29 Sep 2017 07:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbdI2HSN (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 03:18:13 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36907 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdI2HSM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 03:18:12 -0400
Received: by mail-io0-f194.google.com with SMTP id 93so481339iol.4
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 00:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2aHEHJ879DCrXfTlD1HsHcHxFspvUwwno0AOXg5S/Wc=;
        b=Cwav29mErxcQdxkzpkf0x7At8MPiAf25JbrqHy/DOV4okHWq566D85MDP7Ji95vQHU
         kVb9iMGpD4cB4TGm9MWVSTmJdjbBl3HmRjQqgsZeV7MSPLcbfYUTyvGDvIBTilMqjes0
         +gqPEwwU6viXZPQYdv0ytuSpweZXB0gEiTFoNoPMfa1ng+4K9rcNzQXRSlJS0Vw3FxvL
         5Maw8cAUp92uiymWrIXGPlq7FntjofGn/5aPQAYTRuzWHgW8aeBfe1UFOWuQyUmkQ758
         ZtygDwzICDR7NaSff4HxOOgcLQ/qKxWqS4V/hydVBmJk2WZx0nlRwCva/V9afG8R6Nyv
         tFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2aHEHJ879DCrXfTlD1HsHcHxFspvUwwno0AOXg5S/Wc=;
        b=OezI5YgfI88VLjaBCNKXPeQIXCFv9/YarBx8axe+llunVDb4adyabn/7JL8MJ3ULiP
         JH1dgvRoq6fsoO/GvbKfxf4xPOZVou8jUpgkckQ0YYBTz+6gHcsBlsLrD8iUQ6W6s6Nx
         +gUUGWK0MSjx4EUpFwIJ2RvZaPXPNPgBYruniREA7ayqdTp6+0O8s9mIKe7Fim0o+NQb
         Mfb8IjVdE/LrBvKohvWm3+qLL9xZ4dH34ddD+xSW5cXoUQP75jE4wL7+s5I6w5N29tf8
         Y6yR+EQBx4TEGVUqBixGIcoy7j3K/vKfuKA/JNy2afNHAx0jkG/PCid+vKK1rE8/1Gzh
         u+zg==
X-Gm-Message-State: AMCzsaVKa7mvraKPUq09ZhQkoQlYnbE6eqSeiQopAC0Wjd+h6Iw9842q
        3tY7k4agNgK8WRGY6X8DkGPrtPOoefwjH2CJ74tArg==
X-Google-Smtp-Source: AOwi7QDYJSKMI2WwFfQpdvg1CFuQXF2Z4J2oOAW3nzLbHxow1G5nuM1GgZeBYFIRGmK7XJoRSxCUdyDgZACZ/rA5uzg=
X-Received: by 10.107.30.77 with SMTP id e74mr9386539ioe.277.1506669491988;
 Fri, 29 Sep 2017 00:18:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.125.142 with HTTP; Fri, 29 Sep 2017 00:18:11 -0700 (PDT)
In-Reply-To: <20170928224244.pi34zwifnornssqk@sigill.intra.peff.net>
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
 <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <20170928224244.pi34zwifnornssqk@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 29 Sep 2017 09:18:11 +0200
Message-ID: <CAP8UFD13obkLWyuCGUpFxryr8DWfQ8W4JNn04ajO50PvF0SnXQ@mail.gmail.com>
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
To:     Jeff King <peff@peff.net>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 12:42 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 28, 2017 at 08:38:39AM +0000, Olga Telezhnaya wrote:
>
>> diff --git a/packfile.c b/packfile.c
>> index f69a5c8d607af..ae3b0b2e9c09a 100644
>> --- a/packfile.c
>> +++ b/packfile.c
>> @@ -876,6 +876,7 @@ void prepare_packed_git(void)
>>       for (alt = alt_odb_list; alt; alt = alt->next)
>>               prepare_packed_git_one(alt->path, 0);
>>       rearrange_packed_git();
>> +     INIT_LIST_HEAD(&packed_git_mru.list);
>>       prepare_packed_git_mru();
>>       prepare_packed_git_run_once = 1;
>>  }
>
> I was thinking on this hunk a bit more, and I think it's not quite
> right.
>
> The prepare_packed_git_mru() function will clear the mru list and then
> re-add each item from the packed_git list. But by calling
> INIT_LIST_HEAD() here, we're effectively clearing the packed_git_mru
> list, and we end up leaking whatever was on the list before.

The current code is:

static int prepare_packed_git_run_once = 0;
void prepare_packed_git(void)
{
    struct alternate_object_database *alt;

    if (prepare_packed_git_run_once)
        return;
    prepare_packed_git_one(get_object_directory(), 1);
    prepare_alt_odb();
    for (alt = alt_odb_list; alt; alt = alt->next)
        prepare_packed_git_one(alt->path, 0);
    rearrange_packed_git();
    prepare_packed_git_mru();
    prepare_packed_git_run_once = 1;
}

As we use the "prepare_packed_git_run_once" static, this function will
only be called only once when packed_git_mru has not yet been
initialized, so there will be no leak.
