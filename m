Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B8220281
	for <e@80x24.org>; Mon,  2 Oct 2017 17:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbdJBRUg (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 13:20:36 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33481 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdJBRUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 13:20:35 -0400
Received: by mail-pg0-f66.google.com with SMTP id u136so6768341pgc.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 10:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=YLXt1iaU0PkWdHXKhN4OrRc8WoBp/gifcBeFgLqcnWU=;
        b=e2uHHYcCd17fzoFxiR84TIlS9M3jpf+G2wwWIFwWeci6lGJ0OQadN37A+YGusI/z2G
         HELG4UblMPn/hln0YSmjv56VLifVFm305fvCIbaTW4c5bFJAiP0vqUuHFTPN0Rga7QCI
         HLDJjMe5qsYmLZFgESH/MiOX/SIbJlkLYVpjJLRWh1J/XMwY7hvlzeWL1+oGNfzrX7/Z
         ybLQ18sZ/DTeyl5PNV88LJtgeSAR9aYTaL6ISEXu9xGTz2K3HZPOkDuHZeWIW/glggBi
         Xl9WnG/8VbOPMF+KRqBXE+yeG6YK5FbkNjor5GTeECbReQCUB0R/lzrIS5n/74JcxR6Y
         TuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=YLXt1iaU0PkWdHXKhN4OrRc8WoBp/gifcBeFgLqcnWU=;
        b=oMJQeQREPLz1XTTKfLf+QezQ0kfvYRZWEtUjmdd/WrzQHcBX+YK2kIQT3GRmQF2bc6
         ENuFXFgb/YQ6NJe3J04Tcv9ufesIxr7wmXqz0CV45LE1brV1iAHC6QfqPSdKkO6AdEmG
         IQ7TC8CPGjPGRQ0F+xaX1oZFqJrAhfPjRyA9rEkz9Sm58QaHf4Ywvmn2tB+D+m2elVZE
         fLhlvJX6wy/tqi3aGQwPQZ6qYC4fR2H2J2sFnhivqAgh/NP001+49Ws4SKdyMws7n0VZ
         DiuZwA9xpMAFm8TUJ75OQS4SVRE2krzrj0ZXibnfTgQ9z2z2gUb1qtabFfMYMhNkAHkn
         c4zg==
X-Gm-Message-State: AHPjjUiMqfs2QSyZsOZ0yJdGjIZohzRsozG8zzT+c4hBrGWr+sxWmOQE
        KwwGpF8QwigoUIZt2DHDOBNHzdF5
X-Google-Smtp-Source: AOwi7QAvWeD4vjaLt8zXyq+mUwmEqXiVRXxsT71NcSzkK5LVTk8kRl2KuarTCa+ZMctaeJHzLIunlQ==
X-Received: by 10.101.90.68 with SMTP id z4mr13014446pgs.76.1506964835321;
        Mon, 02 Oct 2017 10:20:35 -0700 (PDT)
Received: from unique-pc ([2405:204:7287:7232:c31:a746:72c9:9586])
        by smtp.googlemail.com with ESMTPSA id m13sm16732138pgc.58.2017.10.02.10.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Oct 2017 10:20:34 -0700 (PDT)
Message-ID: <1506964828.3504.5.camel@gmail.com>
Subject: Re: [PATCH v2/RFC] commit: change the meaning of an empty commit
 message
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <1504186577.1826.9.camel@gmail.com>
References: <1500107583.1850.4.camel@gmail.com>
         <20170821140528.7212-1-kaarticsivaraam91196@gmail.com>
         <xmqqo9r4vhv0.fsf@gitster.mtv.corp.google.com>
         <1504186577.1826.9.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 02 Oct 2017 22:50:28 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-08-31 at 19:06 +0530, Kaartic Sivaraam wrote:
> On Thu, 2017-08-24 at 13:19 -0700, Junio C Hamano wrote:
> > 
> > The latter is easier for me as we do not have to worry about 
> > breaking people's scripts and tools used in
> > their established workflows at all.
> > 
> 
> In that case, how about doing something similar to what was done to
> 'set-upstream' option of branch? We could print a warning notice when
> the commit message is found to be empty due to the presence of a sign-
> off line. As usual we could stop warning and stop identifying log
> messages consisting only signed-off lines as empty after a few years of
> doing that.
> 
> Note: I have no idea how good an idea this is. Let me know if it's a
> bad one.
> 


I was recently searching to find the patches have gone missing in to
the void for no obvious reason and found this. Should I consider this
to be "Dropped" in terms of the "What's cooking" emails or has this
just not received the required attention?

---
Kaartic
