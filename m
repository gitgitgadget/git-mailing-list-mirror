Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CCCE1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 11:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfGBLKb (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 07:10:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44860 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfGBLKb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 07:10:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so26828470edr.11
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 04:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=kUS/9fHpBzxibXtX6pyuYuMvz9qTpIwsdUjrqi3oksg=;
        b=dhZSCYlrWRWiKzJEIjC1RV76qFKPJx3YuuOTyvftvCMwpyosEPEKUMc9JclHDyXTTg
         VyWq4yIEHSNsWIsh5+Am4dSo6ufEc01yb5GMzejNgCnvVN4wYpSVMohQAkuTo2l9H8Nm
         c7orCar0gPRgecm58/2NmljY5lSJL6MHu7E/HEbuFdHfCJQhBNa7XTett7Ee7RK3AkE1
         BJLIj9cwFcGUROAo4K/h57cGOTgmi2H7UjoCNve8MEh1WpgIa7bK1lhgk4qnnnd3SvcZ
         ZOphx28T55Zt+P/gRONgJgIJuV9jcBIL8QbzCP3iXctg/PvXv0JJ6t3RmK3pqrONuGlP
         GRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=kUS/9fHpBzxibXtX6pyuYuMvz9qTpIwsdUjrqi3oksg=;
        b=AaaiEO6GG3yO6bs3dUFR7kxEO1+ioA4zmJqJk1xhKEAj6UPxDfhtes/SQFxyTTwqSY
         aqpDh1xjg+NlXaEhE0g9Pxo0E0bVgExrSrcbGOr1uAmxrFGoRUxNJ3BaRYkIK6VnQcmL
         yUmwiA6qzrySfHsRBGl/Z+8zUYhxs8Xv/0fDfJGKkJ2kaCsBghGonkMCWc0BU+q2Lby5
         eAM8R5UxahKVLEK1JRY5Tfv1l5BZn9gfn8h+y0f9LSRSvOXiVYdsCCo88RsQr6dxAFss
         a+chqNGbRPTo3fExJXr9wGzm43BtH/cjunDXQ0bHK2aDXTW3onJtH5+SxLflBWZvYs2C
         gzAA==
X-Gm-Message-State: APjAAAVmEjTXw7lIzqeJzm88Zs+8ldz9yIwExu4fzRNv9tzPYMXLN0GI
        b/xOykrZDxCa8m72kDLeBR0=
X-Google-Smtp-Source: APXvYqzY66Ty/DYIiOOxmD8cMdySkuXGNMLFhiDBG4rIVqgApUUavhd4BU77rGVCeZAy0jvUAhlcyA==
X-Received: by 2002:a17:906:802:: with SMTP id e2mr18049649ejd.59.1562065829457;
        Tue, 02 Jul 2019 04:10:29 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id r26sm1262325ejb.51.2019.07.02.04.10.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 04:10:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [PATCH v3 00/10] grep: move from kwset to optional PCRE v2
References: <20190627233912.7117-1-avarab@gmail.com> <20190701212100.27850-1-avarab@gmail.com> <xmqqef395tmi.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqef395tmi.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 02 Jul 2019 13:10:27 +0200
Message-ID: <87pnms7kv0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 01 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This v3 has a new patch (3/10) that I believe fixes the regression on
>> MinGW Johannes noted in
>> https://public-inbox.org/git/nycvar.QRO.7.76.6.1907011515150.44@tvgsbejv=
aqbjf.bet/
>>
>> As noted in the updated commit message in 10/10 I believe just
>> skipping this test & documenting this in a commit message is the least
>> amount of suck for now. It's really an existing issue with us doing
>> nothing sensible when the log/grep haystack encoding doesn't match the
>> needle encoding supplied via the command line.
>
> Is that quite the case?  If they do not match, not finding the match
> is the right answer, because we are byte-for-byte matching/searching
> IIUC.
>
>> We swept that under the carpet with the kwset backend, but PCRE v2
>> exposes it.
>
> Is it exposing, or just showing the limitation of the rewritten
> implementation where it cannot do byte-for-byte matching/searching
> as we used to be able to?
>
> Without having a way to know what encoding is used on the command
> line, there is no sensible way to reencode them to match the
> haystack encoding (even when it is known), so "you got to feed the
> strings in the same encoding, as we are going to match/search
> byte-for-byte" is the only sensible way to work, given the design
> space, I would think.
>
> Not that it is all that useful to be able to match/search
> byte-for-byte, of course, so I am OK if we punt with these tests,
> but I'd prefer to see us admit we are punting when we do ;-).

I'm guilty as charged in punting this larger encoding issue. As it
pertains to this patch series it unearths an obscure case I think nobody
cares about in practice, and I'd like to move on with the "remove kwset"
optimization.

But I strongly believe that the new behavior with the PCRE v2
optimization is the only sane thing to do, and to the extent we have
anything left to do (#leftoverbits) it's that we should modify git more
generally (aside from string searching) to do the same thing where
appropriate.

Remember, this only happens if the user has set a UTF-8 locale and thus
promised that they're going to give us UTF-8. We then take that promise
and make e.g. "=C3=A6" match "=C3=86" under --ignore-case.

Just falling back on raw byte matching isn't going to cut it, because
then "=C3=A6<invalid utf8>" won't match "=C3=86<same invalid utf8>" under
--ignore-case, and there's other cases like that with matching word
boundaries & other Unicode gotchas.

The best that can be hoped for at that point is some "loose UTF-8"
mode. I see both perl & GNU grep seem to support that (although I'm sure
it falls apart at some point). GNU grep will also die in the same way
that we now die with --perl-regexp (since it also use PCRE).

I think that's saner, if the user thinks they're feeding us UTF-8 but
they're not I think they'd like to know rather than having the string
matching library fall back.
