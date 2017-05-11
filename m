Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38402201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932876AbdEKUFS (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:05:18 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36431 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932585AbdEKUFR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:05:17 -0400
Received: by mail-pf0-f171.google.com with SMTP id m17so18860348pfg.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nQhhSogqGU7zx9PwS/u9ux5CKJzp8pnd/lzwNC96Esw=;
        b=haXdNcubn8XEvHF2pTOyHmopmlw4Vkd7zvA9Kvv29ixgwfglNWVZOi/7XGtHrX0+Nq
         b/3w21W1f4WPZrP//ExING5jXohMVixHYGjObAdfhBOs/VSuqHZ8BuTO6SWHGsyUj13f
         e8FNDySF2+CxPw1WmUMAZg4mNcOSd5t+smexBIVAL8kt/mdgFYzgA6dEq0G+40qFRP9O
         zrIUhPCbOgVk5ZpOMpiuI1iqaSIM/3Bj6jzI9D8QPQKwAJJBRdM0EzHrmW0kle98Mq2O
         R4PdVIqrslzA/h85RA8OGLC0h6Hd8NYq0bKzWvGGLHRPAp+R/VAjmEIiyU28L9xHIGFe
         sdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nQhhSogqGU7zx9PwS/u9ux5CKJzp8pnd/lzwNC96Esw=;
        b=WbnK7MU/XOtzv9cY9/PTSCdGPd/UxTg5aaFd5HGHg+uFFrKwSgRNxBTA9l+vZxNuWe
         5VLXJU3yVWgJVhBt0LG+7qfrpDYpjYe9a7pEcatGCtcUUW7sj3lrIoUinY6XBuhyzEJy
         B0SvpIYnpB3q4loIG9R3o5TcWRL2Fnq/6NUTL0d2n5HYLN4XgflulYcRupmt+jRvAfDi
         MsL94sVgs9ZyN9y/PBFB7Z3OEGe+/2X+oUcb+d8SlsqbAj7HN8q+jHGcBQaE9UsWGH3l
         4BgYY6pP4xcChEQT3UzPl/88tKLCN0zFT3aDl9z5/CAVSO106YmJzho2I5YanAtfL2wI
         w3gw==
X-Gm-Message-State: AODbwcCW+VPilrKIgaYAe+vSwJol8KLaOA64DsjBCH+Ges3mMTO+hds9
        xBXnl/aJr/fPR+tk
X-Received: by 10.98.67.140 with SMTP id l12mr309495pfi.110.1494533116494;
        Thu, 11 May 2017 13:05:16 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id y6sm1557048pgc.40.2017.05.11.13.05.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 13:05:15 -0700 (PDT)
Date:   Thu, 11 May 2017 13:05:14 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 07/29] grep: change non-ASCII -i test to stop using
 --debug
Message-ID: <20170511200514.GE83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com>
 <20170511091829.5634-8-avarab@gmail.com>
 <20170511183109.GC83655@google.com>
 <CACBZZX4mhhx3i2crQbON-_UEHMBRfw+FHQctiN9gU2pHQrvCng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4mhhx3i2crQbON-_UEHMBRfw+FHQctiN9gU2pHQrvCng@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Ævar Arnfjörð Bjarmason wrote:
> Thanks a lot for looking this giant deluge of patches over.

No problem, I'm no expert in some of the areas you're touching but
at least I can catch little things like this :)

-- 
Brandon Williams
