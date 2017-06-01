Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF6B2027C
	for <e@80x24.org>; Thu,  1 Jun 2017 09:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbdFAJoV (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 05:44:21 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36434 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbdFAJoU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 05:44:20 -0400
Received: by mail-it0-f67.google.com with SMTP id i206so4932970ita.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 02:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FHjlwcLpapIj2xnP4DaVEpav8L7Tsc09vwNUbMmq9sk=;
        b=BWfOsfPFMu6v2cYWL4j177cgEeY0McT3xZ5v+ggR2snPqh4IoWd+hVQHBX8PRzG7bW
         e3T6cnbURcd8ROAis2kKBxZ0YEGVvTeyopey1EKN/gheJ4Qu3e/8CPAqKrUhSCY1I6Wg
         VRRj6vtkLHzIoJbv0rZXi/N0oepu+XJHbDIwnk08hE5QsMvFvMFoqvz2HXCWmW7ORZit
         qpoe42MIUOI8bsPfczm/bO07k5ilw1GYIfIaO7RHXIb9Ap3q/fbI9ZinqYa7hm785855
         Rxyc0nYwCO20ZLElLe4eccqDYgekHtGXN954FrtuACE6bBaGnVUDbhigVGuzWUYbtYfm
         vSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FHjlwcLpapIj2xnP4DaVEpav8L7Tsc09vwNUbMmq9sk=;
        b=MgsC+kB/bGGH+iUWqXHlHeiVc5T2lh969isnCNn0Y4LqJBFVKjcaB+YRZmaIjNgvxu
         CxG8xSz8es6A91rNB/Vez0AoW3QWUaUbhlna3uKk4Ql+rDyXz04cWf7bu6A1TVN8od0f
         k8olUh7U/0jraNhVu7RiJ4joNZr12QLsgjFcvBGkdm6cbcBvjcJ1NNtN7MveyGgECtFb
         Nm/sfPZ7wlrvSVM3SfixLaDFkuHD0cjKD65WYu2mCO+l6NHV9t4NJ77oVqAyzoB+Mxtt
         sklrb9piOAj4tcBNo6Wqv6fGAKSELXDvdAb52d9f/FnEF1dR6Q0dqax9EDB1v1m9J7VL
         pFWw==
X-Gm-Message-State: AODbwcDN7w/fhPVGGmV+I2PPUD/AyRE/MDv4n+WRS3BIe9hhXRk1avH/
        8CCQigF0j4aEqA==
X-Received: by 10.36.194.129 with SMTP id i123mr1746965itg.9.1496310260195;
        Thu, 01 Jun 2017 02:44:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id e186sm8680931itc.21.2017.06.01.02.44.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 02:44:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v5 0/5] convert: add "status=delayed" to filter process protocol
References: <20170601082203.50397-1-larsxschneider@gmail.com>
Date:   Thu, 01 Jun 2017 18:44:18 +0900
In-Reply-To: <20170601082203.50397-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Thu, 1 Jun 2017 10:21:58 +0200")
Message-ID: <xmqq1sr459fx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> here is the 5th iteration of my "status delayed" topic. Patch 1 to 3 are
> minor t0021 test adjustments and haven't been changed since v3. Patch 4
> is a minor "extract method" refactoring in convert. Patch 5 is the new
> feature.

Thanks.  

Will replace but it will take a while for me to get to it (I expect
that others may very well beat me to reviewing this series).

