Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33EA1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 17:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933378AbeFLRir (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 13:38:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40245 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754374AbeFLRip (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 13:38:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id n5-v6so466043wmc.5
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dYwW3bFgTos6GHd1C4tF804k5jeFgZzoeznlB3Jm/Xw=;
        b=T8Z0UQaW+amYugIH3GX8WzELdRExCoJky3T5XkK7ibL8jXFYx+HBF5XknPnDgFgke5
         YZ51r0Cd8N0jj7DFbpKRwOdDLGzd/Fnei5lRyZlcTEycXsbs16Ie1vXA5sgH7sHPUgzX
         pF6S8vU63rXvgNX3wsrZO8PTlrIif+hoOO0ZidGL8M0eiMCoqX12Dxeb8terF1CkgV4L
         WYPZMPimmKdNO8GNwkaG+9lOH1GZoZvoK9EBrZLrPfCttoocUKqF/wRYbMLJe1HUbTbM
         IdoHReIpeGNgi/vZ2a0VYw5Sk0TU3MYhdq6cwiV8jGM9+yZ4r0AhtyvKtofSYkDVnKbM
         EL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dYwW3bFgTos6GHd1C4tF804k5jeFgZzoeznlB3Jm/Xw=;
        b=KFSL1F0c7yglRKE7mTx6qXP/wYYbBhgCUdyG2Gr9KH3DJkeL2jlGO75Yo+SRx7KKA6
         F4IiOEgvY31X1FXbDDGA/cFeLiRxnxuSWsQIubxXSDd5hiJY/FWOlOhpd8ITnYCe9ReZ
         ya3X/dnGWZxkIzfnYHLeOTYYwSOUZz0itNIlf6KZC2eR3R747yzekKl4WlgtsRf7scS+
         63VHJ/h7lb2oHq4/r75IyRxf4X0OYoqlk5B0DfuFkajAQg/zK6bKzEG8r1FczPLehmIy
         Ebnf3NGHIRW35mmvccSXKTUmd0ZnZ2N6OTUeOSbhc64h5YNX29Pzw2/7hkx4q8CyGV+F
         AJgA==
X-Gm-Message-State: APt69E2YRSToRnvlPmFs7iBh5dWRNazQAi+2TH57VcgOsFUbBZACBnRv
        Hsj1jVd5gqSl4uovERCYcUoRjASc
X-Google-Smtp-Source: ADUXVKIovrhpgvFs8Md/P12OW5AMXEuIkH/3i9RUVXYUKzBIR5ODkN260q93D3Pgf1rJr6CtmONhfA==
X-Received: by 2002:a1c:6943:: with SMTP id e64-v6mr987268wmc.14.1528825123965;
        Tue, 12 Jun 2018 10:38:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m10-v6sm932952wrq.56.2018.06.12.10.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 10:38:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/send-pack: populate the default configs
References: <20180612172623.165420-1-masayasuzuki@google.com>
Date:   Tue, 12 Jun 2018 10:38:42 -0700
In-Reply-To: <20180612172623.165420-1-masayasuzuki@google.com> (Masaya
        Suzuki's message of "Tue, 12 Jun 2018 10:26:23 -0700")
Message-ID: <xmqqk1r3aorh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> builtin/send-pack didn't call git_default_config, and because of this
> git push --signed didn't respect the username and email in gitconfig in
> the HTTP transport.
>
> Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> ---
>  builtin/send-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Makes sense.  I wonder if this was deliberate (i.e. we had some
reason not wanting to be affected by some _other_ configuration
items and refraining from doing the default-config was the way to
implement it), but I do not think of a reason offhand.

Will queue.  Thanks.

>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 4923b1058..42fd8d1a3 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -121,7 +121,7 @@ static int send_pack_config(const char *k, const char *v, void *cb)
>  			}
>  		}
>  	}
> -	return 0;
> +	return git_default_config(k, v, cb);
>  }
>  
>  int cmd_send_pack(int argc, const char **argv, const char *prefix)
