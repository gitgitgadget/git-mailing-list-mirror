From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] git-blame: Add Emacs Lisp file headers and GNU GPL boilerplate
Date: Wed, 7 Feb 2007 13:56:42 +0100
Message-ID: <200702071356.43020.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 13:57:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEmM7-0005hD-RW
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 13:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161288AbXBGM44 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Feb 2007 07:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161292AbXBGM44
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 07:56:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:53350 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161288AbXBGM4z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 07:56:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so173048uga
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 04:56:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Vt6lCeZsyYjcIAIme+GfDhg0CFJs7j/DOCN3xvOGr5E3oE6FPL5sIuDGZ5Ve6PvbAMFamttUpjf4EbyFcvZ8GgplZ2uDDTsQcQVq3st9K7CtClId3hSX0Hzdm4qkH92XXJp+UXRl27CM9UH5wwcx6Ra7VVO8pzBQYXg3YjOc8nk=
Received: by 10.82.175.2 with SMTP id x2mr6402672bue.1170853008686;
        Wed, 07 Feb 2007 04:56:48 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id 59sm1170449ugf.2007.02.07.04.56.47;
        Wed, 07 Feb 2007 04:56:48 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38920>

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
David K=C3=A5gedal agreed on GPLv2 or later for git-blame.el
in Message-ID: <87veifzkyg.fsf@morpheus.local>

If you have better idea for git-blame.el description, feel
free to correct it.

 contrib/emacs/git-blame.el |   73 ++++++++++++++++++++++++++++++++++++=
++++++--
 1 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 62cf24c..cca0a77 100644
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
+(require 'cl)			      ; to use `cddddr', `push', `pop'
=20
-(require 'cl)
 (defun color-scale (l)
   (let* ((colors ())
          r g b)
@@ -178,3 +243,5 @@
   (shell-command
    (format "git log -1 --pretty=3Doneline %s" (or hash
                                                 (git-blame-current-com=
mit)))))
+
+;;; git-blame.el ends here
--=20
1.4.4.4
