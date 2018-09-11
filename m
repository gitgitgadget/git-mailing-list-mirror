Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B92351F404
	for <e@80x24.org>; Tue, 11 Sep 2018 15:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeIKUis (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 16:38:48 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:33422 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKUis (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 16:38:48 -0400
Received: by mail-qk1-f171.google.com with SMTP id z78-v6so17035595qka.0
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 08:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=e1P+jU5SA3vQS7VZ4ttIguxZdtXodIchM94Kjzq9T1Y=;
        b=mzGnzVVtuZ/WHvdmjrI9llrtb7ZmINSZNmCyhW658Z4SGYyNMs5aWVWyOdPUUeY44w
         4RsdzBjoAWDFQJmVDkue2F2515Za0M7Ht+JgHQgh2tsA5Uz+lOZBwk+QkJweOKYm82kB
         mmRCqVSdD8pedezzIJCryICHkOvoWvZou5htyOORShKHeHDVKavuTfKtkKNn8zj8UY/G
         NbBxDmoVJ8H5+5kApj7OPghv5E1sNKnJl65j3gxJQB+GcxYONNi6qKV36NASDZu3d87X
         qv3qBJru1kEUmGL3lpElENCGi8Z9GTVX5h/B4p1WYH1iBVawqeNpRCdVKvtfHqaFo7nM
         nxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=e1P+jU5SA3vQS7VZ4ttIguxZdtXodIchM94Kjzq9T1Y=;
        b=e6cgtOaCyL0V4700oM4YV9BYJV+rcKjpi94CB7mnWiL5hMEXlLKUiSwNRntpS1iceZ
         Fppb2nINEmGP7gj2xPrTL3LAmkg9Te9bS7iVZb0EoJSP92S0zoEolvwSKooP66i9wqZY
         FaZZR5fyG4CVW5vfuEb83T4+I7w0oWy3ftgkijaLgLSmvxz+usCkkO3qY775m7uWcDg+
         pAeWHb/+Gg86WlFCeusdhpsl7l2YxPVnXDn8NIjsZcbkz3aWDIKRjz7miC/bg7YBbmGZ
         /zxkRsRmYda2L+/TK01u1XFS6AqVQTCml3TEgGAQM2eXs5S5cYx6tX1F+2tyB8DRoV7s
         Umkg==
X-Gm-Message-State: APzg51Bj5vIQM2v3ubM1VklbJ2m1sBHmB8OjZJk8VdZkA6loZ+72+yJF
        YwxZBS7bhyo2NqINI7Mj1eGzJVIo
X-Google-Smtp-Source: ANB0VdZ3zKubKqhZNt1slRdnyHEI4Fl9EXT91IC6JgVz+VD7AxxP5LcV5EPbP3J7OIX5Vujurptryw==
X-Received: by 2002:a37:c987:: with SMTP id m7-v6mr19942281qkl.324.1536680335780;
        Tue, 11 Sep 2018 08:38:55 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:ddb1:de2c:d0ab:264d? ([2001:4898:8010:1:9e47:de2c:d0ab:264d])
        by smtp.gmail.com with ESMTPSA id m9-v6sm12484265qta.55.2018.09.11.08.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 08:38:54 -0700 (PDT)
Subject: Re: Git 2.19 Segmentation fault 11 on macOS
To:     ryenus <ryenus@gmail.com>, Git mailing list <git@vger.kernel.org>
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com>
Date:   Tue, 11 Sep 2018 11:38:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2018 11:25 AM, ryenus wrote:
> I just updated to 2.19 via Homebrew, git range-diff seems cool, but I
> only got a Segmentation fault: 11
>
>      $ git version; git range-diff origin/master  HEAD@{2} HEAD
>      git version 2.19.0
>      Segmentation fault: 11
>
> Both origin/master and my local branch each got two new commits of their own,
> please correct me if this is not the expected way to use git range-diff.
>
> FYI, I've created a sample repo here:
> https://github.com/ryenus/range-diff-segfault/

Hi Ryenus,

Thanks for the report!

I ran something similar using Git for Windows 2.19.0-rc2. I had to run 
`git commit --amend --no-edit` on the tip commit to make my local master 
disagree with origin/master. I then ran the following:

$ git range-diff origin/master HEAD~1 HEAD
-:  ------- > 1:  5009c62 aaa

With this, the command succeeded for me. There is another way to get a 
similar result, could you try it?

$ git range-diff origin/master~1..origin/master HEAD~1..HEAD
1:  f14d571 = 1:  5009c62 aaa

Otherwise, we can now get started trying to repro this on a Mac. Thanks!

-Stolee
