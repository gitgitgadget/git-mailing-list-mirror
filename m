Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5F31F424
	for <e@80x24.org>; Fri, 27 Apr 2018 16:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758449AbeD0QEN (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 12:04:13 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:32924 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758214AbeD0QEM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 12:04:12 -0400
Received: by mail-wr0-f179.google.com with SMTP id o4-v6so2270826wrm.0
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=MMSfQrk6cuPPvIv4J92qrzWuIZZPHeuLXkI6LlSLzpw=;
        b=qRYJXSE6ntV2lhKwCGUvpZ5dE1WbVkelDKIGp3BA7dmoH8CzmPVyJyVPgMqlMjZHr/
         WonLe1cvIeLmZkDuxm3YZSnMae2ii72l02QUfv1ufGMU0feynduQ3JZ0JCU7sEy0a3En
         BeC7UXUdli0LpQV1FxII3ZPXpxGhrzV4jScpiTzkM6qNRFEQcxtBWR0qVfc8DpMgb7yn
         IBc2dxmFT3lttKMPYtqBOBHUG4tjKRYaGkq5O0gi71GaTEEGNmC0GPLpB1OuQAyEJzoh
         nGXeoc+nDc4dD0vS/oFIJMpLlsLtsi5r9ChRTpaGhdc8eiGlZZEQgYZKibg7QFD0PHha
         QadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=MMSfQrk6cuPPvIv4J92qrzWuIZZPHeuLXkI6LlSLzpw=;
        b=aaHVySyoYJ2eXXONGKpxz+LWbqr67w8RWSMw+RJGpXqO8yo7es/4GW7SBEkf+7NsTy
         sPDz+bOTgHe++r9ep3qMTyx84BdomvEiP67Jt19toTJgnE1fpkopQbbu+nAVuggZThL0
         VuPBN52Ak0zINBFJZEGo+pQFeZSReOpzWKy5bAHfDjirr4yKtj2+oPLeL8jixzExJHZU
         i8BBvpk6MDCvODBDZBCCPOVHnGSzAbFzwJe0kHnzbTFscf3LON8t5PRC41kBkUw6m+JW
         5m4uXBu3Vz/Yq/vMbHc5A70WytMCgLf/hCmNSFLgzLfEkdTW0sSzbRD4sAe5vHlCqEIH
         o7xA==
X-Gm-Message-State: ALQs6tCrju3Fv4nlRV7r75fer+C0UyHeFVxTUSFqCgvd+NzcO3LhSmmm
        s39vmigJUQNVOVPjH1OSBLw=
X-Google-Smtp-Source: AB8JxZoLRWc0CAuVjOABMJYjDz2Heq67F9wWdtWMgAZKuxk8iVrrh/FY1wU+wisH9OEd/SOCdPOlrw==
X-Received: by 2002:adf:b595:: with SMTP id c21-v6mr2382187wre.233.1524845051668;
        Fri, 27 Apr 2018 09:04:11 -0700 (PDT)
Received: from localhost.localdomain (x4db1beb3.dyn.telefonica.de. [77.177.190.179])
        by smtp.gmail.com with ESMTPSA id v66sm2319572wmd.41.2018.04.27.09.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 09:04:10 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     wferi@niif.hu (Ferenc =?utf-8?Q?W=C3=A1gner?=)
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: branch --contains / tag --merged inconsistency
Date:   Fri, 27 Apr 2018 18:03:44 +0200
Message-Id: <20180427160344.12724-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.551.g86756ed296
In-Reply-To: <87fu3g67ry.fsf@lant.ki.iif.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Szia Feri,

> I'm moving the IRC discussion here, because this might be a bug report
> in the end.  So, kindly try these steps (103 MB free space required):
> 
> $ git clone https://github.com/ClusterLabs/pacemaker.git && cd pacemaker
> [...]
> $ git branch --contains Pacemaker-0.6.1
> * master
> $ git tag --merged master | fgrep Pacemaker-0.6
> Pacemaker-0.6.0
> Pacemaker-0.6.2
> Pacemaker-0.6.3
> Pacemaker-0.6.4
> Pacemaker-0.6.5
> Pacemaker-0.6.6
> 
> Notice that Pacemaker-0.6.1 is missing from the output.  Kind people on
> IRC didn't find a quick explanation, and we all had to go eventually.
> Is this expected behavior?  Reproduced with git 2.11.0 and 2.17.0.

The commit pointed to by the tag Pacemaker-0.6.1 and its parent have a
serious clock skew, i.e. they are a few months older than their parents:

$ git log --format='%h %ad %cd%d%n    %s' --date=short Pacemaker-0.6.1^..47a8ef4c
47a8ef4ce 2008-02-15 2008-02-15
    Low: TE: Logging - display the op's magic field for unexpected and foreign events
b9cfcd6b4 2007-12-10 2007-12-10 (tag: Pacemaker-0.6.2)
    haresources2cib.py: set default-action-timeout to the default (20s)
52e7793e0 2007-12-10 2007-12-10
    haresources2cib.py: update ra parameters lists
dea277271 2008-02-14 2008-02-14
    Medium: Build: Turn on snmp support in rpm packages (patch from MATSUDA, Daiki)
f418742fe 2008-02-14 2008-02-14
    Low: Build: Update the .spec file with the one used by build service
ccfa716a5 2008-02-14 2008-02-14
    Medium: SNMP: Allow the snmp subagent to be built (patch from MATSUDA, Daiki)
50f0ade2d 2008-02-14 2008-02-14
    Low: Build: Update last release number
90f11667f 2008-02-14 2008-02-14
    Medium: Tools: Make sure the autoconf variables in haresources2cib are expanded
9d2383c46 2008-02-11 2008-02-11 (tag: Pacemaker-0.6.1)
    High: cib: Ensure the archived file hits the disk before returning

(branch|tag|describe|...) (--contains|--merged) use the commit timestamp
information as a heuristic to avoid traversing parts of the history,
which makes these operations, especially on big histories, an order of
magnitude or two faster.  Yeah, commit timestamps can't always be
trusted, but skewed commits are rare, and skewed commits with this much
skew are even rarer.

I'm not sure how (or if it's at all possible) to turn off this
timestamp-based optimisation.

FWIW, much work is being done on a cached commit graph including commit
generation numbers, which will solve this issue both correctly and more
efficiently.  Perhaps it will already be included in the next release.

