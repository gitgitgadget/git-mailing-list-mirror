Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFCAE202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 17:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbdJYROD (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 13:14:03 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:51988 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbdJYROA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 13:14:00 -0400
Received: by mail-it0-f50.google.com with SMTP id o135so1893058itb.0
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M+41Lu0f+lQ4L2UQ0SNruRMLhhO1SqudTFn8spcxNn8=;
        b=blogFxvZQhVfNXvppEEMO75rnTofQFgusNKwhkXy3oiR1OpEf+kb28HMVGT4d65qhn
         rQyxmZhYJ4swhiMNEVlMR2ixuwveYX4p1nqRem7h3JosZEgIyu+Rn4ISyHPEmwl/SNYF
         e6ZF1iKYMQBnk8fywjHdkSuH5bpz1DEdBRmaXKl0upA705er8Q8/WqB3EEIYmlKgexNp
         LZAbQsxqvqRetBpR2abyyc0yY9r6TsZs89/FEWaVHeQT3WUXwJYckYxssNYFDh7bdOkW
         d8/hWAbQ2g4RGFY9Op8KUuDIGCVL3MO6lB73FeWc/Qoq14080gTMIVayUdXb/PBqt+gg
         PAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M+41Lu0f+lQ4L2UQ0SNruRMLhhO1SqudTFn8spcxNn8=;
        b=P16hvEBeZeucqT4EkjN0MjqAbbaJK1xLgEj6k3A+nt6Qv/2qtFI4qs3olrDKzYmW7K
         fel+Lav0PxsngC5JCvCH9inEtP5CO5QCczo8xv/Ew6Jiaj8nmEh4KrGwLzrJCmeznJ2O
         evoRAhbZh1PhNBhVb8qA3mGeIZKBr/SB9lPlx/uCw9nUMaQdD61mW4n9Y9neuiCiBQ+4
         5HXKIiCWVJSR+ukjPH47n2jK1l7ImmCvH/uCwW1Q7KqOcB/rf+O1QUKnTpfH205dK96Y
         16mswg/dfnyfyc0IhgnuxH4MLNnSFWKlqeCvZOcAXLK/RpG515/86Au0cST7yEVcljZ2
         EmZw==
X-Gm-Message-State: AMCzsaXc5Kg8MhnU0eaXkLKJEUm73I0Iy3B9ptnoY2K8ZGodRyHlC102
        t0yd9lDAP3qMarVB2MUiUCUBF67H
X-Google-Smtp-Source: ABhQp+RjBYpBJtRmjLlqmt7ktaQGkQLg8ioe835RE0pjeggkXH/oK5FxScvmqWDeIDSzjE2qL+DiJg==
X-Received: by 10.36.200.138 with SMTP id w132mr2964438itf.24.1508951639877;
        Wed, 25 Oct 2017 10:13:59 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i201sm1545393ita.32.2017.10.25.10.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Oct 2017 10:13:59 -0700 (PDT)
Date:   Wed, 25 Oct 2017 10:13:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Consequences of CRLF in index?
Message-ID: <20171025171357.4nk4aj2c4m4b6kl3@aiede.mtv.corp.google.com>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
 <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
 <07309D89-F536-4DA8-9214-B605007845C6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07309D89-F536-4DA8-9214-B605007845C6@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Lars Schneider wrote:
>> On 24 Oct 2017, at 20:14, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> In any event, you also probably want to declare what you're doing
>> using .gitattributes.  By checking in the files as CRLF, you are
>> declaring that you do *not* want Git to treat them as text files
>> (i.e., you do not want Git to change the line endings), so something
>> as simple as
>>
>> 	* -text
>
> That's sounds good. Does "-text" have any other implications?
> For whatever reason I always thought this is the way to tell
> Git that a particular file is binary with the implication that
> Git should not attempt to diff it.

No other implications.  You're thinking of "-diff".  There is also a
shortcut "binary" which simply means "-text -diff".

Ideas for wording improvements to gitattributes(5) on this subject?

Thanks,
Jonathan
