Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4749EC7619A
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 22:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDHWpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 18:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDHWpX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 18:45:23 -0400
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1228A43
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 15:45:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 41B333C09FA05;
        Sat,  8 Apr 2023 15:45:22 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bqtIu2mkYvMC; Sat,  8 Apr 2023 15:45:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 3060E3C09FA06;
        Sat,  8 Apr 2023 15:45:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 3060E3C09FA06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1680993921;
        bh=wfSiy/8QBl9l5t1AHfLCq1MtZCAo+ITeL91CiR2IfSI=;
        h=Message-ID:Date:MIME-Version:To:From;
        b=KEAt4wad8SgYYOCJHM5fxsHoUZJRX8HMQdovS7SeowO071mZ5rKSb3j5fisu7KfY0
         HKx539tdnVAGUS8PpHxS+2xvBneQjlFM/rpwCuaR+55NnBKyCw8oUhBxQCsjKbfDHL
         G+9b6XuJv5tqiMmX/cF+YUzD4/awMgdO2O86Tc9NvK7mflbXqj7ss0wwxcoV95KsDf
         kZS+LpBXDUe0Lp8qXMBfc895cHiAIu29FGcl1eAwt8CD5iS1gP3l5wC+LiLSEx8/IP
         BIDcWIPeIVj/TDsT6k3rHL5QlgWN+C6ZtajvPYgwZasLyKkwxLo5E4z32GBrVEEcE+
         ubVRY8Xvb/0yw==
X-Virus-Scanned: amavisd-new at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tok1hIEic2OY; Sat,  8 Apr 2023 15:45:21 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by mail.cs.ucla.edu (Postfix) with ESMTPSA id E68933C09FA05;
        Sat,  8 Apr 2023 15:45:20 -0700 (PDT)
Message-ID: <43d04851-2463-2922-44e3-075080129ec3@cs.ucla.edu>
Date:   Sat, 8 Apr 2023 15:45:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, pcre2-dev@googlegroups.com,
        60690@debbugs.gnu.org, mega lith01 <megalith01@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Tukusej=e2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        git@vger.kernel.org
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
 <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
 <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu>
 <xmqqttxvzbo8.fsf@gitster.g>
 <CANgJU+U+xXsh9psd0z5Xjr+Se5QgdKkjQ7LUQ-PdUULSN3n4+g@mail.gmail.com>
 <065bcdcb-5770-5384-5afe-4a4d29272274@cs.ucla.edu>
 <CAPUEspjtN-cwm=Nn=hMCcbOcOgPaVHsBfLW9TXn1HZrxtRR3BQ@mail.gmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: bug#60690: -P '\d' in GNU and git grep
In-Reply-To: <CAPUEspjtN-cwm=Nn=hMCcbOcOgPaVHsBfLW9TXn1HZrxtRR3BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-04-07 22:01, Carlo Arenas wrote:

> Not sure I follow the whole logic here, but PCRE2[3] (search for
> "general category" which is what the "gc" above stands for) only
> supports the abbreviated form of the unicode classes and `Nd` is
> indeed the one that corresponds to `Decimal_Number`.

That's fine: all that UTS#18[1] requires is that PCRE2 provide syntax 
for a regular expression that matches the Decimal Number class. Which 
PCRE2 does, via \p{Nd}.

The logic is that UTF#18 does not require that \d must behave like 
\p{Nd}, or even that \p{gc=Decimal_Number} must behave like \p{Nd}. It 
merely requires that there be some syntax for matching Decimal Number, 
and it says the choice of syntax is up to the implementer. This is why 
UTF#18 doesn't require that \d must also match non-ASCII digits (which 
is what I think Yves was saying).

[1]: https://unicode.org/reports/tr18/
