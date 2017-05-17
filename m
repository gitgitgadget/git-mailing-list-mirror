Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37F41201A7
	for <e@80x24.org>; Wed, 17 May 2017 18:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754774AbdEQSOE (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 14:14:04 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34180 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753465AbdEQSOC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 14:14:02 -0400
Received: by mail-pf0-f178.google.com with SMTP id 9so11227726pfj.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8d9PQwakUoTQlCS7hdoX2sJpeCIxU2z+BuD5IzXiAV4=;
        b=N4+ffOyak7cAJaKH2buwV+UPhqDehd6Wxmt8JdFrkMwa+2HkLvbn4cF88esYxvjbD7
         lCuhXFz9HmKMw3Ob7pM51S4XsmlUbY87URskBp6DLHYuecIRIjQXKhNhsx0z9plMYjAg
         as4ioIqbyq5i7Ho58Oq7yZRVn5/CZ4fzMU7eppXeN6Hg1ONfgkCMiEUq6AmNIO4jc9lZ
         BV/Fb16sJllUQ9M62PzKsl5Ff660fLF5C7Wt7fbt6hOSEIEddGU/5Y0nRGClVSIDVX0Z
         2sFrEUFODiHcWsDiQs5YARzjM/EOOCXF20hKHFX5YTy5B7OirZbEf7NFDGtkg/XBbG72
         Immg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8d9PQwakUoTQlCS7hdoX2sJpeCIxU2z+BuD5IzXiAV4=;
        b=LBh+kJNwl6CNwlByb5EDpwHJuF3nm9IsaYhQVw5+XqeX2NZn74cmc2Q5EsUEvbs5Rz
         JLiDS7hTnWmxhEdFw9QILmpmeq7qqUbOe7hzIAD66mffBs3vQJWK3FamoXTHHcQ04zco
         lciaLNOpiHEZrXZ04hsQ+L7GQLstMXWLhNlrtbCYTMs4p7xBCao/yb/hp8KMHHVoLysS
         E+J9xpi3nWVaS1kfySe/yH4TqiJpAflhhY7jYcr8jCcrQ6NGbrtkcPdIMyr8YWN4qfsJ
         gaYRL0jYTkYUzhoARQVLIDQGB0mWYvOloKFTbzKHS71dvyyOHvH27bDfH3HbBmoMpZd8
         FL9g==
X-Gm-Message-State: AODbwcDBVPKCGbDmtJ3SeEmzPRBaAl56OjL9ZxKv68EAOhnaV4RbJwFT
        eOzmIEb9GXwcJSkRfRFx95LmdwotozF5
X-Received: by 10.84.228.207 with SMTP id y15mr99218pli.172.1495044841069;
 Wed, 17 May 2017 11:14:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 17 May 2017 11:14:00 -0700 (PDT)
In-Reply-To: <20170517134241.5zqaqptfgjrrrbju@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu> <20170517134241.5zqaqptfgjrrrbju@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 17 May 2017 11:14:00 -0700
Message-ID: <CAGZ79kaNxyh_3eJUZ7VRL673K4_nYD-KosAyv=grzWRCSzYT9Q@mail.gmail.com>
Subject: Re: [PATCH 00/23] Prepare to separate out a packed_ref_store
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 6:42 AM, Jeff King <peff@peff.net> wrote:
> On Wed, May 17, 2017 at 02:05:23PM +0200, Michael Haggerty wrote:
>
>> This patch series is the next leg on a journey towards reading
>> `packed-refs` using `mmap()`, the most interesting aspect of which is
>> that we will often be able to avoid having to read the whole
>> `packed-refs` file if we only need a subset of references.
>>
>> The first leg of the journey was separating out the reference cache
>> into a separate module [1]. That branch is already merged to master.
>>
>> This patch series prepares the ground for separating out a
>> `packed_ref_store`, but doesn't yet take that step. (As you can see,
>> it's a long enough patch series already!) It's kind of a grab bag of
>> cleanup patches plus work to decouple the packed-refs handling code
>> from the rest of `files_ref_store`. Some highlights:
>
> I dropped a few minor comments in individual patches, but it all looks
> good to me up through patch 22. Your description in patch 23 makes
> sense, but I was too frazzled by the end to carefully review the code
> itself for that patch. I'll try to come back to it later.

Same here.

Thanks,
Stefan
