Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86821F453
	for <e@80x24.org>; Thu, 27 Sep 2018 21:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeI1Diq (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 23:38:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35473 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbeI1Diq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 23:38:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id o16so4169253wrx.2
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 14:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mYiHZWyE5MIGceONcEDaMEirC1nWmuRasNk7/1tpfsA=;
        b=SQFY68zpEPn8NXigxn5l0qObxUqtiG3A4sZCTetejBviL0ZaOMay8f659bQHAUOPjY
         ikkyyre9SiA3HYoeAA4UwkrPjWnuL0jEGzrVuMkoXENFRoFxIrdGSUidEW2mqp+LdDt7
         nfszdr3k7mVDckTMnlWFxEfBiUOVSmJgDJ1lYCAzNx6ElhY0tHWC6pg1WzmS11QeZQ9d
         arspGlpAmoScTp//cKynxt1CIUNjDmDBDvbvcZkZUSEum4Lro4X4Y54gK2ZqEvLR0pRg
         reb0XjvgUqxVqcuWxiFNNtGJGQoCuAPaF0rJoTlHgMK7MbsohTQB/wx4pAZ3EZc/3CM+
         yKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mYiHZWyE5MIGceONcEDaMEirC1nWmuRasNk7/1tpfsA=;
        b=Tj1vOk/j0KDjC8GG/xp8B3VNsBtYadKzPb+zSL43z1C27y7nCcoOzd7QD5oqxOiXWY
         79VhP4SOJdfmW0NXZIQN3e3P1h5bgpmkymMaOFTQf7wGQ5Ir3fcHyYotDA+ta+SPMREU
         e0jfxJuTE45IonswOjfZ9FyIsCo66TKT6M8MtYDgnBloCyM+q3zYWDVZlYOsqR/XSnaO
         k53RNYNKcBm+RMnSOws9qUn20nKLRFp0Z7o/GMxiyn+tR0Vvq7JrfmJjvhAqbj+IMUvn
         ime8f0VQOWPTXQffszLr1GLydd2VqyneHkNWjYrXkn/PDygEQ+/VDziAEEmTlkc0Ofj3
         jdXA==
X-Gm-Message-State: ABuFfoitSXodPq3LnwH6m8BO1EySc17aHPzGbHSJOhs//aH7bv6GWiYo
        RWOysPWfr4ellyqm86bUdT4=
X-Google-Smtp-Source: ACcGV602NG16abBIcbul/cNe49FNc0pJSG0o2kbzyXAc72HklkXFarOUmHx80kdcidswKKjbT+q/6g==
X-Received: by 2002:a5d:608b:: with SMTP id w11-v6mr10668113wrt.193.1538083109318;
        Thu, 27 Sep 2018 14:18:29 -0700 (PDT)
Received: from localhost (x4dbd8656.dyn.telefonica.de. [77.189.134.86])
        by smtp.gmail.com with ESMTPSA id i4-v6sm4839040wrs.87.2018.09.27.14.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 14:18:28 -0700 (PDT)
Date:   Thu, 27 Sep 2018 23:18:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/5] CodingGuidelines: add shell piping guidelines
Message-ID: <20180927211826.GL27036@localhost>
References: <cover.1536969438.git.matvore@google.com>
 <cover.1537493611.git.matvore@google.com>
 <7dd9a1120726dee34aeebdfa4bf45a232c185500.1537493611.git.matvore@google.com>
 <20180924210314.GE27036@localhost>
 <CAMfpvhJ-chi7OMRKjjk79r0uqCqW67Vj9J=tT7Kz-XUmw41H5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMfpvhJ-chi7OMRKjjk79r0uqCqW67Vj9J=tT7Kz-XUmw41H5A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 02:58:08PM -0700, Matthew DeVore wrote:
> Here is the new commit with updated message (I will wait for a day or
> two before I send a reroll):
> 
>     Documentation: add shell guidelines
> 
>     Add the following guideline to Documentation/CodingGuidelines:
> 
>             &&, ||, and | should appear at the end of lines, not the
>             beginning, and the \ line continuation character should be
>             omitted
> 
>     And the following to t/README (since it is specific to writing tests):
> 
>             pipes and $(git ...) should be avoided when they swallow exit
>             codes of Git processes
> 
>     Signed-off-by: Matthew DeVore <matvore@google.com>
> 
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 48aa4edfb..3d2cfea9b 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -118,6 +118,24 @@ For shell scripts specifically (not exhaustive):
>                  do this
>          fi
> 
> + - If a command sequence joined with && or || or | spans multiple
> +   lines, put each command on a separate line and put && and || and |
> +   operators at the end of each line, rather than the start. This
> +   means you don't need to use \ to join lines, since the above
> +   operators imply the sequence isn't finished.
> +
> +        (incorrect)
> +        grep blob verify_pack_result \
> +        | awk -f print_1.awk \
> +        | sort >actual &&
> +        ...
> +
> +        (correct)
> +        grep blob verify_pack_result |
> +        awk -f print_1.awk |
> +        sort >actual &&
> +        ...
> +
>   - We prefer "test" over "[ ... ]".
> 
>   - We do not write the noiseword "function" in front of shell
> @@ -163,7 +181,6 @@ For shell scripts specifically (not exhaustive):
> 
>     does not have such a problem.
> 
> -
>  For C programs:
> 
>   - We use tabs to indent, and interpret tabs as taking up to
> diff --git a/t/README b/t/README
> index 9028b47d9..3e28b72c4 100644
> --- a/t/README
> +++ b/t/README
> @@ -461,6 +461,32 @@ Don't:
>     platform commands; just use '! cmd'.  We are not in the business
>     of verifying that the world given to us sanely works.
> 
> + - Use Git upstream in the non-final position in a piped chain, as in:

Note the starting upper case 'U'.

> +
> +     git -C repo ls-files |
> +     xargs -n 1 basename |
> +     grep foo
> +
> +   which will discard git's exit code and may mask a crash. In the
> +   above example, all exit codes are ignored except grep's.
> +
> +   Instead, write the output of that command to a temporary
> +   file with ">" or assign it to a variable with "x=$(git ...)" rather
> +   than pipe it.
> +
> + - Use command substitution in a way that discards git's exit code.

'U' again.

> +   When assigning to a variable, the exit code is not discarded, e.g.:
> +
> +     x=$(git cat-file -p $sha) &&
> +     ...
> +
> +   is OK because a crash in "git cat-file" will cause the "&&" chain
> +   to fail, but:
> +
> +     test_cmp expect $(git cat-file -p $sha)
> +
> +   is not OK and a crash in git could go undetected.

Well, this is not OK indeed, because it doesn't make any sense in the
first place :)  'test_cmp' requires two paths as argumens, but the
output of 'git cat-file -p' is the whole _content_ of the given object.

>   - use perl without spelling it as "$PERL_PATH". This is to help our

Note the starting lower case 'u'.

This is because these are the continuation of the "Don't:" some lines
earlier, so your new points should start with a lower case 'u' as
well.


Sidenote: I think we should consider reformatting this whole section
as:

  - Don't do this.
  - Don't do that.

because it grew so much that when I look at the last points, then that
starting "Don't:" has already scrolled out of my screen.

>     friends on Windows where the platform Perl often adds CR before
>     the end of line, and they bundle Git with a version of Perl that
> 
> 
> >
> >
> > These last two points, however, are specific to test scripts,
> > therefore I think they would be better placed in 't/README', where the
> > rest of the test-specific guidelines are.
> >
> > >  For C programs:
> > >
> > > --
> > > 2.19.0.444.g18242da7ef-goog
> > >
