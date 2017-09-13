Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F7A20286
	for <e@80x24.org>; Wed, 13 Sep 2017 15:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbdIMPtQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 11:49:16 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:47320 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdIMPtP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 11:49:15 -0400
Received: by mail-io0-f172.google.com with SMTP id j141so3108180ioj.4
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v9HRSkwcXdup2vy1JBL78u2mvWXaTWAQ6uv4o3G5zS4=;
        b=uasuimXXlR25q9PM+eRd72p9JhztGTMGKfWaCxMCW10uWBSrUJYnHUE/36YDKItYVO
         xd+7UDYwngpfht4kFPQrDVVJLdYIDwBNasqb/ufD+FacIYzY0K5XpdaBu6HMYjVtvEyJ
         Dlydkz82wwrQSm8RPnYMhHW57w0CpqdHvu2EL7X5Q9jWwuHfE+nc42VnLVv4FLZGM1ND
         5yhETFdLvpFuCCPTNQaQaopXrvhQoi4+UOmkCIctZm8+vV3K4HOt9d2oQHGHR8czxgV9
         5I0wpbms3o94iIRt1GzrvD97sAk4gw3NM8TocX0wslHiuDQ8gJBlYVh9jfJQcpvO4aDg
         ob7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v9HRSkwcXdup2vy1JBL78u2mvWXaTWAQ6uv4o3G5zS4=;
        b=lgQ6hSbNpOYoa83MSj9a10URC+ovP2EbHg+uffEPHXB+Qmfo7cr64G3WFSx0KHIPVs
         tugSpnAEq4n8QFnUuQPt8QXuarQBzk1BAejS5LIwlqyOQ33oZ2tKqeue4jJhecCNjuKN
         //Th9GGaYJ+MKcVPFn5NHc6J2jolNgtMXQPjSu+Qmeq3voJQWhqXr56bhzEbIIAyCmwx
         /5eRXpfTgXVo8x5vd4uvTYqpuWBC46bqw7V20V//vLIB7ot2Rq7ychF0UH/dafZcprpp
         JfTOh31Zxv+JEljurzR9/x1G5Q3yaBUtlTZWaTLYu7bJ6mok8I7L0FdUE5ocyCgMfYpI
         2rtA==
X-Gm-Message-State: AHPjjUihIwDwFC0RymE56tsvNUZXm389eXx8c31fdvVgwrtekTrDZYb3
        7Fl70NMISuuPCZMwVjsiCQwEjahL8PQoh2nRAYE=
X-Google-Smtp-Source: AOwi7QCfrtfxs4zYoHt+ogXGC5x1l2QtogfIiAM6xI1XqUQHASdDQBIU1JsbN/fPqZk0zQPL/EKEXM7T+PosXQp8Osg=
X-Received: by 10.107.212.12 with SMTP id l12mr12710299iog.62.1505317754818;
 Wed, 13 Sep 2017 08:49:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.4 with HTTP; Wed, 13 Sep 2017 08:49:14 -0700 (PDT)
In-Reply-To: <20170913152205.sw3i5xzsynx62nea@sigill.intra.peff.net>
References: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
 <20170913123420.die3thfcpaweakce@sigill.intra.peff.net> <CANgJU+U3Vzmmag9fpFGf7sx4Sq4S9qjLc5bnR4e+U0C3aaQXJA@mail.gmail.com>
 <20170913141739.mkmiaud2eemgnbbh@sigill.intra.peff.net> <CANgJU+WHr2-FjAUUKQ8pUkniczcxrr11dTo_zBeXdTi_su2oUA@mail.gmail.com>
 <20170913145154.423zqe6antzccclk@sigill.intra.peff.net> <CANgJU+XvJA2LYgFgmJZw7BR4-7qobvOh5zOSAVzGFOTsJ=Z8ug@mail.gmail.com>
 <20170913152205.sw3i5xzsynx62nea@sigill.intra.peff.net>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 13 Sep 2017 17:49:14 +0200
Message-ID: <CANgJU+XyfeDCpdZTKJOppjs6w6zS1kjxDAwbvOZr_1a8Fyqe7Q@mail.gmail.com>
Subject: Re: Bug: git branch --unset-upstream command can nuke config when
 disk is full.
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 September 2017 at 17:22, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 13, 2017 at 05:18:56PM +0200, demerphq wrote:
>
>> > Hmph. That is very disturbing. But with that information I should be
>> > able to track down the culprit. Thanks for digging.
>>
>> FWIW, I see that git_config_set_multivar_in_file_gently() uses
>> write_in_full() which in turn uses xwrite(), but the latter has the
>> following comment on it:
>>
>> /*
>>  * xwrite() is the same a write(), but it automatically restarts write()
>>  * operations with a recoverable error (EAGAIN and EINTR). xwrite() DOES NOT
>>  * GUARANTEE that "len" bytes is written even if the operation is successful.
>>  */
>>
>> I suspect that at this point I am not adding much value here, so I
>> will leave it at this.
>
> No, the problem is in this line:
>
>                                  if (write_in_full(fd, contents + copy_begin,
>                                                    copy_end - copy_begin) <
>                                      copy_end - copy_begin)
>                                           goto write_err_out;
>
> write_in_full() returns -1 on error (_not_ how many bytes were actually
> written). So its return is a signed ssize_t. But the result of the
> pointer subtraction "copy_end - copy_begin" is an unsigned ptrdiff_t.
> The compiler promotes the signed to an unsigned, so the condition can
> never be true (the "-1" becomes the highest possible value).

Bah. Good eye. I missed that entirely.

> I have the fix, but I'm searching the code base for other instances of
> the same error.

Yeah, I think there are few just in that file.

Thanks for fixing this!

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
