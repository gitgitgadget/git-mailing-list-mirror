Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D64E1F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 19:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJHCzK (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 22:55:10 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:53560 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeJHCzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 22:55:09 -0400
Received: by mail-wm1-f44.google.com with SMTP id y11-v6so3196272wma.3
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=J4714gu2AgE+DT3F0w01svn1H3Yc9x5ofLB6iItsCGQ=;
        b=H++iQzBhWsznk3cvontreK6NEuGJjr3BluIKdY5YD2l2jKjrQKrX8mfXJrgp/cF+D2
         yZckOJ684vbuKDwjpzF9hb5SCUx93+PduM1mWK1eV7R535kkjkW+SexDXquyUqInkzSc
         yIypqZRZhNXD1P1ztWOVxFDWynNkMCtgD9DwRYq79pSXtrYQV6Z1Yx6i4EXKNRBjk45s
         silfaBaeTmga3rQUjEeOipiJxCWbsjELvBTZmb0+xEpwTAnGf7Q7GE6e0jtMku/PSLQr
         S3ctZUkeaC3OYgvhKLsVRswdOh1Mfgulx1ANKYEbzjYPlnOx61Ar6JQIezHLpbOhF37f
         f99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=J4714gu2AgE+DT3F0w01svn1H3Yc9x5ofLB6iItsCGQ=;
        b=YyiqPSLhYvWLUIKFVeBqPeqoOhyaUTvNavrdB02obRkcRs8fDK/ueJh6eNU+IL0lf9
         I024Ihb7zTbmuWSRCja1jZQI5v7mBT+jhnEplxo+q8iEviwcOy2LLEIk1Tn0u35+zowL
         KFlCsdtfqm3xasIkOVAYeBJlwFtqbIUfYws0O2JFfhGdBhAipvESMeERrLrexlUjNVZH
         kL05eAzXzFGPtSRPp5X1Hiti94z1JDYxxZxUrK8say7MhGD3CCxqLwD0b3NHYVqMqojt
         7OGVKn4VGAMdaG4svQiYbUJTu9PpO+W52jwRZpXQoTMMGgEYdwqfesVvmxvUK9iFP97d
         wT1Q==
X-Gm-Message-State: ABuFfoimgFUa6ZUJEJSSzt27gcT/jLRn7bIvedX0j+rI8gX+JA0MGA3y
        uQx7oKnjyRw1Drr0RnvXuBw=
X-Google-Smtp-Source: ACcGV62AHqk8NbWHRwv/ZTzwYbSPi9OGQQixEaQ0BoY/9XMmPVK9frrhebNxq8IxUpTea+iysBH38w==
X-Received: by 2002:a1c:824b:: with SMTP id e72-v6mr3168916wmd.92.1538941606623;
        Sun, 07 Oct 2018 12:46:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d16-v6sm9477441wru.88.2018.10.07.12.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 12:46:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
        Steven Grimm <koreth@midwinter.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's so special about objects/17/ ?
References: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
        <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
        <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
        <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
        <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
        <87k1mta9x5.fsf@evledraar.gmail.com>
Date:   Mon, 08 Oct 2018 04:46:43 +0900
In-Reply-To: <87k1mta9x5.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 07 Oct 2018 20:28:22 +0200")
Message-ID: <xmqqpnwltu8s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> 1. We still have this check of objects/17/ in builtin/gc.c today. Why
>    objects/17/ and not e.g. objects/00/ to go with other 000* magic such
>    as the 0000000000000000000000000000000000000000 SHA-1?d  Statistically
>    it doesn't matter, but 17 seems like an odd thing to pick at random
>    out of 00..ff, does it have any significance?

There is no "other 000* magic such as ...". There is only one 0{40}
magic and that one must be memorable and explainable.

The 1/256 sample can be any one among 256.  Just like the date
string on the first line of the output to be used as the /etc/magic
signature by format-patch, it was an arbitrary choice, rather than a
random choice, and unlike 0{40} this does not have to be memorable
by general public and I do not have to explain the choice to the
general public ;-)

> 2. It seems overly paranoid to be checking that the files in
>   .git/objects/17/ look like a SHA-1.

There is no other reason than futureproofing.  We were paying cost
to open and scan the directory anyway, and checking that we only
count the loose object files was (and still is) a sensible thing to
do to allow us not even worry about the other kind of things we
might end up creating there.
