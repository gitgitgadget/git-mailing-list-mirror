Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FEC320953
	for <e@80x24.org>; Thu, 16 Mar 2017 20:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbdCPUYm (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 16:24:42 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36402 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbdCPUYl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 16:24:41 -0400
Received: by mail-pg0-f46.google.com with SMTP id g2so30254599pge.3
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=Wa4cERawlh/pASxq/MK+H1FAysnr1BCPclZi8S387HA=;
        b=WtMlSFDIoivR+JN+JStN3UwQT5wahYVTBMzbF0nVjjuk99FNdBY8OIrcf8EpuQOMR1
         uivY+pBS60FILvr8KiABlvnByDLNd3srh+gkPYmf3agZ4X5ZY2re+YLvWJyFXSaMV0Fz
         7ydLX0/Qcr+AVXEqHh5/Bq2FPMIVQhaV/txEAG7zySWHTu57qNok3qDri6JBatWQl7vn
         Qe8hi+dNXArFDAmvb3m4A/XFPOaOTlHfn0e15YkEhJCnmx5E3QBCQ1FktlGkNtg6gqS/
         5cdEJJ6FVPErT/+CVegS0tLbQRdXHvg3xhwKadaMGoNfSaH46dO6fvE82tyjhoOa8t9w
         RuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version;
        bh=Wa4cERawlh/pASxq/MK+H1FAysnr1BCPclZi8S387HA=;
        b=A14tAXmSlanFYQhCYMbroCBiEx8MffBrY80A6pxwXlvzlWjcMxc7C70wAOH9zVwxRf
         vmK3yt0fP1NTXdpviNp9UD2schPoZim88pjtQxeqzA2kP8ah+0XEF5PNBjdZEdMYw7vQ
         jlDTbu03nU3HvF3i7Y/u/iDun5fVJRwHYNHnk0e2wBIdA0cjH19QPLwsCvlAMipAhz3E
         Ioy+qIYfzgM/fqfJR2w5/B8PfT7fyGOxWJOAKzJChE3+P5KFDHLDiqt65+yYhpnTbiTv
         YU9djQwnl0fLS8jZa5PJIYUwHkfXV/GghxYp+ZCAOcyYaOIBNvkEffVP6znlzFOkCIV2
         Zdaw==
X-Gm-Message-State: AFeK/H2XamcAy6ebZi/knKh31pAWjTonCAyrmpqf+Sor1TTr6NvPJrNfrZ9enK61c5dvGw==
X-Received: by 10.84.191.165 with SMTP id a34mr14658230pld.62.1489695843977;
        Thu, 16 Mar 2017 13:24:03 -0700 (PDT)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id z27sm12230562pfg.38.2017.03.16.13.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2017 13:24:03 -0700 (PDT)
Date:   Thu, 16 Mar 2017 13:24:02 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/2] Re-integrate sha1dc
Message-ID: <alpine.LFD.2.20.1703161315310.18484@i7.lan>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I suspect the first patch will not make it to the list since it's over 
100kB in size, but oh well.. Junio and Jeff will see it.

This is sent as two patches, just to have the original upstream code as a 
first step, and then the second patch does the small modifications to 
integrate it with git.

It "WorksForMe(tm)" and the integration patches are now fairly trivial, 
since upstream already did the dieting and some of the semantic changes to 
gits more traditional C code.

I did leave the C++ wrapper lines that the sha1dc header files have grown 
in the meantime, I debated removing them but felt that "closer to 
upstream" was worth it.

               Linus
