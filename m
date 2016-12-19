Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C10AC1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 12:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755341AbcLSMH0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 07:07:26 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36590 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755235AbcLSMHY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 07:07:24 -0500
Received: by mail-pg0-f45.google.com with SMTP id f188so60629465pgc.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 04:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hLmPn9DDMOSnwbvV7X/Pl7bnq8lmIkF5hZbjaL8mxwI=;
        b=Bl3gD3RylBAjyOj9kNSHFIWUjICO6K1gU/im2wgFjX/MlQI6URiIyT4BvScb28qSk6
         YI0I263hcDIazc/4ylXAsUG52CImaxvOxdvqtM7v0bosr59lbYAsvQm8wLc+f8EdRR4a
         5oTtn/+9vE2A2YqI+KXkCz//J2cUOSjiimmiWs+9ket1sHHRDm1i7Hv8SZ3M0QfFp74H
         HbooLIEjFWLdG5lBLKOhv7dgSz8HMEwgCjCLeha1xmAnPLFZvVuE8KIaGyKoZBTVQoGC
         4rDX10mfwdOfNaFJl81pm4hTdx929yvdazGDgoxxA48vXMWynWGwq/5mUaq/85tox+Ey
         cPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hLmPn9DDMOSnwbvV7X/Pl7bnq8lmIkF5hZbjaL8mxwI=;
        b=nTrJMd/xDIwBAwrYJ6g0wnoALfcJdDJG7a7b6PYw46QomXeWpnzqb3aUXB/OPrlETF
         JIADi5X4mjyFP3peUs9v/NqmV4A73du0Aq8hLb7klnCHoA7ntQDw1EqaKtArOUjfvyEL
         k6+NSDaQbIgrj0RFKbyl/DuC9jGiXv0l+PSW/XoQTben1JeghZxL6F1gYvV1zkYrtIbj
         ciTqpN0p8/HoREp9Zn2+4ReHJUFUBJA+UYIUu21QGQ4e0TbNVXTINYG2iR0imc83Yloj
         UndMnYpt2cjmBnAVpLblmIW+xq1agw6fgdBVr/J63Zi72ArfT8vkSpxUkjVfXBssjoYt
         JUog==
X-Gm-Message-State: AKaTC02u2zM1wn9/zcBFYhgtel8SoBSjcvt2lrGU6vVbFz4zwb1AFnLGYt8/p4+grcTe0g==
X-Received: by 10.84.129.131 with SMTP id b3mr33391149plb.54.1482149244140;
        Mon, 19 Dec 2016 04:07:24 -0800 (PST)
Received: from ash ([115.73.171.119])
        by smtp.gmail.com with ESMTPSA id 64sm31152939pfu.17.2016.12.19.04.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2016 04:07:23 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 19 Dec 2016 19:07:19 +0700
Date:   Mon, 19 Dec 2016 19:07:19 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] parse-options: print "fatal:" before usage_msg_opt()
Message-ID: <20161219120719.GF24125@ash>
References: <20161214151009.4wdzjb44f6aki5ug@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161214151009.4wdzjb44f6aki5ug@sigill.intra.peff.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 10:10:10AM -0500, Jeff King wrote:
> diff --git a/parse-options.c b/parse-options.c
> index 312a85dbd..4fbe924a5 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -661,7 +661,7 @@ void NORETURN usage_msg_opt(const char *msg,
>  		   const char * const *usagestr,
>  		   const struct option *options)
>  {
> -	fprintf(stderr, "%s\n\n", msg);
> +	fprintf(stderr, "fatal: %s\n\n", msg);

Your commit message does not make clear if you want this "fatal" to be
grep-able (by scripts) or not. If not, please _() the string.  Maybe
this to reduce work for translators

	/* TRANSLATORS: this is the prefix before usage error */
	fprintf(stderr, "%s %s\n\n", _("fatal:"), msg);

>  	usage_with_options(usagestr, options);
>  }
>  
> -- 
> 2.11.0.341.g202cd3142
