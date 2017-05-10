Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7895D20188
	for <e@80x24.org>; Wed, 10 May 2017 23:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754534AbdEJXag (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 19:30:36 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35553 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754197AbdEJXaf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 19:30:35 -0400
Received: by mail-pg0-f46.google.com with SMTP id o3so5081184pgn.2
        for <git@vger.kernel.org>; Wed, 10 May 2017 16:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Yl5NktAfId/V0VBd55jPQvYb8ib01kknvvRbZAwNBms=;
        b=Wo6HAA6HKEQHFwNYeCXgVtOQHcRnLkdGTDQxSwfLAq+VsDdAfYqBQv43FaC08YY54G
         GOF4S4rsxrE43geJDpS3BnKC/scZgGuZ06ml7ACp2w3Rp+8sbN/Ixgv5c+k8rLakjwRF
         Ru08bgRQqZiFQ4wOvOZKSlCmMefx1CZoeZIVlSDe/se1YUyghQGn20mOUuNbCzG7wsK7
         L9PR7+xDM5Hlw5a+aEJU15rcW9kO+V9xl/W/7LVxKpz9jfHO/xyem4biTeND5LH434sl
         FuCoMsCiUQNjOUOS3LzdPrv4CxfiJgpcjfuAl+IW9HGljz+jHQPUx1yq6kplTEPPNGK+
         RMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Yl5NktAfId/V0VBd55jPQvYb8ib01kknvvRbZAwNBms=;
        b=Rn121IaFJ11HtQgxc9nrm+6dtwr6O99LH3Af6Tk8QOkw8+3u2+lRKNDtlUkRyNKIfs
         W7+MpI6BGGV0LQ6ImpbMPBDOVwgqHUC+y8ziyF4sMmCwauqBhzker2ky0SoFjwoxp1pW
         KNNMa/tt5zyuhvrUeHCFTZVaDBb2HTeawvYreoyTtSJWBQwgJqbzd6kfzwg43PJzD7PX
         esqiQFUTcDPky32wbucc1ZdrL+L0iUtJ82lGntNRQDaieMF+hQt4SyYa7ODCWrmsyjpp
         bDL7Rg/8crfDTOXOjO9mmboPzpEaNW2UPdktge1SDKrEIenteArbM0OAllkRTCM9vtim
         rxHQ==
X-Gm-Message-State: AODbwcAAkyeS9Cc5rGU1FRVmtPmCWA3+m8zBPV2c8dq/x6DB+Zjnlby+
        L/Bewgf48sA1Gw==
X-Received: by 10.98.93.27 with SMTP id r27mr9053999pfb.103.1494459034854;
        Wed, 10 May 2017 16:30:34 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:55dd:a079:3f06:9176])
        by smtp.gmail.com with ESMTPSA id y63sm7592pfa.107.2017.05.10.16.30.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 16:30:34 -0700 (PDT)
Date:   Wed, 10 May 2017 16:30:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] perf: add function to setup a fresh test repo
Message-ID: <20170510233032.GD28740@aiede.svl.corp.google.com>
References: <20170510225316.31680-1-avarab@gmail.com>
 <20170510225316.31680-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170510225316.31680-2-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

[...]
>  # call at least one of these to establish an appropriately-sized repository
> +test_perf_fresh_repo () {
> +	repo="${1:-$TRASH_DIRECTORY}"
> +	"$MODERN_GIT" init -q "$repo" &&
> +	cd "$repo" &&
> +	test_perf_do_repo_symlink_config_
> +}

Unlike the other two variants, wouldn't this leave the cwd inside the
new repo?

In other words, I wonder if the commands starting with the 'cd' should
be in a subshell.

Thanks and hope that helps,
Jonathan
