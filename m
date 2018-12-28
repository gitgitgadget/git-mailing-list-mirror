Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA5E1F5B6
	for <e@80x24.org>; Fri, 28 Dec 2018 19:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbeL1Tv0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 14:51:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41440 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbeL1Tv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 14:51:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so21759041wrs.8
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 11:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUf9+qMe3QU6QOPiNrqYXOIyAQKDLldkemml3FXTGxc=;
        b=Ejvqg17Xu4DhvbxoBzui5VHtZZ8RSsyHLCOSqIc4juWTge8DZMDynn62Gh5uRpFK3+
         nrnokkW8Uak2Dnmbe95WJUQ1rz/c0j+KrcR0KORc+VHbnWJmGLLnEK5Pmba9eprEWhq4
         tQaXWlu87Yn+LpcW2pyPVSnRJZ/bimecjcrzdPfMfMGbhNluQ3AfaTceB8eJC1SNWNrq
         yIe8zS8L/PmPFjW7fcpoVRkZB5iEHXYiwLxG8QKBaLP19MUC6bweCya7eGEoaqjT/aoB
         m4Xjz1coyHMiXyPJ1+EVQJT68bKbpGIbg+36T9kgFPl26aEyVd8Ma7UzDOcBQa4YBkmZ
         UC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUf9+qMe3QU6QOPiNrqYXOIyAQKDLldkemml3FXTGxc=;
        b=g6Bhux69JO3RwPPb1p8IghfDyWL2DZe0+GnCsUtJbZIvRV3+sg0FLdYIuvFN0x7+ri
         0uMLCRAANF7D+Lm/N7cximYXi3ADBtKhbUBB2UnI7SNhCiqKrGD16BiOI+PnlBAbOBiO
         TVPvglQmyO26t7W1kfRtrxlB/RAtc4ikbyPEp6+jE8AphJs5CG8u8telLDH6+rlDZ51j
         sW1JI3B+wFAtJymo9lqSRPaEQmap9treLEw3EJFzE0IhT4QOC3L1ccf5UwMAXM7Khgok
         5KPxQJ7SmI5MnqRO/mB+se9oAa7PtMsWoYy+oiAT1E6PHSqfopGm7FAyPX2CGtaobBTT
         uYXA==
X-Gm-Message-State: AJcUukdWDPkNePkFjVjwuor/1NHoVQfEDg9tUQA11rd1Odi4rycixUEZ
        W31P3F1x/qAU+ESTTrS/lIIEa6jHSUlSvmjpbflvfaNTpjQ=
X-Google-Smtp-Source: ALg8bN7H5ShpY/t8uznY2saLkp/bVAwynjUgpMb831YmXCpKPBIBdHL1TiTd2U8LSymp5d1iK8n9s98T/nWzwhTl3Gk=
X-Received: by 2002:adf:bc02:: with SMTP id s2mr25520180wrg.255.1546026683872;
 Fri, 28 Dec 2018 11:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20181228014720.206443-1-masayasuzuki@google.com>
 <20181228014720.206443-2-masayasuzuki@google.com> <CAPig+cQc6oF3b03XS2jmNdtUDOX_08tv=AMUpdd7D1eDto33=A@mail.gmail.com>
In-Reply-To: <CAPig+cQc6oF3b03XS2jmNdtUDOX_08tv=AMUpdd7D1eDto33=A@mail.gmail.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Fri, 28 Dec 2018 11:51:12 -0800
Message-ID: <CAJB1erXq3JZMd9XwUZFHp80Hr2kRakrp3JJgrAugXPyjp1rxNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Unset CURLOPT_FAILONERROR
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 28, 2018 at 11:37 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Dec 27, 2018 at 8:47 PM Masaya Suzuki <masayasuzuki@google.com> wrote:
> > When GIT_CURL_VERBOSE is set, libcurl produces request/response headers
> > to stderr. However, if the response is an error response and
> > CURLOPT_FAILONERROR is set, libcurl stops parsing the response, and it
> > won't ump the headers. Showing HTTP response headers is useful for
>
> s/ump/dump/
>
> > debugging, especially for non-OK responses.
> >
> > This is substantially same as setting http_options.keep_error to all
> > requests. Hence, removing this option.
>
> s/removing/remove/
>
> > Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> > ---
> > diff --git a/t/t5581-http-curl-verbose.sh b/t/t5581-http-curl-verbose.sh
> > @@ -0,0 +1,32 @@
> > +test_expect_success 'setup repository' '
> > +       ...
> > +'
> > +
> > +test_expect_success 'create http-accessible bare repository' '
>
> Not a big deal, but this seems like more setup, so it could be folded
> into the "setup" test above it.
>
> > +       mkdir "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> > +       (cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> > +        git --bare init
> > +       ) &&
>
> Since this is a new test script, it makes sense to format the subshell
> in the modern style:
>
>     (
>         cd ... &&
>         git ...
>     ) &&
>
> Alternately, use -C and drop the subshell altogether:
>
>     git -C $BLAH/repo.git --bare init &&
>
> > +       git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> > +       git push public master:master
> > +'
> > +
> > +test_expect_success 'failure in git-upload-pack is shown' '
> > +       (GIT_CURL_VERBOSE=1 git clone --bare "$HTTPD_URL/error_git_upload_pack/smart/repo.git" 2>curl_log ||
> > +        true) &&
>
> Using test_might_fail() would allow you to drop the subshell and the "|| true":
>
>     test_might_fail env GIT_CURL_VERBOSE=1  git clone ... &&
>
> > +       cat curl_log | grep "< HTTP/1.1 500 Intentional Breakage"
> > +'

The test should success. This is a test that a log is produced after a
git command fails. The point of this test is "cat curl_log | grep ..."
part that asserts the log.
