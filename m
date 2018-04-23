Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702281F404
	for <e@80x24.org>; Mon, 23 Apr 2018 08:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754503AbeDWIX2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 04:23:28 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42916 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754501AbeDWIXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 04:23:25 -0400
Received: by mail-lf0-f68.google.com with SMTP id u21-v6so12008475lfu.9
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 01:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+JPAFRqimtuI0ZJYQHShjsjDDmSqnPKBWIa4wb2Kp8=;
        b=UZ6YvD0WroqiIwJR8NBuUSrE4CN7lzztSeFc6b7oGKxJhNlJwRCw/nsCGPOVG6HT2U
         dDiDczpN8rpJ9hOJuuB4hZ6YcG/tKlIX54Dq6KLtXDAEy0juKswBSXbp/pFQDu1hClfN
         3wE9zydt42q2/MljNUgd7iXsESysY088VUIMgm0LvBSnlX/H79tPcdTZrAW8d+4i2PgI
         4stZUPTmLu+IfpLkCG/PSL2f5cv8jsOx2S+kZJ/RvGfLcy2RBzasP+jl6YN58PdAgFS3
         +hZ9Id2EqLQHMy3zdW/FfCwMfFo85H58PAD43yZwDH4wDRbKTGjQRoExB94+Q6iBsWi8
         C+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+JPAFRqimtuI0ZJYQHShjsjDDmSqnPKBWIa4wb2Kp8=;
        b=ZhnEeBCaSy5lLINZvaWzvaM31zSLbygfKBaRe6K18dc3IltqsCptd9JFhrKQHEOz9I
         zXFT9Bkf52PZvrf9GjsK0mA+59bzHMeH8A4iGPyHbA5cb9QvSo1o2KuWKy4g6XRiPEUo
         8ST+cMdFsikNu3Q5UnQdkCLkgfNBB/Pw0b/WthfGHYPBwgM2mGNtwuVSLjHyvbsFxExY
         1Gc0nBfBi4j6xcZkr0BxsYwJY2PZDZrHXh2N6CvVKaM4A9AaHwCuhHnBGuToUBOQcmmT
         R/gfLJZv840PQvq0Snt3mRfA5WE1PB2NZkR1jGI/7rUQMySZmJ8amuyorfdoRhColrNw
         qCKA==
X-Gm-Message-State: ALQs6tC/mudk7clG6LXfl6Hf5kVhFTX9Gkm8OJPnCU7fxNSq9Eh0qI77
        nNzznUHymoraJS1nFzQWKXY=
X-Google-Smtp-Source: AB8JxZozsbzw7vEK/bPa1YGywKOj5+61FV76ur9o+98onA8SwF7CIxkCoobxz56zUaW+fsKQGB0cNA==
X-Received: by 2002:a19:7113:: with SMTP id m19-v6mr8549866lfc.96.1524471803866;
        Mon, 23 Apr 2018 01:23:23 -0700 (PDT)
Received: from localhost.localdomain (252.137.16.62.customer.cdi.no. [62.16.137.252])
        by smtp.gmail.com with ESMTPSA id n13sm2237673ljg.85.2018.04.23.01.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 01:23:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2 3/6] generate-cmdlist.sh: keep all information in common-cmds.h
Date:   Mon, 23 Apr 2018 10:23:18 +0200
Message-Id: <20180423082318.27314-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <xmqqr2nfyix9.fsf@gitster-ct.c.googlers.com>
References: <xmqqr2nfyix9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> 
> > +category_list () {
> > +	command_list "$1" | awk '{print $2;}' | sort | uniq
> > +}
> 
> Piping output of awk to sort/uniq, instead of processing all inside
> awk within the END block of the script, means that we are wasting
> two processes---I do not think we care too much about it, but some
> people might.
> 

Can be written as:

    command_list "$1" | awk '!seen[$2]++ {print $2}'

This doesn't actually sort it, though, which I'm not sure whether is a
good thing or a bad thing in this case. But it is less work, and being fast is
nice for completion scripts.

Øsse
