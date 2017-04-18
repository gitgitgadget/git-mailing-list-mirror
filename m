Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1D541FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 16:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757474AbdDRQOq (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 12:14:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36029 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbdDRQOo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 12:14:44 -0400
Received: by mail-wr0-f196.google.com with SMTP id o21so25532883wrb.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=7Aky2os3lI426ZSvTalrbgS16t4Iqw1TpQ2Dv1MH3NI=;
        b=Jvu8bpV2ul0rHAKHgCQ1ysTml0l+hx35xpeWuVUKz3lC4YPtUJAkVjjK2sWeho3YI4
         GsCedQspw1iQpHcP0MrxAxMsesQsyX0dL5Q2h1EUlqHgPHtef3hssY2lpCH/+cUfIlmo
         yidRY0VLautmtDoOGkwG28d1bkhBTftEpWi6CWj6+uaMj3BQZSqkv8Rl+lkw5G2P1Okj
         Dlq+FbPsnvKhBh6KmeXg7BPrqUDohPN01I04lfY1+AA6s4YQOOHUDys40YXlqIY5inih
         Ww4E6F6oeqMuMrmDr3/dIRH5s3sP4JT4l6LG7tjCYd9C4z5tXUYr0o8IkSMLkxJvcDra
         P9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:in-reply-to:mime-version
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=7Aky2os3lI426ZSvTalrbgS16t4Iqw1TpQ2Dv1MH3NI=;
        b=OsRJXX2bqMl2leU+ko/92ko+qqHWomgvskkF+v5s/LdvymH/7Jq9m9ZEqNiPffyien
         kX7Y8+akSbU2OoRotKm/PH7K4oPYHmNuT0x3uUULNZNZz7BFbt1san7x/t2vq2GydJPm
         DKBtYy0seb5Bo0Lp2ud6OOHksiw3bnvux9C0fl6RTCZt2EK7FeS4+iZxpw0zG7pBP21+
         UHFdeGrFzyDUPh/mFId/iwQC+RRCx8f9QZ1wDAUzAMdbsqlJJ38XGi4NZxkLrKb5te40
         4v7T5uciLh/RUZntXM+89RP2KHeTVqYpGSRspPxNOZlHCZqrSsu1q/ivc+ToVsPuR2v5
         sRFw==
X-Gm-Message-State: AN3rC/5OzYyvLE24a1ByhPtcyZZUlLz9vbN5ND/f8B5+aTbP3caENVpz
        OxRxJaM55/lhuA==
X-Received: by 10.223.133.1 with SMTP id 1mr24621082wrh.43.1492532083101;
        Tue, 18 Apr 2017 09:14:43 -0700 (PDT)
Received: from [172.16.1.108] ([92.70.185.162])
        by smtp.gmail.com with ESMTPSA id s27sm17549271wra.25.2017.04.18.09.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2017 09:14:42 -0700 (PDT)
References: <20170409191107.20547-1-larsxschneider@gmail.com> <20170409191107.20547-5-larsxschneider@gmail.com> <20170412174610.GB49694@Ida>
In-Reply-To: <20170412174610.GB49694@Ida>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
        charset=us-ascii
Message-Id: <1D510C6F-A830-48BE-880B-62F4212F4A7F@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tboegi@web.de, e@80x24.org
X-Mailer: iPhone Mail (14E304)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 4/4] convert: add "status=delayed" to filter process protocol
Date:   Tue, 18 Apr 2017 18:14:36 +0200
To:     Taylor Blau <ttaylorr@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 12. Apr 2017, at 19:46, Taylor Blau <ttaylorr@github.com> wrote:
>=20
> I think this is a great approach and one that I'd be happy to implement in=
 LFS.
> The additional capability isn't too complex, so I think other similar filt=
ers to
> LFS shouldn't have a hard time implementing it either.
>=20
> I left a few comments, mostly expressing approval to the documentation cha=
nges.
> I'll leave the C review to someone more expert than me.
>=20
> +1 from me on the protocol changes.

Thanks!


>> +Delay
>> +^^^^^
>> +
>> +If the filter supports the "delay" capability, then Git can send the
>> +flag "delay-able" after the filter command and pathname.
>=20
> Nit: I think either way is fine, but `can_delay` will save us 1 byte per e=
ach
> new checkout entry.

1 byte is no convincing argument to me but since you are a native speaker I t=
rust your "can-delay" suggestion. I prefer dashes over underscores, though, f=
or consistency with the rest of the protocol.


>> +"delay-id", a number that identifies the blob, and a flush packet. The
>> +filter acknowledges this number with a "success" status and a flush
>> +packet.
>=20
> I mentioned this in another thread, but I'd prefer, if possible, that we u=
se the
> pathname as a unique identifier for referring back to a particular checkou=
t
> entry. I think adding an additional identifier adds unnecessary complicati=
on to
> the protocol and introduces a forced mapping on the filter side from id to=

> path.

I agree! I answered in the other thread. Let's keep the discussion there.


> Both Git and the filter are going to have to keep these paths in memory
> somewhere, be that in-process, or on disk. That being said, I can see pote=
ntial
> troubles with a large number of long paths that exceed the memory availabl=
e to
> Git or the filter when stored in a hashmap/set.
>=20
> On Git's side, I think trading that for some CPU time might make sense. If=
 Git
> were to SHA1 each path and store that in a hashmap, it would consume more C=
PU
> time, but less memory to store each path. Git and the filter could then ex=
change
> path names, and Git would simply SHA1 the pathname each time it needed to r=
efer
> back to memory associated with that entry in a hashmap.

I would be surprised if this would be necessary. If we filter delay 50,000 f=
iles (=3D a lot!) with a path length of 1000 characters (=3D very long!) the=
n we would use 50MB plus some hashmap data structures. Modern machines shoul=
d have enough RAM I would think...

Thanks,
Lars=
