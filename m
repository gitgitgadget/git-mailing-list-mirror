Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2659C1F404
	for <e@80x24.org>; Thu, 26 Apr 2018 09:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754536AbeDZJn2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 05:43:28 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:53362 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753942AbeDZJnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 05:43:25 -0400
Received: by mail-wm0-f46.google.com with SMTP id 66so11730297wmd.3
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 02:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XGcWThru7JZVz1iMKs1iqUL5JDUoXoQfYX2ws3/9r6w=;
        b=C6I+KAUZKmujcvC9GDnE0vt+DyieOoMkbZct+tXVkRN5xs6A5Z1/fja4Ny8ZGCYJO4
         mH88HkdA58opCJAtVFKvEs1G2CDoczG4gDSl/aghfEWOq8Ru0VfnWJvb3gf9wtQhZhwy
         b4xYIvQQoupMKaiYcPiRe/fSzzUQsuj1yw8o2TrxCZ9hCOUZDX1Pk6Tv7+k9s7kLz8cJ
         R0FCurkgODr3hxlNOA+LiDDM/7kEMHhutRpAqU0I3jugfOYFd3xhqg2qoKmuU5l4AYpZ
         Nopa9tz81MREE+6Vyd71o50nzjK16Dx1ww+Nt+IJmkxK3M0sGl7CBKmvh3BTwnAraInB
         TcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XGcWThru7JZVz1iMKs1iqUL5JDUoXoQfYX2ws3/9r6w=;
        b=GOioOiPVzEDkK/XHfJatW5tfxEBorlg/oC+2tPv+WTWC1bZJIUk6vO3gFQTBpKpFJh
         ZM10UKehT4BP5fZ9e5pNRiUr3KqsDtLWAFAVEsJZ956MYsxkvfThB+Hu6CzQ6P8k9Pmk
         +N3GLcH9sLeMfq2z27twmj4Fijx1Dw8TMG2oXwxaTgSN7ys/Ygm9UQDQmPlGZa97hjOu
         kG+oEd1GA8tkxPFVUmEXmC2gpsAmERCHj8SB4w75jeuggNB0YtmEnZW6wlsiZGNcxH7b
         BLO8eWfabZ/L+swtzQtnXQ8ac5Bke8E8fQPhWfgP1be0OV1bG527KagVm/XeP8/g5HL0
         n6Aw==
X-Gm-Message-State: ALQs6tCfKHWjXf/7DEh5xGImExxLS2IftbayRT6YvNbMnVvYWbBDuEI6
        YLS6+W3PhkHVmh8jkCBvNRE=
X-Google-Smtp-Source: AIpwx49Y6sIjgHWWdWg9hvDwhgamQMMi3BloPFD+0Du7E+LphsLc6un5crB1fBIJ5KHrUbB/hfDOXQ==
X-Received: by 10.28.175.75 with SMTP id y72mr16119583wme.148.1524735803336;
        Thu, 26 Apr 2018 02:43:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s22sm16958307wma.45.2018.04.26.02.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Apr 2018 02:43:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] enable userdiff for more things in git.git
References: <20180426075058.9322-1-avarab@gmail.com>
Date:   Thu, 26 Apr 2018 18:43:22 +0900
In-Reply-To: <20180426075058.9322-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 Apr 2018 07:50:55 +0000")
Message-ID: <xmqqr2n21ex1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> A noticed that git.git doesn't have userdiff enabled for perl files,
> and looking over some recent patches this gave better results, while
> I'm at it add one for Python too. I couldn't find anything in
> gitattributes(5) that was worth the bother of enabling this (e.g. we
> just have one Ruby file).
>
> Ævar Arnfjörð Bjarmason (3):
>   .gitattributes: add *.pl extension for Perl
>   .gitattributes: use the "perl" differ for Perl
>   .gitattributes: add a diff driver for Python

All looked sane, except one minor "Huh?" in the titles.

The last one in the above list makes it look as if you are adding
the func header pattern and/or textconv filter for Python source
code, but the patch actually just specifies that .py is to be
processed by the existing diff driver meant for Python, and at least
to me, the wording for the second one reflects that better.

