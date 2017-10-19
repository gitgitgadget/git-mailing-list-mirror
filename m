Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41F0202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 20:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbdJSU45 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 16:56:57 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:51619 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbdJSU44 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 16:56:56 -0400
Received: by mail-qk0-f182.google.com with SMTP id 17so12022882qkq.8
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 13:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6+yeC7ddBidtJyk4w0Jp2+ynE5qvb1ZIlFv3K20AWXI=;
        b=SvZob42CmgId7/VuepjX3U4Zq2zAFzsxrWmze8MK162+bcNq1um8JUsSZmOMWSZsAA
         Rgtp7MD1RbJ0f66ccWjWBdzXXiDJ6pQJmpG8RbRE80l+RtK0/QP2e2sa9RFbA6rgSUAI
         /3zLS+J6g/bJcFg3X9T1MVRbQ1M+8CTOuLBlodr4l/pFyzGlYJqAM49/GJ4vh1jn/Gp9
         DcbM2m0LNZTV/pgKJToWm/xdraS6s5sE2p7k8ZOw0gMU4tSiRVFTACPDV6UCpcqKEbcy
         uxLNp8sK36YhG7kdJieWQfw9cNua2krJxqSChYEORFfCMb/flEe2hzXsRNMMJcSzk+oa
         0Khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6+yeC7ddBidtJyk4w0Jp2+ynE5qvb1ZIlFv3K20AWXI=;
        b=tbXYjKwysLBH+qPjBklrXdptSH5OTbtGvt8ujpiLEwzjJ7VGeBx5fG7wFcwWFBRjib
         +2mHTksfRkwazXEyGzwepvdNdZ2f/wuFnkN1DWnMav/XE9RRB6nVgqEqcnX+4nZWzkdD
         PkFfH5k/egWOLr0BWpq4LK7zo/mQtvGsEzxg+TYjhfQ7qZ0uxpy3QnKaQc49Rfusp7fc
         shNZWgLfkUJsYpV8+90z05oOO44J+1tMM1+tbKSfsrz/ADBuXkGrvUV40iojkQHSXbRh
         usKL5wVPgrnSQDZOJj+rknqVgpbTLdnc9TvCjRvW9wj+WMwostCWMSk/uor/DEUVZqfr
         Zu4A==
X-Gm-Message-State: AMCzsaXfv5qj27b7IcdR9TnA4+PI/5MlDfaLilzjdDpFP3yhA/+Z1KRZ
        +ApEaQHZgtDA6PQWe8FKIa2PhiITMfO1KHMnG7kg4XEe1wM=
X-Google-Smtp-Source: ABhQp+SdB5F+vwIJLujlR0VhPQ2o3lG2OYszDn7K+Pp45bpOgbGaonAC6GR3vXLuaUBGTml0lykSE9mh4rZMULAdygM=
X-Received: by 10.55.129.70 with SMTP id c67mr4011636qkd.230.1508446615744;
 Thu, 19 Oct 2017 13:56:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 13:56:55 -0700 (PDT)
In-Reply-To: <20171019202403.7srcpos5xlsvmqrl@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net> <20171019202403.7srcpos5xlsvmqrl@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 13:56:55 -0700
Message-ID: <CAGZ79kahYb5=BEvr0io-bSJ+JaOfViicyghH4CtRErqmtAXU-g@mail.gmail.com>
Subject: Re: [PATCH 1/5] t4015: refactor --color-moved whitespace test
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 1:24 PM, Jeff King <peff@peff.net> wrote:

>
> +test_expect_success 'clean up whitespace-test colors' '
> +       git config --unset color.diff.oldMoved &&
> +       git config --unset color.diff.newMoved
> +'

This could be part of the previous test as

  test_config color.diff.oldMoved "magenta" &&
  test_config color.diff.newMoved "cyan" &&

in the beginning. (That way we also do not pollute the setup,
but keeping it test local).

With or without this nit, this is
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks,
Stefan
