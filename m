Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AD2820D0A
	for <e@80x24.org>; Sun, 28 May 2017 07:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750827AbdE1HW3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 03:22:29 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36117 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdE1HW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 03:22:28 -0400
Received: by mail-pg0-f68.google.com with SMTP id h64so3214408pge.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 00:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8mET4Ezjel8yrQ3DKQ4u1M172pDUmY9r/4sUMzn6ahs=;
        b=mNFRy6ssb8eYIXHF9NrWUT/1LXd/iWZoogkU6ASgY9/Rw5ZT6ipW81KDa+cC3F/i09
         pxcxfXlPghD+9olexwVn1Y18QL85LeydSaQv6aE7J+IGIXc71EPy//6P4LArhs437Mhb
         tCIP2Hf4FHcjvFzVcQsk+J2+SG5vOH72kT6YGmVIXW5IXlwDYLa2cJtc6wvXF8ufsd+8
         m8zmbMzwzg6z8VkQueoe3vEt1MgBuXY4Otc8Twnx4r2Njf1iygaRlGU1f7b1QnUps9VB
         VMUa8jtM2V61GOEixiI10Y7S+JjsmAbgh474+erP3Mh++ZCFmKCP/H/iCLQAqE7jPgIB
         wSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8mET4Ezjel8yrQ3DKQ4u1M172pDUmY9r/4sUMzn6ahs=;
        b=ApzTq2B4Rf41tgqvAaF8HcCaFowGfPUt3wekWtVC4FJi/OytovYzzpXyknmVHx+UA6
         cuUgblaiGwg1J+bFJbCd91WHl+jBk9CLhBOG6vMIgYG7po53FaJqmT/AK8avUEkC3EtF
         pjFvUJ7hEh2ly4BrfFG1GE791uciQ2wm7RUGMhbB5UAB68yZlDao6yhaP3HyPP5aq/lf
         yIOFzXWk4nYZjoddag2fi04qEvbmidty3zLXmYLzPloSCICM8ehwkrieCNgztJIb19Qs
         WIiobSzq8FYezrVVQkRFLwuNwg19cETRnubrv5C+MGSi6yVYH5io7eqNQoPbKtboXU7x
         ix8Q==
X-Gm-Message-State: AODbwcCKQaho8l6qDYXNsBGDLUClNXS8mtUZOmAmmX9Fvs4NcYyC2Pa8
        pvaJfJMY5aKrpN+ae3o=
X-Received: by 10.84.229.78 with SMTP id d14mr67754399pln.15.1495956147789;
        Sun, 28 May 2017 00:22:27 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id r68sm10363973pfd.91.2017.05.28.00.22.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 May 2017 00:22:27 -0700 (PDT)
Message-ID: <1495956144.4716.5.camel@gmail.com>
Subject: Re: Missing: Consistency of clean state output of "git add -i"
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Date:   Sun, 28 May 2017 12:52:24 +0530
In-Reply-To: <1495955737.4716.3.camel@gmail.com>
References: <1495955737.4716.3.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I guess I'll take back my note in the previous email that says, I could
help. I saw the implementation and found that I couldn't help as I
don't have experience with PERL. My bad.
