Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA5E202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 22:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbdJZW2J (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 18:28:09 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:50827 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbdJZW2I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 18:28:08 -0400
Received: by mail-qk0-f174.google.com with SMTP id o187so6261252qke.7
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 15:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerotech.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BOQ0L/vtkbTnAM7hvI/OAFwGkiyoADXN+MrSGigz1kc=;
        b=GkMFOC4ayMPhdGtL7kzsXG/ylSjvCzPOeg0kBNIMUoh8vngGHaHeDhPc1fKzzo+qRx
         SZ87NA5I2MK0EkMzJ3a17d6I3sz+dMsRukBf84nhELOePSDafvMw2Qo5VHDpCljWpcIC
         x/Wf6DlkAqvObUK59tIEbiyNralzEpJKE4KrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BOQ0L/vtkbTnAM7hvI/OAFwGkiyoADXN+MrSGigz1kc=;
        b=qBAriQXGdNwZhga/fPNj7UCcqXt5hfPAHwB95sOyvaqZc+IGAU36iJnY2PQvcSHmVk
         qYlqzbjFF7sm1jO7EL6B6K14P2LPwlLiEfknPKe8UDu/wZOxsdBKHeMJMnEMrBYsnUCq
         hn+4yX9RxWieyalILd0SUU0XDPmHlSEYCz3GOxMi3k2vDUjTFgCfSRRCpc3nBa7lFNUl
         esPmuurpKxSMKuMee74Okzz/A5r3TyDcznclQvSStHGlj/7zJc5pLopspwyL2Vdvdfvk
         3Onq9pfF767ipLrtJx/mChPvDoXBvqYLa/GL+9O1Y56EHihB06lCFfsCmlQi7fJNZCae
         50Xg==
X-Gm-Message-State: AMCzsaU41DBkcun3JgsLphsF4piwtEu7UvIDb4cDXyFb83wx6FEJwc1D
        7oAfWyQka7BfPil535G3R7wDx3tCtQzLNOHfie/nyeowJwo=
X-Google-Smtp-Source: ABhQp+Ruco5USrVgpSMO9oudwU17ciCF9CiuqTnhu0SnmR8d0n0wiSAd8iVt8usVBQAStIklhnOSEHA05TAmjoRE5MI=
X-Received: by 10.233.232.14 with SMTP id a14mr10630585qkg.256.1509056887426;
 Thu, 26 Oct 2017 15:28:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.139.153 with HTTP; Thu, 26 Oct 2017 15:27:26 -0700 (PDT)
In-Reply-To: <f56a02d6-fbf9-188f-d19f-3d48708d9268@kdbg.org>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
 <eda48d5e-a52c-9a39-8e55-a6828efdb3ef@kdbg.org> <alpine.DEB.2.21.1.1710251415040.6482@virtualbox>
 <5e962f69-f9cb-bd7e-481f-050e6239813f@kdbg.org> <30ED36AB-FAB1-4635-94AF-FCEC6F02CE01@gmail.com>
 <7a4396e8-7b97-9ec9-d028-c5ad29042c86@kdbg.org> <20171026203046.fu3z5ngnw7hckfrn@aiede.mtv.corp.google.com>
 <f56a02d6-fbf9-188f-d19f-3d48708d9268@kdbg.org>
From:   Ross Kabus <rkabus@aerotech.com>
Date:   Thu, 26 Oct 2017 18:27:26 -0400
Message-ID: <CAEVs+zbq_zcYjyoCPE=W3LuQxAtRz8G+qLXA31jUiw+b4A4kSg@mail.gmail.com>
Subject: Re: Consequences of CRLF in index?
To:     git <git@vger.kernel.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is "* -text" in any way different than "-text" (without the * asterisk)? All
of my .gitattributes files have "-text" (no * asterisk) and I haven't noticed
any difference but could I be missing something subtle?

~Ross
