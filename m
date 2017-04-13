Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A482A20960
	for <e@80x24.org>; Thu, 13 Apr 2017 22:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbdDMWF3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 18:05:29 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35582 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752890AbdDMWF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 18:05:28 -0400
Received: by mail-pg0-f42.google.com with SMTP id 72so27765071pge.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 15:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wKZ7LQcekATIsZ6BdgtX6S7AkywKz2f029OWEwZtcyY=;
        b=b1h0nUNWtYTAIyR60YDdYJtDz9Cbgz2xwoHPYVdoovQpaXqQybXfzndzmrBo3eAGD2
         fxxLFEg+t3vB72A3XoLvLgRWKP+ce2DbpjDdEP13eeI7dBseSfv56K9WcjUdhf+f1enI
         waF1tdZ9FZDBcrgPdPf52CYadhK6vX0UZb0Mqh2rprYyJe09Xvbwc2TD9K221MXs/D7F
         yTg0J1tts7lnXIpgpyP70H2uttJzxl0M9U0LAqXrDQhu2OI9O634BoF+FvTmAsrnQgwy
         3AxhdXmESRVxi62aQPcTJnmIvr7pNZGEpnwPcDPzZaxhhsswxOnItkeJrUP5VdasQERu
         tlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wKZ7LQcekATIsZ6BdgtX6S7AkywKz2f029OWEwZtcyY=;
        b=h8ihWhj8mJkahKTcB8jACV8xzsGx98utSsL3/nyuQLk0PsNQiAHg1nR/SyAVrUD+eI
         mZNHhS+4P1IA1G+5JNGrMD22bsDmjxbW5v7gk0qv9OPCljljivccSFpS85C91JbABuVL
         EQiUnsG5ioVWcXCO+ljoeOdL15QYIoCzUwAifiCEom3HfJXy49bNJDHGnbEu9HrH23Gi
         2QHm6RJl1i2unuR4eo+K/HjDOM5A8WKnEe1eCToxsDIf71/YyRtGJxKL2I9viCzm8YJb
         ZvC90TTG+r9Nb5PyHIiWOL01K1CnXoUKs1NwlODTlJaFUTM/AtgF6nCJC+OesZHJM4/G
         jalw==
X-Gm-Message-State: AN3rC/4jFIBIn4KhJZFhdtrrTmTolg862NJu7itJFluB8GSV6wb2+vVj
        Xu00MHrnYEI56LfbhGg=
X-Received: by 10.84.209.167 with SMTP id y36mr5401615plh.78.1492121126681;
        Thu, 13 Apr 2017 15:05:26 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:40ae:ac27:c1a2:6a87])
        by smtp.gmail.com with ESMTPSA id y28sm30491pfk.16.2017.04.13.15.05.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 15:05:26 -0700 (PDT)
Date:   Thu, 13 Apr 2017 15:05:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] xgethostname: handle long hostnames
Message-ID: <20170413220524.GE10084@aiede.mtv.corp.google.com>
References: <20170413192335.20679-1-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413192335.20679-1-dturner@twosigma.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

David Turner wrote:

> If the full hostname doesn't fit in the buffer supplied to
> gethostname, POSIX does not specify whether the buffer will be
> null-terminated, so to be safe, we should do it ourselves.
[...]
> +++ b/wrapper.c
> @@ -655,3 +655,16 @@ void sleep_millisec(int millisec)
>  {
>  	poll(NULL, 0, millisec);
>  }
> +
> +int xgethostname(char *buf, size_t len)
> +{
> +	/*
> +	 * If the full hostname doesn't fit in buf, POSIX does not
> +	 * specify whether the buffer will be null-terminated, so to
> +	 * be safe, do it ourselves.
> +	 */
> +	int ret = gethostname(buf, len);
> +	if (!ret)
> +		buf[len - 1] = 0;
> +	return ret;

I wonder if after null-terminating we would want to report this as
an error, instead of silently using a truncated result.  I.e. something
like

> +	if (!ret)
> +		buf[len - 1] = 0;
> +	if (strlen(buf) >= len - 1) {
> +		errno = ENAMETOOLONG;
> +		return -1;
> +	}

(or EINVAL --- either is equally descriptive).

Also POSIX requires that hostnames are <= 255 bytes.  Maybe we can
force the buffer to be large enough.

Thoughts?
Jonathan
