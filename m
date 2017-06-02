Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6DDE20D12
	for <e@80x24.org>; Fri,  2 Jun 2017 08:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbdFBIxK (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 04:53:10 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35899 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdFBIxG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 04:53:06 -0400
Received: by mail-it0-f46.google.com with SMTP id m47so552955iti.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 01:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fSI3o5F93Hyeeyl6/h/suuOAXtpf4Zzs4D9FaTfnAFI=;
        b=UNMV7aR+3uVFLCgFvtHaqfrX7RlmAftIZmjqhQMr5mxAN4bd+yw8MyhFWP7HKyT21F
         JE0hsZL1bjSZtPvHn4zcH+olHOQXNCwx2miHmM5ifTb66lk1hWNYCxOHAuqIhbd2pqyz
         GS+i85omKCb6RJ6lScRk4Y7Q9gQJ48pweZghw3mnu+8/+l5I5CfD2M0jiz2uVaZ9eRJc
         YNNPZZayR573La3k1ppbjfyG4/GMOFmbXSs+OahHELOpZBh4aE9lW/LTz6u80S4WTYTL
         k8RURJ+DlpigAkAGnUDiStuB5uTm26BusHoYyJM+Td8Lu8DSKgQUoEDPJS/mpVEaBhqs
         9sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fSI3o5F93Hyeeyl6/h/suuOAXtpf4Zzs4D9FaTfnAFI=;
        b=IVquyS6eAHK4YgrMI4RJFqykWBFlbuV2BJibOc7YAICdsWctMY3HjTMh6BFiai6+kE
         Zp4uH3OKua7Xr51dGN9nge0IEkGrB4D3trvzIAokFMqr1oZxtU/TdSu1mE/ehqHbjPv3
         r6X468uY20jL0ch4uhfEo8aCFZzORGH8Ob4UXdwYoOPo2oz8sXpW91s4RdvXNZkyYWt7
         4Oo0TrRMK6gjfQbgVbZa2ZDICssW+MJi/VVknGmFPg4oLMVUc4utk3rszSbTrWPU5jJq
         RBEZhCDfpdvE64sdEe/iUPglhmjPkCwheazG5xjtD1y0e+jx9FxxE03w5JMXCrS+tH4k
         G97g==
X-Gm-Message-State: AODbwcDkoEtF8oBv8RZ07bmysbCAN34Cu86Ll+VGqQOstlvgOyVaRP3C
        HR3/0GI8hG98XIifaBiRPGX9xS76Ew==
X-Received: by 10.36.166.4 with SMTP id q4mr3400616ite.66.1496393521715; Fri,
 02 Jun 2017 01:52:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 2 Jun 2017 01:51:40 -0700 (PDT)
In-Reply-To: <xmqq37bj454a.fsf@gitster.mtv.corp.google.com>
References: <mvm4lw0un5n.fsf@suse.de> <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
 <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com> <mvmmv9st3yv.fsf@suse.de>
 <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
 <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
 <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
 <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com> <xmqq37bj454a.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 2 Jun 2017 10:51:40 +0200
Message-ID: <CACBZZX7EvUqH28uni+r=RUBXb9=WTp732B4=rq+ViD_kecxZaw@mail.gmail.com>
Subject: Re: Unaligned accesses in sha1dc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2017 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> I looked into this some more. It turns out it is possible to trigger
>> undefined behavior on "next". Here's what I did:
>> ...
>>
>> This "fixes" the problem:
>> ...
>> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
>> index 3dff80a..d6f4c44 100644
>> --- a/sha1dc/sha1.c
>> +++ b/sha1dc/sha1.c
>> @@ -66,9 +66,9 @@
>> ...
>> With this diff, various tests which seem relevant for SHA-1 pass,
>> including t0013, and the UBSan-error is gone. The second diff is just
>> a monkey-patch. I have no reason to believe I will be able to come up
>> with a proper and complete patch for sha1dc. And I guess such a thing
>> would not really be Git's patch to carry, either. But at least Git
>> could consider whether to keep relying on undefined behavior or not.
>>
>> There's a fair chance I've mangled the whitespace. I'm using gmail's
>> web interface... Sorry about that.
>
> Thanks.  I see Marc Stevens is CC'ed in the thread, so I'd expect
> that the final "fix" would come from his sha1collisiondetection
> repository via =C3=86var.
>
> In the meantime, I am wondering if it makes sense to merge the
> earlier update with #ifdef ALLOW_UNALIGNED_ACCESS and #ifdef
> SHA1DC_FORCE_LITTLEENDIAN for the v2.13.x maintenance track, which
> would at least unblock those on platforms v2.13.0 did not work
> correctly at all.
>
> =C3=86var, thoughts?

I think we're mixing up several things here, which need to be untangled:

1) The sha1dc works just fine on most platforms even with undefined
behavior, as evidenced by 2.13.0 working.

2) There was a bug in practice with unaligned access on SPARC. It's
not clear to me whether anyone (Andreas, Liam?) still has any issues
in practice on any platform without specifying compile flags like what
Martin =C3=85gren suggested above.

Andreas: Is your initial report of unaligned access here fixed in the
next branch with my "sha1dc: update from upstream" commit? You didn't
say what platform you were on.

Liam: How about your issue on SPARC?

3) Now we have another issue reported by Martin =C3=85gren here, which is
that while the code works in practice on most platforms it's using
undefined behavior. On my GCC 7.1.1 it's sufficient to:

    make -j8 CFLAGS=3D"-fsanitize=3Dundefined
-fsanitize-recover=3Dundefined" LDFLAGS=3D"-fsanitize=3Dundefined
-fsanitize-recover=3Dundefined" all

And then run e.g.:

    ./t0020-crlf.sh -v

To get spiel like:

    sha1dc/sha1.c:346:2: runtime error: load of misaligned address
0x5610bf16d005 for type 'const uint32_t', which requires 4 byte
alignment
    0x5610bf16d005: note: pointer points here
     65 6e 74 20 66 30 34  66 61 39 37 36 36 64 62  62 38 65 34 63 37
33 38  34 37 30 61 31 36 63 61  62

I think that this is definitely something worth looking into /
coordinating with upstream, but I haven't seen anything to suggest
that we need to be rushing to get a patch in to fix this given 1) and
nobody saying yet that 2) doesn't solve their issue as long as they're
not supplying some -fsanitize=3D* flags.

Now, stepping a bit back from this whole thing: I didn't read the
entire discussion back in February when sha1dc was integrated, but I
really don't see given all this churn / bug reporting we're getting
now why another acceptable solution wouldn't be to just revert
e6b07da278 ("Makefile: make DC_SHA1 the default", 2017-03-17) &
release 2.13.1 with that.

Clearly there are outstanding issues with it, and needing to do a
memcpy() as my `next` patch does will harm performance on some
platforms, and something like Martin's patch on top will slow it down
even more.

It seems to me that we should give it more time to cook, and better
understand the various trade-offs involved. The shattered attack is
very unlikely to impact anything in practice, and users who are
paranoid about it can opt-in to this extra protection.
