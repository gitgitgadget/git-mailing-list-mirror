Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A23E91F404
	for <e@80x24.org>; Thu, 22 Feb 2018 05:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeBVFXL (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 00:23:11 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34607 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeBVFXK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 00:23:10 -0500
Received: by mail-io0-f195.google.com with SMTP id e7so4694951ioj.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 21:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yt8NPGXbqNgl0Hkadv4dHlaLcYHqknKY72H9GuI+Shk=;
        b=p3Hte9CCPz9EJIcjSvFVPPonBSbYorSRH+fcAf/WDdxNI4TLfhmL2EKYc6oydZs06v
         sJACkRj2rsPVVsuDMGAejXPZVvFFe+v3YqBE0ke7GnWmAHw3MrmB0NR9Ap+2eYjyAIjY
         iMUekKqMzMQLjrJBmeDnz8mZqJFoJrEyF22+NmUtkgbgpreNibvkg0ZZRSrixX/BU6Go
         NBqF/4w0Hf81fHCZnwUWImzYZmfPp3qdggR07MdauUYpSaKEYvxMEbXzafm70Qg9C0JL
         X1BUxlkCIPBx4ak8I/kG1sQgSMGTtx2QJmPlyLY2pRSb7JVBK7F/mqOB5UX6biSwrsle
         mutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yt8NPGXbqNgl0Hkadv4dHlaLcYHqknKY72H9GuI+Shk=;
        b=MlRtCPzq21nUHewThXQiSKOqvf5OIor1p3Nw/Egkmte5ozPwVvwKgGGwoJUICox7Y0
         PAj34SXTiBZuXp8f+LkPRn2Vuz+uDigiArk7kjbqCXyJRu3dDHi1cZdVgfhYPRC96uaz
         2PGmZ43aKjdC25QYOPXJs3wQ020vPoxkLjyZ5XnVzZR7xdnW61fEdfFQMNeVbcTj+GrK
         WfzBQP/Ck5vePfbqU84cdXQKClhMh+eHLztCe1FZa44IgaWlu0xj9lxCmJD6bVpEEnYI
         HYxHx7mgDVPfys/9xQA1bLlVG6aDkbAYmVlGdc5Cp6ZHALp3m6C+DGglACAM8J8alyhY
         xH0A==
X-Gm-Message-State: APf1xPCiSerpDR6SmOX7vz931pnqkbbvTX75JW59/z4RsCdlKdejBevR
        xlUEgmCvRlkUgW8Nbnmd6PYNpavl
X-Google-Smtp-Source: AG47ELtCIuD+49G66biTE5URep5KOtI8o4oykL1/Lmi5NLx71rUoKl1l0U+37hxR0pg40IAFg7PNPg==
X-Received: by 10.107.50.210 with SMTP id y201mr6981733ioy.224.1519276989580;
        Wed, 21 Feb 2018 21:23:09 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a188sm6111588itg.30.2018.02.21.21.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 21:23:09 -0800 (PST)
Date:   Wed, 21 Feb 2018 21:22:27 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Raining Chain <rainingchain@gmail.com>
Cc:     git@vger.kernel.org, git-for-windows@googlegroups.com
Subject: Re: Bug Report: git status triggers a file change event
Message-ID: <20180222052227.GA133592@aiede.svl.corp.google.com>
References: <CAPaSTm=Vhg+S0Cf7rkcvXKH1eaEbw5aGOfCmtU7K3D+1kc-pGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaSTm=Vhg+S0Cf7rkcvXKH1eaEbw5aGOfCmtU7K3D+1kc-pGg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+git-for-windows
Hi,

Raining Chain wrote:

> On Windows 10, git version 2.16.2.windows.1, running the command
>
> git status
>
> will trigger a file change event to file C:\myPath\.git  "Attributes changed."
>
> This causes problems when using scripts that detect file changes such
> as tsc -w (Typescript compiler) and using softwares that regularly
> call git status such as VisualStudioCode.
>
> Thanks.

Can you say more about how "tsc -w" reacts to the file change?  Is there
a way to tell it to exclude particular files from the files it watches?

Thanks,
Jonathan
