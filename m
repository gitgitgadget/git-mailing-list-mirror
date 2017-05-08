Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D36320196
	for <e@80x24.org>; Mon,  8 May 2017 19:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755486AbdEHT0P (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 15:26:15 -0400
Received: from mail.aegee.org ([144.76.142.78]:43121 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753622AbdEHT0N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 15:26:13 -0400
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.aegee.org v48JRUvN028653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
        t=1494271650; i=dkim+MSA-tls@aegee.org; r=y;
        bh=ZLD+ndkrXDrf/AGmEHAddakfTDAEVwAKS51c97bgEzk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jp6A6Ed8604wokvwSIG8gJ4izXl+zFGZxkfV3Nd6K1aDqw0OlYnotVZ1s38LnfcdH
         7XeksgFQk0ZQluqpugB1sUxWt/6xuYye10VIFe9BAczTeb4KLX924Q3GVOSegovNd0
         KIX1YAId638cNNtJaXfCzTWW0+FZrc4WFDMTvlDbp2gjRp+/MTkarS4h1ua/3xAklg
         28MW525d9dVhXmKdiMGzgEO48SJEGZPjq717xvMPjNjBqkc6RiaZ1Pafg2/WqMvVqe
         4JjFPutkLYTPgKGiDR98utkY2m7aV+eZ0QesMi9fHX8M3VY1G1D8cE31fRbwzFJ2AJ
         t7wnOq55jnd9dXomCDxislYKq0/xRrsOnLQg/WP5dqbVafbtx65oYItAZMsC24zrBt
         CxDIQVSJHs5KtuD0iEPBlqiu5sIz7aT9mQdrWDJnJTMENSrahLFDq+tsdRPogQuAwI
         JLWtfFm4qR/D0ZUxpVnLdzTQKKwWIxy+qCbZmfMZsITrLtiuSu9TBMW0KeNj4dTptW
         i3fPSp59SsgFcvWgGaKC8rFx+2ggVObFmebbhMcA7C0x165AkcSf2b2XuVylfr0Wla
         /xZrqYKsyZoxyuCv6F65/0qSR2+mCrz+ByObcnCCQ2oCURe1CfvMT8keuJ+LgutYd4
         b93Lwx0+O9HxpGxhDURLkomM=
Authentication-Results: mail.aegee.org; dkim=none
Received: from [10.128.8.92] (port-87-193-154-82.static.qsc.de [87.193.154.82])
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id v48JRUvN028653
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 8 May 2017 19:27:30 GMT
Subject: Re: git and the Clang Static Analyzer
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <5696a8a3-0a17-18ac-8da4-4556586acee7@aegee.org>
 <alpine.DEB.2.21.1.1705081250550.146734@virtualbox>
From:   =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Message-ID: <373a6f4b-1b4d-6c75-30b1-c2498555c3d9@aegee.org>
Date:   Mon, 8 May 2017 21:26:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1705081250550.146734@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

>> I compiled git/master
>
> ... which advances from time to time, so you definitely want to include a
> more informative data point here, e.g. 4fa66c85f11 (Git 2.13-rc2,
> 2017-05-04) ...
>

The 4fa66c85f11 you mentioned is part of the URL I sent.

>> Please note, that the information is only about what gets actually compiled,
>> code disabled by #if .. #endif is not considered (e.g. when determining
>> whether a variable assignment is useless).
>
> So you already know that the report is specific to your setup. It may make
> a lot of sense to actually state what your setup is, i.e. Operating
> System, installed libraries (and their respective versions), CPU, etc.

I don't think this is of much relevance.  The hints provided encourage one to look at the code and to evaluate mentally the lines.  By tweaking the preprocessor directives, you could get less warnings (a previously unused variable now appears within an asser()), or more warnings (as more code gets compiled).  Getting more warnings makes sense, after the current ones are processed.  Getting less warnings means (again) compiling more code.  I use already pcre and openssl, what else can I enable?
  
>> There are probably false-positives.
>
> Probably. So why don't you give it a try and look through the report? Then
> summarize your findings here. That would definitely find a warm welcome, I
> would expect.
>
>> However in case of e.g. builtin/notes.c:1018, builtin/reset.c:294 or
>> fast-import.c:2057 I consider the hints as justified.
>
> Okay. And those hint are...?

Click on  https://mail.aegee.org/dpa/scan-build-git-4fa66c85f11/ and then on "fast-import.c: line 2057 -> View Report" and you will see pointless assignment.

I cannot organize the report much better, as filtering out the false positives requires usually too deep understanding of the code organization of git, which I do not have.

This is the analysis done on the pu-branch:
   https://mail.aegee.org/dpa/scan-build-git-7dd243c75

Both reports do not list files in the same order, as I did parallel builds, but I do not see on the spot any difference.

Learning Travis is not on my priority list, I sent the commands I called to get the report.  I also compiled clang by myself.  For those who mistrust sites, there are no-javascipt, no-css browsers like lynx.

Greetings
   Dilyan
