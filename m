Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C7A1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 19:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfAPTR1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 14:17:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55459 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbfAPTR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 14:17:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so3219783wmc.5
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 11:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6DCgi22Qo8IZ0TzemBALuj9OLjyYkppnIziKXj+GJMg=;
        b=O6YGIimnOMgdLu0k76egQjRVGB0ZnAR7cNlMIeW5ApIz1KUMpjLQDmR3mMpwO5YRMv
         aPj0XBsWvSuc0AqXwFG1q7LgxD0pnwchCY3464gh+8BYp8r93E9uEG9xlkCxpIxE0EtE
         6xDl4nyEwq45tWfRMaPhQdxqDsUsAAN8ZU4v/Yw5QhEPm686yImTv3RrJAaiiwnuTR6W
         JsWm2UJ/Wyc0A+3B+mcxCzs0IFGogQ9E/BFNlOk/rWojBPH3Ur69gIzeC2Mbx1DaW7v8
         RuchIIZC4Ugz/0pXRFiV7ibL3ujU2/ov5q0WUXmfWfRjWezh3ctcPz9wkuwBYjRJUdt3
         fJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6DCgi22Qo8IZ0TzemBALuj9OLjyYkppnIziKXj+GJMg=;
        b=LRlV2befZN5ZVOM34dDVnx9umT+DmOymbKb1zdehh9KlL4ei8879fcHx5tYCaL5STK
         pNrnaICwj3ix48IcPd+aZSufW1ESj5H8s8Nj9lx3HG27GbuOiLpdApbuqL/G0WdXXuBh
         2qwV1NBGAgeunwxCWtK73MbJzXg/+TImBJ2AW19ngfWPJUBMUrUMuAPY5FKNxdTKAaCv
         bBOtYoie+8tkPZBoD7hUL+NolbpxuD2SnaTdsTw69Iyci/f8g2WypRfypid22INTZTeP
         W2iMnn5UGaZtgfvB1B/4IvPg/XSeAjG9LG/Q7C1lwFurA4vjqpYcOiqYYRxTmbC49Tv7
         y+Og==
X-Gm-Message-State: AJcUukcV/qlEWq2Geqca3tu91+W2aVow4o2Y7SdpPjN3I6gVKWxnUT1K
        tB+Vds9IH1kcn5NLEWmtpY0=
X-Google-Smtp-Source: ALg8bN4s1Lefx3YNNcwBgpibeCPGectYvmWockoemlcsaPjZesv4dpyilgg9rUlkKk+oxpxVWZ03IA==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr8887544wmh.118.1547666245157;
        Wed, 16 Jan 2019 11:17:25 -0800 (PST)
Received: from szeder.dev (x4db4a994.dyn.telefonica.de. [77.180.169.148])
        by smtp.gmail.com with ESMTPSA id u204sm61700029wmu.30.2019.01.16.11.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 11:17:24 -0800 (PST)
Date:   Wed, 16 Jan 2019 20:17:21 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] sideband: reverse its dependency on pkt-line
Message-ID: <20190116191721.GH840@szeder.dev>
References: <20190116103438.GG840@szeder.dev>
 <20190116174319.251432-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190116174319.251432-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 16, 2019 at 09:43:19AM -0800, Jonathan Tan wrote:
> > On Tue, Jan 15, 2019 at 11:40:28AM -0800, Jonathan Tan wrote:
> > In the last couple of days I noticed occasional but frequent failures
> > in the test 'leading space' in 't5409-colorize-remote-messas.sh' on
 
> Thanks for checking. Junio noticed a similar thing and I have replied to
> it here:
> 
> https://public-inbox.org/git/20190116003828.64889-1-jonathantanmy@google.com/
> 
> I'll try to ensure that this issue is fixed in the subsequent version.

Oh, indeed, that must be the same issue.  After I bisected the issue I
only paid attention to the discussion of patch 2/4 in v1, and
completely ignored the replies to the cover letter.

But I'm glad that --stress makes itself useful :)

