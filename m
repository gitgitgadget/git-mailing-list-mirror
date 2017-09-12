Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC1E1FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 12:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbdILMrb (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 08:47:31 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37732 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdILMra (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 08:47:30 -0400
Received: by mail-it0-f67.google.com with SMTP id d6so5773217itc.4
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 05:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=zaG7g7HHCOlafVHLoDT+0bxGrnZ/mh8cEaveroAS8EM=;
        b=CnujAZ+8nq21PLsK4NwXXjB/ox8Hwpdifs9o2IPj73W2+VKn1UtRdSb2OclmsrzgeV
         51YFx2x8N5/42x9GQ0ckLOnFIRhcUCsNoHmODJP3IHrz2q6WLBERvFi7De4+vcga1Qnz
         JjITp/K19bSI/Fb0QIZLkelX6tfu8yQCeYafCvix03IGR6X0ZF/3pPQPjySC8rhOKjeq
         koKwKf1m0CZYPL2tRFpcTWyjCvwQ+zBqoZ3BResXrMc/B9wWOoLM9eqfSKH1qI0j2PAK
         WqlwHb8eLdrTvMTb8vspnMK5eikMK+6f/jjwqiAt4fy9FGOsohyHOsjcGv9ILMOP+R/D
         oXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=zaG7g7HHCOlafVHLoDT+0bxGrnZ/mh8cEaveroAS8EM=;
        b=dNclD3u0nFem3yxUdvIr1+6Kq8Q9KwGjVbizmH047EVA6PRa96QFHGYWHY0dlknGx3
         ti79BuDOdOzm7oiqi6T5bud8lRvhOfvLziPe+8msCWayu3AFmYbGxVCt02YyXfIYx2Yi
         c8Lwhy1w05G5GAjxQccTBd13viYr7GM8eD0T+QWSovQCX4K/KW23vp7gZ5f5mfdoj1WT
         dQOkciPPguXGDPJhdJKEVu9YGLMp8fhxdYFOjQIV31VPFguKmtaCylL480WjePn2uh+F
         8I7eZBd3/VH/GhjXoJWFO4WmxT4KAjeyLRg08ftq2eZRiYskCW9J2f6mo5rseMmMKXxE
         Y6aQ==
X-Gm-Message-State: AHPjjUhJWo4Jg8K0S2i0jM4v8SohHAAZ2FAZbNPRMHuzd9t4j4JgCIYL
        2SZ8wPrbq5DwMRIHKjlrJ69DIpUS
X-Google-Smtp-Source: AOwi7QCDulsQtCXSSbs3TFk4pKO2OWsqbUsW5vBR09NlbI3VXzXCB4KfSHM1toMPnFDx+Wypc0Qtqg==
X-Received: by 10.36.233.196 with SMTP id f187mr905038ith.20.1505220450050;
        Tue, 12 Sep 2017 05:47:30 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id k21sm6308313iti.28.2017.09.12.05.47.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 05:47:29 -0700 (PDT)
Message-ID: <1505220449.27800.23.camel@gmail.com>
Subject: Buffered value should be shown when requesting username for remote
 authentication
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 12 Sep 2017 18:17:29 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.24.5-3 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I noted a little issue with the interaction to a remote git repository.
The issue occurs when the network used for remote communication is a
bit sluggish. The main issue is illustrated by the following shell
interaction,

    $ git push -u fork 
    sivaraamUsername for '    https://github.com'    : sivaraam
    Password for '    https://sivaraamsivaraam@github.com':     

    It's a little odd that the (buffered) input found before the request
    for 'Username' is also appended to the input found after the request.
    This might not be obvious to the user and he has to retype the
    'Username' in the next try.

    I have seen some utilities handle this correctly by doing something
    like,

    $ <some-utility> 
    sivaUsername for '    https://github.com'    : siva

        Further, unlike the request string, the buffered input that gets
        printed after the request was editable. I'm not able to recollect the
        <some-utility> correctly, though.

        Any ideas about how to fix this?

        -- 
        Kaartic
