Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2D7A1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 17:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394860AbfIXRMZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 13:12:25 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:34406 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393616AbfIXRMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 13:12:25 -0400
Received: by mail-qt1-f172.google.com with SMTP id 3so3062071qta.1
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wGRZb1rKxh2E7GFTD9AMchO7TjIrjLnEHjiK8GLG6p0=;
        b=h4Q+grT/tah/xfUt6LjC1NMgdSmAOCOIaAVTnR2MfG/pmZhjoNSlXH43wwTeKCMn/i
         xul8vIYCGHgX1kWQthKtB4pyAoVcui2gOrNjxHBUZa9M4onyadQRY9uJKExOA2jVbmg5
         Uh5UobU/LNjvYLmxuM5TBw29re7JnqZiGrCWzVk0p2evSNFIK+77VjccqjqdaJAZOk6q
         EVgFKLecDACNha14aJ7Vz1Y156ZRKWGf6oVOHTwpsy0OXgmbOlcEEx7nKyhwrWn+sDk6
         1FJrdmwfW3SqoXeMWe7FfGZWZA/t82Yh/JXifoN77XSpcqfDI2IHWhDIIv9AhQAh3aWf
         fFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wGRZb1rKxh2E7GFTD9AMchO7TjIrjLnEHjiK8GLG6p0=;
        b=WegysCwjv2ws6FL3QkpdxDYW93EU4+RAfNVXsOsurDCKQ29gdRp5DJ9hR+5abH2n/E
         9lXijSsHhHE9aoBObjLFVMZCf5HFW0WcrzaXW4LqO2WJrBcY9EfctCB00YL2Vn9OlSOY
         wWOD0ZiJluiRlcCOTCs5fSo+Gx7kiQ9t9i+n8oyPljT9UI4KVA9+RBBn2RzDwW652myi
         S96kzaAV8+PhVTEs/1qFViF/qpYy75UNuCS3RQhFEM+6ZaLm37FeGjVXNfDZbtDo8bzX
         sjLgTqpUPKfooSvPtHbvorWb6UpbUrZ6qADcF7cX/0fRsoDKYUsKJ0tpZ8C66+8OnWrh
         NKGw==
X-Gm-Message-State: APjAAAXJObbUWP5gnUjdAQZwMBUyuvf5E9e63/xJAhqZTYzkfmWUn9f4
        cdcesVXUpQFkNRX8UmpqLBll6nnCOJg=
X-Google-Smtp-Source: APXvYqzztf4EALqLSTdJ2lvP85amyrU66hrQPzzsD/s1vsEEgnx0WgdAaleDFOJ1GmzIc9LgQMF3ow==
X-Received: by 2002:a05:6214:444:: with SMTP id cc4mr3514746qvb.132.1569345143864;
        Tue, 24 Sep 2019 10:12:23 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a103:a699:4a8e:b69c? ([2001:4898:a800:1012:5237:a699:4a8e:b69c])
        by smtp.gmail.com with ESMTPSA id a190sm1605273qkf.118.2019.09.24.10.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 10:12:23 -0700 (PDT)
Subject: Re: How to see command line arguments passed to program in
 core.sshcommand?
To:     noloader@gmail.com, Git List <git@vger.kernel.org>
References: <CAH8yC8nVBcBntJVZ6eV+YxoBpZRx+ecC2JxGuunhxNbY2cGyFQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <55e607a9-f004-e6a0-3faf-1112fbaf96c3@gmail.com>
Date:   Tue, 24 Sep 2019 13:12:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CAH8yC8nVBcBntJVZ6eV+YxoBpZRx+ecC2JxGuunhxNbY2cGyFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/22/2019 11:17 PM, Jeffrey Walton wrote:
> Hi Everyone,
> 
> I'm working in an unusual setup on WIndows. I need to 'git clone' over
> SSH, but a third party program has to handle the tunnel. It happens by
> using this git configuration:
> 
>     git config --global core.sshcommand "tunnel.exe ... <path-to-public-key>"
> 
> After I execute the 'git config' command, I open ~/.gitconfig and
> ensure the path is correct and quoted per Windows standards.
> 
> So far the result has been a failed authentication, which seems to
> indicate something went sideways using the public key. I don't receive
> an error from Git or or the tunnel program relating to a "file not
> found" (or any errors for that matter until authentication fails).
> 
> I need to spy the command line arguments being passed around, but I
> have not been able to do so. 'git clone -verbose' is ineffective, and
> -vvv is rejected as an unknown option.
> 
> How do I see command line arguments passed to the program in core.sshcommand?

Have you tried GIT_TRACE=1 or GIT_TRACE2=1? Both options should record
a log entry for any spawned processes.

(You can also point these to fully-qualified filenames.)

Thanks,
-Stolee
