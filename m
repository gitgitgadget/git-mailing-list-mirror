Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455091F461
	for <e@80x24.org>; Tue, 23 Jul 2019 20:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391761AbfGWUCV (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 16:02:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42676 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391752AbfGWUCV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 16:02:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so19662815pff.9
        for <git@vger.kernel.org>; Tue, 23 Jul 2019 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aDw+vGFQRzttJnbCJiBP9VNhiFbdmN4B9e1uW2WsL8Y=;
        b=LpXpX1kKKmNO4vyQzawT67yU32uw7CDleKnUOVLpzZN+SiOpxo2PAJA0tr3ao5gt5G
         ujkOJF1ap5E1MTBYUbfE0Gqykv6BTNRyPsKko7A+2FfYSCJn1ZvUioD9m8UoFMvLh8r4
         5A9fTUr9O08bvUYb7LoTGiIvvfP9voPpZZFtLc859nk/91sMsrdu953FzMXiqp8IADSG
         oENtvW+8Ky47MHlDW4IT8qE211hXXE0Ww/YA/NVdwgcHlzCe49j2INF8szUn2vANdD48
         QfFsmWYpS0daX0RcgiDX3w63ZfEDEINYYngRYVRVliSJM3KHYkxqu7T7TQb0e8u2rx1q
         kAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aDw+vGFQRzttJnbCJiBP9VNhiFbdmN4B9e1uW2WsL8Y=;
        b=n6YGEgay/UT0ZSQdVW0TjgUbfkXgGrG3HgqxH7S4THw4d+ujhvoFSfUlIxkl2q20fR
         kaxoyQdFvDDQSw+HEtYDOxJfIJGg1x8APoDeFrwz3azKXS48cYV/pYT9fDdphzTy9dnF
         A+PWuqiEc87+BpdJhmVOL1ZbYezj1n4BvSXBk2Mc8X1FpBNzutPzCpm25HJJBk8eJYmD
         qm6szcizdRxnK20xAR4mj2Wj2cssWzpyBJCpf4vV4bBoc3p9Z8PBDjWVQzjpPmMbelu0
         RPozf9A3zR8LL6j4Dvw+AWw+9vxU+BkMdge8+Gh7NqcL53hN7bL+DHUr6Ulwk63W9EUb
         q5YQ==
X-Gm-Message-State: APjAAAWbNiySDBIFdtdvQpx31CPszeYavuNXeaYl1j5z/jLKA7hoDT3j
        /l/RIYJFUjzaHYN/KXfUuIoBdcq8EVA=
X-Google-Smtp-Source: APXvYqwseJCyzGwBDR+DaOn+7yHpeLm1ZVSNiW8Emf4xk9jU2zJAIgOOfbBb9LIMZGDyAss2mbdR3A==
X-Received: by 2002:a62:642:: with SMTP id 63mr7528295pfg.257.1563912140264;
        Tue, 23 Jul 2019 13:02:20 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.220])
        by smtp.gmail.com with ESMTPSA id h1sm33347431pgv.93.2019.07.23.13.02.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 13:02:19 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Junio <gitster@pobox.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Martin <martin.agren@gmail.com>, Thomas <t.gummerer@gmail.com>,
        Elijah <newren@gmail.com>, Phillip <phillip.wood123@gmail.com>
Subject: Re: [GSoC][PATCH v2 1/1] rebase -i: add --ignore-whitespace flag
Date:   Wed, 24 Jul 2019 01:29:32 +0530
Message-Id: <20190723195932.16951-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqq5znxvhdu.fsf@gitster-ct.c.googlers.com>
References: <xmqq5znxvhdu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Fri, 19 Jul 2019 14:33:49 -0700 Junio C Hamano <gitster@pobox.com> wrote:
> 
> >  t/t3431-rebase-options-compatibility.sh | 66 +++++++++++++++++++++++++
> 
> Isn't 3431 already taken?

It is not in git/git[1].

> >  5 files changed, 97 insertions(+), 6 deletions(-)
> >  create mode 100755 t/t3431-rebase-options-compatibility.sh
> > ...
> > +	git checkout --orphan master &&
> > +	q_to_tab >file <<-EOF &&
> > +	line 1
> > +	        line 2
> > +	line 3
> > +	EOF
> 
> This will trigger "indent-with-space".  Instead of using q-to-tab,
> perhaps something like this would be more appropriate (not limited
> to this piece, but also other ones in this script that actually do
> use Q to visualize a tab)?
> 
> 	sed -e "s/^|//" >file <<-EOF &&
> 	|line 1
> 	|        line 2
> 	|line 3
> 	EOF
> 

Oh! My mistake, I should have used cat instead.

Thanks
Rohit

[1]: https://github.com/git/git/tree/master/t
