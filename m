Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A238B1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 21:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbcKRVgt (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 16:36:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33441 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbcKRVgs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 16:36:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so10312479wmu.0
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 13:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Fwee37ZAt6CVN54HVtkDVBLOt0ndFTgrYuZAbDR+HfE=;
        b=ii7G8S2jg5a0SB2iqv9Seg/yaiPIJUWENoCq+34AS2Znamoq1CZJ9GueA8Y+TUtuc2
         cqOQ4VZELgAMPt/mVzotztHeBA5vst0NNs3PTLheiEgJ/c5NkD1lytMsecNp8tKaz1Cm
         qpeFKWt5MqJ7QOUKcCODid0Qmhs8VXVXlrjzj38j+1BfaU2qheqrR75tzT2/hLZ2BvYv
         dP0AIWtM3OocSxvb+5ji/G+1XBxAT62zPdJQDPl1KKIjc1GadSRDbi+DZC7nAhzC5jIz
         73w3aNkwLYEs11soq/OwFTHjD+l9NBuEVWmDahG0lOzb/prUEYqbNp66uszYbevhfKzD
         YTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Fwee37ZAt6CVN54HVtkDVBLOt0ndFTgrYuZAbDR+HfE=;
        b=OTegBkDeMvLhyg+MIayj4iH3Xkc4kbc9s8hYC9OX0SUfwIob0RXt7bKaB62jVGF/OK
         aZN0MYVgGj/jZCoGPFBYWSN2xuohCSBzTgC+Ylcj5dbSzEfpWY7izN9cEnK31oUVKpAU
         aK4k7a/0YI0R5yVMqVjgyOI3lFQNdPGGmuKTOQDmFfG3c/DeMSa0ARR7Gw5Ph6MbDba8
         PT47cw9i0mjRwfYSL2ETp2WInnBcVIo17JSQ7SB45+W9jEZuLCnS3lE35v4EIYeeumMa
         98o7GVYuOGYOUa/vrbKNAtextg6n/opRuGI2IL/5FM0jHvjVcR+VrXqsorHstPSKKCWw
         nSNQ==
X-Gm-Message-State: AKaTC004qTog9URayLVb0s16RkEgGqOhazGOO56JHBLCktStaBuDoBd5YihGiOqtD+ovSQ==
X-Received: by 10.28.54.3 with SMTP id d3mr477398wma.34.1479505007089;
        Fri, 18 Nov 2016 13:36:47 -0800 (PST)
Received: from [192.168.1.26] (acuy2.neoplus.adsl.tpnet.pl. [83.11.104.2])
        by smtp.googlemail.com with ESMTPSA id jq10sm10844545wjb.46.2016.11.18.13.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Nov 2016 13:36:46 -0800 (PST)
Subject: Re: [PATCH v7 10/17] ref-filter: introduce
 refname_atom_parser_internal()
To:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <20161108201211.25213-1-Karthik.188@gmail.com>
 <20161108201211.25213-11-Karthik.188@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5df0a607-4d83-8211-457a-96d7bde46eff@gmail.com>
Date:   Fri, 18 Nov 2016 22:36:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <20161108201211.25213-11-Karthik.188@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 08.11.2016 o 21:12, Karthik Nayak pisze:
> From: Karthik Nayak <karthik.188@gmail.com>
> 
> Since there are multiple atoms which print refs ('%(refname)',
> '%(symref)', '%(push)', '%upstream'), it makes sense to have a common

Minor typo; it should be: "%(upstream)"

> ground for parsing them. This would allow us to share implementations of
> the atom modifiers between these atoms.
> 
> Introduce refname_atom_parser_internal() to act as a common parsing
> function for ref printing atoms. This would eventually be used to
> introduce refname_atom_parser() and symref_atom_parser() and also be
> internally used in remote_ref_atom_parser().
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
[...]

> +static void refname_atom_parser_internal(struct refname_atom *atom,
> +					 const char *arg, const char *name)
> +{
> +	if (!arg)
> +		atom->option = R_NORMAL;
> +	else if (!strcmp(arg, "short"))
> +		atom->option = R_SHORT;
> +	else if (skip_prefix(arg, "strip=", &arg)) {
> +		atom->option = R_STRIP;
> +		if (strtoul_ui(arg, 10, &atom->strip) || atom->strip <= 0)
> +			die(_("positive value expected refname:strip=%s"), arg);
> +	} 	else
          ^^^^^^

It looks like you have spurious tab here.

> +		die(_("unrecognized %%(%s) argument: %s"), name, arg);
> +}
> +
>  static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
>  {
>  	struct string_list params = STRING_LIST_INIT_DUP;
> 

