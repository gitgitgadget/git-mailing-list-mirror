Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6A920133
	for <e@80x24.org>; Mon,  6 Mar 2017 20:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932557AbdCFUAE (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 15:00:04 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33224 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932368AbdCFUAC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 15:00:02 -0500
Received: by mail-pg0-f52.google.com with SMTP id 25so69905469pgy.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 12:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CiHV3Qzj6bjXTQOJ42d5mKKhZMfx7AECd1GQL/CgBmw=;
        b=ZRrz6xN+ErFlLftCBIeFxxYrVwcynSiOlTv3qecTJADGECE5klR6gT9GbpX2S2TBpR
         03K9TYAxM4Zeuv6b+ghmnKCFoR8AbRehyXKUWZF/qQZSH4ZAizbOnyscxWrNOGVYtNVm
         0H8m+KBLm7BK6n9XFJqWpyVk602guR7N1GpI5sxFrAgCQ3tS7G+F3Y8ZeePOjvCXnzaV
         0NZbPTz/RYXTUXH+zBUakymP5/YsdMessedRVnoxFPgyzPG9gvL2AZ4c2siIIeVK7Krb
         7mFPhiJstP1onWR/e0oawC7MvQXiGrZW9huB+rPG183WzFtpzXLhNMrbVIFUsaIhyYBU
         aD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CiHV3Qzj6bjXTQOJ42d5mKKhZMfx7AECd1GQL/CgBmw=;
        b=K3QWTGKPfMPz36Fm1DrZf5G7WLJyqq6OJofY6OM0AMWbFyBZrOnKXzj4bTFWTqltnn
         bWGLxZwlHy9KA0+05YEV6KAj2Gv6TIvITrRORVNrV0akLBeMpCYY0FOnBDH4TxWNXweK
         iY5OIPliVjnXPysjQYLXvuG42l8lnmRNEd1OI09cTd7f1WDW9K5c2nUT20BC7tV24gSi
         jaxy4nZkYjUMDfYA/BdUlqLY0a+XSwEAtCMqMEwaBs6iCfRlcFonq6v7kINZZ9hktHiF
         sYYATUYLUpqeovNWgOyE1GKAFjJs74WpOBCs8smwMRHakmtk6hyz8S6FSwEXtqVndf23
         3rVw==
X-Gm-Message-State: AMke39ma3ZbJuZb/8+CDMOCXhK3L8N02qRXLoPOPI7lW+oJGozfrJ+yZd+Uzc4aKfwguJM38
X-Received: by 10.98.163.141 with SMTP id q13mr23439746pfl.72.1488830401399;
        Mon, 06 Mar 2017 12:00:01 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:10a1:c255:c5bd:a65f])
        by smtp.gmail.com with ESMTPSA id g78sm41214895pfe.5.2017.03.06.12.00.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:00:00 -0800 (PST)
Date:   Mon, 6 Mar 2017 11:59:59 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: RFC: Another proposed hash function transition plan
Message-ID: <20170306195959.GD183239@google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net>
 <cdd7779a-acdb-99fd-a685-89b36df65393@google.com>
 <CA+55aFxj7Vtwac64RfAz_u=U4tob4Xg+2pDBDFNpJdmgaTCmxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxj7Vtwac64RfAz_u=U4tob4Xg+2pDBDFNpJdmgaTCmxA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06, Linus Torvalds wrote:
> On Mon, Mar 6, 2017 at 10:39 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > I think "nohash" can be explained in 2 points:
> 
> I do think that that was my least favorite part of the suggestion. Not
> just "nohash", but all the special "hash" lines too.
> 
> I would honestly hope that the design should not be about "other
> hashes". If you plan your expectations around the new hash being
> broken, something is wrong to begin with.
> 
> I do wonder if things wouldn't be simpler if the new format just
> included the SHA1 object name in the new object. Put it in the
> "header" line of the object, so that every time you look up an object,
> you just _see_ the SHA1 of that object. You can even think of it as an
> additional protection.
> 
> Btw, the multi-collision attack referenced earlier does _not_ work for
> an iterated hash that has a bigger internal state than the final hash.
> Which is actually a real argument against sha-256: the internal state
> of sha-256 is 256 bits, so if an attack can find collisions due to
> some weakness, you really can then generate exponential collisions by
> chaining a linear collision search together.
> 
> But for sha3-256 or blake2, the internal hash state is larger than the
> final hash, so now you need to generate collisions not in the 256
> bits, but in the much larger search space of the internal hash space
> if you want to generate those exponential collisions.
> 
> So *if* the new object format uses a git header line like
> 
>     "blob <size> <sha1>\0"
> 
> then it would inherently contain that mapping from 256-bit hash to the
> SHA1, but it would actually also protect against attacks on the new
> hash. In fact, in particular for objects with internal format that
> differs between the two hashing models (ie trees and commits which to
> some degree are higher-value targets), it would make attacks really
> quite complicated, I suspect.
> 
> And you wouldn't need those "hash" or "nohash" things at all. The old
> SHA1 would simply always be there, and cheap to look up (ie you
> wouldn't have to unpack the whole object).
> 
> Hmm?

I'll agree that the "hash" "nohash" bit isn't my favorite and is really
only there to address the signing of tags/commits in this new non-sha1
world.  I'm inclined to take a closer look at Jeff's suggestion which
simply has a signature for the hash that the signer cares about.

I don't know if keeping around the SHA1 for every object buys you all
that much.  It would add an additional layer of protection but you would
also need to compute the SHA1 for each object indefinitely (assuming you
include the SHA1 in new objects and not just converted objects).  The
hope would be that at some point you could not worry about SHA1 at all.
That may be difficult for projects with long history with commit msgs
which reference SHA1's of other commits (if you wanted to look up the
referenced commit, for example), but projects started in the new
non-sha1 world shouldn't have to ever compute a sha1.

Also, during this transition phase you would still need to maintain the
sha1<->sha256 translation table to make looking up objects by their sha1
name in a sha256 repo fast.  Otherwise I think it would take a
non-trivial amount of time to search a sha256 repo for a sha1 name.  So
if you do include the sha1 in the new object format then you would end
up with some duplicate information, which isn't the end of the world.

-- 
Brandon Williams
