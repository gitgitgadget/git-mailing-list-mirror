Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B902920970
	for <e@80x24.org>; Mon, 10 Apr 2017 11:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbdDJLNY (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 07:13:24 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33920 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbdDJLNX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 07:13:23 -0400
Received: by mail-pg0-f67.google.com with SMTP id o123so25364139pga.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 04:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HrL49zvNZtXo+9CMJ/btJ/tLUgah7b8UDBDPYkHvUi4=;
        b=qD9TwATqNCZ2jm/aUyJOG+27m1eUSeR+4b68amZGjNw8AWtehJN+VgF28/ayn7c4tm
         qygEc1CPYC7txwgyiak4ND6SvHrk8GiE2RAoGDaukGJh2x8gEMwKTJAwV6Vmbe/pSwzq
         cEIYJMZ8X2ACrEtR8VorTay+wpo62Bv7Y6U36GQ4q/BiJ5UvDIezJvdiwY9tC8wwT0PL
         b4T9yFkjRJWkoh3gPv5WhuHi1npWI4eTQt0weNyj1Fm19o0hfwBtBj5RZOA3abAjhlre
         bqug/tb/quRQJ1V3K7HzA62gx2OksHXn4ED6sZJQ/MXLOcUicdW9+JsBuqstJ5kWuY5T
         yTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HrL49zvNZtXo+9CMJ/btJ/tLUgah7b8UDBDPYkHvUi4=;
        b=saMXNGOqAKBhVBiJxl1aSbzesfksEyLaEf5hUzqGZ+zAZZE0r1C9e/K+Ax2xMSIIfy
         puGdOU7+zHVmClC26Rfj8o5ClblWiCZoLlcSWmBh9yItR8V66ABZ5no8XyIYrs8m0+Ra
         Uf5VYSvqmcMNJjdNse+fqZ9cl0gP9ONSNSG0xaMeyxy2PP6232ehoLtUOkYp3Fgr5SEI
         K4Hhr6S49Wa7KAOf4VGkBIlPGvynWjiwPfG1pLqX7PR3Lx50wQQopkgEhQ1EHIIK4nER
         7sKLPvhuHpcGeVTt6RNY5K9YRr86N+A5i+H6qwnEv9wSFNWQ8shWFI/TeWVrDdwLZrHj
         07BQ==
X-Gm-Message-State: AN3rC/7I1sdwH218kD1Eql7qh88G5PW3rKw0YP5GG8gRftnZU5bV5g1JE7Nuikt4E6tv/g==
X-Received: by 10.98.59.9 with SMTP id i9mr6828689pfa.50.1491822802658;
        Mon, 10 Apr 2017 04:13:22 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id h7sm18587239pfc.99.2017.04.10.04.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Apr 2017 04:13:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 10 Apr 2017 18:13:18 +0700
Date:   Mon, 10 Apr 2017 18:13:18 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 2/3] column: allow for custom printf
Message-ID: <20170410111318.GA23601@ash>
References: <20170330014238.30032-1-sbeller@google.com>
 <20170330014238.30032-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330014238.30032-3-sbeller@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 06:42:37PM -0700, Stefan Beller wrote:
> diff --git a/column.h b/column.h
> index 0a61917fa7..c44a1525a9 100644
> --- a/column.h
> +++ b/column.h
> @@ -24,6 +24,9 @@ struct column_options {
>  	int padding;
>  	const char *indent;
>  	const char *nl;
> +
> +	/* when non-NULL, use this printing function, fallback to printf */
> +	int (*_printf)(const char *__format, ...);

This function should take 'struct column_options *' as the first
argument so a future implementation have full information. Yes we need
to add a couple more lines for just wrapping plain printf, but I think
it's worth it.

>  };
>  
>  struct option;
> -- 
> 2.12.2.511.g2abb8caf66
> 
