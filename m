Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE29720281
	for <e@80x24.org>; Fri, 29 Sep 2017 15:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbdI2PEK (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 11:04:10 -0400
Received: from ober.noekeon.org ([91.134.133.203]:42771 "EHLO ober.noekeon.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbdI2PEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 11:04:09 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Sep 2017 11:04:09 EDT
Received: from ip-145-116-191-166.wlan-int.ru.nl (ip-145-116-191-166.wlan-int.ru.nl [145.116.191.166])
        by ober.noekeon.org (Postfix) with ESMTPSA id 3416122365;
        Fri, 29 Sep 2017 16:54:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=noekeon.org; s=mail;
        t=1506696866; bh=M3iaXA6tC5pOVOxbnQcbyIwwq7ppF8ajSaveO0s+Wqw=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=nbuBkSMp12af5ZF0r+fAq9+hqc1fPHEzyFI29JoWsbFcWVdiDNv7azGYvbeMjZjNP
         ms2M2140TjBskfGNi6cK0xJEaM23xL9CljLhJtUiG+yTFIJ1RphSAH5aF4Fiun2j5G
         JOk0Zr/YzDCstVr/H/2/JPnQjfoBB0JXKzBkl0i8=
Subject: Re: RFC v3: Another proposed hash function transition plan
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Gilles Van Assche <gilles.vanassche@st.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
 <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1709142037490.4132@virtualbox> <59BFB95D.1030903@st.com>
 <alpine.DEB.2.21.1.1709182340350.219280@virtualbox> <59C149A3.6080506@st.com>
 <alpine.DEB.2.21.1.1709291416290.40514@virtualbox>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Keccak Team <keccak@noekeon.org>
From:   Joan Daemen <jda@noekeon.org>
Message-ID: <acd96750-c165-650c-c67f-44465f2075f2@noekeon.org>
Date:   Fri, 29 Sep 2017 16:54:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1709291416290.40514@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Johannes,

if ever there was a SHA-2 competition, it must have been held inside 
NSA:-) But maybe you are confusing with the SHA-3 competition. In any 
case, when considering SHA-2 vs SHA-3 for usage in git, you may have a 
look at arguments we give in the following blogpost:

https://keccak.team/2017/open_source_crypto.html

Kind regards,

Joan Daemen

On 29/09/17 15:17, Johannes Schindelin wrote:
> Hi Gilles,
>
> On Tue, 19 Sep 2017, Gilles Van Assche wrote:
>
>> On 19/09/17 00:16, Johannes Schindelin wrote:
>>>>> SHA-256 got much more cryptanalysis than SHA3-256 […].
>>>> I do not think this is true.
>>> Please read what I said again: SHA-256 got much more cryptanalysis
>>> than SHA3-256.
>> Indeed. What I meant is that SHA3-256 got at least as much cryptanalysis
>> as SHA-256. :-)
> Oh? I got the opposite impression... I got the impression that *everybody*
> in the field banged on all the SHA-2 candidates because everybody was
> worried that SHA-1 would be utterly broken soon, and I got the impression
> that after this SHA-2 competition, people were less worried?
>
> Besides, I would expect that the difference in age (at *least* 7 years by
> my humble arithmetic skills) to make a difference...
>
>>> I never said that SHA3-256 got little cryptanalysis. Personally, I
>>> think that SHA3-256 got a ton more cryptanalysis than SHA-1, and that
>>> SHA-256 *still* got more cryptanalysis. But my opinion does not count,
>>> really. However, the two experts I pestered with questions over
>>> questions left me with that strong impression, and their opinion does
>>> count.
>> OK, I respect your opinion and that of your two experts. Yet, the "much
>> more" part of your statement, in particular, is something that may
>> require a bit more explanations.
> I would also like to point out the ubiquitousness of SHA-256. I have been
> asked to provide SHA-256 checksums for the downloads of Git for Windows,
> but not SHA3-256...
>
> And this is a practically-relevant thing: the more users of an algorithm
> there are, the more high-quality implementations you can choose from. And
> this becomes relevant, say, when you have to switch implementations due to
> license changes (*cough, cough looking in OpenSSL's direction*). Or when
> you have to support the biggest Git repository on this planet and have to
> eek out 5-10% more performance using the latest hardware. All of a sudden,
> your consideration cannot only be "security of the algorithm" any longer.
>
> Having said that, I am *really* happy to have SHA3-256 as a valid fallback
> option in case SHA-256 should be broken.
>
> Ciao,
> Johannes

