Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6F12013E
	for <e@80x24.org>; Fri,  3 Mar 2017 01:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdCCBnm (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 20:43:42 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:34989 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdCCBnm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 20:43:42 -0500
Received: by mail-it0-f54.google.com with SMTP id 203so4785239ith.0
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 17:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=m/yj7iNaXqAPayO5bSwN9qxsqjz3T2+5b7QIZHRRlWc=;
        b=CtWRPq9u7VtTvI8/g2mbH5/0qkYXLVPGLtShT5nqFbKLko75TO9C+3YwwPk4cNNwb7
         ITmQLyMhmK+QsDbMbf6nDLITaYiIFtLPyOoUATGCNrr03RI9//hhOGpyDYhUtLmdkI7W
         U+BPColSETL710J6M3AJiYln0vhlSu5Y69jX0+Fo2YJbQ5NQm5jKZ/vEo1ptaB+M+Mv6
         bc1nItufMpe1HWjegJ46RqP0h5HF3wtZwpFj1XSu3inSdZzKmbct/bXjYwPFDc3d9do3
         EByJALvCdfnnmEhR7LiE/L520eG4PTUnwB1xF7ZP6Q4YKOmSSPKhZR95p3TaVz//DePe
         zujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=m/yj7iNaXqAPayO5bSwN9qxsqjz3T2+5b7QIZHRRlWc=;
        b=rLgfp/DAsM93/mCMC6joY+8CtgDZskbn6fzaFdeumAS0wNLwdyRXeYBJGjByTEMDKC
         Und5aTdlZ3sG1A04ijLb8W7BUaIS17p5r5hIllevODYGt9WdBT1u1CsVXn30wQe83dL+
         McRzOT2b6lTE1KDR3717iFA+plzUZet3WiSOwXkIuEsYlJnHLx3Nxb4oNSDntBP6sQVq
         ccBY2OQEXFbsjCowLT4+R9H6a6KDeK0c1f15g09bYcnU6zqk17tc97j4oiWONbF7lGg3
         wKjZyqI/H/xll7WBOw/yWSmz8WQViXFfDVUZc3LFVYJUoraR5llGK5tJ/M5LUkcJsJru
         /5jA==
X-Gm-Message-State: AMke39kxcB+UlvsL1BpiKPgRHAq6+fsdJO5os8dfIe0HfGgJ87tLTjvo8a/aRf97yCvuROazV7sWdyhzUymYKQ==
X-Received: by 10.36.204.137 with SMTP id x131mr389125itf.35.1488489691328;
 Thu, 02 Mar 2017 13:21:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Thu, 2 Mar 2017 13:21:30 -0800 (PST)
In-Reply-To: <xmqqk287be9l.fsf@gitster.mtv.corp.google.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
 <CA+55aFwXaSAMF41Dz3u3nS+2S24umdUFv0+k+s18UyPoj+v31g@mail.gmail.com> <xmqqk287be9l.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2017 13:21:30 -0800
X-Google-Sender-Auth: T0YgLyuT4GqQ8JknK_vgPJD-xOU
Message-ID: <CA+55aFziZRA29foAMbM-HS5fiup7T0TuYf4XQ1kNT_SR7FfSgw@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2017 at 12:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> My reaction heavily depends on how that "object version" thing
> works.
>
> Would "object version" be like a truncated SHA-1 over the same data
> but with different IV or something, i.e. something that guarantees
> anybody would get the same result given the data to be hashed?

Yes, it does need to be that in practice. So what I was thinking the
object version would be is:

 (a) we actually take the object type into account explicitly.

 (b) we explicitly add another truncated hash.

The first part we can already do without any actual data structure
changes, since basically all users already know the type of an object
when they look it up.

So we already have information that we could use to narrow down the
hash collision case if we saw one.

There are some (very few) cases where we don't already explicitly have
the object type (a tag reference can be any object, for example, and
existing scripts might ask for "give me the type of this SHA1 object
with "git cat-file -t"), but that just goes back to the whole "yeah,
we'll handle legacy uses and we will look up objects even _without_
the extra version data, so it actually integrates well into the whole
notion.

Basically, once you accept that "hey, we'll just have a list of
objects with that hash", it just makes sense to narrow it down by the
object type we also already have.

But yes, the object type is obviously only two bits of information
(actually, considering the type distribution, probably just one bit),
and it's already encoded in the first hash, so it doesn't actually
help much as "collision avoidance" particularly once you have a
particular attack against that hash in place.

It's just that it *is* extra information that we already have, and
that is very natural to use once you start thinking of the hash lookup
as returning a list of objects. It also mitigates one of the worst
_confusions_ in git, and so basically mitigates the worst-case
downside of an attack basically for free, so it seems like a
no-brainer.

But the real new piece of object version would be a truncated second
hash of the object.

I don't think it matters too much what that second hash is, I would
say that we'd just approximate having a total of 256 bits of hash.

Since we already have basically 160 bits of fairly good hashing, and
roughly 128 bits of that isn't known to be attackable, we'd just use
another hash and truncate that to 128 bits. That would be *way*
overkill in practice, but maybe overkill is what we want. And it
wouldn't really expand the objects all that much more than just
picking a new 256-bit hash would do.

So you'd have to be able to attack both the full SHA1, _and_ whatever
other different good hash to 128 bits.

                Linus

PS.  if people think that SHA1 is of a good _size_, and only worry
about the known weaknesses of the hashing itself, we'd only need to
get back the bits that the attacks take away from brute force. That's
currently the 80 -> ~63 bits attack, so you'd really only want about
40 bits of second hash to claw us back back up to 80 bits of brute
force (again: brute force is basically sqrt() of the search space, so
half the bits, so adding 40 bits of hash adds 20 bits to the brute
force cost and you'd get back up to the 2**80 we started with).

So 128 bits of secondary hash really is much more than we'd need. 64
bits would probably be fine.
