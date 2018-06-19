Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 245671F403
	for <e@80x24.org>; Tue, 19 Jun 2018 19:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030410AbeFSTAY (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 15:00:24 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:41141 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030283AbeFSTAX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 15:00:23 -0400
Received: by mail-qt0-f169.google.com with SMTP id y20-v6so749965qto.8
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8QdUCl9REcdQ44ak6JWKPkI56hzel1C1qpZrDUki0/M=;
        b=rs3bIXf/BUP2Cf5FpWlKEDaMgNB3xG0U5O4evJA/tkLLIi2v0Yfgp80dksG8IU+T4v
         wgjutmM6691ZHY8g/97DOUhAVk70AnZFiGty30G6/KbhC+IfMTJWmbpacsndbWEnpIuv
         8NqWyV6stziJejn1khBvGDi9zWyGgHjWaJZaKmSByK9ts397GIMcjxzP5TtS4o/45enx
         cLlJrDWslTiZy+kI9FYw52FjOrrSSLUTOsZMYdrqC9NmXoznqVqWc/OL3+RUILuUBw1X
         vB8LQrJNLQSdXkjS8VC7f2OT20ijtdaW5QWfcWEPRITsBDUGTl5wU1PyjGFufpQV3Atn
         skRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8QdUCl9REcdQ44ak6JWKPkI56hzel1C1qpZrDUki0/M=;
        b=Kw9XQR+1msUT5m+ZP815/lhyiUVBrkE+L4ucN3QErQiFoawoRAJixpIc999n0zUzgK
         J86Mq7Xvs3HXzzGiEryXx1chZ0V7O9TJQaapQIvgIfE3vlUR1zl46tYcsyzPdMClGxtS
         rURN3QAzeaMbaLZ0CWjNtGaXsSkCPiLpz4dpgoPG4ocFR4vzcej2UnRC98jTQdhSVuM/
         izFxGf11/gWEP16E8fheWv+oggw993wkYllxMTcEp3IDrnWdEbbqmkoZ0Y3KMmfWdGWH
         BhDof7zN3bUxPHHXT5Fecybl2Fd4/amtjYfphaUqTrLNbvtP5zSSR9Zjin+3Tux3QlVE
         01fA==
X-Gm-Message-State: APt69E1zH/P7K0gvseUJvNzO1qT9vrlwSPR5JlfthNMIpHtpVakAqyWU
        1dip3uuiABRZpmRq27kD5itiAja1
X-Google-Smtp-Source: ADUXVKIeiVOGmYJ9ol7D/Z3AsTOTBayfai6z9kzjCL0rgoZYF2XJCW7y3fAFSHUXBlZgIiuUZvlJ2Q==
X-Received: by 2002:a0c:e987:: with SMTP id z7-v6mr15504768qvn.202.1529434822092;
        Tue, 19 Jun 2018 12:00:22 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id s12-v6sm347377qkl.65.2018.06.19.12.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:00:21 -0700 (PDT)
Subject: Re: [PATCH 00/15] Kill the_index part 1, expose it
To:     Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180616054157.32433-1-pclouds@gmail.com>
 <CABPp-BG1n4u78JScxrnUc1gecXFjKbwLWMxKKs+ZO17DdH3zvg@mail.gmail.com>
 <CACsJy8Bib-CFxUs5YBzcgo7LPDospdgSAn+-asCf-YrYnUxqXA@mail.gmail.com>
 <20180618184111.GC73085@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c030f0d3-9b24-9751-b600-50463b7721fb@gmail.com>
Date:   Tue, 19 Jun 2018 15:00:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618184111.GC73085@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/18/2018 2:41 PM, Brandon Williams wrote:
> On 06/17, Duy Nguyen wrote:
>> On Sun, Jun 17, 2018 at 9:02 AM Elijah Newren <newren@gmail.com> wrote:
>>>
>>> On Fri, Jun 15, 2018 at 10:41 PM, Nguyễn Thái Ngọc Duy
>>> <pclouds@gmail.com> wrote:
>>>> This is the beginning of the end of the_index. The problem with
>>>> the_index is it lets library code anywhere access it freely. This is
>>>> not good because from high level you may not realize that the_index is
>>>> being used while you don't want to touch index at all, or you want to
>>>> use a different index instead.
>>>>
>>>> This is a long series, 86 patches [1], so I'm going to split and
>>>> submit it in 15-20 patches at a time. The first two parts are trivial
>>>> though and could be safely fast tracked if needed.
>>>
>>> You post this small little patch about unpack-trees.c, mentioning you
>>> don't know if it's even correct, and bait me into reviewing it and
>>> then spring on me that it's actually nearly 100 patches that need
>>> review...   Very sneaky.  ;-)
>>
>> To be fair, it's all Brandon's fault. If he didn't kick the_index out
>> of dir.c, it would not conflict with one of my out-of-tree patches in
>> unpack-trees.c, catch my attention and make me go down this rabbit
>> hole :D
> 
> Haha well this is something I've wanted to do for over a year now, glad
> you've decided to run with it :)
> 
> I guess I've gotten pretty good at getting people to go down rabbit
> holes.  First Stefan with the object store refactoring and now you with
> the index stuff.  All because I wanted git to be more object oriented
> and have less global state ;)
> 

Let me join the chorus of voices excited to see someone finally taking 
the plunge to do this!  I'm very happy about seeing this taken through 
to "the end of the_index."
