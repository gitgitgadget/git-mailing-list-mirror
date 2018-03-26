Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C10D01F404
	for <e@80x24.org>; Mon, 26 Mar 2018 22:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeCZWkW (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 18:40:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34532 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbeCZWkV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 18:40:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id a20so18725226wmd.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 15:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=h/+Iw6tBfjWf7BFxVURmeyxKhJbSCKOblgnyz1SWQBA=;
        b=lRMcp7XxoVLg+pE6cyaqezZhzWjWlGXG3GjdbsawJsTUzxOQiEOxaC/5zkBv3SVNKR
         uQIvziWzRzgJTz567/CG0/CJIXqn1c5dQMb4dgWGgdonIsxdi6T0kGJIL5uHNSmMC/PW
         cYMCDvnrRPyC7nODtNb6Hcny+kKufGM/RLEXUpKrabR6hpFLlO2kFnBZw3CKOwHbDAlz
         pjWW8FWgHV1M0UWNGWQkFGNHtX/Kf/GhgttkFEpk90Fkh9C2MsshWy0BQyQ15wWR8NIO
         kNZkxdAjOmtCSqNRusPaeieauamR/hcRwa1rZ8NAuUd94165yfIEHyldmW24dSQfWWgd
         JROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=h/+Iw6tBfjWf7BFxVURmeyxKhJbSCKOblgnyz1SWQBA=;
        b=LMqXGIK5rHCxVamrfKDwgU3bok5MszwXr+KoAPQpU6WBmVxretf0i8PXHPzJQ7NQbr
         CVo1ZbtQXhBHAzKErUhR7oiJdHdru+Ngqf+Vz6B29mKX4UbrOclaeaYgXJITk8pl9Ne4
         iqISTNXOcTIKVV7e9Baf2lKJ4jxexUdwZMGK2RhqvmyBIiJhI+MHlIsLkjqCH18wkIAu
         Apy3DwuJKJnjIwfSu5KRvSGS7mHV1YfPyaDgl6m8UvjWdHWi5wjSll6pVtuI7JDTcJY7
         sTw/fLfCfv91yaU6t2SqQU8fOg4qZH52FDtJBXl8h+D2idJnzHR1M2IeHbd8qst2ccMr
         ej+A==
X-Gm-Message-State: AElRT7HZQXWA5QC0ykqrCCMQxni4azRcNsuEr1AXZ5GdIihYdo2kdJEu
        zloPCMR/Ws5iesQBYDPRbDY=
X-Google-Smtp-Source: AG47ELu7elDKDK7lOEEiiBxG8zCTbmI6H8s5A4g/m0eEKrkd8YW2u/6UBG6i8d4AN04qTVPGfalNMQ==
X-Received: by 10.28.10.83 with SMTP id 80mr16567695wmk.70.1522104019897;
        Mon, 26 Mar 2018 15:40:19 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x23sm47926wmc.0.2018.03.26.15.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 15:40:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Alex Vandiver <alexmv@dropbox.com>,
        git@vger.kernel.org, jonathantanmy@google.com, bmwill@google.com,
        stolee@gmail.com, sbeller@google.com, peff@peff.net,
        johannes.schindelin@gmx.de, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Including object type and size in object id (Re: Git Merge contributor summit notes)
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
        <874ll3yd75.fsf@evledraar.gmail.com>
        <0c3bb65f-d418-b39e-34c7-c2f3efec7e50@jeffhostetler.com>
        <20180326210039.GB21735@aiede.svl.corp.google.com>
Date:   Mon, 26 Mar 2018 15:40:18 -0700
In-Reply-To: <20180326210039.GB21735@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 26 Mar 2018 14:00:39 -0700")
Message-ID: <xmqq7epybgvh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> This implies a limit on the object size (e.g. 5 bytes in your
> example).  What happens when someone wants to encode an object larger
> than that limit?
>
> This also decreases the number of bits available for the hash, but
> that shouldn't be a big issue.

I actually thought that the latter "downside" makes the object name
a tad larger.

But let's not go there, really.

"X is handy if we can get it on the surface without looking into it"
will grow.  Somebody may want to have the generation number of a
commit in the commit object name.  Yet another somebody may want to
be able to quickly learn the object name for the top-level tree from
the commit object name alone.  We need to stop somewhere, and as
already suggested in the thread(s), having auxiliary look-up table
is a better way to go, encoding nothing in the name, as we are going
to need such a look-up table because it is unrealistic to encode
everything we would want in the name anyway.

