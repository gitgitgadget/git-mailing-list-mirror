From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] bash: support pretty format aliases
Date: Thu, 14 Oct 2010 10:58:47 +0200
Message-ID: <1287046727-22509-2-git-send-email-szeder@ira.uka.de>
References: <20101014085538.GB838@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 14 10:59:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Jed-0006l8-TC
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 10:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059Ab0JNI7F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 04:59:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:50488 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062Ab0JNI7D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 04:59:03 -0400
Received: from [127.0.1.1] (p5B130B36.dip0.t-ipconnect.de [91.19.11.54])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Ll0b7-1OW9YK07pF-00bDaT; Thu, 14 Oct 2010 10:58:57 +0200
X-Mailer: git-send-email 1.7.3.1.151.g3779c
In-Reply-To: <20101014085538.GB838@neumann>
X-Provags-ID: V02:K0:OAV9bro24PIpkldohNH5TWUbFs+MIbXRi/mGQiqOSZi
 kujSEB+SJJUk4TAHlVVx6lKMCQPG0+9Hx4dYdM2EztiJq6HH9X
 NzasqiL9Ihb2OKacHMIyZT3vBxP5pswfKft7GZokA0rmRatI1y
 8rFaXlDW6BL8IMYEOcXmTUEd979FFYNb6HENnn7wIBS6o3Xe6C
 X0ArJzaGs/e5kxd63+kFg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159031>

Users can have their own pretty format aliases since 8028184 (pretty:
add aliases for pretty formats, 2010-05-02), so let's offer those
after '--pretty=3D' and '--format=3D' for 'log' and 'show', too.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 97a3d8c..a4b6f78 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1368,11 +1368,13 @@ _git_log ()
 	case "$cur" in
 	--pretty=3D*)
 		__gitcomp "$__git_log_pretty_formats
+			$(__git_get_config_variables "pretty")
 			" "" "${cur##--pretty=3D}"
 		return
 		;;
 	--format=3D*)
 		__gitcomp "$__git_log_pretty_formats
+			$(__git_get_config_variables "pretty")
 			" "" "${cur##--format=3D}"
 		return
 		;;
@@ -2095,11 +2097,13 @@ _git_show ()
 	case "$cur" in
 	--pretty=3D*)
 		__gitcomp "$__git_log_pretty_formats
+			$(__git_get_config_variables "pretty")
 			" "" "${cur##--pretty=3D}"
 		return
 		;;
 	--format=3D*)
 		__gitcomp "$__git_log_pretty_formats
+			$(__git_get_config_variables "pretty")
 			" "" "${cur##--format=3D}"
 		return
 		;;
--=20
1.7.3.1.151.g3779c
