Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1AD20248
	for <e@80x24.org>; Mon,  4 Mar 2019 05:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfCDFFo (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 00:05:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33922 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfCDFFo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 00:05:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so3999663wrg.1
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 21:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CDS7LqX/hJm6mHLSGQYTUd1yOkEifuZFHclZR/wIzTU=;
        b=oyOXpfAMz1kxKaZvGYC7z16ocWMRPXgHPSpt+AB4rWC4VidK6yS2QYu/0f+r8RfvLe
         EdJ7Vwql3N19aKsfAz+8qPho64oebF7J2Ch6BRsD1kGPcMPaXUHX0uhETDyIkIEd9DIu
         AkK8LCjfkLcSHzCwAFFVKLKsTG0pfsDJ1L1ZDSGXMPpJKwlWc9qB86HdfMLG/4/6CDda
         ineDrhKQV84BY96b+7Hpp4WBQSITULxHYBj7lVGhcCWosFUBhWtsBJW4QYkm5XiTxJYv
         QmZYIsIPZ9FtF5a0IAdijEwn2QGKwqFgTUujExi6JKYdHD3t80RQBjy8+IC0NrpVymDu
         a8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CDS7LqX/hJm6mHLSGQYTUd1yOkEifuZFHclZR/wIzTU=;
        b=PKCigQdEk0Zum96GzDP96AACp3r98oqUINjoFi5Ynff2HmNdvErQcrAURyJf4de+Ho
         rANvEmATFxYX3+1LMfmT+xKkxUbM2BpGc6XY3ETMAVEudrMxqOeQ62BPH7SrY5CK9fGQ
         muiJJ7g7iYN5vgsz2ekJUZq1dUN/PzDGvfFCSYTlOPMCUCgA4irA+BSe6aaakTPWXOqs
         tLgrJ34TOKz54CMKvokk6dIABNeS9V6F2xFh+kTtN7ggAfXHyDcV8dduIrzZoYoqh0dV
         yLW+eH3cJKMVw5yLkqOaf/68yPXLO3UR2P/seldJj7lOc51xC9mZfCt8ETAnKqaPtmTF
         CuyA==
X-Gm-Message-State: APjAAAUYgjwlGbm/KAPOtaO17Hu9moj+T4ztP5EHSG8RN/M3oKe0FSc/
        AfLfNl7yT3cquB9jjk/I9e4pEoACb2k=
X-Google-Smtp-Source: APXvYqzKQwOmaIxoqOWUy2fbT8FCM69vzcHv/tRv8ZzOZffTy2rPUK2YJu5qwetLuop0kh6dvC+88Q==
X-Received: by 2002:adf:f846:: with SMTP id d6mr11764476wrq.53.1551675941682;
        Sun, 03 Mar 2019 21:05:41 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 62sm4839336wra.46.2019.03.03.21.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 21:05:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
        <xmqqtvgk69ik.fsf@gitster-ct.c.googlers.com>
        <20190303174214.GF23811@sigill.intra.peff.net>
        <xmqqlg1vw9f2.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 04 Mar 2019 14:05:40 +0900
In-Reply-To: <xmqqlg1vw9f2.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 04 Mar 2019 13:28:01 +0900")
Message-ID: <xmqqh8cjw7ob.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I'm not sure I agree. Colors have always been special, and
>> "--type=color" was advertised as a replacement for "--get-color". And
>> "--get-color" never output the newline.
>
> OK, that part of the motivation I completely missed.  If end-users
> and scripters are happy with the behaviour of --get-color that does
> not terminate its output with LF (which I think is a reasonable
> thing to do, as "color" is special in that context, i.e. having a
> dedicated --get option suitable for that type), as we advertise
> "--type=color" is the same as "--get-color" (only better), we need
> to special case it, and omitting LF at the end similarly does make
> sense.
>
>> With respect to backwards compatibility, my thinking on the matter was
>> basically:
>>
>>   1. Since --type=color was supposed to be a drop-in replacement for
>>      --get-color, it's a bug that they don't behave the same.
>>
>>   2. It's a fairly recent feature, so nobody really noticed the bug
>>      until recently (and it was in fact me who noticed and got annoyed
>>      by it). If it were an ancient behavior, we might think about
>>      retaining even bug compatibility, but that's not the case here.
>
> Now I think "we weren't consistent to begin with with --get-color,
> and treating --type=color as a special case is justifiable"; and I
> agree with the above two points.

Just to avoid an awkward situation where the ball gets dropped and
left on the floor forgotten, the above does not mean I am 100% happy
with the patch as posted.  There is no mention of --get-color
anywhere, let alone it shows the ANSI sequence without traililng LF,
which I would consider to be the most important part of the
justification.  It is much stronger than "I expected there won't be
any trailing LF from 'git config'", which was the only thing I
managed to read in the original and led to my response.
