Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C5C1F763
	for <e@80x24.org>; Fri, 28 Dec 2018 20:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbeL1UAe (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:00:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39767 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbeL1UAd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:00:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so20430938wmd.4
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 12:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYJWQJeuoBU9bFdlRrNkjMW4Dp85cC9Uf7pVwTYrEIY=;
        b=OhCCqKA6n//q5KLFtFdh+Q38f5VRT1xY/Ww2Bnwg1dytKMUK6atfmTGmOwmDFU03tL
         t23C+D68hmavDEEA1fCiLLCe8PWwp71aCTVTdjyAeeuTZpt+fGz/14BwFTDMCAZhqAdJ
         wRzDKqTrpiSpwSSC4HJUz9045K4cg947l7TpKgaU+cfPM7EBKh55iO0sTDb6slJboeQJ
         LJRu/H0cq/pJwPUL5a87ZaGnOyAjIjFrb2T4HXLcUefP3Xw24D1KX5cPy9QxJ1hUUrvE
         6JWBdTy16VSBSyRyjHRFW5jrcEJp+dA9S0P/zry+cVnGIfRdOcn69/MuMH2Xkz5fYiNg
         Su+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYJWQJeuoBU9bFdlRrNkjMW4Dp85cC9Uf7pVwTYrEIY=;
        b=oKPmVmpvomC/fTVMnJNa3bCtyc49yi3GlnBoIiZIuhaQC5EnmBW3brl1Lfdm45tOeL
         DSUmBJq6aQibiRueNQQrdedFd3EseB/yOWH2XMgZyNvSAPjEWT8jSBMFkUPfTCvaOkas
         g3wZQHV8tQfNptiNto0YPsdPD2tKdbVzd8f+v8BlzAZj1g2ynKgwLjXIDd/O7lkCw/ns
         sdDDancmRsR+hwYK3P4jiFVrO5cBBUBM2XaKwRuLgvwlCaPSJrB8tzcmnA+Bs51Q6BH9
         nNz3RxyVGN3F7IKuOY+e2Thak/gslh1hWKQEJwF+eDNKYlSc+4qUBE6UqtDTrOojLP3M
         n7+g==
X-Gm-Message-State: AJcUukdFnzzq94KPd93WAkIsySsowOJAMkPtTTt65usbqmCsj+aGr1e/
        uk2F7oFJ99HPxrCIUaO0GNsr87iOX9UhryQj4xHVQ1F61Rs=
X-Google-Smtp-Source: ALg8bN6lfwolU5SvLMrPG+aUBonBM/gxE+D4NklLHhTsbRhZ52C0LbJUR0RWlTnKQ3qpNsp8oDy+9pxUkcRFy1/33OM=
X-Received: by 2002:a1c:8484:: with SMTP id g126mr26018325wmd.117.1546027231549;
 Fri, 28 Dec 2018 12:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20181228014720.206443-1-masayasuzuki@google.com>
 <20181228014720.206443-2-masayasuzuki@google.com> <CAPig+cQc6oF3b03XS2jmNdtUDOX_08tv=AMUpdd7D1eDto33=A@mail.gmail.com>
 <CAJB1erXq3JZMd9XwUZFHp80Hr2kRakrp3JJgrAugXPyjp1rxNg@mail.gmail.com> <CAPig+cTOK9XkGiPcHdVrWbV-L0a+Av0Kv=NcRVYsUHnb0j5-Zw@mail.gmail.com>
In-Reply-To: <CAPig+cTOK9XkGiPcHdVrWbV-L0a+Av0Kv=NcRVYsUHnb0j5-Zw@mail.gmail.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Fri, 28 Dec 2018 12:00:20 -0800
Message-ID: <CAJB1erUMPKUKz-x9+xdyUayO9FUmZVQ1MbewtrQQJxgsLZyqbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Unset CURLOPT_FAILONERROR
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 28, 2018 at 11:58 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Dec 28, 2018 at 2:51 PM Masaya Suzuki <masayasuzuki@google.com> wrote:
> > On Fri, Dec 28, 2018 at 11:37 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > On Thu, Dec 27, 2018 at 8:47 PM Masaya Suzuki <masayasuzuki@google.com> wrote:
> > > > +test_expect_success 'failure in git-upload-pack is shown' '
> > > > +       (GIT_CURL_VERBOSE=1 git clone --bare "$HTTPD_URL/error_git_upload_pack/smart/repo.git" 2>curl_log ||
> > > > +        true) &&
> > >
> > > Using test_might_fail() would allow you to drop the subshell and the "|| true":
> > >
> > >     test_might_fail env GIT_CURL_VERBOSE=1  git clone ... &&
> > >
> > > > +       cat curl_log | grep "< HTTP/1.1 500 Intentional Breakage"
> > > > +'
> >
> > The test should success. This is a test that a log is produced after a
> > git command fails. The point of this test is "cat curl_log | grep ..."
> > part that asserts the log.
>
> Unfortunately, the name "test_might_fail" is confusing. It is not
> saying that the entire test might or might not fail. Rather, it is
> saying that the one command might or might not fail (and that you
> don't care if it does fail). The idiom:
>
>     (some-git-command || true) &&
>
> can be replaced with:
>
>    test_might_fail some-git-command &&
>
> without changing its meaning, and without affecting the
> success/failure status of the test overall.
>
> So, this new test could be written like this:
>
> --- 8< ---
> test_expect_success 'failure in git-upload-pack is shown' '
>    test_might_fail env GIT_CURL_VERBOSE=1 git clone --bare
> "$HTTPD_URL/error_git_upload_pack/smart/repo.git" 2>curl_log &&
>    cat curl_log | grep "< HTTP/1.1 500 Intentional Breakage"
> '
> --- 8< ---
>
> and have the same meaning.

Ah. I see. It's used inside the test. Thanks.
