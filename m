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
	by dcvr.yhbt.net (Postfix) with ESMTP id 156892023D
	for <e@80x24.org>; Thu,  3 May 2018 07:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750945AbeECH22 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 03:28:28 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33167 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeECH20 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 03:28:26 -0400
Received: by mail-wm0-f48.google.com with SMTP id x12-v6so1706424wmc.0
        for <git@vger.kernel.org>; Thu, 03 May 2018 00:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CWDCXxmMd/9pZww4a9EZT7EIe0uccg6akTeZBzuVUjA=;
        b=aI7LgXJ6uv5EtRLGwBxektEzf7BltqjQLBkNMQ1Egv/pCe1I0XmnOL55ADE0Z4hqdU
         rND4xa2pbPf7e7sNcOuHT2MdDLXjUARM+yMCR9OyJOuY88/vtw1H6luvfGNoBNPSvQ3/
         WQy/6+r8gBcdMoTTNFqV/FxRVwTUSeqJfq4peFApnh2mWABl0AjxfUBi9mZZmNc13CPQ
         QlfXceD5oailqSyR9FULnTsW73XawGhI0A9CXLPo6lYQr0vtiJyZ5WQKScbEn4piZYj3
         yZ7qI9f9c0PFQ2LIK1cAg1fm861v1PYbARL3hkmgfQjWaT2odrC+gkdJj916S9Td3v08
         VR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=CWDCXxmMd/9pZww4a9EZT7EIe0uccg6akTeZBzuVUjA=;
        b=d7vPG6X0jJtlkG3NTUTwrL/bySHIASp3xZKsaK86PLv1DDs1q7mpL9OpFPGFMmn4Tq
         kHwjugu41aSTkJCNEsUrarP4wWnIjpaQtlX+gftJXcykbEHmnwQJULSkLkLhs9FSUQ1/
         fkcS24fUYBjFcG2R/FxOJlhH3VdhRllY7ZM+tOExWpULAPPjBisAnW3QjPhnwTSIB6Hz
         +/TleaXZ7Ngle++kirl3bNZpP+TXVDTK2zKp5C0WOUd17xWPPw/Hg6ZBlnu4Jszqxqkj
         OLIh6TkZ1UJXmNXrJ2/3NFGG07/iFvAN5HZGxAy+QPx81MODLXPrNBOQ2G0ubg52Mbgp
         MA1w==
X-Gm-Message-State: ALQs6tCvHkZGljOswG1IRX8fvwtaD8ghHiCDnj1r/9kahv3LP5j26Zrs
        RnWg/OpKzF+D1YntGXki4h0=
X-Google-Smtp-Source: AB8JxZpiShCCptYyrmwi+jcAGW3gSMHPAiUdylwxbnFmZGfMVS4kAMTl8d1A2qdydfouu7F9tccJ9A==
X-Received: by 2002:a50:cfca:: with SMTP id i10-v6mr30466124edk.35.1525332505581;
        Thu, 03 May 2018 00:28:25 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id r48-v6sm8042562edd.16.2018.05.03.00.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 00:28:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 09/12] get_short_oid / peel_onion: ^{tree} should be tree, not treeish
References: <20180501184016.15061-1-avarab@gmail.com>
        <20180501120651.15886-1-avarab@gmail.com>
        <20180501184016.15061-10-avarab@gmail.com>
        <xmqqzi1htij7.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqzi1htij7.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 03 May 2018 09:28:23 +0200
Message-ID: <87wowlxko8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 03 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> But ^{tree} shows just the trees, but would previously be equivalent
>> to the above:
>>
>>     $ git rev-parse e8f2^{tree}
>>     error: short SHA1 e8f2 is ambiguous
>>     hint: The candidates are:
>>     hint:   e8f2093055 tree
>>     hint:   e8f25a3a50 tree
>>     hint:   e8f28d537c tree
>>     hint:   e8f2cf6ec0 tree
>>     [...]
>
> When a user says "git $cmd e8f2^{tree}", the user is telling Git
> that s/he knows e8f2 *is* a tree-ish, but for whatever reason $cmd
> wants a tree and does not accept an arbitrary tree-ish---that is the
> whole piont of appending ^{tree} as a suffix.  A useful hint in such
> a case would be "oh, you said e8f2 is a tree-ish, but there are more
> than one tree-ish, so let me show them to you to help you decide
> which one among them is the one you meant".  When $cmd is rev-parse,
> I would even say that the user is saying "I know e8f2 is a tree-ish,
> and I know it not a tree--it merely is a tree-ish.  I want the tree
> that e8f2 thing points at".
>
> Limiting that hint to show only real trees does not make any sense
> to me.  I do not think we care _too_ deeply, because most of the
> time, command line location that expects a tree-ish can be given a
> tree-ish, so there is not much reason to use ^{tree} suffix these
> days.  But in a case where it _does_ matter, I think this change
> makes the "hint" almost useless.
>
> Or am I misleading what you wanted to achieve with this patch?

The reason I'm doing this is because I found it confusing that I can't
do:

    for t in tag commit tree blob; do ./git --exec-path=$PWD rev-parse 7452^{$t}; done

And get, respectively, only the SHAs that match the respective type, but
currently (with released git) you can do:

    for t in tag commit committish treeish tree blob; do git -c core.disambiguate=$t rev-parse 7452; done

And while =tag doesn't work the others do (inluding =blob), so
core.disambiguate=tree gives you just trees, but ^{tree} gives you
treeish.

Why should ^{tree} be giving me ^{treeish} but =tree be giving me trees,
and =treeish be synonymous with ^{tree}?

There's no other cases I know of where the ^{<type>} peel syntax won't
give you *only* the <type> you asked for. See peel_onion() ->
peel_to_type() and how get_oid_1() will short-circuit if it has an
answer, and then finally fall back to this get_short_oid() codepath.

Looking at the code & git log maybe it'll do that internally, but when
you peel a tag or commit ^{tree} will only ever find one thing, unlike
this disambiguation case where we can match multiple things.

So:

1) Am I missing some subtlety or am I correct that there was no way to
get git to return more than one SHA-1 for ^{commit} or ^{tree} before
this disambiguation feature was added?

2) I think the behavior I've implemented is consistent with how the peel
syntax has been documented in revisions.txt:

    '<rev>{caret}{<type>}', e.g. 'v0.99.8{caret}\{commit\}'::
      A suffix '{caret}' followed by an object type name enclosed in
      brace pair means dereference the object at '<rev>' recursively until
      an object of type '<type>' is found or the object cannot be
      dereferenced anymore (in which case, barf).
      For example, if '<rev>' is a commit-ish, '<rev>{caret}\{commit\}'
      describes the corresponding commit object.
      Similarly, if '<rev>' is a tree-ish, '<rev>{caret}\{tree\}'
      describes the corresponding tree object.
      '<rev>{caret}0'
      is a short-hand for '<rev>{caret}\{commit\}'.

Note "until an object of type '<type>' is found". I.e. my mental model
of this has been that yes you can *start* the search at a different
object (e.g. tag -> tree), but it'll only ever return the tree. The
disambiguation implementation has been inconsistent with this as
documented, because it hasn't been drilling don to an object of '<type>'
given a request like $short^{<type>}, but rather returning something
matching $short because it could be a container for <type>.

Anyway, I'm not saying I'm right. This is the first time I really look
at sha1-name.c in any detail. But the above describes the thought
process behind this patch.
