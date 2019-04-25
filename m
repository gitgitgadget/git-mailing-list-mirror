Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E31D51F462
	for <e@80x24.org>; Thu, 25 Apr 2019 14:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfDYOnm (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 10:43:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37249 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYOnk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 10:43:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id z16so356450qtn.4
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 07:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BitI5V8tXAqFLLpHRh+X/gnQWTtgEZ4EwVeuokotwn8=;
        b=DBfqnKUGdVLI6aXf1nOnyTInbnfxpRO55Re85Bh+ct4zXNMAbN+yZrnGo0+m9TeOTM
         8GrP+SaWBxlHsUPRqCz5z4dboQohGgGEGkIywWwJtCiFkKH4jQLE5chWSVu7OESHCixJ
         QbvFEOzAZFE2B/KPuzxWhu6Ik2AuTsd0OfS/fVxZLPNWEAqx0MhovHx9rfNBPRXYmw+C
         dw76ry8p5xwwQWisr8KJNieYb45ujN2WyendQaVR5Gim4ZXnQQr8e+usRdMUj5vQOEKv
         0Hs90AB9oLJ7nrEhHhoDK2p5J1vHnxRtTk+XG62RNDOQdO+9zdfvAZ0HKjkhN4AcLjCY
         i2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BitI5V8tXAqFLLpHRh+X/gnQWTtgEZ4EwVeuokotwn8=;
        b=i0OTry2QAj7UTW58Ysp/F7g8S67b3J3tQwfIiwjtBxzP3y15G91oxhrJluatFFjvOb
         u5enQlNMtjrvYsPUblFElSG8SWZ+EZxWejoDFMlh1y31u1XQMDaF+QM+H8fhokLmni4z
         f7uoytaKjE6v0TZsZu/+PqkWIhQoQ49MJa3CqAsZq3meFR7hj056K2HA2gYe6BvyMuQk
         ovyfQZ9TM6+2ZQh6FpIBa3T4f0o4Q9IWaf8WQTA3kVqS3WfKg8reiMJovq22nUZUBL3r
         fW51jZ1EQfMmfklgFHGJrCw0/q0dyx5HLH4uv8O0og+6cP1s29Wee0SYcghWaNvBdxUr
         FZ1g==
X-Gm-Message-State: APjAAAXoOQyOLU8GhvFw/1NLlHAdD20adfURE/dz+LD5q0oXM+SRIHHC
        OysdeysJYDNFM0BK0izNCNyPEHrz04U=
X-Google-Smtp-Source: APXvYqyi6Wtrffp17m+UHo1TAFT6KXgWPqyPKcD2kHyi4QBAio/Ira5R79/fJqDhFxd3XGwo1gM6HA==
X-Received: by 2002:ac8:388a:: with SMTP id f10mr21048239qtc.237.1556203419551;
        Thu, 25 Apr 2019 07:43:39 -0700 (PDT)
Received: from ?IPv6:2620:0:1004:a:6e2b:60f7:b51b:3b04? ([2620:0:1004:a:6e2b:60f7:b51b:3b04])
        by smtp.gmail.com with ESMTPSA id 50sm15055137qtq.7.2019.04.25.07.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 07:43:38 -0700 (PDT)
Subject: Re: How to undo previously set configuration? (again)
To:     Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Olaf Hering <olaf@aepfle.de>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424023438.GE98980@google.com>
 <20190424230744.GL6316@genre.crustytoothpaste.net>
 <87k1fis8gq.fsf@evledraar.gmail.com> <20190425143614.GA91608@google.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <74ea0269-3e4f-1f6a-c060-c5ac969b91e8@google.com>
Date:   Thu, 25 Apr 2019 10:43:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190425143614.GA91608@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 4/25/19 10:36 AM, Jonathan Nieder wrote:
> Hi,
> 
> Ævar Arnfjörð Bjarmason wrote:
> 
>> Because we don't have some general config facility for this it keeps
>> coming up, and various existing/proposed options have their own little
>> custom hacks for doing it, e.g. this for Barret Rhoden's proposed "blame
>> skip commits" feature
>> https://public-inbox.org/git/878swhfzxb.fsf@evledraar.gmail.com/
>> (b.t.w. I*meant*  /dev/null in that E-Mail, but due to PEBCAK wrote
>> /dev/zero).
> I'm confused.  Isn't that bog-standard Git usage, not a custom hack?
> That is, I thought the intended behavior is always
> 
>   1. For single-valued options, last value wins.
>   2. For multi-valued options, empty clears the list.
>   3. When there is a special behavior triggered by not supplying the
>      option at all, offer an explicit value like "default" that triggers
>      the same behavior, too.
> 
> and that any instance of a command that isn't following that is a bug.

Not sure if it's meant to be the standard, but I just went with the 
style used by credential.helper.  This was suggested to me by Johannes 
in [1]:

On 2019-01-18 at 10:47 Johannes Schindelin <Johannes.Schindelin@gmx.de>
wrote:
> A better idea IMHO would be to use an OPT_STRING_LIST() for
> `--ignore-revs-file`, too, and to allow for multiple
> `blame.ignoreRevsFile` config entries (with our usual trick of handling an
> empty setting by resetting the list of paths that were accumulated so
> far, see e.g. how `credential.helper` is handled).

[1] 
https://public-inbox.org/git/nycvar.QRO.7.76.6.1901181038540.41@tvgsbejvaqbjf.bet/

Barret

