Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3860B207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 21:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbcJCVty (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 17:49:54 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:34355 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbcJCVtw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 17:49:52 -0400
Received: by mail-it0-f48.google.com with SMTP id 189so7516804ity.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 14:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ftZEASjy73yv6mjEm2h4L3jatjI75aYyXGDTnZQRTzA=;
        b=dwxrp771uzOicq3oaqBWAnksntveWp0sxHkmtmNle6F/+JW2cjvTiodUydZa93DB2s
         3TeTB9mxX/cUYABN3guFgOkW+z6xnUD52uc30CH0b2rX87rpRDDIELX6g0zQ6GRbNwL9
         klZwz6yyIb5TcUCB5m8Fdb+GwrNTCsEV44PdyGyV3Ol9rUhOhJJ7C8ScFzUxFlLI8Uwx
         o9oLd2MIdjVUO74DlMsI513EleDsUiSBR2rqraE4gT5BlifdoqIV9By/l4rRpaD5YFMK
         tqSIJJIOLpXYsGfInwDPs7P5Ft8pkYzPt5pCDrS0cJqB6Pgtm23Ppx3jP1yL5VICErDs
         OdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ftZEASjy73yv6mjEm2h4L3jatjI75aYyXGDTnZQRTzA=;
        b=Tot4x7neY3JsbCzDLbecBZTa4WuMEv4TnZNzYrhHwdc0Fp6BhvIf/WR38dE5tbBTr0
         rjgvKCfOlo+X7ssZQAiHbv8SXDm9WAHcosL2ovCjI0PFLRAd7tiXSitJj1QdTfr+58Tn
         HmnWmlaQtj1CQSdFliyfeZA3hHTb43TKNsyI+loJ4RIUiWrJVV4HGuEUBsQDRV8tQ98H
         +LC/exC6h2LZQ5sWi6zJZekm0+1giCZ7NkZ8FwKvDGFs0/ziiNhY2po5CMe6NIxN3fdO
         AG1aiQEmuHfxsaGTJRFZsN93C5NOWTMxAOSV5d4P7yhywXmt+TyT305c32c+rqHhc+eq
         EC6w==
X-Gm-Message-State: AA6/9Rl7pKu9lwfcGW7Fj0nla/SgiWWNKdn+Mt+PE/sp9bSC8s1/O1GGuNaR/z6f1uT++wV0mKusJGqOUxaXoDvp
X-Received: by 10.36.50.149 with SMTP id j143mr803016ita.91.1475531391902;
 Mon, 03 Oct 2016 14:49:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Mon, 3 Oct 2016 14:49:51 -0700 (PDT)
In-Reply-To: <xmqqwphp5f9q.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tudkjvn.fsf@gitster.mtv.corp.google.com> <CAGZ79kY6c-vwSP7-1Gz4jwWO-z_yT2oFbG4cgZb-JAae=Sk-cA@mail.gmail.com>
 <xmqqk2dp71d2.fsf@gitster.mtv.corp.google.com> <CAGZ79ka8dO1AHJftKAqD6LvxJSP+8yGGa7Citcdxxrnc5DMeYg@mail.gmail.com>
 <xmqqwphp5f9q.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Oct 2016 14:49:51 -0700
Message-ID: <CAGZ79kYt+Z=ff1b2G+wWRAGGS=je+dpksfmMXj0fWwYVvHk8Cg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2016, #08; Tue, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I am looking at the tip of jc/attr-more and for a minimum
>> thread safety we'd want to change the call sites to be aware of the
>> threads, i.e. instead of doing
>>
>       static struct git_attr_check *check;
>>     if (!check)
>>         check = git_attr_check_initl("crlf", "ident",
>>                     "filter", "eol", "text",
>>                     NULL);
>>
>> We'd rather call
>>
>>         struct git_attr_check *check;
>>         check = git_attr_check_lookup_or_initl_threadsafe(
>>                 "crlf", "ident", "filter", "eol", "text", NULL);
>>          if (!git_check_attr(path, check)) {
>>              ...
>
> I actually am hoping that the "static" can be kept so that we can
> minimize the cost of interning these symbols into struct git_attr.
>
> The initialization would thus become something like:
>
>         static struct git_attr_check *check;
>         git_attr_check_initl(&check, "crlf", "ident", ..., NULL);
>
> The structure will have an array of git_attr[], once interned will
> be shared and used by everybody.  _initl() will need to make sure
> that the "check" pointer is updated atomically so that multiple
> people racing to initialize this variable will not step on each
> others' toes.

I see and that mutex to protect the first argument of git_attr_check_initl
is unrelated to the actual pointer; we can use a global mutex for that,
or rather a static scoped mutex in attr.c, such that all parallel
racing git_attr_check_initl try to acquire that init_lock and only
one succeeds and that one makes sure to first initialize a git_attr_check
completely and then atomically storing the pointer to the &check location.

>
> Then the use site would do something like
>
>         const char *result[... some size ...];

... some size ... depends on the git_attr_check->check_nr
and not on the path as I first assumed. So when we still
want to go fast here:

    static struct git_attr_check *check;

    /* hard code 2 as it has to hold results for crlf and ident only */
    const char *results[2];

    if (!check)
        git_attr_check_initl(&check, "crlf", "ident", NULL);

    if (nr != check->check_nr)
        ALLOC_GROW(results, check->check_nr, alloc);

    git_check_attr(path, check, &result);
    // result[i] contains the result for the i-th element of check

    // Note: git_attr_check_elem seems to be useless now, as the
    // results are not stored in there, we only make use of the `attr` key.
