Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C411FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 17:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbdJ0RPd (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 13:15:33 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:48993 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdJ0RPc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 13:15:32 -0400
Received: by mail-qt0-f182.google.com with SMTP id f8so9275402qta.5
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vcONoZMgZnPp2/0Gk7yHCWkUvMZagqf+67KpFPNt7/k=;
        b=j+MsG3ZPFDLmGlF5H5Fb0hK1Qa+Q8XF3rXP+6jnR319uvLl4a0erOSrAQ7IDL0jh03
         Ta1Ql8IE1boIQxL7u3wDDSykdflpjULr15m6e7jZYqq9EFUvlR+mbiIV8Ak1V5p0zMmq
         tSbtt0mZ+PU7P4pS81NFje7ozP4A7SR/AhR0nkZb/aEscuBsA9jqKX1fbKQHwg+on/HK
         dWaoy8jxfU1BRxkYChTNUaYn0kdogb32TpzZF0xXzLWA1pDX0DAq99fOqvUb8H5r1YLL
         GdtJ1aPuY50vfhTfjfeKyY4bQI9U8Co7HLO6Q4dNrHhcN8fsR+6cJ9iom02As8u8mVPz
         zGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vcONoZMgZnPp2/0Gk7yHCWkUvMZagqf+67KpFPNt7/k=;
        b=iDnS1M4t5byG07AJErVNPiAm+J1HkkBbO1E6/N7E8yCCZbdI9UFjE8VM8/M8Cn4APv
         NVTgan+Zky7I8V5T1SW59+MSpx7f/C+p0igNdcRm6l6S/Jm+k+5PGFG91ASKlZ4tznlv
         qGsqaBPPaOYZdfwNSuBZnmuItDU6XSjSaKhqvCHLzPVVi+ks9lQAkIK6VTnoDWFrarCI
         /bT9Hy9ExmiW61ZyQnZdYtRjQp3l0xrlZoKOBW7OOqnwaF4crUIPo4J7itCpqr9R0acX
         BhqchsrCSuXWaVqjXaFxjumi33uzUZk0OYn8YaFMd/4Hmcu1Ub64TqdIA9VE9E8MA4yW
         JJEA==
X-Gm-Message-State: AMCzsaXyJd0cZmCXafM2jhn2uh3gx2mnCIxG/w/mfnUYm7u+aQtbW/sp
        fQpxvWslyYw8mP8ru/qeRAdOJKU3D4HkFuk/03/O2g==
X-Google-Smtp-Source: ABhQp+RCWgD1cTQuhANqNwh78uoLN7SREagDM5CEhRzsV6L5y09PFfj5dZLfnEa6rhTSsiuTTjidhtXt0Do+TfEzKp4=
X-Received: by 10.200.8.53 with SMTP id u50mr2091522qth.260.1509124530879;
 Fri, 27 Oct 2017 10:15:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 27 Oct 2017 10:15:30 -0700 (PDT)
In-Reply-To: <xmqqefppcbec.fsf@gitster.mtv.corp.google.com>
References: <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com> <20171025184912.21657-1-sbeller@google.com>
 <20171025184912.21657-2-sbeller@google.com> <3f656948-273f-e01d-ad52-e460059571da@web.de>
 <xmqqefppcbec.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 27 Oct 2017 10:15:30 -0700
Message-ID: <CAGZ79kZgXZsBOf=9MZnoOCpJmARbaEaLPDBVAGN4GMvxhMotog@mail.gmail.com>
Subject: Re: [PATCH 1/2] xdiff-interface: export comparing and hashing strings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 27, 2017 at 12:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 25.10.2017 um 20:49 schrieb Stefan Beller:
>>> +/*
>>> + * Compare the strings l1 with l2 which are of size s1 and s2 respecti=
vely.
>>> + * Returns 1 if the strings are deemed equal, 0 otherwise.
>>> + * The `flags` given as XDF_WHITESPACE_FLAGS determine how white space=
s
>>> + * are treated for the comparision.
>>> + */
>>> +extern int xdiff_compare_lines(const char *l1, long s1,
>>> +                           const char *l2, long s2, long flags);
>>
>> With the added comment it's OK here.
>>
>> Still, I find the tendency in libxdiff to use the shortest possible
>> variable names to be hard on the eyes.  That math-like notation may have
>> its place in that external library, but I think we should be careful
>> lest it spreads.
>
> Yeah, I tend to agree.  The xdiff-interface is at the (surprise!)
> interface layer, so we could make it follow the style of either one,
> but we seem to have picked up the convention of the lower layer,
> so...
>
> By the way, I was looking at the code around this area while
> reviewing the cr-at-eol thing, and noticed a couple of things:
>
>
>  * combine-diff.c special cases only IGNORE_WHITESPACE and
>    IGNORE_WHITESPACE_CHANGE but no other IGNORE_WHITESPACE things; I
>    have a suspicion that this is not because IGNORE_WHITESPACE_AT_EOL
>    does not have to special cased by the codepath, but only because
>    the combine-diff.c refactoring predates the introduction of
>    ws-at-eol thing?

I wonder how much overlap between the IGNORE_WHITESPACE_AT_EOL
and CRLF-AT-EOL is (maybe these can be combined, as per the root of
this discussion)

>    The machinery uses its own match_string_spaces() helper; it may
>    make sense to use the same xdiff_compare_lines() in its callers
>    and get rid of this helper function.

Speaking of xdiff_compare_lines, it serves the special purpose of the
move detection as well as its internal use cases, but we may need to
change its interface/implementation in the future, to align it with strcmp,
currently the compare function only returns equality, not an order.

>  * diff_setup_done() sets DIFF_FROM_CONTENTS when any of the
>    IGNORE_WHITESPACE bits is true, to allow "git diff -q
>    --ignore-something" would do the right thing.  We do not however
>    give a similar special case to XDF_IGNORE_BLANK_LINES.
>
>    $ echo >>Makefile && git diff $option --ignore-blank-lines Makefile
>
>    exits with 1 when option=3D--exit-code and it exits with 0 when
>    option=3D-q
>
>
> For now I'll leve these as #leftoverbits, but I may come back to the
> latter soonish.  I won't come back to the former until Stefan's
> refactor hits 'master', though.

which is presumably after the 2.15 release.

To tack on the #leftoverbits: The --color-moved detection doesn't
pay attention to XDF_IGNORE_BLANK_LINES (which is tricky as
it is on the per-line layer. If we want to ignore spurious blank lines,
we'd have to check for this flag in diff.c in mark_color_as_moved(..)
in the block
    /* Check any potential block runs, advance each or nullify */

Thanks,
Stefan
