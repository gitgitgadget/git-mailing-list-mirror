From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: fix -f description to match actual git behavior.
Date: Fri, 15 Aug 2014 15:52:02 +0400
Message-ID: <87d2c22cnx.fsf@osv.gnss.ru>
References: <87bnrq22uf.fsf@osv.gnss.ru>
	<xmqq4mxh5w34.fsf@gitster.dls.corp.google.com>
	<xmqqzjf94f5n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 13:58:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIG9Y-0000L5-EF
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 13:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbaHOL6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 07:58:21 -0400
Received: from mail.javad.com ([54.86.164.124]:42594 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbaHOL6L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 07:58:11 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Aug 2014 07:58:11 EDT
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 2C6956185F;
	Fri, 15 Aug 2014 11:52:04 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XIG38-00064z-9D; Fri, 15 Aug 2014 15:52:02 +0400
In-Reply-To: <xmqqzjf94f5n.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Aug 2014 13:38:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255284>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> So I think the reasoning (i.e. "is a descendant" is not quite right)
>> is correct, but the updated text is not quite right.  Changing it
>> further to "only the committer timestamps and identities would
>> change" is probably not an improvement, either.  "Force the rebase
>> that would otherwise be a no-op" may be a better phrasing that does
>> not risk going stale even if we update what are preserved and what
>> are modified in the future.
>>
>> Also I notice the sentence "Normally non-interactive...in such a
>> situation" is not helping the reader in this description very much.
>> I wonder if we should keep it if we are rewriting this paragraph.
>
> How about doing it this way, perhaps?
>
> -- >8 --
> From: Sergey Organov <sorganov@gmail.com>
> Date: Tue, 12 Aug 2014 00:22:48 +0400
> Subject: [PATCH] Documentation/git-rebase.txt: -f forces a rebase that would otherwise be a no-op
>
> "Current branch is a descendant of the commit you are rebasing onto"
> does not necessarily mean "rebase" requires "--force".  For a plain
> vanilla "history flattening" rebase, the rebase can be done without
> forcing if there is a merge between the tip of the branch being
> rebased and the commit you are rebasing onto, even if the tip is
> descendant of the other.
>
> [jc: reworded both the text and the log description]
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-rebase.txt | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 2a93c64..f14100a 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -316,11 +316,8 @@ which makes little sense.
>  
>  -f::
>  --force-rebase::
> -	Force the rebase even if the current branch is a descendant
> -	of the commit you are rebasing onto.  Normally non-interactive rebase will
> -	exit with the message "Current branch is up to date" in such a
> -	situation.
> -	Incompatible with the --interactive option.
> +	Force a rebase even if the current branch is up-to-date and
> +	the command without `--force` would return without doing anything.
>  +
>  You may find this (or --no-ff with an interactive rebase) helpful after
>  reverting a topic branch merge, as this option recreates the topic branch with


Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> So I think the reasoning (i.e. "is a descendant" is not quite right)
>> is correct, but the updated text is not quite right.  Changing it
>> further to "only the committer timestamps and identities would
>> change" is probably not an improvement, either.  "Force the rebase
>> that would otherwise be a no-op" may be a better phrasing that does
>> not risk going stale even if we update what are preserved and what
>> are modified in the future.
>>
>> Also I notice the sentence "Normally non-interactive...in such a
>> situation" is not helping the reader in this description very much.
>> I wonder if we should keep it if we are rewriting this paragraph.
>
> How about doing it this way, perhaps?
>
> -- >8 --
> From: Sergey Organov <sorganov@gmail.com>
> Date: Tue, 12 Aug 2014 00:22:48 +0400
> Subject: [PATCH] Documentation/git-rebase.txt: -f forces a rebase that would otherwise be a no-op
>
> "Current branch is a descendant of the commit you are rebasing onto"
> does not necessarily mean "rebase" requires "--force".  For a plain
> vanilla "history flattening" rebase, the rebase can be done without
> forcing if there is a merge between the tip of the branch being
> rebased and the commit you are rebasing onto, even if the tip is
> descendant of the other.
>
> [jc: reworded both the text and the log description]
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-rebase.txt | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 2a93c64..f14100a 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -316,11 +316,8 @@ which makes little sense.
>  
>  -f::
>  --force-rebase::
> -	Force the rebase even if the current branch is a descendant
> -	of the commit you are rebasing onto.  Normally non-interactive rebase will
> -	exit with the message "Current branch is up to date" in such a
> -	situation.
> -	Incompatible with the --interactive option.
> +	Force a rebase even if the current branch is up-to-date and
> +	the command without `--force` would return without doing anything.
>  +
>  You may find this (or --no-ff with an interactive rebase) helpful after
>  reverting a topic branch merge, as this option recreates the topic branch with

I dig more into it, and that's what I came up with, using some of your
suggestions as well.

Please notice new text on essential interaction with --preserve-merges.

I also thought about "Force the rebase that would otherwise be a no-op",
and while it is future-changes-agnostic indeed, it doesn't actually
explain anything, so I put some explanation back.

-- >8 --

From: Sergey Organov <sorganov@gmail.com>
Date: Tue, 12 Aug 2014 00:10:19 +0400
Subject: [PATCH] Documentation/git-rebase.txt: fix -f description to match

"Current branch is a descendant of the commit you are rebasing onto"
does not necessarily mean "rebase" requires "--force". Presence of
merge commit(s) makes "rebase" perform its default flattening actions
anyway.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-rebase.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 2a93c64..9153369 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -316,11 +316,10 @@ which makes little sense.
 
 -f::
 --force-rebase::
-	Force the rebase even if the current branch is a descendant
-	of the commit you are rebasing onto.  Normally non-interactive rebase will
-	exit with the message "Current branch is up to date" in such a
-	situation.
-	Incompatible with the --interactive option.
+	If --preserve-merges is given, has no effect. Otherwise forces
+	rebase even if the current branch is a descendant of the commit
+	you are rebasing onto and there are no merge commits among
+	those to be rebased.
 +
 You may find this (or --no-ff with an interactive rebase) helpful after
 reverting a topic branch merge, as this option recreates the topic branch with
-- 
1.9.3
