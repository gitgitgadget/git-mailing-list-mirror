Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80F4220248
	for <e@80x24.org>; Mon,  1 Apr 2019 17:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbfDARxf (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 13:53:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33021 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732441AbfDARZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 13:25:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so474325wmi.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=khkkXUxvvWDXullYvHHIp8scBY48xLAmojO62JJj8jg=;
        b=m3uKXp1BM/9qZl1lpjA100/dEviY7hEoevVV6q+72Llk5n0fk6k+DW1nN1OeLNyvAB
         y3gvIPJ591JD38Yih/H7vUJ1cmF4A99zVpJSSNNhYRUqMJ4uavMe4bwGt8S379yvtvUE
         pgN9GH1brT0xo5RdmNhrLU2447icTniVYDNvmZSYJ15OktN6SOrR0uRuwo0foV3VuMG6
         hTh+5WA7YvZX3jt05r6XZ68BhjsbWg4XPqPYTEZekej+K46t5Rf197DMyymBeEZB2V9s
         plc3wRDZ2IW5gSwEmxMVSNOXUFjAvTMkox/+bpGJjXyPHzWX1zCn++gh++zB6sqaftGF
         h5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=khkkXUxvvWDXullYvHHIp8scBY48xLAmojO62JJj8jg=;
        b=Roz012zCNtDzXVC2u5LSlR16Vb3qUgNwzKwdr8YATOw7Y4FtxUY6h2/ruHrUejcx9A
         ph/A/dIR5gnUOMZaA/ecxhwpZdzNn2Yd5XiEkryRdgrDHgeJ6bqj3r2fT8E72ik4f9Ut
         ub5cGQYqRKfQT0KA31/ydHK2spAx0F5WhUpOBYu7k02w2AdovqKNwjy9olE6cljp2n9Y
         v5kEmuSvyStZniJtCGprUp+OtQm5uJ+oZOdFhGtIlzQLRYJcfqXvnP4mhENOjNkWStoR
         lWNH+NLvC2wPhhjUCv6rSf8y8eS+02EbiWIN6HfbXMab75TV+u/CW04/aVJFS+y1MqHh
         9qjA==
X-Gm-Message-State: APjAAAXRdBCTfYJ+Q/Riexswci3yFoBYsS0qT2VI8h/x1GmM0UOZ0IAV
        QBZ6bX3pLc0PTYo7Jwfkbi8=
X-Google-Smtp-Source: APXvYqxJy5h7lZNjHb1pySGucCTBSdOfe9kaw7S/T/2SjUQT1rkD3WSSo8htF50g6nwHmusipO3Q4w==
X-Received: by 2002:a7b:c5ce:: with SMTP id n14mr517204wmk.18.1554139540510;
        Mon, 01 Apr 2019 10:25:40 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id s21sm12573314wmh.22.2019.04.01.10.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 10:25:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v3 05/11] promisor-remote: use repository_format_partial_clone
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
        <20190312132959.11764-6-chriscool@tuxfamily.org>
        <xmqqftrre6p1.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD1K=n1CriNSY75MyBG7ZDYUQRq3LcEMrxTJVcyhQgyJrg@mail.gmail.com>
Date:   Tue, 02 Apr 2019 02:25:37 +0900
In-Reply-To: <CAP8UFD1K=n1CriNSY75MyBG7ZDYUQRq3LcEMrxTJVcyhQgyJrg@mail.gmail.com>
        (Christian Couder's message of "Mon, 1 Apr 2019 18:42:19 +0200")
Message-ID: <xmqqbm1pvdri.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Mar 13, 2019 at 5:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > A remote specified using the extensions.partialClone config
>> > option should be considered a promisor remote too.
>> >
>> > This remote should be at the end of the promisor remote list,
>> > so that it is used only if objects have not been found in other
>> > remotes.
>>
>> That's a declaration, not a rationale, and does not answer "Why
>> should the origin be only used as the last resort?".
>
> I have added the following explanation:
>
>     If we are using promisor remotes other than the origin, it is
>     because these other promisor remotes are likely to be better
>     for some reason (maybe they are closer or faster for some kind
>     of objects) than the origin, so it's logical that we try to use
>     them first.

Alternatively, perhaps you cloned from the origin repository which
is a mirror that is not as reliable as the real thing but is faster
to access when it _is_ up, and you added the true source that
'origin' mirrors from as the fallback, as it should only be used
when 'origin' is down.

So what you wrote is not a convincing explanation why we should
treat the origin as the fallback.

Writing in the end-user documentation something like "because the
'origin' remote is treated as the last resort fallback repository,
after consulting other promisor remotes first and failing to obtain
needed objects, you may want to use repositories with better
availability listed as 'other promisor remotes' and set the worst
connected remote as 'origin'" may be a valid thing to do, though.

I do not like to see the tool making such a policy decision for
users very much, but at least by honestly documenting, we explain
what we unilaterally decide to do without having a strong
justification (i.e. we could decide the other way and the decision
would be equally valid, and because there is no single best choice,
we arbitrarily picked one) to the users, and with that, they can
adjust their use case to what the tool does to take advantage of the
tool's design decision.
