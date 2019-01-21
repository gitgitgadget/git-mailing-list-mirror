Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B2CB1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 09:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfAUJ7M (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 04:59:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43910 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfAUJ7M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 04:59:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so16053427eds.10
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 01:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=5mgwxoGRcqx2daiDlxEA9s1YRlcHgMx8igRfx8ms2pk=;
        b=hCg87Q5BxvSbmVG+cZTmJuWbf8qM6uXd1Il39xN7ckR/U/n4pjHbG6PeQmKsYoonA6
         dUzJcOMEMgb4384wi9caN6rze2pgpgs9WYOKifl4tLf/K7Deuhjg/KXcjdTdBLTLXy/k
         WX4gJ29twakWiKU7Fgfe15KE9KNjYcgKgm/F1Jvs1l+1Bc715+dQHIjR6VF+WcKpFJ+u
         kwrZeemTFknVtd8pgWIMzmsKO1Lbgevik03vMZZ0eAggoZ/kN0j00MNx9OxJSD9ub6Sq
         CN9rrsiflNRQgDA9ZbX00X0KT1P+xgoK2hum43NEtRlt6a+Vrnqxtgq+rNSziIqiB7YF
         Exgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=5mgwxoGRcqx2daiDlxEA9s1YRlcHgMx8igRfx8ms2pk=;
        b=cMjxshoqqY7Q9oVjLmMaEhERXGSScLiXGaoNfhis+pm4/830THiAE7KUUn2hAwi++j
         qk16h4pu/I/Ktsp3iPAS+Yb3dT1W/ieSOhhaXCNAhOBv+ZwEb0x0TeRea48btvfeyZEg
         dkC4XejJNGY9IfDZsMcghucb8ZjAAbBLi1lGOImlDgCYVUHQtvpTIufSi1iAZsz/0zFM
         HZdULfGKUYj+ahPnFd28NJEEzDmaW3+v/xZQt8EO2KBH5eqzNnB34qJGM1xkYj9VwZwN
         wxKNv9kZ+4mQ6WnUji7Bp/BMbC3vu8jmOLZs8IXoSRpv95EmaHo56IPoEorPY+PppF5C
         9EYw==
X-Gm-Message-State: AJcUukcgNUF+FBLD5sHrTJwT4tHvnAqJgIdPJXaThO0y8kmzk4ouFZTY
        tMAyhI6cYTlmXQo/oZCGCPE=
X-Google-Smtp-Source: ALg8bN5f6o67n95cbjq0LdmL1lPx6PykfYPj67tMIablwraikiTTJOQ85JB3WA+IITUSmpwXkCi0eg==
X-Received: by 2002:a50:8a45:: with SMTP id i63mr26659745edi.262.1548064750210;
        Mon, 21 Jan 2019 01:59:10 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id r42sm9192636edd.23.2019.01.21.01.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 01:59:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH v3 7/7] add--interactive.perl: use add--helper --show-help for help_cmd
References: <pull.103.v2.git.gitgitgadget@gmail.com> <pull.103.v3.git.gitgitgadget@gmail.com> <b9a1a7e37a477e978f19cbcc9b41f80519de54da.1548062019.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <b9a1a7e37a477e978f19cbcc9b41f80519de54da.1548062019.git.gitgitgadget@gmail.com>
Date:   Mon, 21 Jan 2019 10:59:08 +0100
Message-ID: <87fttm49hv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 21 2019, Slavica Djukic via GitGitGadget wrote:

> From: Slavica Djukic <slawica92@hotmail.com>
>
> Change help_cmd sub in git-add--interactive.perl to use
> show-help command from builtin add--helper.
>
> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
> ---
>  git-add--interactive.perl | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index a6536f9cf3..32ee729a58 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1717,16 +1717,7 @@ sub quit_cmd {
>  }
>
>  sub help_cmd {
> -# TRANSLATORS: please do not translate the command names
> -# 'status', 'update', 'revert', etc.
> -	print colored $help_color, __ <<'EOF' ;
> -status        - show paths with changes
> -update        - add working tree state to the staged set of changes
> -revert        - revert staged set of changes back to the HEAD version
> -patch         - pick hunks and update selectively
> -diff          - view diff between HEAD and index
> -add untracked - add contents of untracked files to the staged set of changes
> -EOF
> +	system(qw(git add--helper --show-help));
>  }
>
>  sub process_args {

Both this and an earlier change in this series replaces a callback
command with an invocation of system() without any error checking. So if
this add-helper fails for whatever reason we'll silently fail to report
it.

I think it makes sense to put something like the following WIP code
earlier in the series. Then if the command was e.g. ["false", "git",
"status"] we'd see:

    What now> s
    oh noes when running 'false git status': returned error '1'

WIP patch. Obviously not ready as-is, but feel free to consider this to
have my SOB & adapt it.

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 20eb81cc92..1cd5f8122b 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1777,7 +1777,7 @@ sub process_args {
 }

 sub main_loop {
-	my @cmd = ([ 'status', \&status_cmd, ],
+	my @cmd = ([ 'status', ["git", "status"] ],
 		   [ 'update', \&update_cmd, ],
 		   [ 'revert', \&revert_cmd, ],
 		   [ 'add untracked', \&add_untracked_cmd, ],
@@ -1794,11 +1794,23 @@ sub main_loop {
 					     ON_EOF => \&quit_cmd,
 					     IMMEDIATE => 1 }, @cmd);
 		if ($it) {
-			eval {
-				$it->[1]->();
-			};
-			if ($@) {
-				print "$@";
+			my $cb = $it->[1];
+			if (ref $cb eq 'CODE') {
+				eval {
+					$cb->();
+					1;
+				} or do {
+					print "$@";
+				};
+			} else {
+				if (system(@$cb) != 0) {
+					if ($? == -1 || $? & 127) {
+						print STDERR "oh noes when running '@$cb': unexpected '$?'\n";
+					} else {
+						my $ret = $? >> 8;
+						print STDERR "oh noes when running '@$cb': returned error '$ret'\n";
+					}
+				}
 			}
 		}
 	}
