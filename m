From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 8/9] t3903-stash.sh: tests of git stash with stash-like arguments
Date: Sun, 8 Aug 2010 11:32:56 +0200
Message-ID: <201008081132.56998.j6t@kdbg.org>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com> <1281242771-24764-9-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, ams@toroid.org,
	nanako3@bluebottle.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 11:33:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi2Fr-0007wK-Ny
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 11:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529Ab0HHJdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 05:33:00 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:47551 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab0HHJc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 05:32:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1B46BCDF89;
	Sun,  8 Aug 2010 11:32:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1BFB819F5C0;
	Sun,  8 Aug 2010 11:32:57 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1281242771-24764-9-git-send-email-jon.seymour@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152897>

On Sonntag, 8. August 2010, Jon Seymour wrote:
> +test_expect_success 'stash branch - no stashes on stack, stash-like
> argument' ' +	git stash clear &&
> +	test_when_finished "git reset --hard HEAD" &&
> +	git reset --hard &&
> +	echo foo >> file &&
> +	git tag stash-tag $(git stash create) &&

To catch failures in $(git stash create), you should rewrite lines like this 
one as:

	stashid=$(git stash create) &&
	git tag stash-tag $stashid &&

-- Hannes
