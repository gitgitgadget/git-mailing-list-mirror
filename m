From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: squash commits deep down in history
Date: Thu, 23 Oct 2014 22:08:22 +0200
Message-ID: <54496036.8080109@kdbg.org>
References: <trinity-6a57d894-cc4f-4213-9c51-5c73de2501d0-1414067657189@3capp-gmx-bs48>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Henning Moll <newsScott@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 22:08:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhOgQ-0007Mf-Nr
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 22:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbaJWUI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 16:08:27 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:62361 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbaJWUI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 16:08:26 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jP04V6JQqz5tlP;
	Thu, 23 Oct 2014 22:08:10 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BDC2819F758;
	Thu, 23 Oct 2014 22:08:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <trinity-6a57d894-cc4f-4213-9c51-5c73de2501d0-1414067657189@3capp-gmx-bs48>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.10.2014 um 14:34 schrieb Henning Moll:
> i need to squash several commits into a single one in a automated
> way. I know that there is interactive rebase, which can also be
> automated using GIT_SEQUENCE_EDITOR. Unfortunately my history is very
> large and i need to squash deep down in the history several times. So
> using interactive rebase seems not to be the right tool.
> 
> I wonder if i can solve this task using filter-branch? I have a file
> that list the SHA1s for each squash operation per line. All SHA1s of
> a line are in chronological order (youngest to oldest), or in other
> words: the first SHA1 is the child of the second, and so on.

Use git-replace do construct a squashed commit that replaces the last
child in each run such that its parent points to the parent of the first
in the run. Then use a git-filterbranch without filters to burn the
parenthood into the history.

-- Hannes
