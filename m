Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B6E1F516
	for <e@80x24.org>; Sat, 23 Jun 2018 21:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeFWVpV (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 17:45:21 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34319 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeFWVpU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 17:45:20 -0400
Received: by mail-oi0-f50.google.com with SMTP id i205-v6so9206931oib.1
        for <git@vger.kernel.org>; Sat, 23 Jun 2018 14:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fl7LEKUAxaVF9H0UD1krL7Syz+C1WPduStm+YQ7GNDc=;
        b=dMkxaOg5PXMyTg1gSoueZJV5Uu0HyedqmdkuL+hQ8R62uLDd0eYZGOEV/5i+YnjR44
         2TM0x8rNKxFJ32+unWwKHG0efs/tkXH1QvsfitAPjeXMGbNuq2YA7PgeoP5o6ixxc/5A
         USlKnQLW1DG6OHF/Fv0qJrDIEbHpWH8FEjBp7qO69iHobR7d7v72fwEJtDJBYe6D5syt
         mhQDFHBiKDp8YVSWFe40CUWwBEpnRy04OsVSNZadIe/j4VDE4t9YHLJ/DEIeb/c5JE81
         KWCanyeJmXV9XnwDOBpPeboAvmMS8R0hmjSb70tn4GC/o7DwMQEnmSnE8S9QWeqebXy4
         +0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fl7LEKUAxaVF9H0UD1krL7Syz+C1WPduStm+YQ7GNDc=;
        b=Bli+5xd9kQKyPabWNYkUWIcAK5XoRWPu1/tlE+s/WG5R/LJcs/kjhfI2lQL/rxforD
         FBgMj3E+6HrqgOFqUX+8W8vjK3PA4B5vrbXVMB2cW7k1D4qNQ6nzqrxe0ni+DGlTJLTW
         /ufglIadKTGRhQWSsB6L8CFk9q8fOK4Duzi0OMrtVNDLuvuJNYQ7Xb77SazvT0XGxeKp
         ltp8bAeAjAWry/wYxBl0My38LJwjSuvtigsZjJ59n0AIwPC4yTw2IkfSUPTKMAUhGrU5
         K3Sxs0E1f6QbYziK204Bh6rr2weqlNfo/o2MMva8T4Bp0euO/J+Y6AUGO0gkp6DpNRgb
         +mVA==
X-Gm-Message-State: APt69E3FlBSj8UYjGOBCAIhFEawcBuCb0sku1c1MkljZrexP1/OexNp5
        4VdA1R+HfyfEG4ARSeHGgaTTjhe61brf5onVm1U=
X-Google-Smtp-Source: ADUXVKLGXAFJYH5W1nfHMOXoyUPqdmRjvXKrRotjrS3XXxQmjnLUhbvi1ilaCPB5adjzFzeTMMTA5qv8xpxD6C95KZE=
X-Received: by 2002:aca:b504:: with SMTP id e4-v6mr3584634oif.93.1529790319823;
 Sat, 23 Jun 2018 14:45:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:4c02:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 14:45:19
 -0700 (PDT)
In-Reply-To: <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
References: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
 <573B6BF5.1090004@kdbg.org> <20160517194533.GA11289@sigill.intra.peff.net>
 <20160517195136.GB11289@sigill.intra.peff.net> <20160517195541.GC11289@sigill.intra.peff.net>
 <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
From:   Noam Postavsky <npostavs@users.sourceforge.net>
Date:   Sat, 23 Jun 2018 17:45:19 -0400
X-Google-Sender-Auth: _9JIl2aah2kbgcxbDTcqlI_NOtQ
Message-ID: <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com>
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000984dcd056f56101d"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000984dcd056f56101d
Content-Type: text/plain; charset="UTF-8"

Archive link to previous discussion:
https://marc.info/?l=git&m=146331754420554&w=2

On 20 May 2016 at 18:12, Noam Postavsky <npostavs@users.sourceforge.net> wrote:

> Looking at the coloured output, for some octopus merges where the
> first parent edge immediately merges into the next column to the left,
> col_num should be decremented by 1 (otherwise the colour of the "-."
> doesn't match the rest of that edge).
>
> | | *-.
> | | |\ \
> | |/ / /
>
> For the other case where the first parent edge stays straight, the
> current col_num computation is correct.
>
> | *-.
> | |\ \
> | | | *
>
> I'm not sure how to distinguish these cases in the code though. Is it
> enough to just compare against graph->num_new_columns?

I was recently reminded of this, here's a patch which does that.

--000000000000984dcd056f56101d
Content-Type: text/x-diff; charset="US-ASCII"; 
	name="v1-0001-log-Fix-coloring-of-certain-octupus-merge-shapes.patch"
Content-Disposition: attachment; 
	filename="v1-0001-log-Fix-coloring-of-certain-octupus-merge-shapes.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jirxk38q0

RnJvbSBkMGM0ZjE5ZmYxNjJlNjNkNWQyM2Q0NTZkMGZjNGZlOWEzMjAyOWVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOb2FtIFBvc3RhdnNreSA8bnBvc3RhdnNAdXNlcnMuc291cmNl
Zm9yZ2UubmV0PgpEYXRlOiBTYXQsIDIzIEp1biAyMDE4IDE2OjU2OjQzIC0wNDAwClN1YmplY3Q6
IFtQQVRDSCB2MV0gbG9nOiBGaXggY29sb3Jpbmcgb2YgY2VydGFpbiBvY3R1cHVzIG1lcmdlIHNo
YXBlcwoKRm9yIG9jdG9wdXMgbWVyZ2VzIHdoZXJlIHRoZSBmaXJzdCBwYXJlbnQgZWRnZSBpbW1l
ZGlhdGVseSBtZXJnZXMgaW50bwp0aGUgbmV4dCBjb2x1bW4gdG8gdGhlIGxlZnQ6Cgp8IHwgKi0u
CnwgfCB8XCBcCnwgfC8gLyAvCgp0aGVuIHRoZSBudW1iZXIgb2YgY29sdW1ucyBzaG91bGQgYmUg
b25lIGxlc3MgdGhhbiB0aGUgdXN1YWwgY2FzZToKCnwgKi0uCnwgfFwgXAp8IHwgfCAqCgpTaWdu
ZWQtb2ZmLWJ5OiBOb2FtIFBvc3RhdnNreSA8bnBvc3RhdnNAdXNlcnMuc291cmNlZm9yZ2UubmV0
PgotLS0KIGdyYXBoLmMgfCAxMiArKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZ3JhcGguYyBiL2dyYXBoLmMK
aW5kZXggZTFmNmQzYmRkLi5jOTE5Yzg2ZTggMTAwNjQ0Ci0tLSBhL2dyYXBoLmMKKysrIGIvZ3Jh
cGguYwpAQCAtODU2LDEyICs4NTYsMTYgQEAgc3RhdGljIGludCBncmFwaF9kcmF3X29jdG9wdXNf
bWVyZ2Uoc3RydWN0IGdpdF9ncmFwaCAqZ3JhcGgsCiAJaW50IGNvbF9udW0sIGk7CiAJaW50IG51
bV9kYXNoZXMgPQogCQkoKGdyYXBoLT5udW1fcGFyZW50cyAtIGRhc2hsZXNzX2NvbW1pdHMpICog
MikgLSAxOwotCWZvciAoaSA9IDA7IGkgPCBudW1fZGFzaGVzOyBpKyspIHsKLQkJY29sX251bSA9
IChpIC8gMikgKyBkYXNobGVzc19jb21taXRzICsgZ3JhcGgtPmNvbW1pdF9pbmRleDsKKwlpbnQg
Zmlyc3RfY29sID0gZGFzaGxlc3NfY29tbWl0cyArIGdyYXBoLT5jb21taXRfaW5kZXg7CisJaW50
IGxhc3RfY29sID0gZmlyc3RfY29sICsgKG51bV9kYXNoZXMgLyAyKTsKKwlpZiAobGFzdF9jb2wg
Pj0gZ3JhcGgtPm51bV9uZXdfY29sdW1ucykgeworCQlmaXJzdF9jb2wtLTsKKwkJbGFzdF9jb2wt
LTsKKwl9CisJZm9yIChpID0gMCwgY29sX251bSA9IGZpcnN0X2NvbDsgaSA8IG51bV9kYXNoZXM7
IGkrKywgY29sX251bSsrKSB7CiAJCXN0cmJ1Zl93cml0ZV9jb2x1bW4oc2IsICZncmFwaC0+bmV3
X2NvbHVtbnNbY29sX251bV0sICctJyk7CiAJfQotCWNvbF9udW0gPSAoaSAvIDIpICsgZGFzaGxl
c3NfY29tbWl0cyArIGdyYXBoLT5jb21taXRfaW5kZXg7Ci0Jc3RyYnVmX3dyaXRlX2NvbHVtbihz
YiwgJmdyYXBoLT5uZXdfY29sdW1uc1tjb2xfbnVtXSwgJy4nKTsKKwlzdHJidWZfd3JpdGVfY29s
dW1uKHNiLCAmZ3JhcGgtPm5ld19jb2x1bW5zW2xhc3RfY29sXSwgJy4nKTsKIAlyZXR1cm4gbnVt
X2Rhc2hlcyArIDE7CiB9CiAKLS0gCjIuMTEuMAoK
--000000000000984dcd056f56101d--
