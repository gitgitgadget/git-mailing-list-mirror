Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08A120248
	for <e@80x24.org>; Mon, 11 Mar 2019 10:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfCKKkv (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 06:40:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40455 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfCKKkv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 06:40:51 -0400
Received: by mail-io1-f67.google.com with SMTP id p17so3553944iol.7
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=s7PidRNrP0JLUMFCJSQ/njqQ9MIpCUmFmV6cy/5sZyI=;
        b=kgqpqc7wJBuIItSCDpQ/0LOKsEsIXYOpNm+dbqROT5U9nECKYUNhiiSK7RinQTHiYy
         +HCf7XjnZO81OWeRTYyxfwIv0DcuIvvB+a4M4c1nlizDa2OPs9ll24o3sRa56AO+g8xw
         /5gSZFwzq46iXfpebXPVE4Rikzof+kMdNS4MqUdRdVNKq2onxBcrXejVVMDotl6p4B7q
         NxvU1PetoBVxjlQVtLBY7bXaZzxxJVPuJsoCGJY7rkZ850b1hJ7+LPhjFi3N39zU1dd4
         WAC8bIbsFkQ6kxtPwJMP1sokObRhgQnW1ZAiWrn9/VwfuTOaI+3ZrQYNXeoZHu4mTJv9
         LY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=s7PidRNrP0JLUMFCJSQ/njqQ9MIpCUmFmV6cy/5sZyI=;
        b=Y6hRm6fyEmmSR2mLFfBSNMSEDYMIQ9VPHiIvKD+NcNnGdifHztYd3ieyxEZ3SRZ3ej
         TSzc0xODU+o8jmlwBSlLTunRJdgiuIvUVrZGPQoUPQOS4jlB5MAxd7/Pi3oYglwj9AVL
         yY0npOUEmNVaXruUCqHnIVfSGpv9REDHxNBHaK1HIb8tspmf9ETqkTSgcgUMUl0OHb7L
         8JaZ1f2O81rHj8p1ciclzU43J2/ctfWc1LF7HF2tRScLECJtwLhiTA/He8RwVo9OUHO8
         1wzRhBSB95yo0Czav7edCdLcPUsyy34mulokRXrqNcYqQosQh9zdV5NnCRjU9UaeANF+
         t3aA==
X-Gm-Message-State: APjAAAVNxcNurf5W3IqtdXfiw2OhG+GMZ1jOl/iFaWWpVZex4TDvRsVv
        WeNxaGGl+ZQqiVlkZ0hwPakyk8i+7GxbEJPQTFY=
X-Google-Smtp-Source: APXvYqxTrJKrfW8djLC5E9o3bRS/S8CXsDgH+K9XIAxxNH4AsUyDT4aI9PVqLJDJOLTV1+GkgGysBph3VoLkiIE0ylk=
X-Received: by 2002:a5d:9806:: with SMTP id a6mr10108481iol.296.1552300850481;
 Mon, 11 Mar 2019 03:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net> <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
 <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com> <20190311033755.GB7087@sigill.intra.peff.net>
In-Reply-To: <20190311033755.GB7087@sigill.intra.peff.net>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 11 Mar 2019 06:40:21 -0400
Message-ID: <CAH8yC8=9HOAmDE93aXd300kOJSOa0sA8Qv2cNn2M-EO-gqiktw@mail.gmail.com>
Subject: Re: disabling sha1dc unaligned access, was Re: One failed self test
 on Fedora 29
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 11:37 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Mar 11, 2019 at 11:00:25AM +0900, Junio C Hamano wrote:
>
> > Jeffrey Walton <noloader@gmail.com> writes:
> >
> > > I think this is the patch for sha1dc/sha1.c . It stops using unaligned
> > > accesses by default, but still honors SHA1DC_FORCE_UNALIGNED_ACCESS
> > > for those who want it. Folks who want the undefined behavior have to
> > > do something special.
> >
> > Hmph, I somehow thought that folks who want to stick to the
> > standard printed on paper penalizing what practicaly works well in
> > the real world would be the one doing extra things.
>
> Unfortunately, I don't think sha1dc currently supports #defines in that
> direction. The only logic is "if we are on intel, do unaligned loads"
> and "even if we are not on intel, do it anyway". There is no "even if we
> are on intel, do not do unaligned loads".
>
> I think you'd need something like this:
>
> diff --git a/Makefile b/Makefile
> index 148668368b..705c54dcd8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1194,6 +1194,7 @@ BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
>  BASIC_CFLAGS += -fno-omit-frame-pointer
>  ifneq ($(filter undefined,$(SANITIZERS)),)
>  BASIC_CFLAGS += -DNO_UNALIGNED_LOADS
> +BASIC_CFLAGS += -DSHA1DC_DISALLOW_UNALIGNED_ACCESS
>  endif
>  ifneq ($(filter leak,$(SANITIZERS)),)
>  BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index df0630bc6d..0bdf80d778 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -124,9 +124,11 @@
>  #endif
>  /*ENDIANNESS SELECTION*/
>
> +#ifndef SHA1DC_DISALLOW_UNALIGNED_ACCESS
>  #if defined(SHA1DC_FORCE_UNALIGNED_ACCESS) || defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
>  #define SHA1DC_ALLOW_UNALIGNED_ACCESS
>  #endif /*UNALIGNMENT DETECTION*/
> +#endif
>
>
>  #define rotate_right(x,n) (((x)>>(n))|((x)<<(32-(n))))
>
> but of course we cannot touch sha1dc/*, because we might actually be
> using the submodule copy instead. And AFAIK there is no good way to
> modify the submodule-provided content as part of the build. Why do we
> even have the submodule again? ;P
>
> I guess the same would be true for DC_SHA1_EXTERNAL, too, though.
>
> So anyway, I think this needs a patch to the upstream sha1dc project.

https://github.com/cr-marcstevens/sha1collisiondetection/issues/47

Jeff
