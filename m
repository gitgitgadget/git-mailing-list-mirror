Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4FE61F667
	for <e@80x24.org>; Thu, 17 Aug 2017 00:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbdHQANj (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 20:13:39 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33405 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdHQANi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 20:13:38 -0400
Received: by mail-qt0-f171.google.com with SMTP id a18so29947503qta.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 17:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y6mgbQtxITq7AaZfOgSx+wemw+xmustA1WPyvu5C0Wo=;
        b=NuNoKarZatpexjICOEDyg2KWsVgallmKmM+eGLSoByNnevoVosh7LD8rugfWtPynpn
         J/JSUuhbu5IrpeIHUX5pyN8GTHSdMGb5217XTFZ6MWT5rCfxyj2obW1jDcyST8M6He/9
         kA3xh/P5SF4R7/ikJJMd3vg3OqX2eL04xGsNunKJBVb0Qb+GzGMfreN4w2cx65rU9lWb
         tbmXlSgmgpYGtndpAkw6dQlD4xxCmF1ugIJatwJnXcbRQOnImqetFlYyt/Sjgpgby+Zd
         aA17zThg44nf6pHL1YZZQs1tkP027tNifVfYW4FAz0+RrI/VYTdjlHsgA+O1Y94K8rm+
         Kwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y6mgbQtxITq7AaZfOgSx+wemw+xmustA1WPyvu5C0Wo=;
        b=iul/eBkoQrJWTAZ1l3ytC1hyOoY0NEV3MzV36VCgwHfoeTSckqoWNK2zwtdwnaS3Tv
         cky0Ug+z2Uq6Zfy48thsDwgQyEQx2U8uKVoBzNloso+m5lDEQtbSbFrscLJP/HeckyUt
         uEErBoemW4+9YgRdP0t3hO2B2M6JuC8d6spctogRQePpA5nT77eOjlLL5JIGRx9PtTZM
         XKlFvZq8g6jV8NTV5lZMB1e0eF+qgXXaylwMbSK5jesf7n0e9JfaS1k92n//ESUtMKLw
         SyockzlANWz7D8TnZIgABiOuO3bgSoN9BtnGR1CDyWYuCXCN8WnwjIMqmHNJZdMVfIYN
         U+pw==
X-Gm-Message-State: AHYfb5haIv+PuYq/DRFMEcwwZ3aQy7yoGc+XELrbZGlhLiKeqPkU8VBO
        qMkxt0bawaJFvybY2KJTyv7UiEo1Sw==
X-Received: by 10.200.33.188 with SMTP id 57mr4890630qty.101.1502928817669;
 Wed, 16 Aug 2017 17:13:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.39.151 with HTTP; Wed, 16 Aug 2017 17:12:57 -0700 (PDT)
In-Reply-To: <CAOCG=_pKCXbsRtxNN3+qn+28i_1ZXZJ4Nyf2LLSF78irbyoqFA@mail.gmail.com>
References: <CAOCG=_p--J5PKGrQTdquMvcBNQs67MNaN3vM8Tbwn2nZNwVR+Q@mail.gmail.com>
 <20170815192543.GB3839@alpha.vpn.ikke.info> <CAOCG=_pKCXbsRtxNN3+qn+28i_1ZXZJ4Nyf2LLSF78irbyoqFA@mail.gmail.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Thu, 17 Aug 2017 10:12:57 +1000
Message-ID: <CAH5451==kzQxbmVmbVT5JeTDSJGY05B0hzFyvnBMndv-iGg7Xw@mail.gmail.com>
Subject: Re: git clean -fdx deletes tracked files
To:     Kim Birkelund <kim@birkelund.me>
Cc:     Kevin Daudt <me@ikke.info>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kim,

I have cc'd the git for windows mailing list, but doing a quick search
on the bug tracker shows this issue which looks related:
https://github.com/git-for-windows/git/issues/607

Hope that helps, seems like it may be an issue with how junctions on
windows are handled by git.

Regards,

Andrew Ardill


On 16 August 2017 at 16:47, Kim Birkelund <kim@birkelund.me> wrote:
> Apologies. I should obviously have mentioned which OSes the machines I
> tested on ran.
>
> One Windows 10 (fully updated) and one Windows Server 2016 (also
> updated). I've also seen it in a real repository on our build server
> which is Windows Server 2012 R2.
>
> After my first mail I updated git to latest and could still reproduce.
>
>
>
> On Aug 15, 2017 21:25, "Kevin Daudt" <me@ikke.info> wrote:
>
> On Tue, Aug 15, 2017 at 08:45:20PM +0200, Kim Birkelund wrote:
>> Hi
>>
>> I hope this is gonna sound as weird to you as it does to me.
>>
>> The link below is a zip of a small git repository that I can reproduce
>> the bug in on 2 machines.
>>
>> Repo: https://www.dropbox.com/s/fz4d0i5ko7s7ktr/test.zip?dl=0
>>
>> It contains 2 folders: helpers and b, each of which is an empty npm
>> module. b\package.json refers to the helpers module.
>>
>> The following reproduces the bug:
>>
>> 1) in terminal cd to the b folder
>> 2) run npm install
>> 3) run git reset HEAD --hard
>> 4) run git clean -fdx
>>
>> At this point both files in the helpers folder has been deleted and
>> running git status confirms this.
>>
>> Tool version:
>>
>> git --version => git version 2.10.2.windows.1
>> node -v => v6.11.2
>> npm -v => 5.3.0
>>
>>
>> I have no idea what is going. Very much hope you can explain :-)
>
> I cannot reproduce it on linux.
>
> git clean -fdx output:
>
>   Removing node_modules/
>   Removing package-lock.json
>
> These are all untracked, and nothing in the helpers dir is being
> removed.
