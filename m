Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058211F404
	for <e@80x24.org>; Fri, 23 Feb 2018 21:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeBWVsd (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 16:48:33 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:34628 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbeBWVsd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 16:48:33 -0500
Received: by mail-yw0-f178.google.com with SMTP id c193so3285514ywb.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 13:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N8Aut3t3rUZpt3RLteEiLPNjn3Dl4q7O0NRHuObiUPc=;
        b=Jut1iYdTi0c71JMXZ+shJf0VyvssNupYr5b46dlyHEamwkb5YqHLOPF1d+/KzJA3OL
         oQVP9RIImgfH+thr7sofeAUcczOZOLP/5zYs/T/UdzxOSCvnCQvpTn53wGFqGXdc3yOw
         Xcso3cgpVn9rcrMYWKT3CINhjp6IRbCZiZcwFVT8rCay9FcTPDu+QbXAUq5U49a5QCTE
         +uPzWsHdIwNFQzypC+BRHzZf5esJTjnEdDT/fWaqKphwypmv5G+9PqgwfAU7zsRUBlxL
         es926GSlci/W1nxEuly8U9HxeBAL6OjC+P6tbHb3ywT/O1fn+Ka4umuGqcRhYWG2qHzB
         mzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N8Aut3t3rUZpt3RLteEiLPNjn3Dl4q7O0NRHuObiUPc=;
        b=Lm0x9WGlPboC67vdTtrmJgZGTtwcgktzK+7PdpbpzH0CamwfP7dYpTGTmrscncAvsk
         i1+L/Ihc6ypcHBd+aBn3qKJ5A9ri1WsQasSusaHopkUmAAzeikBdCptvk0gh1nNwnZPc
         P8wdHWryKSTJxw1nuwvVTX8yETv0FqOEVMX21HRyxS3OEG7YD9HTGEHJMV91NVvcXbYO
         k6rVe2b2gUbbhs7VZzFIE1nTWeWC5nPgSnCYJxylq+pOPn0bveygd5AUs6w+hJOOPgRT
         INIa89IVkA3ls9lyCMIqgTknerEtw02lN5BgPpG7JDQrZuUUM/G2DpXpo+qypjk0ni8+
         No3A==
X-Gm-Message-State: APf1xPABMFoxvJwrvqwnOzdy2PLBS1O/bD+AERuFpCqkILNPK0mHbMvI
        HUAuN2racqn6/yd/kvKJAPmVfv5wko3h9Kf7KEr71Q==
X-Google-Smtp-Source: AH8x227UKKg5v5KOzwLGtvkdp7OI6uW26roGsHNCQWzXAD/JASvc9+88HvfygZA6V+j5i4A3Un52X1GgDsUwUHBApKY=
X-Received: by 10.129.169.202 with SMTP id g193mr2165178ywh.500.1519422512101;
 Fri, 23 Feb 2018 13:48:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Fri, 23 Feb 2018 13:48:31
 -0800 (PST)
In-Reply-To: <20180223213000.GD234838@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-8-bmwill@google.com> <CAGZ79kbnioP+12xa2qfaYLyzdeCH8hh2Ri0xHD7rNciJiTYxmg@mail.gmail.com>
 <20180223213000.GD234838@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Feb 2018 13:48:31 -0800
Message-ID: <CAGZ79kbh0q8=N07yc+gGnLjggco_+H4YiYAiNOXR3yvO6QX6uw@mail.gmail.com>
Subject: Re: [PATCH v3 07/35] connect: convert get_remote_heads to use struct packet_reader
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 1:30 PM, Brandon Williams <bmwill@google.com> wrote:
> On 02/22, Stefan Beller wrote:
>> > +static enum protocol_version discover_version(struct packet_reader *reader)
>> > +{
>> ...
>> > +
>> > +       /* Maybe process capabilities here, at least for v2 */
>> > +       switch (version) {
>> > +       case protocol_v1:
>> > +               /* Read the peeked version line */
>> > +               packet_reader_read(reader);
>> > +               break;
>> > +       case protocol_v0:
>> > +               break;
>> > +       case protocol_unknown_version:
>> > +               die("unknown protocol version: '%s'\n", reader->line);
>>
>> The following patches introduce more of the switch(version) cases.
>> And there it actually is a
>>     BUG("protocol version unknown? should have been set in discover_version")
>> but here it is a mere
>>   die (_("The server uses a different protocol version than we can
>> speak: %s\n"),
>>       reader->line);
>> so I would think here it is reasonable to add _(translation).
>
> This should be a BUG as it shouldn't ever be unknown at this point.  And
> I'll also drop that comment.

Huh?
Then I miss-understood the flow of code. When the server announces its
answer is version 42, but the client cannot handle it, which die call is
responsible for reporting it to the user?
(That is technically a BUG on the server side, as we probably never
asked for v42, so I would not want to print BUG locally at the client?)
