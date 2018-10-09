Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C3D1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 01:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJIIVz (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 04:21:55 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38156 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIIVy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 04:21:54 -0400
Received: by mail-wr1-f48.google.com with SMTP id a13-v6so22659320wrt.5
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 18:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zGYYuG6u+mZxCt7y/1kNyrUDs4NMIDJIPIfFzLYpb5w=;
        b=TNeu9I3qGAnUwtRmXgwv6ogH1r9GD4pIcecxARr+RfvPvsQyyQktg3pQ/3Ou3ZRLbQ
         EQMYDExBmx3ZZAvafFmVyaP3jw6WS1BF1tC1u2hwNG06vcURoqx/LIUPHLMjOHbkVPLO
         TGPnBXEYCTdTHtMkJepJf7a2iYbpwZzcyJtZmPe2tXACOsQHX1WD97QQXrcx1Bh+Rv1L
         ToxnkCYf3mDYHrhVEtGbsIWhlinKLjYigfKtMMvu1wv5QRN5fermpT/rNTD8Yfhiw8au
         IGkaAt59tbNFJ6hxnASKofE0WwXF90B6bvvWG3aeQPTPowj3x7JIBjXKOFy4z+V6ARfe
         U0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zGYYuG6u+mZxCt7y/1kNyrUDs4NMIDJIPIfFzLYpb5w=;
        b=D0SXlGuESGkgbXCq359+4fErpEbTDfcl2iwXUev1cn7FzNAhAzHCwzQ8EXQPMGSbg3
         YtSksS5+7OCLTnXz8WaTXFQXptN2bZfMG36W923qsqgKHvZBzOKCoLd5WK465/h344xC
         j3syNri3fzAbOAAQvHpuO3TlzqGuV0Dtz0wV+H+IV7z153SaIg+Z7I9WzjHmdlzEm543
         Ti/JJd/YI3K7cWm6xzJg0Nno9omug+K88e0n9cahNq1XqyefXv7KErebB0VDf6mOtJFw
         AZ5OobanzBIdcRUFOyn5ClwGWSv4QqNA0//fGYQd/W9wtkxxoQfCt+wjzA4Wv0MO0nAo
         u0xQ==
X-Gm-Message-State: ABuFfoiVXjIqnaI9hGvmQHXdWs1/B+9qhOHG5Z7CtlEZdO6AAgfnrrRg
        /FD6uD6c926uvqBj/aBTzsA=
X-Google-Smtp-Source: ACcGV62BR2IpgTVsh1iMr97JVeiprHCLyf9OgigyFyUuKlsnMX6x36Xbzi69IbUUzDajD9Koj5GmBA==
X-Received: by 2002:a5d:6748:: with SMTP id l8-v6mr1417593wrw.197.1539047250209;
        Mon, 08 Oct 2018 18:07:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z12-v6sm6480801wrv.46.2018.10.08.18.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 18:07:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
        Steven Grimm <koreth@midwinter.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: What's so special about objects/17/ ?
References: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
        <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
        <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
        <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
        <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
        <87k1mta9x5.fsf@evledraar.gmail.com>
        <xmqqpnwltu8s.fsf@gitster-ct.c.googlers.com>
        <87h8hwafof.fsf@evledraar.gmail.com>
Date:   Tue, 09 Oct 2018 10:07:28 +0900
In-Reply-To: <87h8hwafof.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 08 Oct 2018 12:36:16 +0200")
Message-ID: <xmqqzhvorkq7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Depending on how we're counting there's at least two.

I thought you were asking "why the special sentinel is not 0{40}?"
You counted the number of reasons why 0{40} is used to stand in for
a real value, but that was the number I didn't find interesting in
the scope of this discussion, i.e. "why the special sample is 17?"

I vaguely recall we also used 0{39}1 for something else long time
ago; I offhand do not recall if we still do, or we got rid of it.
