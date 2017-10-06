Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981311FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 12:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbdJFMdY (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 08:33:24 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:48238 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752106AbdJFMdX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 08:33:23 -0400
Received: by mail-io0-f181.google.com with SMTP id j17so856382iod.5
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 05:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fDezmPOHTp2EgIhTHJPpGgDCMeaAICrYnlmPf+zHWC8=;
        b=sWKWkKUhFFIo1h96HyZMqGF1WU0aHP5GAJP5YYUFu3MDAnolcoAoC7ubGVhRBxXNk0
         4BxjgljVFhmRXTW1gpcOmPv8NUnVNRZy9N8pWrkZuf6KGxi4V7BpeNEUKesDWub6utFH
         ARQNsnPViJfM8DyWThWqa5LGjgamVTJ3FQ791+25gw7R7NpDPGy/3ArK3n7hpiKPlu8l
         Fu/JQbAPtGL63ooHj6Avzw30kP1v8CLxtIYZ3ofIlj2WLx8mf07XF6wjdHSHrWaPXc73
         OznjzyZpwB5uhY97bE2TQdMmBMmm6/1JKWgHQ+yQ2mqv0Br+2e1XIdvHG1LKrp0oQIUr
         yugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fDezmPOHTp2EgIhTHJPpGgDCMeaAICrYnlmPf+zHWC8=;
        b=qPzcUimLLFD9d55CmXCQNyhMrx06CjAh1ozPXmZH1nAzpO1+H6wjujXlEWHovfwwmT
         zMvbx1LR2yUXn9/WE9PMC+wH+VvQT7Ixc9iUeX3Q5RXHhlIHQ7GAMdf0B2wEMz3hLysz
         ASm94uL7Eb2hojzRVgskhslwMIhrGkDUyECBSK51MoDKg0t9ydzQ/0KJVpfIdfTszKow
         3LcJIS0jrUc9/gcWMs5wfcWzgaKCQ2zbV9MwmVvjjftel4q3qNvw1/lc8DlbKloSfJM8
         N5eOhI43+lfLa/3qMCZOxwBZ8HL6Y2kVrhSFKiV10t4U1Kozk8d76ILuvzHRIgrAfAOI
         9ifw==
X-Gm-Message-State: AMCzsaUU3yC7AkscKMUz0cjPCBH1F1mpDvbkaLOI8eSPSfHh8ipzVx5R
        zSjVtO703IKF4liMbcwtDT2RYA4Aa/RYDtm27io=
X-Google-Smtp-Source: AOwi7QA1g0cTEMdlwbnftUN5Kja96OKS939g8buOBhSJV4tT4rCh7jrvPQLWWcaf/fbWIpKYWU8p12BuON4/SurVh2g=
X-Received: by 10.107.137.96 with SMTP id l93mr2142073iod.138.1507293202708;
 Fri, 06 Oct 2017 05:33:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.115.198 with HTTP; Fri, 6 Oct 2017 05:33:22 -0700 (PDT)
In-Reply-To: <748131b7-bddd-08c2-ff72-9fd1a63ef6a0@redhat.com>
References: <20171005132243.27058-1-pbonzini@redhat.com> <CAP8UFD1X-aRN5sAB5PQt04jL_92APK279bjNf=Zt_x8KOxyL+A@mail.gmail.com>
 <748131b7-bddd-08c2-ff72-9fd1a63ef6a0@redhat.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 6 Oct 2017 14:33:22 +0200
Message-ID: <CAP8UFD28vVx51xhDgQVesm356XAjfwb286baER-U6VOC+4NL4w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] interpret-trailers: introduce "move" action
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 6, 2017 at 12:40 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 06/10/2017 12:30, Christian Couder wrote:

>> Did you try using `--where end --if-exists replace --trailer "$sob"`?
>
> Yes, it's a different behavior; "--if-exists replace" matches on others'
> SoB as well, so it would eat the original author's SoB if I didn't have one.
>
> So "move" does get it wrong for
>
>     Signed-off-by: Me
>     Signed-off-by: Friend
>
> (Me gets moved last, which may not be what you want) but "replace" gets
> it wrong in the arguably more common case of
>
>     Signed-off-by: Friend
>
> which is damaged to just "Signed-off-by: Me".

Ok. I think you might want something called for example
"replaceIfIdenticalClose" where "IdenticalClose" means: "there is a
trailer with the same (<token>, <value>) pair above or below the line
where the replaced trailer will be put when ignoring trailers with a
different <token>".
