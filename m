From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 4/5] fetch: Add output for the not fast forward case
Date: Fri, 29 Sep 2006 20:07:19 +0200
Message-ID: <87ac4i1r8o.fsf@gmail.com>
References: <87r6xu1rci.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 29 20:07:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTMlh-0003tS-EE
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 20:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWI2SHW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 29 Sep 2006 14:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWI2SHW
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 14:07:22 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:14248 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751302AbWI2SHV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 14:07:21 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8TI7JQ04010
	for <git@vger.kernel.org>; Fri, 29 Sep 2006 20:07:19 +0200
To: git <git@vger.kernel.org>
In-Reply-To: <87r6xu1rci.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Fri, 29 Sep
	2006 20:05:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28121>


Use the ... notation to be able to use this directly in "git log" to se=
e
how the two non-fast-forward heads have diverged.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-fetch.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 32553f8..ee4f5bd 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -190,6 +190,7 @@ fast_forward_local () {
 		;;
 	    esac || {
 		echo >&2 "* $1: does not fast forward to $3;"
+		echo >&2 "  $(git-rev-parse --short $local)...$(git-rev-parse --shor=
t $2)"
 		case ",$force,$single_force," in
 		*,t,*)
 			echo >&2 "  forcing update."
--=20
1.4.2.1.g38049
