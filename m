Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1F01F406
	for <e@80x24.org>; Tue, 15 May 2018 18:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeEOSTy (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 14:19:54 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40015 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752304AbeEOSTx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 14:19:53 -0400
Received: by mail-pl0-f67.google.com with SMTP id t12-v6so517668plo.7
        for <git@vger.kernel.org>; Tue, 15 May 2018 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eCsP4ZTaxgLABL/U8M2IT1sIQHl6N0fiYPN5ssy2X88=;
        b=R3nBkAcsEbwwqd/Uk2rDAkxvxip48UZiwHYAg8n8gkJizkIm/xvAazf+ZMQV9Kfeeo
         mab+EeBIO4xLAQp5Y//MbO4HP37eJVK2XHdjw/uAM2ZFFL0pwfCbR+b1PqQCo5XhkIMl
         c6/E9ZwtlkBjtzaMh00HRXwr1pkysJHgYkGviTUREyYitUM9URCgLCMfwsfKBpafNpYV
         FHrcxmZqgRGQoXco+3NZIpfO9jm34sjyUb5NDtEePTOfYC5lwJNvlVFuvI9/03qBOKB+
         DcoZx2rENHfHHVJ1e+wFjfE0Wi6Hul+DDDRmbYeoPxioGSC09rcJs0LzGj2UOqKys5MH
         FYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eCsP4ZTaxgLABL/U8M2IT1sIQHl6N0fiYPN5ssy2X88=;
        b=n4w1v7lVIFlpMX8lN+KcQxKu2WW+mzPN5PXnzF6y41dmxV/F50NT1IwMy3cVjEQtVF
         akcK+GSFRiY6w1gYN9OfQvhw4urDqmfnJUIvO/L6nE1cEwAxyOKrOBbb/8jvfb9Abh1l
         +v7h6qhp+hLrXZZk4JC/ZuDZtfDU/6hvXSKIDKjXl04FTfb2GxZkRhG2m4P686y+Dlum
         1/WKrz2eqIG6lsEa5nfhJFkr0wITrVDLctLujCgWcBPLFqvwp9eECBkktkw1pzDl54w0
         2bPlN6zLA+fvjIVOFsl2G2fawYi6GY+HkVLoslS1o+XIfznt9kGFUhmzG+Bf8V3bExL7
         HwkQ==
X-Gm-Message-State: ALKqPwfrJLdygh351mSY3wB67ZOAD3Crr6fLkVyqENjCATwvezJBjZAL
        8SNnmjKkXHxQx4MDC5UZIzNgqZhhyrM=
X-Google-Smtp-Source: AB8JxZoa9F7dTmPlVRDnzdWX3in7nGuCDiqhmfW5KpCA2sJuad6xzo9zqycU2p9eO/SPqBUWN5WOcg==
X-Received: by 2002:a17:902:bf08:: with SMTP id bi8-v6mr15368148plb.353.1526408392287;
        Tue, 15 May 2018 11:19:52 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id v5-v6sm774632pff.130.2018.05.15.11.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 11:19:51 -0700 (PDT)
Date:   Tue, 15 May 2018 11:19:50 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/35] refspec: rename struct refspec to struct
 refspec_item
Message-ID: <20180515181950.GF72551@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
 <20180514215626.164960-4-bmwill@google.com>
 <xmqqlgcl8h92.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgcl8h92.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/15, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > In preperation for introducing an abstraction around a collection of
> > refspecs (much like how a 'struct pathspec' is a collection of 'struct
> > pathspec_item's) rename the existing 'struct refspec' to 'struct
> > refspec_item'.
> 
> Makes sense.
> 
> >  /* See TAG_REFSPEC for the string version */
> > -const struct refspec *tag_refspec = &s_tag_refspec;
> > +const struct refspec_item *tag_refspec = &s_tag_refspec;
> >  
> >  /*
> >   * Parses 'refspec' and populates 'rs'.  returns 1 if successful and 0 if the
> >   * refspec is invalid.
> >   */
> > -static int parse_refspec(struct refspec *rs, const char *refspec, int fetch)
> > +static int parse_refspec(struct refspec_item *rs, const char *refspec, int fetch)
> 
> The new comment given to the function in the previous step talks
> in terms of the variable name and not type, so technically it is
> still valid after this change without updating.
> 
> I however wonder if it makes more sense to go one step further and
> rename the "const char *" variable that is a string form of a single
> refspec item to something other than "refspec".  Which would
> invalidate the commit you gave to the function and make it necessary
> to be updated in this step.
> 
> I wonder if the early part of the series becomes easier to read if
> patches 2 and 3 are swapped.  That may result in less code/comment
> churn.

I'll go ahead and switch these two patches and fixup the comment and
function name.

-- 
Brandon Williams
