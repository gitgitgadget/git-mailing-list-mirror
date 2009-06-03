From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v2] completion: Add --full-diff to log options
Date: Wed, 3 Jun 2009 16:20:58 -0400
Message-ID: <20090603202058.GA28808@inocybe.localdomain>
References: <pan.2009.06.02.00.34.36@fedoraproject.org>
 <7vzlcrihew.fsf@alter.siamese.dyndns.org>
 <20090603122230.GZ28808@inocybe.localdomain>
 <200906031630.09962.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Spura <tomspur@fedoraproject.org>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 03 22:21:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBwxb-0005BZ-HB
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 22:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbZFCUVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 16:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbZFCUVJ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 16:21:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbZFCUVI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 16:21:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 291D9B8DE7;
	Wed,  3 Jun 2009 16:21:10 -0400 (EDT)
Received: from inocybe.localdomain (unknown [173.67.155.244]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 40DFAB8DE3; Wed,
  3 Jun 2009 16:21:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200906031630.09962.trast@student.ethz.ch>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: 1384A700-507C-11DE-AF1D-97731A10BFE7-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120636>

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

Thomas Rast wrote:
> Todd Zullinger wrote:
>> I *think* __git_log_gitk_options is the proper place for it, but it's
>> early in the a.m. and I'm not averse to being proved wrong.
> [...]
>>  # Options that go well for log and gitk (not shortlog)
>>  __git_log_gitk_options="
>> -	--dense --sparse --full-history
>> +	--dense --sparse --full-diff --full-history
>
> Gitk has its own setting in the Preferences called "limit diffs to
> listed paths", and ignores this option, so it should go directly in
> _git_log.

Ahh, thanks Thomas.

 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 98b9cbe..79a99af 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1157,7 +1157,7 @@ _git_log ()
 			$__git_log_shortlog_options
 			$__git_log_gitk_options
 			--root --topo-order --date-order --reverse
-			--follow
+			--follow --full-diff
 			--abbrev-commit --abbrev=
 			--relative-date --date=
 			--pretty= --format= --oneline
-- 
1.6.3.1

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I have to decide between two equally frightening options.  If I wanted
to do that, I'd vote.
    -- Duckman
