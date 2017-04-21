Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25A0E207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 18:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423244AbdDUSDE (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 14:03:04 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34950 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423235AbdDUSCv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 14:02:51 -0400
Received: by mail-qk0-f173.google.com with SMTP id f133so78135595qke.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 11:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PZ3V4bH7qILJZflkzlWCmTvjRGnLOrjcXQUxKpcZ7F4=;
        b=dgg49Aj0JhJukfrR7AkrfLkvDj0OWksP5wzoaj5tMZiC+SNEhBF0tGY57nnRW5NnA6
         1/oZb+Vhbfo/mPrrVSSfN+ok/Mt3iv8nCs6zViYW0p2w2YPzjt2XsRXGKrzO3uH+lAkI
         /W9Y0lIq0GOub6S4l+A8CWILKZQbP69wwSvJmLVJdYFechakxhQZl9XGt7lFtQ7qhOgF
         v5xCE9AnkxgepK6oB721hHucuYOnptfmF6kiA0p7nXuXUi0dc/Eb76xMETXxNDb3Wdom
         6ptZEI97mKAOcMXMR/wQH/muWvDlTc9SYR+KNOmoQQTM4Z1w8tF41AV/8bLSX1ysZK8U
         A2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PZ3V4bH7qILJZflkzlWCmTvjRGnLOrjcXQUxKpcZ7F4=;
        b=NVnOdY9eQQbXznncs0RcRlw7KBj0k0lUzsfzauQfQAdIQZPMykP/9wxSV8lLWwc3pv
         v590IAlnjIsvISE/4pjsWOOEIng8J5m3n6/EFZ4R2KLeQDwZzdYITidvPH5Vio9Skz7h
         PoAmQ+AxOTCoGtns3wgxGxhkBgYlfrp85s+B1uYF8swnri0eLa0+DpMJo/95gib+WOMZ
         XtpOKjImBnQj+kiZJUOdhuL0DUajpDj5L01nHeMI43WHljIILRNpgMBZOq0xpIGLHX0n
         AM/IeX2pVSxCwOr7+mYE0zm9/NDfS+H+Z/a8NhC+GL/ahHpgVrXn4aG1coCr+tPL0iEi
         C5KA==
X-Gm-Message-State: AN3rC/4pGqaYIPEzJ+OmUnbgtwkIJEul+/gd5l7piMikKZ3keVham2SN
        yzzEuITf/Re0Q7cvWc5yuJIy6E16BB08
X-Received: by 10.55.4.6 with SMTP id 6mr13054996qke.222.1492788231987; Fri,
 21 Apr 2017 08:23:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.96.65 with HTTP; Fri, 21 Apr 2017 08:23:51 -0700 (PDT)
In-Reply-To: <CAP8UFD2f9g__ykCjReSoaAUvFTPmgRDbsWFQMRrFoFw8haV0uA@mail.gmail.com>
References: <20170420205214.GB4989@hank> <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
 <20170420212436.GC4989@hank> <CAP8UFD2f9g__ykCjReSoaAUvFTPmgRDbsWFQMRrFoFw8haV0uA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 21 Apr 2017 17:23:51 +0200
Message-ID: <CAP8UFD36dcm9EfvtWqqEON1Muyyd7_j3uRtr6C2bLzXZN5n1MQ@mail.gmail.com>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 4:25 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Apr 20, 2017 at 11:24 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> On 04/20, Christian Couder wrote:
>>>
>>> Could you try with the following patch:
>>>
>>> http://public-inbox.org/git/20170330210354.20018-1-chriscool@tuxfamily.org/
>>
>> Yeah, I tried with and without that patch with the same result.
>> Unless I'm screwing something up when testing I don't think this fixes
>> the issue unfortunately.
>
> I just tried on "pu" and only the first test
> (t7009-filter-branch-null-sha1.sh) fails there.

I bisected this test's failure (when using
GIT_TEST_SPLIT_INDEX=YesPlease) to e6a1dd77e1 (read-cache: regenerate
shared index if necessary, 2017-02-27).

The failing test is the following:

test_expect_success 'filter commands are still checked' '
        test_must_fail git filter-branch \
                --force --prune-empty \
                --index-filter "git rm --cached --ignore-unmatch three.t"
'

And if I add the following at the beginning of the test:

        git config splitIndex.maxPercentChange 100 &&

the test then passes.

So It looks like in split index mode the test doesn't expect the
shared index to be regenerated.
Maybe Peff, as he is the author of this test, or Duy have an idea about this?
