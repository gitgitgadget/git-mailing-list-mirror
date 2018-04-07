Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B081F424
	for <e@80x24.org>; Sat,  7 Apr 2018 08:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeDGI6l (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 04:58:41 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:34567 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeDGI6k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 04:58:40 -0400
Received: by mail-qt0-f175.google.com with SMTP id l18so3747655qtj.1
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 01:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=h9xxdaF/LYf/Loq9d5w+slIS2gk8Lg89Ud+EbaC7AOY=;
        b=YX9YI8/Egi9u1HSGNtwkV8HYcn7iHFbmtAf+Q7gEOoTE/QWO1telKnYbAme4OUEMpL
         fTfjqHCR1hrzU2mnTqhbdpuHAMpXmXqutATqli8qKPjLBSE62wpDBcjM1P29ZXnmOr02
         bAQES5VatUj6B7qZ9NXUebNPuWE2hoS7v6rgqrXAH/bYGypt2yPsDBZSApCEJ8FNEmqi
         p68wfy9kNbq7Tvw9lJ7UfUO5OKgaDii6o7sUe94g5xjtQMd4EZ9aAYJi1cS6GYUGYo8C
         6Mz55VJyaU8JyTVQ3AxO3uwL9RhJZH1o8Jb6fzmhLK5yagLX/f33CM4VCtrHoCihL+DS
         EwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=h9xxdaF/LYf/Loq9d5w+slIS2gk8Lg89Ud+EbaC7AOY=;
        b=U79Mn1Wdk5lH1tMCrerkntjWEV9t5/xBfYmMlkqWM6Se7/XkHdwXGKOCv/srVYaG7E
         fcH+9YA/CnLuw1aaRAompy8hKj8jRS+CjucOqlvv5nMGFlvXt2z8RiYI5LvLa133jyA+
         Xz605/WhdqU5Ll7MhzIQa0rt6yiyuG5DFON6X7QApRGK385GvXTwi4fN19x3VRnmtRgx
         u3jRo2ChVE6kefQO2UOsJklBR5AJX5j4wl+A0Gogm7N6kPOgQTZEx31Jx+Gb4KhD6w+z
         96upGt2e51qxxyTTOVebZ4fMYBfSsXt38VonvLdhXWiCnT5cxj1I5RAbT8n/I9BVNoZl
         HUVw==
X-Gm-Message-State: ALQs6tDPGaMTJUf5kS19KgB2ddCgYBYZ/wOTHTaqLPEELv1ZTFD7E/RS
        zNC3Aq/1IwhykVpPBLA+7yOC/WRDFHHwNyfuJ58=
X-Google-Smtp-Source: AIpwx4/+unI5MCf6/RBrSqqu36+6CPHmesFSZUPYO/JfHxdQIUXfKxxUEF7Y/zXHk2r8fLId7y85woXwegTOk/haTbI=
X-Received: by 10.200.42.37 with SMTP id k34mr43316891qtk.101.1523091520116;
 Sat, 07 Apr 2018 01:58:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 7 Apr 2018 01:58:39 -0700 (PDT)
In-Reply-To: <CAPig+cSMv0p6m1kjNN4bGN8prX-9Ri_XbVzHah=MugHmZh46+w@mail.gmail.com>
References: <20180324182313.13705-1-ungureanupaulsebastian@gmail.com>
 <CAPig+cS9QwCOG7BA7O5Nu_zsh-xTbDFy2vTWpAXxBuKTY-uzUw@mail.gmail.com>
 <63772b7d-7b1e-2a3a-b12c-2dae9e254b68@gmail.com> <CAPig+cSMv0p6m1kjNN4bGN8prX-9Ri_XbVzHah=MugHmZh46+w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 7 Apr 2018 04:58:39 -0400
X-Google-Sender-Auth: n3-4S3dJs1HoR7oaKrbgPCNb0LM
Message-ID: <CAPig+cRYeUxjVS-Wf-2L9da7TTNh9PAwbiEAEV0S3qSyR_8R1A@mail.gmail.com>
Subject: Re: [RFC][PATCH] git-stash: convert git stash list to C builtin
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 7, 2018 at 4:56 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> The existing git-stash requires a working directory:
>
> % git stash list
> fatal: not a git repository (or any of the parent directories): .git
> %

Correction on the error message:

% git stash list
fatal: git-stash cannot be used without a working tree.
%
