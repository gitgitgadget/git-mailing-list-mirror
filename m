Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AED512036B
	for <e@80x24.org>; Tue, 10 Oct 2017 18:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932691AbdJJSPq (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 14:15:46 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:48582 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932613AbdJJSPn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 14:15:43 -0400
Received: by mail-pf0-f169.google.com with SMTP id b79so5781899pfk.5
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FiKqDyYoNF3RXlPnj0UUSK2RCX1eB3mCtYifu4zJu+E=;
        b=ArXgue/vuBKoPT43CwF5Cd00VV9ATCz8N+Gt3TZvcDnrDQX3iilBZqFtVLmg1TpYrP
         CQbtAGak2jrT7FrTSFmOG3kD3uOKB8N67LKjF9oxigZjyHJu6COOchKB0KnqukKMPGT8
         9p/SQzARgXrlaWcoFUIF2AbDqa1cxlsEllS7xvyG+kBxBk7kUld+VfvT5Tcwd1Xhdow7
         omlT3MPOFEX7Co8IGSbOxd99IAaGzf8WYZ8u5NClxSgnpRwpJ4Nj4/J98+D7z1vqlBrZ
         xCIhdq3qxbGxgR7HKpvg+ITZDvFmYwsklvnPmjvkpzb62eu2nZPG0QMM+nPxBNzrRA4Z
         wHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FiKqDyYoNF3RXlPnj0UUSK2RCX1eB3mCtYifu4zJu+E=;
        b=Rg0sgzNWtl096Mu3li8Q1oDnnj2wwx/aLy/+TiMJ0nSF+vr/gEqaMwGM4ge5K7s1JS
         h2Jz47jLRfo2o0QcLqnSIFvtBCPT9mOYuIx5oxl46CJw28F0gX090mO3XC16dItgG6gn
         a9d+4EysOiVfd92F2Rn+OeT8TI/9JvhyVDTpE5KTrOTSgZhaqEHfVdJffa3OJoAeBdez
         iJp4oXdA7BWd5Rikz8jWOSV7KFygLo4xfWw40kUbxFT2p7PZh65+oTSOHSp0Tt/Thy23
         4PJpsvtOvdZKeyoz1+8txf+fs3NHUaRqBw8jeUnEhR2MqLT32/V/qKvkkYUkIU8vB/bj
         0o5Q==
X-Gm-Message-State: AMCzsaVrBkklRDu9aqgzEyRz6gfoF7/nMtZc1GaaJKSUyhGPG+aWbn5/
        CsiWXAYeZ2PZi6L2fuFlaml8PQ==
X-Google-Smtp-Source: AOwi7QCdidit6SS3G4aKJ0I5OHJLqWTtJ40mkB5Sb3bxHirvNXtIREBTz2RFZzOuP2/o52+mCqackg==
X-Received: by 10.84.240.196 with SMTP id l4mr12952735plt.445.1507659343264;
        Tue, 10 Oct 2017 11:15:43 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:961:a8fe:b03f:d840])
        by smtp.gmail.com with ESMTPSA id o9sm9050119pfk.162.2017.10.10.11.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2017 11:15:42 -0700 (PDT)
Date:   Tue, 10 Oct 2017 11:15:42 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 02/10] pkt-line: add packet_write function
Message-Id: <20171010111542.1db0ccdf8899a9f501f4e1ca@google.com>
In-Reply-To: <20171003201507.3589-3-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-3-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  3 Oct 2017 13:14:59 -0700
Brandon Williams <bmwill@google.com> wrote:

> +void packet_write(const int fd_out, const char *buf, size_t size)

No need for "const" in "const int fd_out", I think. Same comment for the
header file.

> +{
> +	if (packet_write_gently(fd_out, buf, size))
> +		die_errno("packet write failed");
> +}
