Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37571201CF
	for <e@80x24.org>; Wed, 17 May 2017 06:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbdEQGaf (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 02:30:35 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36589 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdEQGae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 02:30:34 -0400
Received: by mail-io0-f169.google.com with SMTP id o12so3476937iod.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 23:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qBLPYU6wQXE2pH+cubDFd8BGw4nPzyC43cz+cqNLffM=;
        b=W3VC0vpriBVtieBgD1hvc/hVgYk124SrA7KPHM+178Myzh0CvMmKJBOQrjaIOs8MP1
         UP05Jb1qkkdMrKHWFno9JhY57vIkhjRMjrr9AEa/kgyN1V1z1E7JEbIoxkstUnj6agMS
         /9KMrecI5J2O4Ad5jPPqjnwm6qav14kF9zbDMUIXi+1bssXulDKFWu2GmhFPBQtyE9T+
         PkkTzVJ4/cYfhrrO0cWT1yNLmEHK7KGnm1FCoT3Le00wTmR71wVAuPyOQ95rsocfiABs
         llTFirnqeiHRVGcSYwtfZTv57Eh1eXZl72bjrqGKYdIKSllulvsh0VnrqRxdmODUPKik
         86CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qBLPYU6wQXE2pH+cubDFd8BGw4nPzyC43cz+cqNLffM=;
        b=BiKWS+Hg3MEOTYb0W44u4y4nZFqCrZyR2CowgZs/LmINMXji1ak7ydDgw+RVEWwD+C
         TD+E/OsPE29/IgHx3fn6+GNnbzEtKfaQivIx+p4Yv0JRA75YsNqoSbNukkur8u2YnF7y
         on2s3BWmlmqa2uCgYE5NtgHRQfveVYVD4byrZgdxUCeSPdI+1BAGfv8KW04i7x7mQPqu
         17boyWl44bUdN89PwfRvvXhW2T3A0lU7BIzkyjIC0a3Z8lciiW0ecP9cfeuwj9o2AOGn
         Zf3IhBXYdqxuhHp/qp+PuJVLgcOwjt5pduGu/cORazBB/BLQBUW8s6+78TGAkD5HgJ3o
         7wmQ==
X-Gm-Message-State: AODbwcDAytD/BrVI+kB5NSAhJiS+W1M1dC3aOAk0m7cQwq66+AwQoL+T
        +0CcAMl6bujhKkf7kPYjdujsx4SOPg==
X-Received: by 10.107.138.21 with SMTP id m21mr1659190iod.80.1495002633506;
 Tue, 16 May 2017 23:30:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 16 May 2017 23:30:12 -0700 (PDT)
In-Reply-To: <xmqq37c4xcr6.fsf_-_@gitster.mtv.corp.google.com>
References: <CACBZZX6nmKK8af0-UpjCKWV4R+hV-uk2xWXVA5U+_UQ3VXU03g@mail.gmail.com>
 <006301d2cd83$663b5520$32b1ff60$@marc-stevens.nl> <CACBZZX5Q9paMbYWH47fdK9GuNrE=F=FwR__E1yZ32EOAMw_w6w@mail.gmail.com>
 <CAKKM46vwM9pxyMxTc4jA0z_8vGKdDGCGg9ziKkFAsqr5ULYJxA@mail.gmail.com>
 <007001d2cd88$2b916180$82b42480$@marc-stevens.nl> <CAKKM46sS_5bVe5a6wNN7SdVoGvwmVxnLAZTxJ+tSftXfZKeGWg@mail.gmail.com>
 <xmqq37c4xcr6.fsf_-_@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 17 May 2017 08:30:12 +0200
Message-ID: <CACBZZX6cCjorisOn9qyrDH9L_MtKAsLLW=q1_htuaJ+E0QK9rg@mail.gmail.com>
Subject: Re: [PATCH] sha1dc: fix issues with a big endian platform
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 7:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> From: Marc Stevens <marc@marc-stevens.nl>
>
> Some big-endian platforms define _BIG_ENDIAN, which the test at the
> beginning of file has missed.  Also, when the input is not aligned,
> some platforms trigger SIGBUS.
>
> This change corresponds to 33a694a9 ("Fix issues with a big endian
> platform", 2017-05-15) in the history of the upstream repository
> https://github.com/cr-marcstevens/sha1collisiondetection

Then why not just update sha1dc from upstream instead of
cherry-picking one patch from them? My update-sha1dc change does this:
https://github.com/git/git/compare/master...avar:update-sha1dc

This follows the instructions Jeff detailed in 28dc98e343. I solved a
few merge conflicts, I think I got them right, but review of that
especially welcome.

Maybe you just meant this patch for maint, but if that's the case it's
not clear from your commit message or E-Mail.

> ---
>
>  * So here is my attempt to clarify the log message (I left the
>    title as-is, but this change deals both with endianness and
>    alignment requirement).
>
>    Please look it over, and then sign-off your patch ;-)
>
>    Thanks.
>
>    P.S. I wonder how often "buf" is not aligned---could we somehow
>    optimize out memcpy when it is not necessary, or is it not worth
>    it?
>
>  sha1dc/sha1.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index 35e9dd5bf4..ae25318c47 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -20,7 +20,7 @@
>   */
>  #if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
>      (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) || \
> -    defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \
> +    defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \
>      defined(_MIPSEB) || defined(__MIPSEB) || defined(__MIPSEB__)
>
>  #define SHA1DC_BIGENDIAN       1
> @@ -1728,7 +1728,8 @@ void SHA1DCUpdate(SHA1_CTX* ctx, const char* buf, size_t len)
>         while (len >= 64)
>         {
>                 ctx->total += 64;
> -               sha1_process(ctx, (uint32_t*)(buf));
> +               memcpy(ctx->buffer, buf, 64);
> +               sha1_process(ctx, (uint32_t*)(ctx->buffer));
>                 buf += 64;
>                 len -= 64;
>         }
> --
> 2.13.0-416-g4c6b804423
>
