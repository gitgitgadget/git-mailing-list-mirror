Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D397A1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 16:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754481AbeDQQsi (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 12:48:38 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:40256 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753592AbeDQQsg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 12:48:36 -0400
Received: by mail-lf0-f46.google.com with SMTP id i18-v6so13306400lfc.7
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 09:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iiZKTCGZ56Fvht9zgkqL7doLdD2z5TLzulIeMrD90FA=;
        b=N6JypIcDdTVqZ0XQmrNbd9rlpMSTtcBDN5KwpSz4Lxdd5YWPW7rv/KCrLp7bP52iP9
         yw2uPTEFMBFO7hsH3hFekOOTK7fgpt3kcwcO7SgocyvKx36MZP8DHkBpSmnM2EI1jn3f
         HSpp/I5kfrghNH1pmhCbBscj0tjID2vAB+3lJvi7xu9nROHPFo3ZX/T+uz/RWH8xJVQ9
         gWJ/pbPK5pCREfybI1H/EG7+mbT0bbcYh05mbhUz3bRpOJWH+EmstOw9OtKYPuegd9NJ
         ZTQ+YRtBmcywLCrUuH/DvL1qR96tOTHwpetOyu+6eK5NfT2ucqVvTuTxcL6a6G3aY2+I
         CIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iiZKTCGZ56Fvht9zgkqL7doLdD2z5TLzulIeMrD90FA=;
        b=hv9au42Y02MHWx29rXYCZ1lUDB5FKHBMBnPMCUEOgPhSd7VP/agv20qVkX3bFdFc7+
         7O/XL+/0J1FXA3nGhn6qGHfIf2R0hSVWjCKEFselzuzJWI7V1lgxiifmnMW2X4w/wSEN
         YiXsRaV7zeIltLtjkSQmeCp6g9scrTykkg/YkQzcUfwL7DslEVlQu91dNyN5HJGxgCNO
         UXc4c0Q/+OqLm0I3JEKdA3qemGds6/0xTvEP9BSs10zitNX6s+p84h1h1oT2RerLS5f3
         Z0Nkkqn4l3ZdEGtdpUB1W56YpOdE5J5N+RQLDkei92ZJKYOc+LzWwStERYAAA2jAAe2U
         FWyg==
X-Gm-Message-State: ALQs6tB6m6mcGUxNotiksbZd8Sja/wDatWtbU9/VlyHfpjhvgnkTl71o
        xMtiibyG7JmUCaDD4SMwlZw=
X-Google-Smtp-Source: AIpwx4/DzHYl8iuuoIosce+HcS2QRaFQb82w7gAVQK0fkjcsWOhkXOVJtoRrf11OjXtCTHRMZUQskA==
X-Received: by 2002:a19:b54a:: with SMTP id e71-v6mr2044746lff.94.1523983714903;
        Tue, 17 Apr 2018 09:48:34 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g1sm259844lje.58.2018.04.17.09.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Apr 2018 09:48:33 -0700 (PDT)
Date:   Tue, 17 Apr 2018 18:48:31 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH/RFC 0/5] Keep all info in command-list.txt in git binary
Message-ID: <20180417164831.GA18563@duynguyen.home>
References: <20180326165520.802-1-pclouds@gmail.com>
 <CAPig+cTW7KRzXXY7vP-GZ23effYd5jLhiL15KqdRam4rNELCWw@mail.gmail.com>
 <FBB059C530054EEAB2E989D86CBE3BD5@PhilipOakley>
 <CACsJy8BqoW_YWBiMoOks+WM5XY7Mmadkd0LUBoUWLDXehx1GZQ@mail.gmail.com>
 <A9B6B3A17C4844C69F8865C01BCFC51A@PhilipOakley>
 <CACsJy8BTX=6FsH7-Dc86ExQRfBSNVn9yxD5JrNZyLT9VDQOPEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BTX=6FsH7-Dc86ExQRfBSNVn9yxD5JrNZyLT9VDQOPEg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 06:24:41PM +0200, Duy Nguyen wrote:
> On Sun, Apr 15, 2018 at 11:21 PM, Philip Oakley <philipoakley@iee.org> wrote:
> > From: "Duy Nguyen" <pclouds@gmail.com> : Saturday, April 14, 2018 4:44 PM
> >
> >> On Thu, Apr 12, 2018 at 12:06 AM, Philip Oakley <philipoakley@iee.org>
> >> wrote:
> >>>
> >>> I'm only just catching up, but does/can this series also capture the
> >>> non-command guides that are available in git so that the 'git help -g'
> >>> can
> >>> begin to list them all?
> >>
> >>
> >> It currently does not. But I don't see why it should not. This should
> >> allow git.txt to list all the guides too, for people who skip "git
> >> help" and go hard core mode with "man git". Thanks for bringing this
> >> up.
> >> --
> >> Duy
> >>
> > Is that something I should add to my todo to add a 'guide' category etc.?
> 
> I added it too [1]. Not sure if you want anything more on top though.

The "anything more" that at least I had in mind was something like
this. Though I'm not sure if it's a good thing to replace a hand
crafted section with an automatedly generated one. This patch on top
combines the "SEE ALSO" and "FURTHER DOCUMENT" into one with most of
documents/guides are extracted from command-list.txt

-- 8< --
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6232143cb9..3e0ecd2e11 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -292,6 +292,7 @@ doc.dep : $(docdep_prereqs) $(wildcard *.txt) build-docdep.perl
 
 cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-ancillarymanipulators.txt \
+	cmds-guide.txt \
 	cmds-mainporcelain.txt \
 	cmds-plumbinginterrogators.txt \
 	cmds-plumbingmanipulators.txt \
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 5aa73cfe45..e158bd9b96 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -54,6 +54,7 @@ for (sort <>) {
 
 for my $cat (qw(ancillaryinterrogators
 		ancillarymanipulators
+		guide
 		mainporcelain
 		plumbinginterrogators
 		plumbingmanipulators
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4767860e72..d60d2ae0c7 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -808,29 +808,6 @@ The index is also capable of storing multiple entries (called "stages")
 for a given pathname.  These stages are used to hold the various
 unmerged version of a file when a merge is in progress.
 
-FURTHER DOCUMENTATION
----------------------
-
-See the references in the "description" section to get started
-using Git.  The following is probably more detail than necessary
-for a first-time user.
-
-The link:user-manual.html#git-concepts[Git concepts chapter of the
-user-manual] and linkgit:gitcore-tutorial[7] both provide
-introductions to the underlying Git architecture.
-
-See linkgit:gitworkflows[7] for an overview of recommended workflows.
-
-See also the link:howto-index.html[howto] documents for some useful
-examples.
-
-The internals are documented in the
-link:technical/api-index.html[Git API documentation].
-
-Users migrating from CVS may also want to
-read linkgit:gitcvs-migration[7].
-
-
 Authors
 -------
 Git was started by Linus Torvalds, and is currently maintained by Junio
@@ -854,11 +831,16 @@ the Git Security mailing list <git-security@googlegroups.com>.
 
 SEE ALSO
 --------
-linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
-linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
-linkgit:gitcli[7], link:user-manual.html[The Git User's Manual],
-linkgit:gitworkflows[7]
+
+See the references in the "description" section to get started
+using Git.  The following is probably more detail than necessary
+for a first-time user.
+
+include::cmds-guide.txt[]
+
+See also the link:howto-index.html[howto] documents for some useful
+examples. The internals are documented in the
+link:technical/api-index.html[Git API documentation].
 
 GIT
 ---
diff --git a/command-list.txt b/command-list.txt
index 1835f1a928..f26b8acd52 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -150,10 +150,14 @@ git-whatchanged                         ancillaryinterrogators
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
 gitattributes                           guide
+gitcvs-migration                        guide
+gitcli                                  guide
+gitcore-tutorial                        guide
 giteveryday                             guide
 gitglossary                             guide
 gitignore                               guide
 gitmodules                              guide
 gitrevisions                            guide
 gittutorial                             guide
+gittutorial-2                           guide
 gitworkflows                            guide
-- 8< --
