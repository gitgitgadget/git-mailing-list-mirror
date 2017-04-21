Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6731FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 07:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035751AbdDUHCN (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 03:02:13 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35815 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970211AbdDUHCM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 03:02:12 -0400
Received: by mail-lf0-f50.google.com with SMTP id 75so40085059lfs.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 00:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0huZUpEZZKWghGVu1ZnkAcxjjq8Nayk59+09r49GunU=;
        b=X5+VTxZcUqoV6DMtwRAZTwccfGgB/KPKU0VhA5zZ7j9GUNwJ4/sb3Ml6e2/kzmn6QT
         GNCacCbPEPs6M0wabfjc36+Mc3jfhYbiuwMs/QYPVgi7rN3mlo0GuutP7U+HZaXw1Tnv
         AwYBVgVm7XfD6v2H2H6MPzvtVYJ2ifvMy9a7Adf1zCVrCUxyJF/byslvVsWsTCSyT4VN
         /PwENF+ytZJBrmCuDtiAuhe+E6GJtzXLSs8617OOYyVlvRWk6oS8OTn+5HCB+Xe5xkVG
         cLoUiCHW2xqh4N1OZ5L1RUW5GEqxKeONDTtQIcNlch7I9Tn8hEES4SfWUnQMh/sxSaMk
         7ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0huZUpEZZKWghGVu1ZnkAcxjjq8Nayk59+09r49GunU=;
        b=aa0Ww+OX8TZ07wFs3WssXV4fxKxm0DfpummdsIkTy435Jhl59vuDQSqEHu07t5YNNY
         euRpdqxFzmJ5XaVo1hIBltrkjlg/0M7wEcVSesRC2OK8T/Y+a2vkPXc0TJ5REKbdsAep
         aktKJp9kHO1o/gMiYW6kilQcAmXoQc5WbATQfFEjQuzJR2n1aMKDvHR13dw6k3oVBNNy
         j8SUFOKJccyd+xzPrS0n2iOh3R36fxCpzYZsJngnjOLAlMYXQgBKjupRtieF71u9NiMT
         FqVxKPHiXPDF74HHIFZ2Y71OoyxnQzdIstB8LG3ccW7I1PVH0bWs6VALitDRUCW6uE4o
         TvIg==
X-Gm-Message-State: AN3rC/7DDI3MX+zXKnK/iyFzHKuArsAW62s8U9jdVwXDkqTeGW9Xzfz6
        GNJMbTXTPwBFEwTEIWmoCZElRK7g6g==
X-Received: by 10.46.82.137 with SMTP id n9mr4296562lje.0.1492758131098; Fri,
 21 Apr 2017 00:02:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.67.78 with HTTP; Fri, 21 Apr 2017 00:02:10 -0700 (PDT)
In-Reply-To: <xmqqfuh25rzz.fsf@gitster.mtv.corp.google.com>
References: <20170420205214.GB4989@hank> <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
 <xmqqfuh25rzz.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 21 Apr 2017 09:02:10 +0200
Message-ID: <CAP8UFD1N_PoQj3yK1XgL8L725UA-4NOgaNLVEXMrjNhOW=jF_g@mail.gmail.com>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 6:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Could you try with the following patch:
>>
>> http://public-inbox.org/git/20170330210354.20018-1-chriscool@tuxfamily.org/
>
> Ah, this reminds me.  The patch has been in the stalled state for
> quite some time due to confusing description.  How about explaining
> it like so and merge it to 'next'?

Yeah, I am ok with this description. Thanks!
