From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: What's cooking in git.git (Aug 2009, #05; Wed, 26)
Date: Thu, 27 Aug 2009 11:41:18 -0500
Message-ID: <SW-k_fUnLrE0kFNXSIYgMIc-pexuL5ykWs1ZdvHAo9_LMxe9ggJtCA@cipher.nrlssc.navy.mil>
References: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 18:41:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgi2U-0004xq-71
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 18:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbZH0QlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 12:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbZH0QlU
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 12:41:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33592 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbZH0QlU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 12:41:20 -0400
Received: by mail.nrlssc.navy.mil id n7RGfIx5004237; Thu, 27 Aug 2009 11:41:19 -0500
In-Reply-To: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 27 Aug 2009 16:41:18.0186 (UTC) FILETIME=[335B6CA0:01CA2735]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127176>

Junio C Hamano wrote:

> [Stalled]
> 
> * je/send-email-no-subject (2009-08-05) 1 commit
>  - send-email: confirm on empty mail subjects
> 
> This seems to break t9001.  Near the tip of 'pu' I have a iffy
> workaround.

Can you squash this into your 'iffy' workaround to help platforms
(Solaris 7, IRIX 6.5) without the 'yes' utility?

---
 t/t9001-send-email.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 960d7d8..641d0c3 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -505,6 +505,14 @@ test_expect_success '--suppress-cc=cc' '
 	test_suppression cc
 '
 
+yes () {
+	test -n "$*" && y="$*" || y='y'
+	while echo "$y"
+	do
+		:
+	done
+}
+
 test_confirm () {
 	yes | \
 		GIT_SEND_EMAIL_NOTTY=1 \
-- 
1.6.4
