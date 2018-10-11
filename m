Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83631F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 06:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeJKOUU (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 10:20:20 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34872 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeJKOUU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 10:20:20 -0400
Received: by mail-wr1-f49.google.com with SMTP id w5-v6so8325022wrt.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 23:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Rr37BLSInkJg83K/0id31pNFvvfYewJsUXUPN61+ZJ0=;
        b=qpqKOwTNgOv05RD0iKHguZouoshybU54tJryChCaEsUUg/8eWRPS/bu58gcL7mGokO
         PREoW13mAGcMurlICwoMU2aay+jTSNcFWZAOHflSkyC1KZISj6/dzKrno8YSAdoK9Ybo
         0RK4eqsm2qrHwp0y7gKBoSRT9nY4I/T4nym27SmIEA730gPyCEpJ8kEX7xLZzIL2cH2g
         g59kQHv6KxW7JhUxRFArJGnnKbgamn8L1QuWm/QLPiutqCrStsyCSC9hlIyMiolT3jpQ
         l+J3mh7zzzhIrHvthmZ9wO66pYmrOY8iDGBdMWBo9l1GR2jj9bMsnhaV9OPBa9Af2AZ3
         XrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Rr37BLSInkJg83K/0id31pNFvvfYewJsUXUPN61+ZJ0=;
        b=U2devPKzQST5c01ht/hSbDNaxjuBjVeqQxmSIjiHHk+mcmeFzN3SzICd79BkGCYYkT
         f3nm1bUt5EstC5B7FAWc+5IWjaW9SAVeuizPQBgygSOFyvq1EGJ+KA4dqrijy8Qhvcfd
         aEU8T80UQgr3oTFjqsOAXe5P9fY/RkRlI6sZmKXIARJP+uPOMISeFqDLoWiv8+cI1dAO
         chAYbW0LdneDNrJ+1MdqefuP5qnus2NgTOUE0ATy5gBSdHrPxqPxk6j1iok93a3mMnqY
         jD2U2FASdzF5mU2HXt1M/WfBJj8GBRkZl4C9V6P4/rLLAxAGPabWy9ofPfVl8Gf+bbKw
         QBwA==
X-Gm-Message-State: ABuFfogYeMCMGT1z+4kEjBPTNXn1IB76sDTrNumBc+jzdvIeDw3lKeGe
        MtZPuwJk+8B6Fhxb9fl8Xxg=
X-Google-Smtp-Source: ACcGV63/0q5KWxl5tmoQFy2NLHJ/oMe6VaxpSXXx/VRj+fYcnAnMfy3IBhH4kIHsKk5iV5Ut70uReQ==
X-Received: by 2002:a5d:6242:: with SMTP id m2-v6mr331378wrv.162.1539240866116;
        Wed, 10 Oct 2018 23:54:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s1-v6sm17473735wrw.35.2018.10.10.23.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 23:54:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] branch: introduce --show-current display option
References: <20181010205432.11990-1-daniels@umanovskis.se>
        <20181010205432.11990-2-daniels@umanovskis.se>
Date:   Thu, 11 Oct 2018 15:54:23 +0900
In-Reply-To: <20181010205432.11990-2-daniels@umanovskis.se> (Daniels
        Umanovskis's message of "Wed, 10 Oct 2018 22:54:32 +0200")
Message-ID: <xmqq4ldtgehs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniels Umanovskis <daniels@umanovskis.se> writes:

> +static void print_current_branch_name()
> +{
> +	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
> +	const char *shortname;
> +	if (refname == NULL || !strcmp(refname, "HEAD"))
> +		return;

Is it a normal situation to have refname==NULL, or is it something
worth reporting as an error?

Without passing the &flag argument, I do not think there is a
reliable way to ask resolve_ref_unsafe() if "HEAD" is a symbolic
ref.

	int flag;
	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, &flag);
	const char *branchname;

	if (!refname)
		die(...);
	else if (!(flag & REF_ISSYMREF))
		return; /* detached HEAD */
	else if (skip_prefix(refname, "refs/heads/", &branchname))
		puts(branchname);
	else
		die("HEAD (%s) points outside refs/heads/?", refname);

or something like that?
