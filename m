Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9881E1F744
	for <e@80x24.org>; Mon, 18 Jul 2016 01:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbcGRBSf (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 21:18:35 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33256 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbcGRBSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 21:18:34 -0400
Received: by mail-io0-f180.google.com with SMTP id 38so147814514iol.0
        for <git@vger.kernel.org>; Sun, 17 Jul 2016 18:18:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=JBwgBi+zUC1Nwe6waLv2lJxc0wj6G9l1oBSahMUpQhA=;
        b=Qm9UxmU9IJJrOWwXDReNKFE1MP2+dBRnM7gUEWQJmARjkHWyIyobm+djwCQ5LVk1lF
         5WmdUQxfwrc7Yci1wyaIh7RmI0NaP148V6SHihZ2RTshJl1rNxjtAEfeRxL23qIFNl8O
         qVPnf0WKJjuXLyTGraNbZ6qtDvPCdONivDWf1OwT+7KbN4d7lQTyFyZUO9LUPbuHixyb
         xr3xJV3njz3HguUjmeHWcKX7oEVYW44hFWKFivZ6/7EzrAFEOABmekQOber+oQ+Dr6Z/
         uyjTgXDY+FNKMSzpc58IVhbcOReEn9IjP+GAsrbJb4diEST2Hb7L2/UnNr0uL5BNPiwT
         9/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=JBwgBi+zUC1Nwe6waLv2lJxc0wj6G9l1oBSahMUpQhA=;
        b=N11ESs6RV1h77UKwK+3glR8irH8LmwXfJ1dBdAWR9mEj60FKqwskgrTHNxEvbYi4sW
         8K51PE9DBagLPtUquZS2/t71gOT3GrbuWkgITAyq1t058ByXnRipFMdcpHT2WsMRGzHr
         YaAyeVbEfJHWeZib43lwqcxi8gX/HIWiCq/mUSiB4DEG2ZeM5IGG8WAMkbEsHSWU9jqg
         c1P+KufqWJ2dwGNNtTrGanjEjRLUHZ3B6mXCwOOCO8H/VONQOZZPI0kPe0cavOrhHUTv
         xwRt2S0hSTost/D9lfCjBuKa3NLHiLCSfrSiJkHLFwoauE4HkU+wyjppiFQJimPlDtmX
         OV4A==
X-Gm-Message-State: ALyK8tKvNhIUsDbQmtF3djDFZXcHwDuCm267Sn/I/K93WAey8OjFZcjBp6gYpTKVU2L4SZhK7gREAU6/dHtngg==
X-Received: by 10.107.182.8 with SMTP id g8mr21250612iof.53.1468804713484;
 Sun, 17 Jul 2016 18:18:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.83.4 with HTTP; Sun, 17 Jul 2016 18:18:32 -0700 (PDT)
In-Reply-To: <1468804249.2037.0@smtp.gmail.com>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org>
 <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
From:	Herczeg Zsolt <zsolt94@gmail.com>
Date:	Mon, 18 Jul 2016 03:18:32 +0200
Message-ID: <CAPp-VrazVQqA3iEpbUYP=kscdm+LrEMesoDid3s5AD5zfU5Z+w@mail.gmail.com>
Subject: Fwd: Git and SHA-1 security (again)
To:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Do you think the multi-hash approach worth the added complexity? It'll
break a lot of things. I mean almost everything. All git algorithms
rely on the "same hash => same content" "same content => same hash"
statements.

I think converting is a much better option. Use a single-hash storage,
and convert everything to that on import/clone/pull. I would only
introduce a a two-way mapping table (old-hash <=> new-hash) to help
the users. In the normal workflow, everything can go with new-hashes
only.

That leaves most algorithms and code intact, and introduces a very few
new cases:

On import:
If the imported data does not match your selected new-hash format, add
it's hash to the lookup table, than convert it to your selected
format, and handle it as such.

If a user references an old hash:
We can look-up that table forward, and find the referenced object in
storage. We can handle it from now as normal.

On an old signature verify:
Look-up the table forward, find the object by knew key. Look-up
backwards for all referenced objects, reconstruct the "old-format" and
verify the hash on that.

If you double-check your hashes as you build the mapping, you can even
trust it, which makes the lookups and verifys very fast. You can
introduce as many hash mapping tables as you want, so you can not only
support old-to-new has transition, but there can be as many different
hashes in the world as you want. Your only rule is "you reference your
work in your current format", but you can look-up any references which
was valid at the moment it was made.

(There are slight issues with this aproach if we "convert than
convert". As for example, when you import from A (sha1) repo to B
(sha2) repo it's perfectl. But when you import the same commits from B
to C (sha3), you might loose sha1 references. That could be considered
normal if we wan't to keep-it-simple-stupid, only support a few
hashes, always going forward. Or you may add an extra "list" field to
objects, which could show what type of hashes you have to keep in
lookup-tables for that particular object. Or, you can even include a
list of old hashes in the object itself, which should make it to the
lookup table on import.)

Anyway, I think a single-hash storage, and the ability to hide any old
hashes from most of the internal algorithms is a key point in making
transition. If we want to provide multi-hash interface to users, than
we should look for "wrapper" solutions, that translates multi-hash
user needs to a single-hash backend.

Zsolt
