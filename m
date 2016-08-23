Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522441FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 22:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753490AbcHWWNN (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 18:13:13 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:34644 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbcHWWNM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 18:13:12 -0400
Received: by mail-yb0-f175.google.com with SMTP id d10so55520877ybi.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 15:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zB0K744Cc3yH7wvzsgGwzE6OJ5h/8DNosSShdxHhKt4=;
        b=sGlkdwQV9Yrvhobo3ITJnOSj1jOk1HvwOr2zQMyPpqAYH5E4HbEyXCm94fxvKJEX8f
         F3twnyOEEvw57l06hxNClkpJVC6WbnZIcO8P2tpDQcNYYjsUIMVY7nu696PbseyJTc5H
         0MaTm1DrOGzXLuMqwk+Lj8K1kfFxh/qtlsN0pHujxoWMfV78gsLSCN3bPaBGlCywXFT8
         bXFGelWZ6/QSUS+P1FBHBkqyfH0v1+j+0K72z5VnvGsslZbTeVNrR6AEPlJzxJxzPqHz
         VY4KPRO6CYcf3rbr8+mkhZVyWo3CpGs5rbb0+0GnvO55+x8Of8eSuTyeLZkwOHs82dAW
         QbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zB0K744Cc3yH7wvzsgGwzE6OJ5h/8DNosSShdxHhKt4=;
        b=cU0Q2e4I+caLvQs2JuBpTuyNZL7HGgcYx+t3TsyQu8uUmgbcrrO+6n3fihSEBs4/Pa
         I9arp8NMg+nV7BedPvtDkJKrkD5aBHIxrYNCYuPiXD9VE3qFZQkJm/O8yO7tlc6EfqeT
         u9Hdqh4DbxKxon2312mGUZsQ9DRDGBLVBwQT0vSBs9CSI9MUmGU47C0ORlKrkUbs1m22
         hVA5zHBhpv4B29jErGhS6ELiZMDcL9wpb7Qp8+nOwzBroQ3ihfHgU1/CQNUsy3UQ1DGJ
         BAsy8BOt5voA+3xk0KMybbiRk8iO/SAUBicstXusOuTDUEJdm7sk5xud4/YZyA/7IZqD
         +14Q==
X-Gm-Message-State: AEkoousfQoRp/fHl4AR5zViRYODZh5gTW+UOc3tuE2skZD5IJqUoDPddlye2VCsWPIci6zZrvBQcuPNkB8hKMg==
X-Received: by 10.37.19.132 with SMTP id 126mr13346589ybt.113.1471990391993;
 Tue, 23 Aug 2016 15:13:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Tue, 23 Aug 2016 15:12:51 -0700 (PDT)
In-Reply-To: <20160815215327.15682-4-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-4-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 15:12:51 -0700
Message-ID: <CA+P7+xrorjJvOe=y9dipxgvTtVTVp98jz3ubCkmCMUfvAcf7xA@mail.gmail.com>
Subject: Re: [PATCHv5 3/8] submodule--helper module-clone: allow multiple references
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2016 at 2:53 PM, Stefan Beller <sbeller@google.com> wrote:
> Allow users to pass in multiple references, just as clone accepts multiple
> references as well.
>

Straight forward and reasonable change.

Regards,
Jake
