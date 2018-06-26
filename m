Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56811F516
	for <e@80x24.org>; Tue, 26 Jun 2018 19:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbeFZTxc (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 15:53:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39588 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932160AbeFZTxa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 15:53:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so3044605wmc.4
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CDHfRXf8KAQOjDIfgZBkUsc8DALw+nEnEOVc3gpIEiY=;
        b=UWL+9GH0+qHL08yD+yh4v/Cr+USil2MZXdtEdjdyNl403ptQRu7qzZt+1pY9zq71Sv
         ZEvl5jKtkUa9eYxyMLobN1I13GgU8xnWohXkiFDJHp50dvEgIfLXMSENTS0WN/QzE6jv
         KsonqqHu+oApo2X9JjJ0Q2GLE9i28I3u8OW9mOCUqH7hj3NYoqri5kmdkPFOsUlD5tXW
         TgLYrC4f4ITAA6dGua/81wNUWXu/qaVyN1INaaBZUDzRL+WBx7pFW3JSxjnncqAWXphJ
         LDLyPa/ZBDzNJKWB2p4Xd2gn+4wvS8P2m4UbeCYD8iuMXwrhoEK9TZ+sjcbbJXO4Hhfn
         qUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CDHfRXf8KAQOjDIfgZBkUsc8DALw+nEnEOVc3gpIEiY=;
        b=EHbgvk3ocpci1Oe+ggaTG0GNdmaq/r0CrpA8xCjXqLMjZ44wQbvoAD4/5hGe/1Vl0f
         xxqjQ4Y2372FApkTAdreGoKmziYXT4Btv8nvF2IDSPz27v5Y/Nztn2Ux7kexNbT98AiJ
         t4Ps3gtlxZWrKjDxlaC0yg1HVaAkaRDMXQUUtvzjqI9XePdkKczmAQ9JdQb5JzEnwMWh
         GXnnX5YZmxCwhkyALwPowE1DzPeuH5WFN7UVncqNOq+ES3RnOw7ICfokKiyIXwU+rlra
         VtXXCGbBNPXgkcRXUPMhXJwJnurFyDlKcMdz0tsWYA1Fqwxc3g7eW36eMBCO8FM9g/vd
         p7cg==
X-Gm-Message-State: APt69E3m+ahArhv7BWr/PQaCvP7LLOWIVO7TfNjGaGtEBK0K0RghTfnm
        jdiJeJLTNpW10WFuoMyKjJX1jyyn
X-Google-Smtp-Source: AAOMgpfGkZVtkoJf93vAgBjkzop3AWGe0Sh+tEDIFCve5h4/RNp4EbtQi/h5Gk+9SQWXgDLwqDjP2w==
X-Received: by 2002:a1c:58a:: with SMTP id 132-v6mr2560029wmf.95.1530042808631;
        Tue, 26 Jun 2018 12:53:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p8-v6sm1693586wrq.70.2018.06.26.12.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 12:53:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH 1/1] sequencer: print an error message if append_todo_help() fails
References: <20180626100429.10169-1-alban.gruin@gmail.com>
        <20180626100429.10169-2-alban.gruin@gmail.com>
        <nycvar.QRO.7.76.6.1806261455510.21419@tvgsbejvaqbjf.bet>
Date:   Tue, 26 Jun 2018 12:53:27 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1806261455510.21419@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 26 Jun 2018 14:57:37 +0200
        (DST)")
Message-ID: <xmqqk1qljpe0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Alban,
>
> On Tue, 26 Jun 2018, Alban Gruin wrote:
>
>> This adds an error when append_todo_help() fails to write its message to
>> the todo file.
>> 
>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>
> ACK.
>
> We *may* want to fold that into the commit that adds `append_todo_help()`.

Absolutely.  This looks more like an "oops, I made a mess and here
is a fix on top", and even worse, it does not make an effort to help
readers where the mess was made (iow, which commit it goes on to
of); it is better to be squashed in.

I do not know offhand who Alban's mentors are, but one thing I think
is a good thing for them to teach is how to better organize the
changes with readers in mind.  The author of a patch series knows
his or her patches and how they relate to each other a lot better
than the readers of patches, who are reading not just his or her
patches but the ones from a lot wider set of contributors.  Even
though append-todo-help and edit-todo may have been developed as
separate steps in author's mind, it is criminal to send them as if
they are completely separate topics that can independently applied,
especially when one depends on the other.  It is a lot more helpful
to the readers if they were sent as a larger single series, because
doing so _will_ tell the readers which order the dependency goes.

> And, as I mentioned previously, I would love for that function to be used
> as an excuse to introduce the long-overdue `interactive-rebase.c`

I am not sure if I like this direction.  

As newbies are often very bad at coming up with APIs and naming
global functions, keeping everything as "static" inside a single
sequencer.c tends to avoid contaminating the global namespace.
