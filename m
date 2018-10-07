Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 151001F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeJHDPy (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:15:54 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:34734 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJHDPy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:15:54 -0400
Received: by mail-wr1-f54.google.com with SMTP id z4-v6so18585953wrb.1
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/XkAhKWfMc9Dkvj50N+9sYvnq0dcSq6ZNbPNZI/Ehxo=;
        b=kJHzFSD/1mfTinoI9RAWgoiAB1SXlBGfMOVsza42sKhagA/eOP+b+v57JBe8b6FHBv
         0l+EoicIuhKCR1ktOcPteLSLBbxhCT0VbE1NX/SFA1DzUwvwcjZJBKrC2VtcU0mfuvPM
         CIZkjPqeWb0PV4qWwG9uFbJ9HOfRelfiB0xg6CVY9hXKI5V8n0M1FbwCdqjc0kIptPZ1
         dMuKEr/o7Oyr+/nFmIKALoamjQNrW4uEHj+xkNWC2QrTMabRv0nPXAcgUgtv+uhfM2Xg
         PSsJAKhDM88Pw6uV1UHHwxdRyy4RocVCs3AnFZIw4pL64UhGE/TZrCovMhG+G4mX1Vh0
         x3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/XkAhKWfMc9Dkvj50N+9sYvnq0dcSq6ZNbPNZI/Ehxo=;
        b=Q2poaq1p7OSZQRoS3rbvuHs27XOogcG9P7qvzQ7YJdUKjsX+uQImU1IKxuvJGXPNWN
         ZvVZ2ZQJEGWBITua5q1TU3c0uFkfS8qn9r13PQ0fXHw8dxB6MtgYipgM0PtOHCCyV5Az
         ja44fQfjEOt+cw6erVQLqvvsSsCg5t5f3ye4QuRbvweU6oKUrXhPGHxYNxR6rvPQN4jC
         MzEpa0bwppESJ5rTJ4olK7SC4ECsdCg+Ilg4a1Opy4bqiNCZSuC6U+9x7umlCNmpNSM9
         T56y1FY+uesg1g9tqBB5dDbwfkT0OUDWeQfnItBQ+C7qBxdP3mtsxBCNm4axW1gSg++F
         9xLA==
X-Gm-Message-State: ABuFfoj2/TbKSxYpgEERTigkIGxdOvjxaHZkNiBjic1TS9xfCW1fAUzn
        ikzZG2mDYSZUCggYPqqzcZI=
X-Google-Smtp-Source: ACcGV607I0D8Vh+O6bGY/mt/SK4mEEGYTizmF+xUO+wGgCvZOCRabIyAzz5rROxB39KbHor0efdOZw==
X-Received: by 2002:adf:9a84:: with SMTP id a4-v6mr13937199wrc.78.1538942848796;
        Sun, 07 Oct 2018 13:07:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t2-v6sm13361373wrr.7.2018.10.07.13.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 13:07:28 -0700 (PDT)
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
        <xmqqpnwltu8s.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 08 Oct 2018 05:07:27 +0900
In-Reply-To: <xmqqpnwltu8s.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 08 Oct 2018 04:46:43 +0900")
Message-ID: <xmqqlg79tta8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> 1. We still have this check of objects/17/ in builtin/gc.c today. Why
>>    objects/17/ and not e.g. objects/00/ to go with other 000* magic such
>>    as the 0000000000000000000000000000000000000000 SHA-1?d  Statistically
>>    it doesn't matter, but 17 seems like an odd thing to pick at random
>>    out of 00..ff, does it have any significance?
>
> ...
> by general public and I do not have to explain the choice to the
> general public ;-)

One thing that is more important than "why not 00 but 17?" to answer
is why a hardcoded number rather than a runtime random.  It is for
repeatability.

