Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B8E1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 05:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeACFuy (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 00:50:54 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:45268 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeACFuw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 00:50:52 -0500
Received: by mail-io0-f174.google.com with SMTP id e20so973498iof.12;
        Tue, 02 Jan 2018 21:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ThKUu2142BVRwtbWfwzJbijX0OIpFS8NlfFDrSMdg98=;
        b=g6nio8NxmVkrqHB0z7b6gVwmk+ZsBcFgVR78QoZTOCEaLcfZ3+ExP3WGjOOmrMimBb
         Kv8aHKp8Vsix+afmlzLQndEAqZm3qKmbizW8X6KuY5JXgBBjxxk3TYLSrwTa0q8etNqW
         yKjaiHTOcx0bre1fxnZUvBOmJxkL3ZSHaKrgw7yHzSp0TCcrdWOX9flg1ILs/aXmH/vC
         mVrfKJjDUxYbF6r1QFvaX5f7bNhfGL8Hoq5Fi9A+lR3rs21a+asd57paxQ/JLJw4hA3a
         JhqDQt5Qr8Jm6fQcqiLmBh3Y15VmAypisliX8LNRD9OD3sNnN8dcz3lsjEWsNgYctm2b
         43ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ThKUu2142BVRwtbWfwzJbijX0OIpFS8NlfFDrSMdg98=;
        b=px+YWZSaOrELPnW4R0H3kKYu715GJOv068k4gakD1Y3tPoRCnVPqCeRVKHnSWi6Jtj
         FMIazKJva9b6SUN4cgNJ7IjK8zXcYgG3nHkj3eehbuUV//k7geaaS/PW8UbecxQK2xK9
         CvhfRsCv0hVMsziE/g1Cob07izj1eamfCUxLjFXSVdVZGz84Q2vbFihGS/WnVMAOadDd
         GPbHDcU8T21JNJ1zJILoAtdi6qJvq1XBNRtneC2PMfXTNHW0YrTzM+T/JavwTM+b/gZw
         KG73wLAGyrIiDs7Wc9NEe7KjK4vaaFtk/EQVxYUyl5TCmA+DXlaVrSrgbnHGln4+PrIj
         XH5A==
X-Gm-Message-State: AKGB3mKIhYtEFDCGjcceNhmFVUbfdUf9mvlw3w4cYdtOZ9fiPLUKTn24
        iBVR8viCBhye5nOMsG05/3D0HyAu
X-Google-Smtp-Source: ACJfBosBtgooM8Od7EeOcgZ2bdB0FNVK3NTWIfEFsmYFcIgS/pXVf3Wp9bLclK5MrgbP4oroGzY5vg==
X-Received: by 10.107.148.9 with SMTP id w9mr383768iod.290.1514958651790;
        Tue, 02 Jan 2018 21:50:51 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i133sm5997631itf.1.2018.01.02.21.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 21:50:51 -0800 (PST)
Date:   Tue, 2 Jan 2018 21:50:49 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Git Users <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
Message-ID: <20180103055049.GC87855@aiede.mtv.corp.google.com>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
 <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
 <20180103050730.GA87855@aiede.mtv.corp.google.com>
 <CAGyf7-EeBHwg50+MnUGF6=aE91TJY_iYSrg5gF1rp8ApsTsrvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyf7-EeBHwg50+MnUGF6=aE91TJY_iYSrg5gF1rp8ApsTsrvw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bryan Turner wrote:
> On Tue, Jan 2, 2018 at 9:07 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> So my first question is why the basename detection is not working for
>> you.  What value of GIT_SSH, GIT_SSH_COMMAND, or core.sshCommand are
>> you using?
>
> So I'd been digging further into this for the last hour because I
> wasn't seeing quite the behavior I was expecting when I ran Git from
> the command line on Ubuntu 12.04 or 14.04, and this nudged me to the
> right answer: We're setting GIT_SSH to a wrapper script. In our case,
> that wrapper script is just calling OpenSSH's ssh with all the
> provided arguments (plus a couple extra ones), but because we're
> setting GIT_SSH at all, that's why the auto variant code is running.
> That being the case, explicitly setting GIT_SSH_VARIANT=ssh may be the
> correct thing to do, to tell Git that we want to be treated like
> "normal" OpenSSH, as opposed to expecting Git to assume we behave like
> OpenSSH (when the Android repo use case clearly shows that assumption
> also doesn't hold).

Ah, that's a comfort.  Setting GIT_SSH_VARIANT would avoid this
autodetection code and is the recommended thing to do.

That said, we can't go back in time and update everyone's tools to do
that (e.g. there is not even a release of repo with [1] out yet), so
this is still considered a regression and I'm glad you found it.

Jonathan

[1] https://gerrit-review.googlesource.com/c/git-repo/+/134950
