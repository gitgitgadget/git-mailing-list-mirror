Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92B3A20281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031252AbdIZXid (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:38:33 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:47983 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030538AbdIZXic (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:38:32 -0400
Received: by mail-pg0-f52.google.com with SMTP id d8so6761098pgt.4
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 16:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9U/waUsOTNYJ4lilevjkX92XCBDPGDy/HIV35YrT1hs=;
        b=neko7NVpiNSN6FlGowNuGvG9NJ75U9/PTuUwABWLftqszL2KaXjfDHmgan4+esdI/N
         LUOBwvCge3Tx9NA+Vq3OoE0iCfV876ffkC56KQlNsRPjqTzsmPOeMnb35647SZoy61nZ
         qUckb5kenlaZPwdldAhstlxo6zYmy8XydVAajxi3knTUOR7vkeCGh3VfcQmndMpm+wNW
         3HcOe1iSf3ueblBCx/kPbQl0W90WtTvm/dQ5KgQF9W9zebadyrTCAKft4mnqZlBtp3Am
         VeKUEdLA3CSaqg5t1rO3FJzQ10BPqyu+7LZWCahcc9rnYHYqJpioFPuaD2wmXXie+PcL
         GaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9U/waUsOTNYJ4lilevjkX92XCBDPGDy/HIV35YrT1hs=;
        b=stbRGuwopYRoPK6x7PkdBcBArlaNt2FZZ6YiAx+0xJRFZepG9m4eqNti4CkaeMVuIB
         bN5/QPZGqavaFFqRfWfmRb0UctC7sr6o7QIpPT5W5+bGVbOq/ueSkOCGdwBAkmOugWmm
         Qtd4Sy719Y6ZO2TfNOLLrTMgoXZbSbiGZ27MoDFyyRSeKVbKpm28Pe4TYtnAzMpKgCNF
         tE2xw6CU74rm3htrPHVGn7pP5EOWJpMsyAjQk6o4oFa/HncisO01dhkQ2/eCXmkErPvf
         T3Iwu6VUtoE26vyzQOkukFGnU01+xa902aPwlkzWsiM971DP0XQcMI0GPAK9Eg8VDIpy
         HfWw==
X-Gm-Message-State: AHPjjUhYdCt6aMfoKdTc5aqRijU1Dhv90yipZDdN8tWr+jjvtUaUTK2Y
        xONmKc2vJZr+xJ0IC8hv/28=
X-Google-Smtp-Source: AOwi7QDQHGuPz1aoBxNrTmTyHyVBh96//yo5UzeF/NwcDzSBfO8nQko+pXo3oNelUT8VWbT5L5z5uQ==
X-Received: by 10.98.163.28 with SMTP id s28mr11991880pfe.310.1506469111922;
        Tue, 26 Sep 2017 16:38:31 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:adf2:1b4a:4806:c4b1])
        by smtp.gmail.com with ESMTPSA id t17sm17191999pfl.61.2017.09.26.16.38.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 16:38:30 -0700 (PDT)
Date:   Tue, 26 Sep 2017 16:38:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     johannes.schindelin@gmx.de, bmwill@google.com, david@lang.hm,
        demerphq@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        jason@lakedaemon.net, jonathantanmy@google.com, peff@peff.net,
        sandals@crustytoothpaste.net, torvalds@linux-foundation.org,
        Jonathan Nieder <jrn@google.com>
Subject: Re: [PATCH] technical doc: add a design doc for hash function
 transition
Message-ID: <20170926233827.GC19555@aiede.mtv.corp.google.com>
References: <alpine.DEB.2.21.1.1709262356360.40514@virtualbox>
 <20170926222558.22418-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926222558.22418-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> From: Jonathan Nieder <jrn@google.com>

I go by jrnieder@gmail.com upstream. :)

> This is "RFC v3: Another proposed hash function transition plan" from
> the git mailing list.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>

I hadn't signed-off on this version, but it's not a big deal.

[...]
> ---
>
>  This takes the original Google Doc[1] and adds it to our history,
>  such that the discussion can be on on list and in the commit messages.
>
>  * replaced SHA3-256 with NEWHASH, sha3 with newhash
>  * added section 'Implementation plan'
>  * added section 'Future work'
>  * added section 'Agreed-upon criteria for selecting NewHash'

Thanks for sending this out.  I had let it stall too long.

As a tiny nit, I think NewHash is easier to read than NEWHASH.  Not a
big deal.  More importantly, we need some text describing it and
saying it's a placeholder.

The implementation plan included here is out of date.  It comes from
an email where I was answering a question about what people can do to
make progress, before this design had been agreed on.  In the context
of this design there are other steps we'd want to describe (having to
do with implementing the translation table, etc).

I also planned to add a description of the translation table based on
what was discussed previously in this thread.

Jonathan
