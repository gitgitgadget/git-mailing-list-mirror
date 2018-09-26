Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CB6F1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeI0AZ5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:25:57 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44371 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeI0AZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:25:56 -0400
Received: by mail-wr1-f48.google.com with SMTP id v16-v6so27980271wro.11
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LdpGFZwegR4lY+cTZbcx+2HZFTRddLklHZJ3hcCkrH4=;
        b=ViquUs+2ekvKNru9FTcDoHyqFFp5YWcULy6CPNQ7VFAhzQyRprVRzfAQJ57fHYHbLA
         bAS/dwZoGrya4jIeFRYjPNjvdHQmeb1q+skrIszpiKrVDWhB9agLBsRTowcGsdT/bQHu
         nLDfN/eVIdAipkRlLHnqW7MnfX0MXczKkUZn5Aicp2yKsfXBkK7/HrIOVe3e5QFcPBzP
         pjHWOUn4urrtqKaPwxJFs812Ac9x/XzXTxnbdvQLXJnOoNkIv5s+Kn0nzssJ3TXAY4al
         bodzayPAYOTQiOmDqxwhbEWrsJE6KdE4YFiMe8nAwtr6NMB7gRNbSjoXUpGRIxGNSc21
         siJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LdpGFZwegR4lY+cTZbcx+2HZFTRddLklHZJ3hcCkrH4=;
        b=prwDzXSFWYExPgAHWx80/VyAkK4WyuZlS4NqlWhrCik+jFxfzSS3XWEJzIMR7mXxSG
         R0PZeEoibVbAZO/CTKjVMX4lMYMUcvPVV06/C471JsqFtMuhPazOkFmY4CBivZ9+jWLk
         kvmGMfEdJiS8MKwQeu01By4yD5eTo23Q4/iT/hDcwn6AH95xdVdhLFxN/cH6Qaw0FVAQ
         0eaSGoartYCocl5k3OQ9HktAoTJWceQ8iKnWO+Hlh0/oe8R4JOySMYuVdM6aObSQ8wqS
         W7pczkC6Ebc25hm/KPWM9bvoUjEZtgcyVnEagy8UwsINalYugguuBj7lmowPhTkioYr5
         wBVA==
X-Gm-Message-State: ABuFfoj4oYQcGN9KPGRTncgcJ9rLJ727m614V0x1HaLcqUaxTpRg/3BZ
        8+JtmeDIppAibQTNOsjKGls=
X-Google-Smtp-Source: ACcGV63B2huUbp08O2DU10cW3kdYB6rKX1IpIuVhlMhtX8b9p1fUw09N3EtSXWmDbzJHWViQNCRnAA==
X-Received: by 2002:adf:e792:: with SMTP id n18-v6mr5941475wrm.136.1537985506102;
        Wed, 26 Sep 2018 11:11:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z69-v6sm114049wmz.18.2018.09.26.11.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 11:11:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>, Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v4 9/9] Documentation/config: add odb.<name>.promisorRemote
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
        <20180802061505.2983-10-chriscool@tuxfamily.org>
        <CAGZ79kYPik87zvLUPPKFzcATFUdBFcXrAkTYxpxvAQy6w1CcUw@mail.gmail.com>
        <CAP8UFD1ia1xWk9pjfTUQ3zD7=dP=8UjKzf=G0ptsz=qRH8_X+Q@mail.gmail.com>
        <xmqqd0t1nr93.fsf@gitster-ct.c.googlers.com>
        <20180926041222.GA743@sigill.intra.peff.net>
Date:   Wed, 26 Sep 2018 11:11:45 -0700
In-Reply-To: <20180926041222.GA743@sigill.intra.peff.net> (Jeff King's message
        of "Wed, 26 Sep 2018 00:12:22 -0400")
Message-ID: <xmqqpnx0ku1q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I do not think "sources that are not git repositories" is all that
>> interesting, unless they can also serve as the source for ext::
>> remote helper.  And if they can serve "git fetch ext::...", I think
>> they can be treated just like a normal Git repository by the
>> backfill code that needs to lazily populate the partial clone.
>
> I don't know about that. Imagine I had a regular Git repo with a bunch
> of large blobs, and then I also stored those large blobs in something
> like S3 that provides caching, geographic locality, and resumable
> transfers.
>
> It would be nice to be able to say:
>
>   1. Clone from the real repo, but do not transfer any blobs larger than
>      10MB.
>
>   2. When you need a blob, check the external odb that points to S3. Git
>      cannot know about this automatically, but presumably you would set
>      a few config variables to point to an external-odb helper script.
>
>   3. If for some reason S3 doesn't work, you can always request it from
>      the original repo. That part _doesn't_ need extra config, since we
>      can assume that the source of the promisor pack can feed us the
>      extra objects[1].
>
> But you don't need to ever be able to "git fetch" from the S3 repo.
>
> Now if you are arguing that the interface to the external-odb helper
> script should be that it _looks_ like upload-pack, but simply advertises
> no refs and will let you fetch any object, that makes more sense to me.
> It's not something you could "git clone", but you can "git fetch" from
> it.

Yup.  The lazy backfill JTan has, if I understand correctly, only
wants "Please give me this and that object" and use of "upload-pack"
is an implementation detail.  Over the existing Git protocols, you
may implement it as sending these object names as "want" and perhaps
restrict the traversal (if there is a "want" object that is commit)
by giving some commits as "have", i.e. "upload-pack" may not be the
best model for the other side, but that is what we have readily
available.  I was hoping that the way we take to move forward is to
enhance that interface so that we can use different "object store"
backends as needed, to satisfy needs from both parties.
