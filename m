Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD20B208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 16:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbeHFSuK (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 14:50:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33980 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeHFSuK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id h1-v6so5471250eds.1
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 09:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=JyCUE1DZdcEuePhVvdNjF8RsLV979Gcf92yLT0FwwXI=;
        b=S/Zg+0ol/jSPATdWzfm9ZldMMSz8ssh38apOOBA72pzKWRd7KezyssDcwjd4D8ABtR
         ryC4Ovu/CZn+Qu1QL8SEwVG0D5uhIMkQIZ8n7+qPjvJ0Yljek/YFycf8y2IrnrXL7lKN
         XuBgb9YgDoJ1sW1AUdEBP8FXdOmmkXbTaz6TALaHT7xQP9fYu06C4+WmGCTEqN3kVGGv
         cbKBgUYXH0h+rqgPif81AmR2Ou6eIksRFXZh9MOFlet+bbOMLMXT/n97g8dTZQGnseyB
         ppRRlt+qANdYZyxLmxwRYgNW9lTN7+vwuU5a58kJbckNNzNOK628YJmy6mlT5LCSPR/X
         Qx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=JyCUE1DZdcEuePhVvdNjF8RsLV979Gcf92yLT0FwwXI=;
        b=luz50qnh34CAb4vymjtLDe7QF/ayAFJ4/B6tdzfzDuxJwLJ3a9T8HElGmq1MpSGvdU
         /K16kcbDaXv/RzLek5eVH+MsLfg5U07Hy+NNq7V28bKix3RCTDGFZll7eACf8BgoNwXg
         NoGowBReO9r3YABKBLEPxcRWHA4ivhhRfI4Xg1GTQkiURp65bJxzQ8768GNo/OS02UxQ
         HLDqICqNF/2kamfBCEeR7vwb4xGEb6M0bgc8DRbvBl5evXR+/4wRP8mTodCw/7sdNiUm
         sX9UdOWwWPhu3RIDtT7x/WGtipcoygAlRJ/HPZVNo9hYDVDm9Cu+GwUrZ5ngoEeS6N8f
         O5Gw==
X-Gm-Message-State: AOUpUlHLge7Rv3wJOVneTCxxpsJjylK397HNqDllEHo1HfvK4AADf8xY
        zmji1f8E/xs1as/L/ZMPvms=
X-Google-Smtp-Source: AAOMgpexROosgS8pDaHFdyb7Ub5fY9rwMQjyxYsQE6Wo+qRGUPZX1v5je3ycBjuM0GK3M7Lg1nkx2Q==
X-Received: by 2002:a50:8103:: with SMTP id 3-v6mr18870374edc.131.1533573615746;
        Mon, 06 Aug 2018 09:40:15 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id f42-v6sm7118597edf.19.2018.08.06.09.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 09:40:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
References: <20180804020009.224582-1-sbeller@google.com>
        <20180804020255.225573-1-sbeller@google.com>
        <20180804060928.GB55869@aiede.svl.corp.google.com>
        <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
        <xmqqo9eirqwp.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqo9eirqwp.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 06 Aug 2018 18:40:14 +0200
Message-ID: <87zhxzsb2p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 04 2018, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, Aug 4, 2018 at 8:11 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> My main concern is not about them but about other
>>> people building from source in order to run (instead of to develop)
>>> Git, and by extension, the people they go to for help when it doesn't
>>> work.  I have lots of bitter experience of -Werror being a support
>>> headache and leading to bad workarounds when someone upgrades their
>>> compiler and the build starts failing due to a new warning it has
>>> introduced.
>>
>> Even old compilers can also throw some silly, false positive warnings
>> (which now turn into errors) because they are not as smart as new
>> ones.
>
> I agree with both of the above.  I do not think the pros-and-cons
> are in favor of forcing the developer bit to everybody, even though
> I am sympathetic to the desire to see people throw fewer bad changes
> that waste review bandwidth by not compiling or passing its own
> tests at us.

I agree.

Responding to the thread in general, perhaps people would like this more
if we turned DEVELOPER=1 DEVOPTS=no-error on by default?

That's basically why I added it in 99f763baf5 ("Makefile: add a DEVOPTS
to suppress -Werror under DEVELOPER", 2018-04-14), because I wanted the
abilty to have verbose informative output without the build dying on
some older systems / compilers.

It's fine and understandable if you're someone who's just building a
package on some older system if you get a bunch of compiler warnings,
but more annoying if you have to dig into how to disable a default
-Werror.
