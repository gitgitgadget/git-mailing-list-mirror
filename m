Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99392022D
	for <e@80x24.org>; Sun, 26 Feb 2017 18:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbdBZSzi (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 13:55:38 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33008 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbdBZSzg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 13:55:36 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so10166159pgj.0
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 10:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s+TFURTnx/rHF1xvIknQEXNWMbWpB+Tpm/bn5dP6qUc=;
        b=ZHvLu43R+1XUsKUwkWSHoWJ+a4HLQASl8sPS9GphniwG/VLWKagfL3nQINtYq/Oshp
         bboliUmwGzanycYG3sLhQP0QKCH+e+jMvn2kFMT0YT3zhTQjpCz4trPkWq5na9BRIm9s
         A2rqId8LJp1shAG+1SguRUH8K576b5MIJLApRdnHLRlSeoAxYn6O/Q4LvV0bF7PLauA8
         U+75KB7raU7GLynkAzSq6ifUUbwnWql8D61f9MxSx+PI14Vm0TftAluS6TD5FZ+sWTDI
         DMcACZkH7Ylk7c8CBLQWU2B2St+Dj4/u41IXeHPRkWTvSsl+esZfO+DBUlZgAh8Z8PZM
         0ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=s+TFURTnx/rHF1xvIknQEXNWMbWpB+Tpm/bn5dP6qUc=;
        b=em2uG4lrOb6tXYiZlHdCQ4Vmu4Z+cSzuz4RJDtdD3KqjE3+ZK1ctTKkIaI7TXk1zG3
         5He4hVOhvCaZQEMdS5mZzfQGoGNW8Ju6Dfnr/McXZI/wcmyzoBBqWwI8F+wIP3Ca6L0h
         uwOv8xtPsZzp4ijptzTTtj1a4ZIle5yYRM8xDeHkfbTYGrnAuFZHs7R9nWYiPau/IxMo
         Pyr1AYksQGEOOwFVVjRxBrWkFdRj7catc1ppkNHF8UOY6dwr5Mh6JwZoBSVZO/q3dn0M
         m3MpTA6QleeqaseiTFCHoBVO1KcjtL00INklUpthV2iami7WNLHkL8IcA+wePx6sIEUl
         uO6g==
X-Gm-Message-State: AMke39kmG51LYJDSUYOmHrUwA1VjodNjUh/AAAb2NqOrOffFQoJ8Pti63KRRdKf62lg06g==
X-Received: by 10.98.59.8 with SMTP id i8mr16338379pfa.132.1488135310898;
        Sun, 26 Feb 2017 10:55:10 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2939:e4:e178:8ba9])
        by smtp.gmail.com with ESMTPSA id 23sm3671574pfw.94.2017.02.26.10.55.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 26 Feb 2017 10:55:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
References: <20170225011636.qjlv2luj3zefmrpz@sigill.intra.peff.net>
Date:   Sun, 26 Feb 2017 10:55:09 -0800
In-Reply-To: <20170225011636.qjlv2luj3zefmrpz@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 24 Feb 2017 20:16:36 -0500")
Message-ID: <xmqqtw7gye7m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Trees are more difficult, as they don't have any such field. But a valid
> tree does need to start with a mode, so sticking some non-numeric flag
> at the front of the object would work (it breaks backwards
> compatibility, but that's kind of the point).

Just like the object header format does not inherently impose a
maximum length the system can handle on our objects or the number of
mode bits we can use in an entry in the tree object [*1*], the
format in which tags and commits refer to other objects does not
impose what hash is used for these references [*2*].  

The object names in the tree format is an oddball; by being a binary
20-byte field and without any other hint, it does limit us to stick
to SHA-1.

I think the helper functions in tree-walk.h, namely 

	init_tree_desc();
	tree_entry_extract();
	update_tree_entry();

and the associated data structures can be updated to read a tree
object in a new format without affecting the readers too much.  By
having a "I am in a new format" byte at the beginning that cannot be
a valid first byte in the current tree format (non-octal is a good
thing to use here), init_tree_desc() can set things up in the desc
structure to expect that the data that will be read by
tree_entry_extract() and update_tree_entry() are formatted in a new
way, and by varying that "tree-format signature" byte, we can update
the format in the future.

So at the loose-object format level, we may not even need "tree2";
we can view this update in a way similar to the change we did when
we started supporting submodules/gitlinks.  Older Git would have
said "There is an object that is not tree or blob recorded" and
barfed but newer one takes such a tree just fine.  This "we are now
introducing a new hash, and a tree can either have objects all named
by SHA-1 or all new (non SHA-1) hash" update can be treated the same
way, methinks.

The normal flow to write tree objects is (supposed to be) all
contained in cache-tree.c.  As long as we can tell from "struct
object" which hash names the object (i.e. struct object_id may
become an enum and a union), we should be able to use it to convert
objects near the tip of the existing history to new hashes
incrementally. Ideally, the flag-day for one tip of a dag may be
just a matter of

	git commit --allow-empty -m "object name hash update"

without anything else.  The commit by default would want to name
itself with the new hash, which requires it to get its tree named
with the new hash, which may read the old tree and associated blobs
all named with SHA-1, but write_index_as_tree() should be able to
(1) read the tree with its SHA-1 name to learn what is contained;
(2) read the contents of blobs with their SHA-1 names, and compute
their names with the new hash; and (3) write out a containing tree
object in the updated format and named with the new hash.  And that
would give us the tree object named with the new hash that the
command can write into the new commit object on its "tree" line.


[Footnote]

*1* These lengths and mode bits are spelled out in ASCII without any
    fixed length limit for the number of the bytes in this ASCII
    string that represents the length.  The current code may happen
    to read them into unsigned long and unsigned int, which does
    impose limit on the individual reader in the sense that if your
    ulong is only 32-bit, you cannot have an object larger than 4GB.
    But that is not an inherent limit in the format; you can lift it
    by upgrading the reader.

*2* They are also spelled out in ASCII and there is no length limit.
    Existing implementation may happen to assume that they are all
    SHA-1, but the readers and the writers can be updated to allow
    other hashes to be used in a way that does not break existing
    code when we are only using SHA-1 by marking a reference that
    uses new hash distinguishable from SHA-1 references.
