Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA311F453
	for <e@80x24.org>; Mon, 22 Oct 2018 23:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeJWH0W (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 03:26:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34791 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJWH0W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 03:26:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so10265856wmf.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 16:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Wx4OSJRsDtY6Ki3C3mU0cji8AX7vwol71aXu60rQ98M=;
        b=M0wQRy+Pkh/jtqWHTBXajkfk6wCuAVLvOI00SZn+aVA+oOqoyhqiIEhsLWNt91XvpY
         eLYgpuKjZhh1DIVRMhvpeFENqYsQWJK/vfTXxrAhe/GunZAqHhK/eiWoCOgA2ApGdJQM
         wcA0xUD3BNpUh2RBtojn0F6MS9vdG3eD6Csc6o97zXkmzjNjDL9ZQBGBgl6OvJAOcZCG
         n2lThJaRxPlaGrGgFl3+qQltAqWlsAoIpfXP2IburMvBy+09RTlFgBOyi9Fug9JWMBjC
         AGdlDTc2rwpoWIR5pj4/rS8idhoXNVU86pOurX8AuSgoaFc8uMsEqlZsPQntRqyj76fk
         cDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Wx4OSJRsDtY6Ki3C3mU0cji8AX7vwol71aXu60rQ98M=;
        b=Vnqodx5HW852iErLYjJ836scmq/4Q4zeKQIxIt21qVGBCgVbzsk3Vy74ap3DUPSyuY
         o7RJTDgwOnE2X2Ay8+396fn7mQ8s9mMcjThY5yOPUGJB689UrY6R0vKrs2Wmpd13nFo4
         P8xMH0ZDuqRidULmxol7F1ehj6SJE4OQrGqF2kfU3/FM2L9TrrOmdFUTrEgA5rm0SFyV
         nIOkr1xvYm0lXXf6knksiRnrcT+/GM7YemArZp2YrdOurIaeaSr6yKhCZuH4nPT/u1Z5
         ud6Z1O7aHNwNQ3+N3n3uyYFIUovENg8E1vonsgz5Co9IRH0a9KoAEdm82PnjbLTaTt1t
         6JBQ==
X-Gm-Message-State: ABuFfohOCadeUkprV6lj0KvPj6GnGte3/nSqaHfWlsNiJLoQcX5N8+qv
        A5Nj/u2g02BqDnjgtTLbjdQ=
X-Google-Smtp-Source: ACcGV61u1HMdjHt64C6ir+Mh5vVdinzd7dts9FRRhGiar957dgVEoWzigjA6UtajShzB2Fom9guaNQ==
X-Received: by 2002:a1c:7e57:: with SMTP id z84-v6mr18956098wmc.43.1540249547026;
        Mon, 22 Oct 2018 16:05:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x16-v6sm25459084wro.28.2018.10.22.16.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 16:05:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v1] load_cache_entries_threaded: remove unused src_offset parameter
References: <20181022150513.18028-1-peartben@gmail.com>
        <20181022201721.GD9917@sigill.intra.peff.net>
Date:   Tue, 23 Oct 2018 08:05:45 +0900
In-Reply-To: <20181022201721.GD9917@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 22 Oct 2018 16:17:21 -0400")
Message-ID: <xmqqo9bltwdy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If nobody uses it, should we drop the return value, too? Like:

Yup.

>
> diff --git a/read-cache.c b/read-cache.c
> index 78c9516eb7..4b44a2eae5 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2052,12 +2052,11 @@ static void *load_cache_entries_thread(void *_data)
>  	return NULL;
>  }
>  
> -static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
> -						 int nr_threads, struct index_entry_offset_table *ieot)
> +static void load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
> +					int nr_threads, struct index_entry_offset_table *ieot)
>  {
>  	int i, offset, ieot_blocks, ieot_start, err;
>  	struct load_cache_entries_thread_data *data;
> -	unsigned long consumed = 0;
>  
>  	/* a little sanity checking */
>  	if (istate->name_hash_initialized)
> @@ -2115,12 +2114,9 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
>  		if (err)
>  			die(_("unable to join load_cache_entries thread: %s"), strerror(err));
>  		mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
> -		consumed += p->consumed;
>  	}
>  
>  	free(data);
> -
> -	return consumed;
>  }
>  #endif
>  
>
> -Peff
