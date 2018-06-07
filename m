Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A091F403
	for <e@80x24.org>; Thu,  7 Jun 2018 15:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935077AbeFGPJj (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 11:09:39 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35845 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934173AbeFGPJg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 11:09:36 -0400
Received: by mail-oi0-f66.google.com with SMTP id 14-v6so8940090oie.3
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iEpmWv/kLuVXIf1Ou+9bLwnQMHEn+ufdc7bPa+Sa80U=;
        b=YwVAZ9zckvyWCZ5WKJuQECkXh9/oTYKotefU3hV+w0mHKLJWe7Zhrplv5yCDKPBRvg
         LVvlHpNYijz5Jl5IawdjsUJLo0XNjXbYXkYgHH4nj0zet//ymbjI9ndRzfF9b/vmzGp7
         mRjGse+W7j2SUs/NeV8//UdHYLAFhrurx0kDaDIk0hfRvjwFqWuSheB121qGK8SlY7SZ
         w1n/RdhANYwJWafcfjYefIo22me0otyrlPJLZU5rHuXGapqREj6QMW7KNDVyOwkfDf/X
         9qS7YhSES2zTpAqKI4qIrbnbcYVJnYsg+9F8kY8neU/PqprK+pc+1moFBFQy6+eG9mKG
         l7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iEpmWv/kLuVXIf1Ou+9bLwnQMHEn+ufdc7bPa+Sa80U=;
        b=JPnEbdZ3xs3/mZoQlBNhQKbJaw1XI8+rFzh0RRIIc4b0usMeq2mFi3tfEvRlJT/vLj
         q0jNj9mCG0Vs7Rm/a5m6rn3f1u93vkIeCScJBLGIJ3IlgZhMQnVokuXH3lhY63XnNudU
         AH5XsRkIRA1TH283RvfOQMYUBcXorKemkZOiuNAip7wbIy+yXITHGS4ATohVngSm2kcg
         sPlIz8e/AlKqYKeK/xaWNLswunaqKQkrKkvz1dXFET/ADzGHeLrNvOEqkAX0axDK7IDR
         ZPUf/yyPNwt3f+zgXNS473JvvWQCUwnotAiwycvBs4O/qXf1005cpoEKHxIaTUEajWen
         dyww==
X-Gm-Message-State: APt69E0FMYE7mAkYTmah4rn8nyft/VKudw1vSu4+VLQmjlk19Kutyxom
        2X4zn4dhfsjYFEul+9tIE55tw+jKYev1M+OEp5Y=
X-Google-Smtp-Source: ADUXVKL6PZYRGLD/g1S4jl9YktjQ0hLPDgiVpPUeGZI2CjPWj3PkFUFtbt+NWpYsnZzk7Uvi7sVGLqsaSGWdbSFURWY=
X-Received: by 2002:aca:f594:: with SMTP id t142-v6mr1177243oih.56.1528384175853;
 Thu, 07 Jun 2018 08:09:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 08:09:05 -0700 (PDT)
In-Reply-To: <CAPig+cS1M3U0T7yd2hKv4Uv1NMub20bTy13-D-6drpJLJjNNAA@mail.gmail.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com>
 <CACsJy8D=6fAEpO5m4cc7KZyggAW1AosSkUWaunQBFH0nr-YrdA@mail.gmail.com> <CAPig+cS1M3U0T7yd2hKv4Uv1NMub20bTy13-D-6drpJLJjNNAA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Jun 2018 17:09:05 +0200
Message-ID: <CACsJy8D696DiWLGJgfqECBDJ9rMbpOy5bCe_knTttmR82QPCJA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] format-patch: automate cover letter range-diff
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

On Thu, Jun 7, 2018 at 10:34 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 6, 2018 at 3:16 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Wed, May 30, 2018 at 10:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> Dscho recently implemented a 'tbdiff' replacement as a Git builtin named
>>> git-branch-diff[1] which computes differences between two versions of a
>>> patch series. Such a diff can be a useful aid for reviewers when
>>> inserted into a cover letter. However, doing so requires manual
>>> generation (invoking git-branch-diff) and copy/pasting the result into
>>> the cover letter.
>>
>> Another option which I wanted to go is delegate part of cover letter
>> generation to a hook (or just a config key that contains a shell
>> command). This way it's easier to customize cover letters. We could
>> still have a good fallback that does shortlog, diffstat and tbdiff.
>
> It is common on this mailing list to turn down requests for new hooks
> when the requested functionality could just as easily be implemented
> via a wrapper script. So, my knee-jerk reaction is that a hook to
> customize the cover letter may be overkill when the same functionality
> could likely be implemented relatively easily by a shell script which
> invokes git-format-patch and customizes the cover letter
> after-the-fact. Same argument regarding a config key holding a shell
> command. But, perhaps there are cases which don't occur to me which
> could be helped by a config variable or such.

I think format-patch --cover-letter nowadays does more stuff that's
not so easy to simply rewrite it in a shell script. My original
problem with format-patch is it hard codes shortlog settings and you
can't list patches with patch number (e.g. "[1/2] foo bar"). The
simplest way is let format-patch does it stuff as usual and
"outsource" some cover letter's body generation to a script.

But it's ok. I could try to code the patch numbering thing in
format-patch and maybe submit a patch or two for that later.

> Of course, by the same reasoning, the --range-diff functionality
> implemented by this patch series, which is just a convenience, could
> be handled by a wrapper script, thus is not strictly needed. On the
> other hand, given that interdiffs and range-diffs are so regularly
> used in re-rolls on this list (and perhaps other mailing list-based
> projects) may be argument enough in favor of having such an option
> built into git-format-patch.
-- 
Duy
