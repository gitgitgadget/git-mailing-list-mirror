Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075051F4B6
	for <e@80x24.org>; Fri, 19 Jul 2019 21:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388403AbfGSVCA (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 17:02:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43341 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388398AbfGSVB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 17:01:59 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so61189819ios.10
        for <git@vger.kernel.org>; Fri, 19 Jul 2019 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5zPWLKzP0SVdSA/dVc47Rb+L8czi3KG/Z5jSQdn5oZc=;
        b=UQHoQz9R3cGZXNj2BPscAFWxu/mb5Ah3Bc3tiF/ByXeOufZypSRytDEXFKy1iuWZKz
         FrgajsFP63oS5tdPtdlq1dCAPf5ayOIDk6E8UKw5ZWXSuKCWDkt6qgFeZbJb4dbQGbjL
         0BXFru9v/mkMCZhbyK0ioxM+pl5uz8PwnidhmJZyCCQuYjzscUW1vrfyZId/Iev8ahKp
         72rsY/JTK/5/AO6oSlntI+knjvDY4iGXtsVoyF5/X65SIXLT3jXfut42Y2cvjfnLufYI
         kx/Liq96IxnlTuWMPqa1q+5enCVXA4HruC9Exsnwod7YTkco2lM3jLYa4SGKJfjOyBYf
         IxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5zPWLKzP0SVdSA/dVc47Rb+L8czi3KG/Z5jSQdn5oZc=;
        b=mZ8VExrLZRXOOPpMKBhMpevUo8pdoLcZOQk9f37nRr+fJxbUXULdxRjoPfj9KIzD2o
         zaJVlczqQ1NUuxx8Gsz20yT8EDXRibgBWK9yeqvQ12V30d13pfh43J2wKWVuFylTZxHQ
         OllY8Qg5mvc1juq4q/y8thK7mVYY2SrmIeC08KUR+8afmwArE1fle8rS3ggjFbD0xxgb
         0GIKOe/DzL6IHI8o+H9qgjnib/T0FP7J8rhtATbG+Z+0lbKPh/aCFSlcKF6ZAJjkEffX
         ctGs5uTIafVj8qbJ/aWtszSvj6Wf+sGVJc4y2+uILP5EVhbL7q/EXjp6YdCH9Jt6Atlb
         P04g==
X-Gm-Message-State: APjAAAV79k9ZxIlS9jtdo6K0cICvVyqjG1QY5v9DTfwHKRU6KtpOfkOK
        yLJwpD2E1U42411kWc12ZLo=
X-Google-Smtp-Source: APXvYqzG9Gt4afXwpK8r0sBkII4oqgzo/G3XyfLP53uqusTk2bWaW40QViBnTumF0d43O8eD6EU49g==
X-Received: by 2002:a5d:9703:: with SMTP id h3mr49575466iol.152.1563570118491;
        Fri, 19 Jul 2019 14:01:58 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-143-63.dsl.bell.ca. [76.68.143.63])
        by smtp.gmail.com with ESMTPSA id l5sm58011970ioq.83.2019.07.19.14.01.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 14:01:57 -0700 (PDT)
Date:   Fri, 19 Jul 2019 17:01:56 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [RFC WIP PATCH v8 00/13] learn --keep-base & more
Message-ID: <20190719210156.GA9688@archbookpro.localdomain>
References: <cover.1555832783.git.liu.denton@gmail.com>
 <20190508001252.15752-1-avarab@gmail.com>
 <xmqqa7fxionx.fsf@gitster-ct.c.googlers.com>
 <xmqq1rylx2dy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1rylx2dy.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 19, 2019 at 12:14:49PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> >
> >> This is a WIP series I have that I figured I'd send out as-is for
> >> comment since Junio said he'd be merging dl/rebase-i-keep-base down.
> >>
> >> So I wanted to test it, and as seen early in this series in 3/13 and
> >> 4/13 we had significant blindspots in our tests, i.e. there were no
> >> tests for whether --no-ff bypassed the amended logic as it should.
> >>
> >> As seen from those tests we may have some bugs here, either existing
> >> or new, needs more poking at it.
> >
> > Thanks.  I am actually OK to keep dl/rebase-i-keep-base out of
> > 'next' to iron out the kinks.  It's not like we are in a hurry to
> > deliber an important fix to our users---the topic is adding a new
> > feature and attempting to fix a minor irritation (i.e. lost
> > opportunity to fast-forward).
> 
> The 'next' branch has thinned down sufficiently that it may be a
> good time to resurrect topics like this one that we postponed. If
> there is (still) interest in them, that is, which I do not know ;-)
> 

I'm definitely still interested in this topic but I haven't had much time
to contribute since school's been busy lately.

If Ævar doesn't get to it by around a month from now, I'll polish up the
RFC and resubmit.
