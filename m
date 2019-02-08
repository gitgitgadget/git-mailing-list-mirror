Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FFF81F453
	for <e@80x24.org>; Fri,  8 Feb 2019 17:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfBHRuL (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 12:50:11 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:32788 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfBHRuK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 12:50:10 -0500
Received: by mail-wm1-f52.google.com with SMTP id h22so7374847wmb.0
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 09:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tWbzc6nYICdsNN0FnD1HJmlJ0ZinB09+1+xCdi+ejXQ=;
        b=p1A+C171A8JohDigjutVeqb0QTbw27LVn4xEgJO3j15tfoJcYpUtWiwFWCN8cuRXX7
         FGJ55BNV0TuZLJdfA3cJxLIQ2/IDb50+FK4YiuHdrliq2ovdjFa1Iq+zHxFe5rOVkz23
         HRjvKGxo7wFENY7j20ya8z90zKnCcrcWTiKFkKykdb1mmid4eAB3M6Ypyt2h7ZLjwbfS
         fDDXwjTcT0/4Kh2tS43fWZF+/+reWDOv6PlXD+ZdBDtWNPVqUAO5ACRU0SWz8YZDDcAm
         OWApOuTTDmOBzk78pmTLUO/4Ek+GLzS+IjWS6Sui+tFzFRYgS3d1766XyUYpJdineHES
         qy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tWbzc6nYICdsNN0FnD1HJmlJ0ZinB09+1+xCdi+ejXQ=;
        b=kTpaZ/W3kA1mKkfx7KO0sMCnnbqtd8Md/nz5U9JPYqcWH5m2pzRlW87TQ5lDZVHimT
         xvDSHJZJp3CMhpqwAOYesrayiV+Ymf6d+8cwq+tUwYbDfGtBQEtp67kbLCT6ZjlHLWQB
         oRSvahqyvtTf+Dn7yqbcRI4PyxUkQI6qzMNr/53AZ2l2SksBTWLPpc1OzbStfMnl/JdP
         CYPwJ/84qo2DW13IvG4Vg4k/MXAinu0fD1JlZSyE9wnlFgBTRsTw+6foxjxkGRhSDgF5
         51UxDR3N9VAMMeeJz2w0fF1WfUwh5c8EJkrbK9riAMNYlRF0qbci5EghGULixgY3GUY3
         8GFw==
X-Gm-Message-State: AHQUAuYBzeDGCxKNJTOuv55VnfNhsHIb9vO5EWKGrlT+V1E7kRROgOpx
        Eoe++KOPNGn3EH6c4bAVJIgHBkRQ
X-Google-Smtp-Source: AHgI3IYexptZ1EnXgJgNCwpj/m7pmAPmlC3vb6ydE9ZS0wXBYUZ5wqCix70WXafEjif0zj1d59F5lA==
X-Received: by 2002:a1c:47:: with SMTP id 68mr12024802wma.89.1549648208543;
        Fri, 08 Feb 2019 09:50:08 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d4sm1523263wmb.25.2019.02.08.09.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 09:50:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Kevin Daudt <me@ikke.info>, Rich Felker <dalias@libc.org>,
        Kevin Daudt <git@lists.ikke.info>, git@vger.kernel.org,
        larsxschneider@gmail.com
Subject: Re: t0028-working-tree-encoding.sh failing on musl based systems (Alpine Linux)
References: <20190207215935.GA31515@alpha>
        <20190208001705.GC11927@genre.crustytoothpaste.net>
        <20190208060403.GA29788@brightrain.aerifal.cx>
        <20190208114502.GD11927@genre.crustytoothpaste.net>
        <20190208115511.GA30779@alpha>
        <20190208135137.GE11927@genre.crustytoothpaste.net>
Date:   Fri, 08 Feb 2019 09:50:07 -0800
In-Reply-To: <20190208135137.GE11927@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 8 Feb 2019 13:51:38 +0000")
Message-ID: <xmqqr2cikw4w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> So would you suggest that we just skip this test on Alpine Linux?
>
> That's not exactly what I said. If Alpine Linux users are never going to
> use this functionality and don't care that it's broken, then that's a
> fine solution.
>
> As originally mentioned, musl could change its libiconv to write a BOM,
> which would make it compatible with other known iconv implementations.
>
> There's also the possibility of defining NO_ICONV. That basically means
> that your system won't support encodings, and then this test shouldn't
> matter.
>
> Finally, you could try applying a patch to the test to make it write the
> BOM for UTF-16 since your iconv doesn't. I expect that the test will
> fail again later on once you've done that, though.

Sorry for being late to the party, but is the crux of the issue this
piece early in the test?

    printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
    ...
    cp test.utf16.raw test.utf16 &&
    ...
    git add .gitattributes test.utf16 test.utf16lebom &&

where we expect "iconv -t UTF-16" means "write UTF16 in whatever
byteorder of your choice, but do write BOM", and iconv
implementations we have seen so far are in line with that
expectation, but the one on Apline writes UTF16 in big endian
without BOM?

If that is the case, I think it is our expectation that is at fault
in this case, as I think the most natural interpretation of "UTF-16"
without any modifiers (like "BE") ought to be "UTF16 stream
expressed in any way of writers choice, as long as it is readable by
standard compliant readers", in other words, "write UTF16 in
whatever byteorder of your choice, with or without BOM, but if you
omit BOM, you SHOULD write in big endian".  So

 - If our later test assumes that test.utf16 is UTF16 with BOM, that
   already assumes too much;

 - If our later test assumes that test.utf16 is UTF16 in big endian,
   that assumes too much, too.

As suggested earlier in the thread, the easiest workaround would be
to update the preparation of test.utf16.raw may to force big endian
with BOM by preprending BE-BOM by hand before "iconv -t UTF-32BE"
output (I am assuming that UTF-32BE will stay to be "big endian
without BOM" in the future).  That would make sure that the
assumption later tests have on test.utf16 is held true.
