Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83618200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeECXl6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:41:58 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:40172 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeECXl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:41:58 -0400
Received: by mail-pf0-f173.google.com with SMTP id f189so15960071pfa.7
        for <git@vger.kernel.org>; Thu, 03 May 2018 16:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4KVvEw+1SIilEZKOnOViddZ5CGr0DL6eZZ4lUkkoY4o=;
        b=Y6HxnT1AsH1TR2cPHRWpdnyBYwbhM4jDd1H7CApQZpIXDNf4ytryuRcdr8CSlEXGcU
         ZMtbizxbyjXnt1Qiv7yxur4OH7RrHwUcSUzpREYCMdmZHhoUPDjZm0RCfD3MxbUOguhf
         sPuEmGVfFLZI0A7mMvVg/KfM3j8Y57Mka5L9vo/Sz0Mufcv3XgeYjy5pleVEKe9B6+ay
         Y2HZe+OEqwgbKdpHskW8LA/uQia889lXnWtH58pCTWmma8tu8cKZ6vZymt05Y88+HtPk
         JE/X1uw/gET+rAHMyR11hXBKAns+dIVUM7Zdup9z0gY95WGXSzpWeO2SJYd5G7wfy7sA
         qMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4KVvEw+1SIilEZKOnOViddZ5CGr0DL6eZZ4lUkkoY4o=;
        b=fhccwvJ5meyN73LYZ5tsPdurfjQ94+CRM289hO+nS0KWMX8ftCqAtVA/VJToO4O/vu
         kO60EAc1+fru/PxzyusAp2/U2sFSSSrcnAfO6cyV9KvF18PhVzA0K6DrFfuWWUQNF67v
         boz6wR57lIvom2YpjIh1syEvmmf0t3FXW4Wkkcp+HQJosboNKalcYIqFAJ+ZmMK7rXno
         XQN/RJG2ZOL2c+RBuaaQJUOe4vLqcNYOq35JY4IH5pWWuNAsvcsLkDbaIflenq0iVgLm
         /XGao2vb2NIcR+YE11bSq1py1rkCns/z2iI9kmD/sALQ1Aund+dSXRRGt3atL5iGewJC
         zeyQ==
X-Gm-Message-State: ALQs6tBhJR9u2luVaC9NMO9GcecMJoRK9m/2aAwqCYs6mJlmGgi314mG
        2elGKVXfh9tnrlf/DPDxTEWkhg==
X-Google-Smtp-Source: AB8JxZplGDFMNvy9LthsfMDuE2NX+Qzz0/Wzh+AduPNFUFtQPBeVHePl7haCnHYPe7TNhDVnWU9jWg==
X-Received: by 2002:a17:902:bb93:: with SMTP id m19-v6mr6020305pls.74.1525390917425;
        Thu, 03 May 2018 16:41:57 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id u68sm27541545pfu.167.2018.05.03.16.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 16:41:56 -0700 (PDT)
Date:   Thu, 3 May 2018 16:41:55 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 1/3] upload-pack: fix error message typo
Message-Id: <20180503164155.6112764a927d50e23600dc49@google.com>
In-Reply-To: <CAGZ79kbTwqzKgZjN7GSXn-NpKX0kkDVYbXmdz6CC6TrDWbqyQg@mail.gmail.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
        <cover.1525220786.git.jonathantanmy@google.com>
        <177c6eb7058adc1996f0595ddc3cc848c91b578f.1525220786.git.jonathantanmy@google.com>
        <CAGZ79kbTwqzKgZjN7GSXn-NpKX0kkDVYbXmdz6CC6TrDWbqyQg@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 3 May 2018 11:58:59 -0700
Stefan Beller <sbeller@google.com> wrote:

> > +       test_must_fail git -C server serve --stateless-rpc <in >/dev/null 2>err &&
> 
> Minor nit:
> Why do we pipe stdout to /dev/null ?

Usually there's a binary packfile produced, but not in this case. I'll
remove it.
