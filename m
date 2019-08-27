Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1DC1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 08:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfH0IlR (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 04:41:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35453 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfH0IlR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 04:41:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so2097022wmg.0
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pV1ImUkNHAHQRiaq2yJH+8IZY7CrDGul3EKjAQsJ4TI=;
        b=Va+qoaCh4FzIVKpQQbZK0HNxhlNwCMv+SzjAxuRF2guPMZtS7Rbu/Qp18rUdrJyAfh
         5T62j8lQcJmz8GXEOLwkmpWCILaikmOakcW1RA9UyYtbJf2M8YzNE2RlVUG9JKyBqt8g
         2rRiFGs6IxdpktW4+dHbD0BNDQDcIi71KiqD9T39DE7XV2z3TNwWJ3MTj5Xdc1w0cVCN
         x0h+KMiK8mPeAmaUE7PrybDOtj5cg2HigJmk/4MQwe7wcwD0gv6ifKbQulSvA04Vumyt
         NvqD88O+1CyCxRSjw/vXP0E7ChGQ4HpMr/e/IZzoMcmqKNSNoTTdC5J7hGsO+h1w/jpq
         c6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pV1ImUkNHAHQRiaq2yJH+8IZY7CrDGul3EKjAQsJ4TI=;
        b=ILiSbw9OC9yug73SDk1J/R2NiRKWJNwNZMeMUFyptG1mwevxLWFEfI1R9x0G2VT8Qu
         v0K1RFWHI/jeZHoptgWH6rAzMwacv0N90lYE2vDaApbBZV2TDQQO7uJkvG3/TQF4FFO+
         nPRN7NoDiCWVAEYiSyHySfnrVcsNeyRU6noVQPJhqBmDCTAV5qdCf0Ka30TzncpnQePu
         qXPzpVTwr82YTjcxtH7NU+wfIBfKYRr6qO0I8vjEtG6iLJRKSrviePbkcVTpOdJxGm6Y
         SnLnEHhmmesXQA6qdXniX71XE7BbE518utCqqodkMO8l7s7S69UyIPHhvnrmMj8LCWLP
         RM1w==
X-Gm-Message-State: APjAAAWLe18RKkrAHhrBjEPGLUGVV66LxhNIM6DL53HNyU6ilqRyIs/n
        sIIn7CsNv5XfbYuy62iVGiQBCBXHLTI=
X-Google-Smtp-Source: APXvYqxY09Xw8XyKvgbjCEnoqyCyflBtXgckkth7S4vsSkbuZLjzeiQZvz6Tnf5gLOmIeTkqZ3biVA==
X-Received: by 2002:a7b:cb8e:: with SMTP id m14mr18746735wmi.10.1566895274870;
        Tue, 27 Aug 2019 01:41:14 -0700 (PDT)
Received: from szeder.dev (x4db46f61.dyn.telefonica.de. [77.180.111.97])
        by smtp.gmail.com with ESMTPSA id o14sm25174462wrg.64.2019.08.27.01.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 01:41:13 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:41:11 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     git@vger.kernel.org, entwicklung@pengutronix.de
Subject: Re: git slow unless piped to cat
Message-ID: <20190827084111.GU20404@szeder.dev>
References: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 10:15:59AM +0200, Uwe Kleine-König wrote:
> I have a problem here with git being slow in some situations.
> Using git 2.23.0 (from Debian) the effect is:
> 
> ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git show v5.2
> tag v5.2
> ...
> 
> real	0m12.727s
> user	0m0.300s
> sys	0m0.371s
> 
> But to get the actual data isn't the problem:
> 
> ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git show v5.2 | cat
> tag v5.2
> ...
> 
> real	0m0.764s
> user	0m0.014s
> sys	0m0.020s
> 

How does 'git --no-pager show v5.2' perform?  If it's as fast as the
case piping the output to cat, then look into what pager and pager
options you use.

