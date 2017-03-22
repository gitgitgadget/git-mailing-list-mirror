Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A30720323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbdCVVgl (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:36:41 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34363 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753939AbdCVVgi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:36:38 -0400
Received: by mail-pg0-f43.google.com with SMTP id 21so79918830pgg.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 14:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D7FYsMgW2r7JIb2iR+14+zNp/p6aL8oeyWQIdHMSX3w=;
        b=A5s9qORhCrsbwjIGnnw2313UjudoeW3/f4RHSLEc0OhYxQKvvf12yfa9tnvf8Arg5E
         HB7HOoWKT5uM6Qpp1YtNAq/GQK6BUlXIBMHSpLnLKEu1bly9OsB19kSy+1NSt4UOmR+t
         gqiCwDmNRpZmydurT9Uon0LiomqGJjJPw1MVPA0lbbVZsK/ICaRXuza6CT5IjU5iShGu
         Dnzm0Dg0zqmV4H4hfiAmmnRMpY+JEExygkad9hlMRCUMsxJsqnsdCMrzq6weFMH9sHw6
         1+fHRJThq69YK4ZjkTtJ35g/hQN8OUqV0IWQwtNzaaVuS2qCAUlsT+gmh1EnmZLiFXDO
         ASyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D7FYsMgW2r7JIb2iR+14+zNp/p6aL8oeyWQIdHMSX3w=;
        b=Rct+ZrzTfE1IUiaA0XMxBtsCSQKikkE1R68Xm8wAcQRc2HwTpQgTtU7LA5YvAkynL5
         FlKsprJ9T80veAFV+LMsOZ5doJ4S4NcOXH40EAqxIR/k2HpLz/sTMoHnL7i9M3MBg2fK
         1f2X75C/BnD4P7lVRlhI4XIuccIUe8VWzNhuoAVixbiCrv5lF5T7XciVgmo2YCY3wIis
         xeUHlCWqFIqyisrJmHB7Zn0IsPUyR5V0yb4iviYKA+LLLnHP/NLYQcOBn5oaysjH8/yJ
         esgXEYF3n30yVBhIYwJ4pjuqaO6Y7bTyba9bzSRFfpBOfsPo5WId+EorW0Ds0vOh5NzG
         oTng==
X-Gm-Message-State: AFeK/H1c995aFar/bQspPQ2kh85XHKZms0Cx6sLyU2HUT8nM1/RNpWvsw1+zpC1yOyHUMDcl
X-Received: by 10.98.25.83 with SMTP id 80mr47869488pfz.243.1490218597007;
        Wed, 22 Mar 2017 14:36:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:4506:c5a2:cf62:91cb])
        by smtp.gmail.com with ESMTPSA id i3sm5746801pfk.47.2017.03.22.14.36.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 14:36:35 -0700 (PDT)
Date:   Wed, 22 Mar 2017 14:36:34 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] remote-curl: allow push options
Message-ID: <20170322213634.GB11254@google.com>
References: <20170322195102.165314-1-bmwill@google.com>
 <20170322195102.165314-3-bmwill@google.com>
 <xmqqo9wthukz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9wthukz.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/22, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Teach remote-curl to understand push options and to be able to convey
> > them across HTTP.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> 
> An earlier 438fc684 ("push options: pass push options to the
> transport helper", 2017-02-08) said:
> 
>     ...
>     Fix this by propagating the push options to the transport helper.
> 
>     This is only addressing the first issue of
>        (1) the helper protocol does not propagate push-option
>        (2) the http helper is not prepared to handle push-option
> 
>     Once we fix (2), the http transport helper can make use of push options
>     as well, but that happens as a follow up. (1) is a bug fix, whereas (2)
>     is a feature, which is why we only do (1) here.
> 
> and this is the step (2) to complete what it started?

Yep!  As far as I understand from looking at that commit, push options
were being passed to remote-curl and remote-curl was silently ignoring
them.  So that patch made it complain when a remote-helper didn't
support push options.

This patch teaches remote-curl to actually support push options, fixing
(2).

-- 
Brandon Williams
