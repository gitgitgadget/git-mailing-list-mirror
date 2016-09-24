Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F54B1F935
	for <e@80x24.org>; Sat, 24 Sep 2016 19:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935020AbcIXTKR (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 15:10:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35332 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933333AbcIXTKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 15:10:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id 133so7798705wmq.2
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=rHD/whiqFE3Hq0wwDVlNLenlkPX+hs4PoXvWiBjNChY=;
        b=TLMafvAO7mWR8GM0REsjibdVDjfGXya5qLyMCe2gaaa7AIngiEYuRwPIpfv1t8TwmY
         l45L0IzZCA5pUv5M+3f6Meo3Vc2sInEFu2Uu5q4pr5/q0sNg+iDKkEkbWk0CtevNQJHt
         nnov1qlwSmVYvQDyJhIDhnHMK1QOUh5JG+qHmCVTmM+e60fbdy25jEXIy3f6WtHNDNGY
         Cj7EzPNA4u3rLf54dW9wlu3EwebJpoEJEgDrYOekgzGlhdj1XCB77qwZZF4GjlAYNDo1
         ptIGHUd0+4/2MERuXx1yRffk43/RT1lu7TbK39hfwmvKH8e2iPXdceA6zv9ZBr6OMJK5
         rMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=rHD/whiqFE3Hq0wwDVlNLenlkPX+hs4PoXvWiBjNChY=;
        b=UjueAyBetwlWlNVG4RpwH8bxWwG+S8Zp6mxRWVHECOQFURp6SKIc0dBfSDRWU6CBFP
         UuPF+WLcBdwDK0JmRoj/wkfd2AZCotJ1jN7xfRW1Raxd24J9XA+NK+y0QGAn0jqIbCt4
         XPCVBgFdSJgXo5OuWPM5/5vgQvJMYOF4M/EcTzjh8+M8Wy/rCk5e0ycvrIoMxg/Mri94
         eUpz5nlEztHhp5v0qKJhKfCBUAPRTIIa04TbhwusqmqD+m2C1NEH2itg62nVywlowp7Y
         ppka1pq5OTk0okIjcNoZplIuK5BsX/PGXs8taRkHrQm0MK/Nafb2LCFQMGLb5IeT/9hv
         vJCw==
X-Gm-Message-State: AE9vXwNdMia+lL4BFrZa9crHIJ0Ux1wpNMRmGfR0NFCBbqwdTgavqg/5DpB42rMJDQ6KSA==
X-Received: by 10.194.143.104 with SMTP id sd8mr11517239wjb.161.1474744214824;
        Sat, 24 Sep 2016 12:10:14 -0700 (PDT)
Received: from [192.168.1.26] (epq151.neoplus.adsl.tpnet.pl. [83.20.58.151])
        by smtp.googlemail.com with ESMTPSA id c134sm2359372wme.5.2016.09.24.12.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Sep 2016 12:10:13 -0700 (PDT)
Subject: Re: [RFC/PATCH 0/6] Add --format to tag verification
To:     Stefan Beller <sbeller@google.com>,
        Santiago Torres <santiago@nyu.edu>
References: <20160922185317.349-1-santiago@nyu.edu>
 <CAGZ79kZ+eETHm2xuorRqP9OPKdETZSOuuY+SWPR_=J6MwJedRg@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>, walters@verbum.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <9ec55b69-ddd7-ebee-96e3-120422578592@gmail.com>
Date:   Sat, 24 Sep 2016 21:09:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZ+eETHm2xuorRqP9OPKdETZSOuuY+SWPR_=J6MwJedRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 22.09.2016 o 21:01, Stefan Beller pisze:
> On Thu, Sep 22, 2016 at 11:53 AM,  <santiago@nyu.edu> wrote:
> 
>>
>> P.S. Gmane seems to be broken for git after it was rebooted. Should we ping
>> them about it?
> 
> I think most of the git developers have moved on and reference emails by
> message id. An archive of all messages of the mailing list is found at
> 
>     public-inbox.org/git/
> 
> (You can git-clone it to have a distributed copy of the whole archive)
> 
>     public-inbox.org/git/<message-id>/
>     public-inbox.org/git/<message-id>/raw
> 
> is a good point to link to.
> 
> However, feel free to ping gmane. :)

Two relevant articles are the following:
 [1]: https://lwn.net/Articles/695695/
 [2]: https://lwn.net/Articles/699704/

In short: Gmane creator and maintainer wanted to retire from being
maintainer[1] because of DDoS attack against its web interface, so he
stopped supporting wen interface (NNTP continues working). Thus
public-inbox.org was created (or just advertised more). Later
Gmane got new maintainer[2], but without code for web interface
(I don't know why it is).

So there is hope that Gmane web interface would be up some time in
the future; in meantime one can use public-inbox URLs.

HTH,
-- 
Jakub Narębski 



