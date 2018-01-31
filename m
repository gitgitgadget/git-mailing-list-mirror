Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36EBA1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 16:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeAaQAb (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 11:00:31 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:40198 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeAaQAa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 11:00:30 -0500
Received: by mail-qt0-f175.google.com with SMTP id s39so22414080qth.7
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 08:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UrJU4IfJCZP6zVVBrTsmd3wFmomD2VFp17C6N0ZCKYw=;
        b=iW7gM7CpGvH3ZzFnD4PaT59V37gRvsHdja2Lx8D3KEGouoXOdVqB0zGZgQlX6N7bW6
         3Jzk4hBSkIwekVWqTfgSblVspDL4DYgiHeXKc+ALC0wP7X5Blm0XhwGCFZO7QnMhKl4T
         JcB60+W4ZCPTef5pRd02zMvfvF8eLC++yV95t9EXs0PJWTlfPgagUe8cpUJjVpmCIZL0
         dDiCYKCzJOGcJ9IULQU4qcjKliRYcUHQgFv++s4ZX7BLIQtMVHaeiPsUZObsVzdoQh0K
         iMtEa9aXTOlj99RIN5XPEYz0p9SfqwbG1AjesR52QwZl69Cz1XYdFLhv6e3vDUX80K6Y
         8woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UrJU4IfJCZP6zVVBrTsmd3wFmomD2VFp17C6N0ZCKYw=;
        b=OMZWwgknHucrpLW5EPHgG0ZwT83352lSg2sx0lxZ4BJBC1nu1j7tJp+Jy/vIm7fAOa
         dGsI8+reAZtZTDdUz5ozL+exH38p3cYxMC/HVPZCUHFsXST4hKjqCspLAbN1fJmpEURt
         DbGBNr0FicNWdUmhH/ogPOhm3vBb9/0UGPBpGfTZ2GGpk7TwNYNDF/Jjcyp6xgyLQejW
         z87ufnyaCNrN7Dk42ibENcboXRZo73WXIgrPUAlznn7zviH6iH1Xl+iuIDTTP4nfX2eD
         8+2WorMPm9BGYQ+nE/KnbbRRS8Tij764rknlFqbsNvYaB0Wxnotw/ZBRJDiq60GlY8g9
         Yoag==
X-Gm-Message-State: AKwxyteB3DndL0kJEOHoPYYCKPGBrzmLjTi8sZ+Nlb+tcNbsL+wEZucr
        17CFgrUmSU6MhQEuF1SPFIk=
X-Google-Smtp-Source: AH8x227RcS/CDZxCb8za8lLN0Ai/6QpzFz+u74A7vldWb7Y9iJVbOAMUJfIUomvTkeO4L66UU6Qfow==
X-Received: by 10.200.50.176 with SMTP id z45mr53508093qta.140.1517414429459;
        Wed, 31 Jan 2018 08:00:29 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id n25sm13927413qtf.58.2018.01.31.08.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 08:00:28 -0800 (PST)
Subject: Re: [PATCH v2 00/27] protocol version 2
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, jrnieder@gmail.com
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <56044237-4086-faeb-730e-807858a082a8@gmail.com>
Date:   Wed, 31 Jan 2018 11:00:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for chiming in with mostly nitpicks so late since sending this 
version. Mostly, I tried to read it to see if I could understand the 
scope of the patch and how this code worked before. It looks very 
polished, so I the nits were the best I could do.

On 1/25/2018 6:58 PM, Brandon Williams wrote:
> Changes in v2:
>   * Added documentation for fetch
>   * changes #defines for state variables to be enums
>   * couple code changes to pkt-line functions and documentation
>   * Added unit tests for the git-serve binary as well as for ls-refs

I'm a fan of more unit-level testing, and I think that will be more 
important as we go on with these multiple configuration options.

> Areas for improvement
>   * Push isn't implemented, right now this is ok because if v2 is requested the
>     server can just default to v0.  Before this can be merged we may want to
>     change how the client request a new protocol, and not allow for sending
>     "version=2" when pushing even though the user has it configured.  Or maybe
>     its fine to just have an older client who doesn't understand how to push
>     (and request v2) to die if the server tries to speak v2 at it.
>
>     Fixing this essentially would just require piping through a bit more
>     information to the function which ultimately runs connect (for both builtins
>     and remote-curl)

Definitely save push for a later patch. Getting 'fetch' online did 
require 'ls-refs' at the same time. Future reviews will be easier when 
adding one command at a time.

>
>   * I want to make sure that the docs are well written before this gets merged
>     so I'm hoping that someone can do a through review on the docs themselves to
>     make sure they are clear.

I made a comment in the docs about the architectural changes. While I 
think a discussion on that topic would be valuable, I'm not sure that's 
the point of the document (i.e. documenting what v2 does versus selling 
the value of the patch). I thought the docs were clear for how the 
commands work.

>   * Right now there is a capability 'stateless-rpc' which essentially makes sure
>     that a server command completes after a single round (this is to make sure
>     http works cleanly).  After talking with some folks it may make more sense
>     to just have v2 be stateless in nature so that all commands terminate after
>     a single round trip.  This makes things a bit easier if a server wants to
>     have ssh just be a proxy for http.
>
>     One potential thing would be to flip this so that by default the protocol is
>     stateless and if a server/command has a state-full mode that can be
>     implemented as a capability at a later point.  Thoughts?

At minimum, all commands should be designed with a "stateless first" 
philosophy since a large number of users communicate via HTTP[S] and any 
decisions that make stateless communication painful should be rejected.

>   * Shallow repositories and shallow clones aren't supported yet.  I'm working
>     on it and it can be either added to v2 by default if people think it needs
>     to be in there from the start, or we can add it as a capability at a later
>     point.

I'm happy to say the following:

1. Shallow repositories should not be used for servers, since they 
cannot service all requests.

2. Since v2 has easy capability features, I'm happy to leave shallow for 
later. We will want to verify that a shallow clone command reverts to v1.


I fetched bw/protocol-v2 with tip 13c70148, built, set 
'protocol.version=2' in the config, and tested fetches against GitHub 
and VSTS just as a compatibility test. Everything worked just fine.

Is there an easy way to test the existing test suite for clone and fetch 
using protocol v2 to make sure there are no regressions with 
protocol.version=2 in the config?

Thanks,
-Stolee
