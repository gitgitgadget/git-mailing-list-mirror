Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D34E41F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 17:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfKSRH5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 12:07:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42541 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfKSRH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 12:07:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so24765266wrf.9
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 09:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w2ht3tvAJOgIu/jBXIKCQzR/BYoAAUAWtFAfzZR8nxQ=;
        b=WBwbKerAd7qQqPM5n7ZQq46EM+EufWNIYEHqzp2FuoqnGsb+rGzwuZN/md4UsrtiuP
         B9to7mG/hr1+Hlyq5GsiQpB4dRBcLh8jOnX1O51m6QVGE23xQi5udcJMnX/HcwzFmBVy
         nZOwgNKzBvtRvv5SAz3RoSZNkQhZENnkdykuZeujzf7fsSoZAtypdtsfw5J46FM3BeJX
         wtDuVCneQkLSoaOsMp87u4Cl7S9tt0NsXDbOyt8l0mC6U3noKAdGjPNv/GvNIWDSrd37
         AANdCg6JW9Y/havY5VPngu78sGOHyk1gpzy2WaNGrepKo4vmW94JJxJQ/+ytYXh8L5Xu
         SaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w2ht3tvAJOgIu/jBXIKCQzR/BYoAAUAWtFAfzZR8nxQ=;
        b=iNblHJVM6x6OqgTS2N4Apmn+rRnXG1kWFnYSKpO5gagS8964Q9FYrSuLLQWYavOYo3
         jKLisDdqwLu77Jz7H7xcKOs9Kkv7gZFcO6a0bftjGVnHhCz7E6czOoZ8CS2blP1jAEwO
         mPR1RZ27g3ST8ndAQ04btfRP3ZSsF/IJN2297gKRGNoGVuKrfCsMng2ZAESKf6+Brlbk
         I88CaqbZOmtf52fBzPml5U5GuY2MOgDpx3FZlPKqAwMdsAsS4njbdOT6EbgR8lmUwP0f
         lieilmzynHO9hWi9anTIjjcwyLFbA/03bHcGLHtdCsJ5PqXxDczSMa9KXLzzS9COHLVW
         rhig==
X-Gm-Message-State: APjAAAVI6w8/I6xxpqGSEbUYc+3f3RM4+bsOUKlav2sWUIAzdo/bSfXP
        j/L9Yv+msBHrgRqIQPSTju4=
X-Google-Smtp-Source: APXvYqzKtbyYa19+1Ko/4Ye21wqbvK9AjdHhiw49pU7CkHzNjOG6/Uzuu47i3lBgdqsf8roGkRXwug==
X-Received: by 2002:adf:fd4b:: with SMTP id h11mr8971562wrs.191.1574183273913;
        Tue, 19 Nov 2019 09:07:53 -0800 (PST)
Received: from szeder.dev (x4d0c2755.dyn.telefonica.de. [77.12.39.85])
        by smtp.gmail.com with ESMTPSA id f140sm3848545wme.21.2019.11.19.09.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 09:07:53 -0800 (PST)
Date:   Tue, 19 Nov 2019 18:07:51 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 15/17] sparse-checkout: update working directory
 in-process
Message-ID: <20191119170751.GI23183@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <d7af75672ba20ed208d51a35243b96ce10202a54.1571666187.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7af75672ba20ed208d51a35243b96ce10202a54.1571666187.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 01:56:24PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The sparse-checkout builtin used 'git read-tree -mu HEAD' to update the
> skip-worktree bits in the index and to update the working directory.
> This extra process is overly complex, and prone to failure. It also
> requires that we write our changes to the sparse-checkout file before
> trying to update the index.
> 
> Remove this extra process call by creating a direct call to
> unpack_trees() in the same way 'git read-tree -mu HEAD' does. In
> addition, provide an in-memory list of patterns so we can avoid
> reading from the sparse-checkout file.

OK, the way I understand the above two paragraphs is that after this
patch it won't be necessary to write the updated patterns to the
'sparse-checkout' file before calling unpack_trees(), and to me it
implies that it won't be necessary to write the "include everything"
pattern to that file during disabling sparse checkout.

> @@ -378,7 +436,8 @@ static int sparse_checkout_disable(int argc, const char **argv)
>  	fprintf(fp, "/*\n");
>  	fclose(fp);

However, as the patch context here shows we still write that "include
everything" pattern to the 'sparse-checkout' file during disabling.

FWIW, deleting those lines updating the 'sparse-checkout' file make
the 'sparse-checkout disable' test fail.

Did I misunderstand what the commit message is trying to say?

> -	if (update_working_directory())
> +	core_apply_sparse_checkout = 1;
> +	if (update_working_directory(NULL))
>  		die(_("error while refreshing working directory"));
>  
>  	unlink(sparse_filename);
