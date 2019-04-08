Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866EB20248
	for <e@80x24.org>; Mon,  8 Apr 2019 04:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfDHEOe (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 00:14:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37427 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHEOd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 00:14:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so13058383wmf.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 21:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uwM5RCfeWY+QnpscGJW7Ms16OB0GgEjTEnkhc2gSM98=;
        b=CKVO9qS9qA8nMWRSRWVOamyqXg7QH1XxVj+xUMpVeM/GyUfAFE0GnHICyBog0v5U/R
         XXzFxoyVUuCGpfi3g9p3Kuw9XYMOULDQTnjRLp7VDndZMi/yUdnYK9aRo1ACYYnRAg+j
         O1Da5LuY8rIxgt1qG4Zf/bKUK+7FacbkGpze+GDDOjpVP1ly7W2oMQMzYKsJoJEzluQJ
         QhlZ8wC3MPElYI4Zv+yhCq3PNLHQDa6kua5ibujJ7XeExbDaQEhdbBt3X1l1QRPRmy7w
         UVLceU1QKSdlm3FCT48DUsXN5wGL6Rr/lsbiMVdMLbVh4spNuQLSWsSybYpOcI4FPNmA
         urYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uwM5RCfeWY+QnpscGJW7Ms16OB0GgEjTEnkhc2gSM98=;
        b=aFODJ94lHxV8ZCWlLpWm/dl1ENI0yp8rYCfYC+htUr8zYyemKIwS5oaKI0oXpx3Hr9
         5svLqGz6uyUSwQky5zm5zit8e1b7HTxk78LkNkSFDkv7BXXpmfvXG6uHc9Nd/k86A7eP
         JgZ7QyXZfOtSyQ6p9ufj4ExRvjoqXpndt7n7CAQLuwahF0xHxlQviniPZSdDJ8auKQo1
         sbQ1ffOpGMWmotj+RZdYrdiTReKp4irgQMjRQBlJvllQw94gYr0W8cU6KwKkZaL/MmV+
         4iWQMmgHcmX4ASOENKCMCa+0aocYvzHO9RDAvGP1/FJmFtJ7+JulNPyPywuSOWD/LkLm
         Uxyg==
X-Gm-Message-State: APjAAAWZ79kTmu2JSHnLQODLeqRcdCFn2a1/NnEOta4/XpdPaSP94QLg
        TNnMyRrvk+qiSSYIVcKYsI4=
X-Google-Smtp-Source: APXvYqzLnomLdJ9/lEV6PWZc0i02laIP9MrZkPeA3mUqNx/qxXiNVmLGZIBoyFYuUJGwmmR/cYXCJg==
X-Received: by 2002:a1c:658a:: with SMTP id z132mr15965137wmb.92.1554696871877;
        Sun, 07 Apr 2019 21:14:31 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r30sm91874851wrr.46.2019.04.07.21.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 21:14:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2019, #01; Thu, 4)
References: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CmkFNv7Fy+rSY0Q=1DhYSrpSfU=XEpSS6QRLASJtsVew@mail.gmail.com>
        <xmqqmul5e9y0.fsf@gitster-ct.c.googlers.com>
        <87d0lyanen.fsf@evledraar.gmail.com>
Date:   Mon, 08 Apr 2019 13:14:30 +0900
In-Reply-To: <87d0lyanen.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 06 Apr 2019 22:28:48 +0200")
Message-ID: <xmqqimvpb0bd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> I'd rather pick between (1) using the final name for the concept we
>> want to eventually achieve, i.e. "precious", and starting small,
>> i.e. "initially, only git-clean knows about it", or (2) doing
>> nothing.  Per-command 'precious-this', 'precious-that' that would be
>> left as interface wart for years is not a pretty sight I want to
>> see.
>
> I think we shouldn't squat "precious" in general without seeing where we
> want to go with it, which I tried to sum up in
> https://public-inbox.org/git/87ftsi68ke.fsf@evledraar.gmail.com/
>
> But aside from that larger discussion, I see no problem with having some
> "+clean" or "-clean" attribute with basically Duy's current patch in
> nd/precious with the equivalent of "s/precious/clean/". Duy suggested
> this in
> https://public-inbox.org/git/CACsJy8C377NmLv9edNYjinKAQf-P1y5+Nwhdj3vRkz_E__x43Q@mail.gmail.com/

I know.  I've already said that we do not want proliferation of
precious-clean precious-merge precious-yet-another-thing.

> ... shouldn't be breaking the reasonable assumption a user of "-x"
> could make so far, which is "ignore repo config, just wipe it
> all".

Yup.  I think that is reasonable.  To paraphrase (so that you can
tell me that I misunderstood you, if that is the case), if we are
told to honor only what the index knows, deliberately ignoring the
.gitignore file, then we should also ignore .gitattributes that says
which ones are ignored-but-precious, as the "precious" attribute is
a mere implementation detail of what _could_ have been part of the
exclude mechanism (aka ".gitignore") from day one, if we designed
the exclude mechanism to support "ignored and expendable" and
"ignored and precious" from day one.  "clean -x" would certainly
have ignored both kinds.

