Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77FE01F576
	for <e@80x24.org>; Wed, 28 Feb 2018 09:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeB1JjB (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 04:39:01 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40344 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeB1Ji7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 04:38:59 -0500
Received: by mail-ot0-f196.google.com with SMTP id l12so1646808otj.7
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 01:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=h5qQ7HYY7p37NxCJDqVZbyirAGRd2ooKoH2VOmb+L/o=;
        b=RHyODf/47wSRbwRz+Dx/BPON/vjzYMH7mRtevm1YL1lvGcWoAEk14nUOeSrkDwNKmk
         IQTgg8QTUfgEtQK+rwZNHT/XDHcdbBs2Hfh2gSW3D5mz0D4/t0QMT3HQFGgkI/MgwcLv
         /cCV206ovO3BcGeeLiC3bdiFn1CvQ7nXtMv7Y3kRqj2rqAeE3c4x4gpaccmzFV6qRA1r
         BB2aA4GuX/jEsWLxNVghQH1/uCaA4bLbExeJ6kJ9CX42KUQPzgpasjTXFo7COyTAzN+a
         QiOq8btghUHjDARQfrdQjIwXtuFkluvcBkHfOKpoNzSt16iBewNqntGhjaxq597WkNPO
         DGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=h5qQ7HYY7p37NxCJDqVZbyirAGRd2ooKoH2VOmb+L/o=;
        b=Do6ore3BZPscAMyT2XpwoIHJmiadGOTrHxIc4uqogII50QngNw52U4DmqLCQoN18Hk
         ST3K0wDIuTJJWLDMKFerycnNXKOIVWiOIW+bZSQqZ4SiGocQYxQph5S4X0475FqgKMta
         cDhCqKiFQjzUu5oQ2asidWjUyJ3jRC1urn43yWhKoWy1Uw7JDPySm0q2fwskvjmuSpZT
         U+YvzIBHuutUCWdB/Z5MLncwL8MN0lK+bYmRdGJlSxB3ins/j8APBhWYvebDCDkkHZvo
         /1H1jOb+/Tm0S+T8dBW2PDHGxyGiq+19ba/3139Fdpl3xFIWfbVqiX1ifmMW5s6aMfE1
         zAdw==
X-Gm-Message-State: APf1xPD6Q26ao6Gxe+m6BAbMfAIQBLmjtDAi6RnZkdXmmH2hB7ukrf/z
        79Dh1ptWMSSThAkMm6cVdq7TLbUyZ6hf8pGWR6k=
X-Google-Smtp-Source: AG47ELsIuOisYiTPqquP50TPuQSRXOdpEtbbXOlabLuMBYkro33UR1vWpr6uFmNq3dtsDb0wUjrkUT/ZgUAMKtbWGkk=
X-Received: by 10.157.81.92 with SMTP id u28mr12937178oti.152.1519810739374;
 Wed, 28 Feb 2018 01:38:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Wed, 28 Feb 2018 01:38:28 -0800 (PST)
In-Reply-To: <20180227020111.GG4620@genre.crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
 <20180225211212.477570-6-sandals@crustytoothpaste.net> <CACsJy8AnTp1kzwUbAY_9XKg=A6Mo0gUa8o_dimx=+c1rFqu16w@mail.gmail.com>
 <20180227020111.GG4620@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Feb 2018 16:38:28 +0700
Message-ID: <CACsJy8DyrMqNYU7W_cB3U7EEfWUrzWOWx7zGa078EBE38u8Pdw@mail.gmail.com>
Subject: Re: [PATCH v2 05/36] resolve-undo: convert struct resolve_undo_info
 to object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 9:01 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Feb 26, 2018 at 06:25:24PM +0700, Duy Nguyen wrote:
>> On Mon, Feb 26, 2018 at 4:11 AM, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>> > @@ -44,7 +44,7 @@ void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo)
>> >                 for (i = 0; i < 3; i++) {
>> >                         if (!ui->mode[i])
>> >                                 continue;
>> > -                       strbuf_add(sb, ui->sha1[i], 20);
>> > +                       strbuf_add(sb, ui->oid[i].hash, the_hash_algo->rawsz);
>> >                 }
>> >         }
>> >  }
>> > @@ -89,7 +89,7 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
>> >                                 continue;
>> >                         if (size < 20)
>> >                                 goto error;
>> > -                       hashcpy(ui->sha1[i], (const unsigned char *)data);
>> > +                       hashcpy(ui->oid[i].hash, (const unsigned char *)data);
>> >                         size -= 20;
>> >                         data += 20;
>> >                 }
>
> It looks like I may have missed a conversion there.  I'll fix that in a
> reroll.
>
>> Here we see the same pattern again, but this time the @@ lines give
>> better context: these are actually hash I/O. Maybe it's about time we
>> add
>>
>> int oidwrite(char *, size_t , const struct object_id *);
>> // optionally, void strbuf_addoid(struct strbuf *, const struct object_id *);
>> int oidread(struct object_id *, const char *, size_t);
>>
>> for conversion from between an object_id in memory and on disk? It
>> would probably be a straight memcpy for all hash algorithms so we
>> don't really need new function pointers in git_hash_algo for this.
>
> I don't have a strong opinion about adding those or not adding them; if
> people think it makes the code cleaner to read, I'm happy to add them.
> It would probably makes sense to make them inline if we do, so that the
> compiler can optimize them best.

FWIW I'm totally ok with a memcpy(&oid.hash, ..., rawsz); here and not
adding oidread/oidwrite. It's probably best to not adding them this
early anyway. We can always grep memcpy.*rawsz and refactor later.
-- 
Duy
