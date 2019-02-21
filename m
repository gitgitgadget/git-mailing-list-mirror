Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C08A1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 21:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfBUVG7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 16:06:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34390 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBUVG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 16:06:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so53805wrg.1
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 13:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JtsbtGNDj9cJL0vJuV8YYSkxHPv54Gj5zVBkzCa6Hxg=;
        b=f6YAG3Tvzkx/HEg3Z8U+DN6FF+H5lcyv5VcMOATv0c2+Ei2MskgtQOhmS8zLICZu5/
         oP6k+zMURxMhZfOGSic8WaxWcaDYpqXY+VJ8Uh+0BBbqRF8L3zLTZ9ci2dSml/1U+pZ9
         +W4RZWbxpZ0u+dguM+Mik9aG6hn+jEEm4tXvR4LK1TVKbS+L4U/WEuywULGXohy49RUi
         aFKDZNcuH6m+qFkzVjTTVep5iQIRZYR2KnbsYW/9xeyYFHclztE/ZJPZiQmUPcVzFd8R
         GG3oVtqyjG3YlzwYr2aVQha74G/nz7uo742gkFrNNZU+rF+UuAPTbE+Ul6Vk6a4bN6Sw
         pkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JtsbtGNDj9cJL0vJuV8YYSkxHPv54Gj5zVBkzCa6Hxg=;
        b=Ju8+oS7bq+V5kqEu6OCTsrcOcDRSD9rx7grMvPZ6oZh9HogvAkyqBvHEYKvOzjPQ/u
         s5+8ltbFHW6tYfoXpsmpqDHXKlg+pdyPHMbeNPPt7k+2/K00alif522geS6zj/AlmlbZ
         EW68b5Kzs81X7YWJH7V9EDLVlIvX+Q65y+7OM+MQDs3jiUsiB6ZFj5UsGs6cdo5t+aU1
         SF4VhKvA47TLJK3qW13Gf42hIRzxETNbPCSPmXtH0d9EPhs+Hqm9OxVtYqfVtG+RtAas
         urtpW6uOVr1i5aXI3FePAnC9bVIByNst6d/HLGAm9KmxEPctGJa7xNYgZBjZsR2qOFu6
         jUAA==
X-Gm-Message-State: AHQUAub56rl5yx3UEQ27aFmWNgz3mCWxRRgLsDccI4Tc4n5+IryinXYG
        Hj92Bcyt9MIWnWRn4ha9k9c=
X-Google-Smtp-Source: AHgI3IYOuWyxRHXwrwj/NDBafysEmRpaX7pVNXq5IC26UhBT3jDO3CyNzNgfuE7cd1g1j5oVXJXS9Q==
X-Received: by 2002:adf:9167:: with SMTP id j94mr375156wrj.106.1550783217116;
        Thu, 21 Feb 2019 13:06:57 -0800 (PST)
Received: from szeder.dev (x4db54a94.dyn.telefonica.de. [77.181.74.148])
        by smtp.gmail.com with ESMTPSA id q17sm12799492wrx.38.2019.02.21.13.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 13:06:56 -0800 (PST)
Date:   Thu, 21 Feb 2019 22:06:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Johannes Schindelin' <johannes.schindelin@gmx.de>,
        'Duy Nguyen' <pclouds@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc2
Message-ID: <20190221210654.GT1622@szeder.dev>
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
 <012601d4c8b5$54f1b730$fed52590$@nexbridge.com>
 <xmqqftsiw8l8.fsf@gitster-ct.c.googlers.com>
 <001501d4c9fd$bf80dfb0$3e829f10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <001501d4c9fd$bf80dfb0$3e829f10$@nexbridge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 10:54:31AM -0500, Randall S. Becker wrote:
> /home/git/git/t: sh t4153-am-resume-override-opts.sh
> ok 1 - setup
> ok 2 # skip --3way overrides --no-3way (missing TTY)
> ok 3 - --no-quiet overrides --quiet
> ok 4 - --signoff overrides --no-signoff
> ok 5 # skip --reject overrides --no-reject (missing TTY)
> # passed all 5 test(s)
> 1..5
> 
> Technically, we have TTY, but not that dev. The TTYs are not under
> /dev/tty*, however.

The TTY prereq is not about /dev/tty, but about whether
't/test-terminal.perl' can simulate a pseudo-terminal, i.e. the
necessary Perl modules are installed and working appropriately.

