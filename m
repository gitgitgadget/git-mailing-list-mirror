Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6CAC1FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 10:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbdC3KHd (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 06:07:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35108 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932191AbdC3KHc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 06:07:32 -0400
Received: by mail-wr0-f193.google.com with SMTP id p52so10617678wrc.2
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=npqY/pWDCfPM/8J+HHx1LAlTLWyL/egqWMs78OveB7I=;
        b=NqrOHx+Dx7ExRsvTlNyMFmvzP+AUUrQmZQ1UYFTEosiw464QCh2XLxKaAgTPSgVLzj
         2LC4oXe+TuQhAilRn6EEIpVqbOpJXJFjHQqYw2iOrL3snVOhBJfCHjKkmj6VajXR88ni
         4aOXf/QrNl2b5+yGGuc/PxXdzHQjBQwbzcR4Ju/IxpUS4RhiMzeR5yBK8Q1UtGDakiXS
         O8zrD2ohPaVU5zXdSCgYvbZi5pWixiDqFTovdHoouM4SpGW3AhH9IAU5EH40fenemae7
         Xl8T82rxnSMk3jhhcmyEQRu5jG37Wz0et1dyKkWaLJzBUxUvvvasKrBDW9ovExc6JkPf
         pvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=npqY/pWDCfPM/8J+HHx1LAlTLWyL/egqWMs78OveB7I=;
        b=pudHta7xsboXgGywpUTTuUEE4BkjEHcfUFD2TnqNFZPRQIYkBF+BctrRA8a+/Pw3xs
         Pkd80+xlae1a7V0XQr4HULyJBlNZ9o3g+xe+/vuMsp37HdinF3uRLYwE1d5DFD1CupJE
         wRGCcqx8WY7RvG7toTIft8VZRs+k8iHPqKWTmeKSfLVvbAQfZxQHOD5PKqvgcHPmwWvk
         n+gUifFU1Gn0oFSCrPu3csQSWgZyp/eonfXBaTf8Npm0571xGv6InGYwXx+R25IHdYkX
         EWT997n3CtwleFgNZI2g+eKC20AqU3iLFnYMQaft6/gdZyf5vIehNacpLaN6Tqd4W2zV
         yaoA==
X-Gm-Message-State: AFeK/H0gwRg6EEaKdA4dIGMM/99Ul7EbbRxXCtuH5O4k7pLtN1Myx0mJQvyL8S6VtQ+5IQ==
X-Received: by 10.28.20.70 with SMTP id 67mr2680024wmu.86.1490868449843;
        Thu, 30 Mar 2017 03:07:29 -0700 (PDT)
Received: from localhost.localdomain (x590c107a.dyn.telefonica.de. [89.12.16.122])
        by smtp.gmail.com with ESMTPSA id q4sm2613183wme.17.2017.03.30.03.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Mar 2017 03:07:29 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] completion: offer ctags symbol names for 'git log -S', '-G' and '-L:'
Date:   Thu, 30 Mar 2017 12:06:56 +0200
Message-Id: <20170330100656.18766-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.2.453.g223d29900
In-Reply-To: <20170324005256.ji2wijhyqnwbpp5t@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 24, 2017 at 1:52 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 23, 2017 at 04:38:39PM +0100, SZEDER Gábor wrote:
> 
> > Just like in the case of search patterns for 'git grep', see 29eec71f2
> > (completion: match ctags symbol names in grep patterns, 2011-10-21)),
> > a common thing to look for using 'git log -S', '-G' and '-L:' is the
> > name of a symbol.
> > 
> > Teach the completion for 'git log' to offer ctags symbol names after
> > these options, both in stuck and in unstuck forms.
> 
> I think this makes sense and is an improvement over the status quo.
> 
> There are two gotchas with completing "-L" like this:

Reordering your gotchas for convenience...

>   2. The function name is actually a regex, so you can get bit when your
>      function name is a subset of another.

... and when the longer name comes first in the given file.  Yeah, I
was bitten by that a few of times, too :)

However, I found that completing symbol names can be quite helpful in
this case, because now I see that there are longer symbol names
starting with what I'm looking for while typing/completing the
command, and then I can just delete the trailing ':' and add a '\(:'
or '\ :' depending on language and coding style right away.  Of course
it doesn't help, if the function name in question is the suffix or a
substring in the middle of another one, but that seems to be even
rarer, or at least I've yet to come across such a case in practice.

>   1. You still have to come up with the filename yourself for "-L".

I was already quite satisfied that both the symbol name and the 
filename can be TAB completed...  but right, in most cases the
function name uniquely determines the filename, and even when it
doesn't, it still significantly limits the possibilities.  Hmhm.

Listing the funcname:filename together is not a good idea in my
opinion.  A small change to __git_match_ctag()'s awk script can show
why:

-               /^${1//\//\\/}/ { print pfx \$1 sfx }
+               /^${1//\//\\/}/ { print pfx \$1 \":\" \$2 sfx }

The amount of text flooding my terminal on completion is just
overwhelming (and I haven't even tried it in a Java project :), and it
breaks the "helpful" use-case with longer matching symbol names I
described above (it's much harder to see that there are longer
matching symbol names and I would have to backtrack the whole filename
to modify the funcname).  It also breaks symbol name completion for
'-G' and '-S', of course, so further changes would be necessary to
deal with that.

OTOH, the proof-of-concept patch at the bottom shows how we could
start doing filename completion based on the ctags file, and I think
it's really convenient to use.  Alas, it doesn't work when the
funcname is not on its own, e.g. ends with that disambiguating '\(:'
from above, and then Bash falls back to its own filename completion.
However, if I may extrapolate from my ~/.bash_history, this would
still help the great majority of the cases.

> I have a script (below) which makes this easier (and I complete its
> argument using the tags file).  It's probably too gross to even go into
> contrib, but I thought I'd share.

Perhaps 'git log -L' could be enhanced to just DWIM when it gets only
'-L:func:', and show the log of that function, wherever it is defined.
So instead of complaining about the missing filename, it could run
'grep <func>' with a bit of magic to find the filename where the
matching function is declared, and search in the history of that file.

But then again, 'git log -L' could be enhanced in so many ways...


Gábor


 -- >8 --

Subject: [PATCH] [PoC] completion: list only relevant filenames after 'git log
 -L:funcname:'

---
 contrib/completion/git-completion.bash | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d6f25a7e0..8b58096e4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1678,6 +1678,13 @@ __git_log_shortlog_options="
 __git_log_pretty_formats="oneline short medium full fuller email raw format:"
 __git_log_date_formats="relative iso8601 rfc2822 short local default raw"
 
+__git_filename_for_symbol ()
+{
+	local symbol="$1" tags="$2"
+
+	awk "/^${symbol//\//\\}/ { print \$2 }" "$tags"
+}
+
 _git_log ()
 {
 	__git_has_doubledash && return
@@ -1689,7 +1696,11 @@ _git_log ()
 	fi
 	case "$prev,$cur" in
 	-L,:*:*)
-		return	# fall back to Bash filename completion
+		local symbol="${cur#:}"
+		symbol="${symbol%%:*}"
+		__gitcomp_nl "$(__git_filename_for_symbol "$symbol" tags)" \
+			"" "${cur#:$symbol:}"
+		return
 		;;
 	-L,:*)
 		__git_complete_symbol --cur="${cur#:}" --sfx=":"
@@ -1746,7 +1757,11 @@ _git_log ()
 		return
 		;;
 	-L:*:*)
-		return	# fall back to Bash filename completion
+		local symbol="${cur#-L:}"
+		symbol="${symbol%%:*}"
+		__gitcomp_nl "$(__git_filename_for_symbol "$symbol" tags)" \
+			"" "${cur#-L:$symbol:}"
+		return
 		;;
 	-L:*)
 		__git_complete_symbol --cur="${cur#-L:}" --sfx=":"
-- 
2.12.2.453.g223d29900

