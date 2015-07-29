From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/5] refs: Introduce pseudoref and per-worktree ref concepts
Date: Wed, 29 Jul 2015 14:13:47 -0700
Message-ID: <xmqq1tfq8y5w.fsf@gitster.dls.corp.google.com>
References: <1438192688-8048-1-git-send-email-dturner@twopensource.com>
	<1438192688-8048-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 23:13:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKYfi-0004jH-Kc
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 23:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbbG2VNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 17:13:50 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33203 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbG2VNt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 17:13:49 -0400
Received: by padck2 with SMTP id ck2so11521018pad.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=FNbJ4q3s5CiwsHfRv1bBtUkOrjtRG5ZuJiXbSigG60M=;
        b=f+bntTi+JYZHcC99g7Yy++je88pBocqApIv7Z2Od/wAUJPBra3VU+paLO4wJ2q3xFQ
         ymE8O+SVvVjQ4OUrqX2Pbfa4sVH3kIHZWso6fL6d5r6PIiheGq12D3BKMe8pUxuq01xO
         u8M7Sv778ICKG0G3Y3Lu8wLk2UYC5YbGphcbf4/KVBoHRljbWAze+gIqhASVy9FnLpPq
         JXTtGmrLyF8MXNAopzYO+Fk4VBnqid+UZcTzqLTB3Qu2m6JgFk8GMvvmtmrEpeh0iWcZ
         ssf5HRprwtm8bJcZcPMfNJNQ3xs+2sn2vfjkjLVvlOmujpvYJGlIle1wIRaLL4mRagnc
         3osA==
X-Received: by 10.66.141.5 with SMTP id rk5mr99297827pab.16.1438204429153;
        Wed, 29 Jul 2015 14:13:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id a5sm3043158pdk.90.2015.07.29.14.13.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 14:13:47 -0700 (PDT)
In-Reply-To: <1438192688-8048-2-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 29 Jul 2015 13:58:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274953>

David Turner <dturner@twopensource.com> writes:

> Add glossary entries for both concepts.
>
> Pseudorefs and per-worktree refs do not yet have special handling,
> because the files refs backend already handles them correctly.  Later,
> we will make the LMDB backend call out to the files backend to handle
> per-worktree refs.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

Will do s/refs: I/refs: i/; on the subject, and squash the following
in to make the doc-toolchain happy (they are reported as missing
link targets), before pushing the results out on 'pu'.

Thanks.


 Documentation/glossary-content.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index ff14079..edae9f5 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -412,7 +412,7 @@ exclude;;
 	interface than the <<def_plumbing,plumbing>>.
 
 [[def_per_worktree_ref]]per-worktree ref::
-	Refs that are per-<<def_worktree,worktree>>, rather than
+	Refs that are per-<<def_working_tree,worktree>>, rather than
 	global.  This is presently only <<def_HEAD,HEAD>>, but might
 	later include other unusual refs.
 
@@ -421,7 +421,7 @@ exclude;;
 	like refs for the purposes of rev-parse, but which are treated
 	specially by git.  Psuedorefs both have names that are all-caps,
 	and always start with a line consisting of a
-	<<def_sha1,SHA-1>> followed by whitespace.  So, HEAD is not a
+	<<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
 	pseudoref, because it is sometimes a symbolic ref.  They might
 	optionally contain some additional data.  `MERGE_HEAD` and
 	`CHERRY_PICK_HEAD` are examples.  Unlike
