Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28EA5209B8
	for <e@80x24.org>; Mon, 11 Sep 2017 18:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbdIKS7R (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 14:59:17 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36372 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbdIKS7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 14:59:16 -0400
Received: by mail-pg0-f49.google.com with SMTP id i130so9557183pgc.3
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qUaZiy/6DgJfZEBbTZZLgjHwYMbIM1X6iu5iZal3D+4=;
        b=qSOfOi7ZLSgHVpCiU0mIKvT8pyecho3qp7BD+eTQQzvR8pO9woFfP4rqNgAgz3PRk9
         kX18Fe9oiQgIf7PxgJm2/eDXU4oHS/fYp4/4ihYjiNC3WjbqntuMmyiWfp0UqCljuFp+
         M/b9JQhENdzS6YAbjnUbgGXcuT+FB4nU78QbjTM/bn9zU9aOe+QPIjyFiWyHag/IASx3
         I/bfGdnFab4Ehg9thooCg08U+z8dzwmwGpTfJuEk5tF/ZOb08tHS4INJjZHEK73xVyj6
         c4TfjLZ3z7IObpUrkF9tkbSLSslO+lYhlQDcxciEfw2Lw+M4EPlNS9REGI3VVH4G2fsi
         Ap6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qUaZiy/6DgJfZEBbTZZLgjHwYMbIM1X6iu5iZal3D+4=;
        b=Tlo/O5ih37TeRmRWT3tltvWvKidOzke4zUUrDikeaMXuHFTGM7ZLPJR8S7i0zYKX9R
         4FD3diSLbp7YpJ0ZDGcId2QwqOu4fP2ABenWaYZeRRCblgvFStiRfrkGMOdZtYiJ6uxB
         X8QVNm8oru23SGzgOUAM9Xc5QJT2B7/SZoNmG3lFa+bU5A1JviDeYa+b87GN/QGZe2oA
         4NqApvVf/XuqmUgCUIDzLQCBqwr19tgGJEqChSRYNn0pyR9iJGb1I0HaJ4oEhCt6omns
         7zO4tBblRbeNQQV9UithtFFii+iVJaPDFdBgM0IOr9wNSPnFLWsCz4lr+iduDOmFPLWJ
         5eow==
X-Gm-Message-State: AHPjjUizYv+lFkyNH1G2XHrSmrrseesW2UqLLm2WAATxcSvuZea7ZvFG
        +JiQ7CSqfVPVqWZx
X-Google-Smtp-Source: ADKCNb7u8t035mrZ2mtxgy47uGTqMpdhZZiwnTayQ4z/1l7Z+sh1BygAr4p1U46YJscVqyUZneamEA==
X-Received: by 10.99.132.199 with SMTP id k190mr12780562pgd.25.1505156356052;
        Mon, 11 Sep 2017 11:59:16 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:cc97:adde:6e9f:4374])
        by smtp.gmail.com with ESMTPSA id m190sm16569941pga.2.2017.09.11.11.59.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Sep 2017 11:59:15 -0700 (PDT)
Date:   Mon, 11 Sep 2017 11:59:13 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170911185913.GA5869@google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > One thing I still do not know how I feel about after re-reading the
> > thread, and I didn't find the above doc, is Linus's suggestion to
> > use the objects themselves as NewHash-to-SHA-1 mapper [*1*].  
> > ...
> > [Reference]
> >
> > *1* <CA+55aFxj7Vtwac64RfAz_u=U4tob4Xg+2pDBDFNpJdmgaTCmxA@mail.gmail.com>
> 
> I think this falls into the same category as the often-talked-about
> addition of the "generation number" field.  It is very tempting to
> add these "mechanically derivable but expensive to compute" pieces
> of information to the sha3-content while converting from
> sha1-content and creating anew.  

We didn't discuss that in the doc since this particular transition plan
we made uses an external NewHash-to-SHA1 map instead of an internal one
because we believe that at some point we would be able to drop
compatibility with SHA1.  Now I suspect that wont happen for a long time
but I think it would be preferable over carrying the SHA1 luggage
indefinitely.  At some point, then, we would be able to stop hashing
objects twice (once with SHA1 and once with NewHash) instead of always
requiring that we hash them with each hash function which was used
historically.

> 
> Because the "sha1-name" or the "generation number" can mechanically
> be computed, as long as everybody agrees to _always_ place them in
> the sha3-content, the same sha1-content will be converted into
> exactly the same sha3-content without ambiguity, and converting them
> back to sha1-content while pushing to an older repository will
> correctly produce the original sha1-content, as it would just be the
> matter of simply stripping these extra pieces of information.
> 
> The reason why I still feel a bit uneasy about adding these things
> (aside from the fact that sha1-name thing will be a baggage we would
> need to carry forever even after we completely wean ourselves off of
> the old hash) is because I am not sure what we should do when we
> encounter sha3-content in the wild that has these things _wrong_.
> An object that exists today in the SHA-1 world is fetched into the
> new repository and converted to SHA-3 contents, and Linus's extra
> "original SHA-1 name" field is added to the object's header while
> recording the SHA-3 content.  But for whatever reason, the original
> SHA-1 name is recorded incorrectly in the resulting SHA-3 object.

This wasn't one of the issues that I thought of but it just makes the
argument against adding sha1's to the sha3 content stronger.

> 
> The same thing could happen if we decide to bake "generation number"
> in the SHA-3 commit objects.  One possible definition would be that
> a root commit will have gen #0; a commit with 1 or more parents will
> get max(parents' gen numbers) + 1 as its gen number.  But somebody
> may botch the counting and records sum(parents' gen numbers) as its
> gen number.
> 
> In these cases, not just the SHA3-content but also the resulting
> SHA-3 object name would be different from the name of the object
> that would have recorded the same contents correctly.  So converting
> back to SHA-1 world from these botched SHA-3 contents may produce
> the original contents, but we may end up with multiple "plausibly
> looking" set of SHA-3 objects that (clain to) correspond to a single
> SHA-1 object, only one of which is a valid one.
> 
> Our "git fsck" already treats certain brokenness (like a tree whose
> entry has mode that is 0-padded to the left) as broken but still
> tolerate them.  I am not sure if it is sufficient to diagnose and
> declare broken and invalid when we see sha3-content that records
> these "mechanically derivable but expensive to compute" pieces of
> information incorrectly.
> 
> I am leaning towards saying "yes, catching in fsck is enough" and
> suggesting to add generation number to sha3-content of the commit
> objects, and to add even the "original sha1 name" thing if we find
> good use of it.  But I cannot shake this nagging feeling off that I
> am missing some huge problems that adding these fields and opening
> ourselves to more classes of broken objects.
> 
> Thoughts?
> 
> 

-- 
Brandon Williams
