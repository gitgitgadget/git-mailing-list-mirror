Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3EF207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 16:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938475AbdD0QdT (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 12:33:19 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34895 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932430AbdD0QdR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 12:33:17 -0400
Received: by mail-pf0-f180.google.com with SMTP id v14so31737830pfd.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Az2Bdi0fslGz6HJ6LON0KMZPR7xduHZHCe13a2VZS2Q=;
        b=Q/xDRb09CwtJzdiH6RilcJyRQW7fdRW4jOswxRQrZQ5tm3jEa+Yj/A6t9LQ28TDQWm
         KBKuPQr+3VHCxzmDnwRCbUsQCz2mcBsFNpF+6JFo9P7JcvYfzSSKolXKnlQ5VVtYEskA
         8wv3/va6Dk9vXqHEnQxvsnCmDk7Br66cOkq04b1uVJH1xTW3oBXcwLmto1UoWYJxgVDO
         fqneN0OGZCVT/qCXTyO2LJJYFJNnuDg5R5FVnFLOWD/lAAdwB0LFt6hSAy6WwwHH3dAc
         A4AnlCkYdNYrpsd0QtWG4AGKCeUUEzoIJPT4rS++DC1V0l+KVMXC65vTR0235QdVmaQJ
         xVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Az2Bdi0fslGz6HJ6LON0KMZPR7xduHZHCe13a2VZS2Q=;
        b=KeYhdC9MCeK5hvkMEUwelYfFVDe0xa15djrjc+3ca58URp5FE0gCUvGvHi8BU2qQsb
         E641pFINFeTC34FL2B8V1ReDK+N/UKROaNjBmONUtLhv+sLrKknJsu07QuxomVLm0BeK
         L1xuxhWNxHD/eX7lcFYkIPeyiXnhaCa0MzKvywB1kfyV9RbZiNjDjFMTvSU/PiwPnus1
         h60Z5sEP8d1FDbyL7p2XKPBhaPeFfEPHVn4Idleb/ZbIMY6GdlRi/6IDWIINRLs5a5r9
         rtkguXsF2aZQf4gLS6XvZCfhf/AzLMqSGPurv6KOCSe7D+0/SJrs3vTqoB0S8ovQ9lNz
         yWUA==
X-Gm-Message-State: AN3rC/5JMPiOLbyTN3Q4zr/Bk1a0WMKrTKelILQup3iTo7QSc7weD2fQ
        KEI3gJdr7S95uoyv
X-Received: by 10.98.49.70 with SMTP id x67mr6949579pfx.177.1493310796725;
        Thu, 27 Apr 2017 09:33:16 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:90aa:8d1f:3a06:d701])
        by smtp.gmail.com with ESMTPSA id n126sm5423059pgn.32.2017.04.27.09.33.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Apr 2017 09:33:15 -0700 (PDT)
Date:   Thu, 27 Apr 2017 09:33:14 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 4/5] clone: add a --no-tags-submodules to pass
 --no-tags to submodules
Message-ID: <20170427163314.GC80265@google.com>
References: <20170426231236.27219-1-avarab@gmail.com>
 <20170426231236.27219-5-avarab@gmail.com>
 <xmqqk266poih.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk266poih.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/26, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > From: Brandon Williams <bmwill@google.com>
> >
> > Add a --no-tags-submodules which does for --no-tags what the existing
> > --shallow-submodules does for --depth, i.e. doing:
> >
> >     git clone --recurse-submodules --no-tags --no-tags-submodules <url>
> >
> > Will clone the superproject and all submodules with --no-tags
> > semantics.
> >
> > This change does not implement a submodule.*.tags config .gitmodules
> > configuration option corresponding to the existing submodule.*.shallow
> > facility, which would make --no-tags have full feature parity with
> > --shallow-submodules.
> 
> Shouldn't --no-tags automatically propagate down to submodules in
> --recurse-submodules mode instead?  I know --shallow-submodules
> exists but it looks to me more a misdesigned interface, rather than
> something we want to mimic in a new option.

I agree, I would think that the --no-tags option should be propagated
down when --recurse-submodules is provided, without needed to provide
another option for that.  Thinking about the recursive case here
(submodules in side of submodules) you would then need to propagate down
two options, --no-tags and --no-tags-submodules, which feels a bit
awkward.

> The design of the traditional "git submodule" support strived to
> keep the superproject and its submodules distinct and separately
> managed as much as possible, and I view the motivation behind the
> recent push of "--recurse-submodules" as an attempt to make them
> appear as seamless as possible, so I have a feeling that a new
> option (like "--no-tags") that is applied to the superproject, as
> long as it also makes sense to use it in submodules, should
> propagate down in that mode by default (and most likely
> unconditionally).  Those who want finer granularity of control can
> use the traditional "work with superproject, and then initialize and
> update the submodules you are interested in in any way you want
> individually" mode anyway.
> 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > Code-by: Brandon Williams <bmwill@google.com>
> > Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > Commit-message-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > Git-Completion-Code-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > Docs-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > Tests-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> 
> Is it just me who finds this way of attribution unwieldy?  I would
> have expected to see something like this at the end
> 
> 	The main code is by Brandon, Ævar added the docs, tests and
> 	completion and wrapped them up into a commit with a log
> 	message.
> 
> before two s-o-b.

Yeah this looks a bit messy.  Ævar, you've spent much longer on this
topic than I have and should probably take authorship.  I mean I only
spent a little bit cobbling together a patch that I never tested. :)
You're more than welcome to include my 'Signed-off-by' and/or a
'Helped-by' line for this patch though.

-- 
Brandon Williams
