From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [PATCH] rebase -i -p: doesn't pick certain merge commits that
 are children of "upstream"
Date: Mon, 13 Jun 2011 13:30:26 -0400
Message-ID: <4DF64932.1090607@sohovfx.com>
References: <4DEB495F.9080900@kdbg.org> <1307419725-4470-1-git-send-email-andrew.kw.w@gmail.com> <1307419725-4470-2-git-send-email-andrew.kw.w@gmail.com> <7vmxhlpvob.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 19:30:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWAyE-0006X0-ET
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 19:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599Ab1FMRad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 13:30:33 -0400
Received: from smtp04.beanfield.com ([76.9.193.173]:56813 "EHLO
	smtp04.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631Ab1FMRac (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 13:30:32 -0400
X-Spam-Status: No
X-beanfield-mta04-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta04-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta04-MailScanner: Found to be clean
X-beanfield-mta04-MailScanner-ID: 1QWAy3-0009ZT-3G
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta04.beanfield.com with esmtpa (Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QWAy3-0009ZT-3G; Mon, 13 Jun 2011 13:30:27 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <7vmxhlpvob.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175723>

On 06/13/2011 12:01 PM, Junio C Hamano wrote:
> There is no title to this test?
>   
Ah, that's embarrassing. I'll fix that. Thanks!

> In general I think it is wrong to change behaviour depending on which
> parent of a merge we are looking at (unless of course the user tells us
> to, like "git log --first-parent"), so in that sense philosophically I
> think the patch is going in the right direction, but I do worry about
> potential regressions.
>   
I totally agree.  Ever since Jeff brought up this issue, I've been
wondering what issue/workflow is that patch trying to fix.  If the
"todo" list doesn't change the parent of the merge commits, git should
be able to do a fast-forward on the merge, which means the merge won't
be rewritten anyway.  Just a wild guess: maybe back then, git will
actually rewrite the merge regardless?  Anyway, let's wait for a reply
from Stephen.
