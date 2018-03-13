Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA871F404
	for <e@80x24.org>; Tue, 13 Mar 2018 16:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933537AbeCMQdy (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 12:33:54 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:37335 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933513AbeCMQdv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 12:33:51 -0400
Received: by mail-pl0-f53.google.com with SMTP id w12-v6so108891plp.4
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K1zL7Ar7Eld+ZDVPwqYemYxRjmY4Dr/3K9sY77VMUxM=;
        b=gJJUyzRErsUcy3ERcFzvTD49mZ+s+okV/QDBwiGBU1TedStBp53jXZFqVr/dWK7DQe
         xh5pZG0/qscj8ym1C5HcKqBQ3GJr5p2CBVWwM4A4zwQwCpzth1NU5F9bZxHdXwVXwg1s
         wP+sF7T2NtQaajKkc0wclwNtjvDUMdn3fqSGPjCajt2g2L5o8qKU9OpUSl5AzEyvZ+Mx
         XW0Xm1T+ZVOefS3EDyqaaogHqwaNP+0pntFvMW+1rMXEWARnoy+xcp1MhyoUk/InonRA
         +fnsVNvUc2VU0KDqNy+O6lQG7UWfRAAh23F7kCLIXGAfNNNlMZUhf4xtwOKHHCd/RFfy
         IKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K1zL7Ar7Eld+ZDVPwqYemYxRjmY4Dr/3K9sY77VMUxM=;
        b=ZW8HVLVQYeiN4bIhkFRYGG91oOm+FS5eH5qcurqBP1UO9LvbDrbB7M7xoffY61xVQ+
         2cKLSwDlBdG1C2rwDLAJ9uOyD6MzRclU5S0EPIIeMckk7Etd0blTkaw63zQ90eYteR6M
         c7TfatPy1zpGN/aQujEbKV4QEndWlH95PsP4X1w5Af6S0NzLE+wOn9+duwF2DRYSTQxq
         3xx73D3fJHspnHypO2lLjrFta26jhy4Ey732P783cAAJpMiR8qqGe06flvT4yu0nDzHa
         iLWQNN5DpSq1rG4KZDYeu27dvQClYviWko7BXC9Wm4B03eF5lfv5m6Ll5bMYUaK4J/bf
         mX4g==
X-Gm-Message-State: AElRT7FG9+wzuZLPbVcsOKwvjC+p0cDIbckmYMr2LUaRvFbO78Gh8dfz
        K1iZ1SgrPVO10Jbk/25hs2WSkA==
X-Google-Smtp-Source: AG47ELsqdObYP1YqGmtRPCjjaDf0Fix1/ILlbUDGn+2hqbz4HLjAidJ4CZk1jCyh+vMUNsjKFdDl1Q==
X-Received: by 2002:a17:902:6b4c:: with SMTP id g12-v6mr1065936plt.363.1520958830547;
        Tue, 13 Mar 2018 09:33:50 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id p14sm983038pgu.44.2018.03.13.09.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 09:33:49 -0700 (PDT)
Date:   Tue, 13 Mar 2018 09:33:48 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 31/35] http: allow providing extra headers for http
 requests
Message-Id: <20180313093348.34f10e0ca4e14a44a62a5049@google.com>
In-Reply-To: <20180228232252.102167-32-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-32-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Feb 2018 15:22:48 -0800
Brandon Williams <bmwill@google.com> wrote:

> Add a way for callers to request that extra headers be included when
> making http requests.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>

Likewise,

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
