Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46F0B1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 12:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936876AbeF3MrT (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 08:47:19 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:46675 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936446AbeF3MrR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 08:47:17 -0400
Received: by mail-ot0-f176.google.com with SMTP id v24-v6so12749459otk.13
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GvP+jn3qQqWSX9Wpw4OT0Q0cTRK2w9GT7VqMtvScZa0=;
        b=HyzttCAdrUB/Q10RTzize+oJ2b5nTk8YtQrlJDL0wYb0SXgd9LAcuTo9T3YjOdGeia
         jZBFy9/Qac8+hfHAVvGfeP88ksIc1LczUr21HNcJXz395e1zdrwtEAcwImDanA6Z0Vjl
         nMmuPkuEh83iXpcY0IPylvPoKjvIXu3jAArpl4M8UKfcijwzS4GA7BuH3uyu53HORY+h
         dZ8CUmId2ou2PZ+kTC491xK7RhW1yrKwrNg4vblT5sG9XUviEcA+lEDK6Eiflq27OgLe
         nEGFoCz9wCVCZTwz16gnhfb3ggXpmm9y60MHKujcW1hcWaYCehh77oQDRcw2tyWZ7fnN
         ikQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GvP+jn3qQqWSX9Wpw4OT0Q0cTRK2w9GT7VqMtvScZa0=;
        b=Bx3K7do6nPz4rzWHnZaaqwlPxof2pCS7rQoMobzwK/tU8fMFbnL9xAGyVAty4PVlj+
         JDEQ5UL+9VK3SkSv6ZQMyniclE5aTEvxHft2BImL22TFdXqMrGGh+JC4Va03TN6ru5yZ
         8YwJnDfy8m1IyvGv0lG9dVjqRXmJ1nmer1c+m2B38EWHJjc+Vy8BxyqQAz/F4wZW6U8z
         pSqxuw2hPMZpF4JkaXhOa7RKW7fgdPzGs/xu9AcmVX0go4qOjv51hsUVXOmtbe/vtwqg
         AnNmJsMItlvo0Rb9q4aEGgdgYgzKJ4XLyNlstyMfbzohofc72pjT+l20+EsIObuYxP86
         iLMA==
X-Gm-Message-State: APt69E3s/6gri9gQH/3i7VFFr7TUVVavbAaRibtPfWQKzS4y00RKPGRT
        V4E7z/2I50m4F/TDO0P5KFlsI8ama1FFrx5+uVk=
X-Google-Smtp-Source: AAOMgpeU56B/ffRpsHmpeJ7natt3gH+AYnlm2bKje3ebOJAK6+3wS7SmLu2WCB3PIeB75/0nrH8PCyyRL6Hw6ZZ37NA=
X-Received: by 2002:a9d:2ae1:: with SMTP id e88-v6mr11265631otb.248.1530362837286;
 Sat, 30 Jun 2018 05:47:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3b8d:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 05:47:16
 -0700 (PDT)
In-Reply-To: <20180625162308.GA13719@sigill.intra.peff.net>
References: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
 <573B6BF5.1090004@kdbg.org> <20160517194533.GA11289@sigill.intra.peff.net>
 <20160517195136.GB11289@sigill.intra.peff.net> <20160517195541.GC11289@sigill.intra.peff.net>
 <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
 <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com> <20180625162308.GA13719@sigill.intra.peff.net>
From:   Noam Postavsky <npostavs@users.sourceforge.net>
Date:   Sat, 30 Jun 2018 08:47:16 -0400
X-Google-Sender-Auth: HcKg0RCVMVzTu2mDBfaRzecKjzQ
Message-ID: <CAM-tV-8sbbht7NUwf87-gq=+P=LNPyiEcv3zL+1BxfXK+ktmVA@mail.gmail.com>
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004b6af7056fdb5d2a"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000004b6af7056fdb5d2a
Content-Type: text/plain; charset="UTF-8"

On 25 June 2018 at 12:23, Jeff King <peff@peff.net> wrote:

> These diagrams confused me for a minute, because I see two differences:
>
>   1. The first one has an extra apparently unrelated parallel branch on
>      the far left.
>
>   2. The first has the first-parent of the "*" merge commit immediately
>      join the branch.
>
> But if I understand correctly, we only care about the second property.

Yeah, sorry about that, I just copied them from "natural" occurences
and didn't remove all the non-relevant detail.

> I don't remember much about our prior discussion, so let me try to talk
> myself through the patch itself:

I didn't remember all that much either, but I did know that I didn't
have a very strong grasp on the code at the time. But your
talk-through convinced me that I really have no clue what's going on
:)

I'm still having trouble getting a big picture understanding of how
the graph struct relates the what gets drawn on screen, but through
some poking around with the debugger + trial & error, I've arrived at
a new patch which seems to work. It's also a lot simpler. I hope you
can tell me if it makes sense.

Also attached an updated test-multiway-merge.sh which allows adding
more branches to test different sized merges more easily.

--0000000000004b6af7056fdb5d2a
Content-Type: text/x-diff; charset="US-ASCII"; 
	name="v2-0001-log-Fix-coloring-of-certain-octupus-merge-shapes.patch"
Content-Disposition: attachment; 
	filename="v2-0001-log-Fix-coloring-of-certain-octupus-merge-shapes.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jj1e2lq20

RnJvbSBhZDQwYzU5ODYyNjRhZjFmNTkzNGIwNTA4MmUxNmEzY2UzMTRjYWFiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOb2FtIFBvc3RhdnNreSA8bnBvc3RhdnNAdXNlcnMuc291cmNl
Zm9yZ2UubmV0PgpEYXRlOiBTYXQsIDIzIEp1biAyMDE4IDE2OjU2OjQzIC0wNDAwClN1YmplY3Q6
IFtQQVRDSCB2Ml0gbG9nOiBGaXggY29sb3Jpbmcgb2YgY2VydGFpbiBvY3R1cHVzIG1lcmdlIHNo
YXBlcwoKVGhlIGdyYXBoLT5uZXdfY29sdW1ucyBpbmRleCBzaG91bGQgZGVwZW5kIG9uIGdyYXBo
LT5jb21taXRfaW5kZXguCgpTaWduZWQtb2ZmLWJ5OiBOb2FtIFBvc3RhdnNreSA8bnBvc3RhdnNA
dXNlcnMuc291cmNlZm9yZ2UubmV0PgotLS0KIGdyYXBoLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZ3JhcGgu
YyBiL2dyYXBoLmMKaW5kZXggZTFmNmQzYmRkLi5jNzgyNTkwMjAgMTAwNjQ0Ci0tLSBhL2dyYXBo
LmMKKysrIGIvZ3JhcGguYwpAQCAtODU3LDEwICs4NTcsMTAgQEAgc3RhdGljIGludCBncmFwaF9k
cmF3X29jdG9wdXNfbWVyZ2Uoc3RydWN0IGdpdF9ncmFwaCAqZ3JhcGgsCiAJaW50IG51bV9kYXNo
ZXMgPQogCQkoKGdyYXBoLT5udW1fcGFyZW50cyAtIGRhc2hsZXNzX2NvbW1pdHMpICogMikgLSAx
OwogCWZvciAoaSA9IDA7IGkgPCBudW1fZGFzaGVzOyBpKyspIHsKLQkJY29sX251bSA9IChpIC8g
MikgKyBkYXNobGVzc19jb21taXRzICsgZ3JhcGgtPmNvbW1pdF9pbmRleDsKKwkJY29sX251bSA9
IChpIC8gMikgKyBkYXNobGVzc19jb21taXRzOwogCQlzdHJidWZfd3JpdGVfY29sdW1uKHNiLCAm
Z3JhcGgtPm5ld19jb2x1bW5zW2NvbF9udW1dLCAnLScpOwogCX0KLQljb2xfbnVtID0gKGkgLyAy
KSArIGRhc2hsZXNzX2NvbW1pdHMgKyBncmFwaC0+Y29tbWl0X2luZGV4OworCWNvbF9udW0gPSAo
aSAvIDIpICsgZGFzaGxlc3NfY29tbWl0czsKIAlzdHJidWZfd3JpdGVfY29sdW1uKHNiLCAmZ3Jh
cGgtPm5ld19jb2x1bW5zW2NvbF9udW1dLCAnLicpOwogCXJldHVybiBudW1fZGFzaGVzICsgMTsK
IH0KLS0gCjIuMTEuMAoK
--0000000000004b6af7056fdb5d2a
Content-Type: application/x-sh; name="test-multiway-merge.sh"
Content-Disposition: attachment; filename="test-multiway-merge.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jj1e4h5o1

IyEvYmluL3NoCgojIFVzYWdlOgojIC4vdGVzdC1tdWx0aXdheS1tZXJnZS5zaAojIC4vdGVzdC1t
dWx0aXdheS1tZXJnZS5zaCBkCiMgLi90ZXN0LW11bHRpd2F5LW1lcmdlLnNoIGQgZQojIC4vdGVz
dC1tdWx0aXdheS1tZXJnZS5zaCBkIGUgZgojIC4uLgoKR0lUPSRQV0QvZ2l0CiNHSVQ9Z2l0Cgpt
a2JyYW5jaCAoKSB7CiAgICBicmFuY2g9JDEKICAgICIkR0lUIiBicmFuY2ggIiRicmFuY2giIG1h
c3RlcgogICAgIiRHSVQiIGNoZWNrb3V0ICIkYnJhbmNoIgogICAgZWNobyAiJGJyYW5jaCIgPiAi
JGJyYW5jaCIKICAgICIkR0lUIiBhZGQgIiRicmFuY2giCiAgICAiJEdJVCIgY29tbWl0IC1tICIk
YnJhbmNoIgp9Cgpta2RpciAtcCBsb2ctZm9ybWF0LXRlc3QKcm0gLXJmIGxvZy1mb3JtYXQtdGVz
dC8qIGxvZy1mb3JtYXQtdGVzdC8uKgpjZCBsb2ctZm9ybWF0LXRlc3QKCgoiJEdJVCIgaW5pdApl
Y2hvIDAgPiBmb28KIiRHSVQiIGFkZCBmb28KIiRHSVQiIGNvbW1pdCAtbSAwCgpta2JyYW5jaCBh
Cm1rYnJhbmNoIGIKZm9yIGJyYW5jaCA7IGRvCiAgICBta2JyYW5jaCAkYnJhbmNoCmRvbmUKCiIk
R0lUIiBjaGVja291dCBtYXN0ZXIKZWNobyAxID4gZm9vCiIkR0lUIiBjb21taXQgLWFtIDEKCiMg
VGhlIG5hbWUgb2YgdGhpcyBicmFuY2ggYWZmZWN0cyB0aGUgb3V0Y29tZQojIGUuZy4gY2FsbGlu
ZyBpdCAieCIgZG9lc24ndCB0cmlwIHRoZSBidWcgKCEpCm1rYnJhbmNoIGMKCiIkR0lUIiBicmFu
Y2ggbSBtYXN0ZXIKIiRHSVQiIGNoZWNrb3V0IG0KIiRHSVQiIG1lcmdlIC1tICJtZXJnZSBhIGIg
JCoiIGEgYiAiJEAiCgp2YWxncmluZCAiJEdJVCIgbG9nIC0tb25lbGluZSAtLWdyYXBoIC0tYWxs
Cg==
--0000000000004b6af7056fdb5d2a--
