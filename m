Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C374B1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeCPUIg (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:08:36 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38939 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbeCPUHT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:07:19 -0400
Received: by mail-wm0-f45.google.com with SMTP id u10so5200857wmu.4
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qYGoRrD3iRFWgrDkUzBUpjr99c/9FRN/64O4xrV7FsM=;
        b=LiQp00egmKj3GYHso7ajehFdQ4ZNR8Ai1j1AiyITWDDQjENWuaPopR9LICT2MBEtgs
         KebSJPvbj09lkJ29HxQXz/mbjozkx/CXIeDzA/E+uS+83Kbhch4eeOk9aRkXRuIsd4iw
         TsgwqqzajFaQkWtdgZipmja8oTv6M4CCS++Bu41hBE+hPZSQmxNeb3dujlGNhabGsp3C
         FNQosB7LIo6VrXOb5rcA3pp3ghEMJDbKh/krTdfSEnpbZycdB8b3khsWZpygfBFRRAug
         qhgVgtnogoLCM0UsBonzXapGo9yXwz+pECECZIx3AyyqnRL99u21Ab0JH7gfSuEWyCa4
         LpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qYGoRrD3iRFWgrDkUzBUpjr99c/9FRN/64O4xrV7FsM=;
        b=DByBk2N3M0+y4x2QFxTNgxAJAkAAZ6DzdT2srG3gHGtLC6TYYDMsPD0kifb61SQy3V
         0ppO/SRvGTpm9T+A0oi76SYZPF04JNW4ODjEipb9NlWGnEhG8SbnZmQCQ/WDQr4DH1hG
         YpTG9J1D8PxiLqrkzquHq40OS3jUes21B5jChrcbutvBKZBwQ2J8se+O3PtA8euS9Bqm
         G7MDDavEQ7FwgJivddW4KKfEbvAKSYjnZOnvC1/xGj2mv8BH7MjGHxeL9TivHoBTOiDG
         6kY/eTOWGvldZkfLt1hv0JEUzgeU+/A5QfwRTTtWO1USZU5tu1a5VP3QWfvXAMUr2s/M
         HcHA==
X-Gm-Message-State: AElRT7GUyw2SMGNeJzyEWz6Lty85CPOLrbAGGw32NlhyPRLZTJVBeMfC
        yi7jGm6O5sntLBK1rWgqDz2lInkZ
X-Google-Smtp-Source: AG47ELuvBYuepySMi1JN9WFnQF5RbO36cP5pUa642ieEDrDVj18/jmxNmfIjRqQRDcI/zCGLFoFIgg==
X-Received: by 10.28.74.88 with SMTP id x85mr2732856wma.106.1521230837873;
        Fri, 16 Mar 2018 13:07:17 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 124sm7534831wms.25.2018.03.16.13.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 13:07:16 -0700 (PDT)
Date:   Fri, 16 Mar 2018 20:10:34 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH v2 2/2] stash push -u: don't create empty stash
Message-ID: <20180316201034.GA2224@hank>
References: <20180310111215.GA14732@hank>
 <20180314214642.22185-1-t.gummerer@gmail.com>
 <20180314214642.22185-2-t.gummerer@gmail.com>
 <xmqqtvth3xt5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvth3xt5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/15, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> >  no_changes () {
> >  	git diff-index --quiet --cached HEAD --ignore-submodules -- "$@" &&
> >  	git diff-files --quiet --ignore-submodules -- "$@" &&
> > -	(test -z "$untracked" || test -z "$(untracked_files)")
> > +	(test -z "$untracked" || test -z "$(untracked_files $@)")
> 
> Don't you need a pair of double-quotes around that $@?

Ah yes indeed.  Will fix, thanks!
