Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE97B20705
	for <e@80x24.org>; Fri,  9 Sep 2016 19:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754628AbcIITkl (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 15:40:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33751 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753226AbcIITkk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 15:40:40 -0400
Received: by mail-pf0-f194.google.com with SMTP id 128so4413794pfb.0
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qk4/7Gehg3glvTNufccW1Qb2Z8ZonmRjjHXUDGrSJwo=;
        b=cx5JdT341oZ3YwJsdYyO3oNABdrVwkdPKqjXJGGTC2ltkZKSjFjdtt7/tK5u/VSnPi
         ToVr/IeMf4CTqe8Z+AGkwZbSZlXrC0ZF/npqiHSLRhx/lkpAe7yNoPU+ukMJoQNk3Zoi
         6ySjQiakJ9Vb63qri2m18mKf+VCnVRoxoDp5dBr2C7WJLF9Hnv+4sZZpIwGJlzhcfs9/
         VI6cyZ91zAmFQECmr60i9c9KhiXz7LCxjz8Pg7qnH22MoJjTRE8GIuDjokEj7n6cuH/V
         qW1hakpaFSmn4udmnM+gnK3lk+62nl2KaMrLwpQmJND7J1bh7iLq3SgcZBaaQfm5hCX/
         YuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qk4/7Gehg3glvTNufccW1Qb2Z8ZonmRjjHXUDGrSJwo=;
        b=Rcn7zJws7dbYKUr4omI0ohW5AafT7GYlFNDp8O6STUiOUPc7JbZdOvpytaOJ4tVuTm
         7HUhR7i/3nYLKTjv0XRJsL+w5SEhHlfBUYKc9bagdYylyOSDrpPGn2iYqTMrlkUJQvLR
         J1MQIfJO0E2Q3dbXmqMKz12TYWlegFpbe+m3MTuT5QVXrG0g+gp01ZRiFF4kzstnsrAD
         fGUIZtIGb5WVa8imCSNhHH3eIT6l3jlB8/tvYibCm4HC9mqcazH3+kQDiezjGXEKGUa6
         G1LqKAMnDBaiYwlLO09v0GE5qxaaQsdlJMB0w1sHvu8WSh3Cy8GM60IpU2TwWVHDn6Yb
         sfNA==
X-Gm-Message-State: AE9vXwN+8e7fUF9esyxS/PLx31jvdClta9zOh9p3FdEGOJe87NucebXUl7ktrPyMiMOKXA==
X-Received: by 10.98.74.201 with SMTP id c70mr4277474pfj.1.1473450039892;
        Fri, 09 Sep 2016 12:40:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:2c45:4dc:f98f:e9ed])
        by smtp.gmail.com with ESMTPSA id l128sm7142987pfl.21.2016.09.09.12.40.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Sep 2016 12:40:39 -0700 (PDT)
Date:   Fri, 9 Sep 2016 12:40:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, sbeller@google.com,
        gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v4 3/3] connect: advertized capability is not a ref
Message-ID: <20160909194037.GG25016@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1473441620.git.jonathantanmy@google.com>
 <ac55dc281e6875df8abcc6ed06d5f258a53dd251.1473441620.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac55dc281e6875df8abcc6ed06d5f258a53dd251.1473441620.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> --- a/connect.c
> +++ b/connect.c
> @@ -172,8 +173,24 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  			continue;
>  		}
>  
> +		if (!strcmp(name, "capabilities^{}")) {
> +			if (saw_response)
> +				warning("protocol error: unexpected capabilities^{}, "
> +					"continuing anyway");

Please use die() for these.

The warning is directed at the wrong user.  The end-user isn't going
to be able to fix the server.  The server owner is going to say "Git
works fine --- I'll ignore this".  Client authors are going to
*eventually* discover the bad server and have to work around it.  So
everyone suffers.

I feel strongly about this: because there are no servers that violate
this, it should be a fatal error.  If we find a server that violates
this, we should weaken the spec and make all violations of the spec
still a fatal error.

The rest looks good.

Thanks for your patience,
Jonathan
