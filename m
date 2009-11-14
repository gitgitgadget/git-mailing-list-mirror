From: Andreas Gruenbacher <agruen@suse.de>
Subject: GNU patch: new 2.6 release
Date: Sat, 14 Nov 2009 01:09:34 +0100
Organization: SUSE Labs
Message-ID: <200911140109.34202.agruen@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 01:07:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N96BI-0003Bh-0V
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 01:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086AbZKNAHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 19:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756918AbZKNAHn
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 19:07:43 -0500
Received: from cantor.suse.de ([195.135.220.2]:41258 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754632AbZKNAHm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 19:07:42 -0500
Received: from relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 21F036CB00
	for <git@vger.kernel.org>; Sat, 14 Nov 2009 01:07:48 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.1; i686; ; )
X-Length: 4206
X-UID: 566
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132852>

I am pleased to announce my first release of GNU patch,
available by anonymous FTP from:

  ftp://ftp.gnu.org/gnu/patch/

The last release dates back to June 2004 with version 2.5.9.  A new Savannah 
project has been created with the new code repository and the bug-patch 
mailing list archive at:

  http://savannah.gnu.org/projects/patch

A lot of changes have accumulated since version 2.5.9.  The following user 
visible changes have been made:

* A regression test suite has been added ("make check").

* A --merge option has been added which will merge a patch file into
  the original files similar to merge(1).  See the patch(1) manual page for
  documentation.

* Unless a file name has been specified on the command line, look only
  for file names in the patch until one has been found.  This prevents
  patch from tripping over garbage that isn't a patch.  When conforming
  to POSIX, this behavior is turned off and patch will ask for a
  file name when none is found.

* All reject files have file name headers now, which allows them to be used as
  regular patches.

* When a patch file modifies the same file more than once, patch makes
  sure it backs up the original version of the file rather than any
  intermediary versions.

* In the above situation, if there are rejects in more than one of those
  patches, they all go into the same reject file.

* When the file to be patched is specified on the command line, all patches
  are applied to that file. (Previously, the first patch was applied to the
  file specified on the command line, and the names of additional files to
  patch were taken from header lines in the patch file.)

* The -r option now works correctly even if there are rejects in more than
  one file.  Use the - argument to discard rejects.

* Rejected hunks come out in unified diff format if the input patch was of
  that format, otherwise in ordinary context diff form.  Use the
  --reject-format option to enforce either "context" or "unified" format.
  Timestamps and the "diff -p" (--show-c-function) output are preserved.
  Changed lines in context format reject files are correctly indicated
  with '!' markers as the format defines.  Added and removed lines are
  still marked with '+' and '-', respectively.

* The file permissions of reject files are no longer set to match the files
  they modify.  Instead, they retain the default permissions.  This is
  consistent with reject files produced with the -r option.

* The --binary option disables the heuristic for stripping CRs from
  line endings in patches.  This allows to preserve CRs even in mangled
  patches, or in patches generated on non-POSIX systems and without the
  --binary option.

* Backup files for non-existing files are now created with default
  permissions rather than with mode 0: backup files with mode 0 were
  causing problems with applications which do not expect unreadable
  files.

* The -B, -Y, and -z options (--prefix, --basename-prefix, --suffix) now
  imply the simple version control mode, and can be combined.

* Patch rejects more malformed normal format commands and checks for trailing
  garbage.  It now recognizes ed commands without addresses.

* Change the default value of PATCH_GET to 0.  (Previously, the default was 0
  under POSIXLY_CORRECT and negative otherwise; this is causing problems
  particularly with Perforce.)

* Handle missing timestamps better.


Please email bugs or suggestions to <bug-patch@gnu.org>.  (Check the Savannah 
project's bug tracker for a list of known issues.)


Thanks,
Andreas
