Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44A021F453
	for <e@80x24.org>; Thu,  7 Feb 2019 18:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfBGSBo (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 13:01:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38243 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGSBo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 13:01:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so825025wmh.3
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 10:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0Jua1VDXHG9/Cft/F9PdmcYjwNz/LHl8oUrFrzRN3Rk=;
        b=OcFqWlFUoNeJvAOgN9eJ2abjJNe0ZruNXoQFXxfUeXwGLDe9gxmGfRrisOWMp1tOdj
         ppqR6JaL9M0Am8NXtDJgWG8ycGM4EHRVT33thpDRJGBjK7n4bvIq9vF5SuJAmU1G2cP/
         deTAbLhf7Kg+hiVVaCFmTVxCQieQ5WhjZgEtGn4FDOJ3+OvZfX3Sutlz4C0q5AsWLD2/
         ITRxFylVuBk2V4so8WH1oCqpGCTKPf8vZoOCMhrefPelVL+aSZqKdBXveEtTFVyszIY/
         B1oiEW2fytgp3pcI3XeDgTOstfaDsHAeIytkJ64AVNHyoqCgeFPOEVP1NgmzfauEhU1D
         IZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0Jua1VDXHG9/Cft/F9PdmcYjwNz/LHl8oUrFrzRN3Rk=;
        b=X4nwS4emm11PjMeVU7xSOaYhc80Z7ZxSbD9bvUflD44JapDO8tUNIBmjxurreJlmm5
         alBfmMb1aua7NNOYJ6m85RkPEdfGaYqkRa+/kP0P4IGXyfQUWx/q7EdDsXWFNWnquNEL
         g6u/leggRZilsAl1W3EfKyPFaAAvQB4PqxUpk7BiUHz5KYlOGsOHdC3WGMEd7yGQxZjk
         J1XFWY+PbJ8nLztgA/4TE94j+Dfwd2Mgi47SHdJYAMISRWqf08Pe/hsO4C0fWMJ1SGEw
         Rn48yQLsBo0rpcpA18p7p1ddVaWQYWtdKNQqaLmyBWl4Mwl8lMl9keD2nxQ14etFqWzf
         EffA==
X-Gm-Message-State: AHQUAubZ36q4Fj6lEVo3yXUCJq5YAxOno2R2Y8C9N2Lpxl9VUZaOfu88
        LQ/bGdIQ1ZOU0qdtldy1li0=
X-Google-Smtp-Source: AHgI3IbEpVy4+7lbQcFKynldqfsvh0GzFFr/RINxuAvsfyH0NlqJhIO047hmAWVh+wkbC6cS0zFAZQ==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr4162974wmh.87.1549562501334;
        Thu, 07 Feb 2019 10:01:41 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x1sm18115767wru.34.2019.02.07.10.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 10:01:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Teach submodule set-branch subcommand
References: <cover.1549521103.git.liu.denton@gmail.com>
        <cover.1549534460.git.liu.denton@gmail.com>
Date:   Thu, 07 Feb 2019 10:01:40 -0800
In-Reply-To: <cover.1549534460.git.liu.denton@gmail.com> (Denton Liu's message
        of "Thu, 7 Feb 2019 02:18:52 -0800")
Message-ID: <xmqqo97npjej.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> I rebased the changes onto the latest 'next' because if this branch gets
> merged into 'next', there'll be merge conflicts from
> 'dl/complete-submodule-absorbgitdirs'.

Please don't do that.

A topic that depends on everything in 'next' cannot graduate to
'master' until everything that is cooking in 'next' does.

When

 - the "conflict" that would arise is so trivial to resolve,

 - there is no semantic crashes between the new topic and existing
    ones, and

 - the topic is usable even before other topics graduate (or even
   when they get discarded)

please make it a habit to avoid making your topic (i.e. this one)
hostage to another topic (i.e. the absorbgitdirs one), and certainly
not hostage to the whole of 'next'.  A trivial conflict resolution
in this case, if you revert the rebasing and then attempt to merge
the result to 'next', would look like this.

diff --cc contrib/completion/git-completion.bash
index 8b3b5a9d34,de56879960..0000000000
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@@ -2573,7 -2573,7 +2573,7 @@@ _git_submodule (
  {
  	__git_has_doubledash && return
  
- 	local subcommands="add status init deinit update set-branch summary foreach sync"
 -	local subcommands="add status init deinit update summary foreach sync absorbgitdirs"
++	local subcommands="add status init deinit update set-branch summary foreach sync absorbgitdirs"
  	local subcommand="$(__git_find_on_cmdline "$subcommands")"
  	if [ -z "$subcommand" ]; then
  		case "$cur" in


By the way, if conflicts worry you so much, one thing you could do
is this.  Instead of maintaining the ever-growing list of
subcommands and having to worry about textual conflicts, the
completion script could use a clean-up to reduce the need of textual
conflict resolution, when it is quiescent, perhaps like this (I am
assuming that in some future, there is a quiescent period _after_
both of these two topics landed, and this illustration patch is to
be used in such a future).

Merging two topics, each of which adds a new element by inserting a
new line with the element (and the element alone) is on it, is
certainly a lot easier and simpler than having to see what word is
getting inserted by each topic on a single long string on a line.


 contrib/completion/git-completion.bash | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0fccadfc97..5d7d4ebacc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2573,7 +2573,18 @@ _git_submodule ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="add status init deinit update set-branch summary foreach sync absorbgitdirs"
+	local subcommands="
+		add
+		status
+		init
+		deinit
+		update
+		set-branch
+		summary
+		foreach
+		sync
+		absorbgitdirs
+	"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		case "$cur" in



