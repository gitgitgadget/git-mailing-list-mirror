Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB6D1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 18:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfA1SSX (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 13:18:23 -0500
Received: from forward500p.mail.yandex.net ([77.88.28.110]:58981 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbfA1SSX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jan 2019 13:18:23 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jan 2019 13:18:21 EST
Received: from mxback19j.mail.yandex.net (mxback19j.mail.yandex.net [IPv6:2a02:6b8:0:1619::95])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id C6CD694004B;
        Mon, 28 Jan 2019 21:12:01 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback19j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id aQCsRPQcSF-C0viMsLY;
        Mon, 28 Jan 2019 21:12:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1548699121;
        bh=rFauTmxocgN+cXvAQ5L69HF/tgHXHwqaqVRhrZAIf1s=;
        h=From:To:Cc:References:Subject:Date:Message-Id;
        b=ZecY9lYYrhe3y1+Cce24g5SPpy0wXw4aCga5FdMrYwbD4PL8hYbWk+skNCd0KqREY
         JUa3eQbI7Fcg2RtacYlHF5l0UKMLltmmHj0bQ5AdsL878zw2dAlYDc3zohUO9/QxKU
         2Xmz0b1NVz96BiBklHRiRkh4rCh10HC3WzI8Yx58=
Authentication-Results: mxback19j.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by myt6-27270b78ac4f.qloud-c.yandex.net with HTTP;
        Mon, 28 Jan 2019 21:12:00 +0300
From:   Sergey Lukashev <lukashev.s@ya.ru>
Envelope-From: lukashev-s@yandex.ru
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
         <13169311548590123@iva1-16f33c6a446b.qloud-c.yandex.net> <20190128160944.GB23588@sigill.intra.peff.net>
Subject: Re: unclear docs
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 28 Jan 2019 21:12:00 +0300
Message-Id: <1593541548699120@myt6-27270b78ac4f.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you. Does the paragraph about core.eol refers to the text attribute? It's written 'property' there. I was thinking it means whether git thinks file is text, using .gitattributes OR otherwise. Maybe changing this word will make it clearer?

28.01.2019, 19:09, "Jeff King" <peff@peff.net>:
> On Sun, Jan 27, 2019 at 02:55:23PM +0300, Sergey Lukashev wrote:
>
>>  Well, I have two problems:
>>  1) The endings I get with core.autocrlf=false depend on whether I have
>>     * text=auto (a file was commited with LFs). At least in git 2.20.1
>
> That sounds right. The default is that Git will never touch your line
> endings (going into or out of the working tree). Turning on the
> "text=auto" attribute for everything will tell it to start doing so
> (according to core.eol, which on Windows is CRLF).
>
>>  2) If the quote holds true then autocrlf=false is actually "true" (for
>>     output conversion) on Windows by default because default core.eol
>>     is 'native', which is CRLF. I believe autocrlf=false is supposed to
>>     mean "no any conversion, input or output, read or write the repo as
>>     is".
>
> No, it only means "do not use the autocrlf feature". If you've
> separately configured text attributes, it does not disable them.
>
> -Peff

