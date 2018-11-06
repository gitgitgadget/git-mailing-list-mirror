Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499891F453
	for <e@80x24.org>; Tue,  6 Nov 2018 22:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbeKGHbS (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 02:31:18 -0500
Received: from forward106p.mail.yandex.net ([77.88.28.109]:35448 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbeKGHbS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Nov 2018 02:31:18 -0500
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2018 02:31:16 EST
Received: from mxback14g.mail.yandex.net (mxback14g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:93])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 123002D866E5;
        Wed,  7 Nov 2018 00:56:40 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback14g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id YrDHIxkyB3-udK0UcdG;
        Wed, 07 Nov 2018 00:56:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
        t=1541541400; bh=lBNNFB4cBGJsGOQiKWmcneA6xoqoOd6xgyUT7kSK6wY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=q8r5x5dvG6h5BM/axxa7CIscX+nCCwCJwuNH+SytauWdMuQlYkPsfoVf3Oetg/UGR
         GhYCpVqt41Hntz65d9wrrwTTEtxGWUzvdSoWrN95HMSVvG+gaUWnfKL3roQTzDxIym
         fwDwwpMOEhvEIo6Ns6zs7zgilrTXL8D0+gt0Yw0c=
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id KQZ0gZYEOZ-udE0Oh7X;
        Wed, 07 Nov 2018 00:56:39 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
        t=1541541399; bh=lBNNFB4cBGJsGOQiKWmcneA6xoqoOd6xgyUT7kSK6wY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=tKGdPDmd+l3+JQDky0CdkPujYLE1iZzIOuqOI/qrpYtmJLvRNrOAFyAXheZQgk5IX
         5eOdrBaJ1D7dHHA/epc8OvLzcoeRYux4+7C2TsBSn6PIMS4sxavLwVXTKWG9izn+73
         gRN38RqOMWUHsmZUZtj0+9g+y1wUFkCfWD3Qt8x8=
Authentication-Results: smtp1j.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
Subject: Re: [PATCH] gitk: don't highlight submodule diff lines outside
 submodule diffs
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Paul Mackerras <paulus@ozlabs.org>
References: <20181106195417.5456-1-dpb@corrigendum.ru>
 <CAGZ79kZKN8U5+F+BAhQMkLuJVupgAvUgCaMt5-e_FDmY1RUY5g@mail.gmail.com>
From:   =?UTF-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
        <dpb@corrigendum.ru>
Message-ID: <fc89fa11-4809-9cb7-93d9-5e9d29c7b82b@corrigendum.ru>
Date:   Wed, 7 Nov 2018 00:56:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZKN8U5+F+BAhQMkLuJVupgAvUgCaMt5-e_FDmY1RUY5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

06.11.2018 23:06, Stefan Beller пишет:
> On Tue, Nov 6, 2018 at 12:03 PM Роман Донченко <dpb@corrigendum.ru> wrote:
>>
>> A line that starts with "  <" or "  >" is not necessarily a submodule
>> diff line. It might just be a context line in a normal diff, representing
>> a line starting with " <" or " >" respectively.
>>
>> Use the currdiffsubmod variable to track whether we are currently
>> inside a submodule diff and only highlight these lines if we are.
> 
> This explanation makes sense, some prior art is at
> https://public-inbox.org/git/20181021163401.4458-1-dummy@example.com/
> which was not taken AFAICT.

Didn't see that patch. That said, I think it's incorrect, since it never 
resets currdiffsubmod back to the empty string, so if a normal diff 
follows a submodule diff, the same issue will occur.

(The `set $currdiffsubmod ""` lines that are already there are 
effectively useless because they set the variable whose name is the 
contents of currdiffsubmod, rather than currdiffsubmod itself. I assume
it was a typo.)

-Roman

> 
> Thanks,
> Stefan
> 
>>
>> Signed-off-by: Роман Донченко <dpb@corrigendum.ru>
>> ---
>>   gitk | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/gitk b/gitk
>> index a14d7a1..6bb6dc6 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -8109,6 +8109,8 @@ proc parseblobdiffline {ids line} {
>>          }
>>          # start of a new file
>>          set diffinhdr 1
>> +       set currdiffsubmod ""
>> +
>>          $ctext insert end "\n"
>>          set curdiffstart [$ctext index "end - 1c"]
>>          lappend ctext_file_names ""
>> @@ -8191,12 +8193,10 @@ proc parseblobdiffline {ids line} {
>>          } else {
>>              $ctext insert end "$line\n" filesep
>>          }
>> -    } elseif {![string compare -length 3 "  >" $line]} {
>> -       set $currdiffsubmod ""
>> +    } elseif {$currdiffsubmod ne "" && ![string compare -length 3 "  >" $line]} {
>>          set line [encoding convertfrom $diffencoding $line]
>>          $ctext insert end "$line\n" dresult
>> -    } elseif {![string compare -length 3 "  <" $line]} {
>> -       set $currdiffsubmod ""
>> +    } elseif {$currdiffsubmod ne "" && ![string compare -length 3 "  <" $line]} {
>>          set line [encoding convertfrom $diffencoding $line]
>>          $ctext insert end "$line\n" d0
>>       } elseif {$diffinhdr} {
>> --
>> 2.19.1.windows.1
>>
