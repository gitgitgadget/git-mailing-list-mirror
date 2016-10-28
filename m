Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DABF92022A
	for <e@80x24.org>; Fri, 28 Oct 2016 06:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755883AbcJ1GjF (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 02:39:05 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35477 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbcJ1GjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 02:39:04 -0400
Received: by mail-oi0-f52.google.com with SMTP id i127so104133285oia.2
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 23:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0Xorp1l2ZJPRF0443WYwtWt1AAfJD4LbAdRA0hMguV4=;
        b=YzEjyIqGvVr88MPZSjri56zxUQLyOsFDuWNlrRwIgO4b4NTODjbDBwhIsCzr79aZH+
         EiNsf0SyPUJxWJ5/le9ujp/leM+50Jy5zeAbp3i/uojjcgOOmJ8yqkNSABd077DiXJkL
         j94uDJGNJJ6RS4I9D9UiF3EBaL3ymJ6sAbfve9HEyqzzYGOHO39sOFikzzoM9ulQVJwq
         wfIMXSSOsiUklLo4csn8JH8+cb/R6xzE5LAqLCiyGv9QesrnM6VVX6DvBynjz4LE0XSG
         qCVYXQO1FFbCtJoqVoxLY61tqn/Por2K6YttVx3MHBzcHWonRxW1SD79E5EwN+7Zjg3n
         ELQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0Xorp1l2ZJPRF0443WYwtWt1AAfJD4LbAdRA0hMguV4=;
        b=EbA5DwiMIYGkiZILNAbHqnUUmWl3Gzev0F3TD1mw5EpTjZ+Q6Lx/UPfHSTkOMVq2ON
         HMT1dQUTcPO4t1+6Jxr+80+41hhR3s3gq3pVtMGTcW9leDyRgWLzujM08QEtJOmke51O
         z2jgEvHTzNIMUUK/TV441F4vWG5HB62rKANyFZ98KJtExm1phnh9dmpmnD4HtDAzBsUn
         VtHkOoQNMeFqPScQflmO0v42vyphi5+MarorCasGf+6pjRuCkJxHEaTFj7tMfp6HJeNg
         m0rp5Ajd3a4cbrMGlfvuVueUbWorNbpzTf8q0E2qjvgywnAcF9Fo8A4oaM2kgFJGgMkH
         G5dQ==
X-Gm-Message-State: ABUngvfnDX69caSTwfqxVKe/JSWe5pZmtoxiLovYP3xB/SPSZWWbOo5ANcMdAadxKM6NmscOIgT6T7WylyXK1Q==
X-Received: by 10.107.59.6 with SMTP id i6mr10104887ioa.176.1477636743632;
 Thu, 27 Oct 2016 23:39:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Thu, 27 Oct 2016 23:38:32 -0700 (PDT)
In-Reply-To: <20161027204129.GA21619@starla>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox> <20161027204129.GA21619@starla>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 28 Oct 2016 13:38:32 +0700
Message-ID: <CACsJy8ABaHxhrWke3Vu9Z9FSc5GC1LmupHRu4yS6=SFcp6eVHg@mail.gmail.com>
Subject: Re: Drastic jump in the time required for the test suite
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 3:41 AM, Eric Wong <e@80x24.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> I know you are a fan of testing things thoroughly in the test suite, but I
>> have to say that it is getting out of hand, in particular due to our
>> over-use of shell script idioms (which really only run fast on Linux, not
>> a good idea for a portable software).
>
> How much effort would it take to optimize a /bin/sh?
>
> Would replacing uses of fork+execve posix_spawn be fast and
> portable enough?
>
> Even on Linux, performance sucks for me.  I've been hoping dash
> can use posix_spawn (or using vfork directly) to see if that can
> help things.

Busybox hush uses vfork.on no-mmu builds. You could try it out. I
don't know how complete it is though.
-- 
Duy
