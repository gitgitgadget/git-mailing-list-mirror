From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: support --tool-help option like difftool does
Date: Mon, 23 Jul 2012 14:16:12 -0700
Message-ID: <7vmx2qji03.fsf@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFAE1.3070304@gmail.com> <7vr4s2mnir.fsf@alter.siamese.dyndns.org>
 <7vipdemm0a.fsf_-_@alter.siamese.dyndns.org> <500D9E5A.2000204@gmail.com>
 <500D9EDB.90603@gmail.com> <7vhasyl0gc.fsf@alter.siamese.dyndns.org>
 <CAHGBnuMCsxmVN8fCSgazqKUwtJzJJxtrVxjKwCEEhZJ_U0cW9w@mail.gmail.com>
 <CAJDDKr4TyDp5vxqqHGkBBSiMJXJHW528+nqrag9Rgz+vksqjhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	Tim Henigan <tim.henigan@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:16:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StPzN-0006gW-0U
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 23:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014Ab2GWVQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 17:16:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754981Ab2GWVQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 17:16:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D6C780D1;
	Mon, 23 Jul 2012 17:16:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1tNe7TnVNPo5/g+iWlo6vVflhOo=; b=HAqszA
	MaiNNEuxJWxnNVUf7dLLB4lR97WIvp4nQPigczPFS/ZONlZctE//fNXuh2R2GrQg
	Na/EdkHC/hAn0xQ6HbIw/UvWgz5ely8Z0lVsk1qAyrE0Z3zklv7GsFfBOJ4suV+8
	PAiYsWmkJzCDJJxFfZSaIneVOHpCnpRBnzDBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WACQpwNmR9an01r3WddA6KJ7a5jRYZo5
	osCi7iDQ3Dxuh8QciV9A5f1l1xFc5vJnM9OHU7Pe4djSBL+ghO2/lsiFQ6qKOz/V
	crWzfP2mGqban9qJZTi3ykWtFNi8ldxDbE9cbuoo2AtSGOVV1rys7hpRrd4JkaDE
	E32ShnesIog=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF36D80D0;
	Mon, 23 Jul 2012 17:16:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B2F080CD; Mon, 23 Jul 2012
 17:16:13 -0400 (EDT)
In-Reply-To: <CAJDDKr4TyDp5vxqqHGkBBSiMJXJHW528+nqrag9Rgz+vksqjhg@mail.gmail.com> (David
 Aguilar's message of "Mon, 23 Jul 2012 13:44:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A23499F8-D50B-11E1-8921-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201985>

David Aguilar <davvid@gmail.com> writes:

> On Mon, Jul 23, 2012 at 1:14 PM, Sebastian Schuberth
> <sschuberth@gmail.com> wrote:
>> On Mon, Jul 23, 2012 at 9:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>>>  -t <tool>::
>>>>  --tool=<tool>::
>>>> -     Use the diff tool specified by <tool>.  Valid values include
>>>> -     emerge, kompare, meld, and vimdiff. Run `git difftool --tool-help`
>>>> -     for the list of valid <tool> settings.
>>>> +     Use the diff tool specified by <tool>.
>>>
>>> I do not see how it is an improvement to drop the most common ones.
>>> People sometimes read documentation without having an access to
>>> shell to run "cmd --tool-help", and a list of handful of well known
>>> ones would serve as a good hint to let the reader know the kind of
>>> commands the front-end is capable of spawning, which in turn help
>>> such a reader to imagine how the command is used to judge if it is
>>> something the reader wants to use.
>>
>> I don't agree. What "most common ones" are depends on your platform
>> and is sort of subjective. So it should be either all or non here.
>
> Let's please leave this section as-is.

Yes.  

There are only five or six classes of environment that matter in the
real world for the purpose of giving "well known" examples: Windows,
MacOS X, Gnome, KDE and Linux terminal.  By picking a representative
one from each and listing them, the end result would have at least
one that people from various platforms have _heard of_ and can guess
what they do.  The "most common" is secondary, and "well known" is
the keyword.  "Can guess what they do" is the point of the phrase
"Valid values _include_".  Even if you are hard-core Emacs user, it
is likely that you've heard of vimdiff---and in that case, including
vimdiff would be enough.  Likewise for showing kompare to Gnome users.

Unlike POSIXy folks, where IRIX or Solaris users are likely to have
heard of Gnome tools even if they do not use the environment on
their platforms, Windows users tend to be isolated bunch, so it
would not hurt to include at least one well-known Windows-only tool
in the list.

> Yes, indeed, it is arbitrary.  It does have some merit, though--it is
> also a good compromise between unhelpful (listing nothing) and painful
> to maintain (listing everything).

Here is a v2, with documentation updates.

-- >8 --
Subject: [PATCH] mergetool: support --tool-help option like difftool does

This way we do not have to risk the list of tools going out of sync
between the implementation and the documentation.

In the same spirit as bf73fc2 (difftool: print list of valid tools
with '--tool-help', 2012-03-29), trim the list of merge backends in
the documentation.  We do not want to have a complete of valid tools
there; we only want a list to help people guess what kind of things
the tools that can be specified there, and refer them to --tool-help
for a complete list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-mergetool.txt |  6 +++---
 git-mergetool--lib.sh           |  6 +++++-
 git-mergetool.sh                | 42 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 2a49de7..d1e08d2 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -27,9 +27,9 @@ OPTIONS
 -t <tool>::
 --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
-	Valid merge tools are:
-	araxis, bc3, diffuse, ecmerge, emerge, gvimdiff, kdiff3,
-	meld, opendiff, p4merge, tkdiff, tortoisemerge, vimdiff and xxdiff.
+	Valid values include emerge, gvimdiff, kdiff3,
+	meld, vimdiff, and tortoisemerge. Run `git mergetool --tool-help`
+	for the list of valid <tool> settings.
 +
 If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index ed630b2..f730253 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -111,7 +111,7 @@ run_merge_tool () {
 	return $status
 }
 
-guess_merge_tool () {
+list_merge_tool_candidates () {
 	if merge_mode
 	then
 		tools="tortoisemerge"
@@ -136,6 +136,10 @@ guess_merge_tool () {
 		tools="$tools emerge vimdiff"
 		;;
 	esac
+}
+
+guess_merge_tool () {
+	list_merge_tool_candidates
 	echo >&2 "merge tool candidates: $tools"
 
 	# Loop over each candidate and stop when a valid merge tool is found.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index a9f23f7..0db0c44 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -8,7 +8,7 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [-y|--no-prompt|--prompt] [file to merge] ...'
+USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 TOOL_MODE=merge
@@ -284,11 +284,51 @@ merge_file () {
     return 0
 }
 
+show_tool_help () {
+	TOOL_MODE=merge
+	list_merge_tool_candidates
+	unavailable= available= LF='
+'
+	for i in $tools
+	do
+		merge_tool_path=$(translate_merge_tool_path "$i")
+		if type "$merge_tool_path" >/dev/null 2>&1
+		then
+			available="$available$i$LF"
+		else
+			unavailable="$unavailable$i$LF"
+		fi
+	done
+	if test -n "$available"
+	then
+		echo "'git mergetool --tool=<tool>' may be set to one of the following:"
+		echo "$available" | sort | sed -e 's/^/	/'
+	else
+		echo "No suitable tool for 'git mergetool --tool=<tool>' found."
+	fi
+	if test -n "$unavailable"
+	then
+		echo
+		echo 'The following tools are valid, but not currently available:'
+		echo "$unavailable" | sort | sed -e 's/^/	/'
+	fi
+	if test -n "$unavailable$available"
+	then
+		echo
+		echo "Some of the tools listed above only work in a windowed"
+		echo "environment. If run in a terminal-only session, they will fail."
+	fi
+	exit 0
+}
+
 prompt=$(git config --bool mergetool.prompt || echo true)
 
 while test $# != 0
 do
     case "$1" in
+	--tool-help)
+		show_tool_help
+		;;
 	-t|--tool*)
 	    case "$#,$1" in
 		*,*=*)
-- 
1.7.11.3.339.gbdbf398
