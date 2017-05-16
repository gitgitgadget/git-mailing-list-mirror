Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B40D81FAA8
	for <e@80x24.org>; Tue, 16 May 2017 13:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752912AbdEPNKJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 09:10:09 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:35133 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbdEPNKI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 09:10:08 -0400
Received: by mail-yb0-f176.google.com with SMTP id p143so35091455yba.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iC8RmQzexZsW4hIEHsKEN2dtPsRY43QN/6qWklXQPs0=;
        b=q/Ya2/9Q/ROvniq6m+fFP3oD3L6FZS3HeCEAthVwkHggwnpLURO6Q0gJizK7smuP+I
         KafqzH5FrFzgyJV7YvnqyoX4v4Aq2k50r4ehawfDXAuEF/oYuE8O/7+TJ3EQ6PvujT4h
         ChjSpxvVgmi6+qpFH8W8jOwvtCzf801sk0gP/Tx+lzqO45DKXh09gTk9lwaIWrGaCpYz
         gt5QeWlnCbCuv5q3BwblyhiHdXv1CfdHurM9F+XguPobMI0+9ahOPa0CETmzZg2GvdBp
         PIDl0EgwAoR2iNfLhvSdnmuNdZ4vqzw8TEmam/5URgfBnEci125YA3WbRkB7ZKPRE65a
         2cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iC8RmQzexZsW4hIEHsKEN2dtPsRY43QN/6qWklXQPs0=;
        b=U/uVkYeDZeeQZ9U71ziiiFQPIzr4blrGUaQHbF+hBaWoSH/aPJLlyjejLB0/woA4RG
         aNulLGkAEUlaKYjjmpp9tRr7Aff/34Rdi3qxbf3+WSxJBOLN1JUTR3tAzouUJHZmc+1l
         ThicLrXlv1NHeP8YSIOZLUDG+UQmnnn0/GGlWY1E9/QTKuGoCdAbMxrm39Re98o1T/tJ
         pife5ijlEv4kfal66FycEG8jIrC/275VyaddhHZGcxqtlZdOtpuYIuveSLpAm7+zanfl
         KAdrStcpeI1DZRswgLTINzUPymIgQsfuMB+LBUd+6Z+uYBGWF30akaTdH3bcqfersBVH
         NM9A==
X-Gm-Message-State: AODbwcA1PoFplgzst1z0z4pQUboBVoPEt1nmZKQ0ljEPFiiKeStA1S9O
        ktAj+pKQAM+KGe4kJ7A/4KAWyiACJQ==
X-Received: by 10.37.161.104 with SMTP id z95mr9098973ybh.111.1494940207319;
 Tue, 16 May 2017 06:10:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.161.228 with HTTP; Tue, 16 May 2017 06:09:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705041324030.4905@virtualbox>
References: <CA+dhYEX+GgEHnVBnLQqnNW99xpf9kWcataTTt3Ya6ivGFgscMw@mail.gmail.com>
 <alpine.DEB.2.20.1705031147040.3480@virtualbox> <CA+dhYEUCJghqDQyBrL71Q=JKokcH-nhQ9WZzBb19-gonxi7o=Q@mail.gmail.com>
 <alpine.DEB.2.20.1705031630540.3480@virtualbox> <20170504094719.GA3238@dinwoodie.org>
 <CA+dhYEX0f206pZ+7seOce7McnfZ9ZfXLvSn7YH3Ykgqk+gA8gg@mail.gmail.com> <alpine.DEB.2.21.1.1705041324030.4905@virtualbox>
From:   ankostis <ankostis@gmail.com>
Date:   Tue, 16 May 2017 15:09:36 +0200
Message-ID: <CA+dhYEVW1ozj17DT0Asz4iuLXQpCpEckOOqVBe2baLhmzmEopA@mail.gmail.com>
Subject: Re: CYGWIN git cannot install python packages with pip
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        cygwin@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4 May 2017 at 13:26, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 4 May 2017, ankostis wrote:
>
>> On 4 May 2017 at 11:47, Adam Dinwoodie <adam@dinwoodie.org> wrote:
>> Judging from the error-message, it somehow concatenates input & output
>> paths.
>> Isn't this something to research about?
>
> It is something to research about. But by you, not by me.

You got a point there.

> I need to focus
> on bigger-impact issues, because I do not scale, and Git for Windows'
> users generally do not experience the problem you described.

Git for Windows uses MINGW indeed.
But there are still CYGWIN users out in the wild
running the vanilla Windows python installation.

Actually this issue has a big impact on those of us because
recent `setuptools` tools allow for packages to specify project dependencies
using the `git+https://...` url-scheme.
So the problem may appear to unaware users just trying to install
a packages the regular way, with `pip install foo.package`

Great thanks,
  Kostis

FYI, cross-posting also to CYGWIN list.
