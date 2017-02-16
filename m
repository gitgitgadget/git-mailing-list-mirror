Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5471FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 21:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933289AbdBPVX5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 16:23:57 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34337 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932975AbdBPVX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 16:23:56 -0500
Received: by mail-pg0-f67.google.com with SMTP id v184so2944513pgv.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 13:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vJFXt0YrBCEBz3T1rys58ti2sYS2AGovfkGNuqXxOL4=;
        b=TSNjvVTbnvd1Xzfj4r9KKnOLQ5YapPgt9Jt21FiQ9i8QE1+fgp7RC2GJbTkaFyUWaG
         zaKZ9kBjjdudWw2YeSFqsRjnII7Trzt8BvM6k/Pc/CCTchHZxStn9caPpV+ydE7lNdH9
         NOr1Rzz+ih+5GjeXTek1DWKVkA4Pni480ifDDVl0pZngXjFLyUp9yoRYV9FkbWtqcr9F
         djMxeX7DVo5shZsUnwBCaUpWO9wjM3yWOdLnkB4YPU99fbmnYxO7iaA4wrZ4PMxJgBu+
         23jicaSCX7iBLYvP1j+SW5RcYVkUjPf+6thDGtixzJ9XgsTbVNjzj/cNLR4B4skttYrN
         ZhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vJFXt0YrBCEBz3T1rys58ti2sYS2AGovfkGNuqXxOL4=;
        b=ug+/p8GNIEuwn6mBLf5tFu2mz4s3fyRjBjexfFImGNOlgvl/1gPoLcJwJb4JvQLRBj
         mVCpXTaet2lx2EE5fIGfRtEGfZ3eL8bTdzd8aLl/QIPhFsgwduvOzfMWxOuITJ5iB/50
         Lz4dF3cZuH34B7TEXK+eM5UeJI0Oi0hpTYYwQoDtdCG3DdDofqGSMWcDnT6BjAtXq0O9
         VycEy++WnXv3Xt3GQMvlkBPTjTe9AaR+Szf3KcaRRcfT1CaZ8fJGL96bLU2ObmeEm1xL
         vbG7uR394giiUPsZ/TsOBUklQO/R80KKyFmuULt8+Bzo6ktLuyVf3aRnpyns2TGiGDV6
         tTNw==
X-Gm-Message-State: AMke39ltWfboKMCgzuk8M3qPAO9rPK2gO8VqghnA4sRR0+awxfBdwxeyOlI2ihrPlhL29w==
X-Received: by 10.99.95.87 with SMTP id t84mr5470950pgb.209.1487280235889;
        Thu, 16 Feb 2017 13:23:55 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id 9sm15262124pfk.121.2017.02.16.13.23.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 13:23:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     unlisted-recipients:; (no To-header on input) git@vger.kernel.org,
        sandals@crustytoothpaste.net, jrnieder@gmail.com, bmwill@google.com
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)git@vger.kernel.org
                                                                     ^-missing end of address
Subject: Re: [PATCH 12/15] unpack-trees: check if we can perform the operation for submodules
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
        <20170216003811.18273-1-sbeller@google.com>
        <20170216003811.18273-13-sbeller@google.com>
Date:   Thu, 16 Feb 2017 13:23:54 -0800
In-Reply-To: <20170216003811.18273-13-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Feb 2017 16:38:08 -0800")
Message-ID: <xmqqy3x5vnh1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +
> +	/* ERROR_WOULD_LOSE_UNTRACKED_SUBMODULE */
> +	"Submodule '%s' cannot be deleted as it contains untracked files.",

OK.

> +	msgs[ERROR_WOULD_LOSE_UNTRACKED_SUBMODULE] =
> +		_("Submodule '%s' cannot be deleted as it contains untracked files.");

OK again.

> @@ -240,12 +246,44 @@ static void display_error_msgs(struct unpack_trees_options *o)
>  		fprintf(stderr, _("Aborting\n"));
>  }
>  
> +static int submodule_check_from_to(const struct cache_entry *ce, const char *old_id, const char *new_id, struct unpack_trees_options *o)
> +{
> +	if (submodule_go_from_to(ce->name, old_id,
> +				 new_id, 1, o->reset))
> +		return o->gently ? -1 :
> +			add_rejected_path(o, ERROR_WOULD_LOSE_UNTRACKED_SUBMODULE, ce->name);

Is potential loss of untracked paths the only reason
submodule_go_from_to() would fail?  I somehow thought that it would
not even care about untracked paths but cared deeply about already
added changes.

