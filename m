Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A3020899
	for <e@80x24.org>; Tue,  8 Aug 2017 20:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbdHHUnj (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 16:43:39 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34763 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbdHHUnj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 16:43:39 -0400
Received: by mail-pf0-f181.google.com with SMTP id o86so19031659pfj.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=os97eGqbkloLBoIi7jCToGDnz/9xm4drd+IhKOZrJCU=;
        b=Ehl61Li0Hz4+5rddH/jcJebtea0vQ5B+DvwPCdApGlJjW3PuwIBnpnF5GRGO4aCLa1
         yi+5i0DN0qKcZXxM7amVtbWA9vqSJ7x8uN9IE/e9zbbghaNCcUW93qEZVX56L6sPViIK
         eQV9upuCzsuSBMeNthJorw/Ga/HA/tXOPxTVJtTV6uz9pOwi3XPh6ZiICX3lIQinV/FO
         +A5ukzpZQkKiuqIoqc5k+vR35J9EJj/L7HaSIpbF5immP7aHs2Nzi3bt7/R9+vXCAXU0
         LhpSzshqHSB8df8yzEEkeQu7KmRzTvjrsUYvja4uSRpop5uuDcW2aExo2L+1HtIRN1WV
         Ivtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=os97eGqbkloLBoIi7jCToGDnz/9xm4drd+IhKOZrJCU=;
        b=s1tYmUkpycb1G5Sy2WrYVdtC+IFxlORMdnQ29ayzbLgbE9aFpJjLyFXxBszPbokqE0
         YFqNuY1rsigLdkBgcf4/R/ppvpmtBj97hZmRDXWqpsJTYWDM0vo+avlOJWgL+HB8Mr1r
         JThpwHQflcDKGdtcinQWGFHsJetAeWYr6yFcFF1kNIrSwik60Jf2fJOzD4fZh1z5uA0y
         1LKuk+Is5m43GengZfbrRz+RAXpU6p/gxWKTw1dNsxzu/2icrqhLNWbiSnFdqy/axkhl
         HPJMOGNKt/qJqWNq15gS9dzAq5BF+4PjWsc4Fn9Vlx8Sc/cDJBsyIBzik7JK4oqY+1Pq
         dQKQ==
X-Gm-Message-State: AHYfb5jou52FMSYjIobAv/DzqI5j+IrqhJbplShAyQ99qD7qymWmmC5l
        c9xSb4YENlXboHVEF4B5hA==
X-Received: by 10.84.148.134 with SMTP id k6mr6152098pla.250.1502225018283;
        Tue, 08 Aug 2017 13:43:38 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:3038:f339:86a3:23e0])
        by smtp.gmail.com with ESMTPSA id t77sm4172590pfj.9.2017.08.08.13.43.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 13:43:38 -0700 (PDT)
Date:   Tue, 8 Aug 2017 13:43:35 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] An attempt to move packfile funcs to its own
 file
Message-ID: <20170808134335.2834cb3d@twelve2.svl.corp.google.com>
In-Reply-To: <xmqqd185bzbi.fsf@gitster.mtv.corp.google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
        <xmqqd185bzbi.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 08 Aug 2017 13:05:05 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > While investigating annotating packfiles and loose objects to support
> > connectivity checks in partial clones [1], I decided to make the effort
> > to separate packfile-related code from sha1_file.c into its own file, to
> > make it easier to both code such changes and review them. Here is the
> > beginning of those efforts.
> >
> > Is this something worth doing, and if yes, is this in the right
> > direction?
> 
> Overall I think it is a good idea to slim down sha1_file.c *if* we
> can keep the exposed surface area small enough.

What do you mean by "keep the exposed surface area small enough"? If you
mean the total number of exposed functions in sha1_file and pack (once
everything is done), I think it will be almost the same as that
currently in sha1_file.

find_pack_entry() and has_packed_and_bad() (not yet in this patch set)
might need to be changed from static to global, but those are the only 2
I can think of. Anyway, I'll report the functions that need to be
changed from static to global at the end.

During this patch set, there might be some functions that need to be
temporarily made global, but those are reverted to static in the end.

> I wonder if the names "pack.[ch]" communicate well that these are
> "object access layer that is about reading from packfiles".  The
> writer side is called "pack-objects.[ch]".

This file will end up being slightly broader than reading from packfiles
- in particular, things like pack_report() (reporting some statistics
not only on the in-repo packfiles themselves) and parse_pack_index()
(which parses an idx file obtained through http) are there too. Hence
the generic name, but I agree that there might be a better name (or
better set of names).

> This may have to make some symbols that used to be private to the
> "object access" layer, which was what sha1_file.c was about, global
> symbols.  After moving things around, do we end up exposing too many
> implementation details to the world outside the "object access"
> layer?  I'd assume they are limited to the resulting pack.h and it
> would be OK as long as nobody other than sha1_file.c and pack.c
> would inculde it, though.

As stated above, I don't think so, but I'll make a list of the functions
needing to be made global.
