Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF541F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeB1BeD (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:34:03 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46752 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeB1BeD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:34:03 -0500
Received: by mail-wr0-f196.google.com with SMTP id m12so684123wrm.13
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0bjsL60/XGY4wu81VHczInPwCbK8U88EAsmSFpG7PSM=;
        b=QDUDTvJpqNfsvXPOA+pLhi83n4v/hkaRS4hMEkAZMBQ5ZvnBVIDrLR61EWmVMfAGYX
         mFNaZqRtruwj2JPnFxkuNGP34X4hBm32iyx9CSaXV/KmV0XISGxkaID0fQHberzVOawl
         jKPIngDN/wggDhYXEh/otIAhdjK3WwP1tuhF8B1GKlaixfqK7s3AwvcLeilL4zreAq7k
         HN7MDT134m2xEbJSgMv1Wc+0YEyKQpJGkQE2DRrdWB6Dx4TjKJpuZkAzQNbOmcglyCQr
         D4b1rp9tqVKmIz6ltc530SRM1GbCocBMcZcHgXL2Ehaf4POuIgYI1cr2Fo1+nEeMWVAf
         6QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0bjsL60/XGY4wu81VHczInPwCbK8U88EAsmSFpG7PSM=;
        b=Xcy+HzJvA8mBso3dwpHPv10CrDJafD66cnvuDfn766leSsVyn8LRCUTp1JQLv3tZEn
         CH7bhhKeYmaSvPF/A0eexRJZy8dsUXmiAWmTZqz5pO4u3c/uoRDSi3ZC0jhgRFifFu6R
         8p+nlD6z4Ptj1e4EAwQ61VRogz2DIpB0jkNm4xBk6lWCSviABpCKStqit31EHei4lVxX
         4BAMH1sYHAcScI99ZPuhuMYb7665wS0kBrHKZbVHln28wfltAZ7p1k7hmPF6nAWp2Wdj
         02Oe/nzAM8ODVmPTh7NHoVen2/GB1g4CAradv6b6IBQm83MfBvhFmBz29sLOUQ1LT1XR
         XCug==
X-Gm-Message-State: APf1xPCVl1C9JTS2I5aMHB2j7dXIh45hbZSnNLCv6iDXO6udAGidtNUy
        Dg4DpVk9j6fT5WH9nl2MEBs=
X-Google-Smtp-Source: AH8x226SIUZS0fTOFNRwYkCoau+kaQcp3vm7sj5KQ+n2fd6sXjo/0tQ0i8GO9q5+iA7GYciADfO17A==
X-Received: by 10.223.169.161 with SMTP id b30mr15901907wrd.232.1519781641890;
        Tue, 27 Feb 2018 17:34:01 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id p78sm1100154wmg.47.2018.02.27.17.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 17:34:01 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
 <CA+P7+xrzxYSE0OyL8uyF+ErwfWFEgcqnHmaciwWkK-76sQ6ktw@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <8829c395-fb84-2db0-9288-f7b28fa0d0d1@gmail.com>
Date:   Wed, 28 Feb 2018 02:33:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xrzxYSE0OyL8uyF+ErwfWFEgcqnHmaciwWkK-76sQ6ktw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/02/2018 01:36, Jacob Keller wrote:
> 
> > > (3) ---X1---o---o---o---o---o---X2
> > >        |\                       |\
> > >        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
> > >        |             \          |
> > >        |              M         |
> > >        |             /          |
> > >        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
> > >
> >
> > Meh, I hope I`m rushing it now, but for example, if we had decided to
> > drop commit A2 during an interactive rebase (so losing A2' from
> > diagram above), wouldn`t U2' still introduce those changes back, once
> > U1' and U2' are merged, being incorrect/unwanted behavior...? :/
> 
> In that case, the method won't work well at all, so I think we need a
> different approach.
> 

Hmm, still rushing it, but what about adding an additional step, 
something like this: 
 
 (4) ---X1---o---o---o---o---o---X2
        |\                       |\
        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'--R1
        |             \          |
        |              M         |
        |             /          |
        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'--R2


... where:

  R1 = git diff U2 U2' | git apply --3way
  R2 = git diff U1 U1' | git apply --3way

(this is just to explain the point, might be there is a better way to 
produce Rx)

So, we still use Ux' to preserve merge commit M amendments, but also 
Rx to catch any changes happening between Ux and Ux' caused by 
interactive rebase commit manipulation (add/amend/drop).

Note that R*1* is produced by applying diff from U*2*' side, and vice 
versa (as it`s the other side that can erroneously introduce dropped 
commit changes back, like U2' in case of dropped A2').

From here we continue as before - merging R1 and R2, then rewriting 
merge commit parents to point to A3' and B3' (dropping Ux` and Rx).

This seems to be working inside my (too trivial?) test case, for 
interactive adding, dropping, and amending of rebased commits, 
resulting "rebased" merge containing all the added/modified/dropped 
changes, plus the original merge amendment, all as expected :P

Regards, Buga
