Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457C41F453
	for <e@80x24.org>; Sat,  3 Nov 2018 06:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeKCPNf (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 11:13:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37132 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKCPNf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 11:13:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id c4-v6so3543087lja.4
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 23:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=K5YraAYULiXJGJKGVPBa9aiYDS83WK6hDY+WvGMT184=;
        b=lU9NgjBnZI971z9osdk8h/c4PDcKB45hSMcXJHCpZX6fJEZCVQkshvKIq7VO13KR2n
         i+6W50fppIjc2zPIeaPz77zWKvmxkHbnypTVN6jcxDu7tYCqJCek1P7DtF3wPWQsb+Hr
         KT5osdSY/9lOE+rkgCPcLwUiwsIHALRBS47hKKNl8vp4cjVL0MsLXhn9GAiXOhkBpSXV
         j5Ndb228YsUFV31v58VS4b0ZnUnjsh95nfN0HBD7s4QwmPISntm6So6jorNBkmfIeyCy
         m17afXUF4q5dti7stLY5lySX2bMLpWWEOsELc0G+L4PxHU/GWfkglNcMITCf3yGbB1UD
         HFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K5YraAYULiXJGJKGVPBa9aiYDS83WK6hDY+WvGMT184=;
        b=pXrDiGjUlE1rfC1Olm46qkmfwz6Ybzx1PWqQQ90q3N3VlFPURG+huaep6bi4fCD/Wb
         lew1w4N1E69LQbDAJbBc9b9cSZK0P+onTXqAIbf4aTSLVlcUfq7SpGssWWO4paXz9JhS
         UBqAdqb+3Ec5xy4x5yr8zYDbNDkD78H1NDs40O7gomFxBTZt06lHEV78C5lem/i8MVBH
         4F86EmWPYxIxfrCCE4+FcvCIC03qNw+xvKidx7AjK6LKkq6jEEhJNjQW2C1ura2b02B4
         OvkEgFgXu6XjSPPB35k+3nNLPyxnQiUxI3Xfv+DPOaYL8Tt2KqfUSs5zi3axYqAniWT7
         IeVQ==
X-Gm-Message-State: AGRZ1gLv/6F49t7cVwGU5OtO7Zezd+k5yXE7yv+BW01yUviwTj+Uo+Fd
        FM9jWYMWQv/AO9VvFedAMK4=
X-Google-Smtp-Source: AJdET5cIDoPZ3bdvXK93uC9CdmkqLjNMonaqyIieVhWQ3vMJqSK8NKN9bRQ/ojcoJ6UxyzkULFTwnw==
X-Received: by 2002:a2e:730a:: with SMTP id o10-v6mr8223788ljc.67.1541225001942;
        Fri, 02 Nov 2018 23:03:21 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e83-v6sm3507590ljf.32.2018.11.02.23.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 23:03:20 -0700 (PDT)
Date:   Sat, 3 Nov 2018 07:03:18 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Anmol Mago <anmolmago@gmail.com>, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com
Subject: Re: [PATCH v2] completion: use builtin completion for format-patch
Message-ID: <20181103060317.GA5432@duynguyen.home>
References: <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com>
 <72331ce9275ce995009fe8dd3d586bb9d71f2cbf.1540881141.git.liu.denton@gmail.com>
 <CACsJy8Ajc0qWw3RLak1PRPXvQzMHjaFuWJ6BPkhiVg=7fQvCnA@mail.gmail.com>
 <xmqqk1lxvaj6.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AowaAW91wGMYbC8aTOB1NoqQN-5NGx=qUCHp0i6zQRDA@mail.gmail.com>
 <xmqqzhuss6dd.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzhuss6dd.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 02, 2018 at 08:52:30AM +0900, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> >> > I have no comment about this. In an ideal world, sendemail.perl could
> >> > be taught to support --git-completion-helper but I don't think my
> >> > little remaining Perl knowledge (or time) is enough to do it. Perhaps
> >> > this will do. I don't know.
> >>
> >> So "all", "attach", etc. are added to this list while these similar
> >> options are lost from the other variable?  Is this a good trade-off?
> >
> > Not sure if I understand you correctly, but it looks to me that the
> > options in git-send-email.perl are well organized, so we could...
> 
> Yes, but I wasn't commenting on your "sendemail should also be able
> to help completion by supporting --completion-helper option" (I think
> that is a sensible approach).  My comment was about Denton's patch,
> which reduced the hard-coded list of format-patch options (i.e. the
> first hunk) but had to add back many of them to send-email's
> completion (i.e. the last hunk)---overall, it did not help reducing
> the number of options hardcoded in the script.
> 
> If it makes sense to complete all options to format-patch to
> send-email, then as you outlined, grabbing them out of format-patch
> with the --completion-helper option at runtime, and using them to
> complete both format-patch and send-email would be a good idea.  And
> that should be doable even before send-email learns how to list its
> supported options to help the completion.

OK how about this?

Minimal changes in send-email.perl and no duplication in
_git_send_email(). I could do $(git format-patch
--git-completion-helper) directly from _git_send_email() too but we
lose caching.

-- 8< --
Subject: [PATCH] completion: use __gitcomp_builtin for format-patch

This helps format-patch gain completion for a couple new options,
notably --range-diff.

Since send-email completion relies on $__git_format_patch_options
which is now reduced, we need to do something not to regress
send-email completion.

The workaround here is implement --git-completion-helper in
send-email.perl just as a bridge to "format-patch --git-completion-helper".
This is enough to use __gitcomp_builtin on send-email (to take
advantage of caching).

In the end, send-email.perl can probably reuse the same info it passes
to GetOptions() to generate full --git-completion-helper output so
that we don't need to keep track of its options in git-completion.bash
anymore. But that's something for another boring day.

Helped-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 16 ++++++----------
 git-send-email.perl                    |  8 ++++++++
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index db7fd87b6b..8409978793 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1532,13 +1532,9 @@ _git_fetch ()
 	__git_complete_remote_or_refspec
 }
 
-__git_format_patch_options="
-	--stdout --attach --no-attach --thread --thread= --no-thread
-	--numbered --start-number --numbered-files --keep-subject --signoff
-	--signature --no-signature --in-reply-to= --cc= --full-index --binary
-	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
-	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
-	--output-directory --reroll-count --to= --quiet --notes
+__git_format_patch_extra_options="
+	--full-index --not --all --no-prefix --src-prefix=
+	--dst-prefix= --notes
 "
 
 _git_format_patch ()
@@ -1551,7 +1547,7 @@ _git_format_patch ()
 		return
 		;;
 	--*)
-		__gitcomp "$__git_format_patch_options"
+		__gitcomp_builtin format-patch "$__git_format_patch_extra_options"
 		return
 		;;
 	esac
@@ -2081,7 +2077,7 @@ _git_send_email ()
 		return
 		;;
 	--*)
-		__gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
+		__gitcomp_builtin send-email "--annotate --bcc --cc --cc-cmd --chain-reply-to
 			--compose --confirm= --dry-run --envelope-sender
 			--from --identity
 			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
@@ -2090,7 +2086,7 @@ _git_send_email ()
 			--smtp-server-port --smtp-encryption= --smtp-user
 			--subject --suppress-cc= --suppress-from --thread --to
 			--validate --no-validate
-			$__git_format_patch_options"
+			$__git_format_patch_extra_options"
 		return
 		;;
 	esac
diff --git a/git-send-email.perl b/git-send-email.perl
index 2be5dac337..ed0714eaaa 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -119,6 +119,11 @@ sub usage {
 	exit(1);
 }
 
+sub completion_helper {
+    print Git::command('format-patch', '--git-completion-helper');
+    exit(0);
+}
+
 # most mail servers generate the Date: header, but not all...
 sub format_2822_time {
 	my ($time) = @_;
@@ -311,6 +316,7 @@ sub signal_handler {
 # needing, first, from the command line:
 
 my $help;
+my $git_completion_helper;
 my $rc = GetOptions("h" => \$help,
                     "dump-aliases" => \$dump_aliases);
 usage() unless $rc;
@@ -373,9 +379,11 @@ sub signal_handler {
 		    "no-xmailer" => sub {$use_xmailer = 0},
 		    "batch-size=i" => \$batch_size,
 		    "relogin-delay=i" => \$relogin_delay,
+		    "git-completion-helper" => \$git_completion_helper,
 	 );
 
 usage() if $help;
+completion_helper() if $git_completion_helper;
 unless ($rc) {
     usage();
 }
-- 
2.19.1.1005.gac84295441

-- 8< --
--
Duy
