Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACD4B1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeBWXLq (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:11:46 -0500
Received: from mail-pl0-f47.google.com ([209.85.160.47]:37345 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbeBWXLp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:11:45 -0500
Received: by mail-pl0-f47.google.com with SMTP id ay8so5728258plb.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n+ZTAhthnmrwQ7pE2HQarzHC9zO4AFRYiAOJLz8KGTs=;
        b=PfBnelRbNBqeafIWCq1zAnSPFwrvLj30IriBbex+AwMfV0HqPOw/d6agsYdujI6dMs
         eyVzvXwkqkRu3TFuZTPdki0nYZMEmUij6h29p6DRxx944SBQf70owjS6VW8zQlk1DFuQ
         mCpnp6qp/OqNcFK8xHWvKXIRg3iF35Tx5BsMGL4TVL5Fx96HmrBctuxC8BmFNncuaiH4
         vQIRrx/NFl8bfUU3L6AVlbYmFKC7PXifVm37utpdWkqimHTGA1ZLRMXW+MP+ByupT2n2
         k4J44XkvXCG7Xca0xhREBBsPYqbc/SWRej5j0kroEMfPCxerTJW+SJM2Mn1ouzBthknO
         T5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n+ZTAhthnmrwQ7pE2HQarzHC9zO4AFRYiAOJLz8KGTs=;
        b=qk8uFhBXtJsUaA+EZ8enYZzcb4JhFdNmiR0OMePAAF1atRyllyqYRFivT1444WVkB6
         trbGZ3FnthmmhvgdMYZfTlvKnkzgRGlh2jAjUc0XwBOOuiWsbZGa3ZxD3SZgEZYDIpH5
         aD4x7vC6KfpUPhLdLrDRZBlPdCTl4glO2y8YXpFf6hznuXoYIekpji39fJOEYrG0TawD
         fejpn1KDNtFjhvKr2hoP65iDSg94KO/pD6wC/42oSe97igTfLl/ehrJTV2cdlK1hvgVp
         ekmzybkq+J54rjC3DMH2Suu9YkquWRH7DRf82PgpalHh+oBxKloKqLUPH+1NNmrlFSoM
         cTmg==
X-Gm-Message-State: APf1xPAt9KiYTnTzxeFEYwdCJfaqNV1OJxDaD7USZV8Vx7SbCy6zumrK
        7OLbcrK9ZfzHwHIg1rQXK1EFvQ==
X-Google-Smtp-Source: AH8x227oFl5pFsPVDwcdIIzeGPNbDTCkXRTOrSLTOMSMTdCSQAG7zhuRLUJoDNvuLS/l7TM+P39uUA==
X-Received: by 2002:a17:902:b185:: with SMTP id s5-v6mr3122276plr.109.1519427504921;
        Fri, 23 Feb 2018 15:11:44 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id s78sm4172448pfe.162.2018.02.23.15.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 15:11:44 -0800 (PST)
Date:   Fri, 23 Feb 2018 15:11:42 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 16/27] sha1_file: add repository argument to
 sha1_file_name
Message-ID: <20180223231142.GH234838@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-17-sbeller@google.com>
 <20180222005149.GH127348@google.com>
 <CAGZ79kZess5QJL1RuV+qmUYtLoY0q0EJkvRF1rZPWeScFcRz_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZess5QJL1RuV+qmUYtLoY0q0EJkvRF1rZPWeScFcRz_w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/23, Stefan Beller wrote:
> On Wed, Feb 21, 2018 at 4:51 PM, Brandon Williams <bmwill@google.com> wrote:
> > On 02/20, Stefan Beller wrote:
> >> Add a repository argument to allow sha1_file_name callers to be more
> >> specific about which repository to handle. This is a small mechanical
> >> change; it doesn't change the implementation to handle repositories
> >> other than the_repository yet.
> >>
> >> As with the previous commits, use a macro to catch callers passing a
> >> repository other than the_repository at compile time.
> >>
> >> While at it, move the declaration to object-store.h, where it should
> >> be easier to find.
> >
> > Seems like we may want to make a sha1-file.h or an oid-file.h or
> > something like that at some point as that seems like a better place for
> > the function than in the object-store.h file?
> 
> It depends what our long term goal is.
> Do we want header and source file name to match for each function?
> Or do we want a coarser set of headers, such that we have a broad
> object-store.h, but that is implemented in sha1_file.c, packfile.c
> for the parts of the raw_objectstore and other .c files for the higher
> levels of the object store?
> 
> For now I'd just keep it in object-store.h as moving out just a couple
> functions seems less consistent?

Fair enough :)

-- 
Brandon Williams
