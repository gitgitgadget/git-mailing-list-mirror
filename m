Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A941C1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 16:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeINVfL (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 17:35:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39105 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeINVfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 17:35:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so4534872pff.6
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+IZoSK8S+ADzhBJMMsyIsKNzfotS3PkMDZEBNyZxYqg=;
        b=LldnoX4sboKQdXhvFBNFLAzY3wNfg25OwvyNeQfgldpLA8CO0ZkfYetlz7SwQd2Y3I
         U/f8hOr6HGTmnMcIQZA76AGp7q0jp8P73Uzk4FxvPqI4eXa8CYm3NDjn/ug993fTsMwg
         vAVsVQ95fJARKvVjaeXnXwngCsfT9zCq28k4WfCkeIvKNl0qwo0V/M1CiHVUK/GQj3R1
         o3YWWZS2o3c4bPqLDacxrh6DXpP9H2I98KQAdxX5tQo+UDEI7FqXWxW3a5EOV1TgTJuB
         xI2kfC2emusrrlUb38uvXP/UrSBgQDW77Rcr+/DFEAeZAsa3cZTsAVgQxlJrT+VYvMiY
         4v+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+IZoSK8S+ADzhBJMMsyIsKNzfotS3PkMDZEBNyZxYqg=;
        b=MFGXeGoKjI1YD+FUnL/WBuX6EmvUusYK3TjtkF0z55jX4aJfnEckyr9sMwkzOndRxl
         vYWgG664/ldocWXmZZpynmMUF+Snw5apByATnSJIQOoKcz4Cdft6GO9rEeSth7M7aRdu
         /Pszc2R62wq/kEEVfOW5OnqO2FltufJDu9gdLv7s4DTeVZtE3Bs+V5OJYTHAiwbx3BzY
         ZBmvjkz9eB00Wg0rP54jTjGJ1ydMk1CTT1OkABdjRnkgNVBHrPVUcp+ECq7XDondtkn2
         T97m0lt52u2OddGmQA5Q0Gh2VXh4IajefNJN+qi68qUWHYkj6ZDDj/DP+Ukh/4gzbwfO
         Ek1w==
X-Gm-Message-State: APzg51CClcvb6+/QlPHYMA5pEIhPLz4WU08Ojys4svYfN73yP+n68WzC
        oXLIFcCiVGQh4phDMCuuIj8=
X-Google-Smtp-Source: ANB0VdYtHqV5U0VgPpX95T1w9bKFcCShX6fsShOZGTu1g8J88OVVrY9N8yRCw7iENvNij4mC/KIYuw==
X-Received: by 2002:a63:1823:: with SMTP id y35-v6mr12608553pgl.438.1536941999719;
        Fri, 14 Sep 2018 09:19:59 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 9-v6sm14029915pfc.20.2018.09.14.09.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 09:19:58 -0700 (PDT)
Date:   Fri, 14 Sep 2018 09:19:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Josh Steadmon <steadmon@google.com>, git <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bmwill@google.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH 2/3] archive: implement protocol v2 archive command
Message-ID: <20180914161956.GA133420@aiede.svl.corp.google.com>
References: <20180912053519.31085-1-steadmon@google.com>
 <20180912053519.31085-3-steadmon@google.com>
 <CAGZ79kZOTsUH=zQX3rLXvuSOx1vp8C98maSn47ssfca8c-BrBQ@mail.gmail.com>
 <87k1npkzh5.fsf@evledraar.gmail.com>
 <20180914060552.GD219147@aiede.svl.corp.google.com>
 <xmqq4lesdpk4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lesdpk4.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> I think though that instead of doing setlocale() it would be better to
>>> pass some flag saying we're operating in a machine-readable mode, and
>>> then we'd (as part of the protocol defintion) say we're going to emit
>>> GIT_ERR_UPLOAD_ARCHIVE_EXPECTED_DELIM_PACKET or whatever.
>>
>> I think you're suggesting client-side message generation, and that is
>> one way to handle internationalization of server output.
>>
>> The main downside is when the server really does want to provide a
>> custom error message.  For that, we'd need
>>
>>  1. To propagate LANG to the server, so it knows what human language
>>     to generate messages in.
>>
>>  2. On the server side, to produce messages in that language if
>>     available, with an appropriate fallback if not.
>
> That is one way to do so, but it does not have to be the only way, I
> would think.  You can send a machine parsable message in pieces, and
> assemble the parts of speech into a message at the receiving end.
> Like sending a msgid to identify an entry in the .pot file, and
> values to be filled in.

That works if the same party controls the client and server and the
client is up to date enough to know about every message the server
would want to send.

It doesn't work for
- hooks
- alternate server implementations
- messages involved in an emergency fix
- ... etc ...

Don't get me wrong: for messages with a machine as an audience, error
codes or similar structured errors are a great way to go, and getting
client-side generation of messages for humans (not to mention styling,
etc) are a nice bonus there.  I stand by what's in the message you're
replying to, though: if we actually want to be able to consistently
provide useful messages to people who do not like to read English,
then client-side generation won't get us all the way there.

Jonathan
