Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1874F1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 19:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfAQTq7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 14:46:59 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35026 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbfAQTq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 14:46:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so9357500edx.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 11:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wnXWdEXNHHhbTZ6Bq+CNsVDuMiyh86/GA2p/reqgYN0=;
        b=Z49wJiXcZYi4XRqlHHofIhygut9P9SR/OuzL7Swm0doGSsIbw6l3g14EgF6812tpGh
         1OGhEaMWXS32H9BpFDsDoouDDMuTgv+VuYK+464aZHTHcOcyBfqaVeD4hDhzxI9OKNR1
         fuiIkXOAPc+Ck6VdOihvxwky0HT0eroq2anxqjfxi8rHmRPw6WrVn8AVHtfzR+m+tRtK
         ToopzNv5IfvsC6rcdQDQ6QMitjmvbsAHkuVcXHBzOvUFFrhfVfPKVdZCcmRpew3GeeJT
         rYCTP5ibFH0LaMcH+YONsM/8Zk0Q1lficUP5OV2C8Cgep9XfFchEa5M00ZAkOczoA27J
         k50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wnXWdEXNHHhbTZ6Bq+CNsVDuMiyh86/GA2p/reqgYN0=;
        b=QP1/O/duRmqVoWb5e0CJZzmwzl4CtC7F3BFGYKc1YMqd/MXava/Hc7uN6UhAYdT11H
         4zLJbWktnSFgz+9zz8Oyr6bAB82Z+slNZuDTbHAlDG3gJFK70aqQdYx2C7mjZLMEtjDz
         Jg7UIb0OLFdb6xWYQrYNx7NGQqKa/jsM9EDZJhyxb1jE5phd5h+Czp/yXiBMaEfpqRfg
         W5AzE6yVpImwTU29R4didGIXaqsd8dKp5sLX7aiGej2iQdhrhcWezsHcou8VxsO1+iXA
         qKN1XJkJlUG2Ct5zEAsSuVujB7UpKNfXrw7FjGlMWoq3S65cdUj/BFvY2WidHjrQueRL
         F7xg==
X-Gm-Message-State: AJcUukc9hkKabN1dPTo+0BYOWYrascZWPBxba85WGFAtWJjzgWOrZ7VO
        apybVKm0adL3vvNjLHUkw9jBVpRLBFy6ZWrw+1FbSEdPe5aSBg==
X-Google-Smtp-Source: ALg8bN56xxXtujqQjj92KkO2Pr44EC/UWHdXXleCvmOXViD3mrpXbXbY7KZ0Jvq0972cA5y92wQGeGacaslLX0F0KWQ=
X-Received: by 2002:a05:6402:1816:: with SMTP id g22mr13252479edy.191.1547754417541;
 Thu, 17 Jan 2019 11:46:57 -0800 (PST)
MIME-Version: 1.0
References: <20190117130615.18732-1-pclouds@gmail.com> <20190117130615.18732-75-pclouds@gmail.com>
In-Reply-To: <20190117130615.18732-75-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Jan 2019 11:46:46 -0800
Message-ID: <CAGZ79kaAf7NytateigG_f6-UbeJKa2bno9+4zC7R4uqfFB77FA@mail.gmail.com>
Subject: Re: [PATCH 74/76] range-diff: use parse_options() instead of diff_opt_parse()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 5:12 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> Diff's internal option parsing is now done with 'struct option', which
> makes it possible to combine all diff options to range-diff and parse
> everything all at once. Parsing code becomes simpler,

Cool. I like the series up to here.

I skipped most of the conversion
patches, but looked at some and they seem to be very regularly
constructed, as a later step we might want to move all the diff parsing
out of diff.c into diff-options.{c,h,} or such.

> and we get a
> looong 'git range-diff -h'

This is an interesting tidbit to put into the commit message.

range-diff is interesting in that in it is unclear where the options
should take effect. My mental model of range-diff is

    diff --inner-options-1 <range1> >tmp1
    diff --inner-options-2 <range2> >tmp2
    diff --outer-options tmp 1 tmp2

and for most operations we would want to have the inner
options to be the same. However there are cases of changing
one of the inner options, example at
https://public-inbox.org/git/20180810001010.58870-1-sbeller@google.com/

But even when we assume this to be a corner case for
weird research of our own options, it is unclear to me
if the options should apply to the inner diffs or to the
outer diff or both.

As far as I read the patch, the options are applied to both
inner and outer, which may be ok?

I would think that sometimes you want to control only the
inner options, e.g. file copy/rename/move detection
thresholds. And sometimes you want to control the outer
options only (white space error highlighting?)
