Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DAD120248
	for <e@80x24.org>; Fri, 12 Apr 2019 02:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDLCc3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 22:32:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33177 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfDLCc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 22:32:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so9915528wrp.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 19:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bFzsJapnKGQWuOeFqXjcCjwPetdozVS2NgAxZT9Ag0o=;
        b=HnZtg5v39JoxuuS8QarMnaMIsclD3+oPdaDk53++H7afj6vjxv0SWoMxeN+T/ZnEGV
         H71bZ2BMx0C0UZKq59olkbVy57yJ6zlcNaX2bM2numtDjJMHihJmj1aAWTXgsFudPigd
         /IsLzILW6NXkkgQkBK9jbZI/an4+/CIWBXs/lLpG2Kh+T0m7m5u34XLpCnTixk7I0wcz
         Cru6Pc1QgqjkrE9eBaGjkX1AKJ0MR8jnoUU7dEy4seoppv8NBJjArtjQCIGa/BpuHJgV
         IJy6DeFC/pRCeqMkmwf4y6+OgOWV3CaMs9bRj8SyQl2OClVFgRzhzghpYPhZEmZv+dkY
         yZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bFzsJapnKGQWuOeFqXjcCjwPetdozVS2NgAxZT9Ag0o=;
        b=UDtaBrlD2YyeR3Tizmx8B7DZelwG7gOYtxeXcMPfxVhPX/BDcn1U1dcBjNg5AeWMNp
         o8Zv71v6KGTVJqzaQti4M8R2VuIHdNOil2lMSVUJt2Mx15fpUvwSErjkp6zDLPyjxvc6
         bU4SqPgoE+6rScXowSHHKluD24lOEYRh5HHwVr8/NTrl0+xGe+ljcuOJ2FS2qHlkaeGQ
         lL5J0BbMrJWHLh7ZzMddVD5p76LD7acBEYgUCe23oi6orzGXwpjEHkrZgvw2GG7yb2h/
         xtkW/fI+cQMI9YZ0A1ySpKyMsXvDajRK/8U6V3rBJNeDSEmdX4S2v42hVobC2Sm3SCSJ
         sopQ==
X-Gm-Message-State: APjAAAUj0KkwPkx8jxrc9NqndSXBFlpkhcqkOYC5jUD7ZLUCPBfJUDiu
        UVF11VPr7XgyUNbd61/8PN0=
X-Google-Smtp-Source: APXvYqxLEsqtn1lhqx8J1B5AyEPj39Mfq+7jrRoj61GBcIDCY/WbgzqgUOHtstcdEw9Xi4G2hXdy5g==
X-Received: by 2002:adf:dc4a:: with SMTP id m10mr32825737wrj.0.1555036346834;
        Thu, 11 Apr 2019 19:32:26 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id h2sm61087721wro.11.2019.04.11.19.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 19:32:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?B=C3=A1rbara?= de Castro Fernandes 
        <barbara.fernandes@usp.br>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git <git@vger.kernel.org>
Subject: Re: Feature request: Add --no-edit to git tag command
References: <CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com>
        <20190404015744.GF4409@sigill.intra.peff.net>
        <20190404032606.GA39148@Taylors-MBP.hsd1.wa.comcast.net>
        <20190404120613.GB22324@sigill.intra.peff.net>
        <CAHd499CUCoShsQHYZotFqprfDUf_owg_Urbt29fkNRV6LhFc3Q@mail.gmail.com>
        <20190405222100.GA10787@sigill.intra.peff.net>
        <CAJ+V80pY0L7onX600dmSaMuFFnH5n52-3CmnRyDKr-7ZkZ92mA@mail.gmail.com>
        <20190411182903.GA32528@sigill.intra.peff.net>
Date:   Fri, 12 Apr 2019 11:32:25 +0900
In-Reply-To: <20190411182903.GA32528@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 11 Apr 2019 14:29:03 -0400")
Message-ID: <xmqqr2a8ymva.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Apr 11, 2019 at 03:20:52PM -0300, Bárbara de Castro Fernandes wrote:
>
>> This new proposed --amend option, although semantically different,
>> would have a very similar functionality to the already existing -f
>> option. So should we, perhaps, change -f's behavior to treat the tag
>> as a new one, treating the old one as if it never existed (as I think
>> Junio was saying)? By this I mean the command should fail if the user
>> doesn't give a SHA-1 and the previous message wouldn't be preloaded.
>> --amend, on the other hand, would give the user an opportunity to
>> revise the tag by opening, by default, the editor with the
>> pre-existing message unless given the '--no-edit' option, and if not
>> given a SHA-1 it would keep on using the previous one.
>
> Yes, that's what I'd expect it to do (so yes, it's also different from
> "-f" in that it defaults to the existing tag destination instead of
> HEAD).

Do you mean you'd expect "--amend" to do that, which is different
from what "-f" does, so they should not be conflated into one?

If so, I think that makes sense and changing the behaviour of "-f"
is too confusing.

