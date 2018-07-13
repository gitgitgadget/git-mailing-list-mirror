Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD2B1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbeGMQ2f (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 12:28:35 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35157 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbeGMQ2f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 12:28:35 -0400
Received: by mail-vk0-f65.google.com with SMTP id o202-v6so18474775vko.2
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RpmO7Rde4yfeDLlQruifFuRum/uFCKcpTQhQdbmo81U=;
        b=U3O/hRlWbtNczGak0e7qj9r/CD8aMfcGFFoMcEaVIGRnJeDjUHtst8Fu4BcC/jC9D4
         rq0RnfspT45wxJaD9unqYjpsqMyjJSin8mGOHYcUvs9HFrfFxdGuVGJu01YSaC516GZa
         6wz6kWo3a/Wmar9A3NVehoixX11gHS6BvHktnkVH/jsB7NozDWMrCnswyM0d4PZzJ+A5
         s5BS+5iLrccIjrTNCDV27MvTyHpH3NGrjI0mHwVGoCsMBRuhei0Jw6fQXTWqYMdQYNLV
         DSkQ2HjQPz3GOGwqq5hGEfRTGHJeD9Sx/NMYMuBxveNEhSF3xNF15QaLVDrIf4eE/6fZ
         U95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RpmO7Rde4yfeDLlQruifFuRum/uFCKcpTQhQdbmo81U=;
        b=TyMrvybw4jhsWKiXiTXsrQwNxhIN+MJydlnwaCbiKURV2mn7NhJhMNq3mzBmDu9NQG
         8F1f9/4ToRAtHapns04QE5IQjF1F6SdNYQHZdg0A+1AcG1tvZYNAsRw8xAuaF+vZkEj8
         GCLnX297EifJqfBu7VMCddaL0xXBXCDD/YVLUaMuj2OQzvObyzbmKz+OllT+eGFahRbp
         /YST5BrwaHDaDB/ZZF0vcZL24cRmucsU+BYCshjQlKiCRAZIpvgcALJkxPnyByWk5AmI
         hmUwrguDsSOjY5Oys2UuUMCtdkpBiu0wDZrxOups5zF52K8dFCPcQCdf0wTm1jD9jkbI
         FUKw==
X-Gm-Message-State: AOUpUlGCGTokSCIiETTL8T0cymUhVy1Eg9g+M4ufhENycwQrWswEdb15
        JvVZ7WhOlKolvQml4h+2HNAZ7emXj8QZXXPivwc=
X-Google-Smtp-Source: AAOMgpdGF55XYs7RNVKWACHiOF3K+w9cpoBnCcGZ5fMhd4UUVFUwAY2UaLGK4Gj6pNsn5M0UfXjtQbsbL3KtcGaoRhg=
X-Received: by 2002:a1f:c884:: with SMTP id y126-v6mr4061660vkf.76.1531498397401;
 Fri, 13 Jul 2018 09:13:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 09:13:16
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1807121743040.75@tvgsbejvaqbjf.bet>
References: <20180607050615.19598-1-newren@gmail.com> <20180627074600.32149-1-newren@gmail.com>
 <nycvar.QRO.7.76.6.1807121743040.75@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Jul 2018 09:13:16 -0700
Message-ID: <CABPp-BHrjqHVpV3bwR+aa5Q4yvARMyna10TrXPXBuKpDQ0r_tQ@mail.gmail.com>
Subject: Re: [PATCH v2] git-rebase--merge: modernize "git-$cmd" to "git $cmd"
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Jul 12, 2018 at 8:49 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Elijah,
>
> On Wed, 27 Jun 2018, Elijah Newren wrote:
>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>>
>> Changes since v1:
>>   - Fixed up commit message (move below comment to below diffstat as
>>     originally intended)
>>
>> Long term I just want to make git-rebase--merge go away, so this patch
>> will eventually be obsoleted.  But since I'm waiting for multiple
>> topics to merge down before re-submitting that series, and since that
>> series has some open questions as well, I figure it's worth
>> (re-)submitting this simple fix in the mean time.
>
> I carry essentially the same patch in Git for Windows for a while now
> (more than a year, to be a little preciser):
>
> https://github.com/git-for-windows/git/commit/42c6f1c943a
>
> (but it seems that I either missed one when I wrote that commit, or I
> missed when it was introduced)

So...I helped you get your work upstream without knowing it?  :-)

> There are more dashed forms in Git's code base, still, see e.g.
>
> https://github.com/git-for-windows/git/commit/4b3fc41b117
> https://github.com/git-for-windows/git/commit/c47a29c373c
>
> I would *love* to see those go away.

Are there blockers or more known work needed to get these ready for
submission, or is it more a case of you just haven't had time to
submit upstream?

> FWIW I had originally also "undashed" the use of `git-receive-pack`, but
> that breaks things, as the dashed form was unfortunately baked into the
> protocol (which is of course a design mistake even if Linus still denies
> it).
>
> It would go a long way to help with platforms and packaging methods where
> hardlinks are simply inconvenient. Because we could then finally get rid
> of (almost) all those hardlinked builtins.

I thought they were symlinked rather than hardlinked, but yeah I've
always found them slightly annoying.
