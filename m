Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63121F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 18:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbdIASPv (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 14:15:51 -0400
Received: from mout.web.de ([212.227.17.11]:52108 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752092AbdIASPu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 14:15:50 -0400
Received: from [192.168.178.36] ([91.20.50.165]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCIqT-1dejfw4C8X-0096A5; Fri, 01
 Sep 2017 20:15:42 +0200
Subject: Re: [PATCH] pull: honor submodule.recurse config option
To:     Stefan Beller <sbeller@google.com>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, magnus@homann.se
References: <eba8e727-25ef-b34b-cd2b-e92602709c9b@homann.se>
 <cc70ea38-9980-120f-afaa-af7a6e3a8c36@morey-chaisemartin.com>
 <CAGZ79kaxSARkh9+PrYB05+Ln=hngu-9_y+UYi=P+M0OzNdedNw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6edd3cff-e552-787e-9ca4-0d91df8e51e0@web.de>
Date:   Fri, 1 Sep 2017 20:15:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaxSARkh9+PrYB05+Ln=hngu-9_y+UYi=P+M0OzNdedNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:kL3MScn4WW1PATWrIXoTwji5JPrPGKMIoKFv5COAXV4KCzPcfuE
 MHZpArYV7lILu8aJzrLosxZlJRTBMR8JvOBIU4cYfjvgLCgAUcJQd6T/FmJBHPulyRqPMZs
 8ulS7uw+uvq2q5zZtQtm7PeA4Fw2+sh5bjmiz54cCma+OgIZSKHaQnkVPiiT3t8DpBMugCM
 UnzRySxui4Y/LRjSTd+8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ja6eTAklCCQ=:mZtWlptGlcALLwc+nR+JUt
 xIkllxd7ApFuu9DNQ4zFX0euVP1nLZTxlLQhLfjY93o2I9+5XCt2VTh9s0F1scDt9cOYPfVdz
 VpnucDvGoN6/C1ZAkWY3bLXXHpQkdHlltWiP1mN0rOeOBRmfSQ3fSFX4L64pZvBjqAFCsoOiK
 q2+ehKzJHKn8t7P+2BoFPJpPT2CfHabgefSBjsIqRGYTSamw7d4IG+sudAuUZDhjzBHIR3SRW
 8pghJ1T4TfZnyIxjfsGJXe618rVik3Nej41FTM1CDdsfvm7nQMHFNd1BWsfWNnMALvilb85EW
 FniH7970CR4S9Pa8aKNq2dPjYeNOFjUBsAgF2g4p70ZU45tC6AMr5QE0Z7WcjN/zXUAJDUoQJ
 UVyaRMaWpb+wDjRwi9kKImJc9zOUnnU+4j5laVZiVb34unKEq4936vuXV85Id/PK+z6/qfW8o
 NPVJGVlhUdWeNDackdnZpv+o3nHIJ1sjm4QKASpxJYNlgAnasdD8LtWIK7ZtuE8wzMgJ6+rW/
 5ImgrKaFifD8giXUai4UsYuaeYeKBk2bqEsB/hBZzJz7BLPkzqkbBQppxmmrkHoSwc5ddhZnm
 Lw30lleaJLic4P8YdoTyxOIKt6+RMetDHgfB/DkdnmzqjUnbgCxdbPnx6HwYymI0OhwgUCZSQ
 ao8brUvIiwnMAxMbGMEDK9Hq0pdesPcxkkgJTq1HjmJYY9GqqK4CMC+ZhzH7kPEpY0OpSdPB5
 bnmiP+fEQa67LZZYKeRD7IohNJqqexNbzHWZqGUDnc19K7WYbskYMD9we7h9gFsQjNKVKYQT3
 N46chzZgIgGomCWxIRZriyeQhYG8i9CbjXtfb0e9Cbh3/3ZbGs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.09.2017 um 19:11 schrieb Stefan Beller:
> On Fri, Sep 1, 2017 at 12:29 AM, Nicolas Morey-Chaisemartin
> <nicolas@morey-chaisemartin.com> wrote:
>> git pull used to not parse the submodule.recurse config option and simply
>> consider the --recurse-submodules CLI option.
>> When using the config option, submodules would only be fetched recursively
>> while the CLi option would tigger both fetch and update/merge.
>>
>> Reported-by: Magnus Homann <magnus@homann.se>
>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> 
> Reviewed-by: Stefan Beller <sbeller@google.com>
> 
> Thanks,
> Stefan
> 
> 
>> ---
>>   builtin/pull.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/builtin/pull.c b/builtin/pull.c
>> index 7fe281414..e4edf23c5 100644
>> --- a/builtin/pull.c
>> +++ b/builtin/pull.c
>> @@ -326,6 +326,11 @@ static int git_pull_config(const char *var, const char *value, void *cb)
>>                  config_autostash = git_config_bool(var, value);
>>                  return 0;
>>          }
>> +       if (!strcmp(var, "submodule.recurse")) {
>> +               int r = git_config_bool(var, value) ?
>> +                       RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;>> +               recurse_submodules = r;

A few nits to pick:

Why not assign directly to recurse_submodules?  The variable r is only
set once and read once, and doesn't have a particularly descriptive name
that would justify having it.

builtin/fetch.c::git_fetch_config(), builtin/push.c::git_push_config()
and submodule.c::git_default_submodule_config() do the same, and I can't
infer why for them either.

And why fall through to git_default_config() here even though we know
that it won't match "submodule.recurse" again?  Config functions are
usually exit early on finding a match, as the "rebase.autostash" handler
above does.

>> +       }
>>          return git_default_config(var, value, cb);
>>   }
>>
>> --
>> 2.14.1.460.g196d2604f
>>
