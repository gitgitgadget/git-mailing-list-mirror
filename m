Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 422AD207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 20:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S976792AbdDXUdq (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 16:33:46 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34713 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S977598AbdDXUdf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 16:33:35 -0400
Received: by mail-qk0-f194.google.com with SMTP id u75so5711030qka.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=TNRWF14GhlRG6J2+gGa7f6RbnE3v67Aiodjp87hBJyU=;
        b=OYg1XjCnQSyQG8xTvu1xoTJ1UWCXAQ80lPYPvuWscM2Ez0HpA57n3mc3giGcmCq5Wq
         pVXF+E0SFeJY98vlduTP8FavsVmGKeVbDrNaD+UG1Ka67jaAEbAqOuF9PNMTwKa3qWdq
         dnez4RQLUt8AFvS6u7pHy3dQYLGfXfyR9HkDV/MCsWo3GDKeWDr6yK5ecm4h3dPh+J1Z
         E1dkvhW5D29T51/bvMVAM/9n3lCvyZ//XdZFByhoaUDidPc8uUrz5Uzwml+D6sgZb3nV
         FCIV2yY5n3OypbeGoAtLPg4xNQEcdjdkyyTVREqODDUR6sq/SqHGWOwd0h7gEzjTHAjt
         pKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=TNRWF14GhlRG6J2+gGa7f6RbnE3v67Aiodjp87hBJyU=;
        b=Fli7+7kiYzFDqKEeJuxRWovA6MlRTQKVYnPTMxyBHHq/VbUhHQP6MsDUgjUHnrq3Ec
         IMTNLuaf+KSGsRSgaz4K0uGK6oV3ek8K9p2zFfSp39AbeoQofMn7EZ7KjNHqKmJF6Ytk
         E0l32xe4vxWKi2eBbHulVGV/+3VKXj+A8/m30zurElGUFYzet6q34gH2oSwNM3P7dXOn
         D6V9YteCxQ+pBRRHRz8VCs4+FHFxccSoTeMWH5PlGitikIbHl09vedsvMlQZzme4OZhX
         2GWbI+GpHTKnzgTHvcRQuNoiMK8UnRA5RJb79xnP3QmhUcYV5gKYMJ2Ho/Gb9BsYCSaI
         Ab3Q==
X-Gm-Message-State: AN3rC/7Sj4K1lPslmjw8uCWJdkHPmzFY6710XHT3qCIIWrwJNUoB7YT9
        NPV6LqtVHtIspQ==
X-Received: by 10.55.92.71 with SMTP id q68mr26063942qkb.219.1493066009417;
        Mon, 24 Apr 2017 13:33:29 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id c21sm3846131qkg.64.2017.04.24.13.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 13:33:28 -0700 (PDT)
Subject: Re: [PATCH v6 1/8] pkt-line: add packet_read_line_gently()
To:     Junio C Hamano <gitster@pobox.com>
References: <20170421172611.12152-1-benpeart@microsoft.com>
 <20170421172611.12152-2-benpeart@microsoft.com>
 <xmqqy3uqzb90.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
From:   Ben Peart <peartben@gmail.com>
Message-ID: <d6e8a63b-e95d-4194-5ad0-d68f557be083@gmail.com>
Date:   Mon, 24 Apr 2017 16:33:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3uqzb90.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/24/2017 12:21 AM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
>
>> Add packet_read_line_gently() to enable reading a line without dying on
>> EOF.
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> ---
>>   pkt-line.c | 14 +++++++++++++-
>>   pkt-line.h | 10 ++++++++++
>>   2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/pkt-line.c b/pkt-line.c
>> index d4b6bfe076..bfdb177b34 100644
>> --- a/pkt-line.c
>> +++ b/pkt-line.c
>> @@ -315,7 +315,7 @@ static char *packet_read_line_generic(int fd,
>>   			      PACKET_READ_CHOMP_NEWLINE);
>>   	if (dst_len)
>>   		*dst_len = len;
>> -	return len ? packet_buffer : NULL;
>> +	return (len > 0) ? packet_buffer : NULL;
>>   }
> The log does not seem to explain what this change is about.

This change was made as the result of a request in feedback from the 
previous version of the patch series which pointed out that the call to 
packet_read can return -1 in some error cases and to keep the code more 
consistent with packet_read_line_gently below.

If len < 0 then the old code would have incorrectly returned a pointer 
to a buffer with garbage while the new code correctly returns NULL 
(fixes potential bug)
if len == 0 then the code will return NULL before and after this change 
(no change in behavior)
if len > 0 then the code will return packet_buffer before and after this 
change (no change in behavior)

>
> Is this supposed to be a preliminary bugfix where this helper used
> to return a non-NULL buffer when underlying packet_read() signaled
> an error by returning a negative len?  If so, this should probably
> be a separate patch early in the series.
>
> Should len==0 be considered an error?  Especially given that
> PACKET_READ_CHOMP_NEWLINE is in use, I would expect that len==0
> should be treated similarly to positive length, i.e. the otherside
> gave us an empty line.
>
>>   char *packet_read_line(int fd, int *len_p)
>> @@ -323,6 +323,18 @@ char *packet_read_line(int fd, int *len_p)
>>   	return packet_read_line_generic(fd, NULL, NULL, len_p);
>>   }
>>   
>> +int packet_read_line_gently(int fd, int *dst_len, char** dst_line)
> ERROR: "foo** bar" should be "foo **bar"
> #29: FILE: pkt-line.c:326:
> +int packet_read_line_gently(int fd, int *dst_len, char** dst_line)

Sorry, missed that somehow.  I'll move the space before the ** in the 
next version of the patch series.

>
>> +{
>> +	int len = packet_read(fd, NULL, NULL,
>> +			      packet_buffer, sizeof(packet_buffer),
>> +			      PACKET_READ_CHOMP_NEWLINE|PACKET_READ_GENTLE_ON_EOF);
>> +	if (dst_len)
>> +		*dst_len = len;
>> +	if (dst_line)
>> +		*dst_line = (len > 0) ? packet_buffer : NULL;
> I have the same doubt as above for len == 0 case.

packet_read() returns -1 when PACKET_READ_GENTLE_ON_EOF is passed and it 
hits truncated output from the remote process.  This occurs when the 
remote process exits unexpectedly which is the exact case I was fixing 
with this new function.  This requires testing len for this error 
condition so that it can correctly handle this error case, otherwise it 
would incorrectly return an invalid buffer. Since this is a new 
function, there isn't any before/after behavior comparisons but it is 
consistent with the similar packet_read_line() function.

