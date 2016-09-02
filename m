Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B647A1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 22:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbcIBWLU (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 18:11:20 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33236 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbcIBWLT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 18:11:19 -0400
Received: by mail-pf0-f175.google.com with SMTP id g202so23033613pfb.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 15:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=4ICkJCiyfGuRhI4JEVhPr8VWNuuGVYaHYT9JqzH9I4E=;
        b=glIFzP4CEm1h+xMMB4kR6c7M2yqrWme3tU/SYSuD+NRRTDgLJZGWkwqzoRyGEYZtN7
         FG0x6r3uXr+/avIIqQNfAq8YS7szHz3GZAfExc5isMbZQ6VFBvTASUZDvcGX/t4hBZFv
         yOUsUENeYqzoy/SzCJ5tpEx0IoXygVsY8OA7ZHsxCAJ6vGSVF2LDZXrNRW0ngc7lRz7i
         KwIZlSKnZntzPsBj+lMcC5rkfrki8+Wl2RA6nYZExfdK0xe4DCaZ8oYaZ9Xi2dsnkb5j
         qA4sozQ/ooNp+FBCAtkV+nzKstptbqHZVVkXD+TCqG6/ByAvDdwmL1ro0ivVv5IHvu1h
         5X/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=4ICkJCiyfGuRhI4JEVhPr8VWNuuGVYaHYT9JqzH9I4E=;
        b=G/oZv/C2nZfkWuIlPpSQ+BYxkP/YBcNDu+Df+zWuL5oIITKyuvxT35924ZRC3FTloK
         DCk3Y1qbyBgNxohC/h64Lc9hlb8SroWFHsbOnzTAu+TV0RaF91KTl70oSvJ8cSmhd1KX
         zMnbzYCMgOHp4YGhlvLkD3xmTLK1ZQxQU6XhU9KOL+LPEfhNvVsNNg/rzZfqR9skUAba
         NMLOjfziB/0EbvOXwAmdx/ESTzdksLFOfKDoYXSL5zr2MEjfgngoOomQKWx2CxdTiLZw
         SYDl78MjXcIsG4sYKhgqChP2ZZr/jpgtVd5HoeL9ZDmh5kobCoqRSKuByxeqODlMvv0A
         bkGA==
X-Gm-Message-State: AE9vXwOGF+q0ie8027fVGgtJXndyTCAl6gvO0Ge2sAnTLpChBYrNr38H3gN1INA0SrJyGeyg
X-Received: by 10.98.100.67 with SMTP id y64mr40408888pfb.84.1472854278559;
        Fri, 02 Sep 2016 15:11:18 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:5d3b:bbd9:4200:b5b1])
        by smtp.gmail.com with ESMTPSA id h86sm17017460pfh.46.2016.09.02.15.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2016 15:11:17 -0700 (PDT)
Subject: Re: [PATCH 2/2] connect: know that zero-ID is not a ref
To:     Jeff King <peff@peff.net>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <2bea354c6218a33db3972e42baa75676fdcbc598.1472836026.git.jonathantanmy@google.com>
 <20160902201321.35egsg5l6r2fvrtw@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <84df7985-6c87-9485-261c-e8e9a3bbab7b@google.com>
Date:   Fri, 2 Sep 2016 15:11:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160902201321.35egsg5l6r2fvrtw@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/02/2016 01:13 PM, Jeff King wrote:
> On Fri, Sep 02, 2016 at 10:15:39AM -0700, Jonathan Tan wrote:
>> (git-daemon should probably also be changed to serve zero IDs, but such
>> a change can be considered independently from this change; even if both
>> the client and server changes were made in one commit, it is nearly
>> impossible that all Git installations are updated at the same time - an
>> updated client would still need to deal with unupdated servers and vice
>> versa.)
>
> I'm really not sure what you mean here. How does git-daemon enter into
> this at all?

I was comparing the behavior of git daemon and jgit daemon - when 
serving the same repository, the former does not send the zero ID and 
capabilities^{} line, whereas the latter does; and I was stating that 
git daemon's behavior should be changed to JGit's behavior, but not 
necessarily immediately.

(In one of the replies to that email, Jonathan Nieder has suggested a 
more detailed transition plan.)

>> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
>> index 819b9dd..c6f8b6f 100755
>> --- a/t/t5512-ls-remote.sh
>> +++ b/t/t5512-ls-remote.sh
>> @@ -207,5 +207,27 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
>>  	test_cmp expect actual
>>  '
>>
>> +test_lazy_prereq GIT_DAEMON '
>> +	test_have_prereq JGIT &&
>> +	test_tristate GIT_TEST_GIT_DAEMON &&
>> +	test "$GIT_TEST_GIT_DAEMON" != false
>> +'
>
> GIT_DAEMON depends on JGIT? Should this really be the JGIT_DAEMON
> prerequisite?

The JGIT line shouldn't be there - thanks for catching this.
