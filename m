Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C97D1F42D
	for <e@80x24.org>; Sat, 26 May 2018 17:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032115AbeEZRZi (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 13:25:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56207 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032007AbeEZRZg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 13:25:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id a8-v6so21882158wmg.5
        for <git@vger.kernel.org>; Sat, 26 May 2018 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=u+QPuPxg5LJswXH+WuOUYhyecyuUfLriluIVbq/0rbg=;
        b=UNL8aFZM+O4u1tPQFrGQq4BgcVpR4HcG1txpAUqcM8y66SO3fel9AH0IyJW3+RX3CN
         dTvbnQfE00EeWKqOlikEhY6VFiLt1ERCM292fx5p9Fu/qJPCMO12iDylGd6wp3s3rxeW
         XQH8d/uLNP7HUApfVpRe6wNfViGHyULUitwvnhJtl1UOsVKHobPV/8U9UCHEfpyKEX/t
         a8778OChiRWVLT+IKOaOaonq0rumgnuAcvkZHSMH8cV0LaH6g9Qq8OnWyBn7QpP1v7/H
         y6nU9H7UUB2mQqg9pJPaQex5ji6Sj3WU+9zcNQs6Fjamzn6C5oUmfnWvC+RD+IDfjnNv
         T/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=u+QPuPxg5LJswXH+WuOUYhyecyuUfLriluIVbq/0rbg=;
        b=s8EWiHYXN9DnJEpYV32Y3Hye8Ju+9T7QHh9si816XVotG3TYNBkdFoeFXSKs2oZ3Tv
         Dh2SA+Os/3dLYk7t4cwdC29KbyYTrk6YEMtdtQKs/J1KvCWwQHwJIBcfjHUA6LVLJ0RL
         4lEImK2+z1k15VBz1Pqj8Rr0cv8CCtEqkk9+TFrGi9DXuddiPOXzdv3uqc0Kgplb/t51
         2Zf/nEveDjHp471+xGYdXDLTqojRzK6mrncFQlTxJZjizj9JufStzrELHzODTpwI3NHP
         5EOjt3bMuCVIk4pN7KhOqnkc5mQM3g9ZzDn4tXojU1ORvAurFvkeycjNzg1FaI6IWdLp
         R0Mg==
X-Gm-Message-State: ALKqPwfP7Bi+yt+Hu1LbvArRlFkG71p90ZaCt0Sss2mT8RJxw/tOvKs7
        OSA9b6iUa9HD4vuq0ZCPB7J37k/q
X-Google-Smtp-Source: ADUXVKJpLbABD4WP6ut9G62Swp/d66Fn38r7vPgEU3v6cix2RVSnGxJUvPnqn9PuHOhxBIx5N+Y5VQ==
X-Received: by 2002:a1c:1d10:: with SMTP id d16-v6mr341803wmd.78.1527355535200;
        Sat, 26 May 2018 10:25:35 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egg40.neoplus.adsl.tpnet.pl. [83.21.70.40])
        by smtp.gmail.com with ESMTPSA id g28-v6sm9595092wmc.38.2018.05.26.10.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 May 2018 10:25:33 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        git discussion list <git@vger.kernel.org>,
        David Turner <dturner@twopensource.com>
Subject: Re: RFC: New reference iteration paradigm
References: <56FD4CAD.3070100@alum.mit.edu>
        <xmqqlh4yo7av.fsf@gitster.mtv.corp.google.com>
        <20160331193150.GC5013@sigill.intra.peff.net>
Date:   Sat, 26 May 2018 19:25:32 +0200
In-Reply-To: <20160331193150.GC5013@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 31 Mar 2016 15:31:51 -0400")
Message-ID: <86h8mu1g8j.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> On Thu, Mar 31, 2016 at 11:01:44AM -0700, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>=20
>>> the backend now has to implement
>>>
>>>> struct ref_iterator *ref_iterator_begin_fn(const char *submodule,
>>>>                                            const char *prefix,
>>>>                                            unsigned int flags);

The problem with callbacks, including their lack of composability, is
often solved in high-level languages by using Promises / Futures (or
Channels / Supplies).

But I think in this case implementing a straightforward Iterator pattern
would be a better and simpler solution, especially in C.

>>> The ref_iterator itself has to implement two main methods:
>>>
>>>> int iterator_advance_fn(struct ref_iterator *ref_iterator);
>>>> void iterator_free_fn(struct ref_iterator *ref_iterator);
>>>
>>> A loop over references now looks something like
>>>
>>>> struct ref_iterator *iter =3D each_ref_in_iterator("refs/tags/");
>>>> while (ref_iterator_advance(iter)) {
>>>>         /* code using iter->refname, iter->oid, iter->flags */
>>>> }
>>=20
>> We'd want to take advantage of the tree-like organization of the
>> refs (i.e. refs/tags/a and refs/tags/b sit next to each other and
>> they are closer to each other than they are to refs/heads/a) so that
>> a request "I want to iterate only over tags, even though I may have
>> millions of other kinds of refs" can be done with cost that is
>> proportional to how many tags you have.
>>=20
>> The current implementation of for_each_tag_ref() that goes down to
>> do_for_each_entry() in files-backend.c has that propertly, and the
>> new iteration mechanism with the above design seems to keep it,
>> which is very nice.
>
> Actually, that is a slight fiction. :)
>
> We traverse only the loose ref directories we need, but we populate the
> entire packed-refs tree in one go. That's fine if you have a reasonable
> number of refs and care about the cold-cache case (where you care a lot
> about hitting directories you don't need to, but reading the entire
> packed-refs file isn't a big deal). But it's really bad if you have an
> 800MB packed-refs file, as looking up one tiny subset of the entries
> wastes a lot of RAM and CPU pulling that into our internal
> representation[1].
>
> At one point I wrote a patch to binary search the packed-refs file, find
> the first "refs/tags/" entry, and then walk linearly through there. What
> stopped me is that the current refs.c code (I guess file-backend.c these
> days) was not happy with me partially filling in the ref_dir structs in
> this "inside out" way.
[...]

Isn't this what reftable - an alternative way of storing refs in Git,
tested by being used by JGit - would solve?  See Christian Couder post
"Implementing reftable in Git"

  https://public-inbox.org/git/CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcX=
zPBjPBg@mail.gmail.com/t/#u

'Efficient lookup of an entire namespace, such as refs/tags/' is
allegedly one of the objectives of this format.

Regards,
--=20
Jakub Nar=C4=99bski
