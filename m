Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35C331F404
	for <e@80x24.org>; Fri,  2 Feb 2018 22:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeBBWb6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 17:31:58 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:38581 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeBBWb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 17:31:56 -0500
Received: by mail-pl0-f50.google.com with SMTP id 13so7231635plb.5
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 14:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WTSSGCAp1IxnP5xRmU+ZZj+mq9JmZTLd84qP8GXpPkk=;
        b=Pc2VZ3LaMEQ1nuv+eRugG7QtmUop1LoBxPvXvaU44oquM2/D/QnPTBofPRl4ApzVpN
         G2DIWYsQuz1lWh6JRR3dVlNa8xG2HjrFtp1IY3LXZSzbjGa4jG3plybpANrXr2beS9pv
         HK0rah8oeIxM/RbhhcD6B457JSw6g+nJtXXlRvDV9pbphbTcC4JcCi/K7Wqjdvd0M3Yd
         msvGfVpwgr0hSuKucytsvW+JD17Jg3aKkb4zzfWwDQwettESITanwbO2v5y5CtGG7R1X
         A1kgeQjaVhjJhCpATrk2+H2K0PdgaK0OE8DTOZnaZS6PgcG9AJhtb5tHox2FTGM0igmi
         O3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WTSSGCAp1IxnP5xRmU+ZZj+mq9JmZTLd84qP8GXpPkk=;
        b=uGOOnKNxolXCoUB6uC62oDPm58+bxDSasp03EjahCMwRuj0P/UEIa9uS8kirQPyfT7
         CfF2/GBKTmY6wcKDLfxNmiTN5NmguVx/oFo24cBmQ2Rwi1FrOQuuh8yAD6WoeFIjBdNd
         2Rrtw3J8wppY85/mD7RkBcV12XHfj9hi9kGDbL0B15pGqRkH6zrpphYyKgXIfLg7Lpru
         6HCyQNdz245DU6714OP05zXGaXrgLhRDcu2EFOHA+cif2DdY37a6rln5qjzBLyBeZu29
         QfHMV816Hxc+TQZj3UgAyVqkCxpOjifsaiwFpE6a0LfFIVEQLtCBHcgFA0lueZrX5yLr
         n+Ow==
X-Gm-Message-State: AKwxytd3BUtn6NfqQmBoZ1nMJ0zagSNv/U9ol91SZUV+qtt51stax59d
        X7YOlLlQ2RlnohSFW2ve9IUD+A==
X-Google-Smtp-Source: AH8x226x3yAwh3BCs0zv1KgccETBhOvE0cjIZOP5GsRETXeCDOHP2Ic6g1+SS1eBd7apGucpSx0dYw==
X-Received: by 2002:a17:902:f83:: with SMTP id 3-v6mr12447221plz.287.1517610716167;
        Fri, 02 Feb 2018 14:31:56 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id d4sm4277477pgv.24.2018.02.02.14.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 14:31:55 -0800 (PST)
Date:   Fri, 2 Feb 2018 14:31:54 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 13/27] ls-refs: introduce ls-refs server command
Message-ID: <20180202223154.GA187827@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-14-bmwill@google.com>
 <CAGZ79kb14ciUoyHLAxmh0jGwwPYFVjGayrn9R2f+4+88A8=xsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kb14ciUoyHLAxmh0jGwwPYFVjGayrn9R2f+4+88A8=xsA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/26, Stefan Beller wrote:
> On Thu, Jan 25, 2018 at 3:58 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> > +ls-refs takes in the following parameters wrapped in packet-lines:
> > +
> > +    symrefs
> > +       In addition to the object pointed by it, show the underlying ref
> > +       pointed by it when showing a symbolic ref.
> > +    peel
> > +       Show peeled tags.
> 
> Would it make sense to default these two to on, and rather have
> optional no-symrefs and no-peel ?
> 
> That would save bandwidth in the default case, I would think.

Maybe?  That would save sending those strings for each request

-- 
Brandon Williams
