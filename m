Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C4F61F424
	for <e@80x24.org>; Thu, 21 Dec 2017 20:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755698AbdLUUsq (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 15:48:46 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:46372 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755689AbdLUUsm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 15:48:42 -0500
Received: by mail-io0-f195.google.com with SMTP id x129so22407111iod.13
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 12:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lqljw7mGo9zaVj3qcwymytlMU1kfCRi7Tmg6EfDuPyU=;
        b=WEfaZ8zpK9t0/G6X3/txC/cusRFDaC3qp6Nj0Dkd41oGFjPh9FoOk+8DXeCbXoTv3c
         n93jZc4qYimHHHsznCy4gQjEvvokCjO97T3E10y5JPQYeI7zY7+fZQe6kXWj3Jaaz6G8
         4LUkPTAqdPPvM6jtwzWVA6YL2QXYDwB7LQOqTSSNzgcnADxnYrBMbSn0ZzLiRME7YYp9
         X+WuAYA7cqKNtu+Iz6Hfjz3vZmgnrdbP2eyU3NRVtbJpQobNb3zqtNM6f7ZzCDCRJnPO
         jdGxyRTVTXeeeC/fOOuX/B4OE6+MyaUqkVvM1b3r21aNkhZDB+bWBqbYSTkBKwNF4PeU
         RuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lqljw7mGo9zaVj3qcwymytlMU1kfCRi7Tmg6EfDuPyU=;
        b=M3RR1Zp9raYyrZY75lA+/0RNFiyBjvXOqcYNJjzwEWUj0/e/Z+c16mMOmxbxkNJpBT
         7jSoUksm20Y+M/wyhIKFQZdnwe8EBvBhWJCgxvs9vHyO4tciBsjJrNGywIzN5Yop5tJH
         c8lJhucr7itv9g4z75ZG+fl+w73ZvRXZU91Aoht0Ubl80lue2ZXdII/0FL+VYONgBNPK
         BNLAwxm32mDRZ/cjtPdVFMZ9GrLXpy28+emE2aASm24Yi3X7Vo6MEVPAlD8nIDWtkBNn
         5wUj26yESdVb10QDcr9xJiu24oK51CcSXC2XFjlInnHliINbV+MHhnfzSJT1F8DYHcBC
         qmaA==
X-Gm-Message-State: AKGB3mK8yh5oYWOsjDOvrmvseWCvbUlyphrRTr37csJ2fjxekCeQrO6h
        O+g15onMattG9jLr9GhivJw=
X-Google-Smtp-Source: ACJfBovhFuOc/JXk7rL+pOuA55RJj3ARaxDNCDJb72sPmJaDnB+7dlgKt3ExdDTB+Stb2ST3omu//g==
X-Received: by 10.107.137.146 with SMTP id t18mr1924765ioi.258.1513889321210;
        Thu, 21 Dec 2017 12:48:41 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v9sm5078880itv.35.2017.12.21.12.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Dec 2017 12:48:40 -0800 (PST)
Date:   Thu, 21 Dec 2017 12:48:38 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 2/5] stat_tracking_info: return +1 when branches are
 not equal
Message-ID: <20171221204838.GB58971@aiede.mtv.corp.google.com>
References: <20171221190909.62995-1-git@jeffhostetler.com>
 <20171221190909.62995-3-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171221190909.62995-3-git@jeffhostetler.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler wrote:
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1239,7 +1239,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>  		*s = show_ref(&atom->u.remote_ref.refname, refname);
>  	else if (atom->u.remote_ref.option == RR_TRACK) {
>  		if (stat_tracking_info(branch, &num_ours,
> -				       &num_theirs, NULL)) {
> +				       &num_theirs, NULL, ABF_FULL) < 0) {

What does ABF stand for?  It made me think of airport codes.

Would a name like AHEADBEHIND_FULL work?

[...]
> --- a/remote.c
> +++ b/remote.c
> @@ -1977,16 +1977,22 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
>  }
>  
>  /*
> - * Compare a branch with its upstream, and save their differences (number
> - * of commits) in *num_ours and *num_theirs. The name of the upstream branch
> - * (or NULL if no upstream is defined) is returned via *upstream_name, if it
> - * is not itself NULL.
> + * Compare a branch with its upstream and report on their differences.
> + * If abf is ABF_FULL, save their differences (number of commits) in
> + * *num_ours and *num_theirs.
> + * If abf is ABF_QUICK, skip the (possibly expensive) ahead/behind

Please format these comments as paragraphs, with a consistent
line-width and a "blank" (space-star-newline) line between paragraphs.
That makes them much easier to read.

[...]
> @@ -2019,6 +2025,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
>  		*num_theirs = *num_ours = 0;
>  		return 0;
>  	}
> +	if (abf == ABF_QUICK)
> +		return 1;

nit: I think this is missing a blank line before the 'if'.

Thanks and hope that helps,
Jonathan
