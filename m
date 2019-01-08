Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A981F803
	for <e@80x24.org>; Tue,  8 Jan 2019 18:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfAHSHc (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 13:07:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33696 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfAHSHc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 13:07:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so5052298wrr.0
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 10:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ytRXY1plVtoNDHEbSwSrc19MO2U8cj/10LsQ8k5Zaj4=;
        b=gD8BGP7jb/0hQ0V7+m+6odZRz1f8zZEPLHLlE5chJZYTYptWWJEuR50LktwGySD+LJ
         AKpZmuLE1kQ1gkWBrr6tpPqP+hH+BJ0W/fIeC/fgGDkusdE1BcH+HrJaEfFeNPvQp8sH
         zve8GfwlYUhuVRFxztSW9iGKAsf25xR6fEgL85eMu4iH/vMqHLXiJJeXbgWLULegB71Q
         4w+wd0+UySuwn5h/zX1wvNdhFMzRyu3LzlVJ3X0Gb6QBGI+Tjai2icoEQJfytshMHhZy
         8eWM5APbMLAsQOJSmr6pTHraRC5BFWgNLKjLa2YqhyC3ymwCmJY2FLdRFWdIFLvCdYVI
         icxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ytRXY1plVtoNDHEbSwSrc19MO2U8cj/10LsQ8k5Zaj4=;
        b=Mq2RznwqlTYEoWZaboZ5bmFSTMjER+mDx8MVRTuxmWrfKP78/kGaIGltrwvKO3hsfL
         j4k2mRtrWhpNIbSGBeKtTzjbHP1aVCyIbxq187SATVjybtrtGpPcWmqstGr40PpL8USN
         JTHwnw0jUOsI6xH+dzVdmxaWNRAQGhTZbstJG8KxOSZlCXYypkUnxG+t9lEmSYkJDLF9
         AvG8Tkpo0WEwMFBy7noG7GjvlcJKs6G5kmP3L9UUZsIWA1sFVs4iO5S4luVLpkqtI8kZ
         Spb6dul4LtAuyQH6aXkvuvQdu5ZGXMNDRIvYfpLrxmEKWpa290PFLMWDBFvrdeSMslEa
         x0Nw==
X-Gm-Message-State: AJcUukfKYbFAmSk7eHVxsnNG2ZZyYwOJH9mh+zMjdpt5HjVK4XIJwDq6
        TUF8+DbozBLREisQU/FF2l8=
X-Google-Smtp-Source: ALg8bN68vAJ5BkLV7R0Q9kB66izpE9e8BObC9CiNTzdBIZzwE54po8RFde5LzzRlnTZ5JZdc9DsCNw==
X-Received: by 2002:adf:f052:: with SMTP id t18mr2376039wro.112.1546970850282;
        Tue, 08 Jan 2019 10:07:30 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 10sm12677272wmy.40.2019.01.08.10.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 10:07:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/11] jk/loose-object-cache sha1/object_id fixups
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
        <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
        <20190107083150.GC21362@sigill.intra.peff.net>
        <b0049722-d019-fd5d-d93d-7b7363b4f244@web.de>
        <xmqqy37v59qz.fsf@gitster-ct.c.googlers.com>
        <20190108180522.GA4610@sigill.intra.peff.net>
Date:   Tue, 08 Jan 2019 10:07:29 -0800
In-Reply-To: <20190108180522.GA4610@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 8 Jan 2019 13:05:22 -0500")
Message-ID: <xmqqmuob58gu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, they should. I think one of them will need René's patch, which
> changes the body of quick_has_loose(). I can roll it as a separate topic
> if that's easier (or just wait a week or so until René's cleanups
> graduate).

Nah, what I got is already good to work with.  Both series are
straight-forward and I do not expect them needing long fermentation.

