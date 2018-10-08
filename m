Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E0BC1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 00:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeJHIDt (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 04:03:49 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:45638 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeJHIDt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 04:03:49 -0400
Received: by mail-wr1-f43.google.com with SMTP id q5-v6so18904774wrw.12
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 17:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=U+Xgcwg8gFaZc71P5i6PKa05IgFjeQEb+hPbqLN/D8g=;
        b=KNlTkv3b6VQSlZCKCERorhTKuksQbRtiC2QuMdHElH9ih+XbtLgDAtajWgFr9qEZhE
         mTrym3O4AQdf7NgAAoFCOiilkg8rfQ+FfklyUH8VTosrK9ZHiXLgvJ+xm4PahZY9s4R5
         +3/bIb8zr/tqs4F1IrryFEaokTI+YgAC9c8CWKbKBvDR9qC8StakHPJh1v3LXvNtJ5iC
         T7B0d+0LbgQZ5Y7MATeHbIWhfkpJLDRrKDrQEmZQ8NPdbxNXjjwkFNAdsMB80cSmwBKi
         2twwlDXObDNu4BFNbgEf6UF+H3gZJGomJvS3fkMxVFoBkqTnvCdFQYqixAvl6xJmZ1/T
         e6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=U+Xgcwg8gFaZc71P5i6PKa05IgFjeQEb+hPbqLN/D8g=;
        b=a5i5T1DGfHj4zjyP+sL0X3kdq6ux2X7wXgwdmOla5GeA1OGYgJMev9NukRF6CfoBKV
         iI9pjGazUlWbNM5X4r8DvwE9RNc8QAYWWqftkJmwHPezovMHbuyPyr7M7TWUZMMiesu4
         /GQp3BnRpNAdsXhxPQhaLNwd4IbvBE5LDmYHEFRF7Qqy2KtnHcxqgoZohDH4trLYPe7w
         kA4gJwlsJtpGRJV+bLe+sHMHmfREr34hj+V9L9d72WfQg3I7Hd/XkORCOmpQ78UkAyKE
         HDzFSJAXZUoCO97Gr86Vavr/VvTR+hxfSBIXjA6+nVQI/uGqx3OONTWVm5TkIm8bBafG
         TEpw==
X-Gm-Message-State: ABuFfoipnd8AlO0GivHPHy/fx61/M31Oa3Sbpq96ZO72SDTBf7DD1LPM
        MNddIlz2XryVW+VjPtyQSvX6s1uOE6o=
X-Google-Smtp-Source: ACcGV62C6keSHEMwhnchEyhLu/6/0Z8fkUOkhWasGxONNDLAXa0nQsgnUZpFCvoaaSxjNI8nE/FCMA==
X-Received: by 2002:adf:9a62:: with SMTP id z89-v6mr13746729wrb.53.1538960080571;
        Sun, 07 Oct 2018 17:54:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p62-v6sm35252911wrc.97.2018.10.07.17.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 17:54:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's so special about objects/17/ ?
References: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
        <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
        <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
        <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
        <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
        <87k1mta9x5.fsf@evledraar.gmail.com>
        <f64b5c5d-ef72-a347-bd0f-7b1669a8c10d@kdbg.org>
        <87in2da862.fsf@evledraar.gmail.com>
        <c904d10e-d6a1-b1d4-73eb-fb93f5caecdb@kdbg.org>
Date:   Mon, 08 Oct 2018 09:54:36 +0900
In-Reply-To: <c904d10e-d6a1-b1d4-73eb-fb93f5caecdb@kdbg.org> (Johannes Sixt's
        message of "Mon, 8 Oct 2018 00:39:47 +0200")
Message-ID: <xmqqh8hxtfzn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 07.10.18 um 21:06 schrieb Ævar Arnfjörð Bjarmason:
>> Picking any one number is explained in the comment. I'm asking why 17 in
>> particular not for correctness reasons but as a bit of historical lore,
>> and because my ulterior is to improve the GC docs.
>>
>> The number in that comic is 4 (and no datestamp on when it was
>> published). Are you saying Junio's patch is somehow a reference to that
>> xkcd in particular, or that it's just a funny reference in this context?
>
> No lore, AFAIR. It's just a random number, determined by a fair dice
> roll or something ;)

As I already said, I did not pick the number randomly, but rather
arbitrarily, and it is not 00 because the chosen number (unlike the
0{40} magic we use elsewhere) does not have to be memorable, and the
choice does not have to be explainable.

So people will not get any further explanation as to the reason
behind that arbitrary choice, but it was not random.
