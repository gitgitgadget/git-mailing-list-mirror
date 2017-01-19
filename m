Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8A7320A17
	for <e@80x24.org>; Thu, 19 Jan 2017 22:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbdASWDv (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 17:03:51 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33387 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbdASWDt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 17:03:49 -0500
Received: by mail-io0-f173.google.com with SMTP id v96so49016690ioi.0
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 14:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ue7+QG43zIrHqF5mEd8vLr9ULcWZdEeFzlo8zbC7wmI=;
        b=QLnoIsnO1696YK6KyOCAeTvdhl1OM3zufDB9kFPUwkZJQynDUN4iyh+GGS/7q26fRI
         LKegW2A3tyzGqCHxkBJGfK4+0/gXwi52xI0sKFWa2ohW1jIJPEUNCKDuy47anmei7Zwv
         iaB49cCFspP/0Itfb4vSZ3T3y4vNx8QyYNSRXpXS2ixByPY8LsQzBkhM4VpoA77LB1O+
         nJ9u3s8cSXZ2d6D6mTw8zSmKI9GzoEovL2PtQ0kUvUilp7EkCjm4uy6FajWOGTlTKYtu
         IZxbE2/dEfe3+7+MOBRFZrNlDI/tNSHmY6/BKKS4Q93ZVu2kF0SoDbDV3XNtuHc0C+/h
         ekXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ue7+QG43zIrHqF5mEd8vLr9ULcWZdEeFzlo8zbC7wmI=;
        b=ES6Q83MQ2Qg7lIgu71sZ/GK58ImE/mha1CwAyUcrQB/ubTlw6BBWeqkc1v+RMGMorO
         oHTLI4YmiJUgJsFaeNOisjgljpMT+BSi6eRAbnxS1YrJfnI2TDsf7Ag5G3DiCCrvYihf
         UTtTblb10fknAv1bgOSTUu0LnzTeeBg84r53LKsUzDp4MQbtqqsF9QE/irn4kF2nUQbH
         UeKBnKAC11UmLk0ugthUEacMnIYJRf2lhqsDpZr20/AGD0sDtIaC1oUW/wMDefhR9FQ7
         cEnEzzx54F6Nba8iZxWaBR56YB28Pwo0UMaA2/p5PmAR4HJ3ea+rJORN+X/to+Fq3nLr
         U2Ow==
X-Gm-Message-State: AIkVDXJ8mYrHn3VnYv7UqAZe/60W59nP/w+Usz3Vv9z8zmT1P8EUTjyXqzVtbT9a502+HdwJ31HOtvkj0Mxvv+U9
X-Received: by 10.107.3.160 with SMTP id e32mr10562418ioi.52.1484863428351;
 Thu, 19 Jan 2017 14:03:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 19 Jan 2017 14:03:47 -0800 (PST)
In-Reply-To: <5207b04e-5e80-7100-4328-7e87ee619aea@synopsys.com>
References: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
 <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com> <CA+55aFxAe8bH2xXkx1p5gYN+nc-D-vjNnfUeA_64Q3ttpbHq+w@mail.gmail.com>
 <991ef396-3fc3-27d6-283c-b8dffa10a7b7@synopsys.com> <CA+55aFzGaxhRRHXUcfnUDcgyaAKy4jXLcKMXH8T61x8sxEJT+g@mail.gmail.com>
 <5207b04e-5e80-7100-4328-7e87ee619aea@synopsys.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Jan 2017 14:03:47 -0800
Message-ID: <CAGZ79kZ3g+J5=ZmP8zDCK8zBwMc7SwLdmgyB3Sab8qkTE=enhQ@mail.gmail.com>
Subject: Re: Git: new feature suggestion
To:     Joao Pinto <Joao.Pinto@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        Git Mailing List <git@vger.kernel.org>,
        "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 1:51 PM, Joao Pinto <Joao.Pinto@synopsys.com> wrote=
:
> =C3=80s 7:16 PM de 1/19/2017, Linus Torvalds escreveu:
>> On Thu, Jan 19, 2017 at 10:54 AM, Joao Pinto <Joao.Pinto@synopsys.com> w=
rote:
>>>
>>> I am currently facing some challenges in one of Linux subsystems where =
a rename
>>> of a set of folders and files would be the perfect scenario for future
>>> development, but the suggestion is not accepted, not because it's not c=
orrect,
>>> but because it makes the maintainer life harder in backporting bug fixe=
s and new
>>> features to older kernel versions and because it is not easy to follow =
the
>>> renamed file/folder history from the kernel.org history logs.
>>
>> Honestly, that's less of a git issue, and more of a "patch will not
>> apply across versions" issue.
>>
>> No amount of rename detection will ever fix that, simply because the
>> rename hadn't even _happened_ in the old versions that things get
>> backported to.
>>
>> ("git cherry-pick" can do a merge resolution and thus do "backwards"
>> renaming too, so tooling can definitely help, but it still ends up
>> meaning that even trivial patches are no longer the _same_ trivial
>> patch across versions).
>>
>> So renaming things increases maintainer workloads in those situations
>> regardless of any tooling issues.
>>
>> (You may also be referring to the mellanox mess, where this issue is
>> very much exacerbated by having different groups working on the same
>> thing, and maintainers having very much a "I will not take _anything_
>> from any of the groups that makes my life more complicated" model,
>> because those groups fucked up so much in the past).
>>
>> In other words, quite often issues are about workflows rather than
>> tools. The networking layer probably has more of this, because David
>> actually does the backports himself, so he _really_ doesn't want to
>> complicate things.
>
> I totally understand David' side! Synopsys is a well-known IP Vendor, and=
 for a
> long time its focus was the IP only. Knowadays the strategy has changed a=
nd
> Synopsys is very keen to help in Open Source, namelly Linux, developing t=
he
> drivers for new IP Cores and participating in the improvement of existing=
 ones.
> I am part of the team that has that job.
>
> In USB and PCI subystems developers created common Synopsys drivers (focu=
sed on
> the HW IP) and so today they are massively used by all the SoC that use S=
ynopsys
> IP.
>
> In the network subsystem, there are some drivers that target the same IP =
but
> were made by different companies. stmmac is an excelent driver for Synops=
ys MAC
> 10/100/1000/QOS IPs, but there was another driver made by AXIS driver tha=
t also
> targeted the QOS IP. We detected that issue and merged the AXIS specific =
driver
> ops to stmmac, and nowadays, AXIS uses stmmac. So less drivers to maintai=
n!
>
> The idea that was rejected consisted of renaming stmicro/stmmac to dwc/st=
mmac
> and to have dwc (designware controllers) as the official driver spot for
> Synopsys Ethernet IPs.
> There is another example of duplication, which is AMD' and Samsung' XGMAC
> driver, targeting the same Synopsys XGMAC IP.
>
> I am giving this examples because although the refactor adds work for
> backporting, it reduces the maintenance since we would have less duplicat=
ed
> drivers as we have today.

This sounds as if the code in question would only receive backports
for a specific
time (determined by HW lifecycle, maintenance life cycle and such).

So I wonder if this could be solved by not just renaming but
additionally adding a
symbolic link, such that the files in question seem to appear twice on
the file system.
Then backports ought to be applicable (hoping git-am doesn't choke on symli=
nks),
and after a while once the there no backports any more (due to life
cycle reasons),
remove the link?

This also sounds like a kind of problem, that others have run into before,
how did they solve it?

Thanks,
Stefan

>
> Thanks,
> Joao
>
>
>>                Linus
>>
>
