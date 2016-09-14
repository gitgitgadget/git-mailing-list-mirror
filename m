Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC811FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 19:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761984AbcINTcO (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 15:32:14 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35413 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759857AbcINTcN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 15:32:13 -0400
Received: by mail-it0-f51.google.com with SMTP id r192so59887652ita.0
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CQdseH78OFpWA/yh6Wh6qnfnE6Xb2udZiNktOIpONZ0=;
        b=Il3eMUw2bellMGe3Yvvo62Wg+wjvYag4bpFz8Jt1xVBxl6Low+GWHrjEcLfQRyB/8j
         noXoC6kwWau4RStdrNonCnyZpIIxKSwPNXc0D5OnU6haPMN9vVQdBrKIHZhnXvfWYtjs
         4y55aM+dhALHbWdNXUvBWGsx264pC4nmYNPyxvizPA6t/LK8mg8zzp7NSOHCP+QJXDpv
         yC56ZgJZGwEBKHh2rruUNRJgZ2+JDcO4OjyCwi7iXuNUGKAApNisiI/XRVYUUuB1AbrV
         PlWQkAEHePdobwhUOFfIdS1cZZqEPKIMPUsVNAV+D3Z836Z84TCpI07Na+Tpving3rYo
         iIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CQdseH78OFpWA/yh6Wh6qnfnE6Xb2udZiNktOIpONZ0=;
        b=dDteIptu6ylkNJj5egQJzg6n9ZaGYu2TBW/oOPZtBkfeEkLBjneZkwbPNqfxeeuTBB
         ZPm7S1vaBu+ta5BoFxKBuUYhAvnFh+h9ehmwMPhcwUUk/yuCvpaZtLP2qmTTWihLGDj/
         qv/pVRRo//lyfni/PeANfpZqcXVJYAo7v18zYOSpZeXapl6H5ZtHj5cE7LoQ26jJ1jm1
         HYx1tGxsYO5RBWtpAQOCmpfgcFT+28BqlfvzU64j1nYIZ+bNsH1rk+VTe9mcWjnxvrLl
         xwwebgGe9Ta1sFRPnuRswaoIf4oJSLIsEe5d/HLr7t91U8D20OBxyW45w0U0GOvi/iOg
         TRvQ==
X-Gm-Message-State: AE9vXwPem94mT6SGWmYEDGyIeWyE9DcZb418P4iW6X6crPyW9IYcJDT44L51UUgozGHeqe+8C2gN1Moorx277/Sn
X-Received: by 10.107.20.16 with SMTP id 16mr4166057iou.13.1473881532284; Wed,
 14 Sep 2016 12:32:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Wed, 14 Sep 2016 12:32:11 -0700 (PDT)
In-Reply-To: <20160914140318.GB9833@onerussian.com>
References: <20160909221942.GS9830@onerussian.com> <20160914140318.GB9833@onerussian.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Sep 2016 12:32:11 -0700
Message-ID: <CAGZ79kbdfWHDGzoe21LVqt6naMJPWGf45S1oknrAp6=Z-Qm8dQ@mail.gmail.com>
Subject: Re: git submodule add spits unrelated to actual problem error msg
 about .gitignore
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 7:03 AM, Yaroslav Halchenko <yoh@onerussian.com> wrote:
> I have spent some time chasing the wild goose (well - the .gitignore
> file) after getting:
>
>     $> git-submodule add --name fcx-1 ./fcx-1/ ./fcx-1/
>     The following path is ignored by one of your .gitignore files:
>     fcx-1
>     Use -f if you really want to add it.
>
> long story short -- the culprit is this piece of code in git-submodule:
>
>     if test -z "$force" && ! git add --dry-run --ignore-missing "$sm_path" > /dev/null 2>&1
>     then
>         eval_gettextln "The following path is ignored by one of your .gitignore files:
> \$sm_path
> Use -f if you really want to add it." >&2
>         exit 1
>     fi
>
>
> so if anything goes wrong in git add, it just reports  this error
> message.

Thanks for the bug report!
I think we could chop off "2>&1" as that would have exposed the
underlying error.

Another way to go would be to use verbose git-add and grep for
the string "add '$sm_path'".

     if test -z "$force" && ! git add --verbose --dry-run
--ignore-missing "$sm_path" |grep "add $sm_path"

git-add already gives the correct (the same error message) for  the
ignored files, so maybe we'd just do:

    # no need for a if, but this single line will do:
    test -z "$force" && git add --dry-run git.o >/dev/null || exit 1
