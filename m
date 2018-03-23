Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C51C11F404
	for <e@80x24.org>; Fri, 23 Mar 2018 18:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeCWSu6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 14:50:58 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32779 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCWSu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 14:50:57 -0400
Received: by mail-pf0-f172.google.com with SMTP id 123so5068225pfe.0
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lu9vuWrhg7Pya0HDDWVvc8O6f+Omem58GA/DgBPo+cA=;
        b=FSGRjSG7lqO+3Y5R5IGmgS+xxM4E2rm3+TFRWZfvSdppEVxpFOwcWwFmTVw6mihd2v
         sC/EzCwS45Mxg5AbonBxobSFswdObg4xoCkDeUR2eG5TIBZpheZ+tgiQEwv4XDFabIuG
         c5I9YfLcUDcu1cMHq3ZZmBpu85Gjbs1lyt8CKBNMT5EO70c7eEedRFnQCjy+HIbdGZUr
         j2cUr52Tp8+d+UZhr4FXY04JlhqwfuHUyO9etoL/PcdLQ2FUnDh+Al71BfBy794P4jdF
         U5dKAh40phPOQDnxWnTIEs6LtXNE0R2BJxKUxpYV3zfGRgYGlZRgLxz78ADC99kYUGbW
         4aYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lu9vuWrhg7Pya0HDDWVvc8O6f+Omem58GA/DgBPo+cA=;
        b=GSjf4oKxJHNrme2lD1YXqBjALvjjyIMtQQxb4U2Hv87Jey5mm/FTXBLgDn8Cw6U2/w
         6YIYl3VBcYLQKfcrqf4BVDnUYBkgB4MwLD0kA2G2YIfyeiwKJ06JGfkh/0Ed6EwZHCec
         JQFXErgsJwxyEHv9yFChco1cbuJXnxZJsJzQZ7LuHk7yuEbZNuQ9P3xdNxXEIh6I31bb
         8KSPGErl8tbqEumDIDluifr8xrlRUpUQKHwkZGIjG1ZR44AIDIh1u/NQjHfD/sEq1Ak2
         mZSuM55kq5C5UtiNiPdw76DoQN9QnjAYlJyM79+gIPP7AoyRSqbBHXLE0aGe4MPjIRAA
         p40g==
X-Gm-Message-State: AElRT7F0bgt3sn6RYRc8UEqbKgsPa74E9GkXFCM7ba1HJg8Njq3nNHl9
        EcKjcwFv2VM7rpoVg+5JtKy8WZucKV4=
X-Google-Smtp-Source: AG47ELv69ARgz2pIuN3KpwnBOZN7LhUUDfs1AhGgUx4h5zHC31c7YRrtECyxGoNJwDb+utLXsdOsXw==
X-Received: by 10.99.0.2 with SMTP id 2mr17141902pga.395.1521831056992;
        Fri, 23 Mar 2018 11:50:56 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 184sm20244951pfg.124.2018.03.23.11.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 11:50:56 -0700 (PDT)
Date:   Fri, 23 Mar 2018 11:50:55 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/27] sb/object-store updates
Message-ID: <20180323185055.GD243756@google.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
 <20180323183550.GB243756@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180323183550.GB243756@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/23, Brandon Williams wrote:
> On 03/23, Nguyễn Thái Ngọc Duy wrote:
> > I think I have addressed all comments I've received so far. What I
> > decided not to do, I have responded individually. One comment I did
> > not respond nor do is the approximate thing, which could be done
> > later.
> > 
> > Interdiff is big due to the "objects." to "objects->" conversion
> > (blame Brandon for his suggestion, don't blame me :D)
> 
> Haha, I'm guessing you prefer having a pointer too then? :P 
> 
> The interdiff looks good, though I'll set some time aside today to go
> through the series as a whole again.

Had some more time than I thought; this series looks good!  Thanks for
take the time to keep this rolling.  Hopefully we can see this merged
soon :)

-- 
Brandon Williams
