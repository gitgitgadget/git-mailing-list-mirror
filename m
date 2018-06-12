Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFAF11F403
	for <e@80x24.org>; Tue, 12 Jun 2018 07:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754160AbeFLH3t (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 03:29:49 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35484 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754114AbeFLH3s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 03:29:48 -0400
Received: by mail-yb0-f194.google.com with SMTP id f79-v6so7596359ybg.2
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 00:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=9WpkbX64MrQ0zkfeSb9xmXy6gQMcFMSwLzn68PBfWL8=;
        b=KoWbxai1wqczYcT1u+UUksr8VXUYse/1CMfR3BRKmEIdlaErfK7l9Mp8BZrzFJUfni
         MRsTg0XF2Nz/Z4RvDexJF+O+hMLUHkOHFO5MWl65XwC48BCWY/o+S+C5cMqCQnpZCgyG
         uluo7Ba4TiRQYjOJOInfXP4DvBovhC+ME8TJGay/m3oWjs3hu6LGayMlOKhvQ9aSG3hj
         5ECLU6C9zbx2P45oCr3kZNc2UJxSHPHy9CwOXRAkseHDgsnUeRaxzSbTdR5HpIU+6CWK
         GyZduO9KkwoFaQ0J74jM6uhxPsO2AR/HgcWuavk9Ch+IqTp7mwjYEyF4fqhjc9ONkJwg
         FCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=9WpkbX64MrQ0zkfeSb9xmXy6gQMcFMSwLzn68PBfWL8=;
        b=YqOFwDzZPTvmaQwACist3rMUDfKDGZs5h6Tgex04MqUgROMaFQUiI7YVkn3cSZNa3i
         n4Y6aLz8xvlpuy8XDvnV2/ecc0rmlVDaLIY6gaHnjZ9SQG39AxNsCFccNE4Nz1WaeyLm
         Wa3hzMnvmuDk2nZGXqpkSHldYYpHT6dWu4jrC8rL28TA9RAkELQd+MnQXOwd1+Hxkarw
         wc/x+E6mJEyPg7xxVlDbEEsQqCjAvPKBt9yHVyAjovcuQysazd3Z9BKOgc2ujfDMEUpl
         snDB61iwgu2aVGFBB0PD5WIE/uC6qskmPOWAc8ligBoGh1YV+sjSrUdD+e3UKV5do/Wx
         7vCQ==
X-Gm-Message-State: APt69E1Eap7a9pwWafdE/YPyJESlsHhyNpUimlQ+njk4oFdDmvbmhwsh
        29tsqm7009VQtBcAlcl1i10+dNoLHGNhzDUT/g0=
X-Google-Smtp-Source: ADUXVKKDtvL2+U12PoYL2dXPFCwhxKmCs1GvPQ2t84j2tTS1psnasChD4jiYcxB6U+EY92HXHnGWGRaUSDzG++c2mpk=
X-Received: by 2002:a25:83c6:: with SMTP id v6-v6mr932715ybm.263.1528788588094;
 Tue, 12 Jun 2018 00:29:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3dc7:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 00:29:47
 -0700 (PDT)
In-Reply-To: <20180612010513.GH38834@genre.crustytoothpaste.net>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
 <20180604235229.279814-2-sandals@crustytoothpaste.net> <20180611074743.GA24066@flurp.local>
 <20180612010513.GH38834@genre.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Jun 2018 03:29:47 -0400
X-Google-Sender-Auth: 4jIR7MAHxZrtr0_6V0OHzAIX5vw
Message-ID: <CAPig+cSEpCTg+rYQYNQ5wUz3PL+51dr7bQdn-2cOWgg2ScdXNA@mail.gmail.com>
Subject: Re: [PATCH 01/10] t: add tool to translate hash-related values
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 9:05 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Jun 11, 2018 at 03:47:43AM -0400, Eric Sunshine wrote:
>> The word "translate" is very generic and is (at least in my mind)
>> strongly associated with i18n/l10n, so the name test_translate() may
>> be confusing for readers. Perhaps test_oid_lookup() or test_oid_get()
>> or even just test_oid()?
>
> test_oid would be fine.  One note is that this doesn't always produce
> OIDs; sometimes it will produce other values, but as long as you don't
> think that's too confusing, I'm fine with it.

It was surprising to see it used for non-OID's (such as hash
characteristics), but not hard to deal with.

One could also view this as a generic key/value cache (not specific to
OID's) with overriding super-key (the hash algorithm, in this case),
which would allow for more generic name than test_oid(), but we don't
have to go there presently.

>> This is a very expensive lookup since it invokes a heavyweight command
>> (perl, in this case) for *every* OID it needs to retrieve from the
>> file. Windows users, especially, will likely not be happy about this.
>> See below for an alternative.
>
> I agree perl would be expensive if it were invoked frequently, but
> excepting SHA1-prerequisite tests, this function is invoked 32 times in
> the entire testsuite.
>
> One of the reasons I chose perl was because we have a variety of cases
> where we'll need spaces in values, and those tend to be complex in
> shell.

Can you give examples of cases in which values will contain spaces? It
wasn't obvious from this patch series that such a need would arise.

Are these values totally free-form? If not, some character (such as
"_", "-", ".", etc.) could act as a stand-in for space. That shouldn't
be too hard to handle.

>> Here's what I had envisioned when reading your emails about OID lookup
>> table functionality:
>>
>> --- >8 ---
>> test_oid_cache () {
>>     while read tag rest
>>     do
>>         case $tag in \#*) continue ;; esac
>>
>>         for x in $rest
>>         do
>>             k=${x%:*}
>>             v=${x#*:}
>>             if test "$k" = $test_hash_algo
>>             then
>>                 eval "test_oid_$tag=$v"
>>                 break
>>             fi
>>         done
>>     done
>> }
>
> Using shell variables like this does have the downside that we're
> restricted to only characters allowed in shell variables.  That was
> something I was trying to avoid, but it certainly isn't fatal.

Is that just a general concern or do you have specific "weird" keys in mind?

>> test_detect_hash() would detect the hash algorithm and record it
>> instead of having to determine it each time an OID needs to be
>> "translated". It probably would be called by test-lib.sh.
>
> We'll probably have to deal with multiple hashes in the future,
> including for input and output, but this could probably be coerced to
> handle that case.

My original version of test_oid_cache() actually allowed for that by
caching _all_ information from the tables rather than only values
corresponding to $test_hash_algo. It looked like this:

--- >8 ---
test_oid_cache () {
    while read tag rest
    do
        case $tag in \#*) continue ;; esac

        for x in $rest
        do
            eval "test_oid_${tag}_${x%:*}=${x#*:}"
        done
    done
}
--- >8 ---

The hash algorithm is incorporated into the cache variable name like
this: "test_oid_hexsz_sha256"

>> And, when specifying values from which to choose based upon hash
>> algorithm:
>>
>>     $(test_oid bored sha1:deadbeef NewHash:feedface)
>
> This syntax won't exactly be usable, because we have to deal with spaces
> in values.  It shouldn't be too much of a problem to just use
> test_oid_cache at the top of the file, though.

See above about possibly using a stand-in character for space.

>> A nice property of how this implementation caches values is that you
>> don't need test_oid() for really simple cases. You can just access the
>> variable directly. For instance: $test_oid_hexsz
>
> Because we're going to need multiple hash support in the future, for
> input, output, and on-disk, I feel like this is not a good direction for
> us to go in the testsuite.  Internally, those variable names are likely
> to change.

Indeed, this isn't a real selling point; I only just thought of it
while composing the mail. Going through the API is more robust.
(Although, see above how the revised test_oid_cache() incorporates the
hash algorithm into the cache variable name.)
