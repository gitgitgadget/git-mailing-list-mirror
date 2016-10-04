Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56F9220986
	for <e@80x24.org>; Tue,  4 Oct 2016 15:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753492AbcJDPqr (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 11:46:47 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36600 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbcJDPqq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 11:46:46 -0400
Received: by mail-oi0-f54.google.com with SMTP id m72so68843382oik.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 08:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/RZ/KAGEY7sMdhZ7Gx0Q1HQKw9+Gx3HBEL7w2JeZTe4=;
        b=Duhm63rVv8QUbgRGXr2D9c2JaaVaRJFK6LZTOSYwYWKt0o1YIgbSBigJqNAiHlK4m/
         o2wY6PYw2j9smPMvTBJNMuskT1mvTUJ62dQPyRvVB9Gl0V6U2pHlUpfg4THKbvpzEgiS
         sHRrGrrChXi0mumJh3abmk4/Q0GmKn78XkcKTUkEedfQ3He2ekBOSD/w29K+sIl3WjL+
         KinFqHr4ZWdTbmGPKqTXltY3RCRiOK5Cxbamq4B3RY8jXkepAHGk07y2GA2kRd5kJu+i
         a03O5Gjub3jbqpLGJhkbxOCC3oxLnx9sDAkencuocIHC/x8VzgQfNh1Wj0EgyHxwyssz
         mwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/RZ/KAGEY7sMdhZ7Gx0Q1HQKw9+Gx3HBEL7w2JeZTe4=;
        b=fW+GbRtDUcvAca8t4TKGgfUf1LhfMWS+2tQIEM68x6hUGgiL2Oi2HBtb5/adCnpXIF
         HD5V+rfZY1qfYtycT7fM3orb6wusKknq5ZhxH9S9tTANKTOVUxR8FmpqH85tXC08Oo0+
         VVzD0x9+s43nL4haN4vsw4AKXRiaaeZAYzfuP2ZGaFqLvUmhsyPFUSm5u4WH1z9IoAjg
         os5lqMHGkPyh6GmrDnoA50ytn+Lyd5MynIxuKTF+syFF2FnxauHi+RytC2dQAKbwmu53
         nVm45XLFKlobyvg1HNFlUnrNad2VQFZrc/Iz5gMLCR07UucYEOuqhOiIYHoCJCd25gDF
         2yAQ==
X-Gm-Message-State: AA6/9RmnXL+KdDX9JCZ5/XOEn6li5M8JBIGtF8/KbA5/AKkb+qZkZuR+korUTTz0R5fwNkJu96ZwX6a3PViRbQ==
X-Received: by 10.157.63.216 with SMTP id i24mr2662206ote.178.1475596006033;
 Tue, 04 Oct 2016 08:46:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.189.4 with HTTP; Tue, 4 Oct 2016 08:46:45 -0700 (PDT)
In-Reply-To: <20160914202907.GD7613@sandbox>
References: <CAPOqYV+C-P9M2zcUBBkD2LALPm4K3sxSut+BjAkZ9T1AKLEr+A@mail.gmail.com>
 <20160914202907.GD7613@sandbox>
From:   =?UTF-8?Q?Thomas_B=C3=A9tous?= <th.betous@gmail.com>
Date:   Tue, 4 Oct 2016 17:46:45 +0200
Message-ID: <CAPOqYV+xsrLk7y1hJYHZFY8OfkxVRwPcZBdqhdgrhThqdZysQA@mail.gmail.com>
Subject: Re: Bug Report: "git submodule deinit" fails right after a clone
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your answer and sorry for the delay (I was on vacation...).

I am using git 2.9.0.windows.1 (run on Windows 7 via git bash).

I tested it on this repo:
https://github.com/githubtraining/example-dependency.git
The same problem occurs.
Here a small script to reproduce the error on my PC:
#!/bin/bash
git clone https://github.com/githubtraining/example-dependency.git
cd example-dependency
git submodule deinit js

It ends with this error:
fatal: Please stage your changes to .gitmodules or stash them to proceed
Submodule work tree 'js' contains local modifications; use '-f' to discard =
them

Is the script working on your PC?

Thank you in advance.

Thomas

On Wed, Sep 14, 2016 at 10:29 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Tue, Aug 30, 2016 at 01:45:56PM +0200, Thomas B=C3=A9tous wrote:
>> Are you able to reproduce this problem?
>
> No. I just did a clone and an immediate deinit afterwards and no error.
> Maybe you can provide a script to reproduce? Which System was this on?
>
> Cheers Heiko
