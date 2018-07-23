Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4973A1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 16:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbeGWRep (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 13:34:45 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55364 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbeGWReo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 13:34:44 -0400
Received: by mail-it0-f67.google.com with SMTP id 16-v6so2420953itl.5
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3hwTIu3ZWgfzECC7+hTKa7J41mpD+xRgFuM6dIlmuo=;
        b=J5IF4weKozT0NO/zECqITVWdF2EITdPyxlRHFYC+Iq6NaN1jn+tnmhwL/j+A1DA++A
         jqMWu5drOR9rTJnDZwAu3p8TOiFVa6OAOKSjSQ80ws15IZm+YMmkdsemm7cr7B9gwtA6
         aOqq8553VyEbbEgcWI9cDXeDMfjAv3W6S/cMjKUC2GyGgy1kXvSRTB8G/2fJEBREFqGq
         gQeMWsDLZUIiy9WUcEbi/OKZAvUcfDiNS8gatE9qSZTEhJXJmPunPV79FuSvsbp4lwcR
         cb9i33XWQtAQE9l62OdnlUwKHGV+aiEkKxLmBtOWvD8ozMZnczMfGyZv2PkWyvyIUOr6
         5qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3hwTIu3ZWgfzECC7+hTKa7J41mpD+xRgFuM6dIlmuo=;
        b=n5+CL4Vz/OoF5ukK3Yyk4arDPVlr81VL2RUTM4LzdgzVIKreVjGRu3n/qpmcnsrPB5
         uEXu1Nts/wRD90AHWVFTxEG1RtIAiMcWz0pqbwjsKzDkOHEeVuGNWDtxVCSwNCqUe3Xy
         /HGStJO9lTVkPMOgTHBvlD89DB/gJ8CNNNK1VCMkQiITp2ElJKvG86tZTc/SCUQaE5+S
         v3f2YZZoB4HEVLrV0yv1cl9/w99pCut6BENDukNYtZKaR8ttiHYM0Wkdh4gSX0JM9fmg
         ilp1dSJBVdZqToHSExIK6UFz7c8TBp5wR5dNw6RsuJTYwGJfK4+wSv8Fykzh9Ekt1Gc5
         yXtw==
X-Gm-Message-State: AOUpUlHDJW7HHS+e1n7LlaehhYbVh2aaDI1mYZyHMSVY90vv5JyCjey7
        4DSGf/JOJbxYnqUPJmUarzscMaynxX8P74yhEJhVLA==
X-Google-Smtp-Source: AAOMgpfqJlBlxvOBjhfGP9pZwzJkHxlMuzrk8NAq6fWwsWqV58k3iqNKj51+V9FqWp+fkNzVHcG38ecSMKGCgQBCjgU=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr11006440itc.68.1532363563881;
 Mon, 23 Jul 2018 09:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com>
In-Reply-To: <20180722095717.17912-1-sunshine@sunshineco.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 23 Jul 2018 18:32:18 +0200
Message-ID: <CACsJy8BgAMYykkNOJc5NgMj-X6SMyskU3iCzTKnL0CLRTdF2oA@mail.gmail.com>
Subject: Re: [PATCH 00/14] format-patch: add --interdiff and --range-diff options
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 11:57 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> When re-submitting a patch series, it is often helpful (for reviewers)
> to include an interdiff or range-diff against the previous version.
> Doing so requires manually running git-diff or git-range-diff and
> copy/pasting the result into the cover letter of the new version.
>
> This series automates the process by introducing git-format-patch
> options --interdiff and --range-diff which insert such a diff into the
> cover-letter or into the commentary section of the lone patch of a
> 1-patch series. In the latter case, the interdiff or range-diff is
> indented to avoid confusing git-am and human readers.

I gave up after 10/14. But what I've seen is nice (yes I have a couple
comments here and there but you probably won't need to update
anything).
-- 
Duy
