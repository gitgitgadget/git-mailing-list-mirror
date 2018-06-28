Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC471F516
	for <e@80x24.org>; Thu, 28 Jun 2018 20:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeF1UiT (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 16:38:19 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41898 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753431AbeF1UiS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 16:38:18 -0400
Received: by mail-wr0-f193.google.com with SMTP id h10-v6so6744995wrq.8
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 13:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nkYb3rCa/kL6oXpwwirW6u3ielTFEV+KDoeFPe7A8Tg=;
        b=HI04z5oOgWm+2dTFHJ3TKSu9savXDmAjzox8/HOnpfClo10t0ksznAl9XCspbvyYxm
         Sfh6/kOnGVsEKx2AiYK//0l26EnR3sK+qJy6u7ELcp49z63ZM3MdgYY2t72M2b0oWMui
         Coer+dOPjVtNbZ01aN+iJDTBhOtDRqVP5Fts6A3luH2RQY/rsFCPavP5GfFRkJlmAcKo
         qAdVK1vd9+I2vzh0l7/rjv5yciCN+d7wZBZ79UnPOEHT4jhsiuBQdn1tpK3rramnoH7L
         1ig/WV1/fLn5eZaY7ANzgfR8yjuoRamElTP72OGQv/P7X0KuPfQzxnhzgO1zThnPUszD
         nmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nkYb3rCa/kL6oXpwwirW6u3ielTFEV+KDoeFPe7A8Tg=;
        b=U3ykYEXNoYDoUI+8arem/wui70TaoaqZQFd6qaExE8Yw4whr/MdFnl1YDTCzOUuk3E
         JJtzPl4ZI/r+bQ6tOTNIa0Ab1eb9qNeWqdogPxVH5C9ZMQThSBeobfV7p4qn98bkJ7eG
         AlGYAZkxBAcIpXhRiS1CreZTU3J9/xShak2b2NDWZYNnD/uBq0vb4qj8FAYIWttwDcDC
         B2O+ELWy2CiVoFZyF1Y+SEAr5xYUqNqvxyVroMwjo8S2Sf/my720oErJ+ny/LCxBhKFA
         fnVJA0lvAAJ/gdWfxxM0CjEBNY6yC2Xr0aHwNHDIjxkko2NGWHK2BN+SRwmqZOl2cTYz
         TJug==
X-Gm-Message-State: APt69E2IlzKYugXJwtbPuSoOHzTpvpTP8TjrM/9DvWfRC0ed3nfiHgA5
        fBrk6wTnvfuZOcxeon3NT7Q=
X-Google-Smtp-Source: AAOMgpfj/0p7qq9RzYM//tbPh0DQ5nwh2Sr86FdedaF+Q9NzLT1Fnp1db44NVgqHzcNo6qDceJvcUA==
X-Received: by 2002:adf:fd4c:: with SMTP id h12-v6mr7822457wrs.280.1530218296804;
        Thu, 28 Jun 2018 13:38:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r2-v6sm11645176wmb.39.2018.06.28.13.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 13:38:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Schrab <aaron@schrab.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sequencer: use configured comment character
References: <20180628020414.25036-1-aaron@schrab.com>
Date:   Thu, 28 Jun 2018 13:38:15 -0700
In-Reply-To: <20180628020414.25036-1-aaron@schrab.com> (Aaron Schrab's message
        of "Wed, 27 Jun 2018 22:04:14 -0400")
Message-ID: <xmqqh8lmwsso.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Schrab <aaron@schrab.com> writes:

> Use configured comment character when generating comments about branches
> in an instruction sheet.  Failure to honor this configuration causes a
> failure to parse the resulting instruction sheet.
>
> Signed-off-by: Aaron Schrab <aaron@schrab.com>
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 4034c0461b..caf91af29d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3991,7 +3991,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  		entry = oidmap_get(&state.commit2label, &commit->object.oid);
>  
>  		if (entry)
> -			fprintf(out, "\n# Branch %s\n", entry->string);
> +			fprintf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
>  		else
>  			fprintf(out, "\n");

Would this interact OK with core.commentchar set to "auto"?
