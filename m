Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC96B1F404
	for <e@80x24.org>; Wed, 17 Jan 2018 00:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeAQAoc (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 19:44:32 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:38762 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeAQAob (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 19:44:31 -0500
Received: by mail-pf0-f176.google.com with SMTP id k19so10606854pfj.5
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 16:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5g2xLrQjOnI2gmNpkL/uW2Kelb1uoaAukFqcUhwV3OM=;
        b=JKQgaIu7xigybFWYWwuk4gjsO62ORpwyA+A2ovtGDjUT1YTrbvnA/pglKxxOI/+/5H
         oUnqENG4ELv9KbATTrvhHlxtJKO0034NMAhkmA3iqR1Zmah5MyEiMp4f3xdtfJ2Ktytv
         MMXSzcjoXc+eBbF882PWfhZ4LW2rY535R2yBslu09UVVbBEmnaW+USw44/kxLR1Vj65K
         UoB3r5PEHRZt/NDXduAI6wLIdIrnJU4eo2zw1noSckEXz7gwpA31FJPdHMnLYmSFSVww
         PQTWTo8xh/y+H1xwvpa2Ed7mo2xjGHk5eJ2OG+6UdPVdiOiDVZJvs9FjaZglNNIMywyb
         Wc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5g2xLrQjOnI2gmNpkL/uW2Kelb1uoaAukFqcUhwV3OM=;
        b=Z9VxZrLNgoMpKMAkeDtoAZ+p0WdA4W4KD4iAphJnRVUZjMBDPly40o6o1ywqOsMonj
         Hg5oTkKx8KHnP8ayFEcOFJG9nvftFu/jYRsAvGidl92aEVqLhwn7UW+s6na+0mQmQVgO
         RhBNCyRPlr459wozQN4hpCLgZDYC8Vqx0jHgw0anrwox8pNaeltfP0cVpPm8y3S9fiAM
         v3y3aYi10JRHk6pzNGM+yembFKb9519nwdtoH2UkO6Ie1B6iXtXvI4oPyU4FKqjwUzzK
         KPSIsw3hwKhtdnTGdrVTE3CDylDZzLYhYTuMu8UTI2sq7yG9IO+b7g5r7b7EhQwhaxsP
         o1Tg==
X-Gm-Message-State: AKGB3mIBCc2ePJZTBp2y6dRQ8SYYymWbQIfswYMOsELI+Sgk09L8i+a+
        Fnyluz7LEOuH7nzoQRrfgVc=
X-Google-Smtp-Source: ACJfBotlBCs9KzDpYZmQBESOJ77W2eR8Qy3GAY0e0nL8C9rTLyjsjOG1wlpXppr0AlbXdEBmxqIAOg==
X-Received: by 10.98.204.75 with SMTP id a72mr28032655pfg.211.1516149870885;
        Tue, 16 Jan 2018 16:44:30 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id u10sm4852503pgo.31.2018.01.16.16.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2018 16:44:29 -0800 (PST)
Date:   Wed, 17 Jan 2018 07:44:19 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Keith Smiley <k@keith.so>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] Add shell completion for git remote rm
Message-ID: <20180117004419.GA14263@duynguyen.dek-tpc.internal>
References: <20171229135240.GQ3693@zaya.teonanacatl.net>
 <20171229224825.31062-1-szeder.dev@gmail.com>
 <87y3ll6s0e.fsf@evledraar.gmail.com>
 <20171230005222.GT3693@zaya.teonanacatl.net>
 <87vago76i8.fsf@evledraar.gmail.com>
 <xmqq373miw4r.fsf@gitster.mtv.corp.google.com>
 <1516052626.2870893.1236353440.65CA651A@webmail.messagingengine.com>
 <CACsJy8Dzv3qPc1dB1rdvYL+CvEp+hY8ddoBrbCiP5KnqikzyLw@mail.gmail.com>
 <xmqqh8rlvdgh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8rlvdgh.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 10:57:34AM -0800, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Tue, Jan 16, 2018 at 4:43 AM, Keith Smiley <k@keith.so> wrote:
> >> So it sounds like either we should deprecate rm, or I should update the patch to the suggested method where we just complete remotes, but not rm in the list of completions.
> >
> > I vote for deprecation. I could send a patch to start warning to
> > switch from 'rm' to 'remove'. Then perhaps we can delete it after two
> > releases. It's not classified as plumbing should we don't have worry
> > too much about scripts relying on 'remote rm'.
> 
> I do not know about "two releases" part (which amounts to merely
> 20-24 weeks), but looking at "git remote -h" output and seeing that
> we do spell out "rename" (instead of saying "mv" or something cryptic),
> it probably makes sense to remove "rm" some time in the future.
> 
> I actually do think "rm" is _already_ deprecated.  
> 
> "git remote --help" does not mention it in its synopsis section and
> it merely has ", rm" after "remove" as if an afterthought.

It's actually my bad. I should have replaced 'rm' with 'remove' in
git-remote.txt in e17dba8fe1 (remote: prefer subcommand name 'remove'
to 'rm' - 2012-09-06)

> I am not sure if it is worth being more explicit, perhaps like this?

Looks good. If we want to be more careful, we can follow up with
something even more annoying like this before removing 'rm'

-- 8< --
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 577b969c1b..0a544703e6 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -90,7 +90,6 @@ In case <old> and <new> are the same, and <old> is a file under
 the configuration file format.
 
 'remove'::
-'rm'::
 
 Remove the remote named <name>. All remote-tracking branches and
 configuration settings for the remote are removed.
diff --git a/builtin/remote.c b/builtin/remote.c
index d95bf904c3..774ef6931e 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1609,7 +1609,10 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = add(argc, argv);
 	else if (!strcmp(argv[0], "rename"))
 		result = mv(argc, argv);
-	else if (!strcmp(argv[0], "rm") || !strcmp(argv[0], "remove"))
+	else if (!strcmp(argv[0], "rm")) {
+		warning(_("'rm' is a deprecated synonym. Use 'remove' instead."));
+		result = rm(argc, argv);
+	} else if (!strcmp(argv[0], "remove"))
 		result = rm(argc, argv);
 	else if (!strcmp(argv[0], "set-head"))
 		result = set_head(argc, argv);
-- 8< --

PS. This also makes me thing about supporting subcommand aliases, so
that people can add back 'git remote rm' if they like (or something
like 'git r rm' when they alias 'remote' as well). Which is probably a
good thing to do. Long command names are fine when you have completion
support, they are a pain to type otherwise.

--
Duy
