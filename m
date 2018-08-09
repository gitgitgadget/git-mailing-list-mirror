Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AFE81F46C
	for <e@80x24.org>; Thu,  9 Aug 2018 19:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeHIVxI (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 17:53:08 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36348 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeHIVxI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 17:53:08 -0400
Received: by mail-yw1-f67.google.com with SMTP id v197-v6so6119043ywg.3
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 12:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uf0+p3OSMGKuymsAxYKf5iS143r/na4BxeTxyGchx2A=;
        b=r3EIe9K2J5pzz5+nzbgstj3vdopPnWUSHnV331TrJIsN3CnPEn9c0WftigB8y3a+Tb
         yztaMj/c0EJ0xmllkXbrGp4HjvDUC6uw39/yJyUuWVKCiMaVJeRDlpB4RI6pLVwvuU3l
         d9D6vn8/de/KIbAUPnCBK3xsiyfbOauRz4PGFkHskE1CYl1C7rm/GGlKzo7H/7fh3kWF
         mxcAeaQueLWpMWKgpLu0NIdO777vArwiSOhWx8o9VkL0NccK6YVCfi9empsRTeDhsHRz
         SmZkN6fOl/QRpCXRLFist2C66VR1E2vnAVyXJJ+fcYil6dbask9PEhQ6YIR+TH5FMpOA
         +BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uf0+p3OSMGKuymsAxYKf5iS143r/na4BxeTxyGchx2A=;
        b=fLQXz0losaQcI1vsZgiktmdP009idvIRtTwBH4MFPE+9HQJUuYL0WWDa2EFGhfahhy
         ReRDc7pKhnCNJUotjCFtRs3fY5C2w2hzKNnRCvnLxnMo7mkSaJQhBJcHXoMa5d5TX+KW
         usmErAim02/htfOhgLc8tBjFfPhIf918El8ipYsS6Waa1ev9VbCSMU8zqVoyHB172P1W
         98dVIsFXAp3QN7mE0jcp0hqIkyBGypbqaIPEWa0ppJv7yX6owDPtOx/BetO+ApgnpWRd
         jSvEOE/CdktehMg1uBFKVow0CmZzSy0jCfSlY/LBP8dRQq381CBWXsjy9Rm1BfvZjnNS
         RncA==
X-Gm-Message-State: AOUpUlF6Xd9AOF4fZtFI2d8+suVMT/OEXEmVcSdoZD6eEch1Nt0KXof0
        qRC7h7OjC3UeSuo7t6sXIyYeFVGI+5XCn9R8BXfS+w==
X-Google-Smtp-Source: AA+uWPyXTOyiJ31OA+QcAZpWwEhCIlrpq5tH/vdwy1jJxNSvWXOuqVhhlruX3eGAtiPQIYUXLhzUhuq4+snjil8WTJQ=
X-Received: by 2002:a0d:c944:: with SMTP id l65-v6mr1907492ywd.414.1533842812558;
 Thu, 09 Aug 2018 12:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180724044051.GA208393@aiede.svl.corp.google.com>
 <20180806222551.132628-1-sbeller@google.com> <20180806231843.GA4117@aiede.svl.corp.google.com>
 <xmqq600mmaqn.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq600mmaqn.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Aug 2018 12:26:41 -0700
Message-ID: <CAGZ79kZR_gj00JORH3WB_T+_mgtQm5PGt6+DSMFUbJM+C4FxVw@mail.gmail.com>
Subject: Re: [PATCH] Documentation/diff-options: explain different diff algorithms
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 8:56 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> > Both don't seem quite right, since they have an extra space before the
> > period.  The git-diff(1) seems especially not quite right --- does it
> > intend to say something like "See the DIFF ALGORITHMS section for more
> > discussion"?
>
> Good suggestion and doing so would nicely allow side-stepping the
> space before the dot issue, i.e. "See the DIFF ALGO section (in
> git-diff(1)) for more discussion".   I like it.

Me, too.

> >> +`Histogram`
> >> +
> >> +This algorithm finds the longest common substring and recursively
> >> +diffs the content before and after the longest common substring.
>
> As a first-time reader, I felt that it is a bit uneven that there is
> no attribution for only this item, unlike the description for Myers
> and Patience.

Yeah. That is because I spent too much time thinking how this algo is
flawed (in its design as the comments in the initial commit in JGit
indicate that design error when reading closely) when I was trying to
understand it deeply.

Maybe I should emphasize the trade off for performance gain
more as Shawn really cared about performance. After all it offers
the best performance in *many* common cases, but has a
"long tail" of really unfortunate results, too.
