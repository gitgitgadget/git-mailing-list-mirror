From: Remi Vanicat <vanicat@debian.org>
Subject: Re: [PATCH] git.el: find the git-status buffer whatever its name is
Date: Thu, 28 Feb 2008 13:58:40 +0100
Message-ID: <87skzd44qn.dlv@maison.homelinux.org>
References: <87hcg0fyxe.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: julliard@winehq.org
X-From: git-owner@vger.kernel.org Thu Feb 28 13:59:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUiM9-00087c-CZ
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 13:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbYB1M6t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Feb 2008 07:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755586AbYB1M6t
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 07:58:49 -0500
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:60565
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753611AbYB1M6s convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 07:58:48 -0500
Received: from neuf-infra-smtp-out-sp604001av.neufgp.fr ([84.96.92.125])
	by neuf-infra-smtp-out-sp604007av.neufgp.fr with neuf telecom
	id uzzV1Y01W2iH3ss0702Q00; Thu, 28 Feb 2008 13:58:45 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604001av.neufgp.fr with neuf telecom
	id v0yi1Y00A20lBGc0100000; Thu, 28 Feb 2008 13:58:45 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JUiLQ-0003Sz-4Y; Thu, 28 Feb 2008 13:58:42 +0100
In-Reply-To: <87hcg0fyxe.dlv@maison.homelinux.org> (=?utf-8?Q?=22R=C3=A9mi?=
 Vanicat"'s message of "Fri\, 22 Feb 2008 22\:45\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: moi@vanicat.homelinux.org
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on maison.homelinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS autolearn=ham
	version=3.2.3
X-SA-Exim-Version: 4.2.1 (built Tue, 21 Aug 2007 23:39:36 +0000)
X-SA-Exim-Scanned: Yes (on maison.homelinux.org)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75396>

Any comment on this bug fix ? It seem it was forgotten.
I re-include it for convenience:


=46rom 8ab57162a69c178dbc04bc4f94271e36ee9d120a Mon Sep 17 00:00:00 200=
1
=46rom: R=C3=A9mi Vanicat <vanicat@debian.org>
Date: Fri, 22 Feb 2008 22:36:23 +0100
Subject: [PATCH] git.el: find the git-status buffer whatever its name i=
s

git-status used the buffer name to find git-status buffers, and that
could failed if the buffer had another name, for example when multiple
working directories was tracked.
---
 contrib/emacs/git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index f69b697..14a1601 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1545,7 +1545,7 @@ Commands:
         (with-current-buffer buffer
           (when (and list-buffers-directory
                      (string-equal fulldir (expand-file-name list-buff=
ers-directory))
-                     (string-match "\\*git-status\\*$" (buffer-name bu=
ffer)))
+		     (eq major-mode 'git-status-mode))
             (setq found buffer))))
       (setq list (cdr list)))
     found))
--=20
1.5.4.2.191.g7b407


--=20
R=C3=A9mi Vanicat
