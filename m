Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D791C2055E
	for <e@80x24.org>; Thu, 26 Oct 2017 01:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbdJZBds (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 21:33:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:50280 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbdJZBdr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 21:33:47 -0400
Received: by mail-pf0-f194.google.com with SMTP id b6so1306549pfh.7
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 18:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2kgi1CjN8Q/PDF103XWUqgyTDrrayBSGr93nm0gdonA=;
        b=LG6FSbNk7nS/3KR6Jnc90mn2tqbhLSLwUKJxSfgJLGWRMSeDg01OySfNFE45VF55iQ
         dPHZkA35ZoLUUx6ZUR7yLzdM04RNrARDMXwJRxm2DQ091YnyZ7lSpiPhBSPW15Gh3Me2
         W06IWV2KK5FKKaW/LOXXa2x/o3wLM09tVzlzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2kgi1CjN8Q/PDF103XWUqgyTDrrayBSGr93nm0gdonA=;
        b=TxhUL3EsO0i5x4gUCJr7rLno3F3mPmH3RVdEPb52RaM/laP+0J3zM05b4rB6ZYn4vR
         GvZr6MSN5X7ynNmWxi7kUIdIKOlj7GWZceopGagNeAZO2SdeDOVCrSA6KV9TQXnGrkpt
         vV4xYkM6jVO5l1T/k9q9ARkqioSPKwT8rQzjfNH8CjcOZFxWa/WhrWIeynFmamj6TjQk
         +XmuyENhrkI9G+Ew2NCmZJFtoB5HpSgZ8u174NVfSkEpzXfA2Ug+rvvpKb7EMn9tsmbX
         8AqjgTUc2M5RvCmk1//WVmOpkWAWLKa+MF/yujoOgyp23884amG/WLrIIBzgVvXPCpuY
         ALvA==
X-Gm-Message-State: AMCzsaXjnE16zwMGSHG2vo+aSnJg3R6zrBKbtvppp+w3miJENJOzNmao
        3LdShK9z+udcESzXgxuh575Ar1KkRRw=
X-Google-Smtp-Source: ABhQp+QmKsVB84rM8rMX8djGQWYpPHpKiZ09gOJXRAW+g+acEqetZOl2ac/5CjEnEHlzuhOghhfFcA==
X-Received: by 10.159.194.133 with SMTP id y5mr3100278pln.85.1508981625908;
        Wed, 25 Oct 2017 18:33:45 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (Guest-GW2.corp.dropbox.com. [205.189.0.166])
        by smtp.gmail.com with ESMTPSA id s65sm7803110pfj.81.2017.10.25.18.33.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 18:33:45 -0700 (PDT)
Date:   Wed, 25 Oct 2017 18:33:37 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     git@vger.kernel.org
cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v2 1/4] fsmonitor: Set the PWD to the top of the working
 tree
In-Reply-To: <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com>
Message-ID: <alpine.DEB.2.10.1710251832180.9817@alexmv-linux>
References: <20171026013117.30034-1-alexmv@dropbox.com> <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Wed, 25 Oct 2017, Alex Vandiver wrote:
> The fsmonitor command inherits the PWD of its caller, which may be
> anywhere in the working copy.  This makes is difficult for the
> fsmonitor command to operate on the whole repository.  Specifically,
> for the watchman integration, this causes each subdirectory to get its
> own watch entry.
> 
> Set the CWD to the top of the working directory, for consistency.
> 
> Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
> ---
>  fsmonitor.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 7c1540c05..0d26ff34f 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -121,6 +121,7 @@ static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *que
>  	argv[3] = NULL;
>  	cp.argv = argv;
>  	cp.use_shell = 1;
> +        cp.dir = get_git_work_tree();

Looks like my editor swapped out a tab on me.  I'll hold off on
sending a revised version to collect any other comments.
 - Alex
