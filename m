Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCE0D1FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 19:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755344AbcLQTzh (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 14:55:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:63363 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752476AbcLQTzh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 14:55:37 -0500
Received: from [192.168.178.43] ([88.71.237.80]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNf1y-1cGfJm3b2Y-0079Tm; Sat, 17
 Dec 2016 20:55:32 +0100
Subject: Re: [PATCH v15 08/27] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ab6-bda8420e-9a63-47d7-9b99-47465b6333d9-000000@eu-west-1.amazonses.com>
 <a4c7fec8-0e84-eb53-ca22-c369ce3facfa@gmx.net>
 <CAFZEwPMwviof5jNvQnxFZYdw324XpbLSQ9mzEQjrCW-K4A+GCA@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <6a8aef40-9ae9-7e7a-12b1-b28039fc6554@gmx.net>
Date:   Sat, 17 Dec 2016 20:55:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <CAFZEwPMwviof5jNvQnxFZYdw324XpbLSQ9mzEQjrCW-K4A+GCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:gexBQOp/oclQwSFQtq26p2etWCDfRUQ3U56mA7EH5hDkucU++8q
 82yJNUanars/NEK6tfDMfz6TN9JPFsIbNaqV/tvbYLj5AIYLRehxzAcBX+9bai9yXvIxvZu
 qAxoOzTwC9SHMEkKinZRIWL97TmP5iLVqhUuCkzl10mNziW3MdqT9sOMVZGScafDtmyNox2
 mQWTVZE8SHHyVs4HPb8WQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QNhghArN4hY=:fORiyA5L27iNHkK77p/iLG
 E/5aDSgDvUlJgFsBvcSYcbLlr3uzHv6CQg4jHrP/sEzJRVRDTKs8IAgGIBsX1SDeJsD3aqS1v
 brL8R0dylPgEcQDwlyikfY/rQEovXvj6gApmQDROOEaQvGPtkhXagQ93ZL7mVmNzSSf2xphr2
 /eUdBSPo7dPwfj2rY7GHZ/YjVMC57SDAbjpd4Mnh9JRH48wabMITwoF8a31UozzEDR8t1yFCU
 oFWgA/msUqAiJBy6OPbDBPgMKpgxG6p/D0qjteKwpA8UYEd5i0+vsKqPQKOO3AXiPCsrJLIZp
 y6a1oF2dDkOeoieRAKd06h8GfD+ebl2bopyPisFpADdQZQIyqQG5c9qKVwLxQiDG4Dy666YY/
 M71VgxfXpgpwsjEYJrHNH8cZwCECLRCze91I7RKjLzOrjiQvP0eHIAnjEagrjJxzjVO89ZK16
 cXg2QeEBh0PSw+TtEjzbNSJQTPjJxiR5XKILyFtWqQpJuClGLlDf99VUQmrDI7NDXo/3nBTi4
 Mp9JKoDm5LyOGTyqHRNCdJoIS7xtLXx6V1qolDB5Blb19lta85EUW2IL8xnCdoOhd+8I9d7PB
 Lft7c2/86vtYtkOvfNRYxa+vKRlM4h0ot22DtxfNlXu6uf27cQ583GfZJcW6PX2LmyVlUHrE4
 /0ch/WkW6qu+pM5amGODBTrAlbh2SKC5Qb/SgdajNwIMTu6rCAH/vkO0rHHvkFEdRNtvCyp8A
 8k/YpW9J1x2ECl+H2ikiOP6hd1SCv/+pofVDEXvd3+FuPIM8WW+towul/G+d7FNMBB0EHprNt
 kKYkBtm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pranit,

On 12/16/2016 08:35 PM, Pranit Bauva wrote:
> On Thu, Nov 17, 2016 at 5:17 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
>> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>>> index d84ba86..c542e8b 100644
>>> --- a/builtin/bisect--helper.c
>>> +++ b/builtin/bisect--helper.c
>>> @@ -123,13 +123,40 @@ static int bisect_reset(const char *commit)
>>>       return bisect_clean_state();
>>>  }
>>>
>>> +static int is_expected_rev(const char *expected_hex)
>>> +{
>>> +     struct strbuf actual_hex = STRBUF_INIT;
>>> +     int res = 0;
>>> +     if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 40) {
>>> +             strbuf_trim(&actual_hex);
>>> +             res = !strcmp(actual_hex.buf, expected_hex);
>>> +     }
>>> +     strbuf_release(&actual_hex);
>>> +     return res;
>>> +}
>>
>> I am not sure it does what it should.
>>
>> I would expect the following behavior from this function:
>>  - file does not exist (or is "broken") => return 0
>>  - actual_hex != expected_hex => return 0
>>  - otherwise return 1
>>
>> If I am not wrong, the code does the following instead:
>>  - file does not exist (or is "broken") => return 0
>>  - actual_hex != expected_hex => return 1
>>  - otherwise => return 0
> 
> It seems that I didn't carefully see what the shell code is (or
> apparently did a mistake in understanding it ;)). I think the C
> version does exactly what the shell version does. Can you confirm it
> once again, please?

I check again...

The shell code does the following:
 - file does not exist or is not a regular file => return false
 - actual_hex != expected_hex => return false
 - otherwise => return true

(false means a value != 0, true means 0)

Your code does the following:
 - file cannot be read or is broken => return 0
 - actual_hex != expected_hex => return 0
 - otherwise => return 1

So you are very right, it seems I had a weird thinko (I probably missed
the "!" in front of strcmp or something) :)

Sorry for bothering,
  Stephan
