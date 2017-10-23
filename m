Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A00EB202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 21:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbdJWVww (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 17:52:52 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:56302 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdJWVwv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 17:52:51 -0400
Received: by mail-io0-f171.google.com with SMTP id p186so21704969ioe.12
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zzt7r8HxT7St+QllmzEGa5ZbX0AxreQ8mxFasW/UN7s=;
        b=UeU09t4LpiKJ2ScS5OPo3I+7DwjMYq/AgQurOTVhwOeSigarBbYtS11AxhgY9cb2BF
         hub+nSgbVfRidvGqva++EWKb16zvjozZ0X8vH7QY5UAypQlTPUMlvZ1KNnquypxw1dQ1
         vsJC+xV8znbcDOkelnZNEA03SAQ5EeTg6mN8g3Ebs7AL5OxGt1lgZQZoIzvEU96ofw2I
         XngnZdgrpXCC97kLhvoR31ne7wPe9R+vFWw4IaFR+lnrhEex3ppSQA/15ceDs7+l8spr
         6YADul3HjK0Y/FY8kB6dx96fXYENiNMLGuLxu0qHkxeaHmzastMlddqfhdDphMNRknO/
         vmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zzt7r8HxT7St+QllmzEGa5ZbX0AxreQ8mxFasW/UN7s=;
        b=Fky+AQkYLWYsdgJoEADAAWNwSrC5N38FyPlgF0/FwXquMUKldD+//FW+mbkLp/L1qm
         BmdzEuGsmbGFVoGMShm3JGhoPbRjYa+I3k7XHu98fG2MXoRM/JgvdMFzjAaB0s0Xp2Aq
         vm5mMIIbxUgMZRayWA/lWfe/Oq9bq8MZ6BdcKir30t3sepxRJEyFiibVQenuNQBeO7AV
         rTOQLMOmOYgg5XAF49m3VHlM8YTlrbhGB4CF9BjmDObVgfENVnOOapr+rIiNCaT3zhMI
         RC89oM81OqzZYR2WS5CqUyvZ/RolOLbkyO4pAUHCuJmCMlJ/HLj6u7s/2mxpFw5wLz4f
         h1nw==
X-Gm-Message-State: AMCzsaX4EhALTlmos9cCR/ncHaXExfInLvZJ0or7EcikpWcuLeQbU5p1
        aRY3xlnQL6pIJ5gYCpZ0TIe2q1pq
X-Google-Smtp-Source: ABhQp+RXZ7OabC7JLTcljzukoPO1hfJ1g8ynMEU6lhyThATwxl3+fwcefXoqG7DIykNn6K0gxdfNWQ==
X-Received: by 10.107.222.17 with SMTP id v17mr19090164iog.283.1508795569096;
        Mon, 23 Oct 2017 14:52:49 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h20sm3500885iob.65.2017.10.23.14.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 14:52:48 -0700 (PDT)
Date:   Mon, 23 Oct 2017 14:52:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org,
        Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] column: show auto columns when pager is active
Message-ID: <20171023215246.r3xevx5jey5pyuuz@aiede.mtv.corp.google.com>
References: <20171011172310.2932-1-me@ikke.info>
 <20171016183511.12528-1-me@ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016183511.12528-1-me@ikke.info>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Kevin Daudt wrote:

> --- a/column.c
> +++ b/column.c
> @@ -5,6 +5,7 @@
>  #include "parse-options.h"
>  #include "run-command.h"
>  #include "utf8.h"
> +#include "pager.c"

Should this be pager.h?

Thanks,
Jonathan
