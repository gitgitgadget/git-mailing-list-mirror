Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8E331FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935025AbdCXXwU (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:52:20 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38757 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934843AbdCXXwP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:52:15 -0400
Received: by mail-it0-f53.google.com with SMTP id y18so5363732itc.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 16:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Dadbo83wWhM1xCK4O6xL2oKVatXx0SImpIE3iFWe6s4=;
        b=i0s0sQquzDEAy+bQxx7hbPqNvRuwejboMUxGfVcmqAdXkoCgIehgO2Zb9a8q+Xy0Ca
         qcBAcSSxBsOe68vTUQlt55uEvi/u6cJTpebyrImGM2LYEmkhc1F37+T31yW8TQ4Sy1gG
         fP7gh1VDV/c9enT9MVmivFoCp6HLan0mc4ZF3LMhSBk4M7l0Xn1huH/Y80eWsZbSa/DL
         7q4pFOPGUVLVORxjGV8ZYtm+XXtoP50AXIJyjrhuPcx/H1Xfxc9/J1JEWfIaqh/c2N5l
         tyu7YTWpTwpriKC95M+uDVdPafHL6IEo8w/xglDtI4F11QHH3Zjj2kMNj4+uOFYsO9Ng
         AG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Dadbo83wWhM1xCK4O6xL2oKVatXx0SImpIE3iFWe6s4=;
        b=rTk5jn7c+Wck97UDnFUti0i/ZLd/2LjlGsX9j9bXDvU+1vRwcgmLt+UEPi2cj2n8Et
         h9093k+34L+9oOrtatJEi+JgeJ3H9mwGoAw8oyCMtiKnxQhJSS+YKU6jxdyDlUFdgP9A
         NzDhY6xthVtYI7x9CeJBU59vsbVUXmcVyF05auTy5sRiO5yPzZbEsmgKfO7xNxxrEn6r
         mIpWcnPg3YDqxX0RaxOcBdGZi3uZMGVLHC1drFUncCSdDSIajxyOI13MoXsR41wNmqa+
         TOEmlhTXjmSIuMAOKRFcI5uA864cElUbCcUdeFHpV9h/JUqfuA4mQWtz3AkanTYJj6Hr
         mgjQ==
X-Gm-Message-State: AFeK/H11M1Mo8CxnDdZfG5Yq4d7wEeykg5q+pDJYZ5YtUFs0eKyX7YP8z/+68a6ZiVNOyBnnu4pCj/2lbTGjYQ==
X-Received: by 10.36.29.66 with SMTP id 63mr5236363itj.91.1490399533253; Fri,
 24 Mar 2017 16:52:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Fri, 24 Mar 2017 16:51:52 -0700 (PDT)
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 25 Mar 2017 00:51:52 +0100
Message-ID: <CACBZZX6F47uC9jLxppgkUnwVpGV2jpzzP4kwTuqKgayCevomeA@mail.gmail.com>
Subject: Will OpenSSL's license change impact us?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They're changing their license[1] to Apache 2 which unlike the current
fuzzy compatibility with the current license[2] is explicitly
incompatible with GPLv2[3].

We use OpenSSL for SHA1 by default unless NO_OPENSSL=YesPlease.

This still hasn't happened, but given the lifetime of git versions
packaged up by distros knowing sooner than later if this is going to
be a practical problem would be good.

If so perhaps we could copy the relevant subset of the code int our
tree, or libressl's, or improve block-sha1.

We also use OpenSSL for git-imap-send, AFAICT with no fallback other
than "don't use ssl" or "use stunnel".

1. https://www.openssl.org/blog/blog/2017/03/20/license/
2. https://www.openssl.org/docs/faq.html#LEGAL2
3. https://www.apache.org/licenses/GPL-compatibility.html
