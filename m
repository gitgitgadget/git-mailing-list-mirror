Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329071FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 15:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbcLSObJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 09:31:09 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:34529 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755298AbcLSOal (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 09:30:41 -0500
Received: by mail-io0-f171.google.com with SMTP id p42so153754615ioo.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 06:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1BVBTaaczRFO9OeUWFzHcY/kEdIvPEDbMg4DylybrOs=;
        b=avv2d/l2UJOkLea7Y+4PCkJXGxg8ThSKetcWXWTWqE0lxYyI652zDHwwzQ0sELOsEE
         JhT/NIblMWRr88paAlD01fVWxornEdopBDIKqTwXLdcKDs0EGkSgHEx48AoP+v0sjqt9
         PbVyjjYTBI5FXAgEWqxHAVIjHSuLHrC5yJ1iGfqoReyWRBxy2bp2IG7enY/bQi+ZzJ12
         YDpySQifOfF8HgMJvS04j68vJbl7dzxJZ3cMRKvw2/X24X8ef6OZQ17toGrc+TUUMXXk
         U+abWy5VETU8EDF9ATK2rqcnQ6xFKXvCaDpsbWW8VWi9pprBkF0AYQgfoBWaZc/0XcJE
         gNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1BVBTaaczRFO9OeUWFzHcY/kEdIvPEDbMg4DylybrOs=;
        b=rEOvSg2qeOaTct1cXndMPLy1Vmo6LR3a2Zp0Ckozo/Enpq4zcavDBJxIlp8lh0Z+kK
         DUnzRwxTYKNpgC9B6JOjJSMmIfnKZJiF6vpZXleS0I7jgVffGI7/+8ys6JtTQDeUZx4b
         c8eSMfZWg999qV7Y9jkubC4wtd/3nj8pVknEFdJikCB/xKjFpK3X+fp8ZMaXIB3n4M/w
         rdmzU4Jq32O0kRrZebgqx/7+gWI+R+jIv4MT9oDUDR79fmgi5fF7RU4UwNaBDv6ZUfm4
         1wW3zI/iotflrWFiWEMx7Vaid9pL/PVGaq05uL3fYG/xCqAaUiSaB2sU+94NoFGrlsXt
         sQ9A==
X-Gm-Message-State: AIkVDXIs1FqwDaJ84+gmqlwIRtkCOB22crdsC1UOyYYGVJyQmfg2WPGJ5icb5C6oaSkfN3iJd9RLHtbmY2m+Tw==
X-Received: by 10.107.59.9 with SMTP id i9mr17252874ioa.176.1482157840350;
 Mon, 19 Dec 2016 06:30:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Mon, 19 Dec 2016 06:30:09 -0800 (PST)
In-Reply-To: <20161219140535.ehrbosgn32nl27ki@sigill.intra.peff.net>
References: <20161214151009.4wdzjb44f6aki5ug@sigill.intra.peff.net>
 <20161219120719.GF24125@ash> <20161219134148.vxa4fz3jw2i23lfm@sigill.intra.peff.net>
 <CACsJy8BgfyDTUmNh_PvoVcz2q92eNTRZy5myegTdi8mu6imVUQ@mail.gmail.com> <20161219140535.ehrbosgn32nl27ki@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Dec 2016 21:30:09 +0700
Message-ID: <CACsJy8AswJb1wzV+mcQ3HXrib3HRtVje7PPd9AWPE9Bi32_2sw@mail.gmail.com>
Subject: Re: [PATCH] parse-options: print "fatal:" before usage_msg_opt()
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 9:05 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 19, 2016 at 08:53:30PM +0700, Duy Nguyen wrote:
>
>> >> Your commit message does not make clear if you want this "fatal" to be
>> >> grep-able (by scripts) or not. If not, please _() the string.  Maybe
>> >> this to reduce work for translators
>> >>
>> >>       /* TRANSLATORS: this is the prefix before usage error */
>> >>       fprintf(stderr, "%s %s\n\n", _("fatal:"), msg);
>> >
>> > I don't think we translate any of our "fatal:", "error:", etc, do we?
>> > It certainly doesn't look like it in usage.c.
>>
>> I know. But those existed before the l10n starts, some of those belong
>> to plumbing messages. This one is new.
>
> We add lots of new messages which are themselves translated, and they
> still get untranslated prefixes. It seems like consistency is more
> important than translating this one spot. But then, I do not use a
> translated git myself, so I would not see the difference either way.

I'm kinda used to the half English half Vietnamese messages after so
many years (not just git). I do like the prefix translated as well.
But I guess we could leave this a is for now. At least we know the
scope of this message and will have easier time i18n-izing it when we
do the same for die(), warning() and friends.
-- 
Duy
