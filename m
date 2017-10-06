Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_BLACK
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BC241FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 16:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbdJFQ5E (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 12:57:04 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com ([77.238.178.147]:35351
        "EHLO sonic308-19.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751766AbdJFQ5D (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Oct 2017 12:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1507309022; bh=jCaKwAdUp2I4bayCl82BkKjeCPK5cEALj+EIuqsR+N0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=fozDPu/1QcjzeEwkX8FmSytUYIaafQz9pWrMCqqL3+IJHlQpgHJqcoB6u+XNtlLpR4rl2T4vIc/lJ9eCF7FXyGQZRjvxs1oESq12Dvgx+HDth+cKS/pHCqF+PB4Tw0HS0Ufs28/ixerrzHdrv0JFzvGixA/5K4iPvRcqt11NyROHMRVB2mWZdtelFn+pdyWGogNVE4R5ASybPzxXs7a5CAkJKEVLh0qz4yHA1bhXAycY2wInEe3mRghyK2DzujmNAV0X/0Gnhc6nScv8SQgFc3MpsFvpEkqpGJExcPXSV8whB3XToq3kTJhuCb3fLeJREsHEab5hXOdZNtrJHvFUSg==
X-YMail-OSG: ZVLTkoIVM1klZCQGNtBAUqjXPXYJ8G7ksjq3C3RfKsqdLD7GMgSWdjhJd3SUKga
 KHVQFJyPlk0xIzfFrFovhVfRosic6Z9q_lyz9inv7koyGpKi912xQ2bAzBuzYjTx8V4Ako4cmXYD
 SXqAqlu4J8iRFUk03QglwplEhujzR1lxZ4Wt9AelNPFymkqCopFwjnrA5Sx_tMg2ZsYteUnUrrMz
 xYA.2CptvLu_2JlnPI1niNui6klRjtZgMiZwphKxyvX9gYiF86YUtAg2EzkhhD_rudUJgBfIT6vk
 nuMq09d.YqJMrDlnJ2PVQP35G2Fb77KZjIRred0BaHwpmC1vuyvNo8Bmuxsuf65vOB9P0VSrD6DB
 LCXsS1I99sYt20l1TAiNKD.JkN7hRfFzpXqo.HzIJD8QaYeXQ0m9zl.VXbi7v.H1SeTEzvnri7mg
 7Sxu8PvipickMgcaN23ww9iA2JTnnzGHap.Ix8NscNGpX1pOTOFLWMAYZ.68.YONQ3auwzXrUZlx
 wUP21zqWD5e4aXm7ld5k_7bpbl0IUG9SXh5L6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Fri, 6 Oct 2017 16:57:02 +0000
Received: from [127.0.0.1] by smtp144.mail.ir2.yahoo.com with NNFMP; 06 Oct 2017 16:57:02 -0000
X-Yahoo-Newman-Id: 140822.55195.bm@smtp144.mail.ir2.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: ZVLTkoIVM1klZCQGNtBAUqjXPXYJ8G7ksjq3C3RfKsqdLD7
 GMgSWdjhJd3SUKgaKHVQFJyPlk0xIzfFrFovhVfRosic6Z9q_lyz9inv7koy
 GpKi912xQ2bAzBuzYjTx8V4Ako4cmXYDSXqAqlu4J8iRFUk03QglwplEhujz
 R1lxZ4Wt9AelNPFymkqCopFwjnrA5Sx_tMg2ZsYteUnUrrMzxYA.2CptvLu_
 2JlnPI1niNui6klRjtZgMiZwphKxyvX9gYiF86YUtAg2EzkhhD_rudUJgBfI
 T6vknuMq09d.YqJMrDlnJ2PVQP35G2Fb77KZjIRred0BaHwpmC1vuyvNo8Bm
 uxsuf65vOB9P0VSrD6DBLCXsS1I99sYt20l1TAiNKD.JkN7hRfFzpXqo.HzI
 JD8QaYeXQ0m9zl.VXbi7v.H1SeTEzvnri7mg7Sxu8PvipickMgcaN23ww9iA
 2JTnnzGHap.Ix8NscNGpX1pOTOFLWMAYZ.68.YONQ3auwzXrUZlxwUP21zqW
 D5e4aXm7ld5k_7bpbl0IUG9SXh5L6
X-Yahoo-SMTP: .w5QqJ6swBA_3w7N9yIVdzdJdKQq_njOOGspvdTCCa.iTA--
Subject: Re: Git config multiple values
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <4b848032-e8b6-be67-58d9-e3fcc2c11853@yahoo.pl>
 <20171006143219.4bn63aoenluc77fd@sigill.intra.peff.net>
From:   "aleksander.baranowski" <aleksander.baranowski@yahoo.pl>
Message-ID: <07ab076b-e1c6-8731-4501-17459bdff005@yahoo.pl>
Date:   Fri, 6 Oct 2017 18:57:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171006143219.4bn63aoenluc77fd@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!,

Thank you very much for descriptive answer.

You are absolutely right. I should read manual more carefully! Still
it's quite odd interface. Thank you for your time.

Bests,
Alex


On 10/06/2017 04:32 PM, Jeff King wrote:
> On Fri, Oct 06, 2017 at 01:10:17PM +0200, aleksander.baranowski wrote:
> 
>> I'm currently using git version 2.14.2. There is possible to put
>> multiple values into same variable with git config.
> 
> Yep, your examples should behave the same even with older versions.
> 
>> Case 1:
>> # git config --global user.name Foo - returns 0
>> # git config --global user.name Bar - returns 0 and replace Foo to Bar
>> # git config --global user.name Foo - returns 0 and replace Bar to Foo
> 
> This is all as expected. You're hitting the first case in the manpage
> synopsis here (I snipped the uninteresting options):
> 
>   git config name [value [value_regex]]
> 
> So you're doing:
> 
>   git config name value
> 
> which replaces any existing key by default. You could also do:
> 
>   git config --add name value
> 
> to add without replacing (if you had a config key that takes multiple
> values).
> 
>> Case 2:
>> # git config --global user.name Foo - returns 0
>> # git config --global user.name Foo2 Bar - returns 0 and put second name
> 
> Here you're doing:
> 
>   git config name value value_regex
> 
> So we're replacing any values which match the regex "Bar" (and there are
> none), and leaving others intact. Hence after this you will have two
> user.name values.
> 
> If you wanted a name with two strings, you'd have to quote the string
> from the shell to leave it as a single argument:
> 
>   git config user.name "Foo2 Bar"
> 
>> # cat ~/.gitconfig
>> [user]
>> 	email = aleksander.baranowski@yahoo.pl
>> 	name = Foo
>> 	name = Foo2
> 
> Right, this is what I'd expect.
> 
>> # git config --global user.name Foo - return 5 and message
>> "warning: user.name has multiple values
>> error: cannot overwrite multiple values with a single value
>>        Use a regexp, --add or --replace-all to change user.name."
> 
> And this, too (though I forgot we had such a safety check).
> 
>> It's just an opinion, but this behaviour is no consistent for me.
>>
>> If it's not the bug it's a feature just let me know.
> 
> It's a feature, though I agree that git-config is rather baroque. We're
> mostly stuck with it for reasons of backwards compatibility, though.
> 
> -Peff
> 
