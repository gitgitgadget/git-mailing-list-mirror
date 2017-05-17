Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677ED2023D
	for <e@80x24.org>; Wed, 17 May 2017 01:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdEQBij (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 21:38:39 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35574 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdEQBii (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 21:38:38 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so21775584pfd.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 18:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=42WZNUPamJIHpOu2Ryhezal6UP4wukYDI+V1wDsz99M=;
        b=Q8W6vvtwJYR5g0hiabGrbIXsZQ4a5bdosqs/jmXDxHPO7zr2B/FMXZXPw9uaIm5SdT
         qSTlo/SZoorjS7zu2Sr6cp7HaR3FbFKS7G0mHhHp2SqTvy0PfDGzuHmbjXCBK/+xolQP
         oo1V5BG1W0J2QWiQZniL9Lr5F1IUuCAuhXCsLMqLaR3fIhtFtxg2K4EznILRwPz/fM9s
         sxUpaS3TyxqG/wFfIcFEotxHaDaYG/hfc/rNx/PpFa7zUxb/veF/JYK8hmx+E/wix5d9
         cBIPTVAruJsBykkzAShekggjAnpLWXINJBH7FHTHg/r8Ix6Er0iMU9mx5TgE46fqx3EB
         /okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=42WZNUPamJIHpOu2Ryhezal6UP4wukYDI+V1wDsz99M=;
        b=oggON/wix7Ss84uaPiLMeI3u/sYOnLH2anVORSedIyorzX5JqIeU+J5bNnLpNsUs68
         OBTSm07lU6yyUomX8u+5FuuOSNXYRMvpQulSAc8wWMor3Z2MQJed9fG2NrhU0rZ1YK7p
         5SLInplYJIzzPwqODvMUWnDkUBP0erfE/v/f/Xj2WWWCEr/Ha7iiUhZQu1ha2/Jq6Cli
         qwFHFqgqEkULaclknhvRsKghZpHNty8eBBgdW47WuIH/w9zc4qyRY6dmOq0cFsqzd6qu
         /Nv8ozGModcBaCe/AMWF0Dv1Th3G4LP9FGWzfalVDevOTxk6lo+BGtvVf/JpgtS9Cs3J
         CYiQ==
X-Gm-Message-State: AODbwcDd0BDrdBmOnOOpFNpTfwyw7qbn2P/vGPPbOUDr4D/mjwGYP+OA
        jYMyystDf4mGkg==
X-Received: by 10.84.217.215 with SMTP id d23mr1175250plj.114.1494985117962;
        Tue, 16 May 2017 18:38:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id s18sm481087pfi.16.2017.05.16.18.38.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 18:38:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] Demonstrate and partially work around a gitattributes problem
References: <cover.1494861793.git.johannes.schindelin@gmx.de>
        <20170516075418.m3knwvdsr5ab6vzy@sigill.intra.peff.net>
        <20170516081023.lh3zflnf473jiviq@sigill.intra.peff.net>
Date:   Wed, 17 May 2017 10:38:36 +0900
In-Reply-To: <20170516081023.lh3zflnf473jiviq@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 16 May 2017 04:10:23 -0400")
Message-ID: <xmqqshk4z2hv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/diff.c b/builtin/diff.c
> index d184aafab..8ed1e99e3 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -409,7 +409,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  			if (2 <= blobs)
>  				die(_("more than two blobs given: '%s'"), name);
>  			hashcpy(blob[blobs].oid.hash, obj->oid.hash);
> -			blob[blobs].name = name;
> +			blob[blobs].name = entry->path ? entry->path : name;
>  			blob[blobs].mode = entry->mode;
>  			blobs++;
>   ...
> -			add_pending_object(revs, a_obj, this);
> -			add_pending_object(revs, b_obj, next);
> +			add_pending_object_with_path(revs, a_obj, this,
> +						     oc.mode,
> +						     oc.path[0] ? oc.path : NULL);
> +			add_pending_object_with_path(revs, b_obj, next,
> +						     oc2.mode,
> +						     oc2.path[0] ? oc2.path : NULL);

The fix is surprisingly simple, and I think it definitely goes in
the right direction.

Somehow, it bothers me to be forced to view (a_obj, this, from_sha1,
oc) vs (b_obj, next, sha1, oc2) as a sensibly corresponding pair of
tuples, but that is not something your introduction of "oc2"
started, so I won't complain ;-).

>  			return 0;
>  		}
>  		*dotdot = '.';
> @@ -1574,7 +1578,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
>  		verify_non_filename(revs->prefix, arg);
>  	object = get_reference(revs, arg, sha1, flags ^ local_flags);
>  	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
> -	add_pending_object_with_mode(revs, object, arg, oc.mode);
> +	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
>  	return 0;
>  }
>  
