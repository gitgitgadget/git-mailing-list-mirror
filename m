Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CCBC1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 20:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeCEUQR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 15:16:17 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:39137 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeCEUQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 15:16:16 -0500
Received: by mail-wm0-f50.google.com with SMTP id i3so17980966wmi.4
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 12:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H0y2zieiF62GTyWmSbonZd+WkrzrtcTALtYSjUTQxE8=;
        b=I3q9dvWG1yj7k2wY0MOJW0s6bO1XqaCjemWwEB7pfTtDPK+QySPd9uEiCJkArr/Voa
         ViOWiIuQSzYWrzYGdjbpfn3ZdWqvf8459Rg+S4pr6jZnTNAphuGkGAmIvu5AWcdCi/tR
         WLlQhkGUpVbwW2flXGIMrdhltq1svK3zPKtKKXPINGIggtmRMoQnbk1fy4z9UXZ5ohnu
         Dzx2kmpBNqaDGNJEsGH0AfLpMiVKlZrT7Ew9Lqg5C+/Z/w7yzMYEXfSoQd/oz4HZs8B2
         sMN7BUIMx3B1JZeDQKTvcZxOSZR/QAaMqga1oeUTM2Db8/UGg6zRMz3ql3h8o/hP+Rfh
         FhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H0y2zieiF62GTyWmSbonZd+WkrzrtcTALtYSjUTQxE8=;
        b=BEgHnWXptB7CJL17VV+TUkAG9DXBOP+lG2L3Txc9+j441C0fQiJvyBI+dYRqZo2ZY+
         wR/aIb3JZHRoGX3MEDoEg4I630WglcEnikxMzrrEVnmWjdf3rX3tHTptgZAn+HC0cj6Z
         P6znhS7FJTWBLTLzL6xC0xUdN491nKLbZ2ojtMUAsSj5XQ6Mo1ZmY7Qc5O+KKA+Itdfo
         1nVKJtFdha0Wysx6881EnB2Ft4MetTzlIOSNtXQZ7pNS6hSWtEKZTmukjufN8CTAho+w
         w1sACJRCOcJjHOIHhpyoVZZGTFzzMpYc7AIzoB2DxBNLq5IWJd9O/sdZuC6OOImu/hqn
         3XTg==
X-Gm-Message-State: AElRT7FGrVQLeNAtjGKLz1IFOUm3M13tU4eQX5LpisDRCd/cUa/7X1sp
        BLdW6/SdrVVePhCwgZMTDdIhlg==
X-Google-Smtp-Source: AG47ELtzPHPpmZt8KLLJbt6a7Ys84gNh7Muwh9RBqC46Q0I52zOEU15+dd/7N6ZwGJWdo557u4hjNA==
X-Received: by 10.28.191.70 with SMTP id p67mr10107894wmf.17.1520280974820;
        Mon, 05 Mar 2018 12:16:14 -0800 (PST)
Received: from ?IPv6:2001:a62:81d:ab01:1464:abc5:81f1:7b9d? ([2001:a62:81d:ab01:1464:abc5:81f1:7b9d])
        by smtp.googlemail.com with ESMTPSA id d27sm17223239wrd.60.2018.03.05.12.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Mar 2018 12:16:14 -0800 (PST)
Subject: Re: [PATCH 1/2] git-svn: search --authors-prog in PATH too
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
References: <20180304112237.19254-1-asheiduk@gmail.com>
 <CAPig+cQARx4eZFHyRpikHJYaz42NKq18fjt-=KYOX2GddDPNDA@mail.gmail.com>
 <20180305175243.GA10325@dcvr>
 <7767e8ea-5a4b-5088-47e3-f9f2eb7ffae9@gmail.com>
Message-ID: <a767150a-cb33-5aad-68ed-27ef237ee9aa@gmail.com>
Date:   Mon, 5 Mar 2018 21:16:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7767e8ea-5a4b-5088-47e3-f9f2eb7ffae9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.03.2018 um 20:48 schrieb Andreas Heiduk:
> Am 05.03.2018 um 18:52 schrieb Eric Wong:
>> Thanks both, I've queued 1/2 up with Eric S's edits at svn/authors-prog.
>> I'm not yet convinced 2/2 is a good change, however.
> 
> I'm not sure which direction your argument points to: Do you object to a
> $PATH search at all? Or would you like to remove the legacy code too?
> Or is the code/doc/... in bad shape?

OK, I've mismatched your reply and the patch number. So my new questions
are:

Do you object to the feature as such? Or would you like to remove the
legacy code too? Or is the code/doc/... in bad shape beyond what E.S.
already mentioned?

Right now my team performs a hefty "git filter-branch" after each "git
svn fetch" followed by black magic to set the new object ids in the
caches / rev-maps of git-svn. Official support for "no synthetic email"
would be much easier.


