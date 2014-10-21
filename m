From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Copy mergetool "bc3" as "bc4"
Date: Tue, 21 Oct 2014 11:27:53 -0700
Message-ID: <xmqqsiihz39y.fsf@gitster.dls.corp.google.com>
References: <1413803017-30489-1-git-send-email-ocroquette@free.fr>
	<xmqq7fzu4rve.fsf@gitster.dls.corp.google.com>
	<xmqqtx2y3avx.fsf@gitster.dls.corp.google.com>
	<54455334.8000503@gmail.com>
	<xmqqfvei37qg.fsf@gitster.dls.corp.google.com>
	<20141021084436.GA39148@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Olivier Croquette <ocroquette@free.fr>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 20:28:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgeAB-0008T7-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 20:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbaJUS2C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 14:28:02 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754048AbaJUS2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 14:28:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC83A15478;
	Tue, 21 Oct 2014 14:27:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JzDFZKXr4kaw5FFsgeRg4zTWnRI=; b=GvG5ou
	T6HxWB5kPvqf/CrLoUwyNGJ6oQTuIXfbraqxFhy9QYKbsPzkgwnQNoJ3KTTWRqGB
	oE425OOE3fVVXEEb2cdTC7FXRknfv3Q4jNzTomH1pNY6G2jM7xa9QLqDC4mrHkTL
	iS7rKXUApblw0YdkkuXrbhKy1395DXRRvoq/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eWWauyCdHFwatvht/X6WnauZN3GKlhFS
	yRwNehzqIZ3Anbo0HchJ/XebfDgHi81wDM24EnGh0vY/jEAU/3Gw87yXolaCirDI
	Bwzjs/67oxb5Vv+++tO9i4L+On+S8SE6P3LFrxhAQL8UWVp3I3dIrVhqdZwqjgd/
	7gQ9eQyG35w=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E13FC15475;
	Tue, 21 Oct 2014 14:27:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4276815474;
	Tue, 21 Oct 2014 14:27:56 -0400 (EDT)
In-Reply-To: <20141021084436.GA39148@gmail.com> (David Aguilar's message of
	"Tue, 21 Oct 2014 01:44:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA3C75B0-594F-11E4-8A08-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Otherwise, this patch looks like the right way to go ~ it makes
> "bc" available and keeps compatibility for "bc3".

OK, thanks.  Here is what I'll queue.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 20 Oct 2014 15:49:36 -0700
Subject: [PATCH] mergetool: rename bc3 to bc

Beyond Compare version 4 works the same way as version 3, so rename
the existing "bc3" adaptor to just "bc", while keeping "bc3" as a
backward compatible wrapper.

Noticed-by: Olivier Croquette <ocroquette@free.fr>
Helped-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |  2 +-
 git-mergetool--lib.sh                  |  2 +-
 mergetools/bc                          | 25 +++++++++++++++++++++++++
 mergetools/bc3                         | 26 +-------------------------
 4 files changed, 28 insertions(+), 27 deletions(-)
 create mode 100644 mergetools/bc

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 06bf262..8a19b3e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1207,7 +1207,7 @@ _git_diff ()
 }
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3 codecompare
+			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc codecompare
 "
 
 _git_difftool ()
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index c45a020..a40d3df 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -250,7 +250,7 @@ list_merge_tool_candidates () {
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
 		tools="$tools gvimdiff diffuse diffmerge ecmerge"
-		tools="$tools p4merge araxis bc3 codecompare"
+		tools="$tools p4merge araxis bc codecompare"
 	fi
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
diff --git a/mergetools/bc b/mergetools/bc
new file mode 100644
index 0000000..b6319d2
--- /dev/null
+++ b/mergetools/bc
@@ -0,0 +1,25 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	if $base_present
+	then
+		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" \
+			-mergeoutput="$MERGED"
+	else
+		"$merge_tool_path" "$LOCAL" "$REMOTE" \
+			-mergeoutput="$MERGED"
+	fi
+	check_unchanged
+}
+
+translate_merge_tool_path() {
+	if type bcomp >/dev/null 2>/dev/null
+	then
+		echo bcomp
+	else
+		echo bcompare
+	fi
+}
diff --git a/mergetools/bc3 b/mergetools/bc3
index b6319d2..5d8dd48 100644
--- a/mergetools/bc3
+++ b/mergetools/bc3
@@ -1,25 +1 @@
-diff_cmd () {
-	"$merge_tool_path" "$LOCAL" "$REMOTE"
-}
-
-merge_cmd () {
-	touch "$BACKUP"
-	if $base_present
-	then
-		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" \
-			-mergeoutput="$MERGED"
-	else
-		"$merge_tool_path" "$LOCAL" "$REMOTE" \
-			-mergeoutput="$MERGED"
-	fi
-	check_unchanged
-}
-
-translate_merge_tool_path() {
-	if type bcomp >/dev/null 2>/dev/null
-	then
-		echo bcomp
-	else
-		echo bcompare
-	fi
-}
+. "$MERGE_TOOLS_DIR/bc"
-- 
2.1.2-583-g325e495
