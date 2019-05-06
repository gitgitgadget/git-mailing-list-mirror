Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2C7E1F45F
	for <e@80x24.org>; Mon,  6 May 2019 18:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEFSZI (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 14:25:08 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:34598 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFSZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 14:25:07 -0400
Received: by mail-pl1-f179.google.com with SMTP id ck18so6789746plb.1
        for <git@vger.kernel.org>; Mon, 06 May 2019 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WuKgDBcLZ47dAd+OWticQ/b+kdR5Ymio4MlTyOLcRYY=;
        b=tMyFhaN/ILgziQU9vxqS5oOGiVNJzHLlA1lN7r5sRMTyOBpMDpojAoYX5wOFv3qrnn
         VC/1GzxqHEqSD+/X4ygYB03XRCbLR6wqGEdRqDP2vhottjYEuUJTgp0cs1Ms67n19NY7
         o0akNsqlcClbhWhAPgqQkyry4o5uCHGZIKI/pBLlzGJ9XcDrj19Ugko/q1uOtMQ/RLf3
         EGAvthuaxKmNO0VUxxz+IOXqwgN33jMV5dl09NH1NLWlIrWWZmiNJXz2gBuiy3K3VHFr
         GpV96JvoDk9J7BiOaRV/MUyouZ774GOqabGhKgCfOop7OTfcE328tkZdplytX8bdL2Ui
         je7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WuKgDBcLZ47dAd+OWticQ/b+kdR5Ymio4MlTyOLcRYY=;
        b=B9bv2FeavypAcFXhrOlAQBGlgpwY9XjycngRkp8SCyH+9pnefLIAX8nemTuBREy1gy
         9r6sxdft0cG+woWm69DTxnLebWzNjVWY8zpBOS5fhrohPVyEFFJWKJQm5maT2zQLcaex
         T1q7HiBXUXR/uLOW/NysE9rH7MxB/9dnyd0QAJxqL3mnUsxfDlWzoLivETFiDtI++oqf
         67+1/rtUmWAByTO7Pb1dlFFt+Wnq7N7mTlAtHtFLsDUiyYDUewtWVS4FS7AMkiHJ6HOu
         D2sHXZd8MPBtF85iVcl46k7rnV01xE1g9wlpkojjVu2zr5TPIuRqTL7UsfFIE7GDhg7l
         UPAw==
X-Gm-Message-State: APjAAAX8VcVpZ+37e0NB2uTTV7YnSUD7Kp1p+tibIUJJmjfbtuOrghvL
        QLPcwR4RltwIdqZ98zmIo+Q=
X-Google-Smtp-Source: APXvYqwK54JJqMW2BT+yQh7Fp8d3lEVh/C8gHjEVjI2ZeoS+upCbYOCn8N1oH7ToPkwaZd1Nlu24xQ==
X-Received: by 2002:a17:902:a01:: with SMTP id 1mr33913943plo.36.1557167106878;
        Mon, 06 May 2019 11:25:06 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id u66sm14682614pfb.76.2019.05.06.11.25.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 11:25:06 -0700 (PDT)
Date:   Mon, 6 May 2019 11:25:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Proposal: object negotiation for partial clones
Message-ID: <20190506182504.GA57368@google.com>
References: <CAMfpvhKYRVwTVNLfRJYcjhHtg=FNLNPbnw8xtY93nJu228v6=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMfpvhKYRVwTVNLfRJYcjhHtg=FNLNPbnw8xtY93nJu228v6=g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Matthew DeVore wrote:

> I'm considering implementing a feature in the Git protocol which would
> enable efficient and accurate object negotiation when the client is a
> partial clone. I'd like to refine and get some validation of my
> approach before I start to write any code, so I've written a proposal
> for anyone interested to review. Your comments would be appreciated.

Yay!  Thanks for looking into this, and sorry I didn't respond sooner.

I know the doc has a "use case" section, but I suppose I am not sure
that I understand the use case yet.  Is this about improving the
filter syntax to handle features like directory listing?  Or is this
about being able to make better use of deltas in a partial clone, to
decrease bandwidth consumption and overhead that is proportional to
size?

Thanks,
Jonathan
