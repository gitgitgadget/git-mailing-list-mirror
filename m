Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB3AA1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 22:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeINDTs (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 23:19:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33363 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeINDTs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 23:19:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so8332870wrc.0
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 15:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=P3nRnMZuE9m4r29/V0Gq1avKeh79uHc18rUuyAsqFpA=;
        b=CqZyDjH85aV9N6g7VrSAIHtMMhozGtyVnJmyydmUCsVGuH0loVLh0xC88FeBED6CR2
         OCIYrrVHd7cyyQbiNCJaFIaBOaRvQr21ZGYfDzHOxk3fUpiACLfTBoFBl26fhrillVj+
         jgE7KdsEoazyxPBe3qdb+OzF+ty/QyUMetVZARBbdLuAylMJcIcHRgZ6MsT99T+baoa+
         LJCEpI1lVe3LMdZVK8DIRy3nwpD/Y/mLWcyyltWHRHs3KfWq1FlqRynq4wvPu5VA2mNC
         VF8h7fbjHYs7XVJnBBORx9BH1TzkfiqUW2Oz281BOmS415rMWrFd7r8Tq9qPK+VEUyyE
         tQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=P3nRnMZuE9m4r29/V0Gq1avKeh79uHc18rUuyAsqFpA=;
        b=oGI1yEKyBbKJ4FGfv1isvX6e06WzhMk3qvyEW8PUEOt2MqD7wBDvEoeDxbIVfhzSc+
         TKAxzwCDwqVeVAvmcFRV1Ge+AV94pb6gXQ4R8v/U6wPruG3tdrw6lLrtOYFXlI2D2cI5
         vd5r0qvrCUxfC6iraAaXSqjguxsbNf9A0QCr6ddqrwnPS96zDbinbqbJBERbfAcFO5mm
         PuStthZ2E3lLvlKU8R7PEn/hf650yx2L9RaFOP1Cv/XPBVvCZGLKLmjduIFlIZ40PTlJ
         tpyi0BCrmW14d4Om+NFrTiuMgiqwEyd4FPoWTQW3fC7HMN8jKuz1TDDtBHnfXXFBW6cU
         mhcQ==
X-Gm-Message-State: APzg51BHToBf9gCPiO3nUAv8WOOHMonhSOZSeQ3qv99p1cW0ejkAxXh0
        Qg77D4/2s3Tyv7KvXYPnnrqTOKD+
X-Google-Smtp-Source: ANB0VdZe0fZJaJq+Zd5CteeFm3h7DGp1VWSiL3trbMJfswGqxHg85RmxNNTYvnrXeRVIhXy5zO2e5A==
X-Received: by 2002:adf:8504:: with SMTP id 4-v6mr6985577wrh.72.1536876502145;
        Thu, 13 Sep 2018 15:08:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g2-v6sm37365wme.20.2018.09.13.15.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 15:08:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, Ben Peart <benpeart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v1] read-cache: add GIT_TEST_INDEX_VERSION support
References: <20180912212544.33624-1-benpeart@microsoft.com>
        <20180912223101.GA1719@hank.intra.tgummerer.com>
        <4f8b4664-6108-db7f-cb40-2bc55d9edece@gmail.com>
        <20180913215616.GD1719@hank.intra.tgummerer.com>
Date:   Thu, 13 Sep 2018 15:08:20 -0700
In-Reply-To: <20180913215616.GD1719@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Thu, 13 Sep 2018 22:56:16 +0100")
Message-ID: <xmqqh8itdp9n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Thanks, I do think this is a good idea.  I do however share Ævar's
> concern in https://public-inbox.org/git/87h8itkz2h.fsf@evledraar.gmail.com/.
> I have TEST_GIT_INDEX_VERSION=4 set in my config.mak since quite a
> long time, and had I missed this thread, I would all of a sudden not
> run the test suite with index format 4 anymore without any notice.
>
> I think the suggestion of erroring out if TEST_GIT_INDEX_VERSION is
> set would be useful in this case (and probably others in which you're
> renaming these variables).

I am not enthused by "you are using an old variable---we fail your
build/test".  The assumption is that people let config.mak laying
around regardless of how new/old the vintage of Git they are
building and testing.  I do not think you'd want to adjust your
config.mak as you switch between 'maint' and 'next.

I think it is OK to make it error only if the old one is set without
the new one.  Then people can have _both_ set to the same value
during the period in which the topic sails through pu down to next
down to master, after seeing an failure once while building and
testing 'pu'.

> Btw, I think it would be nice to have all these renaming/documenting
> variables for the test suite patches in one series, so they are easier
> to look at with more context.

Yeah, even though these three were posted as independent changes,
their additions to t/README inevitably conflicted with each other.



