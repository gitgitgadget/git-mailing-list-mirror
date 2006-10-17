From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: [RFC/PATCH] git-fetch: Use already fetched branch with the --local flag.
Date: Tue, 17 Oct 2006 16:03:30 +0200
Message-ID: <873b9n9gzx.fsf@gmail.com>
References: <87ac3w8jl1.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 17 16:03:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZpXc-0005hb-PK
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 16:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWJQODe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 10:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWJQODe
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 10:03:34 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:58505 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1750994AbWJQODd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 10:03:33 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k9HE3VJ16896
	for <git@vger.kernel.org>; Tue, 17 Oct 2006 16:03:31 +0200
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <87ac3w8jl1.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Mon, 16 Oct
	2006 15:40:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29075>


Please, add this:

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 617d022..a792323 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -260,7 +260,7 @@ get_ref_for_remote_branch (){
 	remotes)
 		ref=$(sed -ne '/^Pull: */{
 				s///p
-			}' "$GIT_DIR/remotes/$1" | grep "$2:")
+			}' "$GIT_DIR/remotes/$1" | grep "^$2:")
 		expr "z$ref" : 'z[^:]*:\(.*\)'
 		;;
 	*)
