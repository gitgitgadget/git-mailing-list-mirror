Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8A020281
	for <e@80x24.org>; Thu,  2 Nov 2017 22:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934511AbdKBWbH (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 18:31:07 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:55617 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbdKBWbG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 18:31:06 -0400
Received: by mail-wr0-f174.google.com with SMTP id l8so930085wre.12
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZsxBm06yzgw7rXOQnpMB3SBGi2JGW87cfbjej5q8JO0=;
        b=KGaE3IUjDIQm3Ni2IXws5OkwtHA/nXxU32fwOvfpdvcs48lgSZTz4s/1W/1qYg7r0e
         PEahuBXJzOqGo5RDz40RBrB08gdX6JCS1XU3/kADeZ3EfdcROj/OxV9H9c//B99ll+MN
         +41qywQ9cOBV2Z/qXNRLm4bbE/eDj3dvNiF9CGanyq8NeJKKjlODB2H0TWQWefZX1uE8
         WO4CXrWE9WrZziUU1Rpn9iBvTHUvDt6V+7HI3JYC6DaysERTpDYnVyBkkjmzCqSml20E
         4L3sxSTch7s/C8/B0SegeFn9Y7L/7fp+FzPfb9jMpLBiMusyIk87+FlSfdhKvXbKn0/5
         MXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZsxBm06yzgw7rXOQnpMB3SBGi2JGW87cfbjej5q8JO0=;
        b=tcyEgxNiuqGFBVR7/WQaRXlTytqdTqhI73URevQHkRJRWmmqCtgV2nVQcrPn5yvyC+
         zMaRc+AFWW17Q2wwmt6uYxQNYx6Tstos5lr2MfSUOpDVsCEqb9tCoBX7zfJ+SgG+QVbK
         d2AbGBPa4l4sQKVWs/zsT4zgyXe2qH4Xh1UDOmEsp0+Nz/+zlCsiyMFLV4NnUtYyFLuu
         6xp2+Bc3gU6GjKXV8Ou9WkSHJ9UnbVEtPaIoFfQF8lOBPL4MaesrtpuY+KFe7QKPfeth
         qL79e8u4jfRTds1bdICxIA02YMJBghhDg2PVN4KwVcQS+ukK3RHACKY5PS0dd/+5RHuo
         +/eA==
X-Gm-Message-State: AMCzsaWI2TqssBLfn4jFkPHkqBKiTAs05jLwkJ3rN2/AdgNO8SY6nq1m
        kyBRMt0wwZLQwqZE7kjrMgT7dX6d
X-Google-Smtp-Source: ABhQp+THx8cwSjN2xS/ju1a755ZKWu9Mgt0f9nNdYf4LMJb+PFdP0K045sEbx1h9/pkJ/6u4L5pqyQ==
X-Received: by 10.223.195.131 with SMTP id p3mr4522244wrf.89.1509661864818;
        Thu, 02 Nov 2017 15:31:04 -0700 (PDT)
Received: from laptop.local (host-78-145-151-122.as13285.net. [78.145.151.122])
        by smtp.gmail.com with ESMTPSA id k13sm8086800wrd.95.2017.11.02.15.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Nov 2017 15:31:03 -0700 (PDT)
Date:   Thu, 2 Nov 2017 22:31:02 +0000
From:   Thomas Adam <thomas@xteddy.org>
To:     Antoine =?iso-8859-1?Q?Beaupr=E9?= <anarcat@debian.org>
Cc:     Thomas Adam <thomas@xteddy.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 7/7] remote-mediawiki: show progress while fetching
 namespaces
Message-ID: <20171102223102.j3niifmupcs77p3r@laptop.local>
References: <20171030025142.19421-1-anarcat@debian.org>
 <20171102212518.1601-1-anarcat@debian.org>
 <20171102212518.1601-8-anarcat@debian.org>
 <20171102221807.juon446b6zfw64cq@laptop.local>
 <87vais48rg.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87vais48rg.fsf@curie.anarc.at>
User-Agent: NeoMutt/20170714-87-e4144b (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 02, 2017 at 06:26:43PM -0400, Antoine Beaupré wrote:
> On 2017-11-02 22:18:07, Thomas Adam wrote:
> > Hi,
> >
> > On Thu, Nov 02, 2017 at 05:25:18PM -0400, Antoine Beaupré wrote:
> >> +        print {*STDERR} "$#{$mw_pages} found in namespace $local_namespace ($namespace_id)\n";
> >
> > How is this any different to using warn()?  I appreciate you're using a
> > globbed filehandle, but it seems superfluous to me.
> 
> It's what is used everywhere in the module, I'm just tagging along.
> 
> This was discussed before: there's an issue about cleaning up the
> messaging in that module, that can be fixed separately.

Understood.  That should happen sooner rather than later.

-- Thomas Adam
