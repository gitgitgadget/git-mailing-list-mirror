Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891181FC44
	for <e@80x24.org>; Mon,  8 May 2017 21:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbdEHV1Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 17:27:16 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35854 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdEHV1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 17:27:15 -0400
Received: by mail-pg0-f47.google.com with SMTP id 64so17337390pgb.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 14:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=y68LUcLKMNvq0+y4N2aDamhiYYMMl+bTZh7RoKdeVAs=;
        b=B9/nnZAVfZsHVleuqCvfLY7mkoTn72E1HAfGS4rXLwE5Yklf2IS2B1vi38qjJKi4/T
         IQFdNGCj3YYBh0JoaklNNuGJYC1QvYMtVoC45JC9ygC2EOWjsB5HU2n4Tt7jHHCqjAfY
         MXgaD+bjtcRTQTM1LPlSg7Iyy3gOfs4MUnHaneqTCBFRQ5cvbkGZPgZNRPgCOTM9cMrA
         Pys4p8UqIuKQ9ogNNS+r0t+ZfBDqLbtIFR2J8umpszBxJ2Ix/W9RiaKWNZ6+QJmWNc9F
         COh9KwkZR7/WbiFB3nGcLNIh2n4bNkyMDQ/zSeBLxA/hDXW/Po8RHKgIAfDBP/qKfiDg
         HVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=y68LUcLKMNvq0+y4N2aDamhiYYMMl+bTZh7RoKdeVAs=;
        b=NLxlnWGu6frvGhpHtwefy1ZS0yZZ4M1R7NqblNx8vfGzkYWq+tyGU6uJtbIxs769Ub
         MyEEZn7Cmoco54GFrzChVx6NqnAhATblTFZFmbbCAbFjdEFTkzO182tg819Ip44zaM1o
         86ydoEJN7CJhfPmlruQzEt/qB0AqV6UBdoRL/8/cVS0/534V16553Dde5jLwuHIcOjQ8
         WRm3baGrME767obQvrqOh55M63z3SQRL+E1hjPxTOA8TsAz5G+xEUOIdFLr1X78mOzFS
         CqoI498GC1/O4WfhkdoTmh5vFzb6JtncXKRSta+6/i0yl8Roi40daLB356DB8vahiHmy
         ZD8A==
X-Gm-Message-State: AN3rC/4uiUsMROJAS44znoq2hwHfEgKRRLLjNbEuGBDCfPhi4+8wa5m1
        S8peDuZcKmvSY+mH
X-Received: by 10.84.238.199 with SMTP id l7mr58408411pln.153.1494278834387;
        Mon, 08 May 2017 14:27:14 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:91e9:5a9b:243a:fa47])
        by smtp.gmail.com with ESMTPSA id b8sm21278738pgn.51.2017.05.08.14.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 May 2017 14:27:13 -0700 (PDT)
Subject: Re: [PATCH 3/3] protocol docs: explain receive-pack push options
To:     Jonathan Nieder <jrnieder@gmail.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
 <615007182a5e205a7074317a4c8788aa4eb009ff.1494027001.git.jonathantanmy@google.com>
 <20170506002605.GM28740@aiede.svl.corp.google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <01f61fa4-d69d-8f0b-76e1-bca3444f4101@google.com>
Date:   Mon, 8 May 2017 14:27:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170506002605.GM28740@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/05/2017 05:26 PM, Jonathan Nieder wrote:
>> -This list is followed by a flush-pkt. Then the push options are transmitted
>> -one per packet followed by another flush-pkt. After that the packfile that
>> -should contain all the objects that the server will need to complete the new
>> -references will be sent.
>> +This list is followed by a flush-pkt.
>
> I think this removed more than intended.
>
> Before c714e45f (receive-pack: implement advertising and receiving
> push options, 2016-07-14), this said
>
> 	This list is followed by a flush-pkt and then the packfile that should
> 	contain all the objects that the server will need to complete the new
> 	references.
>
> which I think would work fine.

That wouldn't work fine because there is no mention of push options - 
hence the modification in c714e45f to talk about push options, but that 
is also not accurate because push options (and, more importantly, the 
associated flush-pkt) are not sent if the client doesn't have any.

> [...]
>> -  update-request    =  *shallow ( command-list | push-cert ) [packfile]
>> +  update-request    =  *shallow ( command-list | push-cert )
>
> This seems confusing to me both before and after.  How does
> update-request get used?  Is it supposed to include the packfile or not?
>
> Where do push-options fit into an unsigned request?

I've updated "update-request" to "update-requests" to show that this is 
the "list of reference update requests" mentioned in the previous paragraph.

This is only the ref part - I've chosen to describe push options and 
packfile in separate sections, because there are very specific rules 
that determine whether the push option section must be included or omitted.

>
> [...]
>> @@ -500,12 +497,35 @@ references will be sent.
>>  		      PKT-LINE("pusher" SP ident LF)
>>  		      PKT-LINE("pushee" SP url LF)
>>  		      PKT-LINE("nonce" SP nonce LF)
>> +		      *PKT-LINE("push-option" SP push-option LF)
>>  		      PKT-LINE(LF)
>>  		      *PKT-LINE(command LF)
>>  		      *PKT-LINE(gpg-signature-lines LF)
>>  		      PKT-LINE("push-cert-end" LF)
>>
>> -  packfile          = "PACK" 28*(OCTET)
>> +  push-option       =  1*CHAR
>> +----
>> +
>> +If the server has advertised the 'push-options' capability and the client has
>> +specified 'push-options' as part of the capability list above, the client then
>> +sends its push options followed by a flush-pkt.
>> +
>> +----
>> +  push-options      =  *PKT-LINE(push-option) flush-pkt
>> +----
>> +
>> +For backwards compatibility with older Git servers, if the client sends a push
>> +cert and push options, it SHOULD send its push options both embedded within the
>
> This needs to be a MUST, not SHOULD.
>
>> +push cert and after the push cert. (Note that the push options within the cert
>> +are prefixed, but the push options after the cert are not.) Both these lists
>> +SHOULD be consistent.
>
> Likewise this one.
>
> What does it mean to be consistent?

Changed to "MUST be the same, modulo the prefix".
