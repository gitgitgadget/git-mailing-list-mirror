Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7AE202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 10:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbdJBKGb (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 06:06:31 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:45278 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdJBKGb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 06:06:31 -0400
Received: by mail-qt0-f177.google.com with SMTP id b21so679330qte.2
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 03:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dam.io; s=arbre;
        h=mime-version:from:date:message-id:subject:to;
        bh=GYKzepDlUTdqoeANrKEsIe9UORwUQ3FhzDUKY/Bw+os=;
        b=SfWSlAHi4OlPOWh2qmyxLpYP3s48R15KbQ+0ATCO/nr+CGwo/FERhoUQAHU5fBGLbM
         7JJWTy6IX0NdNKu2q2bI0rrB1WLjHKPjUXEkJwjwL5q9mSeg/RM5LFb4XeWqoXMU9ZRS
         GE6QrkqQaw71sCbrp+UiD8jNXyE7IaGixFUtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GYKzepDlUTdqoeANrKEsIe9UORwUQ3FhzDUKY/Bw+os=;
        b=cRXG+KpqnFtnn0g7zZ6OZOPgQP8QxUKgU/jbRbHe+lnHa4MtEyCHk+C/GtV3dF5yri
         Ujjh6eQRtRPCkeEyIGoKu67g6+4CeVK5SDb4EhmLMkqAkIogDH2d+hSmXf0jXgQ13QSr
         KjlMRwu/UVQMj6JqlRV33y3/rwZ/9RKkx98kPYwIkBvUUV3WNhHc/QoSxPqCDntU45sS
         TUzTxBBPmJcT3k7NblVcu3FPserZ0W0wcH5KRBw0bExvWf40HECs5zxK9sUGc7uEYP3T
         +WUs2QXNjVQcWj2thOkV0l81QTfWGxR88gYVMUeYsDHtavFH7koGXyGWpqAkShWEeyXJ
         pxJA==
X-Gm-Message-State: AMCzsaVawuU/LU4EEwiCz2KjFITBdU2Hx6wrvOVchKwIwo9K0zTR/Bqc
        nju+m6GeNqNcFgWe+S5RSorFvFvP
X-Received: by 10.237.60.101 with SMTP id u34mr17280677qte.153.1506938790313;
        Mon, 02 Oct 2017 03:06:30 -0700 (PDT)
Received: from mail-qk0-f173.google.com (mail-qk0-f173.google.com. [209.85.220.173])
        by smtp.gmail.com with ESMTPSA id o9sm2146837qte.49.2017.10.02.03.06.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2017 03:06:29 -0700 (PDT)
Received: by mail-qk0-f173.google.com with SMTP id k123so1134683qke.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 03:06:29 -0700 (PDT)
X-Google-Smtp-Source: AOwi7QAA2ZqVvwQEBrepXEFH55niFYdpXLp5zgfXOaTIH+p/woR13h8X+FD1ShO57hUP5Z0cUVg+SJMXGJ/8FQYvIuI=
X-Received: by 10.55.124.71 with SMTP id x68mr13089083qkc.10.1506938789703;
 Mon, 02 Oct 2017 03:06:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.149.67 with HTTP; Mon, 2 Oct 2017 03:06:09 -0700 (PDT)
From:   Damien <damien@dam.io>
Date:   Mon, 2 Oct 2017 12:06:09 +0200
X-Gmail-Original-Message-ID: <CAAQ5yigO8FxhUjwr68OnW0UEYck2AKF5P0Qt_zedhBL_SEiKTw@mail.gmail.com>
Message-ID: <CAAQ5yigO8FxhUjwr68OnW0UEYck2AKF5P0Qt_zedhBL_SEiKTw@mail.gmail.com>
Subject: hooks are ignored if there are not marked as executable
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

If you do `echo my_script > .git/hooks/pre-commit` and then `git commit`,
The hook is just gonna be ignored.
But if you do `chmod +x .git/hooks/pre-commit`, then it's executed.

I think ignoring a hook is misleading and not newbie friendly, an error
message to signal an incorrectly configured hook could be better.
At least as a warning to be backward-compatible.

Thanks,
Damien
