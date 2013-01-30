From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] mergetool--lib: Add functions for finding
 available tools
Date: Tue, 29 Jan 2013 19:08:56 -0800
Message-ID: <7vwquvmkon.fsf@alter.siamese.dyndns.org>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
 <1359334346-5879-3-git-send-email-davvid@gmail.com>
 <1359334346-5879-4-git-send-email-davvid@gmail.com>
 <20130129194846.GD1342@serenity.lan>
 <7vr4l3oi1z.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4e=pg=YJ4CfUk7guUCcikBtXTveVX9j6CV5NtGvPB=9Q@mail.gmail.com>
 <7va9rroazl.fsf@alter.siamese.dyndns.org>
 <20130129230607.GG1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 30 04:09:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0O3E-0000UA-QL
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 04:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab3A3DJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 22:09:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626Ab3A3DI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 22:08:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A9A7B761;
	Tue, 29 Jan 2013 22:08:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QUDdSGLX7trfIxcHZqXutQQ0uiY=; b=CH2HeJ
	+lwmIQKNZMYjafYqLckyPod7CXf4axC059pY8k96yK+g5u55uN4lY7evkcC77gIN
	T2asGY8AEtSDBGq8QRzJMJmyHwv0d2ZdQrVzmmZFYelGLNXE8EYJBKfEQeCSMcT4
	epfR4fCuHIIaHzKsddm8tID+RiMZlEYNtPs5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FgRH7UNMnCVE0eBlKTNVxHYFu3cmQUhk
	5FBvweTTGX7x1+BFcBOjlRiqH7RNDbc8g25+/3RMsNYR+b7impXWfONZ1JqWjRdt
	9aT2TRjeoLuKkVcElxy3H8NTN6mKRlyGgK9N+mZte01u6SAiDbbBsBd4ohwgwObk
	soJS0Wp5/vU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F40B4B760;
	Tue, 29 Jan 2013 22:08:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20A50B75D; Tue, 29 Jan 2013
 22:08:58 -0500 (EST)
In-Reply-To: <20130129230607.GG1342@serenity.lan> (John Keeping's message of
 "Tue, 29 Jan 2013 23:06:08 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 637891E6-6A8A-11E2-B2C1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214988>

John Keeping <john@keeping.me.uk> writes:

> On Tue, Jan 29, 2013 at 02:55:26PM -0800, Junio C Hamano wrote:
> ...
>> I can work with John to get this part into a shape to support his
>> extended use sometime toward the end of this week, by which time
>> hopefully you have some time to comment on the result.  John, how
>> does that sound?
>
> My email crossed with yours - that sounds good to me.  If
> da/mergetool-docs is in a reasonable state by tomorrow evening (GMT) I
> should be able to have a look at it then - if not I'm happy to hold off
> longer.

Heh, I actually was hoping that you will send in a replacement for
David's patch ;-)

Here is what I will squash into the one we have been discussing.  In
a few hours, I expect I'll be able to push this out in the 'pu'
branch.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 29 Jan 2013 18:57:55 -0800
Subject: [PATCH] [SQUASH] mergetools: tweak show_tool_names and its users

Use show_tool_names as a function to produce output, not as a
function to compute a string.  Indicate if any output was given
with its return status, so that the caller can say "if it didn't
give any output, I'll say this instead" easily.

To be squashed into the previous; no need to keep this log message.
---
 git-mergetool--lib.sh | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 135da96..79cbdc7 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -22,7 +22,7 @@ is_available () {
 show_tool_names () {
 	condition=${1:-true} per_line_prefix=${2:-} preamble=${3:-}
 
-	( cd "$MERGE_TOOLS_DIR" && ls -1 * ) |
+	( cd "$MERGE_TOOLS_DIR" && ls ) |
 	while read toolname
 	do
 		if setup_tool "$toolname" 2>/dev/null &&
@@ -36,6 +36,7 @@ show_tool_names () {
 			printf "%s%s\n" "$per_line_prefix" "$tool"
 		fi
 	done
+	test -n "$preamble"
 }
 
 diff_mode() {
@@ -236,27 +237,30 @@ list_merge_tool_candidates () {
 
 show_tool_help () {
 	tool_opt="'git ${TOOL_MODE}tool --tool-<tool>'"
-	available=$(show_tool_names 'mode_ok && is_available' '\t\t' \
-		"$tool_opt may be set to one of the following:")
-	unavailable=$(show_tool_names 'mode_ok && ! is_available' '\t\t' \
-		"The following tools are valid, but not currently available:")
-	if test -n "$available"
+
+	tab='	' av_shown= unav_shown=
+
+	if show_tool_names 'mode_ok && is_available' "$tab$tab" \
+		"$tool_opt may be set to one of the following:"
 	then
-		echo "$available"
+		av_shown=yes
 	else
 		echo "No suitable tool for 'git $cmd_name --tool=<tool>' found."
+		av_shown=no
 	fi
-	if test -n "$unavailable"
+
+	if show_tool_names 'mode_ok && ! is_available' "$tab$tab" \
+		"The following tools are valid, but not currently available:"
 	then
-		echo
-		echo "$unavailable"
+		unav_shown=yes
 	fi
-	if test -n "$unavailable$available"
-	then
+
+	case ",$av_shown,$unav_shown," in
+	*,yes,*)
 		echo
 		echo "Some of the tools listed above only work in a windowed"
 		echo "environment. If run in a terminal-only session, they will fail."
-	fi
+	esac
 	exit 0
 }
 
-- 
1.8.1.2.555.gedafe79
