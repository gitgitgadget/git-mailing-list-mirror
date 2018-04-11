Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 483931F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756119AbeDKUsM (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:48:12 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33303 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756024AbeDKUsK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:48:10 -0400
Received: by mail-qt0-f195.google.com with SMTP id p9so1291973qtn.0
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I9IDPGUps6oCyGevD/5HWGFv3zEtTCCcpjRcwT8FnDo=;
        b=nCsPN9GhM6AX4jxAkFeUMXBAQfE2FGbeX6FJN/qp/E+FIge6TWYFSGJckDnt7muoWI
         I9aQRAeei+tqKA1x+KQ7BYqlFNiGdTWulvkWNECcgCpgvUD1G17vbsEPH3kEU6HJAnWs
         rmsaZssnwaNEkm6+H/2dxFwtGoRBOaqMqEzVqOMs4FYgA/WYkv/kFmZ/hc7aOPegxxD9
         QfR5Mt74I7V0ihQ7FC13Nrffc9JwKxIf0cHeXP1SDHW16c5z3e+e0lQn2CMLe/LVAyp1
         NkGWfM9i8EhXZzRoDwsS1ttcvh8BX5R8uweEtXGdP3xtvwH8qEVV1I+MlZvcY/CjKGFc
         tMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I9IDPGUps6oCyGevD/5HWGFv3zEtTCCcpjRcwT8FnDo=;
        b=nGBwnO3SLjuzokj5j9fM/a8x7f2wblH+qe9296X+YzdPhGpDWMoV+I9BorA/JRwe+L
         WBe4qUUmJf2quIXmh597P4VhmE9kIFtI7mGM32XN9uwq1fSexJApa0bN0b/Ui973jVz/
         aPeCDBAqMKK1eeXXoOw+H9rfVausE+ZS3WjjtZ5+cc/k7BKck1AxgpsiJ8o6yWBfM1/I
         YqBpxC5roqd0K2IeB3mxi/o/I6E3Vb+iwMejlNbnJkHepOYWoJ3D3zvGoi3grZhp1MUW
         17hGHIwyJWGKEWurgW/pdgfw4CL0fKO7e/aOAl9QRu9QYkRio54Z1xjp0ad9VgXVNBQT
         B8fw==
X-Gm-Message-State: ALQs6tDtDfzrMhi/EclAtWCdZk329sNN64CRslNG4g54u+Z7itQX6v41
        SD5mXadcPaBw0T2LPmnrS9mQUe4HZBxrl++jL8E=
X-Google-Smtp-Source: AIpwx4+v0SVbOJy5FfX43Hfgt0456U/JgXtYDd5INY5Di3CMKephFYGb8SdbcTTjj8z2uz+4Gljfv93SSu+uAoWoOro=
X-Received: by 10.200.69.131 with SMTP id l3mr10066301qtn.50.1523479690029;
 Wed, 11 Apr 2018 13:48:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Wed, 11 Apr 2018 13:48:09 -0700 (PDT)
In-Reply-To: <20180411200955.GO2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com> <20180331151804.30380-1-t.gummerer@gmail.com>
 <CAPig+cQ8VzDycUMo-QOexNDBgQGEGj2BPmPa-Y0vhGCt_brbhg@mail.gmail.com>
 <20180409193007.GL2629@hank> <CAPig+cRXsir3siZ5eArk6k1mF9kaDfFe1mL+T9faR6dxSUez7w@mail.gmail.com>
 <20180411200955.GO2629@hank>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 11 Apr 2018 16:48:09 -0400
X-Google-Sender-Auth: 1TnelIwW7OoAo87uWkWKQj2-eQM
Message-ID: <CAPig+cTP6cJNmeXXbdRm3PTuq49+g9jNM-DvCJ472QrBC1CO4A@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] worktree: teach "add" to check out existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 4:09 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 04/09, Eric Sunshine wrote:
>> Another solution would be not to augment the "HEAD is now at..."
>> message at all. I realize that that augmentation was one of the
>> original motivations for this patch series, but with the upcoming
>> restoration of the "Preparing worktree" message:
>
> My original motivation of the series was to just make the new dwim
> work :)  Because that's adding some magic, the secondary motivation
> became improving the UI, to help users see which dwim was used.  I
> felt like this was going to be one of those improvements, especially
> after we get rid of the "Preparing ..." line.
>
> I do however like your suggestion of the "Preparing worktree (_branch
> disposition_)", as that doesn't add more lines to the output, while
> still giving a good indication of what exactly is happening.  At that
> point just showing "HEAD is now at ..." is fine by me, and doesn't
> require adding the hidden flag to 'git reset'.  So I'm happy just
> dropping the change in the message here, which will simplify things.

Nice. This sounds like a good plan for moving forward.
