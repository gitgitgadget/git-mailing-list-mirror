Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 282891F404
	for <e@80x24.org>; Thu, 19 Apr 2018 06:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeDSGHy (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 02:07:54 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:42376 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeDSGHx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 02:07:53 -0400
Received: by mail-wr0-f179.google.com with SMTP id s18-v6so10589518wrg.9
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 23:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AKaqto3C3/aWVsCCv7TRkfkIpDCxGOBvwjsozIGOk3k=;
        b=oF3Tzjw+0xvTaoVXtZQYKhtKKM3eHcofaY3hoHRzoGUlsTZKJ1gxznYy+yaffrswPm
         P/nDldGF7/kdN7cHKAyrafJMfU4I/czb1nppWGzsaFn/1/gIXno79stSgspYnpBndxqP
         Q/M+rXDD/EuYNO09mG4/WFsHlV9sAjonhwQ8WAktaot6SiKinyGmoZgwwRn3mgMluv5X
         mxdy1g0etEElw8tMilQXXWxyPx4B+vayOqMTKTnqY2A4+IOUINnJ+VHBliEMnhJge67z
         afn7cfmRIzSCosUvy3tMZ3IcLH8nDTfbAGVFBNSDy6pCrNQ8wuan/08lf6pOpcfiO9Au
         MDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AKaqto3C3/aWVsCCv7TRkfkIpDCxGOBvwjsozIGOk3k=;
        b=cXSRRKupOOw6/GRLuNUvXkVpL7M9x6ps6LwpXHJHCnwaxfFfrS4My28jkGoeA3lQfZ
         VF8iR5/XgdhG9625QlxmIYmS0ZGswD2D4u7M59CwtYHPFf+dO2AuCGMv8ahybBuv/gQ+
         CO+FaiYKqd9NnLC2lrRDsZeIYF9atpLOIczG0JPXqqdKlsBXd/irhDBq1R3YKAISfDVm
         a/5sLAsdF53BC1VPO20AGrGrac0JjxrtSrvm26Ny6YPV/GTr0Mmt2nC86FhebAQIclzL
         7IJOmcy8q5DnE6XgrM9sjZowlcjUxDDoMxr9exCxmGMnl6ov12Ds7wdVhSqEgnAUco9X
         CPag==
X-Gm-Message-State: ALQs6tCv7QZnGk2+e9tmKb2aj2eJGTwpyPvpHjSTbdd1Fjl0FFAEUBAC
        zzFVW0pkOEl1aBuzjGMYbgInLRZfTxETGLF2xBc=
X-Google-Smtp-Source: AIpwx4/vDcAIIDwUoprLKXf32kIHx+eKSTSnjBi70k+O6KuroHj9yFjSjzhHtJr/dfV16HZcqTv+BccGWoq5RzrKMCU=
X-Received: by 10.28.67.2 with SMTP id q2mr3288810wma.15.1524118072003; Wed,
 18 Apr 2018 23:07:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.146.194 with HTTP; Wed, 18 Apr 2018 23:07:51 -0700 (PDT)
In-Reply-To: <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com>
References: <CAK0XTWdpKnMbXs5sq2qsERxQO20sQW6YwL=2kfBHmSwHMmunBg@mail.gmail.com>
 <20180403222053.23132-1-eddy.petrisor@codeaurora.org> <20180403222053.23132-2-eddy.petrisor@codeaurora.org>
 <CAK0XTWf=ubDK-4=FknLSFObZrShg=7UDgR5c6iNSjrwiDngayA@mail.gmail.com>
 <CAGZ79kYu-9vzee=R7uE4fhhrRj19ZT0Z5+7fPLwOpXhEr7aqUw@mail.gmail.com>
 <CAK0XTWdSQmfqo2-WuiPtOcn_4cf60jNZ_j9Uh_HpzxUwSpA7bw@mail.gmail.com> <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com>
From:   =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>
Date:   Thu, 19 Apr 2018 09:07:51 +0300
Message-ID: <CAK0XTWecZASWULXYXGauV5WKhYinD7HXyXSTJntocQt3vzr4AA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] t7406: add test for non-default branch in submodule
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@codeaurora.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-04-05 0:41 GMT+03:00 Stefan Beller <sbeller@google.com>:
> On Wed, Apr 4, 2018 at 1:37 PM, Eddy Petri=C8=99or <eddy.petrisor@gmail.c=
om> wrote:
>
>>> you plan to later submit as one patch including both the change as well=
 as
>>> the test.
>>
>> Yes,

I did not forget about having a single patch. Will do it once the
details are ironed out.

>>>>> +       cd ../super5 &&
>>>>> +       echo super_with_2_chained_modules > super5 &&
>>>>> +       git add super5 &&
>>>>> +       test_tick &&
>>>>> +       git commit -m "commit on default branch in super5" &&
>>>>> +       git submodule add ../submodl1b1 submodl1b1 &&
>>>>> +       git config -f .gitmodules submodule."submodl1b1".branch b1 &&
>>>>> +       git add .gitmodules &&
>>>>> +       test_tick &&
>>>>> +       git commit -m "add l1 module with branch b1 in super5" &&
>>>
>>> now we do this again without the nested submodule, just one repo
>>> as a submodule?
>>
>> My intention was to have super5 -> submodl1b1@b1 -> submodl2b2@b2 on
>> the "server" side.
>> But are you saying I just implemented super5 -> sbmodl1b1@master due
>> to the previous master checkout in submodl1b1?
>
> No. I was a little confused about the code.

Actually you were 100% correct. In order to link to submodl1b1@b1 I
had to move the master branch checkout after the submobl2@b2 is added.

Otherwise the submodule is added with the last commit on master, not
the last one on b1 an b2, respectively.

I suspect that in the tests, because the "server side" repos are
local, the git fetch-by-sha1/cloning by hash will be done correctly,
without the need of a branch hint, but the problem will still exist
for servers such as github which do not support fetch-by-sha1.
In case I realize that a server-side repo that doesn't support
fetch-by-sha1 is needed, is there a mechanism to set that up in the
test case, or do I have to rethink my approach?

>>>>> +       git submodule init submodl1b1 &&
>>>>> +       git clone super5 super &&
>>>
>>> does super exist here already? (I did not check, but IIRC
>>> super and super{1-4} are there as we count upwards to
>>> find a name that is ok.
>>
>> I created it in the first step of the test with the intention to have
>> super5 as the "server" and "super" as the client clone.
>
> oh, ok.

After using test_pause I realized 'super' is left over by some other
test cases, so in my v4 (unjustifibly) long series I switch to using
super_w because I was getting all sorts of issues and wanted to not
interfere with the other tests.

>> As a general idea for a test, does it look sane?
>
> Yes, I think it is a sane approach. Thanks for writing such a test!

OK, thanks for the feedback.

>> Do you think I should I start with a just one level of submodule with
>> a non-default branch (super -> l1@b1), or it this OK?
>> In my view, having 2 levels makes sure the recursive part is also
>> addressed and verified.
>
> I totally agree.


--=20
Eddy Petri=C8=99or
