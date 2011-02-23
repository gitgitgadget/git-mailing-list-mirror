From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] completion: complete "git diff ...branc<TAB>"
Date: Wed, 23 Feb 2011 13:43:08 -0800
Message-ID: <7vlj1677gz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 23 22:43:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsMUY-00022U-8L
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 22:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029Ab1BWVnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 16:43:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663Ab1BWVnU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 16:43:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 373DC3750;
	Wed, 23 Feb 2011 16:44:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=MVVZ
	KcmJYww2f/bCYmF59gv8ff0=; b=mr99gXQC5++U9CIvRuSjvFis+S8DDPvY1iHM
	KGvlPXEqNN44W8kEx73/UI0qPbi4a+BnMD4JdyzIVVuCx9kVTZSCd5fkgiD49s/U
	RAV99111UCXLClOdrMyIjuRJZCtjjkrN1HzNIQeG/pAauTikHqboZ+swVEJ+G3bH
	4RJZc1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	N+dD5TV1tABGgpFkJ/2cfHHB0mJ79QS9J+P7qx7YR6blVQbZjttT5ZRc+wWGfJZP
	D95PlKiQUTwnUf207+FGXM+NovkfgSUAmVxByBSFAmcMWkSf48gXWVNymHMOYxX5
	alfMODjCUN/nu0Q3HT3jQ6ReS7yFpbUryxuy5tNXgj8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 04990374E;
	Wed, 23 Feb 2011 16:44:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C02CA374C; Wed, 23 Feb 2011
 16:44:23 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16AEFB64-3F96-11E0-800D-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167728>

While doing a final sanity check before merging a topic Bsomething, it is
a good idea to review what damage Bsomething branch would make, by running:

    $ git diff ...Bsomething

I however find myself often typing "git diff ...B<TAB>", seeing nothing
happening and then repeatedly hitting <TAB>, saying "huh? <TAAAAAAAAB>!".

This change would hopefully help me, and others like me.

Even though there is no point in supporting "git diff A..B" (you can say
"git diff A B" just fine), but reusing complete-revlist was the easiest
and that form is supported as a benign but not so useful side effect.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I sent this out a while ago and have been using it ever since, but
   totally forgot about it.  Likes, dislikes, alternatives?

 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 64341d5..cf56514 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1137,7 +1137,7 @@ _git_diff ()
 		return
 		;;
 	esac
-	__git_complete_file
+	__git_complete_revlist
 }
 
 __git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
