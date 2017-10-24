Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1EF81FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 17:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbdJXRL3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 13:11:29 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:52996 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdJXRL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 13:11:26 -0400
Received: by mail-pg0-f65.google.com with SMTP id a192so15025282pge.9
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jaJfmbmlRguGmmlWtVEkUCO1iF+JjSy/+gr9PnALa00=;
        b=mXjVVbCD8STz1Kpj04eE1mde05wY5dHxGeGuJIXQMl8n3yVlhHrd8U2rTWwGXVKhPi
         TrsvjrMpPVBSSekLiJM+W9dPVGZK6HzIdBS1sGoQJh7Rh6rrVQt0PhQZsf5rG4wks0p6
         /Wul5JP17tR2JloBZAyXDoRrf+sCUlPRkMi7YzpbC4fGR0pDv8obXYJRXFBemX1MkJO2
         5I1Adki0Jkn+TA95QyeL7NpZp2u2gDlY1v948w0w3SR5eXEJEFxI4eqylNcyXJiEauAm
         JmejF9y0KU/V6gJQ/JCAaF/7FZvsvBig24G3Go0jskf5M9lFqtxhx4PXCZWedHvk6H+s
         ZF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jaJfmbmlRguGmmlWtVEkUCO1iF+JjSy/+gr9PnALa00=;
        b=ewHbyga74GQ+VhzvhstfpTZz72mixt13Jg+m5CiM+tC43pusCti6Z/OOwS6dy8DyNa
         CWVhOPc/Y5Au4eBHM2CPOrxfYegY57SDb+rxqLq7e6xx3RHno45r4cirsP8+3dWicCEz
         kWCV2F7/OyzgnHvQAhz6vsiVE/WHXukkAxBr1zT/fEMvbmvz9Qc2I6mQ60ImNdK7NsDc
         6ZvDbmFIgahQpiHpvpujf/uu7DB2J66rDtl2pJJLdvQCMan/sxNrYIEsBvcjapufQj/E
         DBVMD2ZPoqOKHQNO3/TuRdJ869beLJYc7Qwzga9bz7z12H5BmZfdYZUsa8d2dzQmKyTZ
         e6Eg==
X-Gm-Message-State: AMCzsaWi5Vo5GUpJ9OHcOvPO3S1D/x0HXWqg3srAFC00R2rPJsfhnk6s
        1J044vqsgg+7/NQTGQ+zQbDFWHY0jPGPkDz3BJs=
X-Google-Smtp-Source: ABhQp+T73E3mXHRU06nBqsXGxyg+Gvk3QZ7GdgHSlajvVVxDuMRDKRK4zAKi14gnTSWBTu6Edd4tFS9vdC2aMhbxLcA=
X-Received: by 10.84.233.66 with SMTP id k2mr13551173plt.45.1508865085080;
 Tue, 24 Oct 2017 10:11:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.177.141 with HTTP; Tue, 24 Oct 2017 10:11:24 -0700 (PDT)
In-Reply-To: <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
 <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com> <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
 <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 24 Oct 2017 19:11:24 +0200
Message-ID: <CAN0heSp7b_6n3y=s4++oWhkPUuM=s9L7LWVx5vn8o=5aH6DKKw@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Andrey Okoshkin <a.okoshkin@samsung.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        vmiklos@frugalware.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 October 2017 at 18:45, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Oct 24, 2017 at 12:28 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, Oct 24, 2017 at 8:27 AM, Andrey Okoshkin <a.okoshkin@samsung.com> wrote:
>>> Add check of 'GIT_MERGE_VERBOSITY' environment variable only once in
>>> init_merge_options().
>>> Consequential call of getenv() may return NULL pointer and strtol() crashes.
>>> However the stored pointer to the obtained getenv() result may be invalidated
>>> by some other getenv() call from another thread as getenv() is not thread-safe.

I'm having trouble wrapping my head around this. Under which
circumstances could the second call in the current code return NULL, but
the code after your patch behave in a well-defined (and correct) way?

> The distance between getenv() and the point where the value is
> actually used is a big concern due to not knowing what is or might be
> going on in called functions between the two points. According to [1],
> the value returned by getenv() could be invalidated by another call to
> getenv() (or setenv() or unsetenv() or putenv()), and we don't have
> guarantee that we're safe from such invalidation considering that this
> function calls out to others. For instance, after getenv() but before
> the value is used, init_merge_options() calls merge_recursive_config()
> which calls git_config() which calls git_xmerge_config(), and so on.
>
> For this reason, I have difficulty endorsing this change as-is.

Yeah. The call should be immediately before `merge_verbosity` is used.
Then, if a compiler wants to move the call, it has to do the work and
prove that it's ok.
