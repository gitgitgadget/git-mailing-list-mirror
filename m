Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54D4E1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 18:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbeGIStB (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 14:49:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46031 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932607AbeGIStA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Jul 2018 14:49:00 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8027F21687;
        Mon,  9 Jul 2018 14:48:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 09 Jul 2018 14:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=living180.net;
         h=cc:content-transfer-encoding:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Z2bNWWDv8wmfsc9x+
        MUgAFR0gS8L9JjzBANCgwXVzMw=; b=XfuL4OJHry8AfF+1i2XQFCY59ta7fpWV7
        HuLzPVsXb86TrfgM/H4hyfdR/HL1pWiDbA/tn2oMf3aRuNOFkbLMos3u3DHIgLqH
        DNQj77rXH2Vh2KbeEaJoOQ3EffdzeLKCSCVcpv//uZG1W2Bm3v0uO66idJE24pFO
        XN7TRr2AAytaUr6H0KCJKw7DKIX4lfS6xwey0Np8RmGNpjs/I2tZHEQgGfr52sFn
        konXhk4zH6R14a4vrLMyija69DkawcuazTpChtiAQtB2WlURVEF0mI10+cLEhP29
        RNLeWpu4aPbtvUAkWCmgHskIo3dTX91f5tGV/JwNO/mr+MTqvj3mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Z2bNWW
        Dv8wmfsc9x+MUgAFR0gS8L9JjzBANCgwXVzMw=; b=m4h5IPhU1A8M/z6FoDYM3P
        8AjwdZAZqKESW+xJdkW53U2NKhScYOrXfve9ZObOF72EVGiNM3X1Q5d/7msv7QN7
        aIi6Q7IeFijANkwOxwa/goExzVj8U/yEkCaGk9MFFByek9sSTXb9odEcR8e8gTsw
        A13l2eXSrkAAqOgyycPIqlTjKdF5vLiVq2nXg9FcDliG9B3qAg1aH8C1MOM6170J
        YRtXwpW+x6LQ2eWbNKJmU9Kfe3G7PoXRhKF9whdzDH8/TVxukh2FYPeWmq1SHMJj
        GNMVJyEwNRfQ18Q77xBUhD4DqQrD2aGjs9qqgnK3m/lPtHNxGKK+8ixDb2hoAdAg
        ==
X-ME-Proxy: <xmx:G65DW8i9Ml3uaKpsn2LDsy2fcUH6s7-DgtGTFxWLkH8UTexRVpICGg>
    <xmx:G65DW1N0xd0vx_MY1hfFNbj280n4be1so-ZoxtyN1Kfa-BcRAI-3tw>
    <xmx:G65DW15i8zHC9_U7uDo7nJ4k6cFj3VOzaFrYwFqQDHloNbV8L5ay4w>
    <xmx:G65DW73TbwveOE4NPeytib1qnzAJW3EHwD6DygKZyWzjZdT5oE4Esw>
    <xmx:G65DW-bgrAy0wuJCgtkUdsHcmNGutPw4_oxk57ilySLjqpm3f3F_TQ>
    <xmx:G65DW2G6G_ON0DIoBwT_pl55oby8lrvghvRBZaixtRLrww4PTOo_Fg>
X-ME-Sender: <xms:G65DW7OfZL1r02QJxUND3Br93tWTUjjkCIKvayY0iopfjBVBUXENAg>
Received: from [0.0.0.0] (unknown [173.199.115.247])
        by mail.messagingengine.com (Postfix) with ESMTPA id B8C05E491A;
        Mon,  9 Jul 2018 14:48:57 -0400 (EDT)
Subject: Re: [PATCH 2/2] t3430: update to test with custom commentChar
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20180708184110.14792-1-dharding@living180.net>
 <20180708184110.14792-3-dharding@living180.net>
 <20180708210200.GA4573@genre.crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Daniel Harding <dharding@living180.net>
Message-ID: <1084a573-4ed5-5a8c-a159-7773f7465704@living180.net>
Date:   Mon, 9 Jul 2018 21:48:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180708210200.GA4573@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello brian,

On Mon, 09 Jul 2018 at 00:02:00 +0300, brian m. carlson wrote:
> On Sun, Jul 08, 2018 at 09:41:11PM +0300, Daniel Harding wrote:
>> Signed-off-by: Daniel Harding <dharding@living180.net>
> 
>> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
>> index 78f7c9958..ff474d033 100755
>> --- a/t/t3430-rebase-merges.sh
>> +++ b/t/t3430-rebase-merges.sh
>> @@ -56,12 +56,12 @@ test_expect_success 'create completely different structure' '
>>   	cat >script-from-scratch <<-\EOF &&
>>   	label onto
>>   
>> -	# onebranch
>> +	> onebranch
>>   	pick G
>>   	pick D
>>   	label onebranch
>>   
>> -	# second
>> +	> second
>>   	reset onto
>>   	pick B
>>   	label second
> 
> Should this affect the "# Merge the topic branch" line (and the "# C",
> "# E", and "# H" lines in the next test) that appears below this?  It
> would seem those would qualify as comments as well.

I intentionally did not change that behavior for two reasons:

a) from a Git perspective, comment characters are only effectual for 
comments if they are the first character in a line

and

b) there are places where a '#' character from the todo list is actually 
parsed and used e.g. [0] and [1].  I have not yet gotten to the point of 
grokking what is going on there, so I didn't want to risk breaking 
something I didn't understand.  Perhaps Johannes could shed some light 
on whether the cases you mentioned should be changed to use the 
configured commentChar or not.

[0] 
https://github.com/git/git/blob/53f9a3e157dbbc901a02ac2c73346d375e24978c/sequencer.c#L2869
[1] 
https://github.com/git/git/blob/53f9a3e157dbbc901a02ac2c73346d375e24978c/sequencer.c#L3797

Thanks,

Daniel Harding
