Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE3520954
	for <e@80x24.org>; Tue, 28 Nov 2017 16:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbdK1QC2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 11:02:28 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:45552 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbdK1QC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 11:02:27 -0500
Received: by mail-qt0-f174.google.com with SMTP id g10so397976qtj.12
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 08:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mRV9AsOP6L0cA+ddOgrCtAmDOc1lAQDZBKWpMsuSJnk=;
        b=eQcMeD79qPhRHahGO/5l5enesmYpd0FDe/w2hO6CjrEnEaW4rJ/A7lgjWgouTD8ECx
         +qbWhHH+XiNWoGx0vUCjLXgeuqr6fi6EDfUu+ud7CqIO/FAOEW1Kb9h+UZrldyI66aLF
         Qjx7WhkF6tdwwYHwKEad6AyYF/oJDRIKMk9By7zfmlY0SHeVrjiDhOn8aFI8BiRkKf5+
         1xdgHq/5C9dfyoXA3cuRJrk3wba9cnFCMOZsAFigJEEe3SSRhzm166pDkz4xqb4qw2MQ
         m/lk8MfRyv9NavScId82X12XPKqWtvBjCDttU3UBgX8MRNgyxyrYyXrG5cRfdjggDjVU
         kC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mRV9AsOP6L0cA+ddOgrCtAmDOc1lAQDZBKWpMsuSJnk=;
        b=uW9OjOFYPK3zfCBb/E/sMdBFb/RIR5tJvAFIYnqLQexVvtpCRvFoxWPD0rGAfETJWu
         +hJ4fNANxQbZyZ+J1GbGcSDJnb96AxmPUT87k8bSEnFCFZMXSq9HdKSOurGS8xmXpHS/
         igGScw5Zpp7K3G+u1lmYhY/OiqZEvsxjZlCHpIPs/3D8dA2wqV9jJjEkgxXnHRtC2OyQ
         oGiitzKjKvqg4TzXl6tDqPdm2SQIPD98s8rASKsvikMhazasiZLRtInR+RAu5TOKt6V0
         QHqyV/4RRPYeUTaQsxL0oxl3JXB25dbpusBktL4LAmvgMpnFIJX4k/K3uCbeOPrUvbhi
         3Utg==
X-Gm-Message-State: AJaThX4SMSpB8twdSQczjJXIv33Vw3ZVR4Ehx09eZ/8tT9+yJVygmv+H
        B/bCrzuA7k/w1MpEPVdZfgw=
X-Google-Smtp-Source: AGs4zMa7901XyjqQVWjow7PDolNXBC8usmd1nCI0XyFbM16dxzXTMatMDs6hWelHTCoB9ycQiZoV9Q==
X-Received: by 10.200.50.39 with SMTP id x36mr71768271qta.255.1511884946574;
        Tue, 28 Nov 2017 08:02:26 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id e16sm22363350qtk.64.2017.11.28.08.02.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Nov 2017 08:02:25 -0800 (PST)
Date:   Tue, 28 Nov 2017 11:02:22 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] travis-ci: avoid new tcl/tk build requirement
Message-ID: <20171128160222.GO3693@zaya.teonanacatl.net>
References: <xmqqlgir6mwk.fsf@gitster.mtv.corp.google.com>
 <20171128143718.3748-1-tmz@pobox.com>
 <CAP8UFD1Y_7FcARFoqNKTpDLRxKW1+jCBGAy5+TxL33ui0Hyb8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAP8UFD1Y_7FcARFoqNKTpDLRxKW1+jCBGAy5+TxL33ui0Hyb8w@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder wrote:
>> Junio C Hamano wrote:
>>> It seems that TravisCI objects ;-)
>>>
>>>    https://travis-ci.org/git/git/jobs/307745929
>>
>> Interesting that the main builds passed.  I don't know what the default
>> 64-bit linuxinstall looks like in travis, so I presume it includes
>> tcl/tk or something.
>
> Yeah, interesting. I am cc'ing Lars who perhaps knows.

I pulled the travis docker image used in clang/gcc builds[1] and can
see it has both tcl and tk packages installed.  The linux32 builds use
a docker image[2] which does not contain tcl or tk.

[1] travisci/ci-garnet:packer-1503972846
[2] daald/ubuntu32:xenial

If we wanted, we could set BYPASS_TCLTK_CHECK only for the linux32
builds.  I think it's probably better to do it globally rather than
rely on the travis containers implicitly having tcl/tk installed.

> The patch looks good to me. Thanks!
>
> I wonder if it would be better to squash it into my patch or to keep
> it separate. I am ok with both ways.

I fine either way too.  This is still just on pu, so squashing it in
seems like the way to go.  I only made it separate to cause travis to
run the tests. :)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In the beginning the Universe was created. This has made a lot of
people very angry and has been widely regarded as a bad move.
    -- Douglas Adams

