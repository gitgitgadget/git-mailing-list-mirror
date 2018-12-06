Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7A4211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 23:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeLFXCW (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 18:02:22 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:36540 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeLFXCV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 18:02:21 -0500
Received: by mail-it1-f182.google.com with SMTP id c9so4291583itj.1
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 15:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7ecP6/Fnrm9n8hFCspVN+9fPC9wLQ6F0WNi6PZElGqw=;
        b=OOtRAJvQCdshMm9Kqi16Li5EAHgu4iGrxpraTpblcftvxFdhmPNW9OrsRm1UldtjPQ
         Md+p7NtqMyiEM4mxkKHRAd8WuzN3BzzQi35CU3mO0b09ND8I+VmAe6ejrXjb1r3ICRFA
         8AZOsM3Jb83g9fgw1MHFbbO1o+bDb0LZCRKXy3drcrGcbkJ9C70Pj2LNDoi3DNPM91Ix
         PzAFK34ynx9LJfd1IR/NOLsNk8bZPtBgt5xeECX11sdDQxrMW8A1EnW4LaQ+RJwr8rPn
         wVpZnEqXlEylhOc9FxfsmsgT1lsC5OXYIC/u0Ow4FltYCl53sP0MnXKxw2OHCAu+Lnfh
         6DTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7ecP6/Fnrm9n8hFCspVN+9fPC9wLQ6F0WNi6PZElGqw=;
        b=Mj36fhqYO4rLkv7lDrQC5RlrrohxDaqMew0LqugpufLeDJuHiJ6zylyF1ccyY5br4d
         SK/tyqxQmeX1o08D2q8S6KeJsrcWYXGmJdQMHXRFNBraa89FQlpwaKspMwsGNgISJ4x/
         5dgdNxbnZSLvvgdW7VFfUwOE2o8J6xxP+pcBa7dYVMOoH+JLfz/I0QX2lFQiVQJCjXaR
         dTcyXpcm3f4U0ThE8wqqOCNVWBMNiXmHesNp5QUSOGt6YYB2xl3nI5Ul2NnvWSu4Uu8y
         K7xYE4t3wcgihwbroP5iu6EHYIesNcE70DlKR7jNWSbgWuluhM25srRI/NhNtikgOX8K
         gk3A==
X-Gm-Message-State: AA+aEWbOgmoiS0dpp3/jWwMvUxCXPnwO9q5SC6pW9TxJ22Y+UroNEq3H
        rSR7jk+G6Fb3OJ49simGMQLc5tyHhMrIQPCqNXQ=
X-Google-Smtp-Source: AFSGD/XeufwE9lFrxJbi2J71eVKJnrbsQOBNYGVnRBL7AHXtI22BK3qOZHUtC30c8HrfHQnBX3wFh9yyPVnWiJTxzeU=
X-Received: by 2002:a24:26c4:: with SMTP id v187mr273386itv.54.1544137340546;
 Thu, 06 Dec 2018 15:02:20 -0800 (PST)
MIME-Version: 1.0
References: <CA+YJQx72dMybGWyzNMUcNcVZnpDTHoaONcC-AQdqt=C_8aEdXg@mail.gmail.com>
 <CAP8UFD2xv6SK+qPXKr5hQ0ZctOR5K-BNg1wdBy5=fp2DVBZMHw@mail.gmail.com>
 <f9f644daa705c78ef348a4a808d88bc01e7bdbd4.camel@gmail.com>
 <CAP8UFD3cD5KtvPJK5WkWGVUT6grbL=xL2MV1YWNJGpOjD3uRiQ@mail.gmail.com>
 <278123655fbdb565aed16bba804711774716c554.camel@gmail.com>
 <CAP8UFD3VCzEdtfRqi_d2ibPtTN0uocGW+CshY_5m16TW1_YUdw@mail.gmail.com> <5ab4e3fb2e22097753bde7702e67d6ce924283a2.camel@gmail.com>
In-Reply-To: <5ab4e3fb2e22097753bde7702e67d6ce924283a2.camel@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 7 Dec 2018 00:02:08 +0100
Message-ID: <CAP8UFD2+Kk84J=xwGo2bRGUeOXaRCKbLhZSS769qvDMFN8Pg3g@mail.gmail.com>
Subject: Re: [BUG REPORT] Git does not correctly replay bisect log
To:     lskrejci@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 6, 2018 at 6:30 PM Luk=C3=A1=C5=A1 Krej=C4=8D=C3=AD <lskrejci@g=
mail.com> wrote:
>
> I am talking about `git bisect replay`. The shell script, as far as I
> can see, only updates the references (ref/bisect/*) and never checks if
> the revisions marked as 'good' are ancestors of the 'bad' one.
> Therefore, $GIT_DIR/BISECT_ANCESTORS_OK file is never created.

Indeed `git bisect replay` first only updates the references
(ref/bisect/*) according to all the "git bisect {good,bad}"
instructions it finds in the log it is passed. After doing that
though, before exiting, it calls `bisect_auto_next` which calls
`bisect_next` which calls `git bisect--helper --next-all` which checks
the merge bases.

I think it is a bug.

`git bisect replay` is right to only update the references
(ref/bisect/*) and not to compute and checkout the best commit to test
at each step except at the end, but it should probably just create the
$GIT_DIR/BISECT_ANCESTORS_OK file if more than one bisection step has
been performed (because the merge bases are checked as part of the
first bisection step only).

> The first time the ancestors are checked is in the helper (`git-bisect-
> -help --next-all`) that has only limited information from refs/bisect*.

`git-bisect--helper --next-all` knows how to get refs/bisect*
information, otherwise it couldn't decide which is the next best
commit to test.

Thanks for your help in debugging this,
Christian.
