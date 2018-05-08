Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A6D200B9
	for <e@80x24.org>; Tue,  8 May 2018 18:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755387AbeEHSxO (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 14:53:14 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38001 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754386AbeEHSxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 14:53:13 -0400
Received: by mail-wm0-f54.google.com with SMTP id y189-v6so5147164wmc.3
        for <git@vger.kernel.org>; Tue, 08 May 2018 11:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=W6BhfSYafbD8gG4jtcUmbZz/ONulmXTpbtfqbJV9t7I=;
        b=LDK837gUD9wiBxuKr+QcpdaSGhtJIK1XU6FRFZJ9ABB7MUvBca09j4H6Pu+r0ZAyUL
         GEHZmy6MqFHHtQch2E4sbBkEsxxhSJpkspUH/UPxW/h47j1U0ZQUOPe2gmDzHeAFm+Y+
         h1dn+QGSGmSJ0026O48bKArCFTRIzY1eY1JA/5fQk5AgkWxlbAyRNUF07smRJQKaBGdj
         Z+I8bOs6+1GNsMQIKX6V4h+jnk7xAfp2ahMsK1Sy9kioO7JJHsKgXIwKeukbcHgpk3dD
         JGSUkD9UWbhBjGw7Mmt0F5yJyxDbsRDAsRRla1lYaryE8bgbO2tndDzYjmc1TGRuGacY
         72Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=W6BhfSYafbD8gG4jtcUmbZz/ONulmXTpbtfqbJV9t7I=;
        b=XdTDwy/CuUz75yd9VKIloN6sEM7ukQJRlHdAnOgFi7XzHmukRBk2sJrCfvQEIGQISQ
         DCDMsFVAJ12vkzxV36DYYiCEuJdO39W8F6Sa6MILRABr8CEzxGWrNA1LFVOSfinERfMk
         mHN7km7rSmOyRd+aiTg/vh/Q7mJ2zXnLEayQcFO+/ueWLnjmMdbTLPmgdjzcHtAe05iB
         1AbYaSE620p4pQtkLcBhGDWGoohdI/cRke1JCNxk/n8CN1RIAL05K0tTdNcBhMkH31fL
         4X7YWwEForKBUh2W9MGga0ciXMKkdGmHiZ2ncrY/VpDaJfyFY6U6ROo5AhDdmr51sOZr
         PBaA==
X-Gm-Message-State: ALQs6tDB7dF2Qu/XGR4yrdtiKeJQ8X7D+BGhbDhLbG7OREL8g6XqNzHD
        QjqUtVUinR8kVv2UXH9CMWo=
X-Google-Smtp-Source: AB8JxZrFmu/bbPL3yKsAPi1qIOenU2t6Xzw/nPO8L4MTgT13nVLkFIie088p4LZw8pf0zXJnCIFC2g==
X-Received: by 2002:a50:98e2:: with SMTP id j89-v6mr55931929edb.8.1525805592449;
        Tue, 08 May 2018 11:53:12 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id w26-v6sm14035075edq.77.2018.05.08.11.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 11:53:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 09/12] get_short_oid / peel_onion: ^{tree} should be tree, not treeish
References: <20180501184016.15061-1-avarab@gmail.com>
        <20180501120651.15886-1-avarab@gmail.com>
        <20180501184016.15061-10-avarab@gmail.com>
        <xmqqzi1htij7.fsf@gitster-ct.c.googlers.com>
        <87wowlxko8.fsf@evledraar.gmail.com>
        <xmqqvac4tb64.fsf@gitster-ct.c.googlers.com>
        <87lgczyfq6.fsf@evledraar.gmail.com>
        <xmqq6040qf8x.fsf@gitster-ct.c.googlers.com>
        <20180508143408.GA30183@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180508143408.GA30183@sigill.intra.peff.net>
Date:   Tue, 08 May 2018 20:53:10 +0200
Message-ID: <87a7tax9m1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 08 2018, Jeff King wrote:

> On Mon, May 07, 2018 at 01:08:46PM +0900, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>> > Right, and I'm with you so far, this makes sense to me for all existing
>> > uses of the peel syntax, otherwise v2.17.0^{tree} wouldn't be the same
>> > as rev-parse v2.17.0^{tree}^{tree}...
>>
>> More importantly, you could spell v2.17.0 part of the above with a
>> short hexadecimal string.  And that string should be naming some
>> tree-ish, the most important thing being that it is *NOT* required
>> to be a tree (and practically, it is likely that the user has a
>> tree-ish that is *NOT* a tree).
>>
>> I guess I have a reaction to the title
>>
>>     "get_short_oid/peel_onion: ^{tree} should be tree"
>>
>> "X^{tree}" should *RESULT* in a tree, but it should *REQUIRE* X to
>> be a tree-ish.  It is unclear "should be tree" is about the former
>> and I read (perhaps mis-read) it as saying "it should require X to
>> be a tree"---that statement is utterly incorrect as we agreed above.
>
> FWIW, I had the same feeling as you when reading this, that this commit
> (and the one after) are doing the wrong thing. And these paragraphs sum
> it up. The "^{tree}" is about asking us to peel to a tree, not about
> resolving X in the first place. We can use it as a _hint_ when resolving
> X, but the correct hint is "something that can be peeled to a tree", not
> "is definitely a tree".

Maybe I'm just being dense, but I still don't get from this & Junio's
E-Mails what the general rule should be.

I think a response to the part after "leaving that aside" of my upthread
E-Mail
(https://public-inbox.org/git/87lgczyfq6.fsf@evledraar.gmail.com/) would
help me out.

Not to belabor the point, but here's a patch I came up with to
revisions.txt that's a WIP version of something that would describe the
worldview after this v3:

    diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
    index dfcc49c72c..0bf68f4ad2 100644
    --- a/Documentation/revisions.txt
    +++ b/Documentation/revisions.txt
    @@ -143,29 +143,52 @@ thing no matter the case.
       '<rev>{caret}1{caret}1{caret}1'.  See below for an illustration of
       the usage of this form.

     '<rev>{caret}{<type>}', e.g. 'v0.99.8{caret}\{commit\}'::
       A suffix '{caret}' followed by an object type name enclosed in
       brace pair means dereference the object at '<rev>' recursively until
       an object of type '<type>' is found or the object cannot be
    -  dereferenced anymore (in which case, barf).
    +  dereferenced anymore (in which case either return that object type, or barf).
       For example, if '<rev>' is a commit-ish, '<rev>{caret}\{commit\}'
       describes the corresponding commit object.
       Similarly, if '<rev>' is a tree-ish, '<rev>{caret}\{tree\}'
       describes the corresponding tree object.
       '<rev>{caret}0'
       is a short-hand for '<rev>{caret}\{commit\}'.
     +
     'rev{caret}\{object\}' can be used to make sure 'rev' names an
     object that exists, without requiring 'rev' to be a tag, and
     without dereferencing 'rev'; because a tag is already an object,
     it does not have to be dereferenced even once to get to an object.
     +
     'rev{caret}\{tag\}' can be used to ensure that 'rev' identifies an
     existing tag object.
    ++
    +Object types that don't have a 1=1 mapping to other object types
    +cannot be dereferenced with the peel syntax, and will return an
    +error. E.g. '<treeid>{caret}{commit}' or '<treeid>{caret}{tree}' is
    +allowed because a tag can only point to one commit, and a commit can
    +only point to one tree. But '<treeid>{caret}{blob}' will always
    +produce an error since trees in general don't 1=1 map to blobs, even
    +though the specific '<treeid>' in question might only contain one
    +blob. Note that '<tagid>{caret}{blob}' is not an error if '<tagid>' is
    +a tag that points directly to a blob, since that again becomes
    +unambiguous.
    ++
    +'<rev>{caret}{<type>}' takes on a different meaning when '<rev>' is a
    +SHA-1 that's ambiguous within the object store. In that case we don't
    +have a 1=1 mapping anymore. E.g. e8f2 in git.git can refer to multiple
    +objects of all the different object types. In that case
    +{caret}{<type>} should always be an error to be consistent with the
    +logic above, but that wouldn't be useful to anybody. Instead it'll
    +fall back to being selector syntax for the given object types,
    +e.g. e8f2{caret}{tag} will (as of writing this) return the v2.17.0
    +tag, and {caret}{commit}, {caret}{tree} and {caret}{blob} will return
    +commit, tree and blob objects, respectively.
    +
    [...]

My understanding of what you two are saying is that somehow the peel
semantics should be preserved when we take this beyond the 1=1 mapping
case, but I don't see how if we run with that how we wouldn't need to
introduce the concept of blobish for consistency as I noted upthread.

So it would be very useful to me if you or someone who understands the
behavior you & Junio seem to want could write a version of the patch I
have above where the last paragraph is different, and describes the
desired semantics, because I still don't get it. Why would we 1=many
peel commits to trees as a special case, but not 1=many do the same for
trees & blobs?
