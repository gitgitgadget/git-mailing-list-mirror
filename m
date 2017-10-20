Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F9E2202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 05:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750944AbdJTF1a (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 01:27:30 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:55764 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdJTF13 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 01:27:29 -0400
Received: by mail-qk0-f171.google.com with SMTP id x82so13073333qkb.12
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 22:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hknpB0rIgnqNQCp3R0RMplHNqrz33mzfev13c6eqtx4=;
        b=akCVE9uEfDYSMO+k4a+a845LlzGx+dgL3ad7CuA6hIW/ZLuhW1lFznrY7QbkcU5CFm
         dkQFF8cbZygsv14kFiwL13reFdcOQ2IeX0v3UY53Pu2esZ2KowKJiNEqEde3XoEU9QEb
         lKIeoyFkL/L9R9C8ff7WmsSq74M4+NTpx7qPLSEZpdzr52GYgJdVJfBId9l5k5LteDEc
         wupe1NolDtosCtY8OuiE/izRCsEwzD7YgWYqBvEGEPzIAkd0LBY67BIBo/ywj5JytFEb
         odVtY6mzr7y4CQbyckNqRhCs4rBL2gR3ntQL5sY5U8IIOaLKJvAd5skGt9lREv96EV5e
         GAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hknpB0rIgnqNQCp3R0RMplHNqrz33mzfev13c6eqtx4=;
        b=aUMAq1H0Pv9tJ7QmeTdt++HykGk6Sntx1uytnQLtMZQMxWGYsdWCOYNOGWm91Eav1S
         tgu7aFIrIg7hmtnf1CvPxHKOVt3SDMNmrqXuEGRvgszYNOuiVlfzo/sInl/wnScUdvW+
         tUnGGXV1dwmxxUbZ/oRT93Ih5dazG72NfxZdCUx4UR1z1KmJhga+5XrlJ9kSk+L1c52Y
         wWrxzOPN4OkIkxywFzZOQlFYs+TWSqGSZWlK8LEwBsBcbZfEOyFaK/Yzc0YUxDcE6KqW
         eljCFR75YVWCgpy6ymDlG3mTsI1eSH0vi6m7E/FyF60tlM0fuzwM3miOBxagXm2zB4ku
         LH2Q==
X-Gm-Message-State: AMCzsaUZFpSuve8QrLTbi3BJMRc8BpBPtPHZwFp2YG4UJfFbZw+bNEos
        dyw+MeL63YwcwY26np2frkg5tIovM+9BtjAcmwHjiA==
X-Google-Smtp-Source: ABhQp+SvPxzq1mJCroZz8wGEutwR2FCf5l6DIcrUqS03ZNp9qTr66kTkv98hDktVzPcCSPp5IOlE/ZimLo4IORBMbZ0=
X-Received: by 10.55.129.70 with SMTP id c67mr5506372qkd.230.1508477248908;
 Thu, 19 Oct 2017 22:27:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 22:27:28 -0700 (PDT)
In-Reply-To: <20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net>
References: <CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com>
 <20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 22:27:28 -0700
Message-ID: <CAGZ79kZc+O9gM97bVZETE3sgkmc-t78Nf_Hq6=K4Gf2yaE79zA@mail.gmail.com>
Subject: Re: "Cannot fetch git.git" (worktrees at fault? or origin/HEAD) ?
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 8:16 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 19, 2017 at 06:43:57PM -0700, Stefan Beller wrote:

>
> So that's the right immediate workaround (and hoping there was nothing
> valuable in that worktree!).

How would I know? ;)

Without the commit available I do not even know if the code there
is well reasoned about. (My commit messages usually tell my future
self how much thought I put into the code)

>
>> Any idea which direction we need to heading for a real fix?
>
> If my analysis above is correct, then it's already fixed. You just had
> leftover corruption.

Well fetching yesterday worked and the commit in question is from
8/23, the merge  8a044c7f1d56cef657be342e40de0795d688e882
occurred 9/18, so I suspect there is something else at play.
(I do not remember having a gc between yesterday and today.
Though maybe one in the background?)


I am curious how you can have a worktree owned by multiple
repositories [1] (?).

Thanks,
Stefan
