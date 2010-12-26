From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t1501: avoid bashisms
Date: Sun, 26 Dec 2010 11:23:07 -0800
Message-ID: <7v4oa0z6ck.fsf@alter.siamese.dyndns.org>
References: <1293285457-11915-1-git-send-email-pclouds@gmail.com>
 <m2aajudjqt.fsf@whitebox.home>
 <AANLkTinhrBf14446rJBZSYWTSH6sxOchMcgBsrq8DoLO@mail.gmail.com>
 <AANLkTi=fCa4a-POoMWqnraFjz28-Ko4Yp0fcar+d7AsE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	Michel Briand <michelbriand@free.fr>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 26 20:23:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWwBh-0004xb-8n
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 20:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab0LZTXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 14:23:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab0LZTXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 14:23:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A1C4728D9;
	Sun, 26 Dec 2010 14:23:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2RNlspzvK7I+CbZPJREkQQlFJgA=; b=xcVN4P
	OP0fHlx4rXqiCPlCNTYXyJ41Jn1NWwVl1pv3p17MjKxDxg8le5FkKjg4MZL/dRLK
	yrDotnzWgf50IDcUZyoJwGMgz09WLLGCg7ZTAm3IuxDXrTgMXo66hPvGsFFSoUwr
	neAhN5AtcUlPRw+EotOzbR1BAzOAMnIxZK4OY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AguSyiG+wO13dFWtqg6kH76yqyziXwQN
	9q7YsR/QN9hnoMfN00gb6s4tUs6KNDbKmfI+Uu+Vl+hL8uU7bwS+MOSqxCBoOL5y
	ObVAeePwntbL/jjJrU7USVWzr6EXrjbDv8rO5NaOXLYV/ib8WKoPFA1CLo01f/pw
	umpKWIhNmgE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5DD9428D8;
	Sun, 26 Dec 2010 14:23:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0CADB28D7; Sun, 26 Dec 2010
 14:23:39 -0500 (EST)
In-Reply-To: <AANLkTi=fCa4a-POoMWqnraFjz28-Ko4Yp0fcar+d7AsE@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Sat\, 25 Dec 2010 21\:44\:25 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A8232948-1125-11E0-8B48-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164198>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Junio, please don't pick up this patch.

Won't.  And [2/2] needs to be updated with something like this?

 t/t1501-worktree.sh |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 1429a65..8cab065 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -341,14 +341,10 @@ test_expect_success 'make_relative_path handles double slashes in GIT_DIR' '
 '
 
 test_expect_success 'relative $GIT_WORK_TREE and git subprocesses' '
-	(
-	GIT_DIR=repo.git
-	GIT_WORK_TREE=repo.git/work
-	export GIT_DIR GIT_WORK_TREE
+	GIT_DIR=repo.git GIT_WORK_TREE=repo.git/work \
 	test-subprocess rev-parse --show-toplevel >actual &&
-	echo "`pwd`/repo.git/work" >expected &&
+	echo "$(pwd)/repo.git/work" >expected &&
 	test_cmp expected actual
-	)
 '
 
 test_done
