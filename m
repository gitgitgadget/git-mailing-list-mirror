From: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
Subject: [PATCH] git.el: find the git-status buffer whatever its name is
Date: Fri, 29 Feb 2008 19:28:19 +0100
Message-ID: <87wson1ut8.dlv@maison.homelinux.org>
References: <87hcg0fyxe.dlv@maison.homelinux.org>
	<87skzd44qn.dlv@maison.homelinux.org>
	<7vprugj0t2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: julliard@winehq.org, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 19:29:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV9yl-000721-2R
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 19:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757745AbYB2S22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 13:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757701AbYB2S22
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 13:28:28 -0500
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:56663
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757598AbYB2S21 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Feb 2008 13:28:27 -0500
Received: from neuf-infra-smtp-out-sp604012av.neufgp.fr ([84.96.92.115])
	by neuf-infra-smtp-out-sp604007av.neufgp.fr with neuf telecom
	id vWTf1Y00Z2VLLWC0700C00; Fri, 29 Feb 2008 19:28:25 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604012av.neufgp.fr with neuf telecom
	id vWUM1Y00820lBGc0C00000; Fri, 29 Feb 2008 19:28:24 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JV9xz-0006Ti-EB; Fri, 29 Feb 2008 19:28:21 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75549>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

git-status used the buffer name to find git-status buffers, and that
could failed if the buffer had another name, for example when multiple
working directories was tracked.
Signed-off-by: R=C3=A9mi Vanicat <vanicat@debian.org>
Acked-by: Alexandre Julliard <julliard@winehq.org>
Tested-by: Xavier Maillard <xma@gnu.org>
---
Resend as requested
 contrib/emacs/git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index f69b697..14a1601 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1545,7 +1545,7 @@ Commands:
         (with-current-buffer buffer
           (when (and list-buffers-directory
                      (string-equal fulldir (expand-file-name list-buffers-=
directory))
-                     (string-match "\\*git-status\\*$" (buffer-name buffer=
)))
+		     (eq major-mode 'git-status-mode))
             (setq found buffer))))
       (setq list (cdr list)))
     found))
--=20
1.5.4.2.191.g7b407


--=20
R=C3=A9mi Vanicat

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


--=20
R=C3=A9mi Vanicat

--=-=-=--
