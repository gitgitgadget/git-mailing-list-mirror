From: Shahid Alam <shahid.alam@gmail.com>
Subject: [PATCH] make git-svn resilient to log.abbrevcommit = true
Date: Wed, 23 Nov 2011 23:16:28 -0800
Message-ID: <3A78B8F7-803C-4278-8B5F-4A1B02C9FF04@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 24 08:16:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTTXx-0000V3-3y
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 08:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab1KXHQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 02:16:32 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57696 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1KXHQc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 02:16:32 -0500
Received: by ywt32 with SMTP id 32so2220578ywt.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 23:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        bh=vY58nvKoHT3NN87CD6D38gfGsZ4AezbU1+OvMkYrM/k=;
        b=nXCpM1eTVvosLoHqu+AcxTgVqD9kCCzEYzsWD/2MebyuqCQVSNGseLdYWWYJHtANY0
         NK9d8Z8oeSWCwTiYnYr0jpEZxOyDICuytfZw+meInTigNb20hxA2sR1/mbiv1ZtDobPI
         6DxnmrC2SEntdTsiKp6oH1h2ajmrLBdMBKXTA=
Received: by 10.50.87.227 with SMTP id bb3mr31343138igb.29.1322118991645;
        Wed, 23 Nov 2011 23:16:31 -0800 (PST)
Received: from [192.168.1.5] (c-76-103-54-111.hsd1.ca.comcast.net. [76.103.54.111])
        by mx.google.com with ESMTPS id p16sm83486720ibk.6.2011.11.23.23.16.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Nov 2011 23:16:30 -0800 (PST)
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185893>

Add --no-abbrev-commit arg to working_head_Info()'s invocation
of git log.
---
git-svn.perl |    2 +-
1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 351e743..da4c240 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1803,7 +1803,7 @@ sub cmt_sha2rev_batch {
sub working_head_info {
	my ($head, $refs) = @_;
	my @args = qw/log --no-color --no-decorate --first-parent
-	              --pretty=medium/;
+	              --no-abbrev-commit --pretty=medium/;
	my ($fh, $ctx) = command_output_pipe(@args, $head);
	my $hash;
	my %max;
-- 
1.7.7.2
