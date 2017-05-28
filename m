Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FD931FD09
	for <e@80x24.org>; Sun, 28 May 2017 13:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750811AbdE1NTA (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 09:19:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35489 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbdE1NS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 09:18:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so9450013pfd.2
        for <git@vger.kernel.org>; Sun, 28 May 2017 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+jfhpB3i6zBNHgHPEAsE0l9xZhTjvDVSqwuLWjFdn6Q=;
        b=AokSeDIJ7wnVrHkwO2Y2VQZ23UkyJ8OvCp0L/NKfMKjDctSUjqvDAkqS615swF57UB
         9gX7lFnTKT+yELq9QIGJCQn0QGlKCy1A+4qu53pZvkTPIYb/WK0Vc1+zc8Oyxbw9H1cs
         8DOh79atwsBrzAvjs8//h57pDBqq83Wi4wSlzgfUUN5tFBtePTUcTDO+WuYLw0soOUTb
         pLOLpPxpeKn5kSwulMQJWxgF6gqfaZw25BhTTu6nY6QtGvxIJMRWIxnQizxuIgIB4J6A
         BF/p5+A2BlSnu05MXiQoSAVRVmJ4CSNEUddczxbZQXMJOIi8r0sB9wfXr6+bnRKkWFmZ
         nn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+jfhpB3i6zBNHgHPEAsE0l9xZhTjvDVSqwuLWjFdn6Q=;
        b=AlnjtJz2B5Y5RRFDIE2sQQGq7dQo1MoFTRJBp0Xm0Hj9K8YFUnm9BLGuf4qIait22V
         bLSA5P3FUqnQ9LLEDa2JG2S4AvkZhIVOGBHgJDLMXllgsxfdc/RkId7CjUhS1+p9ZdvU
         R87e8nSHV3eYYzCpbTAzKSYEr7lbRckCkA0p45GQFO6U6YBhYtIqCzcph3bq1LSTFsZI
         iYrE1x9Cv0bjWkGo9CJ/5XL2+ZrK5zXZPLW8NWdb7IW+L96Sr5Zl+UTmw8mTfhZuHaTR
         dSK2jRZZynJTr8aFSUZ6A1/3VZT8qjgpLQpOxtQej40qW7QFP4+ESpyFQXB5vNJHngcb
         h05A==
X-Gm-Message-State: AODbwcAVSIyCgTT9ciFF7FiiJjTycoWdozCgHNHQVDaSqX6Apb3Ffs+C
        pDL85+75EBz2vuo5EqQ=
X-Received: by 10.84.169.36 with SMTP id g33mr32752118plb.0.1495977538754;
        Sun, 28 May 2017 06:18:58 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id b72sm11571859pfd.118.2017.05.28.06.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 May 2017 06:18:58 -0700 (PDT)
Message-ID: <1495977535.17563.3.camel@gmail.com>
Subject: Re: Missing: Consistency of clean state output of "git add -i"
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
Date:   Sun, 28 May 2017 18:48:55 +0530
In-Reply-To: <ABE60A6489CD42CFA43B9F5E946D8735@PhilipOakley>
References: <1495955737.4716.3.camel@gmail.com>
         <1495956144.4716.5.camel@gmail.com>
         <ABE60A6489CD42CFA43B9F5E946D8735@PhilipOakley>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-05-28 at 11:39 +0100, Philip Oakley wrote:
> I wouldn't let that stop you. We were all ignorant once.
> I know little of tcl (gitk/git-gui), but I've still managed to fix a
> couple 
> of issues, with the help of others on the list (and the search
> engines and 
> their results;-)
> 
Thanks for the motivative reply. 

> Perl is *that* hard, is it?
I don't have any idea about Perl. I'll see if I could do something when
I find time. That said, I wouldn't like to prevent anyone who like to
take up this task. If anyone's interested, please take it up.

--
Regards,
Kaartic
