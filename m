Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340051F461
	for <e@80x24.org>; Sat,  7 Sep 2019 23:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395308AbfIGXmM (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 19:42:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41619 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393301AbfIGXmM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 19:42:12 -0400
Received: by mail-oi1-f196.google.com with SMTP id h4so7888839oih.8
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 16:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+qp0Bn2pzFNKO1qjbeItt9AVicjZ9JMic6etUmGchc=;
        b=X/jK9Br1JhctrAv8MVUF2rQEJPIGCY40pKlsvB5Sp9E9r78w5vtvaMfzOfWssA9h0m
         aRZr1PXkcbFBmQa00T4cqInLE+vNZZT32Ofu3SzVVvbaU40lOjkjzB26f2FDLeO+m2Ro
         CwYanU7lMOIHYc+9aJDTSBCfW7vX8TpnHw6el9eRAOwOwKywjQ/1SzEN/EJI56ZB5Yeo
         OaubKog1KXsHjl+OTdNjkIc5GePqT8vKqVrD8m0YbxvC9NeVZpsQIFduh9XCu1bR9Lir
         MlqWP6qfNCrA0lDp22E7CKyfWr5T1QRvpOsxjyq+tsDc9F0iLj7mYEGKQcjFvCx/DIXD
         a3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+qp0Bn2pzFNKO1qjbeItt9AVicjZ9JMic6etUmGchc=;
        b=A3ZlGjsCECR+E0LxrTlWen81EcKtikqDpZIdGaN7gbtj67HQhPvfb4DxrL9hPmGAC7
         eIW3lL+ejU0oMJ2JXU1yxCPr2QO3ozUIvgHu7wGhjgkCW7RMhPjeO97uUuvp/zBi2zbq
         +4/HXEOSlKflRrm2IDSfvClWUi0zvlt0LKUyqWCTCeja7wWWPGJyqJ2QC5Fr4TXmAAq7
         k2myl2wuQrsHom5S6O9gepS2u2TBdTc4Gawq/idgAMggXcxuAQc4uLq7miycgFN3xQXS
         n/lEj3PMU3+05TQOLnjw9BHT959vCHY5AF1I4FartIycS8u0lsCMR+clsqk7ZpI5ltAn
         nizA==
X-Gm-Message-State: APjAAAX4V7ZDBYvdhtSXiBhhIRA2uMNvpXM/x+BKJP8i3acX8cPgkDCt
        3pgfMIyUXRLQSIh1vTD4ofA=
X-Google-Smtp-Source: APXvYqyI4u6cz/blgp3Q91TKOeY+p/ZKoKmqg8ak11Hq3qanuoG0jZjgRCqGO0oiZBScb8fApuTJJg==
X-Received: by 2002:aca:cc96:: with SMTP id c144mr12582231oig.72.1567899731183;
        Sat, 07 Sep 2019 16:42:11 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:8a10:1290:ccab:112b:24b3:bd34])
        by smtp.gmail.com with ESMTPSA id v132sm3639554oif.34.2019.09.07.16.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Sep 2019 16:42:10 -0700 (PDT)
From:   Warren He <pickydaemon@gmail.com>
X-Google-Original-From: Warren He <wh109@yahoo.com>
To:     me@ttaylorr.com, gitster@pobox.com, sandals@crustytoothpaste.net
Cc:     git@vger.kernel.org, pickydaemon@gmail.com, wh109@yahoo.com
Subject: Re: [PATCH] rebase: introduce --update-branches option
Date:   Sat,  7 Sep 2019 16:41:46 -0700
Message-Id: <20190907234146.1473-1-wh109@yahoo.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20190903013959.GA40029@syl.lan>
References: <20190903013959.GA40029@syl.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian, thanks for looking. The only thing I can come up with to say about having
lots of refs is that at least that part of this isn't brand new code. The part
that collects ref info uses the same routines as `git log --decorate`. Do you
recall how long that took in the repository with 80,000 refs?

Junio, thanks for eyeballing. Let me know if some style violations remain.

Taylor, thanks for coming up with a way to configure branches to be excluded. I
haven't worked on implementing that yet. Let's continue to watch for feedback if
people will desire this kind of control.

Using `exec git branch -f` is further discussed in the review, where there are
arguments for introducing a new todo command. I'll add some comments there when
I post a new patch set. But if someone's in favor of accepting a version of this
without that change, with the potential harm from this feature being low enough,
I'm not opposed to that either.
