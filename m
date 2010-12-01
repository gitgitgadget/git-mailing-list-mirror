From: jari.aalto@cante.net
Subject: [PATCH] git-config.txt: Order options alphabetically
Date: Wed,  1 Dec 2010 22:15:47 +0200
Organization: Private
Message-ID: <1291234547-21201-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 21:16:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNt5q-0001qQ-4t
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab0LAUPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:15:53 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:45530 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642Ab0LAUPw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:15:52 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 513DB18CF00
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:15:51 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A03D7B4E25B; Wed, 01 Dec 2010 22:15:51 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 3891327D82
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:15:49 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNt5f-0005WN-48; Wed, 01 Dec 2010 22:15:47 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162599>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-config.txt |  121 +++++++++++++++++++++---------------=
------
 1 files changed, 60 insertions(+), 61 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 543dd64..baeeebc 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -64,15 +64,27 @@ This command will fail if:
 OPTIONS
 -------
=20
---replace-all::
-	Default behavior is to replace at most one line. This replaces
-	all lines matching the key (and optionally the value_regex).
-
 --add::
 	Adds a new line to the option without altering any existing
 	values.  This is the same as providing '^$' as the value_regex
 	in `--replace-all`.
=20
+-e::
+--edit::
+	Opens an editor to modify the specified config file; either
+	'--system', '--global', or repository (default).
+
+--bool::
+	'git config' will ensure that the output is "true" or "false"
+
+--bool-or-int::
+	'git config' will ensure that the output matches the format of
+	either --bool or --int, as described above.
+
+-f config-file::
+--file config-file::
+	Use the given config file instead of the one specified by GIT_CONFIG.
+
 --get::
 	Get the value for a given key (optionally filtered by a regex
 	matching the value). Returns error code 1 if the key was not
@@ -82,6 +94,23 @@ OPTIONS
 	Like get, but does not fail if the number of values for the key
 	is not exactly one.
=20
+--get-color name [default]::
+
+	Find the color configured for `name` (e.g. `color.diff.new`) and
+	output it as the ANSI color escape sequence to the standard
+	output.  The optional `default` parameter is used instead, if
+	there is no color configured for `name`.
+
+--get-colorbool name [stdout-is-tty]::
+	Find the color setting for `name` (e.g. `color.diff`) and output
+	"true" or "false".  `stdout-is-tty` should be either "true" or
+	"false", and is taken into account when configuration says
+	"auto".  If `stdout-is-tty` is missing, then checks the standard
+	output of the command itself, and exits with status 0 if color
+	is to be used, or exits with status 1 otherwise.
+	When the color setting for `name` is undefined, the command uses
+	`color.ui` as fallback.
+
 --get-regexp::
 	Like --get-all, but interprets the name as a regular expression.
 	Also outputs the key names.
@@ -95,6 +124,33 @@ from all available files.
 +
 See also <<FILES>>.
=20
+--int::
+	'git config' will ensure that the output is a simple
+	decimal number.  An optional value suffix of 'k', 'm', or 'g'
+	in the config file will cause the value to be multiplied
+	by 1024, 1048576, or 1073741824 prior to output.
+
+-l::
+--list::
+	List all variables set in config file.
+
+--path::
+	'git-config' will expand leading '{tilde}' to the value of
+	'$HOME', and '{tilde}user' to the home directory for the
+	specified user.  This option has no effect when setting the
+	value (but you can use 'git config bla {tilde}/' from the
+	command line to let your shell do the expansion).
+
+--remove-section::
+	Remove the given section from the configuration file.
+
+--rename-section::
+	Rename the given section to a new name.
+
+--replace-all::
+	Default behavior is to replace at most one line. This replaces
+	all lines matching the key (and optionally the value_regex).
+
 --system::
 	For writing options: write to system-wide $(prefix)/etc/gitconfig
 	rather than the repository .git/config.
@@ -104,46 +160,12 @@ rather than from all available files.
 +
 See also <<FILES>>.
=20
--f config-file::
---file config-file::
-	Use the given config file instead of the one specified by GIT_CONFIG.
-
---remove-section::
-	Remove the given section from the configuration file.
-
---rename-section::
-	Rename the given section to a new name.
-
 --unset::
 	Remove the line matching the key from config file.
=20
 --unset-all::
 	Remove all lines matching the key from config file.
=20
--l::
---list::
-	List all variables set in config file.
-
---bool::
-	'git config' will ensure that the output is "true" or "false"
-
---int::
-	'git config' will ensure that the output is a simple
-	decimal number.  An optional value suffix of 'k', 'm', or 'g'
-	in the config file will cause the value to be multiplied
-	by 1024, 1048576, or 1073741824 prior to output.
-
---bool-or-int::
-	'git config' will ensure that the output matches the format of
-	either --bool or --int, as described above.
-
---path::
-	'git-config' will expand leading '{tilde}' to the value of
-	'$HOME', and '{tilde}user' to the home directory for the
-	specified user.  This option has no effect when setting the
-	value (but you can use 'git config bla {tilde}/' from the
-	command line to let your shell do the expansion).
-
 -z::
 --null::
 	For all options that output values and/or keys, always
@@ -153,29 +175,6 @@ See also <<FILES>>.
 	output without getting confused e.g. by values that
 	contain line breaks.
=20
---get-colorbool name [stdout-is-tty]::
-
-	Find the color setting for `name` (e.g. `color.diff`) and output
-	"true" or "false".  `stdout-is-tty` should be either "true" or
-	"false", and is taken into account when configuration says
-	"auto".  If `stdout-is-tty` is missing, then checks the standard
-	output of the command itself, and exits with status 0 if color
-	is to be used, or exits with status 1 otherwise.
-	When the color setting for `name` is undefined, the command uses
-	`color.ui` as fallback.
-
---get-color name [default]::
-
-	Find the color configured for `name` (e.g. `color.diff.new`) and
-	output it as the ANSI color escape sequence to the standard
-	output.  The optional `default` parameter is used instead, if
-	there is no color configured for `name`.
-
--e::
---edit::
-	Opens an editor to modify the specified config file; either
-	'--system', '--global', or repository (default).
-
 [[FILES]]
 FILES
 -----
--=20
1.7.2.3
