Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 184F5202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 23:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbdB1Xl6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 18:41:58 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:33501 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdB1XkY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 18:40:24 -0500
Received: by mail-io0-f171.google.com with SMTP id f84so19230264ioj.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 15:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jqN2OQcpEG04UrO7efYfjS6Je7qVX7FvGsBjJ5P2Cu0=;
        b=In6uEKPed3FyJh1lpKCeTRROaEGJjl4FL9eI0k2AiNNKELSJyi1jLdzVCDVDQAUjt6
         bhBKxkvaAU0m0u6+ry3mK2hKXbdGxlRf/I/JVwOKaMsQgsXBG2LX6762QUXBqu3f5q4E
         Le6ZoFig2t3Q9Unax7FQl9F14Zn/Xn0tieHwIFIQ8AevQfN0wFbYrIQkbF+rn7WFQrIv
         T9EHEVrLkm6y9XGzDhuHVgZmpyNlsiRm1kw9LfFUYROyDVnmk5zPEtEEoG9fQ+VMKOi1
         up3/ViBncb7VlZokUzMRLZJQdVh9htOzd6Pi2s6UI3BE7+XbZLEK8cDWlym2Grla/Bdt
         nKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jqN2OQcpEG04UrO7efYfjS6Je7qVX7FvGsBjJ5P2Cu0=;
        b=nVXZ/8Tpdp3xR1FvMzxALVr/9N+mACZxkqhL9Vwo+SuZdOlyWY2jzRvjRqYvArIQRb
         NqoFLLY4fWmFhQ458bmuV2Vh7IGg9PZSuXAAseu13wL6Espl5mtvjYSyHPi/2zUn2+3J
         WYP7ZpBtULL8mFjGJ8DLRW6zAq3a16MuvHSVCM+S+vWxhYmHGLjn+ZwEaV6iyZ91v1NK
         ePaLDVjlrI4Pq8Zm/X2TBXigiNlpK9LlC2c0FWLtmGrzZn0YiYJHSl0sPTZUTp5awSqU
         NTwb3E10Xo28C3L3ygDa8KRz+DrNyBIwf+eCLQxJfmnMa6lEPOsqtUd3b12VCXYIDcDE
         IccA==
X-Gm-Message-State: AMke39lYSZHxV3eqP1XRsrb6UUX0Nppm5k5ZZm4gAvOU2PKzdm0GNbksU0Lj3GuGUg5dhFyH/PVP81B+25YWSA==
X-Received: by 10.107.5.213 with SMTP id 204mr5220929iof.189.1488323492703;
 Tue, 28 Feb 2017 15:11:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Tue, 28 Feb 2017 15:11:32 -0800 (PST)
In-Reply-To: <259cc328-13f7-2d2d-c86f-8b4fc7da8e34@cwi.nl>
References: <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net> <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net> <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
 <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net> <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
 <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net> <alpine.LFD.2.20.1702231428540.30435@i7.lan>
 <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net> <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
 <xmqqefyikvin.fsf@gitster.mtv.corp.google.com> <xmqq60jukubq.fsf@gitster.mtv.corp.google.com>
 <CA+55aFxTWqsTTiDKo4DBZT-8Z9t80bGMD3uijzKONa_bYEZABQ@mail.gmail.com>
 <CY1PR0301MB21078DDCA8C679983D22821FC4560@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <259cc328-13f7-2d2d-c86f-8b4fc7da8e34@cwi.nl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2017 15:11:32 -0800
X-Google-Sender-Auth: VAWFPIozZ9x-q1c8sEHKNn1nWlE
Message-ID: <CA+55aFwjzbhYyFm_MqL=cDZZeKbSjqd-jSeb0yW_bJ_WQTzEpA@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Marc Stevens <marc.stevens@cwi.nl>
Cc:     Dan Shumow <danshu@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 2:50 PM, Marc Stevens <marc.stevens@cwi.nl> wrote:
>
> Because we only have 32 disturbance vectors to check, we have DVMASKSIZE
> equal to 1 and maski always 0.
> In the more general case when we add disturbance vectors this will not
> remain the case.

Ok, I didn't get why that happened, but it makes sense to me now.

> Of course for dedicated code this can be simplified, and some parts
> could be further optimized.

So I'd be worried about changing your tested code too much, since the
only test-cases we have are the two pdf files. If we screw up too
much, those will no longer show as collisions, but we could get tons
of false positives that we wouldn't see, so..

I'm wondering that since the disturbance vector cases themselves are a
fairly limited number, perhaps the code that generates this could be
changed to actually just generate the static calls rather than the
loop over the sha1_dvs[] array.

IOW, instead of generating this:

        for (i = 0; sha1_dvs[i].dvType != 0; ++i) {
                .. use sha1_dvs[i] values as indexes into function arrays etc..
        }

maybe you could just make the generator generate that loop statically,
and have 32 function calls with the masks as constant arguments.

.. together with only generating the SHA1_RECOMPRESS() functions for
the cases that are actually used.

So it would still be entirely generated, but it would generate a
little bit more explicit code.

Of course, we could just edit out all the SHA_RECOMPRESS(x) cases by
hand, and only leave the two that are actually used.

As it is, the lib/sha1.c code generates about 250kB of code that is
never used if I read the code correctly (that's just the sha1.c code -
entirely ignoring all the avx2 etc versions that I haven't looked at,
and that I don't think git would use)

> Regarding the recompression functions, the ones needed are given in the
> sha1_dvs table,
> but also via preprocessor defines that are used to actually only store
> needed internal states:
> #define DOSTORESTATE58
> #define DOSTORESTATE65

Yeah, I guess we could use those #define's to cull the code "automatically".

But I think you could do it at the generation phase easily too, so
that we don't then introduce unnecessary differences when we try to
get rid of the extra fat ;)


> Note that as each disturbance vector has its own unique message differences
> (leading to different values for ctx->m2), our code does not loop over
> just 2 items.
> It loops over 32 distinct computations which have either of the 2
> starting points.

Yes, I already had to clarify my badly expressed writing on the git
list. My concerns were about the (very much not obvious) limited
values in the dvs array.

So the code superficially *looks* like it uses all those functions you
generate (and the maski value _looked_ like it was interesting), but
when looking closer it turns out that there's just a two different
function calls that it loops over (but it loops over them multiple
times, I agree).

                           Linus
