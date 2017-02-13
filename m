Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9DA2013C
	for <e@80x24.org>; Mon, 13 Feb 2017 05:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbdBMFwg (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 00:52:36 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36472 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdBMFwf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 00:52:35 -0500
Received: by mail-qt0-f196.google.com with SMTP id h53so11897898qth.3
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 21:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ormM8LFnR2MnHnQgSnQyNpuNr0GFZQCaFNMtr/UU5qc=;
        b=cZTU2M7mdq8XCreewrKZsfVeGeQYpvrE4uViv1G5pJSMibBXYUCwCPhmvE+4o+QCbs
         oro1VENHLeKZadIhacLISu1Kgm24us2LQQVLgQsU5QmZjUIre4as7h4W/ky+FHl5Ckk6
         yd8UNLxlOMq9PqQTZ1JAILP4FjyCAZbT8JqFg1hXuQa8IDvd8wzDRj8kpscXm702t/N/
         3xPLQ1vLzrlZdy7LEUlQNdioxA37/dLw0U4ZIigudqGAMiOqzDLnzsiNaUn+Ggmhr+ES
         aHk/fWQgN0OPwTfonpMZyXhySSXLd4evywCbxWxLxCORkMm+eFic0wNFEx2oxKbOzJ68
         +FyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ormM8LFnR2MnHnQgSnQyNpuNr0GFZQCaFNMtr/UU5qc=;
        b=XceDElfdFAKiB029JaLc/PfUUni6Mm9xiv8iS9H44o5GpIvPzk93zjQxI+wM8WHc1m
         pK+XiIMrpz3Td4M2C0li2VExNFrIrNqdq8mMjTvzLgya3A/ffqgFwzbSijxgHlUJlyZo
         QWayQxYijfqmtM/h6jIDX+OKEiKNpV3CPL/C8lvaq6ePZBAtQi5u8Zl/vJDesp/dkwlS
         pmJiXxx9o0fhC+A9EV+ONBO4MVVyStmUJjD8R4kd6+tNm62dKEI/9hT5jBb2YUmt1jwb
         Zrs5SuqMCiwTV7fPMVBNdKOCIjFpWtks3wBm3n95YsItmhvka763NSgInKTYTaNeHOCy
         zfpQ==
X-Gm-Message-State: AMke39k0XmZdnUYFx8EHYodKkgNZnRFXWurGB/Dv0skc/gT3Rgrm7WtDpDlUkSYN0JFsfw==
X-Received: by 10.200.1.11 with SMTP id e11mr18479514qtg.85.1486965154235;
        Sun, 12 Feb 2017 21:52:34 -0800 (PST)
Received: from localhost.localdomain (c-24-131-5-126.hsd1.va.comcast.net. [24.131.5.126])
        by smtp.gmail.com with ESMTPSA id f126sm6906345qkc.47.2017.02.12.21.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Feb 2017 21:52:33 -0800 (PST)
From:   Arif Khokar <arif.i.khokar@gmail.com>
X-Google-Original-From: Arif Khokar <arif_khokar@hotmail.com>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Arif Khokar <arif_khokar@hotmail.com>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
 <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
 <alpine.DEB.2.20.1608241509200.4924@virtualbox>
 <alpine.DEB.2.20.1702101707060.3496@virtualbox>
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "meta@public-inbox.org" <meta@public-inbox.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Message-ID: <d16546a4-25be-7b85-3191-e9393fda1164@hotmail.com>
Date:   Mon, 13 Feb 2017 00:52:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702101707060.3496@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10/2017 11:10 AM, Johannes Schindelin wrote:
> Hi Arif,
>
> On Wed, 24 Aug 2016, Johannes Schindelin wrote:

>> I recently adapted an old script I had to apply an entire patch series
>> given the GMane link to its cover letter:
>>
>> https://github.com/git-for-windows/build-extra/blob/master/apply-from-gmane.sh
>>
>> Maybe you find it in you to adapt that to work with public-inbox.org?
>
> Oh well. That would have been too easy a task, right?
>
> As it happens, I needed this functionality myself (when reworking my
> git-path-in-subdir patch to include Mike Rappazzo's previous patch series
> that tried to fix the same bug).
>
> I copy-edited the script to work with public-inbox.org, it accepts a
> Message-ID or URL or GMane URL and will try to apply the patch (or patch
> series) on top of the current revision:
>
> https://github.com/git-for-windows/build-extra/blob/2268850552c7/apply-from-public-inbox.sh

Thanks for the link.  One thing that comes to mind that is that it may 
be better to just download the patches and then manually apply them 
afterwords rather than doing it in the script itself.  Or at least add 
an option to the script to not automatically invoke git am.

Getting back to the point I made when this thread was still active, I 
still think it would be better to be able to list the message-id values 
in the header or body of the cover letter message of a patch series 
(preferably the former) in order to facilitate downloading the patches 
via NNTP from gmane or public-inbox.org.  That would make it easier 
compared to the different, ad-hoc, methods that exist for each email client.

Alternatively, or perhaps in addition to the list of message-ids, a list 
of URLs to public-inbox.org or gmane messages could also be provided for 
those who prefer to download patches via HTTP.
