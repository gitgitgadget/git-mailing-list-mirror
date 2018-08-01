Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4267E1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 18:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbeHAUD7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 16:03:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33144 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeHAUD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 16:03:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so21038678wrp.0
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xnqDu73YYv8gxhI6hm3Klkz2Mxxfy2DGAXvFl/n9toA=;
        b=IgAlA8rPurzjApS8CYg3yNMdl9OEMjx6n8V/6eBK3995TI9CgDIb8OqGBc80gyBOCR
         CWNWH6Q0hFJcTcNDBPc4dr6qvZcQtFQgoXCVP3nHip1N8zAUOgLA0f+xaXbmJjEOLBmR
         oSFg8WYUbO2ElMTEEaQ+/rpsAUyccZRFZ2VNA54DX8gVvYt8rUlvNRFkXbhyTIKqEjd4
         HqXDP3bJxWU8Np0cQqAJwLGLngmW9evBfHcxRTGsmRnuKEoZ2dgOxV6X3MqkMY1MjIi1
         d+swZDXHcfy3JmFATDQoq8HGwrt+Qam4d6eKFLZZeVhXrEdRRFDH85e0UQrkfXdfN+UM
         hTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xnqDu73YYv8gxhI6hm3Klkz2Mxxfy2DGAXvFl/n9toA=;
        b=HuKDAfK8PM/bit9BHyYyeF6Yp5ckrkAq+Mqmn9Q3UXqFRUx1sxdlIJhnOR47U7sGJu
         SShz0CpigPisjCUiMWAgjTUfrP+pEbyPVnHbxYrfDhvpYm+SCb4ijOug9uNSlS13LUoK
         IEUzcQnd28Bub+kS9TVawz6CZ0lpdzdrU+mmRtYrcQdnYmm1d+RAgnvIRa4N0Lc7oA2Y
         XEFxNo/Jpll9LEOd36RcI6YZGizb2k9PA/L3L5nI76r5EzIvJ1sT+p8GhpwqqxW/k1vf
         RpMREl7EaQXVqS6yxFia2rUNZQ/5DDqFlNyLx1uRiwSyv8AlxaR4aFGqZcky0DF+6/gl
         LFJQ==
X-Gm-Message-State: AOUpUlFAMov+MQrKZ3+VA43U9qRvTeWSBD33uXT7Cm6ephRX/D2wMpw3
        jjA7yTP8ZqlR1O8H7tzY9FVpapcr
X-Google-Smtp-Source: AAOMgpcjBpneHBA2csZpiiyEQiddy56iKcnLQGS3gBW+z9lQhYLFAdwuGxn/CLRAF8aVMG8IrIZvdA==
X-Received: by 2002:adf:94e2:: with SMTP id 89-v6mr24476617wrr.48.1533147419703;
        Wed, 01 Aug 2018 11:16:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x7-v6sm31679531wrr.95.2018.08.01.11.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 11:16:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     sunshine@sunshineco.com, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] Highlight keywords in remote sideband output.
References: <20180731173651.184716-1-hanwen@google.com>
        <20180731173651.184716-3-hanwen@google.com>
        <CAPig+cSbibJ7i8LwJqPe06xJObnq6dJdMUnJoC1uAg4zUQq3KA@mail.gmail.com>
        <xmqqeffi856n.fsf@gitster-ct.c.googlers.com>
        <CAFQ2z_PXfp60C-aiizUURjcqr-A+VJQDjMJ+fU_5DOo10x+rcQ@mail.gmail.com>
Date:   Wed, 01 Aug 2018 11:16:58 -0700
In-Reply-To: <CAFQ2z_PXfp60C-aiizUURjcqr-A+VJQDjMJ+fU_5DOo10x+rcQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 1 Aug 2018 19:18:31 +0200")
Message-ID: <xmqqsh3y6jfp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Wed, Aug 1, 2018 at 5:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> Hmm, do we actually say things like "Error: blah"?  I am not sure if
>> I like this strncasecmp all that much.
>
> this is for the remote end, so what we (git-core) says isn't all that
> relevant.

It is very relevant, I would think.  Because the coloring is
controlled at the client end with this implementation, third-party
remote implementations have strong incentive to follow what our
remote end says and not to deviate.  Preventing them from being
different just to be different does help the users, no?

>> > So, despite the explanation in the commit message, this function isn't
>> > _generally_ highlighting keywords in the sideband. Instead, it is
>> > highlighting a keyword only if it finds it at the start of string
>> > (ignoring whitespace). Perhaps the commit message could be more clear
>> > about that.
>>
>> Sounds good.
>>
>> I didn't comment on other parts of your review posed as questions
>> (that require some digging and thinking), but I think they are all
>> worthwhile thing to think about.
>
> Sorry for being dense, but do you want me to send an updated patch or
> not based on your and Eric's comments or not?

It would help to see the comments responded with either "such a
change is not needed for such and such reasons", "it may make sense
but let's leave it to a follow-up patch later," etc., or with a
"here is an updated patch, taking all the comments to the previous
version into account---note that I rejected that particular comment
because of such and such reasons".
