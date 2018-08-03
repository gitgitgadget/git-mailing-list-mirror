Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C063A1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 02:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeHCEnI (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 00:43:08 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:45052 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbeHCEnI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 00:43:08 -0400
Received: by mail-pf1-f178.google.com with SMTP id k21-v6so2403837pff.11
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 19:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kgdl4yXYdpRMtAjSK0oxsqJJRH+rpsUQ2rTuj94eeLc=;
        b=edjK+8WvDob+XT4NMW/ms3AVh7oxxbQNFqkyW5FspRmJJqFK7f/3dn/hbbaV6/xozS
         jZslE57qPowLycBCLC3fFJnqZ789mhzvFymIB3Y4g9br8UT6hYNwWB26+2q89YzBfIoQ
         yNwSSvTm2wvgiBNl/UYbEXXxgcCFgB0YaA/iH+y1qpSq3gG4tI/pcFJ85JyGIGJR5fB2
         EOTHOWC7tnkryWxc8/cY6TlY2+UPNx29/Cee0bj8XqyNxRtU0skV9NZi0PZHcDqJfOZT
         +B23Utmr50Rxzj55mRbcw9XB8Hm+mZraLpKNtyWr+Ht3G9dtme6oL/f3LTYhpGLpir3S
         YzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kgdl4yXYdpRMtAjSK0oxsqJJRH+rpsUQ2rTuj94eeLc=;
        b=br/Qh1kXQbucxjhUCc1iBaDxgXDuo81wgC3sEE3wBZQbunEOY0YHnRZmysng5WyYIA
         YBCqbanKI420sjdBSwcXTXuHlm4KVpB58G0l6FgGvjl7oCRmFkuUYBW+fZtPxDsuZ07O
         SHVRVAVYGGkkKu0w3FbFPv8l7+QjWjCU4QgVOu/jNnoKaLwJpCWenPuvkzDAmo7S9zqc
         7Uax530dPYyHbToyPaBZbrcYCO1XvCMVkjSLyL+gwwcSh2iqwnNwMsSBZJduVoRg6rFy
         14a1rYP3o8FvCmBLI1L7lqRZShcvV15KuAxFE9FDZC1nq+3yCLhCVFGOfjO9MnwL8trV
         r6ag==
X-Gm-Message-State: AOUpUlEquY/aV5hDvMmdNpRA2ldFE7LC58LgpvqrX4wRq8rIVcmkq38m
        jfE5Z7vfcurtdVfzRAgvF9Y=
X-Google-Smtp-Source: AAOMgpd1ISHy36spDufFiO34iXQVMh6JfgpAA2MqAiML52codIzM4ZlGryheuzGgeB+leJhWbNqP/g==
X-Received: by 2002:a63:be05:: with SMTP id l5-v6mr1839595pgf.330.1533264544804;
        Thu, 02 Aug 2018 19:49:04 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id w20-v6sm3066063pfj.131.2018.08.02.19.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 19:49:04 -0700 (PDT)
Date:   Thu, 2 Aug 2018 19:49:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Liam Decker <ldecker@indeed.com>, git@vger.kernel.org
Subject: Re: Question regarding quarantine environments
Message-ID: <20180803024902.GC197924@aiede.svl.corp.google.com>
References: <CALcD6sYfcaftciYU+2AHpzabyOS9ohRcZoE6LDuMyht+dxktHw@mail.gmail.com>
 <20180802183924.GB23690@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802183924.GB23690@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Thu, Aug 02, 2018 at 12:58:52PM -0500, Liam Decker wrote:

>> The solution that I implemented was to check the objects directory for the
>> object, and if it was not there, to look for a quarantine directory and try
>> there. However, that feels fairly inefficient.
>
> That's more or less what Git will do under the hood (though in the
> opposite order).
>
>> For the curious, the library and solution I attempted are both here [5]
>
> Just skimming, but it sounds like go-git does not support the
> GIT_OBJECT_DIRECTORY environment variable.

To be clear: we don't guarantee that the quarantine directory in the
future will be where it is today.

So as Peff hinted, supporting GIT_OBJECT_DIRECTORY in go-git is likely
to be the best way forward for your tool.

Thanks and hope that helps,
Jonathan
