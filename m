Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48DD1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 06:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeDZGA0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 02:00:26 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:37774 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbeDZGAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 02:00:25 -0400
Received: by mail-pf0-f169.google.com with SMTP id p6so17349544pfn.4
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 23:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RWqqdCSAuZVSAD9y1wnaJ+u7++l7PxqReFJRYlyqu68=;
        b=Ea3NKTwuCoHyqudMXSzBFhe7KK/B4CmksfrgLnA91+/G3ukaNhNh7qL8CyHvpu/hrv
         fKeHS9RkeZ5iUChmziBLOsIqHCZ4UcYrmBT3/pBRBlQ0dqKGy746d003IiJgkngNiY/f
         mT+N4+r8/XklpWfCLcpSRBgKu/fSlA5SAVqrN2fpe6qSlyvwT2j7fc8NAhqCWbjilJIi
         cYCtj0jxK2tqBk38vdpkNO3m1MEWHFUt1dpejL5bRAeOKGoiCGhW+L+VykQt/2VPXE4b
         cSmVtMHBp4IhjihSuTI2gpCh2Pw8FKFzk0zqE8k97CkylfcREFY3pc1FU6bgarJTaoRa
         a0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RWqqdCSAuZVSAD9y1wnaJ+u7++l7PxqReFJRYlyqu68=;
        b=rUL6tFBV6YLq+ZTo5sE3ZD4fSyG2ySboFwcdD1WC5yc3MwnMYbxJY9WhPmYeeKt/0O
         L6nhOJ5/5Se9kdST3jmRa+fGdP3CWT/uh79RcKq4pCzF5begLO9yWXa+kplvAhLVBtRH
         jYNczxCs3SM0wbAVUjV7oYcX5UnP4+I0f0QcKIH3MtzXZKeeHwaN9r7HDFWOuKtF1M3+
         MvjOFWeNDrNX28wQOcRGHOqdmBcJgPpI3nOLsZbgwkx5D/s+Hff+g24ECl4BpaoeaNdF
         BS5I2TcL5wseNUWzMLA0X3UZT75vQfprN0luE6tU12o1EaOc0wDBEYA5In/qhvv0soci
         BHLw==
X-Gm-Message-State: ALQs6tCsQxiaxPu/ngT0HQdODaeS8lgZ1Oh7eFO6ASQ3W4DzGnQB0Mez
        4CxkwHqy2KhFuDWCOlEMe3V8+g==
X-Google-Smtp-Source: AIpwx49CXuOoQPacc+FkTSdFs7fKualo/fPk11TnVI2vUmIcI9xcCHr4v4Qo0YiVn59KpZO4ziw9QA==
X-Received: by 2002:a17:902:bb06:: with SMTP id l6-v6mr14165443pls.255.1524722425188;
        Wed, 25 Apr 2018 23:00:25 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:b5ff:86d4:d359:c7bd])
        by smtp.gmail.com with ESMTPSA id 186sm34268083pfe.109.2018.04.25.23.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 23:00:24 -0700 (PDT)
Date:   Wed, 25 Apr 2018 23:00:23 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
Message-ID: <20180426060023.GA39448@syl.local>
References: <cover.1524716420.git.me@ttaylorr.com>
 <1bc42a611089a2552b1d8bc83ff229be0a5136ff.1524716420.git.me@ttaylorr.com>
 <xmqq7eou35ev.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7eou35ev.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 02:25:44PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Subject: Re: [PATCH 2/5] builtin/config.c: support `--type=<type>` as preferred alias for `--type`
>
> I'd retitle while queuing, as the last 'type' is a placeholder for
> concrete types like <type> above.

Good idea. I amended v2 in this fashion.

> > +...
> > +	new_type = opt->defval;
> > +	if (!new_type) {
> > +...
> > +	}
> > +
> > +	*to_type = opt->value;
>
> But this is wrong, no?  You meant opt->value points at an integer
> variable that receives the type we discover by parsing, i.e.
>
> 	to_type = opt->value;

Oof. You're absolutely right. I fixed this and moved the assignment to
the declaration at the top of this function.


Thanks,
Taylor
