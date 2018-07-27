Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 913E41F597
	for <e@80x24.org>; Fri, 27 Jul 2018 18:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbeG0TuJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 15:50:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33825 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388879AbeG0TuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 15:50:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so5935211wrt.1
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RcjHjbTG7q+lcVC+v2gOJS1toJt9f1vOaZ8vq+XWikM=;
        b=tW0lObXEoQ4WOcTLlF5Fs/S4ERfEy/ke1ZTrBJvPDUgqpomJl7iJYIVqetvj2eSBM3
         0TpF0+0tUuPD8AJngNVLGtf9lyZVkLD90Lbb+aVjnchXKJrank88X4IEukI9U2Jew9WH
         kuFG3pEOGUBFVdb5JP5w9c6eCtozRYK7MPSvCdUyWlgIv0Q2G8Mtgm3ihk9aW1V9kAfw
         5wRIj0qWt6kQU+YRZ4idGzro3Pbcqqdm1fd3c+LFMaQ9cK65PAfEDuK30rWAesx+E/fQ
         ot2yPzVCnhBt1le5hvORxo/dWJtvjCIcLDhJHtA541pBhKnigfAHkjEKgrHJ1PnAahf9
         iF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RcjHjbTG7q+lcVC+v2gOJS1toJt9f1vOaZ8vq+XWikM=;
        b=lSGifLQjoqUBerSomUQUaxrxn3eaoqf1FbHKr0Iim/oVkLSlXpY/8fHAHrMaz4RyWu
         kZTWwOo7GPv4U2/HU8Prl7tATVnp0/NhpNAACypZkgRX7n78OYac0sI8Fdo1Lb+2Krk8
         PwgirVI1ZgPIDKS+5O2Mm9Ins2kPuF+JRSw2WuqT2OOIFNlHjF9EwS75eguH2MO4n6gQ
         88YciGITPD1HrSeZMF0zYn6MdImsjmM0OgBhpeL0qyVK65Qm8sdFyXpAJ9Z8HxKLRGuB
         ffd1YMCgq6R8E8suUExjVvY9Up43mDSaIPzFnhXIJq3CQCP/JJWkssGpXhovzJXUmH53
         S37g==
X-Gm-Message-State: AOUpUlEzzF9DsXesTcHly51jYDavvUrz31T3y8cZ8YXsVvpuRembpT/V
        7N9aAcUdmWing2HN8nUjYL5/7l0THAs=
X-Google-Smtp-Source: AAOMgpcHdIiJohFE7H9v3MviHpTU+pn9vfsRiqufH2Qm6zC3/BCFqgHf4orSczFmirY1h2eWy1+7TQ==
X-Received: by 2002:adf:8796:: with SMTP id b22-v6mr6069576wrb.92.1532716023155;
        Fri, 27 Jul 2018 11:27:03 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id p12-v6sm3522207wrw.3.2018.07.27.11.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 11:27:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v5 0/4] add -p: select individual hunk lines
References: <20180219113619.26566-1-phillip.wood@talktalk.net> <20180726155854.20832-1-phillip.wood@talktalk.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180726155854.20832-1-phillip.wood@talktalk.net>
Date:   Fri, 27 Jul 2018 20:27:00 +0200
Message-ID: <87effo5ybv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 26 2018, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Unfortuantely v4 had test failures due to a suprious brace from a last
> minute edit to a comment that I forgot to test. This version fixes
> that, my applogies for the patch churn.
>
> I've updated this series based on Ævar's feedback on v3 (to paraphrase
> stop using '$_' so much and fix staging modified lines.). The first
> patch is functionally equivalent to the previous version but with a
> reworked implementation. Patch 2 is new, it implements correctly
> staging modified lines with a couple of limitations - see the commit
> message for more details, I'm keen to get some feedback on it. Patches
> 3 and 4 are essentially rebased and tweaked versions of patches 2 and
> 3 from the previous version.

I was going to review this, but can't find what it's based on, I can't
apply 1/4 to master, next or pu. It seems to be based on some older
version of master, e.g. 1/4 has this hunk:

    +			elsif ($line =~ /^l/) {
    +				unless ($other =~ /l/) {
    +					error_msg __("Cannot select line by line\n");
    +					next;
    +				}
    +				my $newhunk = select_lines_loop($hunk[$ix]);
    +				if ($newhunk) {
    +					splice @hunk, $ix, 1, $newhunk;
    +				} else {
    +					next;
    +				}
    +			}
     			elsif ($other =~ /s/ && $line =~ /^s/) {

Which seems to conflict with your 4bdd6e7ce3 ("add -p: improve error
messages", 2018-02-13). I could have tried to manually apply this, but
figured I'd bounce this back to you...

Having just skimmed through the patches themselves I agree with this
approach of handling the simple case (as discussed before) and leaving
the rest for some future change, but let's see about the details once I
have this running.
