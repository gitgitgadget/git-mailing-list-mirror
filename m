Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C567E1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 12:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbeGWNt6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 09:49:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36239 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387954AbeGWNt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 09:49:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id s7-v6so325395pgv.3
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o9VpAZ9biGcOCO0TsElMix1mPNEPXDihtdjHcK+ikRY=;
        b=ld54Yk8w7FR0bk1CQo8H0WBdB0gE4L4DFKx11zrGC9tr2eePYvnYjKiEttYB1BCrsl
         oGvn0o8wNziQCRfk0yIvZlblWZ2D01+S7LHN9R7pktNSI9vw3OkMg/GFHAhYmpD9bRrQ
         +/c81qSij5EYpSuONzQ4NQM+22Q4A1MaMmRYZyiPsoyoOrX1lOp45s2H0C5vwFdeZXxM
         +XtTKppmAMplsJmtI5ukWOXnXnmyz7Z+szxKU94g0Wr9tKW0aUlqGGUCb+RdVQXP6OsJ
         TclRUDJAFulQPYD09/zfs2MUbLYwn+I9mlRyv0jdAlpq4A19wu8Hzs9JUeT25pFSHn4g
         rz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=o9VpAZ9biGcOCO0TsElMix1mPNEPXDihtdjHcK+ikRY=;
        b=pDVhEbiYSlWIlxxb2VtPz1wX89u3+jVPxiTY7UhYMxFab7COJWCLgpdEYxRplHcFlD
         3PI9o8VLJ7Kz9MXdKcNHd2g33UqAXiDb4k6nnWUXMmbg1lj31uflnH+ksI3u+4i9WUGY
         5rfWxhB2DVRVppOg0ScV0IGVPE3wqAY2iA+eL4hlCNT9eox5czOTUieX1qXL7W7mDcSK
         CP754YlRRgc1hMXPHmdMQdgA4BvKDpHqwe0N78DJR+BcDyVrIfvsEDT5sB2SBKqX23eF
         IcXH13i4O3ULncH5yBSRx5MReLIhVSq8fQEBAMUYhlcHUaA+Y89SyfwZ16aYGi/L76Y+
         CABw==
X-Gm-Message-State: AOUpUlHJjeolVR2OC7hOzJcOSHYdehuPkAgdjNgJ+Dql4iO/Ny6nAWae
        j0qs58X2mxH+PGoXEl6Tn+E=
X-Google-Smtp-Source: AAOMgpfRy5ZL1W+Tx0NOmLcgGG4tRXKEs7FSfoaA3njrypTdsJL04LHtqYJHH5zjMkovwdXetDa3Bw==
X-Received: by 2002:a63:8449:: with SMTP id k70-v6mr12204276pgd.309.1532350133492;
        Mon, 23 Jul 2018 05:48:53 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([183.83.81.223])
        by smtp.gmail.com with ESMTPSA id i25-v6sm7228124pfi.150.2018.07.23.05.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 05:48:52 -0700 (PDT)
Subject: Re: Hash algorithm analysis
To:     demerphq <demerphq@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, agl@google.com,
        keccak@noekeon.org
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
 <20180721235941.GG18502@genre.crustytoothpaste.net>
 <CANgJU+X39NoEoMyLu+FX38=x19LrRqatz_dUpUAc+WFV+Uw+=A@mail.gmail.com>
From:   Sitaram Chamarty <sitaramc@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sitaramc@gmail.com; prefer-encrypt=mutual; keydata=
 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
 ZNJ7wKEHInRBmycqkB/ksby8tHy6yfE6
Message-ID: <98111891-a605-1cfd-e92b-a3b5b4186ac2@gmail.com>
Date:   Mon, 23 Jul 2018 18:18:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANgJU+X39NoEoMyLu+FX38=x19LrRqatz_dUpUAc+WFV+Uw+=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/23/2018 06:10 PM, demerphq wrote:
> On Sun, 22 Jul 2018 at 01:59, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> I will admit that I don't love making this decision by myself, because
>> right now, whatever I pick, somebody is going to be unhappy.  I want to
>> state, unambiguously, that I'm trying to make a decision that is in the
>> interests of the Git Project, the community, and our users.
>>
>> I'm happy to wait a few more days to see if a consensus develops; if so,
>> I'll follow it.  If we haven't come to one by, say, Wednesday, I'll make
>> a decision and write my patches accordingly.  The community is free, as
>> always, to reject my patches if taking them is not in the interest of
>> the project.
> 
> Hi Brian.
> 
> I do not envy you this decision.
> 
> Personally I would aim towards pushing this decision out to the git
> user base and facilitating things so we can choose whatever hash
> function (and config) we wish, including ones not invented yet.
> 
> Failing that I would aim towards a hashing strategy which has the most
> flexibility. Keccak for instance has the interesting property that its
> security level is tunable, and that it can produce aribitrarily long
> hashes.  Leaving aside other concerns raised elsewhere in this thread,
> these two features alone seem to make it a superior choice for an
> initial implementation. You can find bugs by selecting unusual hash
> sizes, including very long ones, and you can provide ways to tune the
> function to peoples security and speed preferences.  Someone really
> paranoid can specify an unusually large round count and a very long
> hash.
> 
> Also frankly I keep thinking that the ability to arbitrarily extend
> the hash size has to be useful /somewhere/ in git.

I would not suggest arbitrarily long hashes.  Not only would it
complicate a lot of code, it is not clear that it has any real benefit.

Plus, the code contortions required to support arbitrarily long hashes
would be more susceptible to potential bugs and exploits, simply by
being more complex code.  Why take chances?

I would suggest (a) hash size of 256 bits and (b) choice of any hash
function that can produce such a hash.  If people feel strongly that 256
bits may also turn out to be too small (really?) then a choice of 256 or
512, but not arbitrary sizes.

Sitaram
also not a cryptographer!
