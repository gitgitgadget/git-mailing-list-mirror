Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FA920401
	for <e@80x24.org>; Wed, 21 Jun 2017 22:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdFUWyH (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 18:54:07 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36655 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdFUWyG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 18:54:06 -0400
Received: by mail-pg0-f46.google.com with SMTP id u62so63623003pgb.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 15:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQEfy0F/vYacH0CqhbSX+33IONnOgZ+DbaPIlgdTGoo=;
        b=niYQ/2zF5DE82+hTzSlkdfyj4MBILbhwgdJy///ZmBvTF9AVQp/8AdmXCISZi7qtxf
         JYciluZ4b2ZTPKwTq7q11YU15yabApV6whpyGIb2b6imvF2yfCKzKF41k4xxXLhgdkcV
         FCol/ZYD7ePKedwTcZHPLG2Tscj5yhjE58kZxVogtz2TEk45UuP4dTCkB914rqN7N3CY
         IGplU1dk6SEYSDeS8m21mdGn8rVZacJZsOIQ5Ofm1XuRE7OEewGRH/GxSfQJgrU59cAt
         37FVVVIZBX2a+5CESD3w/hAS64fOKe//St8F7KPTg2ttNKKM6obAlqGtme/YS+wwORW6
         UZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQEfy0F/vYacH0CqhbSX+33IONnOgZ+DbaPIlgdTGoo=;
        b=Fecb9dyHUqL2RoL3Xmu+zqty2RoeEWbh+p3D17hi1xgOMcZ2jauKJ+z68fp33+XYdR
         yV6MRKlY6TGs4sc0rp0Gz7mwGPiqOQDa4MgyDY4huoGbwQintdnkzvotDOoDsQmspNNz
         Qbemaem38QAo2kaaCtTItorOH36j8C9gLMUbAerfFQxZzHv3IhiTKpug0jWPE6YEqXi2
         kzYyWjvFkyv49UbfLgkotwmTJ334LR3ht4zMlrz7Wk5jKXLXfft8tJORdxCumZJwH9xK
         5PUKxuqNSoltl3WpgJ41chkB170YuIARwn/QBPE9AJ5OrF8oVXkdkMC5fYLGEKjvpF/G
         vLmw==
X-Gm-Message-State: AKS2vOyElG9l6vQvRvRJq5WWxSZBAfrAanz1vZQcaOCC52A1AJJAUqNO
        AmXcilkD4WVvh5U8
X-Received: by 10.84.193.36 with SMTP id e33mr43807513pld.293.1498085645705;
        Wed, 21 Jun 2017 15:54:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:d052:1af5:b2b3:bc81])
        by smtp.gmail.com with ESMTPSA id b2sm33377842pgc.16.2017.06.21.15.54.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 15:54:04 -0700 (PDT)
Date:   Wed, 21 Jun 2017 15:54:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v3 15/20] repository: add index_state to struct repo
Message-ID: <20170621225403.GH53348@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
 <20170620191951.84791-16-bmwill@google.com>
 <20170621155059.3ae2c601@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170621155059.3ae2c601@twelve2.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/21, Jonathan Tan wrote:
> On Tue, 20 Jun 2017 12:19:46 -0700
> Brandon Williams <bmwill@google.com> wrote:
> 
> > +int repo_read_index(struct repository *repo)
> > +{
> > +	if (!repo->index)
> > +		repo->index = xcalloc(1, sizeof(struct index_state));
> 
> sizeof(*repo->index)?

Is there a reason to prefer one versus the other? Either way I can
change.

> 
> [snip]
> 
> > +	/* Repository's in-memory index */
> > +	struct index_state *index;
> > +
> 
> Might be worth commenting that repo_read_index() can populate this.

-- 
Brandon Williams
