Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F7E2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 18:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932641AbcISSft (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 14:35:49 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36034 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbcISSfs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 14:35:48 -0400
Received: by mail-wm0-f52.google.com with SMTP id w84so91373739wmg.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SLofSjcvLUVjCES26Q/bVcnwJv1WtsF2a49gpFE2WBY=;
        b=MAIZlPzjWbyARN1trmmR5/0Pozr+ajtQuEeSMBZwcMV0BnsgFKYviYYwTqruuKo+Nt
         LYi18wvWTnGhqbhbKXRpTUiREiZRDTyEO7T8qeXZ+mn/1oogaSFoKIT+A4V5E0/TN58I
         uwe/T1+WlYr9fXHMoVzkezaI3gfHY95M25CebSBdiU5NhxdIKpeaiDbg18wehVEzVnEm
         dg23XhdcMo6aZj9/haJV+bMUwzCv7j75TWPhQjo5aKHKXzFICR4Cqm9aB+gBXw8+eM+Q
         3+IoKZo4Pq0jzzoKFOMQUIAOAAQWIoq4cNz3ckl7pboyuSU95bE7R103jk/UVN/iowHS
         vNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SLofSjcvLUVjCES26Q/bVcnwJv1WtsF2a49gpFE2WBY=;
        b=QWKHsoRORRobn6WMYoAtm+C8iEF07ToI0vpt0eZR+/L+yC/mtE0qqFpdi7TZUpF7aO
         Oeji9xhwfbMF/HSEwUlNLw8Mfp9tce9W30RQ8+KxZCxqu11tRyWsgg4PNvGNi8w3ePyt
         KSweCuHjv/S70Y/5STL5aLU8FFeCwHKMBgzflOd8nW6kQnRwwj/fV2eyyqnx3pij7ETj
         eIYHEIW15t1sl+P2rMHCARTdU82g05IU7VVY3wYCeYHLk/Nvi3PAbjznIZYJdTBR6AXV
         Zdxc7OnQY0aHy4b0j3GJPPvSI3wvX9P3tedWTfPXaAFVUxCDegRef0N0Q72Sl5iGAzoa
         nH1w==
X-Gm-Message-State: AE9vXwOrZKmRMiI3UCfodIClNF5yN2llcrfajT22TpGXBwD0Vn6j9fsOwhkVzJE91dmL6qqtMl4ITAb3j9aJnI1a
X-Received: by 10.194.164.102 with SMTP id yp6mr24811695wjb.50.1474310146832;
 Mon, 19 Sep 2016 11:35:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Mon, 19 Sep 2016 11:35:46 -0700 (PDT)
In-Reply-To: <xmqqoa3jeo1y.fsf@gitster.mtv.corp.google.com>
References: <CAKoko1pewoxD4=_9M45pchdDg03K8fc73raJOsf4A+=KKw_EMw@mail.gmail.com>
 <1474073981-96620-1-git-send-email-bmwill@google.com> <xmqqtwdfgpd0.fsf@gitster.mtv.corp.google.com>
 <CAKoko1r6cfv-2HVCJPgGbXyCVe-wdUBS+2nXtaTHO3jshVg8MA@mail.gmail.com>
 <xmqqvaxrg6zt.fsf@gitster.mtv.corp.google.com> <CAKoko1r_WATxJzxQrQW2VBkhuKquv=yQv6sB_eCMgH6qavS__Q@mail.gmail.com>
 <xmqq1t0fg417.fsf@gitster.mtv.corp.google.com> <CAKoko1oSvBF3=-hvSGVMQYpZkUvnwAEYg=U-g8927F6dt4Q8mA@mail.gmail.com>
 <xmqqshsveomv.fsf@gitster.mtv.corp.google.com> <CAKoko1rULusRdcw7_u0QRfn590uTAZyOTk4JS6b8oopaSDLNDQ@mail.gmail.com>
 <xmqqoa3jeo1y.fsf@gitster.mtv.corp.google.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Mon, 19 Sep 2016 11:35:46 -0700
Message-ID: <CAKoko1qrAuLhn6qQax-BSZFhEqbFdiBbVrip8TD3NVjD8Xzy0g@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add pathspec matching for submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I thought as much.  Thanks for the quick explanation :)

On Mon, Sep 19, 2016 at 11:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> side question if the answer is short:  Any reason as to why all of the
>> pathspec matching code lives inside of dir.c and not pathspec.c?
>
> Hysterical Raisins.
>
> A pathspec used to be just a "const char **" in simpler times, which
> was no more elaborate than "argv + i" (i.e. after parsing options
> and revisions out, the remainders are pathspec elements).  Major
> part of the matching was done inside dir.c and we haven't had chance
> to look at the larger picture to move the code around.
