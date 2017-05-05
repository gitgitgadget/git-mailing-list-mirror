Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33FCF207B3
	for <e@80x24.org>; Fri,  5 May 2017 22:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753260AbdEEWfn (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 18:35:43 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35643 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbdEEWfn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 18:35:43 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so2204580pfd.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1MvGXTjCrDMu2IPQhwTWHmVwmO5qxlifXx8Mpt7r0mo=;
        b=Nb3HsZExwxcyXXF247DEWXPqQiCf6CGfHnRM0tv/XRx9lZhVWwAFt3boDpvrZXx0jW
         UoCFp/VCPL5QoKV6L30nJ7o+5BIEvuiTaIfBih7KkfH8atjlqgMsWMArTq+dJN3HOrew
         ewDnjScZTkuKQc55Hn9uFz+xqokwCZUybQmiltQt00lz9gJYPLWfDeDipl5K1deWHjiD
         GYMImf6NTxKFollHWGBOQW8xWRhoCfL34E1DUUfbgRsLXpM/yeqi1OBda77jdTZQ0cSj
         q4tOxfz3GM2oh2S8SkSaVGrcJW9LHoq37gOekLj3ABjoC2Oiu3m0WkpPY7oMlPB7ZkN6
         mj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1MvGXTjCrDMu2IPQhwTWHmVwmO5qxlifXx8Mpt7r0mo=;
        b=JEAwxFsAbGolHL3UhbY1A4PdN0dMptG+yYNGDvao1xOs9Jt8KjB9jEkHpBMym0MBhh
         l07f/DVNjgEbKmdSjHiqArj6tY5wWg2EylqEcxFO6fwcDxwe8s+WebH89WoPKShM28ZE
         /ZwOF2rR6NE7q4W+toTgdC7+xGUNiaoe7/pckp28d3mrM0G50a6WS+PdqtffZaEhOloB
         Jv3ZKKYkChNesxJ6JXuDi72lAZRTxoN+oswol1eqQsmH4hMPJO3nMK5UbpG8QU20HJXY
         sfpPWK9ThZjBH5J8NaTcmjzrSase7Sxp+ukekD1mSBJd0bDBLzR0afP/gCj4ZJQ6rK/5
         0eiA==
X-Gm-Message-State: AN3rC/76sApJmDZsLVukXb2Gv/CfCFqNZsrsXLEo1wbOgokeoyh/93bw
        YYZKsVtqD23DRAtUiWk=
X-Received: by 10.98.166.21 with SMTP id t21mr19677670pfe.120.1494023742356;
        Fri, 05 May 2017 15:35:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:5d98:2d3c:6099:849])
        by smtp.gmail.com with ESMTPSA id a184sm12856176pfb.118.2017.05.05.15.35.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 15:35:41 -0700 (PDT)
Date:   Fri, 5 May 2017 15:35:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Daniel Ferreira <bnmvco@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Port git-add--interactive.perl:status_cmd to C
Message-ID: <20170505223539.GI28740@aiede.svl.corp.google.com>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
 <CACBZZX6oTEToPPFF0LpAXBCru9_B+VcaBL=KQUjkUhNdyanF1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6oTEToPPFF0LpAXBCru9_B+VcaBL=KQUjkUhNdyanF1g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Fri, May 5, 2017 at 8:43 PM, Daniel Ferreira <bnmvco@gmail.com> wrote:

>> This series introduces git-add-interactive--helper (or should it be
>> called git-add--interactive--helper?) as a builtin capable of doing
>> what the Perl script's status_cmd() would do.
>
> The existing script is git-add--interactive.perl, so
> git-add--interactive--helper.c would be consistent with that, since
> there's no git-add-interactive command.

Or git-add--interactive-helper.c, or git-add--helper.c.

The important thing is that there's a double-dash somewhere.

Thanks,
Jonathan
