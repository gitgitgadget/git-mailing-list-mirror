Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB2D21847
	for <e@80x24.org>; Wed,  2 May 2018 15:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeEBP07 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 11:26:59 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:43266 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbeEBP05 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 11:26:57 -0400
Received: by mail-ot0-f177.google.com with SMTP id y10-v6so17014855otg.10
        for <git@vger.kernel.org>; Wed, 02 May 2018 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=BTrtInSdZucJAvyRc0ThQJDAyBVB2NL49/RXRGUf4ew=;
        b=Xw9V3SsXHBooEF2zXndE2nXybSpNk6ndlHAp4jDFsWnnzOzUB8tR2S/p+1jlHFWHeI
         bvZV7YLlx1l/R9iaG/LlHXZMR5gHPZVzaOL1kP5ZwfM0f+Y9uor9z+189lElyCitw1ta
         /vLZoo8v570Y42lwSv9DqVl9hdr94h7i+BCvfMl+ywM9GtvWlxZoeaVespqgsEATbtZn
         Xe2yPCihuOXaQT5RrkMf1pDuBzGz+l6ZZKqNOhFwVc7UAS4uzEKcRRfrgEMOTWpMtqvF
         +v/y02yBYVhnIL0dvXuDdOkfKQkviNhUYUYKwEOYS1IVCcfV5Ekg4ieByze6AKobIHSn
         O+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=BTrtInSdZucJAvyRc0ThQJDAyBVB2NL49/RXRGUf4ew=;
        b=BqPvgHOdZH4UAgRIZ0O3wH+f4TJwEbB0pGvSelwqEWcvZEFRAbdi2YbdXGbdH3AG+M
         Bp9poaZiLgl+L2isrC/7WG3cPTYniG+MWd+7KaFupcDbwrEFGkiE92/zTbn1klZ1GkVJ
         iWRETC6RbsJ5BhWTLiuJuaFt+PlmRegZD5h5j4BXirpmyqU6AdRC8UE8X/RdMqOT3ViC
         UDMYihPaUJ7X315UY6g2RJ5Lmw0EUegwUWJXJtET1DOoC/1JGAYqRCtfXPeBX81MUf2L
         Pk/pMmx4Ra8o8iNleeNt23aEwH5PUnazeTey7tiQX/Xd2e1iZok0a/B7g0CBrPxBByPd
         CQEA==
X-Gm-Message-State: ALQs6tAEfjIrN64qG6aWjdDSiSgOLU6nQkLvHinWYdh0cq+TytAQfto5
        J71GEQPO1RQPchJF/6AdBLCefT1UGDv/nsR4lxg=
X-Google-Smtp-Source: AB8JxZq3ajn4/CdlPUcsA/rbes2zGx+Umsz6dTtjDhw/S7F8tB4fyUjQRcdFigUTsx/Y3lKjij4S1KSefUmG0/W7NeY=
X-Received: by 2002:a9d:2fa6:: with SMTP id r35-v6mr15155820otb.356.1525274816370;
 Wed, 02 May 2018 08:26:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 2 May 2018 08:26:25 -0700 (PDT)
In-Reply-To: <20180502001140.GH13217@genre.crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-9-sandals@crustytoothpaste.net> <20180501102243.GE15820@duynguyen.home>
 <20180502001140.GH13217@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 2 May 2018 17:26:25 +0200
Message-ID: <CACsJy8C1nLTOZFvdgrRYDTXbQhdt5vkbVxHSEiAVuH6Vo8WB_Q@mail.gmail.com>
Subject: Re: [PATCH 08/41] packfile: abstract away hash constant values
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 2:11 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Tue, May 01, 2018 at 12:22:43PM +0200, Duy Nguyen wrote:
>> On Mon, Apr 23, 2018 at 11:39:18PM +0000, brian m. carlson wrote:
>> > There are several instances of the constant 20 and 20-based values in
>> > the packfile code.  Abstract away dependence on SHA-1 by using the
>> > values from the_hash_algo instead.
>>
>> While we're abstracting away 20. There's the only 20 left in
>> sha1_file.c that should also be gone. But I guess you could do that
>> later since you need to rename fill_sha1_path to
>> fill_loose_object_path or something.
>
> I'm already working on knocking those out.

Yeah I checked out your part14 branch after writing this note :P You
still need to rename the function though. I can remind that again when
part14 is sent out.

>> > @@ -507,15 +509,15 @@ static int open_packed_git_1(struct packed_git *p)
>> >                          " while index indicates %"PRIu32" objects",
>> >                          p->pack_name, ntohl(hdr.hdr_entries),
>> >                          p->num_objects);
>> > -   if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) == -1)
>> > +   if (lseek(p->pack_fd, p->pack_size - hashsz, SEEK_SET) == -1)
>> >             return error("end of packfile %s is unavailable", p->pack_name);
>> > -   read_result = read_in_full(p->pack_fd, sha1, sizeof(sha1));
>> > +   read_result = read_in_full(p->pack_fd, hash, hashsz);
>> >     if (read_result < 0)
>> >             return error_errno("error reading from %s", p->pack_name);
>> > -   if (read_result != sizeof(sha1))
>> > +   if (read_result != hashsz)
>> >             return error("packfile %s signature is unavailable", p->pack_name);
>> > -   idx_sha1 = ((unsigned char *)p->index_data) + p->index_size - 40;
>> > -   if (hashcmp(sha1, idx_sha1))
>> > +   idx_hash = ((unsigned char *)p->index_data) + p->index_size - hashsz * 2;
>> > +   if (hashcmp(hash, idx_hash))
>>
>> Since the hash size is abstracted away, shouldn't this hashcmp become
>> oidcmp? (which still does not do the right thing, but at least it's
>> one less place to worry about)
>
> Unfortunately, I can't, because it's not an object ID.  I think the
> decision was made to not transform non-object ID hashes into struct
> object_id, which makes sense.  I suppose we could have an equivalent
> struct hash or something for those other uses.

I probably miss something, is hashcmp() supposed to stay after the
conversion? And will it compare any hash (as configured in the_algo)
or will it for SHA-1 only?

If hashcmp() will eventually compare the_algo->rawsz then yes this makes sense.

>> > @@ -675,7 +677,8 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
>> >     p->pack_size = st.st_size;
>> >     p->pack_local = local;
>> >     p->mtime = st.st_mtime;
>> > -   if (path_len < 40 || get_sha1_hex(path + path_len - 40, p->sha1))
>> > +   if (path_len < the_hash_algo->hexsz ||
>> > +       get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->sha1))
>>
>> get_sha1_hex looks out of place when we start going with
>> the_hash_algo. Maybe change to get_oid_hex() too.
>
> I believe this is the pack hash, which isn't an object ID.  I will
> transform it to be called something other than "sha1" and allocate more
> memory for it in a future series, though.

Ah ok, it's the "sha1" in the name that bugged me. I'm all good then.
-- 
Duy
