Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB44920899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbdHQVjJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:39:09 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:37018 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdHQVjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:39:09 -0400
Received: by mail-pg0-f51.google.com with SMTP id y129so50862312pgy.4
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 14:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0rJQsbOqzLUIzyXoUkSXRGYk1uDLLiwXfoMeWI1fXjw=;
        b=GbnzE944/rraOaMtabTIjM0N6j2qCucI1+oKyZrl7/l8RFw+xNvEL+Lv6OxmQqxtqp
         qHnzRl8UVCwvkmEh08xfLEdAXw42BC5db1gbxK29RpbDaJnImg3eEmdkA7Dy42esmbpB
         YFs0ehzPyjwjf9ZTX4n6c9WVHSoctdYLNCD5chCnK5nV47fpCwFG1yA4I6FAY0PECTs8
         ALO9zRGQpA8Zh73C/8IRPDPJIQy+pdxgp7VG3uwtI28wps0grK4q73aH0NNfm+bYUhWF
         ghsp3oh+393XIr9s2E/E37oxxFQO4YittBre0RcYz9RiIz2fgBCvaZ6Vhh8CNqIEKjCi
         bI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0rJQsbOqzLUIzyXoUkSXRGYk1uDLLiwXfoMeWI1fXjw=;
        b=O7Rsz+7p7D9FTIut+XFpBOlrtaZ5G4ySBHKjcZj3W96hDb6huvujLojIEMvyxbZJyh
         hyPqT1whrKd4apV5ekfmMkEoiVc1Pb3jKYBi1Ltf8KJTkk/WMAS6hLAGj9iKi3z1xSej
         /1RCMQ43FGbb08nDuYPb0a7+U9haziNW4BOLzp4R/UbEjIEdolZKimq+zcX6u7AN3cGS
         7wX8hRocrCuTdW0SZ9AHtKjIPstRQbiyt0YHkku3LW6ICN71QjFo49YQ/OTM4HaT/JfR
         ufPSTGDl+eEYo3ffntLhrYeqm0LTpyYHtpVcG8HZus5daVxAvsBbYPM6Pp09JfjYObdb
         PiZw==
X-Gm-Message-State: AHYfb5gjcH12sByA+pq7ALqB4NEjsh4pM8goodYDI06BhXBZiwL5Go22
        uHjjX32xSIRzVlCzjUTB+w==
X-Received: by 10.84.174.3 with SMTP id q3mr7500519plb.456.1503005948233;
        Thu, 17 Aug 2017 14:39:08 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:75a4:d37d:bb23:58d2])
        by smtp.gmail.com with ESMTPSA id u198sm6754289pgb.3.2017.08.17.14.39.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 14:39:07 -0700 (PDT)
Date:   Thu, 17 Aug 2017 14:39:05 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [RFC PATCH] Updated "imported object" design
Message-ID: <20170817143905.2ef872e6@twelve2.svl.corp.google.com>
In-Reply-To: <c6787a0b-ba7c-106a-66bd-5c2d38752ccb@gmail.com>
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
        <20170816003200.19992-1-jonathantanmy@google.com>
        <xmqqa82zjlt4.fsf@gitster.mtv.corp.google.com>
        <20170816143515.0a74f959@twelve2.svl.corp.google.com>
        <c6787a0b-ba7c-106a-66bd-5c2d38752ccb@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your comments. I'll reply to both your e-mails in this one
e-mail.

> This illustrates another place we need to resolve the
> naming/vocabulary.  We should at least be consistent to make it easier
> to discuss/explain.  We obviously went with "virtual" when building
> GVFS but I'm OK with "lazy" as long as we're consistent.  Some
> examples of how the naming can clarify or confuse:
> 
> 'Promise-enable your repo by setting the "extensions.lazyObject" flag'
> 
> 'Enable your repo to lazily fetch objects by setting the
> "extensions.lazyObject"'
> 
> 'Virtualize your repo by setting the "extensions.virtualize" flag'
> 
> We may want to carry the same name into the filename we use to mark
> the (virtualized/lazy/promised/imported) objects.
> 
> (This reminds me that there are only 2 hard problems in computer
> science...) ;)

Good point about the name. Maybe the 2nd one is the best? (Mainly
because I would expect a "virtualized" repo to have virtual refs too.)

But if there was a good way to refer to the "anti-projection" in a
virtualized system (that is, the "real" thing or "object" behind the
"virtual" thing or "image"), then maybe the "virtualized" language is
the best. (And I would gladly change - I'm having a hard time coming up
with a name for the "anti-projection" in the "lazy" language.)

Also, I should probably standardize on "lazily fetch" instead of "lazily
load". I didn't want to overlap with the existing fetching, but after
some thought, it's probably better to do that. The explanation would
thus be that you can either use the built-in Git fetcher (to be built,
although I have an old version here [1]) or supply a custom fetcher.

[1] https://github.com/jonathantanmy/git/commits/partialclone

> I think this all works and would meet the requirements we've been
> discussing.  The big trade off here vs what we first discussed with
> promises is that we are generating the list of promises on the fly
> when they are needed rather than downloading and maintaining a list
> locally.
> 
> My biggest concern with this model is the cost of opening and parsing
> every imported object (loose and pack for local and alternates) to
> build the oidset of promises.
> 
> In fsck this probably won't be an issue as it already focuses on
> correctness at the expense of speed.  I'm more worried about when we
> add the same/similar logic into check_connected.  That impacts fetch,
> clone, and receive_pack.
> 
> I guess the only way we can know for sure it to do a perf test and
> measure the impact.

As for fetching from the main repo, the connectivity check does not need
to be performed at all because all objects are "imported", so the
performance of the connectivity check does not matter. Same for cloning.

This is not true if you're fetching from another repo or if you're using
receive-pack, but (1) I think these are not used as much in such a
situation, and (2) if you do use them, the slowness only "kicks in" if
you do not have the objects referred to (whether non-"imported" or
"imported") and thus have to check the references in all "imported"
objects.

> I think this topic should continue to move forward so that we can 
> provide reasonable connectivity tests for fsck and check_connected in 
> the face of partial clones.  I'm not sure the prototype implementation 
> of reading/parsing all imported objects to build the promised oidset is 
> the most performant model but we can continue to investigate the best 
> options.

Agreed - I think the most important thing here is settling on the API
(name of extension and the nature of the object mark).

> Given all we need is an existance check for a given oid,

This is true...

> I wonder if it 
> would be faster overall to do a binary search through the list of 
> imported idx files + an existence test for an imported loose object.

...but what we're checking is the existence of a reference, not the
existence of an object. For a concrete example, consider what happens if
we both have an "imported" tree and a non-"imported" tree that
references a blob that we do not have. When checking the non-"imported"
tree for connectivity, we have to iterate through all "imported" trees
to see if any can vouch for the existence of such a blob. We cannot
merely binary-search the .idx file.
