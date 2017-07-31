Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44681F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbdGaUaY (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:30:24 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36111 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGaUaX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:30:23 -0400
Received: by mail-lf0-f47.google.com with SMTP id o85so59027201lff.3
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1MVCzbbFx9sg5eqAOQPUVuEF3WF5H2DnkPXePgV/WoU=;
        b=GQBIQhVaXL61/ZgaOmY1smEcYDdoSTql/ytt4zPV/tDVFuh8Xwm/tfg7lVvnzTJbMj
         tFpTanhBnWtNbd8mGJ80azb626/YWHZtZx6Y6TcTvMJJF/vqdEU+VMy6Etp/GwR9XnWq
         Ig+4XClvMHGLm/RfszemCBUFCMwSAt7bpyFmupngj0XEqKkoy/oXbbf+M5G9QySg7EGe
         hB8WAe10zSWAWx2URf5GrlbWQmF4N+41ImCq/XQ8ALdl3CYcj8ck8aUOX5qni+MDsvvQ
         plvTwSZ+aGdCr3eMJr5uQZMjfCmc0hunfOMiGqlS7pBmLGKS7z+1eGI2WhdCgUvDNZEl
         o0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1MVCzbbFx9sg5eqAOQPUVuEF3WF5H2DnkPXePgV/WoU=;
        b=hcGeBWXuunGc2599ic7dKR/CVnt/ZNZAyqiFSWrdbyRCerWTWOXtL+REWO1C3tPVg8
         aGNozYwkDPgl+jqMVW6Btusj35tDyOUZineIT3aGXIqsdbvJ3u8QBo8mNABwY6po+3Ij
         tBmie+tUSRVcQeBzUtkhh523v1IO3BmrDjOIX5IgUBREAccOJ1ITkTLe/LLH7+8z7fz0
         oUZH/pDQiXc5/8gFsbq62lwO8v27hBHcy7DgD5RNz1ygPmDsnJZ98MMFElWzyYhkIzJ8
         Jatg/tJf2Rv+m00MQ5qI09Y7eoWZ+K5jMqulRex/o1ezRntQe8UZLCGT0HbBusbWglQr
         sOmg==
X-Gm-Message-State: AIVw111yd0XxApOWkL1orAQKpcpxtGE5qN74QPm4Oyayg1oG3fO0ZRyD
        rhhWTAhS46RdUPozKXOZKTQ+H2hWMyRQw1M=
X-Received: by 10.25.80.78 with SMTP id z14mr4974801lfj.132.1501533022312;
 Mon, 31 Jul 2017 13:30:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Mon, 31 Jul 2017 13:30:21 -0700 (PDT)
In-Reply-To: <CACBZZX43JFOAOTffWVEMT1fPuzAiZnYi4JoE55QWquZ4kLA2Hg@mail.gmail.com>
References: <20170728171817.21458-1-sbeller@google.com> <20170728171817.21458-3-sbeller@google.com>
 <xmqq379gmco6.fsf@gitster.mtv.corp.google.com> <20170729175833.4idan3befldn5vgp@genre.crustytoothpaste.net>
 <xmqqini9k4cx.fsf@gitster.mtv.corp.google.com> <20170730230019.ch74ska6wgbrh7ql@genre.crustytoothpaste.net>
 <20170730232427.vrqrrhlsap55ax7t@genre.crustytoothpaste.net> <CACBZZX43JFOAOTffWVEMT1fPuzAiZnYi4JoE55QWquZ4kLA2Hg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 31 Jul 2017 13:30:21 -0700
Message-ID: <CAGZ79kZFkNu5zOZk_+ckkVNrU=7chHezPy0rA_A0-CjxFhucAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] t6500: mark tests as SHA1 reliant
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2017 at 1:17 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Jul 31, 2017 at 1:24 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> On Sun, Jul 30, 2017 at 11:00:19PM +0000, brian m. carlson wrote:
>>> Yes, basically, but a bit more generally.  There will always be cases i=
n
>>> which we need to specify an object ID or an arbitrary string and the
>>> behavior will need to vary based on the hash.  That can be something
>>> like, in this case, the two blob contents that would have the similar
>>> prefix.
>>>
>>> So in this case, we pass the helper the string "263 410" and get back a
>>> value for either the hacked SHA-1 hash or the SHA-256 or whatever we're
>>> using.
>>
>> I realize this was worded poorly.  So for my example, in this case, we'd
>> do:
>>
>> test-helper-hash-string "263 410"
>>
>> For SHA-1, we'd get "263 410".  For SHA-256, we'd get "313 481" (which,
>> as SHA-256 blobs, both start with "17" in their hex representation).
>> Presumably we'd read some environment variable to determine the proper
>> value.
>
> I've been mostly out of the loop on this hash transition plan, but
> don't we expect to be compiling a git that knows about both SHA-1 and
> whatever the $newhash is?

That is my understanding as well.

> If so it seems better to just test all N
> hashes we have:
>
>     test_expect_success_hash $desc_description '
>         hash_value=3D$(test-helper-hash-string $CURRENT_HASH)
>         ....
>     '
>
> Then test_expect_success_hash would run N times for the N hashes we have.

I think that is just adding more workload without furthering the stated goa=
l
which is usually reached with just one hash function. The tests we're talki=
ng
about here are not trying to test correctness of hashes but some other
functionality
(correct abbreviation length, collisions in prefix, etc.) that would not ch=
ange
depending on the hash function used, I imagine.

For t0000 we want to have multiple versions, one for each hash.

> This would obviously be slightly more hassle to write & convert, but I
> think it would be worth it, particularly with something like Travis
> where we can test all hashes, instead of being in some mode where we
> fragment on all of hashes/gettext poison and whatever other
> compilation option we have that really requires compiling a new git
> version...
