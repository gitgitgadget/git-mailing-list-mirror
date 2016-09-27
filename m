Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9523E20986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936359AbcI0UxM (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:53:12 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36525 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935813AbcI0UwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:52:05 -0400
Received: by mail-pf0-f173.google.com with SMTP id q2so9395514pfj.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 13:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F84iXNVilN5AvaarDrnW2iRuFwBYvHE1JhuQTiHWASw=;
        b=GrC0WbtzRFTu0jIotVops2vHAOFo1rqaTtcbE8VLPDCNYZOmGw94J54uIgAz3Gg7vC
         A+c2TCcSckmxLY1gWSyEqDlh56orpYR6nV7F3vNC6PhMU/JZHleUOi+yR925y9kL6wTe
         VJzqhStlRFqHCzbA/RaFvRoeJ4vo+4j5HI36Hv2K67Ja/Sz8WhgI8opn8n20JaAGip2x
         Il8GDNTM4BGUFOPd4r9u3hvInY5r4Jt2m4XOEco4OShjHbwy7IMTpM/I3ZtQ7mQBBbXb
         V/UnUmwe+wYnyQx8Rlmlbj869unlktzg1rQIxK5s4E6NeRF4OeIrEZAxbgZGbgVM+j3b
         zCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F84iXNVilN5AvaarDrnW2iRuFwBYvHE1JhuQTiHWASw=;
        b=CvwVTQE/9I8EP5n4fh6Px6ivfHvvZy1C+MZjkC1Guh72J4+6Gdkg6GEwWFypTD8dbE
         kGpaIO5lfZ78UkoYOsjzHoNE5wBszKcAgbG/ZOCckEp0YLv6p5wj4ZgJuv1P8zpzQB/G
         7Mx7WbT97zx8rv/RJ7VqA66Wi/vztlXAG9ACUXB5uG11n2Uo7SxLbc3gfaNZEPj2RSMf
         VzpU6r4l/q6taSW6jsWN4aOhLmnCITO9ywWyxDk0gTgDSd7Y6bGO2QnEwfNhY6vDWU8F
         tIfd++VwzRzj7Y4/lNU7i9odTt/C65TrYTep6gXjRI/6LAqSW7ks2ACmj48Oxyk5IBsP
         CDCg==
X-Gm-Message-State: AE9vXwPFHvTVyfMJqNpCYl5TGXeE+Xs3dD8j720MyloYCIiLRcbxk+CYJZbhH1buVnaAl6CW
X-Received: by 10.98.2.215 with SMTP id 206mr51489222pfc.89.1475009524302;
        Tue, 27 Sep 2016 13:52:04 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:3959:5f82:1885:1644])
        by smtp.gmail.com with ESMTPSA id h8sm6945307pfk.88.2016.09.27.13.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 13:52:03 -0700 (PDT)
Date:   Tue, 27 Sep 2016 13:52:02 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4 v4] ls-files: pass through safe options for
 --recurse-submodules
Message-ID: <20160927205202.GG32565@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1474930003-83750-4-git-send-email-bmwill@google.com>
 <xmqqh991nq34.fsf@gitster.mtv.corp.google.com>
 <xmqqwphxm7av.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwphxm7av.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > In nul_to_q and q_to_nul implementations (t/test-lib-functions.sh)
> > we seem to avoid using "tr", even though q_to_cr and others do use
> > it.  I wonder if we had some portability issues with passing NUL
> > through tr or something?
> >
> >     ... digs and finds e85fe4d8 ("more tr portability test script
> >     fixes", 2008-03-12)
> >
> > So use something like
> >
> > 	perl -pe 'y/\012/\000/' <<\-EOF
> >         ...
> >         EOF
> >
> > instead, perhaps?
> 
> I actually think it would make more sense to add
> 
>     lf_to_nul () {
>             perl -pe 'y/\012/\000/'
>     }
> 
> to t/test-lib-functions.sh somewhere near q_to_nul if we were to go
> this route.

my mind is drawing a blank, what does the 'lf' in 'lf_to_nul' stand for?
line feed?

-- 
Brandon Williams
