Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2CF51F403
	for <e@80x24.org>; Wed,  6 Jun 2018 16:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeFFQ7X (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 12:59:23 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44982 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeFFQ7W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 12:59:22 -0400
Received: by mail-ot0-f195.google.com with SMTP id w13-v6so8067526ote.11
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 09:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5jHrTb4/lc51aASW4kDMenfPiCNBsldkFWYzZue3+BM=;
        b=G+W8dU/1/2CZYqIvOUVeTsrlvQ36mAFPd9sO/ROYZa9MJzx2DOIC03t46BoCn5+xEP
         tFKTClQihW9/7VRguM792563CkhFHA9xddA8A8DhmLXIWrhzwxfRQOS2Nru0uhPGZFth
         ks9gjEQGFjn+0jbWzAH7g+FPWyEhl5I+9oh3wBJE9vhuhD15JFI3h9x9b87IWw3zOZon
         2qF8emPQRZjGl/AV7nePEZeibAf9irCRcZQzlFDjA2/5RluTdD8AEAtYhMBfZhgVZ1HP
         xbsC6tQw3GHDt7vsYL15jcc9E1M8lAkP+ZlshV4VWaSEwN/YAQg19rvLhS4gvjKSxCbs
         uOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5jHrTb4/lc51aASW4kDMenfPiCNBsldkFWYzZue3+BM=;
        b=hgIR03ULFAWPVe1u55vP8aK94a3N+vdbdfvPuElwrjxIfwJv2oACxDe+neUHpKp8ah
         caB9PmpWNE70Br+sSgtoHAc+yEdl9rGLq3x8cnBjVTe+uxLgEF981B6LBVGiLRbseMoe
         l90+zyDG0CvSklFRk8NBvcaP2Wcs5yEpBFVz9CvYDq8nVpeTwLwVIpRbbusT4fNySRye
         1Wel4jA9ZkO+LspQgXf9IW9R1dd+fFTo4pzrLXV2JspZJcd4yLkRY/4WZkdWLZ+xkQdS
         bufWbjH7Uu4XIJfkeMexKCuGWPurxQbl4eBTb1gW7X+urLBw4JN2H2r0Q+LZErvUIDmm
         Ysyg==
X-Gm-Message-State: APt69E2bmZ4IhIbS2TCmcVcrC42mvO5Z3Etf4D9ufIB1vYTwxKMVIQzB
        DERv6OZ0ONRJ9+NmpNeMPscFPg6Kl3FV/DX34r0=
X-Google-Smtp-Source: ADUXVKJCT/wFgoV4zltyiZtnNuPI4rRcp/pEWvbx8+GCCK0pjYVpfMRm0bJb3q73ooepYMeqSJchTuRlgW2UXn6WsMM=
X-Received: by 2002:a9d:c61:: with SMTP id 88-v6mr2570803otr.173.1528304362445;
 Wed, 06 Jun 2018 09:59:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 09:58:52 -0700 (PDT)
In-Reply-To: <20180606165051.GH158365@google.com>
References: <20180606050207.13556-1-pclouds@gmail.com> <20180606073933.14755-1-pclouds@gmail.com>
 <20180606073933.14755-8-pclouds@gmail.com> <20180606165051.GH158365@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Jun 2018 18:58:52 +0200
Message-ID: <CACsJy8AZdOQGimhg00ZGwv=ESquDaLae_poj1Au_hE5kaW8ksg@mail.gmail.com>
Subject: Re: [PATCH v3 07/20] attr: remove an implicit dependency on the_index
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 6:50 PM, Brandon Williams <bmwill@google.com> wrote:
> On 06/06, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Make the attr API take an index_state instead of assuming the_index in
>> attr code. All call sites are converted blindly to keep the patch
>> simple and retain current behavior. Individual call sites may receive
>> further updates to use the right index instead of the_index.
>>
>> There is one ugly temporary workaround added in attr.c that needs some
>> more explanation.
>>
>> Commit c24f3abace (apply: file commited * with CRLF should roundtrip
>> diff and apply - 2017-08-19) forces one convert_to_git() call to NOT
>> read the index at all. But what do you know, we read it anyway by
>> falling back to the_index. When "istate" from convert_to_git is now
>> propagated down to read_attr_from_array() we will hit segfault
>> somewhere inside read_blob_data_from_index.
>>
>> The right way of dealing with this is to kill "use_index" variable and
>> only follow "istate" but at this stage we are not ready for that:
>> while most git_attr_set_direction() calls just passes the_index to be
>> assigned to use_index, unpack-trees passes a different one which is
>> used by entry.c code, which has no way to know what index to use if we
>> delete use_index. So this has to be done later.
>
> Ugh I remember this when I was doing some refactoring to the attr
> subsystem a year or so ago.  I really wanted to get rid of the whole
> "direction" thing because if I remember correctly its one of the only
> remaining globals that affects the outcome of an attr check (everything
> else was converted to use the attr check struct.  I always got way to
> far into the weeds when trying to do that too.  I'm not expecting that
> from this series (since its way out of scope) but maybe it'll be easier
> afterwards.

It's not that much easier. This direction thing is still global by
design. It would be great if we have something like Scheme's parameter
(aka. dynamic scoping iirc) then we can still scope this nicely. Git
does not live in such worlds.
--=20
Duy
