Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A41D2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 18:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbdBOSxF (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 13:53:05 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34344 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbdBOSxE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 13:53:04 -0500
Received: by mail-pf0-f193.google.com with SMTP id o64so8343900pfb.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 10:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GDx3fLfBXI4AQhmhTjHJoya3+Sh9RVG4dgbn+Y0a0ZU=;
        b=ZHcPCaKcFeKhs2h/bNzPloYuywFQi0gmqpbXxNeiaNfoTvZc7Vq6zXUVefmbb2Rg8E
         /A9F+WiY2UrGF973aJ0DV1Ua1Hzf04Y2/rRQwqfOa1/fMacNDUQjoNCmtnQwMzH4Iuoi
         ihb+CGCe2rSz72QaEqsWdV4tCn9Lv++1gAYjMEt8VkRTpE7cmhsH+KVK+lE/ZTBsZen6
         ARx3UiusATGIGINWefH97sCBiRQ9p5/gDXvqOcSYwxMYo5mgxDvPjEfwdjF8Oswc7jP4
         O27U/Qjzcvszx2efNXAQd5adZfn+5qEq8VFeGs/q7BS46eIsuMjatUoY5n80CPdQ0k3X
         IEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GDx3fLfBXI4AQhmhTjHJoya3+Sh9RVG4dgbn+Y0a0ZU=;
        b=TZh0oGRWKULq2/X3PO43VHDF5zuuulyaLT0Tay8a+DwJpNpLIHHJMfuIdSAd9bykPy
         EpzOL3U/j5KU/eVXJNLhMimEWWjpTOfOXwceuGsmx12OsDXn69/Arjq2ta/NpJzrbYTR
         iaveCBmBvpNBG85NEXqiyUdp8AYBBS8OWYeXFp+j/3/0PBEAttWL0b2jVdGH0lqU8ZoY
         9DjIbtp/h94VjveSsPrn1zojQILhSolY1WkyfSgsxeaJIoTs7ZHWTMxoEEUOn9dY/ZtK
         tIOf97iVXJSvnWGLIWF/2tgNXWO41CuHhEGE15ApqUwMt04uqXJsNbRmspKigzh45Zro
         5oXw==
X-Gm-Message-State: AMke39k4OKF/8RGteLmsHx4WbFFxqTY/L4ORzV9zwodEoTW5qd3ZGtlJsJ6KbhC3AcPSeQ==
X-Received: by 10.99.136.198 with SMTP id l189mr40046017pgd.45.1487184784061;
        Wed, 15 Feb 2017 10:53:04 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id z74sm8907685pfd.70.2017.02.15.10.53.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 10:53:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [BUG] submodule config does not apply to upper case submodules?
References: <20170215111704.78320-1-larsxschneider@gmail.com>
Date:   Wed, 15 Feb 2017 10:53:02 -0800
In-Reply-To: <20170215111704.78320-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Wed, 15 Feb 2017 12:17:04 +0100")
Message-ID: <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> It looks like as if submodule configs ("submodule.*") for submodules
> with upper case names are ignored.

This observation is surprising, as the second level in three-level
names like "<section>.<name>.<variable>" is designed to be case
sensitive.  A code that uses the config API needs to do extra things
to cause the behaviour you showed, i.e. to get submodule.U.update
ignored while submodule.l.update to be honoured.  Perhaps somebody
downcases things too aggressively before comparing?

This is worth making it work as expected, needless to say ;-)
