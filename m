From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/7] Documentation/config.txt: describe 'color' value type in the "Values" section
Date: Wed,  4 Mar 2015 13:33:21 -0800
Message-ID: <1425504803-16039-6-git-send-email-gitster@pobox.com>
References: <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
 <1425504803-16039-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 22:33:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGvQ-0007NC-V4
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 22:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbbCDVdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 16:33:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753078AbbCDVdq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 16:33:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1E773C79D;
	Wed,  4 Mar 2015 16:33:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FP8F
	lJDQ8W/wAl5NXVSMssN27Lg=; b=BefhOI51WVNWKfIGiu5rFk5fxaZDR8U/ijms
	fMZ4wQh3DUDXAWKFc1cBtlQIxqxpcew2HnFXvNgBr4JfCFX0ybGmEcckBjWLoO8I
	8zfNYr0SPD7ULLF4cCY/xRYNGtJVRBCAgFTGTHWceyRCXRTVrQoB951ozO+ex0nF
	ueEcGNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ZqCgYU
	Lvgkct7PFN8Xurn1eNsvcY/iHvdfpm32aSQbaSR8Znxugkatiy1n0+WU2LzBZFb6
	zsH2DRdKnWRo1C58O7bPq8oQYDJhr1FKBOg+NnadMPqatlcplHa4WogoyrIw3ANg
	quKTQg+CPCZWlKlgwRGS9E3LKdz9fPcWviYTc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA8793C798;
	Wed,  4 Mar 2015 16:33:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 388363C787;
	Wed,  4 Mar 2015 16:33:40 -0500 (EST)
X-Mailer: git-send-email 2.3.1-318-g5233f23
In-Reply-To: <1425504803-16039-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1FDE0390-C2B6-11E4-BC51-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264783>

Instead of describing it for color.branch.<slot> and have everybody
else refer to it, explain how colors are spelled in "Values" section
upfront.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7be608b..c40bf4a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -146,6 +146,16 @@ integer::
        be suffixed with `k`, `M`,... to mean "scale the number by
        1024", "by 1024x1024", etc.
 
+color::
+       The value for a variables that takes a color is a list of
+       colors (at most two) and attributes (at most one), separated
+       by spaces.  The colors accepted are `normal`, `black`,
+       `red`, `green`, `yellow`, `blue`, `magenta`, `cyan` and
+       `white`; the attributes are `bold`, `dim`, `ul`, `blink` and
+       `reverse`.  The first color given is the foreground; the
+       second is the background.  The position of the attribute, if
+       any, doesn't matter.
+
 
 Variables
 ~~~~~~~~~
@@ -838,14 +848,6 @@ color.branch.<slot>::
 	`remote` (a remote-tracking branch in refs/remotes/),
 	`upstream` (upstream tracking branch), `plain` (other
 	refs).
-+
-The value for these configuration variables is a list of colors (at most
-two) and attributes (at most one), separated by spaces.  The colors
-accepted are `normal`, `black`, `red`, `green`, `yellow`, `blue`,
-`magenta`, `cyan` and `white`; the attributes are `bold`, `dim`, `ul`,
-`blink` and `reverse`.  The first color given is the foreground; the
-second is the background.  The position of the attribute, if any,
-doesn't matter.
 
 color.diff::
 	Whether to use ANSI escape sequences to add color to patches.
@@ -865,8 +867,7 @@ color.diff.<slot>::
 	of `plain` (context text), `meta` (metainformation), `frag`
 	(hunk header), 'func' (function in hunk header), `old` (removed lines),
 	`new` (added lines), `commit` (commit headers), or `whitespace`
-	(highlighting whitespace errors). The values of these variables may be
-	specified as in color.branch.<slot>.
+	(highlighting whitespace errors).
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
@@ -899,8 +900,6 @@ color.grep.<slot>::
 	separators between fields on a line (`:`, `-`, and `=`)
 	and between hunks (`--`)
 --
-+
-The values of these variables may be specified as in color.branch.<slot>.
 
 color.interactive::
 	When set to `always`, always use colors for interactive prompts
@@ -913,8 +912,7 @@ color.interactive.<slot>::
 	Use customized color for 'git add --interactive' and 'git clean
 	--interactive' output. `<slot>` may be `prompt`, `header`, `help`
 	or `error`, for four distinct types of normal output from
-	interactive commands.  The values of these variables may be
-	specified as in color.branch.<slot>.
+	interactive commands.
 
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
@@ -940,8 +938,7 @@ color.status.<slot>::
 	`untracked` (files which are not tracked by Git),
 	`branch` (the current branch), or
 	`nobranch` (the color the 'no branch' warning is shown in, defaulting
-	to red). The values of these variables may be specified as in
-	color.branch.<slot>.
+	to red).
 
 color.ui::
 	This variable determines the default value for variables such
-- 
2.3.1-316-g7c93423
