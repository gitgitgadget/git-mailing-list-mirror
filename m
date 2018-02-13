Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 858A51F404
	for <e@80x24.org>; Tue, 13 Feb 2018 17:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965220AbeBMRSL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 12:18:11 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52015 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965091AbeBMRSH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 12:18:07 -0500
Received: by mail-wm0-f66.google.com with SMTP id r71so17514102wmd.1;
        Tue, 13 Feb 2018 09:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nI260c0vIp+iNO8EiJn0/6tN731OdZ6l0WtpyXbApRU=;
        b=lguG45H+MWGNh4KDQeRTOifZl+Oe1WPv+Ms90e7bJHRRQKHsqe68nsKDawpxvyW4sX
         ocnhG7xU+Nhl4SzWYvt6gqHIWQjgVaO+aDmT8zfi2Jvhevy6IlMnE3peI2+DiK4QHZBP
         Gz2NnmsNHAQS5eClUSb02OVsaMZwrNAG/CdL9Olv7NSUDHLXE2xHY/Vu1RlF7xZSFL9M
         4riYlTND8DMkfn4J5axDyqQabA45j/4PaUVc+fjbaHCO/qFbTVmyVc0hiScXBfkx5bdi
         vAANXEfbGsm7uf6w/DZnya4udGUjBM+jcYW6SUTR4Lev1zQtnRWOslHQUYpY61dKv5G5
         e1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nI260c0vIp+iNO8EiJn0/6tN731OdZ6l0WtpyXbApRU=;
        b=rAcWUlVwFNx7O7zaw+i0RDukV607H1jzcH7ii+S3jHZF89WHFHnEL+hQCQYMNceIRF
         NLQSv8qPuRly4KWeXDpRiOyRSRWOpJxOVcrg7CeOE+I/fKFeiwMSYOVKB1pmyi6BngH6
         pFSPlFc3DEVrNSH49PkNDIX/hX4ad3KlDoWKQS3lNjz4oAmxWjojLjL3ugyWPiIipm5+
         GiDVZjeA4bQJEiklnIPBzZ0s6bQAxPLY/5s8NIJc33T/KoKKFPOiQuL0aKFH7GY18P6o
         M8pbIkaOn/wVaqHmhytmrmJ/w65pSnA+pQe8gAkUTUgsVEO7Aw4auDhFpQyIOasY2hkq
         XOVg==
X-Gm-Message-State: APf1xPBWbpwiHloBYFEK+H+i/X1+32gi+HIZlsdQVn1unbbgkfiBvvBl
        AzJADutQYmX9AmGsaeWEPfB5UQrI
X-Google-Smtp-Source: AH8x224HcU/LVIVUpbT7GIDDLTM2/PsYWB5bEsNfNtQuQt6ANYmIPV2mIHzMa8BuFcW5stqZib/0Jw==
X-Received: by 10.28.58.79 with SMTP id h76mr2057516wma.139.1518542285104;
        Tue, 13 Feb 2018 09:18:05 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c7sm4167966wrh.18.2018.02.13.09.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 09:18:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
References: <20180213080036.3bf3a908@canb.auug.org.au>
        <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
        <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
        <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com>
        <CA+55aFwTp8gg70sHXqOgR01Liv5c8nnfUP0yTdwpkh-rg+2EMA@mail.gmail.com>
        <xmqqzi4drczv.fsf@gitster-ct.c.googlers.com>
        <20180212222157.0a3bd472@vento.lan>
Date:   Tue, 13 Feb 2018 09:18:03 -0800
In-Reply-To: <20180212222157.0a3bd472@vento.lan> (Mauro Carvalho Chehab's
        message of "Mon, 12 Feb 2018 22:21:57 -0200")
Message-ID: <xmqqmv0crepg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mauro Carvalho Chehab <mchehab@osg.samsung.com> writes:

> Yes, that's my pain. I don't want ff only when pulling from others,
> only when pulling from upstream tree.
>
>> 
>> We may want per-remote equivalent for it, i.e. e.g.
>> 
>> 	[pull]
>> 		ff=false ;# good default for collecting contributions
>> 
>> 	[remote "torvalds"] 
>> 		pullFF = only ;# good default for catching up
>> 
>> or something like that, perhaps?
>
>
> Yeah, something like that works. Please notice, however, that what I
> usually do is:
>
> 	$ git remote update torvalds
> 	$ git merge <tag>
> 	  (or git pull . <tag>)
>
> So, for the above to work, it should store somehow the remote from
> where a tag came from.

That makes me wonder if another heuristic I floated earlier is more
appropriate.  When merging a tag object T, if refs/tags/T exists and
it is that tag object, then an updated "merge" would default to "--ff";
otherwise, it would keep the current default of creating a merge even
when we could fast-forward, in order to record that tag T in the
resulting history.

Of course, end users can use command line options to override such
heuristics anyway, but if the behaviour based on the new heuristic
is easy to explain and understand, and covers majority of the use
cases without command line override, then we might not even need a
new configuration mechanism like remove.torvalds.pullFF mentioned
above.
