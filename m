Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11551F453
	for <e@80x24.org>; Wed, 24 Apr 2019 11:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfDXLZz (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 07:25:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43269 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfDXLZz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 07:25:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id a12so1360009wrq.10
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 04:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gSaZXm56l6aJjLlvuVSQd9bTt/GnNgHu/OLC9Xjd8Lg=;
        b=jS/VjWKgkatA/Dy5t03hD/PLqCPfXpTjn3wTQUH0BopVS3zVhbAIrzleKbENxBY45V
         3uBJOJlbJHOQ+zRtxXDGL72kjrho2h3QDiQIRl/Geujg+5hSAJjxc/Rv4qmkJfCViRGs
         Mvm6EU4QgdQ9+MTH4ltvSahd8LM/JLyZ5y10cYvMXGo1C9jpnTKlqycuFMu8kSGV4Km4
         hXmysGoo93XkjagMG4DJO2EruDbXXIHUoXwoTRFbryG5oDTo8RpjO/2J8XuD+qOEC9yH
         U/00VEulBrH8klF1eP7snHH2793lyb7wkpOsUvW4B+Asub3loTasDUwRo+mXQlB3m25b
         J/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gSaZXm56l6aJjLlvuVSQd9bTt/GnNgHu/OLC9Xjd8Lg=;
        b=XmA2FxlHGJQcse30zplqCSipV4etqFTn2tat2ewEUzoCKuZ3pRfiVPqtjHxLf0ovWP
         LSioJsBWOxwwSFygLdBB1Po7UQ8GEAtDPjlEiP6bd+ZEkTSfXDS7bFGAMBHGVibTR38E
         Jf/cwj9Zm9RrCWYm3+6+pyRS73TuDWokJOp10ekCy6r0SGvfzLGXk69Emfhk9gGOu0Pv
         YEbME3bC7G+4h453qHr2OYhsecy7eWmVPMO9n4RNxabzm20m2AL1haUmqmBub+uwaKo/
         A5m7VfQRHQ+BV2vseQYsQEK1oNLjUbABfoYloPPnHP1GO8K3fhmWITwEqWP2EAUy5tWc
         0anQ==
X-Gm-Message-State: APjAAAUT01gHqlHw4nslbetkZW6TElydN1/Ik2f2+j0mskcZCBLNnfml
        lMJZQR/i3HkxGHxMyIRAN8M=
X-Google-Smtp-Source: APXvYqyfKAAF0DkHVm4VymRU1ZnaU2bZePfKfbZj9PlMMJ2Lvx2HKAfS1XN7ZbcqFnpA1vYimFAP3A==
X-Received: by 2002:adf:d081:: with SMTP id y1mr11370906wrh.283.1556105153592;
        Wed, 24 Apr 2019 04:25:53 -0700 (PDT)
Received: from szeder.dev (x4db31470.dyn.telefonica.de. [77.179.20.112])
        by smtp.gmail.com with ESMTPSA id z14sm26026116wro.81.2019.04.24.04.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 04:25:52 -0700 (PDT)
Date:   Wed, 24 Apr 2019 13:25:50 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] Makefile: dedup list of files obtained from ls-files
Message-ID: <20190424112550.GC8695@szeder.dev>
References: <xmqqy343a43b.fsf@gitster-ct.c.googlers.com>
 <20190422144927.GA6519@sigill.intra.peff.net>
 <20190423202109.GA8695@szeder.dev>
 <xmqqlg0043km.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlg0043km.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 24, 2019 at 10:03:37AM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > I remember being rather puzzled by 'git ls-files' listing the same
> > file more than once depending on its --options when I was working on
> > the git-aware path completion parts of our completion script.
> 
> Yup, I recall a thread we recently had where we wondered why we see
> two entries reported when we ask for 'modified' and 'deleted' at the
> same time.
> 
> Perhaps not-so-low-hanging fruit miniproject would be to teach
> "ls-files" a new "--dedup" option that does two things:
> 
>  * When -m and -d are asked at the same time, ignore '-d', because
>    '-d' will give duplicates for subsets of what '-m' would show
>    anyway; and

There are other combination of options that need similar treatment,
e.g. '--cached --modified', '--cached --deleted', and I vaguely
remember a combination involving '--killed' as well.

On second thought, however, I'm not sure that such a '--dedup' option
would be all that useful in the above cases.  If the users have to
adjust their 'git ls-files' invocation by specifying '--dedup' to
avoid the same paths listed multiple times, then they might just as
well remove the redundant options.  After all, a deleted file is
inherently modified, and a modified file is inherently cached...

>  * When neither -s nor -u is given, do not show the same path more
>    than once, even the ones with multiple stages.
> 
