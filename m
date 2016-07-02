Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65EBF2018A
	for <e@80x24.org>; Sat,  2 Jul 2016 04:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbcGBEkG (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 00:40:06 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:36767 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbcGBEkF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2016 00:40:05 -0400
Received: by mail-it0-f46.google.com with SMTP id a5so33146505ita.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 21:40:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ozav4qYyAFjg9xygmpuvJJ3nUXA096KBt7upIN5LEPg=;
        b=g59RI1YtnKfS3/LSYeZtPSPvwllFC+S4lSBpTuT0fBEnN7kw+UUPuyAjKNmxa2OU6x
         mNOGf0IXRW3zRJ776vQl8LgaGQGzoHjljSkGB5dcsOOrebW2dc8Pg2oCiNZmwgjDtSMd
         gXz8m6K77hly55cq1Uqwz1o+tV17l9SlUN28TKLNrQ+dG2sjf9l82WJ+EXBC3NV+4WnM
         DIcUOUfZ9vx3YYcrnS0Ig7syWXmwvVaJvDbdFK/T0A6oKTf2pXzJILuCHxeErqNYez+G
         N/XHR0XT9iOGEmJmLC3sRh0gM0i8Mu7CU/9ANstyQhNl4uDSDKLTp0WY3KwStLdsyBBg
         w1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ozav4qYyAFjg9xygmpuvJJ3nUXA096KBt7upIN5LEPg=;
        b=kJxqzM7SlAykb6SjOj85wss4MlK1qEFJfOqqzON8XzLRbsJWFa4utBDWANP/jGRugq
         HuMWWam0S/d33A0LTZ0riKAOmuo2QkZOe/S/R65/rDhKy4IgTSLdEBnF5wWTDaigWBml
         s8TCehKcE61zEwhK+iJSViauZ9acrTqCyHq4UXrOUJ4HXqLD1lNd0n8WWR6Yz8XbUZbq
         VjQVBv8Rt0zxeIxhNLKKJWgy+Y4/Y8uIkx+yFBhZHq7TMAH3BEFOYtcmW6UZN+KzTUUx
         5A7soPVvqw8UTjkMmS9G1dkrVqaT4yLWefXkDNRaXXWh83Eh1bFUJKtIT8IWfiOjZBbf
         ZPGw==
X-Gm-Message-State: ALyK8tKJ9Sg27SodJhFQjS8HyKIPwUhaNFLeBV0VxSsHVfb06m/wf5WMwMMSRXLF/Ed2bp2tBU02aZXXJwSesg==
X-Received: by 10.36.43.5 with SMTP id h5mr1399432ita.57.1467434403837; Fri,
 01 Jul 2016 21:40:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 1 Jul 2016 21:39:34 -0700 (PDT)
In-Reply-To: <xmqqvb0puepd.fsf@gitster.mtv.corp.google.com>
References: <20160626055810.26960-1-pclouds@gmail.com> <20160701160331.29252-1-pclouds@gmail.com>
 <xmqqvb0puepd.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 2 Jul 2016 06:39:34 +0200
Message-ID: <CACsJy8CLJ9aSwA_iABdDVrGULyXSgGO1A_Dy=+aOhAn1m26yDQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Better ref summary alignment in "git fetch"
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 2, 2016 at 1:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>> I'm not sure if we should bring back "{ -> origin/}foo" format. I can
>> do it if someone still wants it.
>> ...
>> +In compact output mode, specified with configuration variable
>> +fetch.output, if either entire `<from>` or `<to>` is found in the
>> +other string, it will be substituted with `*` in the other string. For
>> +example, `master -> origin/master` becomes `master -> origin/*`.
>
> What is the desired property we would want to see in the end result
> of this series (or possible replacement of it)?  Easier to read by
> humans?  Cut-and-paste friendliness?  Alignment?

Easier to read, which is largely improved by aligning output.

> I think the largest objection against "{ -> origin/}master" was that
> it wasn't cut-and-paste ready.  There might have been other attempts
> during the rerolls leading to this v5, but I have to say that what
> we ended up with, "master -> origin/*", is no more cut-and-paste
> friendly than "{ -> origin/}master".

The true cut-paste friendly is the old output, though "master ->
origin/*" is a tiny bit friendlier than "{ -> origin/}master" because
you can double click on master in the former to select it (origin/
requires some typing, not much with the help of tab-completion).
Double clicking on "origin/}master" may or may not select master
alone, depending on your terminal settings.
-- 
Duy
