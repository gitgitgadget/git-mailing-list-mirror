Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF6681F600
	for <e@80x24.org>; Thu, 20 Jul 2017 19:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754687AbdGTTR1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 15:17:27 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34558 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdGTTR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 15:17:26 -0400
Received: by mail-pf0-f169.google.com with SMTP id q85so15547163pfq.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GlJsCTwI5dMuWNYEctus/0hHRLG95vEpxAXayrfEqKY=;
        b=QGqBzcWDxA+4fW/a7LkIz2X+rsv5Fc1g1qS9y2PTf6Y+rSoVEsQz9BOcVM16Gy0AOd
         G+3nZGpe1PAhSWx5yvcIArVHhY/IR8P0dYujnJopsTF7z0/AkWKakhipR71YSNef43do
         +JvUkP1wARXpx6tdo6jeY/Fu8y/DVsRcr9qAKqu8iLUfDbI3SckYc41ywqcMRHtqgYzL
         2C32Jo+ThCz6Y0BaVkkwnPO23HzhFP96Qq3BEurJuVJf4Pluq/3Aru8+zCFurWxfSxfL
         7XdK4mrm2PzBhimqpGkUhD0qrTysg33PFwB+rzXA84/0flDR0Uva5K9H3LIIQ48xRVn7
         s9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GlJsCTwI5dMuWNYEctus/0hHRLG95vEpxAXayrfEqKY=;
        b=aKV5nlbMaYCInTc9Qi0HUZQeFIOAOz3KwqIHOBcArEgHmATuNWj65TA4pTcU+V2+BY
         S+7bsJzmtVvGI7pkRgVuOOUGIvrSdnnMIvGOhZGr+5HFMt8D3yHNsxcexEOl2k2/DwwB
         kDuejdM7xLvaRbIGZa/v/SLYtb3tKZ2hHw0aKgT5nhkOZoKExy6gWeUjG2STkCgjLW8M
         jocSdAKJkI9HonuYWQaVNqG36bv7O2FguFToudMHj7x6xG9o87NZtAszOgngc8M3u+Rw
         Ip3GZ2XPMDziUENNTofupKrC2Lr7IiiWXBYFW9hGAfo93N1OZusmW5SkhU2AyVcW4Peq
         7Y2w==
X-Gm-Message-State: AIVw110FeIwrZFKO9rWujwU0N1i5jEN83uzFSjgnObJ4rCTF2m7Tj6zO
        KNo/9NS1MCEBLMw3
X-Received: by 10.84.131.106 with SMTP id 97mr5230466pld.416.1500578245447;
        Thu, 20 Jul 2017 12:17:25 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:e9ae:e35a:1cee:5424])
        by smtp.gmail.com with ESMTPSA id c82sm5491924pfd.5.2017.07.20.12.17.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Jul 2017 12:17:25 -0700 (PDT)
Date:   Thu, 20 Jul 2017 12:17:20 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [RFC PATCH v2 2/4] promised-object, fsck: introduce promised
 objects
Message-ID: <20170720121720.76e0c06e@twelve2.svl.corp.google.com>
In-Reply-To: <CAGZ79kZ45Z3R9FbsKQwotXh_Ek=StUdSTHj4er6HMhx79VbV4g@mail.gmail.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
        <cover.1500508695.git.jonathantanmy@google.com>
        <3420d9ae9ef86b78af1abe721891233e3f5865a2.1500508695.git.jonathantanmy@google.com>
        <CAGZ79kZ45Z3R9FbsKQwotXh_Ek=StUdSTHj4er6HMhx79VbV4g@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 20 Jul 2017 11:07:29 -0700
Stefan Beller <sbeller@google.com> wrote:

> > +       if (fsck_promised_objects()) {
> > +               error("Errors found in promised object list");
> > +               errors_found |= ERROR_PROMISED_OBJECT;
> > +       }
> 
> This got me thinking: It is an error if we do not have an object
> and also do not promise it, but what about the other case:
> having and object and promising it, too?
> That is not harmful to the operation, except that the promise
> machinery may be slower due to its size. (Should that be a soft
> warning then? Do we have warnings in fsck?)

Good question - having an object and also having it promised is not an
error condition (and I don't think it's a good idea to make it so,
because objects can appear quite easily from various sources). In the
future, I expect "git gc" to be extended to remove such redundant lines
from the "promised" list.

> >   * The object type is stored in 3 bits.
> >   */
> 
> We may want to remove this comment while we're here as it
> sounds stale despite being technically correct.
> 1974632c66 (Remove TYPE_* constant macros and use
> object_type enums consistently., 2006-07-11)

I agree that the comment is unnecessary, but in this commit I didn't
modify anything to do with the type, so I left it there.

> >  struct object {
> > +       /*
> > +        * Set if this object is parsed. If set, "type" is populated and this
> > +        * object can be casted to "struct commit" or an equivalent.
> > +        */
> >         unsigned parsed : 1;
> > +       /*
> > +        * Set if this object is not in the repo but is promised. If set,
> > +        * "type" is populated, but this object cannot be casted to "struct
> > +        * commit" or an equivalent.
> > +        */
> > +       unsigned promised : 1;
> 
> Would it make sense to have a bit field instead:
> 
> #define STATE_BITS 2
> #define STATE_PARSED (1<<0)
> #define STATE_PROMISED (1<<1)
> 
>     unsigned state : STATE_BITS
> 
> This would be similar to the types and flags?

Both type and flag have to be bit fields (for different reasons), but
since we don't need such a combined field for "parsed" and "promised", I
prefer separating them each into their own field.

> > +test_expect_success 'fsck fails on missing objects' '
> > +       test_create_repo repo &&
> > +
> > +       test_commit -C repo 1 &&
> > +       test_commit -C repo 2 &&
> > +       test_commit -C repo 3 &&
> > +       git -C repo tag -a annotated_tag -m "annotated tag" &&
> > +       C=$(git -C repo rev-parse 1) &&
> > +       T=$(git -C repo rev-parse 2^{tree}) &&
> > +       B=$(git hash-object repo/3.t) &&
> > +       AT=$(git -C repo rev-parse annotated_tag) &&
> > +
> > +       # missing commit, tree, blob, and tag
> > +       rm repo/.git/objects/$(echo $C | cut -c1-2)/$(echo $C | cut -c3-40) &&
> > +       rm repo/.git/objects/$(echo $T | cut -c1-2)/$(echo $T | cut -c3-40) &&
> > +       rm repo/.git/objects/$(echo $B | cut -c1-2)/$(echo $B | cut -c3-40) &&
> > +       rm repo/.git/objects/$(echo $AT | cut -c1-2)/$(echo $AT | cut -c3-40) &&
> 
> This is a pretty cool test as it promises all sorts of objects
> from different parts of the graph.

Thanks.
