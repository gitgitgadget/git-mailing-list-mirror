From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH] Print hunk number in prompt of add --patch.
Date: Thu, 27 Nov 2008 06:17:17 +0000
Message-ID: <492E3B6D.9090309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 07:18:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5aDF-00049v-Nw
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 07:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbYK0GRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 01:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbYK0GRX
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 01:17:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:29849 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbYK0GRW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 01:17:22 -0500
Received: by nf-out-0910.google.com with SMTP id d3so441279nfc.21
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 22:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=a+V6sy1qjSA30Bn1GJG8z+bkYp0YqaNR23Tgle8xBuU=;
        b=Xqj5jj1u3TYomrltRHbkAF5aIHjzX3QBJEdVIYadDrQTNVoQn6FKBzvf71FTx/8jRH
         6g5E1P6RJSzX0CHsLvz1D9oTj2WsW85U2NV2RL6924G80RUFeavp4ZmMXssVDf/y3n4j
         sFhU5JLZDQ/zx2fzQRfYTtIDzAjk2T4LI7APQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=xIY5XJyGVdqD/2K+wwOQklf5DXd3ArQnif3NIqWy3PIvUeTrPbUVIanZMRs4GZ6Qpr
         SuruHXTZocfIoM1PQoX60327wdakMCZUcrQboGrTYyZ8b6TsJOw6ZTYoW4umtu+rCMTC
         cZ5ZJMFYDXUFhXVqVb1YGtftUNmEDs9j+pvC0=
Received: by 10.210.24.12 with SMTP id 12mr7021136ebx.31.1227766641451;
        Wed, 26 Nov 2008 22:17:21 -0800 (PST)
Received: from clam.local (5ad934ac.bb.sky.com [90.217.52.172])
        by mx.google.com with ESMTPS id z37sm1185267ikz.5.2008.11.26.22.17.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Nov 2008 22:17:20 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101793>


I'm considering adding a command to skip to a hunk, and
just generally find myself confused about which hunk I'm
looking at, so having the number in the prompt is helpful.

Signed-off-by: William Pursell <bill.pursell@gmail.com>
---
  git-add--interactive.perl |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index b0223c3..7974cd1 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -919,7 +919,7 @@ sub patch_update_file {
  		for (@{$hunk[$ix]{DISPLAY}}) {
  			print;
  		}
-		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
+		print colored $prompt_color, "Stage hunk $ix [y/n/a/d$other/?]? ";
  		my $line = <STDIN>;
  		if ($line) {
  			if ($line =~ /^y/i) {
-- 
1.6.0.4.782.geea74.dirty


-- 
William Pursell
