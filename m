Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2C601F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933608AbeBVSSm (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:18:42 -0500
Received: from mail-yb0-f178.google.com ([209.85.213.178]:40200 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933441AbeBVSSl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:18:41 -0500
Received: by mail-yb0-f178.google.com with SMTP id i15-v6so2049877ybg.7
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U1t9VGQTvzUsxuS/jvalg4IWo4FnhoO4exjPjOLgpHc=;
        b=rSjsr5PsKI3pB7gvHDBfc7LqIgNHaeQKHvE6MVx3b2v9yRNPFOolSU2Dq19cXk5emT
         IE2zsneco2ReSD3tQrtZvCgkcmNsJzbclkUtIEi444RYan0d42SuQRhCA8qTF5X+4LKd
         nW0MwHVVmRMgrziXMw9WQAozfAdovd8YCBLcmO9EMbB+k5b9I7kPHTwEPjYFU5SFGc0g
         nANIsTnvafmF5zp5ppQoc6x+WqzbOXrGmR0JhXY4jPr2uieUS5/iicIGrwU4FOLebQZv
         0w5voTswwHaLDDg62h8GddI042YSzrf8JijDSFOdFQrBYtX24tRLm8JA5h4Mc1AmuuwG
         mjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U1t9VGQTvzUsxuS/jvalg4IWo4FnhoO4exjPjOLgpHc=;
        b=lBeMghgsfqYfTrufM7ZmfzxuP+fAXY1M/6mG93jyfvZ+wdzRj0qIY+nGAzbkNarzm4
         7ICqHqwHReD61ehq84eWOQWCwTMgBm2/q8fdyA46q0t8qPe6jyFC4mVc8UwxIfrsk9GY
         D6jMI5FbtP7FUs4FzBlqbXFwnM66KALuQrwCA4rQixTaqUe1cPEbvJ3OdzKpXahf5Cjv
         LGX17p7FDfZQgzupNThe0MvgzbL+keT1zJGKD4u7Ef9XBLly6IaLj0Ry5bVMO7rEEnst
         F3t8z9HmTWm2+NR6Yor23qihHnZdN+CeF1CzUVPr495nyn9zwmFXzMQ1PtjK39/gSExt
         tagQ==
X-Gm-Message-State: APf1xPBpDd0sad7mRj1/rIaUWcBd+eF2MmD/K1EybFdvWDjrZKXGWpRm
        s0Usq3ljNZTwResRaC6jaauvE6RvYq5Xj13/gpoCuw==
X-Google-Smtp-Source: AH8x227UxmoMG9mySuhayc1XOmixKp+KDf/9sBRDFHA38VVklthXz0idi23b5WPuND/vbvJQdGAzu/ZKqbiZJz9zuJ0=
X-Received: by 2002:a25:f40e:: with SMTP id q14-v6mr4169263ybd.334.1519323520911;
 Thu, 22 Feb 2018 10:18:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Thu, 22 Feb 2018 10:18:40
 -0800 (PST)
In-Reply-To: <20180222052227.GA133592@aiede.svl.corp.google.com>
References: <CAPaSTm=Vhg+S0Cf7rkcvXKH1eaEbw5aGOfCmtU7K3D+1kc-pGg@mail.gmail.com>
 <20180222052227.GA133592@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Feb 2018 10:18:40 -0800
Message-ID: <CAGZ79kZBrG7uQ5KOrpdkkhzet7chJhxVsKjTnVMQTrSGFAMZhw@mail.gmail.com>
Subject: Re: Bug Report: git status triggers a file change event
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Raining Chain <rainingchain@gmail.com>, git <git@vger.kernel.org>,
        git-for-windows@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 9:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> +git-for-windows
> Hi,
>
> Raining Chain wrote:
>
>> On Windows 10, git version 2.16.2.windows.1, running the command
>>
>> git status
>>
>> will trigger a file change event to file C:\myPath\.git  "Attributes changed."
>>
>> This causes problems when using scripts that detect file changes such
>> as tsc -w (Typescript compiler) and using softwares that regularly
>> call git status such as VisualStudioCode.
>>
>> Thanks.

Does
https://github.com/git/git/commit/27344d6a6c8056664966e11acf674e5da6dd7ee3
help?

>
> Can you say more about how "tsc -w" reacts to the file change?  Is there
> a way to tell it to exclude particular files from the files it watches?
>
> Thanks,
> Jonathan
