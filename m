From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH 1/7] git-blame: Add Emacs Lisp file headers and GNU GPL boilerplate
Date: Fri, 09 Feb 2007 09:19:28 +0100
Message-ID: <874ppvrbe7.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 09:19:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFQz0-0001n2-9T
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 09:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946209AbXBIITr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 9 Feb 2007 03:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946211AbXBIITr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 03:19:47 -0500
Received: from main.gmane.org ([80.91.229.2]:53219 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946209AbXBIITq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 03:19:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HFQyp-0004fI-I7
	for git@vger.kernel.org; Fri, 09 Feb 2007 09:19:39 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:19:39 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:19:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:RRswmRHqC2kLfEt8TjBjDjVjRQw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39159>

=46rom: Jakub Narebski <jnareb@gmail.com>

Add Emacs Lisp file headers, according to "Coding Conventions" chapter
in Emacs Lisp Reference Manual and Elisp Area Convetions for
EmacsWiki:
  http://www.emacswiki.org/cgi-bin/wiki/ElispAreaConventions
Those include: copyright notice, GNU GPL boilerplate, description and
instalation instructions as provided in email and in commit message
introducing git-blame.el, compatibility notes from another email by
David K=C3=A5gedal about what to change to use it in GNU Emacs 20, and
"git-blame ends here" to detect if file was truncated.  First line
includes setting file encoding via first line local variable values
(file variables).

Added comment to "(require 'cl)" to note why it is needed; "Coding
Conventions" advises to avoid require the `cl' package of Common Lisp
extensions at run time.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 contrib/emacs/git-blame.el |   75 ++++++++++++++++++++++++++++++++++++=
++++++--
 1 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 62cf24c..ba9d8a6 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -1,8 +1,73 @@
-;;; git-blame.el
-;; David K=C3=A5gedal <davidk@lysator.liu.se>
+;;; git-blame.el --- Minor mode for incremental blame for Git  -*- cod=
ing: utf-8 -*-
+;;
+;; Copyright (C) 2007  David K=C3=A5gedal
+;;
+;; Authors:    David K=C3=A5gedal <davidk@lysator.liu.se>
+;; Created:    31 Jan 2007
 ;; Message-ID: <87iren2vqx.fsf@morpheus.local>
+;; License:    GPL
+;; Keywords:   git, version control, release management
+;;
+;; Compatibility: Emacs21
+
+
+;; This file is *NOT* part of GNU Emacs.
+;; This file is distributed under the same terms as GNU Emacs.
+
+;; This program is free software; you can redistribute it and/or
+;; modify it under the terms of the GNU General Public License as
+;; published by the Free Software Foundation; either version 2 of
+;; the License, or (at your option) any later version.
+
+;; This program is distributed in the hope that it will be
+;; useful, but WITHOUT ANY WARRANTY; without even the implied
+;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+;; PURPOSE.  See the GNU General Public License for more details.
+
+;; You should have received a copy of the GNU General Public
+;; License along with this program; if not, write to the Free
+;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+;; MA 02111-1307 USA
+
+;; http://www.fsf.org/copyleft/gpl.html
+
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+;;
+;;; Commentary:
+;;
+;; Here is an Emacs implementation of incremental git-blame.  When you
+;; turn it on while viewing a file, the editor buffer will be updated =
by
+;; setting the background of individual lines to a color that reflects
+;; which commit it comes from.  And when you move around the buffer, a
+;; one-line summary will be shown in the echo area.
+
+;;; Installation:
+;;
+;;  1) Load into emacs: M-x load-file RET git-blame.el RET
+;;  2) Open a git-controlled file
+;;  3) Blame: M-x git-blame-mode
+
+;;; Compatibility:
+;;
+;; It requires GNU Emacs 21.  If you'are using Emacs 20, try
+;; changing this:
+;;
+;;            (overlay-put ovl 'face (list :background
+;;                                         (cdr (assq 'color (cddddr i=
nfo)))))
+;;
+;; to
+;;
+;;            (overlay-put ovl 'face (cons 'background-color
+;;                                         (cdr (assq 'color (cddddr i=
nfo)))))
+
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+;;
+;;; Code:
+
+(require 'cl)			      ; to use `push', `pop'
=20
-(require 'cl)
 (defun color-scale (l)
   (let* ((colors ())
          r g b)
@@ -178,3 +243,7 @@
   (shell-command
    (format "git log -1 --pretty=3Doneline %s" (or hash
                                                 (git-blame-current-com=
mit)))))
+
+(provide 'git-blame)
+
+;;; git-blame.el ends here
--=20
1.5.0.rc3.204.g93c76


--=20
David K=C3=A5gedal
