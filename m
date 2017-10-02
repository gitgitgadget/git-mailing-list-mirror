Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D2F202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 10:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdJBKPW (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 06:15:22 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:45900 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdJBKPV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 06:15:21 -0400
Received: by mail-pg0-f44.google.com with SMTP id 188so2764683pgb.2
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 03:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P2Ol9LILtTshtewoPOT4HSO4985CV1GgJ1ALMJxaDXc=;
        b=ryFAts/AMEiuURF58qTwyWS2DQChWPTI1uleA7DRj8tvkLUZ1J6ShhdWHIpqQC+Uge
         qpgqzF+t5ezsWHW1T23yp49uKfYKIoTG9I2wFMnvkTwsOwgTvupB4MY8UrL9d10EwFfF
         5C5RdyymU4hhBtyjWfEduO0ZkfYbtOQhzMec/DbcpCt7aheDQbstq3nVdSafZX9h5JDl
         uQfHXy0vrk1LqnxCkGjfBa94d6xGytcWxLaANFX/VCOVVa8YT3z8v+B7+fySDbdnqQDX
         r4BIdvGHcYpN72DYezJb/Z8mgcUtHFMQ+4THin2hYxgecxtyEYHIYZmJRIsbNC3flrQ1
         /F1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P2Ol9LILtTshtewoPOT4HSO4985CV1GgJ1ALMJxaDXc=;
        b=XaGEeYu5UJM9wI9VeCIojmqOLK5f+IS18xYNWcY2nU3kQQtnYzZ5XypwSiARwSA/z5
         dFrbqXaqFBPOO8UQrri3sjX3b+hM1aRN8tfQw0KbpgrEn6xLXUjc7hGGGH0/3P8lM3kA
         kOz49X6opkzbwfolTVs6quMa1Vd25FDVzYvSKQ9PCQHPX6yINlWruNhImHuaRidY0BuS
         y/jRi04EmWtZ3NUZ+JdBUF8+ml6WN8tcnvgfZs2z9op91QBJXg0URQQMgKI8n6UZ8WQR
         nbfVZ/PsLByuAQeaOYse1UC8yxU/KzfhuGlfRUPV1GHrXTJE2rpRSAUSBNRGuu5VrZxy
         b8vw==
X-Gm-Message-State: AHPjjUjNWJM3tsCfjFdK6iqFsz5SvAoRuz5SdgY4eukoHj0cU7XqlWlx
        bgD60FAsE6AMcV4LTkrAgsFSqcINyCOZRNiRUx8=
X-Google-Smtp-Source: AOwi7QC4d9qesOUeLKFvbFhEO2YtE+THe5eVnd0JxK6vQdS0ZXWSyfhleItcggjBKXx22um0izYYNCjnJbRcA/ut6tk=
X-Received: by 10.84.185.106 with SMTP id e39mr13554415plg.333.1506939321006;
 Mon, 02 Oct 2017 03:15:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Mon, 2 Oct 2017 03:15:20 -0700 (PDT)
In-Reply-To: <20171002052659.hgzkhz4sgez3mkgz@sigill.intra.peff.net>
References: <cover.1506862824.git.martin.agren@gmail.com> <9725917d9854a54e4daeda70940c3bb0ff5d9201.1506862824.git.martin.agren@gmail.com>
 <20171002052659.hgzkhz4sgez3mkgz@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 2 Oct 2017 12:15:20 +0200
Message-ID: <CAN0heSotumvyYDa8zsRx9cNd8LF+CgUOGgd+eFPEmwBqJsjfkA@mail.gmail.com>
Subject: Re: [PATCH 01/11] sha1_file: do not leak `lock_file`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 October 2017 at 07:26, Jeff King <peff@peff.net> wrote:
> On Sun, Oct 01, 2017 at 04:56:02PM +0200, Martin =C3=85gren wrote:
>
> The original code is actually a bit confusing/unsafe, as we set the
> "found" flag early and rollback here:
>
>> @@ -481,17 +481,15 @@ void add_to_alternates_file(const char *reference)
>>               strbuf_release(&line);
>>               fclose(in);
>>
>> -             if (found) {
>> -                     rollback_lock_file(lock);
>> -                     lock =3D NULL;
>> -             }
>> +             if (found)
>> +                     rollback_lock_file(&lock);
>
> and that leaves the "out" filehandle dangling. It's correct because of
> the later "do we still have the lock" check:
>
>> -     if (lock) {
>> +     if (is_lock_file_locked(&lock)) {
>>               fprintf_or_die(out, "%s\n", reference);
>
> but the two spots must remain in sync. If I were writing it from scratch
> I might have bumped "found" to the scope of the whole function, and then
> replaced this final "do we still have the lock" with:
>
>   if (found)
>         rollback_lock_file(&lock);
>   else {
>         fprintf_or_die(out, "%s\n", reference);
>         if (commit_lock_file(&lock))
>         ...etc...
>   }
>
> I don't know if it's worth changing now or not.

I'd like to address the feedback on other commits in a re-roll. I will
use that opportunity to try your approach above instead of this patch.

Thanks.
