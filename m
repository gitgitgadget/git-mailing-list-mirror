Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A43F1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 20:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756929AbeAIUu2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 15:50:28 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36262 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753968AbeAIUu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 15:50:27 -0500
Received: by mail-pf0-f176.google.com with SMTP id 23so6742688pfp.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 12:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MUSlKvkOwH8xWopj9D/kS0cpNzoRNtE2N0uDLG2wGkE=;
        b=eZJjdjMdEb1VhfpaHFGFE9ohw6lTUoSAYzjM3szX/uD/fFC2t0ciMEMWjsx1yVINe5
         KwGDTf1H9iULdyMgxYLYwQtmBouSHk0qYceaik36OmAG7WPfv0N3PfRekuz1N2lucd8i
         nBCpb3/JJXnGR1GNO8u7syd8/eMpGYWQnk3U1qmUdGBOx6BJq+agRgdYqEwtoRQ7wJXG
         vwLoDnrFVOmoe5yylcA/l8l3TFIqXTdBLyQBG7V61sEGrgJSyVy6kNh2tf1/Qy4lJjOX
         AnVCCSzOZUXsEiKyto6i1TeHvH31GpzOI7ztY4VDDUqSR5PEx/bmAuJYHYOI5wjhJnC2
         MJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MUSlKvkOwH8xWopj9D/kS0cpNzoRNtE2N0uDLG2wGkE=;
        b=NhMCibNS/axOL89p9SQKT7aDFS9WK7QRq02S7RTUMYeTe3RYtaywBsiK2fSLpmezy5
         tr6pp9qO2DrCsl9cUiLefWS+l6LW4EYAfrzUXHrWrQlVN+YUutNaKzTx+qgvmrjWqKD3
         CmwVmSbBxcCDYtWa4mQM1XS7lLwDpdhlWONkwiIkUr7i3cc+S6eByHlkh+fg0zyIcrrg
         9QrrsMh9O4+HrUSkjSmeRij3fI/Tkbzon9qQpMGJyD76UtD3PmlAev1/lZizYQdVbe1c
         20r9udX/sCcU13eGod08av2h8gl+wtGbNcCCp7yKpo3n6C+HLNMnxd6IBH66P/rqouBF
         NdUw==
X-Gm-Message-State: AKGB3mKNUCqaAhKUDmW6wtTEb3eHRVZ9zZ8zyfIVh60xzGDzFzk+01iy
        hAfnBpbew0MfxBaOJuFEM3+WAg==
X-Google-Smtp-Source: ACJfBot41fYrSHz1r/SZmB1QDnuNzaYJSpU9gn5PvT9+c8m8v5szcmMS6/OaXbzTnyDtToKwH4P5iw==
X-Received: by 10.99.174.77 with SMTP id e13mr13266876pgp.263.1515531026540;
        Tue, 09 Jan 2018 12:50:26 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:592e:240e:24e2:56aa])
        by smtp.gmail.com with ESMTPSA id u68sm30480495pfu.17.2018.01.09.12.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 12:50:25 -0800 (PST)
Date:   Tue, 9 Jan 2018 12:50:25 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 12/26] ls-refs: introduce ls-refs server command
Message-Id: <20180109125025.6c88700e6e00e45822ee8932@google.com>
In-Reply-To: <20180103001828.205012-13-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
        <20180103001828.205012-13-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  2 Jan 2018 16:18:14 -0800
Brandon Williams <bmwill@google.com> wrote:

> +  symrefs: In addition to the object pointed by it, show the underlying
> +	   ref pointed by it when showing a symbolic ref.
> +  peel: Show peeled tags.
> +  ref-pattern <pattern>: When specified, only references matching the
> +			 given patterns are displayed.

I notice "symrefs" being tested in patch 13 and "ref-pattern" being
tested in patch 16. Is it possible to make a test for "peel" as well?
(Or is it being tested somewhere I didn't notice?)
