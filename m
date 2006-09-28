From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] fetch: Add output for the not fast forward case
Date: Fri, 29 Sep 2006 00:15:34 +0200
Message-ID: <873babbptl.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 29 00:16:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT4AP-0002mT-Tn
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 00:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWI1WPi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 28 Sep 2006 18:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWI1WPi
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 18:15:38 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:3287 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S932528AbWI1WPh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 18:15:37 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8SMFYQ05113
	for <git@vger.kernel.org>; Fri, 29 Sep 2006 00:15:35 +0200
To: git <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28056>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---

This patch follows the notation of the other mail, but for the
not-fast-forward case I think it makes more sense to use the '...'
notation. If you don't like it, just use:

+		echo >&2 "  from $local to $2"

 git-fetch.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 1bc6108..15d6800 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -190,6 +190,7 @@ fast_forward_local () {
 		;;
 	    esac || {
 		echo >&2 "* $1: does not fast forward to $3;"
+		echo >&2 "  $local...$2"
 		case ",$force,$single_force," in
 		*,t,*)
 			echo >&2 "  forcing update."
--=20
1.4.2.1.g5a0f
