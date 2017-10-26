Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0954D20560
	for <e@80x24.org>; Thu, 26 Oct 2017 09:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbdJZJI3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 05:08:29 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:55164 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbdJZJI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 05:08:27 -0400
Received: by mail-ua0-f194.google.com with SMTP id n38so1941892uai.11
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 02:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DJ6BaP9lc++GLY+XPq+tEZ+3BcBmRXhUjpeKIgJeNxc=;
        b=vGZW/qBimZ4ZgJ0lxo01WExK6VxEQwbvpTJUGUcO4yfXleqY1xfVSTEwETotMFA78q
         BiS/qOzVkdVUWRYoGF2gDRA780s8u0ufN+gzVjtIrx2jjsKgyjHXUe00BHZh/GHx429/
         hHnPM2GGeYvR9L7Bj5HU9jNaOWSp/7o7xmCdBlHSIxof8syjtL+paN5WnJD38amV2/v3
         hChygzGhiJidffAVKIqCG0puedxLLS33KBzZLpkfqrI/Qnhy0J1UI94ReVoXRh0wfrBC
         7n7RWfg9VXGw/fuR1bxAhPNKUZK4hZAjn8mgCGH3E+NEVUK6R5lhzsDZVZj5EPlTydsA
         bBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DJ6BaP9lc++GLY+XPq+tEZ+3BcBmRXhUjpeKIgJeNxc=;
        b=FaaRilSWa7pMGlMzc4Rt+V9j1/ubHa6bP/xNrf+Zq8PQ3ZLtvqjbzqovznU0TgsTcK
         cORN8+BOR0RCQ/NqPZ+hgyfov1+2yFx/EqPIlHww1VbSx208IBApvTegmvkav+2pZ04O
         rshNZzm5SY+MFAx1/tWu57am23KdFNkAAc0k8GPOWS4Vl+nG0SU6rYcORD2+hmiliRAf
         TbHkg5pJv7tLoWVl8wXEKCf6BK/4NAMN469c3vJk5pGep94LVKuoCAABCr5/L8deJFvs
         /GBRZd0ePhN6ayioVjyhDtFa3YrFEWB7jlTMnSqXbqNuez5uby44RQxRvcX4q9EDjqeW
         5o6w==
X-Gm-Message-State: AMCzsaUykQEXdR5XONuOCNROVEqP1WgXw/yuVuhaV2GaQmZq5p3XHsFU
        upuNqpVTMLLUJHQtx45PcAkPG+AqGfSUAqNmHn6E3w==
X-Google-Smtp-Source: ABhQp+So0rbsJf/pFeZUeWa6UNOGuVggvjfvsF4nRA+/ye8+YC9UUxfWDnHt6aeJ0yhVfO2vLw4CC54/tyjNUKrtSWQ=
X-Received: by 10.159.57.227 with SMTP id p35mr3705114uag.198.1509008906630;
 Thu, 26 Oct 2017 02:08:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.30.139 with HTTP; Thu, 26 Oct 2017 02:08:26 -0700 (PDT)
In-Reply-To: <CA+P7+xpcC7Daw5k3=XFyZRsqiBib6yY2YzLpjYfcS7yqfUzTpg@mail.gmail.com>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
 <alpine.DEB.2.21.1.1710260008270.37495@virtualbox> <xmqq4lqmfoy7.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xpcC7Daw5k3=XFyZRsqiBib6yY2YzLpjYfcS7yqfUzTpg@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 26 Oct 2017 02:08:26 -0700
Message-ID: <CAGyf7-Ho3eY8sE2ME+p-JdR9OUQGFc43TmjHpueJgwCBSznN5w@mail.gmail.com>
Subject: Re: [PATCH 0/6] Create Git/Packet.pm
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 2:07 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Wed, Oct 25, 2017 at 10:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> Note that the correct blib path starts with `C:\BuildAgent\_work` and
>>> the line
>>>
>>>       use lib (split(/:/, $ENV{GITPERLLIB}));
>>>
>>> splits off the drive letter from the rest of the path. Obviously, this
>>> fails to Do The Right Thing, and simply points to Yet Another Portability
>>> Problem with Git's reliance on Unix scripting.
>>
>> In our C code, we have "#define PATH_SEP ';'", and encourage our
>> code to be careful and use it.  Is there something similar for Perl
>> scripts, I wonder.
>>
>> I notice that t/{t0202,t9000,t9700}/test.pl share the same
>> split(/:/, $ENV{GITPERLLIB}); forcing this specific variable to use
>> the non-platform convention to accomodate the use of split(/:/)
>> certainly is a workaround, but it does feel dirty.
>>
>> It is hard to imagine that we were the first people who wants to
>> split the value of a variable into a list, where the value is a list
>> of paths, concatenated into a single string with a delimiter that
>> may be platform specific.  I wonder if we are going against a best
>> practice established in the Perl world, simply because we don't know
>> about it (i.e. basically, it would say "don't split at a colon
>> because not all world is Unix; use $this_module instead", similar to
>> "don't split at a slash, use File::Spec instead to extract path
>> components").
>>
>
> I thought there was a way to do this in File::Spec, but that's only
> for splitting regular paths, and not for splitting a list of paths
> separated by ":" or ";"
>
> We probably should find a better solution to allow this to work with
> windows style paths...? I know that python provides os.pathsep, but I
> haven't seen an equivalent for perl yet.
>
> The Env[1] core modules suggests using $Config::Config{path_sep}[2]..
> maybe we should be using this?
>
> Thanks,
> Jake
>
> [1] https://perldoc.perl.org/Env.html
> [2] https://perldoc.perl.org/Config.html
