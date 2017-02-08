Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50C21FCC7
	for <e@80x24.org>; Wed,  8 Feb 2017 08:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933114AbdBHIiB (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 03:38:01 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:33715 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933168AbdBHIh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 03:37:57 -0500
Received: by mail-ot0-f180.google.com with SMTP id 73so11530270otj.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 00:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iLOwWva65sbkFWkdWbrgODZb8R+iK8jRsu4VQkVcLrs=;
        b=ltLKqN3RqzMmmlnUFoHyhMTwQ1iHgdDPi5r0wixkzXrR/aMqBGFRZIfoKk6zMeiSoy
         AuQHQ89wXfcBXuyxO5xxDp412sk5H7BK519cLpj8CixE7jf5R5PcIPX4RVVCWDHjbf6A
         dzHviU04XQPdi3uBIUWy0WlM0CQ8isiD55OC948M60dONktB6mBkmnhCaRnOB9AeDTgc
         cQAvsr2tYVof+l/WWUNPNDA/oTPxRRXfIaxb+n24pw5WPLYrL5JbJlflsbZisoynvfUz
         07HAeBLp7McBexbIbRhFfNwubvWHYqXavUYeblSbIejkHz63+FNogI2vPupseYcIAi/p
         Hc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iLOwWva65sbkFWkdWbrgODZb8R+iK8jRsu4VQkVcLrs=;
        b=jeLhCRHTuUX56Gohc+30ShM3GlJ6aSz2Srd4nMcWRnWugmO8ik3xp8TpLNm3PRXneO
         rYkeqr+XzHu2NHGH/l9KONvFDYebrpyaxyN7veXfVXKtuY9x6EP7l7TmUC0+O+x0Wwyf
         ef39nfjRdxHKQMaCtbnauZZ49lev8eLu4dECjqJY1TUeZknRVpcoKD51RGVJ4vUebIiq
         iMuUYBx3q6EOcCM+L7swGiBcf7OTRjBK053slhfm5Q8X5MwajKhA0rcanK6xd3bTCTz5
         tmTqnAzGsvI/4gGRtKya/up2hsp3HOy2RiQEcLGLmj2f0sunkdXPE9uYIm36DT1GDcpA
         6ELg==
X-Gm-Message-State: AMke39nFLGfOPXfYrnMghv8NaaHr/KVFhUIr1T00Yi5KUsWe9NDHJCyfv575jdckFw0FaOaSeACoFJetW+zS0Q==
X-Received: by 10.157.39.35 with SMTP id r32mr9426033ota.199.1486543074964;
 Wed, 08 Feb 2017 00:37:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Wed, 8 Feb 2017 00:37:24 -0800 (PST)
In-Reply-To: <1486542299.1938.47.camel@novalis.org>
References: <1481922331.28176.11.camel@frank> <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
 <CACsJy8ACy+Hv1Z3FgG-WFBozwWqmMuN-JnMWF-+rdpF0knFjqg@mail.gmail.com>
 <1486515795.1938.45.camel@novalis.org> <CACsJy8C81+D=UG4pZ4e+URQqKRCPG=5bLiCHbGCQamvE-2y2MQ@mail.gmail.com>
 <1486542299.1938.47.camel@novalis.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 8 Feb 2017 15:37:24 +0700
Message-ID: <CACsJy8C4DO-GYREUhED3YU_WetoTZaB3MUq1kGfRjA3e-FOLYQ@mail.gmail.com>
Subject: Re: "disabling bitmap writing, as some objects are not being packed"?
To:     David Turner <novalis@novalis.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 3:24 PM, David Turner <novalis@novalis.org> wrote:
> On Wed, 2017-02-08 at 13:45 +0700, Duy Nguyen wrote:
>> On Wed, Feb 8, 2017 at 8:03 AM, David Turner <novalis@novalis.org> wrote:
>> > On Sat, 2016-12-17 at 14:50 +0700, Duy Nguyen wrote:
>> >> And we can't grep for fatal errors anyway. The problem that led to
>> >> 329e6e8794 was this line
>> >>
>> >>     warning: There are too many unreachable loose objects; run 'git
>> >> prune' to remove them.
>> >>
>> >> which is not fatal.
>> >
>> > So, speaking of that message, I noticed that our git servers were
>> > getting slow again and found that message in gc.log.
>> >
>> > I propose to make auto gc not write that message either. Any objections?
>>
>> Does that really help? auto gc would run more often, but unreachable
>> loose objects are still present and potentially make your servers
>> slow? Should these servers run periodic and explicit gc/prune?
>
> At least pack files wouldn't accumulate.  This is the major cause of
> slowdown, since each pack file must be checked for each object.
>
> (And, also, maybe those unreachable loose objects are too new to get
> gc'd, but if we retry next week, we'll gc them).

I was about to suggest a config option that lets you run auto gc
unconditionally, which, I think, is better than suppressing the
message. Then I found gc.autoDetach. If you set it to false globally,
I think you'll get the behavior you want.

On second thought, perhaps gc.autoDetach should default to false if
there's no tty, since its main point it to stop breaking interactive
usage. That would make the server side happy (no tty there).
-- 
Duy
