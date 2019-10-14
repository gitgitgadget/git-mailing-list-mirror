Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEA331F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 19:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbfJNThl (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 15:37:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39883 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730288AbfJNThl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 15:37:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so21043401wrj.6
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CFyRYnhpl/hQW8KGK+S48a1TYQLOY1831hdrICZ+x6Y=;
        b=GG4RpUjWClrRhSEr+5emPc3KdjOqIwF4Dy99r2uyYkwAssf4PMPKjW0iFddP2JtN5M
         rtQ+dQG9jfKLJJU/F/K9+7AUoS5yIvcXhfXMY5WJI/+OBHprmhPqPP4h1duzeZNnbo7q
         nkEXhrVbQwGycig1SoZCfc6w4+FRT29RKecWPmbmjuYRIPOC4g+hf0c18MgE0fQgpUkk
         HFngghfgnW58o9vXnf7kP7oPduX7AN0jnS840b6KeHnKkB5RrCrmqxlvlwjUPAogG505
         Vde2I7zn3Hu43yQzeY8BXt28Lm5wOSs4NjtXn9M7raPdItTWT395vEg65JesppVLmfkL
         a8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CFyRYnhpl/hQW8KGK+S48a1TYQLOY1831hdrICZ+x6Y=;
        b=o+z1BcUM/Nrpug1vp58Dpe6IlmkwN74We2rjmlK87RA0ISlunqUkByfcZ94DKkU2Id
         WmtHk9gFTg0qeGxJrdXuHGiTfRmeZ8f/XXdPFKjsTTbHTW7VcdvjrxjOGMygJPGuHN8C
         6XnL3PT+H+8rS39bVIue7Wcn08qCgAsXOdUYBqM5ujrTbFdQIRt5tN2xM9E0rEmWavW2
         oKj5k+swhXENGpy0hmj3merYM8yTBMVzACeWalXoJRVeXZ9cHI62sxLy8+pH7vc6Nbz7
         Z+kBhfG700n2KRWA1j2iwe9NmoiLJ+1jcYC9XY2a+DDD2DlKxc8b2/ElFuZe/fXGf19J
         Z2aQ==
X-Gm-Message-State: APjAAAXCEizSizVsYTK1qp4X8PSIt2D6EQ2NdpmDxXxSIxZfgEJ+a1I9
        vHYYNzrKek/HIGTsLq/gUHo=
X-Google-Smtp-Source: APXvYqw7/uETrusHBT6KqEbnl0SLJaz2WSy0mQxBBSnAWT3foFL27HE6wIUP4fREwEKUVk96zoOPog==
X-Received: by 2002:a5d:4aca:: with SMTP id y10mr16175821wrs.292.1571081859171;
        Mon, 14 Oct 2019 12:37:39 -0700 (PDT)
Received: from wambui ([197.237.61.225])
        by smtp.gmail.com with ESMTPSA id u68sm33703174wmu.12.2019.10.14.12.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 12:37:38 -0700 (PDT)
Date:   Mon, 14 Oct 2019 22:37:34 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [Outreachy] [PATCH] blame: Convert pickaxe_blame defined
 constants to enums
Message-ID: <20191014193734.GA13706@wambui>
Reply-To: 20191014182754.82302-1-jonathantanmy@google.com
References: <xmqqk19ag60g.fsf@gitster-ct.c.googlers.com>
 <20191014182754.82302-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014182754.82302-1-jonathantanmy@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 14, 2019 at 11:27:54AM -0700, Jonathan Tan wrote:
> > Jonathan Tan <jonathantanmy@google.com> writes:
> > 
> > >> > Also, I have a slight preference for putting "= 02" on the BLAME_COPY
> > >> > line but that is not necessary.
> > >> 
> > >> That is absolutely necessary; it is not like "we do not care what
> > >> exact value _COPY gets; it can be any value as long as it is _MOVE
> > >> plus 1", as these are used in set of bits (and again, I do not think
> > >> it is such a brilliant idea to use enum for such a purpose).
> > >
> > > Good point.
> > 
> > Doesn't that also show that enums are not quite a good fit for set
> > of bits (i.e. 1<<n)?
> 
> Well, I agree that it could be better, but with the C language as we
> have it now, I still slightly prefer an enum to a list of #define. Both
> ways, we still have to manually enter values for each flag, but with
> enum, we get better debugger display (at least in gdb) and in the
> function declaration and definition, we can put a specific type (instead
> of "unsigned" or "int"). gdb supports the notion that a few people use
> enums this way too, but if we decide as a project to not use enums in
> this way, that's fine too. For what it's worth, I tried doing a search
> online, but most of the results I got was for C# (where it is
> recommended - they have a "[Flags]" attribute for enums), so maybe I am
> indeed in the minority.

I'll try to pick another set of constants to convert - before this is
agreed on.

Thanks,
wambui karuga
