Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3AE1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 10:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeJYSl0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 14:41:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46736 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeJYSl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 14:41:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id i4-v6so8638958wrr.13
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 03:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YVeMVrB1uO3jGvFAPNOhd60dJe7jLbHWhHTQQL7LyOk=;
        b=sJ5KdsoQTXti6NUQVtHbfrL/VaR2QicY4L9Igl1q0NhGcx8IfTUb+r/OJjw4mrtTRE
         gn94AGvIHya9nnodE9bNptWCyKiAiOQETohr12pChDe1g3pHoiPRM5MMLEaPPSrCBYdF
         lthBISf/pCxd4YCFFQtPaoXLJ0HGGYbyyiZs8W//TnpZ//gV8L2PjjqfJMz4uKVzqM6/
         W0QjRkoxxP2PFWmx/39I62QXVFAngEbpQmQCQoIu5x2aka2Q7tep5QX5OZa0BcFZ8KR3
         ik2F+ebXCXIXATLWx1TUjzUfqrvRenn3LhoK7rhvncA6PfrGbuqQpIzVt6yj/xM+zkWD
         BaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YVeMVrB1uO3jGvFAPNOhd60dJe7jLbHWhHTQQL7LyOk=;
        b=iWSJizAeEeCC8Vn01DuNgD8bOX0/vuzds9n9712nZUjpw5NLN9bCjX7wWjjVj5XKg+
         RcwHFro4cq+ZAolA4ydJGe7fyRSw1iY/urrsXnWKx5Dodd4WOAYHlNK7hcuUTnaLS/PJ
         XZ41CBJa1iWhuJcJkJJDLJtnw4tfBqpZ4gUBcjs2cLDmmAvQRfh2IJ/85lQSJNOGgsRN
         GIBf7vo2bLvJHN0AquaF0x8Mqd1AAaRFE7OkB8bvo1RGJz/uoSbBEUI5+mJmlPMDZCD4
         oAHkXB9D2bN/aunwwZy9AqC0ARtgXvwWvlHZCYbC6j4+6hyu/rCiKZa6xaFBmjztiZau
         nbBA==
X-Gm-Message-State: AGRZ1gIA5ac+83860Pmi4q1dsMzgutS4+Vgqjbn5YIEWdPFh1NV8qVl0
        BicdduZmdl7qUVKgstBDEPCJz/5DnWM=
X-Google-Smtp-Source: AJdET5egBWaHJjepU1yIm92T9A0cGCgxqBWI2A2KqRZrQlrWPn77gpQXJJsoXEbjg9LD3imhXcmIww==
X-Received: by 2002:adf:ea88:: with SMTP id s8-v6mr1243445wrm.287.1540462161293;
        Thu, 25 Oct 2018 03:09:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p19-v6sm463163wmc.46.2018.10.25.03.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 03:09:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tommi Vainikainen <tvainika@gmail.com>
Cc:     sandals@crustytoothpaste.net, git@vger.kernel.org
Subject: Re: git pull defaults for recursesubmodules
References: <CAGshahkvn3fcyuqtD-WQE9tn+7rSad84+mtA_cfkz+t42xqPdw@mail.gmail.com>
        <20181023230324.GC6119@genre.crustytoothpaste.net>
        <CAGshahk7pY4rW5SQu73AdHMmxsbDCo5UP5LGF67FQYBws492TA@mail.gmail.com>
Date:   Thu, 25 Oct 2018 19:09:19 +0900
In-Reply-To: <CAGshahk7pY4rW5SQu73AdHMmxsbDCo5UP5LGF67FQYBws492TA@mail.gmail.com>
        (Tommi Vainikainen's message of "Wed, 24 Oct 2018 09:57:18 +0300")
Message-ID: <xmqqy3amficw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tommi Vainikainen <tvainika@gmail.com> writes:

> After reading SubmittingPatches I didn't find if I should now send a
> fresh patch with
> changes squashed together or new commits appended after first commit in that
> patch. Patch is updated accordingly as fresh patch.

(just on mechanics, not on the contents of your actual patch)

You can and should treat any topic that is not yet in 'next' as if
it did not exist.  If you refined based on a v1 patch, pretend as if
you were a perfect developer and you came up with that refined
version without producing any problematic things that were pointed
ont in your v1.  Pretend mistakes in v1 never happened.  Pretend
that you are perfect! ;-)

If you can limit the signs that an earlier rounds ever existed to

(1) The In-reply-to: header of the message you send your updated
    version of the patch in, so that people can find the older
    version and its discussion thread, and

(2) The cover letter that describes what you improved in the
    updated version relative to the last round, in addition to the
    overview of the series [note: this only exists for a larger
    patch series, and not usually done for a single patch]

you achieved your goal.
