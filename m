Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E10C1F4F8
	for <e@80x24.org>; Fri, 21 Oct 2016 06:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754034AbcJUGKm (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 02:10:42 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35053 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbcJUGKl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 02:10:41 -0400
Received: by mail-qk0-f176.google.com with SMTP id z190so131606967qkc.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 23:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sZQCpWKOVEvrloi3f2L2LemH3ohA/ALi5szbYuJ08FM=;
        b=MQaXBryqzNbqNqKRYwF0JZ4JTbQQSF7Sw5opfsIAoY9pPLPgdtndNDlyVx/kgspsb5
         cA9i9HyIchy0aNl2Ez96m5/y1EAnORiVgml0yGQeg5/IIkq+8Dgf1ngqhmmwlIzbSZKN
         NDo5b/IDeuKzxkkPOCOs0SKHpWLU24S66X6fApH03i28pll/RrOP7CVQHtz126quLQtx
         xqxU99rW8xTZP8J2dbl+09lQedkFk+pLrJKmUPx5kp+WyrFOPP5OHf2Yl94nHGyQ8VgQ
         ANrJtn+pHCsIs/eytG/gHhB10ZiDfH1RN3rtDtRtbRAcNdoUnBLuL9lWJRMXxkHMgEpO
         1d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sZQCpWKOVEvrloi3f2L2LemH3ohA/ALi5szbYuJ08FM=;
        b=EgFJgH/BGv/+mIsKGMJpyHS9mSj0WRCZKwNKl9SCh5StukxlQyKL32IebcJvXqMDek
         CId0YpxfGr1cTzFIQ58N29f+Gm//Isv/Fy6zC3zkLmzWnxE+OhZ6d3J1PGnq7pJ2ENT9
         a5te8eaKuzW4h0HM+RseWikjEPoo/PFrLtFQne8D6Q/+h/RPyu8IwszJfvU0VSAX/soA
         iRHxQ9xizeMomKYAISs6TZiLr2xmiWPzIZ8V4VABgAFZ9y57HnxkkRNpPVCTV6rZpfLe
         bPavbbyqoY53rMEJy7JfUk0XB+CLMrX7Qsq7Okvxy+dCATKLhguMr6BPNxhSXiUILJiv
         t9og==
X-Gm-Message-State: ABUngvegx13EHdpI9rvB8nbe7e4Un02hX9LmOS4RK7GQ1We1dCAQp85DNRPT7PbRSsrLbXU0O5znSaMzkdibsA45
X-Received: by 10.55.22.105 with SMTP id g102mr3775970qkh.86.1477030240072;
 Thu, 20 Oct 2016 23:10:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 20 Oct 2016 23:10:39 -0700 (PDT)
In-Reply-To: <D9C1E13F-88A2-483E-A549-1C2294EACFEB@gmail.com>
References: <D9C1E13F-88A2-483E-A549-1C2294EACFEB@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Oct 2016 23:10:39 -0700
Message-ID: <CAGZ79kZo3LdcRmrjQTAvgx=H6U2tdjASK3qv5A2K5J2HQ2NvSw@mail.gmail.com>
Subject: Re: Prove "Tests out of sequence" Error
To:     Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 9:14 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> on TravisCI I see these weird "Tests out of sequence" errors with prove
> and they seem to not go away. I assume the reason that they not go away
> is that the ".prove" file is carried over from on build to another (but I can't
> look into this file on TravisCI).
>
> Has anyone an idea where these errors might come from?
>
> ------------------------------------------------------------------------
> t5547-push-quarantine.sh                         (Wstat: 0 Tests: 5 Failed: 0)

push quarantine is a new thing made by Jeff 2 weeks ago, IIRC.

>   Parse errors: Tests out of sequence.  Found (2) but expected (3)
>                 Tests out of sequence.  Found (3) but expected (4)
>                 Tests out of sequence.  Found (4) but expected (5)
>                 Bad plan.  You planned 4 tests but ran 5.
> Files=760, Tests=15109, 679 wallclock secs (21.91 usr  1.78 sys + 320.79 cusr 529.13 csys = 873.61 CPU)
> Result: FAIL
> make[1]: *** [prove] Error 1
> make: *** [test] Error 2
> ------------------------------------------------------------------------
>
> Example:
> https://s3.amazonaws.com/archive.travis-ci.org/jobs/169385219/log.txt
>
> Thanks,
> Lars
