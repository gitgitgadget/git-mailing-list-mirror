Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6A461F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 18:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753350AbdARSvG (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 13:51:06 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36553 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753330AbdARSvD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 13:51:03 -0500
Received: by mail-qt0-f196.google.com with SMTP id l7so3217843qtd.3
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 10:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XcLOfuu2bPQVAxFHrTPoTE+Qp7BHTANXbuxAvrK2qnc=;
        b=ZIgMss8YwVL6yBW4MwwFY39I+yZ1qvuvyknNhhFEi2wMuXsUVJ2bJWN5oMRnMglr7F
         yhEY1ewbeWZC3pccSKK9LS2HktmNT1nckDNOU2LWTwFNev4iesrnqkom0IhsOKSiBwGr
         CgiqTFpIgMb17hsgs4DP8IuJKUg/4FUhpe2s1/Dnw87Ukt8IoICxzxrPVcJGQ1yG3n7o
         NsZRjjLTFFjcElIq9DQ6at/rNmrUV29WTh1xEGtNIGPheEPY+M0ZWDEpWKYgPGDK62aQ
         cInG6LdtLOwJtqa7C3f2GLwjY2vSGmG5mZ9avdXOhSDRkfxUxCgUI7vgWL74hHkfPPvu
         xmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XcLOfuu2bPQVAxFHrTPoTE+Qp7BHTANXbuxAvrK2qnc=;
        b=iwdvyDPrDL5kcHzE2YJG6gie4DLK6ChusjM1AiCGxYukwKCmZgF8NdBN6i+BrXryyf
         Zwk45m/jzQ1FsIfPPUxHEeO4XVyzyNkpRQUeV0/Je/4UUYNYEeKgkY7MGYpes+jF7WLC
         NqEBzgn/RC98FVAtEHcOTV84WPsi0pC1/nUlfW2+Z3WFhyljgrxdoZ0noSKQfrdt6wKV
         6FCs8iCHXedF5NEevSTF0/2Z0GGVyeG/+LCf66e9Q0d+7xvXLPwHx/IwXjvEldjF061W
         76PQkxzynhr/N9p6C+RBKgLYj0maevAZA5IfX/+sNysWiGOGCKNl+vWrqD9E3A7JDgr3
         pqaQ==
X-Gm-Message-State: AIkVDXKDoRvO6WkEgo0hQoRV72T/+AYmBF9c0gDIsewoLKm7WmUyG9tRBpKuwTvxY6glEted
X-Received: by 10.200.37.22 with SMTP id 22mr4115111qtm.250.1484765416734;
        Wed, 18 Jan 2017 10:50:16 -0800 (PST)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-15.NATPOOL.NYU.EDU. [216.165.95.4])
        by smtp.gmail.com with ESMTPSA id d144sm888484qkc.45.2017.01.18.10.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jan 2017 10:50:16 -0800 (PST)
Date:   Wed, 18 Jan 2017 13:50:15 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     meta@public-inbox.org, git@vger.kernel.org, peff@peff.net,
        sunshine@sunshineco.com, walters@verbum.org,
        Lukas Puehringer <luk.puehringer@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v6 4/6] builtin/tag: add --format argument for tag -v
Message-ID: <20170118185015.3vq7wfvsfo3gjj4b@LykOS.localdomain>
References: <20170117233723.23897-1-santiago@nyu.edu>
 <20170117233723.23897-5-santiago@nyu.edu>
 <xmqqmvepb4oj.fsf@gitster.mtv.corp.google.com>
 <xmqqh94wb4y0.fsf@gitster.mtv.corp.google.com>
 <20170118182831.pkhqu2np3bh2puei@LykOS.localdomain>
 <xmqq4m0wb43w.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4m0wb43w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 10:44:03AM -0800, Junio C Hamano wrote:
> Santiago Torres <santiago@nyu.edu> writes:
> 
Was:

Thanks!

Would you want me to re-roll really quick? or would you rather apply
this on your side?

Thanks,
-Santiago.
> 
> Eric, I've noticed that this message
> 
>   http://public-inbox.org/git/20170118182831.pkhqu2np3bh2puei@LykOS.localdomain/
> 
> and all messages from Santiago appear empty when they come via
> public-inbox.org; the reason I suspect we haven't heard much
> complaints is because nobody else around here sends multipart/signed
> disposition inline other than Santiago.
> 

Interesting, I thought I wasn't inlining the .asc. I guess I can disable
signing for this ML for the time being. 

Thanks for letting me know.
-Santiago.
