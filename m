Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65F371F404
	for <e@80x24.org>; Mon, 12 Mar 2018 23:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeCLXO2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 19:14:28 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:44773 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeCLXO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 19:14:26 -0400
Received: by mail-pl0-f41.google.com with SMTP id 9-v6so10233610ple.11
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 16:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Amrz9gi6LpZlBgrA2NbQRQ5v2gyykHwSyIq6AF+mZU=;
        b=Pprmig3EugTU01nRVabSKZH3DyfVBP6oFMTeJeWyQK1GLW1wueKLtuWAYE14FqS7/T
         o+DI3mebaxfGpUBno4xnQKer4MqpGmSwrfwfas6gu1p7j1cm8X134Mk4Y45Dnx9okcbF
         ozWiIQGIyN3TEGYdVDgCp71xnqIzcnNRlwHhGMp6NIdaim1uDepDLMFf5SgOeuAeiJle
         9uYxJMzh09vyPYJytyMb+toHI/F0gUoofIsVdjg7oCf9o6FxVwSLjH715IS1t3ZuTnIA
         Lh1EhJ8O7ZTjfl3A4Xo3rhPsCFYhlqoIGDO4XgkMTHq5oCC5bLANAnVyLi2gBLvlSj57
         sDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Amrz9gi6LpZlBgrA2NbQRQ5v2gyykHwSyIq6AF+mZU=;
        b=Y+LhhAai55sogpFE+rYzZ8x3pzLkOnGO3AxX1FiF1XNedxoE342qkLI0jT/PU5rGZt
         PDRXSoxeRUB4eXs6x2bTfTMoECTX01d3HOHkXqx+l5MmfAUYKZXXTIbrserAEV0ntDcx
         YI2KT4mX2ozrJ/HqqIv0Wy3dUpG/Ub1tHfGcz0yg1zDwysd7vTUvEiQm/yY0raW0QXG0
         5eRhuUT8Qlj3ewBqS2JVSNVwIt893iE41tyJb9oIiERTxEtFJe2h7dnEA/HSpnbZMWxb
         IMA/lD2s9wmbbkIOhccf2iudTBg4eHOueobTDJzboGTJBGvJmMJqKeiI5sgS7vwz7CDF
         OT/A==
X-Gm-Message-State: AElRT7GmoUonzl+bRXL8pHI+gZm2ysn41tw3ZE2V4EIZF9upXrjYZkec
        GuXUb7kuklMphe3k5TJZCD4=
X-Google-Smtp-Source: AG47ELvuDRIrIWk56HWcESrKsHYV7eAvMyNHlgjxVc5W5HXraSdqlSp0laYAOaNXJYes/ZhRwFB3aw==
X-Received: by 2002:a17:902:aa43:: with SMTP id c3-v6mr9679671plr.357.1520896466106;
        Mon, 12 Mar 2018 16:14:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v12sm16052933pfe.187.2018.03.12.16.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 16:14:25 -0700 (PDT)
Date:   Mon, 12 Mar 2018 16:14:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: Opinions on changing add/add conflict resolution?
Message-ID: <20180312231419.GA235366@aiede.svl.corp.google.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <20180312184734.GA58506@aiede.svl.corp.google.com>
 <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
 <20180312213521.GB58506@aiede.svl.corp.google.com>
 <CAE1pOi3jbLyZ7zgCO5J_BrQurrxZvm5RH+ZjXTTBf4MMmVOduA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE1pOi3jbLyZ7zgCO5J_BrQurrxZvm5RH+ZjXTTBf4MMmVOduA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Hilco Wijbenga wrote:
> On Mon, Mar 12, 2018 at 2:35 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Interesting.  I would be tempted to resolve this inconsistency the
>> other way: by doing a half-hearted two-way merge (e.g. by picking one
>> of the two versions of the colliding file) and marking the path as
>> conflicted in the index.  That way it's more similar to edit/edit,
>> too.
>
> If work is going to be done in this area, would it be possible to
> include making auto-merging (in general) optional? Preferably,
> configurable by file (or glob) but I'd already be happy with a global
> setting to opt out.

Have you experimented with the 'merge' attribute (see "git help
attributes")?  E.g. you can put

 * -merge

in .gitattributes or .git/info/attributes.

If that helps, then a patch adding a pointer to the most helpful place
(maybe git-merge.txt?) would be very welcome.

Thanks and hope that helps,
Jonathan
