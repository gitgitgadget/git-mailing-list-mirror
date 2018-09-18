Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59DB1F453
	for <e@80x24.org>; Tue, 18 Sep 2018 16:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeIRWXz (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 18:23:55 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:50356 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIRWXz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 18:23:55 -0400
Received: by mail-it0-f51.google.com with SMTP id j81-v6so4251775ite.0
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B6ww+BFiWBUTZvUOFrQSLwKMVeMz1r37mb3aUnQoe3U=;
        b=P0GE/epJ4ZjWKl8ODgQGqrHXw/5QigP4TcTrv8oSrt/uEdAPA1ScRZWP3DdwmfSNQV
         zjQlQBasar6K53usEscfwAXjcwtq2b87ZqMua2c64kE5T/1oFH5Od96eFGcM2gMXEldm
         G4mv/5f/fsY10FqVUNrJ7gk2XqxVfp/Kemers=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B6ww+BFiWBUTZvUOFrQSLwKMVeMz1r37mb3aUnQoe3U=;
        b=hH5UGFx74qToe+GOCglHB4bs09mBWmZno1uKORVtbW6dljnaJaHaJDQabHuDBhpeZy
         UOBdY7mpK+12iLt/ldvLJq7vOr4Ia2EN45D+Xib4QUrx10dz91T89gQpvQ5G6q94uwJL
         tB6X0b+uhFvNLwy4LB9w0xPkbqpDO7+y7d120ydK+4N4MvM+zlnA3lazXE35Gj/z9AsI
         Y4ntllNSGBSJImMLbLeqL9Upe8bu24kiCzM6shL7Bm2TQFseI03RC4ZVYI+mkrbftbYq
         oYuZsHPcpwi8LXMcQKWIwqw0lyVrBWpL+65VmrgCSuzWajRqNJg3kaHEKzu51GBv4o27
         yEBw==
X-Gm-Message-State: APzg51BjFuJ8P4WBdmhPxX42tnESIqK2XA9PhifFJJLvQeKatTqBK9MB
        51zo2rGqNMoKdz9XlrHWBhvAdgRI6uOJjLjI6L0=
X-Google-Smtp-Source: ANB0VdZS1RsIjRy3mkadzpmSio2yMSVlrdHgzyzRpQiifUzFrM5urc0FQ7fwrxGeIbum+CaBbD5lYMD41UN0LO6KcHs=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr28502502jaf.70.1537289428870;
 Tue, 18 Sep 2018 09:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net> <20180724190136.GA5@0f3cdde9c159>
 <CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com>
 <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com> <20180724221008.GI18502@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807301058560.10478@tvgsbejvaqbjf.bet> <MWHPR21MB01738A46E37527E45E950937C42F0@MWHPR21MB0173.namprd21.prod.outlook.com>
 <64c1fc82-8830-bd62-7cc6-ef76ad06f6d5@noekeon.org>
In-Reply-To: <64c1fc82-8830-bd62-7cc6-ef76ad06f6d5@noekeon.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Sep 2018 09:50:17 -0700
Message-ID: <CA+55aFyYyh0EYSotDYMv+mk+QbRghQnn3MK7oRn=131VDm=HfQ@mail.gmail.com>
Subject: Re: Hash algorithm analysis
To:     jda@noekeon.org
Cc:     Dan Shumow <danshu@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 18, 2018 at 8:18 AM Joan Daemen <jda@noekeon.org> wrote:
>
> 3) The relatively large state in the sponge construction increases the ge=
neric strength against attacks when the input contains redundancy or
> has a certain form. For instance, if the input is restricted to be text i=
n ASCII (such as source code), then the collision-resistance grows
> higher than the nominal 2^{c/2}. Such an effect does not exist with narro=
w-pipe Merkle-Damg=C3=A5rd. (This may be what Linus had intuitively in mind=
.)

Answering to just this part:

No, what I had in mind was literally just exactly the kind of attack
that SHA1 broke for - attacking the internal state vector directly,
and not paying any penalty for it, because the stat size is the same
as the final hash size.

The length extension attack is just the simplest and most trivial
version of that kind of attack - because the internal state vector
*is* the result, and you just continue using it.

But that trivial length extension thing not the real problem, it's
just the absolutely simplest symptom of the real problem.

I think that the model where the internal state of the hash is the
same width as the final result is simply broken. It was what broke
SHA1, and that problem is shared with SHA2.

"Length extension" is just the simplest way to say "broken by design", imho=
.

Because the length extension attack is just the most trivial attack,
but it isn't the fundamental problem. It was just the first and the
cheapest attack found, but it was also the most special-cased and
least interesting. You need to have a very special case (with that
secret at the beginning etc) to make the pure length extension attack
interesting. And git has no secrets, so in that sense "length
extension" by itself is totally immaterial. But the basic problem of
internal hash size obviously wasn't.

So I would say that length extension is a direct result of the _real_
problem, which is that the hash exposes _all_ of the internal data.

That is what makes length extension possible - because you can just
continue from a known state, and there is absolutely nothing hidden -
and yes, that's a really easy special case where you don't even need
to actually break the hash at all.

But I argue that it's _also_ one big part of what made SHAttered
practical, and I think the underlying problem is exactly the same.
When the internal state is the same size as the hash, you can attack
the internal state itself for basically the same cost as attacking the
whole hash.

So you can pick-and-choose the weakest point.

Which is basically exactly what SHAttered did. No, it wasn't the
trivial "just add to the end", but it used the exact same underlying
weakness as one part of the attack.

*This* is why I dislike SHA2. It has basically the exact same basic
weakness that we already know SHA1 fell for. The hashing details are
different, and hopefully that means that there aren't the same kind of
patterns that can be generated to do the "attack the internal hash
state" part, but I don't understand why people seem to ignore that
other fundamental issue.

Something like SHA-512/256 would have been better, but I think almost
nobody does that in hardware, which was one of the big advantages of
plain SHA2.

The main reason I think SHA2 is acceptable is simply that 256 bits is
a lot. So even if somebody comes up with a shortcut that weakens it by
tens of bits, nobody really cares. Plus I'm obviously not a
cryptographer, so I didn't feel like I was going to fight it a lot.

But yes, I'd have probably gone with any of the other alternatives,
because I think it's a bit silly that we're switching hashes to
another hash that has (at least in part) the *exact* same issue as the
one people call broken.

(And yes, the hashing details are different, so it's "exactly the
same" only wrt that internal state part - not the bitpattern finding
part that made the attack on the internal state much cheaper. Real
cryptographers obviously found that "figure out the weakness of the
hashing" to be the more interesting and novel part over the trivial
internal hash size part).

That said..

The real reason I think SHA2 is the right choice was simply that there
needs to be a decision, and none of the choices were *wrong*.
Sometimes just the _act_ of making a decision is more important than
_what_ the decision is.

And hey, it is also likely that the reason _I_ get hung up on just the
size of the internal state is that exactly because I am _not_ a
cryptographer, that kind of high-level stuff is the part I understand.
When you start talking about why the exact rules of Merkle=E2=80=93Damg=C3=
=A5rd
constructions work, my eyes just glaze over.

So I'm probably - no, certainly - myopic and looking at only one part
of the issue to begin with.

The end result is that I argued for more bits in the internal state
(and apparently wide vs narrow is the technical term), and I would
have seen parallel algorithms as a bonus for the large-file case. None
of which argued for SHA2.

But see above on why I think SHA2 is if not *the* right choice, at
least *a* right choice.

                    Linus
