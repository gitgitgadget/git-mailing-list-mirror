Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10E21F404
	for <e@80x24.org>; Sun,  4 Mar 2018 01:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeCDBgx (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 20:36:53 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36391 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeCDBgw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 20:36:52 -0500
Received: by mail-oi0-f67.google.com with SMTP id u73so9720348oie.3
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 17:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oRnzXyOFgXmfAgePbKM6mTP/wiXmXKHPOvfjzvb+IVI=;
        b=f5g2gflowzcJv1JNskoRx+1+txSGSFXPwD5rAQLvvIzhOo5XZvcNDWWWQ5isnxCPSf
         dFPnNEUEKS2CDHStWRA8NnsoM5L6sonlT9WP+f950sUYufRK0DQI2uFqje7a2okEbcQo
         px749eRi6AZV+k05k9xE4FTje4kYFuLNkb9PWhV2v6YGPY2/FHODRig4iaFsnASq8aec
         6OfDsFBVetUsl2lnpkFvDeqjOrEumjgiENNOCCS42Pu81mSUc0sjTacXI4SU7A+yeyr3
         sbzNnwW2noyCU7tvINqdHoe9Iri7fUbugu5hN3vkQBr94vnbcoFD9HeYIvcM/iGXZSJ3
         l3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oRnzXyOFgXmfAgePbKM6mTP/wiXmXKHPOvfjzvb+IVI=;
        b=qp00Nsw+lqK5uKNQYzPPw0nYivAEk/ZJ78QPReKAochkpOWmwjcuHlnvSBWda6Ij8/
         eHIZlCUSOMj6ZVd2i5SHcHrt8hdhFMjU1um/a/4op/yV2xCAzAlDPPtlMOojVF5CureD
         A8Qr7S5K2yanRS6VMQqoRD4fMBa/5rDRCk66DWLQn+wcq/yGwGe9tU5W/xipP+bjfH4S
         pWYcMpaUcRGBn+SWMAFRNmsIvdOiElEZREZUxWFpiWfie5xJzFcYZFkR5CUtn902Juaj
         uyfhb23Dr+3WRjZqRA6yzojh65WBZ0ZDhXonURT1qStbN4eRZA51UKs6UegdbryHlxXQ
         0IFA==
X-Gm-Message-State: APf1xPDIG0RckaC8ZjGNLBGCyrXoHRmnW9/5rxxIXe9fbVZnyECqKRY1
        RWtRgiMXnxTyCxsovqevU3mTlSnith8Zr8MmXag5DE5p
X-Google-Smtp-Source: AG47ELumq6EPdin1GtH2dA7WIdV5liTZltBp0O/EDaTy1A1Ud9Z32JXWGKQx7ryyEbzHOp5R71862jPgauSo9adjfHA=
X-Received: by 10.202.213.81 with SMTP id m78mr6447778oig.196.1520127411935;
 Sat, 03 Mar 2018 17:36:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.76.9 with HTTP; Sat, 3 Mar 2018 17:36:51 -0800 (PST)
In-Reply-To: <CAPig+cR=adC_Ok=FJw2APaLahXX_v1ix4ufEJyBhED5ruXaQxA@mail.gmail.com>
References: <20180303034803.21589-1-dorabpatel@gmail.com> <CAPig+cR=adC_Ok=FJw2APaLahXX_v1ix4ufEJyBhED5ruXaQxA@mail.gmail.com>
From:   Dorab Patel <dorabpatel@gmail.com>
Date:   Sat, 3 Mar 2018 17:36:51 -0800
Message-ID: <CAE09B1+XXJvrOucHwehUGk=Taio7sirfOh5gq7KGs4iZSpK=vQ@mail.gmail.com>
Subject: Re: [PATCH] git.el: handle default excludesfile properly
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexandre Julliard <julliard@winehq.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[[Pardon the duplicate. I forgot to send via text/plain and the
mailing list bounced it, so resending.]]

Thanks for the feedback.

Correct me if I'm wrong, but my understanding, from
https://git-scm.com/docs/gitignore, is that $HOME/.gitignore is used
only if it is specified as the value of core.excludesfile in
~/.gitconfig. It is not used by default. If that is so, then the
proposed (and original) code works. The changes I am proposing handle
the default case, when core.excludesfile is not specified.

Looking deeper into how the function git-get-exclude-files is used, I
see that it is only being called from git-run-ls-files-with-excludes.
So, perhaps, a better (or additional) fix might be to add the
parameter "--exclude-standard" in the call to git-run-ls-files from
within git-run-ls-files-with-excludes. And remove the need for
get-get-exclude-files altogether.  Presumably, "--exclude-standard"
handles the default case with/without XDG_CONFIG_HOME correctly. The
question I'd have then is: why didn't the original author use that
option? Either I'm missing something? Or the option was added later,
after the original code was written? Or something else?

Thoughts?

On Sat, Mar 3, 2018 at 12:42 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Mar 2, 2018 at 10:48 PM, Dorab Patel <dorabpatel@gmail.com> wrote:
>> The previous version only looked at core.excludesfile for locating the
>> excludesfile.  So, when core.excludesfile was not defined, it did not
>> use the possible default locations.
>>
>> The current version uses either $XDG_CONFIG_HOME/git/ignore or
>> $HOME/.config/git/ignore for the default excludesfile location
>> depending on whether XDG_CONFIG_HOME is defined or not.  As per the
>> documentation of gitignore.
>
> Perhaps take $HOME/.gitignore into account too?
>
>> Signed-off-by: Dorab Patel <dorabpatel@gmail.com>
