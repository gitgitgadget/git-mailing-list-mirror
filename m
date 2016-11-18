Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189651FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 18:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbcKRSZd (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 13:25:33 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35117 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752336AbcKRSZd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 13:25:33 -0500
Received: by mail-qt0-f179.google.com with SMTP id c47so162345699qtc.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 10:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O3HriybSrCo6mJB50t486qzwfPTNm5L6TRhZqwlBR1g=;
        b=hPBPFYvnF0gELJt5PeQCH5jgjxoiecf0OjtR/P5ybWlU8AAlQVu9H67fk+ZNwzC49Y
         SdiM5zIbr3SVBRjJYAO6Z9y6FBBDyurqRWGcHG1Q1QnIcWRq6ypd34CVlBDrfQNf+xcD
         azRcepiQOLKWuQAeaHPFspHMia4OjQwDEXo7PxM40ol+YTiDEWWTQhxWCBQNUeiNe7Sw
         dYKtO4evwvfsQwtZAKLxPuFPAAjVMsPLH+/YfsodQHUUtzO5xitAJlUyPX2bxBoxIz2w
         e7UnH2cvrwswT/ApuH4D/lUK5aG5Q+InS1NAR+An5sTomdgntPPShqUzEqjnpD8T+4VC
         yUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O3HriybSrCo6mJB50t486qzwfPTNm5L6TRhZqwlBR1g=;
        b=JtMB6LgFLYl83+++gDBUZkNArWcVJeVmmRV/YUC+cOBNg9SOANx6DIieyoj2fDpTp1
         affug09vRDYhQJb5vF5y+Co+vF3V3lGV73UsHgZZpEvZ3PteOJ0fPrIdcqsbuDDic+hm
         KQABOAz/v1TS1latyO28oFX0g81Tt/uczcJEC+FvDXu8vSarnRv0MuNawbmPhvVGfLO5
         SIcnT2m3JA303c2lq6Zvtejwr0/jSyqy0XrbmhAkZNFErTIOANq4zSNqHgejI37Xtk4g
         QrIEZ3LQo3GH7BUa/BKPQ/M17rnPsQYo+hcdxNPBfjaHtbtAIZap8ryOx0g/LXc66MV4
         VwwQ==
X-Gm-Message-State: AKaTC01yiiVBpTz6MW1ROdiAc61J3cWnMIufSpHE0RJmB/qdH4t6ORdJlUhzXLPlF/ksOGM969Ww5R3qZhHq4tgX
X-Received: by 10.200.53.9 with SMTP id y9mr824022qtb.176.1479493532057; Fri,
 18 Nov 2016 10:25:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Fri, 18 Nov 2016 10:25:31 -0800 (PST)
In-Reply-To: <20161118174607.GP66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com> <20161115230651.23953-9-sbeller@google.com>
 <20161115234403.GE66382@google.com> <CAGZ79kbCqLsRzrsX29uM7pobs_11UZtFOQWP9RO8ptS5PyDfmw@mail.gmail.com>
 <20161117222926.GN66382@google.com> <CAGZ79ka0-JFvogHRoTA4ioMK86zD=zkgEfBb-gpU8tbOjwEoFA@mail.gmail.com>
 <CAGZ79kYE1JooyKMDsEM5=6OWxbCOL3q2=Et3nL7mMcayxtLZxA@mail.gmail.com> <20161118174607.GP66382@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 Nov 2016 10:25:31 -0800
Message-ID: <CAGZ79kYD0ER4k6+o=spnCS3ymOnTcZ5i7Lu5-G_GLXu6XDqS3Q@mail.gmail.com>
Subject: Re: [PATCH 08/16] update submodules: add depopulate_submodule
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mogulguy10@gmail.com>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2016 at 9:46 AM, Brandon Williams <bmwill@google.com> wrote:
>> +
>> +       sub = submodule_from_path(null_sha1, path);
>
> This should probably be checked to see if sub not NULL before
> dereferencing it right?

yeah, will fix.
