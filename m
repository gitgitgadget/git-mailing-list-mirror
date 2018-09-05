Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1C281F404
	for <e@80x24.org>; Wed,  5 Sep 2018 19:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIEXoJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 19:44:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:43345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbeIEXoI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 19:44:08 -0400
Received: from [10.24.110.212] ([185.190.160.130]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ljqgb-1fR2Qc0MHJ-00bqB9; Wed, 05
 Sep 2018 21:12:27 +0200
Subject: Re: [RFC PATCH v2] Allow aliases that include other aliases
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
References: <20180905085427.4099-1-timschumi@gmx.de>
 <xmqqlg8f50mq.fsf@gitster-ct.c.googlers.com>
From:   Tim Schumacher <timschumi@gmx.de>
Message-ID: <42223280-d9be-904d-2804-86939ae25aaa@gmx.de>
Date:   Wed, 5 Sep 2018 21:12:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqlg8f50mq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Sj6ZXflXEoKRPdjGZsOBsL5SEUyIrlw3w/3w77VJ+UDQlGrSzrI
 ZfD67HlSYnIVAFIouEqynOmgHxXMKn9nKaac92DMKRWPDcFwTVli34cuTRVGB/UV/qkGsDr
 qBw3WECp/rFDuHey1XGtl2hgRHUSLXGbVspQaxENFoPhUvzRjiRJER6VhMSzvCd6Qh3FDwh
 clN1yoLuE+5L3geW6bOdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CZpVKOLywIo=:hoZNqvSteqHtOcmd25ggxn
 fYIk+VtAz3ugB7iwYyqu0Sd02bLEe1/DXEgkJz+rwFtsA/9td9r5XByH/DDwBYldT3k3OXSaH
 VgEyiiMqN7J8d4kQfkP4KAoYRbrrxW+vEuCrODFAzWiJBprbQhnLVeNZpLdhdTe8EaAVb26Jb
 NI8wjVRxxRFD9xYWZyyBA/ZEZaI1KMQcWp3uEfDGyX4kYnQs0ejubyu4CP1qPhb+6xFPCKREI
 2tOStPec9S25PFhqDB6tNNTY5p2ass7F7R1R8m0yoMwmEjzKDNt6Tn0/1EoY76BtrL5rz3zq5
 9jCqEqbzNeWaPadIX90gtPXsX7Q3Z9U1KLXMi1usbIoIgW1ox66RaKCb1hB1YxZfTOMLYOV0w
 q7AhxDgZnYA8RgAQX83owJUHmRL3ZnQGpNd49dBO1pnr9UVeWM3bDLVYMJFqsgSLOB0uUKkX+
 f5XIZFn4BWiMaM/4sS/LzBKwbCZ1gKadZnm/1ULz3/oXVLDZsORYz4qKUMsvplW70l2/z7IYL
 uXzm2QafRTGfE6w9CussYEKHSq6tzgOvwpHJnGe5Q/MaZW2oc7JW71ahFtp95ofe1d6sALSss
 GM8KkDSCHSq3Hiqsq8UmAuQRDVcfiI6Zwprw2NGfOr9ISMBw69zkHYpfKI40gPtGLR98SjR/1
 8d0A1Yls0kXHM1cz9M1H719vUZaDaYcgGluzwa+BMygcCMzJZdyvP3Zjemvd1rLjKuT95uGm9
 BkKrDVsEvMNrKuGLBap2s+YesZwK/rGvAKXOzC34FhHQVa2UcoLIaj1JMvuJ/PRy7+oDNwL3I
 g23NwM/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.09.18 19:12, Junio C Hamano wrote:
> Tim Schumacher <timschumi@gmx.de> writes:
> 
>> @@ -691,17 +693,34 @@ static int run_argv(int *argcp, const char ***argv)
>>   		/* .. then try the external ones */
>>   		execv_dashed_external(*argv);
>>   
>> +		/* Increase the array size and add the current
>> +		 * command to it.
>> +		 */
>> +		cmd_list_alloc += strlen(*argv[0]) + 1;
>> +		REALLOC_ARRAY(cmd_list, cmd_list_alloc);
>> +		cmd_list[done_alias] = *argv[0];
>> +
>> +		/* Search the array for occurrences of that command,
>> +		 * abort if something has been found.
>> +		 */
>> +		for (int i = 0; i < done_alias; i++) {
>> +			if (!strcmp(cmd_list[i], *argv[0])) {
>> +				die("loop alias: %s is called twice",
>> +				    cmd_list[done_alias]);
>> +			}
>> +		}
>> +
> 
> Wouldn't all of the above become three or four lines that is so
> clear that there is no need for any comment if you used string-list,
> perhaps?

Whoops, I didn't know that string-list existed. I'll try reworking the
code to use that. Concerning the comments: I planned to remove them
anyways since the code should be simple enough to be understood without
them already.

> 
>>   		/* It could be an alias -- this works around the insanity
>>   		 * of overriding "git log" with "git show" by having
>>   		 * alias.log = show
>>   		 */
> 
> 	/*
> 	 * Style: our multi-line comment begins with and ends with
> 	 * slash-asterisk and asterisk-slash on their own lines.
> 	 */

I wasn't sure if I should have changed that (because I didn't introduce
that comment), but I can fix it in v3.

> 
>> -		if (done_alias)
>> -			break;
>>   		if (!handle_alias(argcp, argv))
>>   			break;
>> -		done_alias = 1;
>> +		done_alias++;
>>   	}
>>   
>> +	free(cmd_list);
>> +
>>   	return done_alias;
>>   }
> 
