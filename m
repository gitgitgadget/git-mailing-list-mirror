Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6521F404
	for <e@80x24.org>; Wed, 20 Dec 2017 21:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756020AbdLTVNN (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 16:13:13 -0500
Received: from mail-pl0-f46.google.com ([209.85.160.46]:35745 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755747AbdLTVNM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 16:13:12 -0500
Received: by mail-pl0-f46.google.com with SMTP id b96so9726861pli.2
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 13:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=KlVv4qULMPHJfEd8lJyG3s9ruYGO3V1BV7bWeYmygkY=;
        b=FtkpLEHCoWZpDPDpGXt5X0xdBNLUG9hLUPercP4iobQddhQBPlpTm2vPAxSBmNr3Ow
         H2mRcTJaV0edK60vgKYk5vrP3JUc209gfahvIlbo5ZeQdrTfdExTRFVKNJpsN71zevJu
         S8Kvb9DOo2u6hTxJoG44uyMeLljBmY9Ic7M4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=KlVv4qULMPHJfEd8lJyG3s9ruYGO3V1BV7bWeYmygkY=;
        b=I2pmbT4l0BJEqM7zhN0YaJEwAOzAHHE0atiEKl2+qeeNu8StEw2P/iCoXKi0OyiaMI
         9cCx86I1lodKEn/Cdpb2gD44nQPhB3W0meEd4RyP4rSQxszqqmOth8Dl6yIXH65JAxg9
         yTtF7EOUt+wmoZdBOJiX7bXHdzx/y/o+9C3W1g16u8EmeFXi/HV5DYx/eOSXby7c1yBS
         gsRDBP6CrFav/8EM58gIFTuJGiUZV5Sfz42GILZDzMQgqZdRvSX+IIHYLdsyROXwTmru
         Of4SFwzaOwRtrhIN9GALRFeCNxnzYIbBkebudU9IkjTb1AGMUrJowW4+tPQFxdgxOFE7
         cKDw==
X-Gm-Message-State: AKGB3mLwsQWhyngIiprP9W0/KbfGfHLtfNMGDLsLO1hognzJeOCRmnZv
        KUCvILTaIVM1J5+XrtXjaAXSVSaj8z0=
X-Google-Smtp-Source: ACJfBovIcGGe6iBrrOfCwVbN3NodX1a2MPV9ZjdpiQcX6pkOD2S+j9nIYulgpSNw6FV1Fpd/EOcBrA==
X-Received: by 10.84.248.148 with SMTP id q20mr8413290pll.110.1513804391441;
        Wed, 20 Dec 2017 13:13:11 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (Guest-GW2.corp.dropbox.com. [205.189.0.166])
        by smtp.gmail.com with ESMTPSA id a23sm34579089pfa.177.2017.12.20.13.13.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Dec 2017 13:13:10 -0800 (PST)
Date:   Wed, 20 Dec 2017 13:12:56 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     git@vger.kernel.org
cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 3/6] fsmonitor: Update helper tool, now that flags are
 filled later
In-Reply-To: <e3246bad10b891d8e3f751b6ed368a9e3f37c425.1513642743.git.alexmv@dropbox.com>
Message-ID: <alpine.DEB.2.10.1712201259520.10810@alexmv-linux>
References: <20171219002858.22214-1-alexmv@dropbox.com> <e3246bad10b891d8e3f751b6ed368a9e3f37c425.1513642743.git.alexmv@dropbox.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 18 Dec 2017, Alex Vandiver wrote:
> dd9005a0a ("fsmonitor: delay updating state until after split index is
> merged", 2017-10-27) began deferring the setting of the
> CE_FSMONITOR_VALID flag until later, such that do_read_index() does
> not perform those steps.  This means that t/helper/test-dump-fsmonitor
> showed all bits as always unset.

This isn't the right fix, actually.  With split indexes, this puts us
right back into "only shows a few bits" territory, because
do_read_index doesn't know about split indexes.

Which means we need a way to do the whole index load but _not_
add/remove the fsmonitor cache, even if the config says to do so.

The best I'm coming up with is the below -- but I'm not happy with
it, because 'keep' is meaningless as a configuration value outside of
testing, since it's normally treated as an executable path.  This uses
the fact that fsmonitor.c currently has a:

        switch (fsmonitor_enabled) {
        case -1: /* keep: do nothing */
                break;

...despite get_config_get_fsmonitor() havong no way to return -1 at
present.

Is this sort of testing generally done via environment variables,
rather than magic config values?
 - Alex

---------------------8<----------------
diff --git a/config.c b/config.c
index 6fb06c213..75fcf1a52 100644
--- a/config.c
+++ b/config.c
@@ -2164,8 +2164,13 @@ int git_config_get_fsmonitor(void)
        if (core_fsmonitor && !*core_fsmonitor)
                core_fsmonitor = NULL;

-       if (core_fsmonitor)
-               return 1;
+
+       if (core_fsmonitor) {
+               if (!strcasecmp(core_fsmonitor, "keep"))
+                       return -1;
+               else
+                       return 1;
+       }

        return 0;
 }
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index ad452707e..12e131530 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -5,8 +5,9 @@ int cmd_main(int ac, const char **av)
        struct index_state *istate = &the_index;
        int i;

+       git_config_push_parameter("core.fsmonitor=keep");
        setup_git_directory();
-       if (do_read_index(istate, get_index_file(), 0) < 0)
+       if (read_index_from(istate, get_index_file()) < 0)
                die("unable to read index file");
        if (!istate->fsmonitor_last_update) {
                printf("no fsmonitor\n");
-----------------8<---------------------
