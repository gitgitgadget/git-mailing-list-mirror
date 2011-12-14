From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: t0090-cache-tree fails due to wc whitespace
Date: Wed, 14 Dec 2011 16:09:47 +0100
Message-ID: <hbf.20111214ogjn@bombur.uio.no>
References: <7F1792D2-8ED4-4546-8ED4-52B95E0AE9FC@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 16:10:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaqTG-0001ql-3P
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 16:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264Ab1LNPJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 10:09:53 -0500
Received: from mail-out2.uio.no ([129.240.10.58]:54187 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756798Ab1LNPJv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 10:09:51 -0500
Received: from mail-mx2.uio.no ([129.240.10.30])
	by mail-out2.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RaqSq-0001cr-2L; Wed, 14 Dec 2011 16:09:48 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx2.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RaqSp-0007ky-NM; Wed, 14 Dec 2011 16:09:48 +0100
Received: by bombur.uio.no (Postfix, from userid 2112)
	id 24EE3E34; Wed, 14 Dec 2011 16:09:47 +0100 (CET)
In-Reply-To: <7F1792D2-8ED4-4546-8ED4-52B95E0AE9FC@silverinsanity.com>
X-Mailer: VM 7.19 under Emacs 23.1.1
X-UiO-Ratelimit-Test: rcpts/h 4 msgs/h 1 sum rcpts/h 8 sum msgs/h 2 total rcpts 2035 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RP_MATCHES_RCVD=-2.023,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 1B7B73C6B6A3BD42AA9F2E81EFD0EBEE6C4FA510
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -69 maxlevel 80 minaction 1 bait 0 mail/h: 1 total 876 max/h 5 blacklist 0 greylist 1 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187125>

Brian Gernhardt writes:
> I was able to fix this by adding a sed command to remove leading spaces:
> 
> -           "($(git ls-files|wc -l) entries, 0 subtrees)" >expect &&
> +           "($(git ls-files|wc -l|sed -e 's/^ *//') entries, 0 subtrees)" >expect &&
> 
> But I'm not sure if this is the best way to solve the issue.

Well,  tr -d ' '  saves all of 7 characters from  sed -e 's/^ *//'.

-- 
Hallvard
