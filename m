Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 243091F424
	for <e@80x24.org>; Mon, 23 Apr 2018 17:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbeDWRvE (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 13:51:04 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:39474 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeDWRvB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 13:51:01 -0400
Received: by mail-ua0-f182.google.com with SMTP id g10so10768953ual.6
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gOE8z/AiRdEGgMR3zzizZLeUOIuOj3r5XQY0sHh8eGI=;
        b=dX6jwWz0sv4KQ3rG+pNEqPOk84gquhNcdV+yQLQW+B+439ymWG15q2l26RxmqGe6Xp
         Ujvo6YAg9Hqx5+n0hykk+ltBe+xqimgmFszX/ZOdBe3CSUfGYjnI2hYhlbXNmHygfz0V
         mWTUOp6I50y2N7WPP3JuXDFUdE0uh5j1eZve4SeJS6E7I4ISPOWSYtr/nuNCYvkrnL6U
         bAnol0emX4xfZOlPtn+btwPnIXN6wU9Mwc7VJd6NmjqVASKT+SPpXA9ciZkvhCGT0gld
         FBBSek5Ia9KY0jcCg9jMltHsEY8itxKKYaUwSHg1aBjk392NBtOxUHPxsHQFLGea65FU
         wPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gOE8z/AiRdEGgMR3zzizZLeUOIuOj3r5XQY0sHh8eGI=;
        b=Pzz0VCCB7h36KhZPpFXukI1yxdOcc62QBvoU0dSa02bxkb0F3nzD0qCwZYmW31qXVD
         qj0K0RwAAFK2c68Fgs+wWiDXRMF3AgS0XU0OqV7cZtATj96nMrKf5tAPwAUPT7B4TyPV
         j+yPcVU4NeEVGGh6KTMa6SQKT00ZHFTrWMwxjk7pk0uXekp4AtWfbsR7OZ8ygpDedvgS
         d0PYXRw2iWoH5AsVcyYvfpeTg8ajG9Nz3CBFXibCveo6v1C5V/EJghn3wIFAr6bXSeN5
         C3RlBoEjnJG7GAnFJJDzYZafkKn04VZV8QVbzKMrt9Y/sfNBHN9TrzRI/7qPoQME0bXy
         SRzg==
X-Gm-Message-State: ALQs6tBL7TL8VCxgU7bfdKNRDjXcmfV02g4dbjmdoWHdMyELQoagBE90
        8NtqRUFp618gFBOJkxe1Sym5IszX7BHq7qaCVJPTjQ==
X-Google-Smtp-Source: AB8JxZp9sLZ+JybENMJd4l2K80rPkKdkeMZ6o7D8HzHr4cANOWz0qC8sTyzp3FPKtf25F3f3Ls+yxlTucmuWhrQfxCM=
X-Received: by 10.176.10.26 with SMTP id q26mr1034732uah.23.1524505860738;
 Mon, 23 Apr 2018 10:51:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 23 Apr 2018 10:50:59 -0700 (PDT)
In-Reply-To: <xmqqy3hibms3.fsf@gitster-ct.c.googlers.com>
References: <20180419175823.7946-1-newren@gmail.com> <CABPp-BEhfMPNEtAvdc3MsX5mWsq=YT_=rVeOzCfidJde7Mhh-Q@mail.gmail.com>
 <xmqqy3hibms3.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Apr 2018 10:50:59 -0700
Message-ID: <CABPp-BHM1VcPZ_8gqdYrSHn8ybsQFvSF_=zesFT0PgoyYyZz5w@mail.gmail.com>
Subject: Re: [PATCH v10 00/36] Add directory rename detection to git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Apr 19, 2018 at 8:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Thu, Apr 19, 2018 at 10:57 AM, Elijah Newren <newren@gmail.com> wrote:
>>> This series is a reboot of the directory rename detection series that was
>>> merged to master and then reverted due to the final patch having a buggy
>>> can-skip-update check, as noted at
>>>   https://public-inbox.org/git/xmqqmuya43cs.fsf@gitster-ct.c.googlers.com/
>>> This series based on top of master.
>
> The series as-is is fine, I think, from the maintainer's point of
> view.  Thanks.

Sorry to be a pest, but now I'm unsure how I should handle the next
round.  I've got:
- two minor fixup commits that can be trivially squashed in (not yet
sent), affecting just the final few patches
- a "year" vs "years" typo in commit message of patch 32 (which is now
in pu as commit 3daa9b3eb6dd)
- an (independent-ish) unpack_trees fix (Message-ID:
20180421193736.12722-1-newren@gmail.com), possibly to be supplemented
by another fix/improvement suggested by Duy

Should I...
- send out a reroll of everything, and include the unpack_trees
fix(es) in the series?
- just resend patches 32-36 with the fixes, and renumber the patches
to include the unpack_trees stuff in the middle?
- just send the two fixup commits, ignore the minor typo, and keep the
unpack_trees fix(es) as a separate topic that we'll just want to
advance first?
- something else?

Thanks,
Elijah
