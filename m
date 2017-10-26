Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3CFB20560
	for <e@80x24.org>; Thu, 26 Oct 2017 16:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbdJZQOJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 12:14:09 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:55865 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932255AbdJZQOI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 12:14:08 -0400
Received: by mail-wr0-f194.google.com with SMTP id l8so3691182wre.12
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 09:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=S5DhB3hLMhBedjq/01fxYfuXfsav9Kcu946omgap8hg=;
        b=bQ/zpsDNjHgY9SCzxtzxunuOYu4oKeZlI/bzaF/eIGAu/RpwpHJw+TzuAC/yuZjgqU
         a1TG8R3WG6iqTEZnN2KXczMkjjiPMECtKs9R0ZKSTd1I64v27eL/7KmMkntYKR1AS5BW
         BWgonNCRzX0d6HiSbC609nB1TGb3TxU41zloaWVe1u0MqGKWQja9OD7GaWrua8yUktX0
         PMJ1ta2yE49ldhhejwWvyP/C64BAV1xngItBK0HzIa+KJb3H5TlWi09oIkov3iLz476y
         SAN4hq2ikjQt5KYbnkIDDv66MPIanMn5mZa3S/OpKdQZRlzp7m/pqmeakhHzSOunPuwr
         yMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=S5DhB3hLMhBedjq/01fxYfuXfsav9Kcu946omgap8hg=;
        b=VYTFkuRizIFt+W1MyBtPfw6mySHF7Duz5LSkyBaz9HFl+lj2LgvnvqftSuLqUh9xR+
         Ao5NkYq61b176AUuolYiE2Owo9DtjULfPXoqhk12QUcQynM1NXaYfIW501xvIw0smUnv
         95sb4X73sgKR1u/0ETAMaw+Ea6sEr3S6ZW4YemCecCPtH5Wa4MP9wg10X+maF+NgYq9d
         aHPTWV43GSmpBJAOtGqYbP6UVXeWc2Co0QkMBSxnB0eK7GHrSlsGqpfRjLO2QsUDfZnp
         +XxQjMaVfwJARtbwt2PJELk3++nMqRAJZutvRV+zc0VtLHvycx6kGF5wfiMaBR0BMvu2
         /uPQ==
X-Gm-Message-State: AMCzsaUdIkNH1E93OdhwQMinPYDn4gx/WqEfbqd84wQwZiW2IEkxGB9P
        QB73ctv6UUnur/Kdqtf8Wpw=
X-Google-Smtp-Source: ABhQp+QSjdVjt2C/JytEwpD/I9oo1TUE2g0zsMI+WMBGMDhVnXpjgODZVgUJ34iBy2zfQ9SHObCOww==
X-Received: by 10.223.156.144 with SMTP id d16mr5951958wre.29.1509034447161;
        Thu, 26 Oct 2017 09:14:07 -0700 (PDT)
Received: from localhost.localdomain (x4db15b4c.dyn.telefonica.de. [77.177.91.76])
        by smtp.gmail.com with ESMTPSA id f132sm1668424wmf.38.2017.10.26.09.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Oct 2017 09:14:06 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: grep vs git grep performance?
Date:   Thu, 26 Oct 2017 18:13:54 +0200
Message-Id: <20171026161354.23037-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.0.rc2.117.g35d527b84
In-Reply-To: <1509030170.10651.59.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Comparing a cache warm git grep vs command line grep
> shows significant differences in cpu & wall clock.
> 
> Any ideas how to improve this?
> 
> $ time git grep "\bseq_.*%p\W" | wc -l
> 112
> 
> real	0m4.271s
> user	0m15.520s
> sys	0m0.395s
> 
> $ time grep -r --include=*.[ch] "\bseq_.*%p\W" * | wc -l
> 112
> 
> real	0m1.164s
> user	0m0.847s
> sys	0m0.314s

Note that this "regular" grep is limited to *.c and *.h files, while
the above git grep invocation isn't and has to look at all tracked
files.  How does

  git grep "\bseq_.*%p\W" "*.[ch]"

fare?

