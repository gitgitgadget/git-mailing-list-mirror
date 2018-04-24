Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DB7D1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 22:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750929AbeDXWtP (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 18:49:15 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:39042 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDXWtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 18:49:14 -0400
Received: by mail-pf0-f176.google.com with SMTP id z9so13485112pfe.6
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 15:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFMmQW6qKMR64sFRT7QSnw73Yr7rFkgdaS5Jiejq5ik=;
        b=NSgNGw058aCUwhTj2iCuVeBcEhwCiSJjuXlLbfwBSMLmoIytUfqNSqNMrn2BmaDuMB
         TFp7i06wv0wLmkXShR+F4Ra1BKH0yiconKN3Fnh2k7n+yhkTJUqwoGdukonIl0T4vSOg
         ZYVa/s1ObW/MKT1BMEWrf3mfXXZ+audcm8zGqaYNtL68LpIWq3FmM9vbWFvuNMFf9EKT
         MYl20kd5HzhrB4J9TuZTM4JRYXM2OED6eSORnKrgB7WJnNYfh1U0JGf4ZzVqayTjWSiP
         98u8L37c/UyQTAhRcAfwSsNP/rPmgUqYSighYJ6ylTDabufTUTmBiPDRyeT4Za7g3whb
         y8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFMmQW6qKMR64sFRT7QSnw73Yr7rFkgdaS5Jiejq5ik=;
        b=AlOSOcm9wdbtPHrK2CzcN9bDuPJ2u1Ps4idQptzozo1/Vzb2bMnDUqf5HXRp819AEI
         9fmNDiPh2MkuV1lyGEpu/sOrZnF6XHBl8gBJMcAGuVYRNioc0p7S/a0YLlD5yzNEl+ce
         kXPkoALp3tNYfEbVSkN1+hSN0hpkiQ8SUS7tFjpVhYPy5NG7n+S58GysTq4vzGA1vQA0
         z9LLAB0ETOP3c4IbMjakA+G3IfcbRYjfKW3w2Can44tBoINjhiC5lsmzIzHKsWnE9vyJ
         S4G0jaiumSIcCUtca+EljEidfjPEwjiegBkLqye3SodY6+U3PTdrW8yL4gFPpa2nPk3D
         sa3g==
X-Gm-Message-State: ALQs6tA+4PtpKwFqOEHI6NAGaatAPlfoKw5DS/7qQ0yrVwQ9EDrARAOh
        o6fQYFAWRWiMeHvYfIaFDLcyCA==
X-Google-Smtp-Source: AIpwx4/qM9BBkIVzzdAQPRvalUZa00x/vu889uAY9dfkyU3EKrSYg+OoxG1S/9AZtxKw3eJIXqwavg==
X-Received: by 10.99.95.130 with SMTP id t124mr21894472pgb.150.1524610153450;
        Tue, 24 Apr 2018 15:49:13 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id s27sm5257470pgo.91.2018.04.24.15.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 15:49:12 -0700 (PDT)
Date:   Tue, 24 Apr 2018 15:49:11 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com,
        sandals@crustytoothpaste.net, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 9/9] cache.h: allow oid_object_info to handle
 arbitrary repositories
Message-Id: <20180424154911.54ab50bc2f95bc92ef88350a@google.com>
In-Reply-To: <20180424215910.22201-10-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
        <20180424215910.22201-10-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 24 Apr 2018 14:59:09 -0700
Stefan Beller <sbeller@google.com> wrote:

> This involves also adapting oid_object_info_extended and a some
> internal functions that are used to implement these. It all has to
> happen in one patch, because of a single recursive chain of calls visits
> all these functions.

I wrote about delta_base_cache in a reply [1] to an earlier version,
which is indeed safe (as discussed), but I think that other reviewers
might have questions about that too so I think it's worth noting that in
the commit message. Maybe write something like:

  Among the functions modified to handle arbitrary repositories,
  unpack_entry() is one of them. Note that it still references the
  globals "delta_base_cache" and "delta_base_cached", but those are safe
  to be referenced (the former is indexed partly by "struct packed_git
  *", which is repo-specific, and the latter is only used to limit the
  size of the former as an optimization).

[1] https://public-inbox.org/git/20180424112332.38c0d04d96689f030e96825a@google.com/

> sha1_object_info_extended is also used in partial clones, which allow
> fetching missing objects. As this series will not add the repository
> struct to the transport code and fetch_object(), add a TODO note and
> bug out if a user tries to use a partial clone in a repository other than
> the_repository.

s/sha1_object/oid_object/ (in the 2nd paragraph)

Also, you sent 2 versions of PATCHv2 9/9.
  
> @@ -1290,9 +1291,12 @@ int oid_object_info_extended_the_repository(const struct object_id *oid, struct
>  		if (fetch_if_missing && repository_format_partial_clone &&
>  		    !already_retried) {
>  			/*
> -			 * TODO Investigate haveing fetch_object() return
> +			 * TODO Investigate having fetch_object() return
>  			 * TODO error/success and stopping the music here.
> +			 * TODO Pass a repository struct through fetch_object.
>  			 */
> +			if (r != the_repository)
> +				die(_("partial clones only supported in the_repository"));
>  			fetch_object(repository_format_partial_clone, real->hash);
>  			already_retried = 1;
>  			continue;

This most likely means that a partial clone with a submodule would
wrongly error out here. Instead, the "r == the_repository" check should
be done in the same "if" statement as repository_format_partial_clone
(and no "die"-ing occurs if it fails - just that there will be no
fetching of objects).
