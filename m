Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7314E20D11
	for <e@80x24.org>; Wed, 31 May 2017 20:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbdEaU17 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 16:27:59 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32878 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdEaU16 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 16:27:58 -0400
Received: by mail-pf0-f179.google.com with SMTP id e193so17094326pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eGihKzzRz/gkCDGWHVc0GBpyM8GVNxNqvhPalD98Oio=;
        b=XAf4Grj2LIf+1+gYhRawiEu4pFfEqf0LS0kVn16tRppENV5QPQGxyNUNTUC4oeo2yT
         kuD8REsEf/lm8NSJs7zT9eEQdBjXVmHgkWh4aO153ClYmdRJlwLYSk+D39k99Bhb0Y9Q
         B2q+NUieainD8+RIjeXpwYhFclQBXYaSJPnO/9NJPOlaZCroc6dj3am/rUxhDs+eBjZ7
         KR0S2gcprXWgrssCaOCWADV8kK4MPCzRQYSR+D9Gb12clQnh1WIBDIlCfLrT8HwlfO+s
         43JprReDFNZMQvCBtr87igs+MCApI3JRK4he70/ukI/3tx3uFtWjO7+t2wi46uBgyUf/
         V+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eGihKzzRz/gkCDGWHVc0GBpyM8GVNxNqvhPalD98Oio=;
        b=TeKlYu/MZQ71xK4/bfXysYB9B+2KSvqxLki2+rHiadcKwT7F/8HAuM+O/mKXtxdT4q
         eG+QlzYF8CnILzI4MHgWnIbTPHvntlZpyLSBL98I2QHir4nJWaWz+bmRLI56HYLUFZg4
         NbgMH4x0qf/+62akh0FwV8JWVyw1XWW3Y8jV4L8DUqg6riBYqZ9l1c/aWphKD+LDt3lH
         vwRfzU7dZVaU+OThLMZmHdjG8iUGE4S4AbG0lmKySd/eiddenvz+65S0HcVCMmxN+8Qj
         Ywx5cBkSu/qlKReID5KQANjWx3gwuikv4lApr+NZ1q1ryyIRmNwWoJhj1v3WrNnHD0PK
         LiNA==
X-Gm-Message-State: AODbwcAK/PLSmvBJyd1y1vw1ugsFrvp12+Mb3TR8YyP+ehFr8gf3Qyy+
        j2GjPCd9d715Hi3SA2X2nZOw0XN1ukPZvisUTQ==
X-Received: by 10.98.148.2 with SMTP id m2mr32398626pfe.194.1496262477619;
 Wed, 31 May 2017 13:27:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 31 May 2017 13:27:57 -0700 (PDT)
In-Reply-To: <SN2PR03MB23331225571F62753E88572CB7F10@SN2PR03MB2333.namprd03.prod.outlook.com>
References: <20170531150427.7820-1-kewillf@microsoft.com> <20170531150427.7820-3-kewillf@microsoft.com>
 <CAGZ79kYns3CWS5acxGRk67mqdfBvPC=hngnNyovrOkjRRwhRCA@mail.gmail.com> <SN2PR03MB23331225571F62753E88572CB7F10@SN2PR03MB2333.namprd03.prod.outlook.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 May 2017 13:27:57 -0700
Message-ID: <CAGZ79kbmd7D5btJO5BWgOnSNUf221tYSYEUkgM9axzRPx7RnAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rebase: turn on progress option by default for format-patch
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     Kevin Willford <kcwillford@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 12:46 PM, Kevin Willford <kewillf@microsoft.com> wr=
ote:

>
> I thought about that and certainly could do it but I have found it nice t=
o have the number of patches that are generated in the output even for a sm=
all number or commits.  For example when I run a `git rebase master` and ex=
pect there to be only 2 commits, the message "Generating patch: 100% (2/2),=
 done."  Gives me that good feeling that I did it right and didn't mess som=
ething up.  I'm good either way though.
>

Oh I see, that number matching makes sense.
Though by reading the code, I have the impression
that the final value would not change. So if it would take
a really long time for these 2 patches, you'd still get the
(2/2), to know it was 2 patches indeed.

When it goes quickly, I'd be more concerned about
screen real estate, driving off the recent history from
the screen.

Also we maybe want to have
 "Generating patches: 100% (2/2), done."
plural, as (when using the delay)
it is more likely to kick in for more than just one patch?

Sorry, if this comes across as bike shedding.
It's meant as food for thought. :)

Thanks,
Stefan
