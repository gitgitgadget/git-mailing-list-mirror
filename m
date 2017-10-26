Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB28202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 20:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdJZUbX (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 16:31:23 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:51807 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbdJZUbW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 16:31:22 -0400
Received: by mail-io0-f176.google.com with SMTP id b186so8191613iof.8
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D38e6fccPG8JcA2QVz+Qpet/jxljaKgoZwx1bUq9heM=;
        b=m2+1KwC/hYoncHUwsqEbJnw9wSDENMorJGEkH/60jM3lX4Rt7rERPKhP6fEnDveL9f
         tP7ZAAgZnFE6L/GQEicXLydFKMilVcrx/GDMUEkMjX3wANCZx4i2qnfSSUbMeWcVne7I
         sLh+gPRYjtx/eTc+24BZmIlWTeVAlCw5NhjIFbTNR52/KJd9puAVmPudjjVV3NbIqKVP
         QDGpCslMUl9JMqTMRwYYCzn7Ksp5+EHG64pQEpRQpLuXDEyoOAnV2itMunW1C3WE3TuX
         Jzj9fUMytcJFVVzF2yqytvdX52XoFHc92xyq8zoJ2ouMMwteLUlvE7J3LR2P4S0r0OmN
         1Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D38e6fccPG8JcA2QVz+Qpet/jxljaKgoZwx1bUq9heM=;
        b=aCXXjTUa5hqQ+E5rjC1QqhUJBU7+eyPZWXQ6E4rxFNeq05zzmAYMPEM9ebhKYSwtyl
         2b4mj1BMikFPNPW6FEqVyKD80A/l8FFelIpHJ44vRT+sisBZbdAfE1HnaBxA6cpuUs3p
         ZA7kMx4pHAz6DBc/skgBRzji3yOy2t7lJQTSly8plGP8fnTycLrq9qlRgj4wf6culY5A
         WkchO1wQYlfqcasflMw1a7v8g1Iz34Arrn9+NpLLlHuAGO3TKgWnoNfVdjLwacWLWEtw
         1rNBSrLMQ6Al4zZyflypE55IbeRjpukT3Ac86AokviNNWQJurW7AXnGf5tRFNFJL5Pki
         SqMg==
X-Gm-Message-State: AMCzsaV+6f1LNspHAjc7viZ6E0B+CJ8AMI5qEw92cQCG39f8LNg+DF6z
        HCVD2sTIXhCGymgKuDa5D5o=
X-Google-Smtp-Source: ABhQp+QWJwGlijcU9z6QTxuqXwgjPp71cgzBbALSy5EKUjAkMwBIBtllAnuM/qNYjcBl2ez8JhlysA==
X-Received: by 10.107.149.18 with SMTP id x18mr11861742iod.99.1509049882038;
        Thu, 26 Oct 2017 13:31:22 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j190sm57489itb.35.2017.10.26.13.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Oct 2017 13:31:21 -0700 (PDT)
Date:   Thu, 26 Oct 2017 13:30:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: Consequences of CRLF in index?
Message-ID: <20171026203046.fu3z5ngnw7hckfrn@aiede.mtv.corp.google.com>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
 <eda48d5e-a52c-9a39-8e55-a6828efdb3ef@kdbg.org>
 <alpine.DEB.2.21.1.1710251415040.6482@virtualbox>
 <5e962f69-f9cb-bd7e-481f-050e6239813f@kdbg.org>
 <30ED36AB-FAB1-4635-94AF-FCEC6F02CE01@gmail.com>
 <7a4396e8-7b97-9ec9-d028-c5ad29042c86@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4396e8-7b97-9ec9-d028-c5ad29042c86@kdbg.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:
> Am 26.10.2017 um 13:01 schrieb Lars Schneider:

>> *     -text
>> *.sh   text eol=lf
>
> Why would that be necessary? I cannot have CRLF in shell scripts etc., not
> even on Windows. (And in addition I do not mind CR in C++ source code.) All
> I want is: Git, please, by all means, do not mess with my files, ever. Isn't
> the simplest way to achieve that to set *nothing* at all? Not even
> core.autocrlf?

That's why Lars suggests "* -text" in .gitattributes.  That way, if
some user of the repository *does* set core.autocrlf, you still get
the "do not mess with my files" semantics you want.

If you control the configuration of all users of the repository, you
don't need that, but it doesn't hurt, either.

With that "* -text", you do not need "*.sh text eol=lf", but maybe
you'd want it in order to get some warnings when someone changes the
line endings by mistake without running tests.  (Better to have a
culture of running tests, you might say.  Fair enough, but as with the
other .gitattributes line, it doesn't hurt.)

Jonathan
