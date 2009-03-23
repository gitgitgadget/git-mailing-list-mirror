From: Benny Halevy <bhalevy@panasas.com>
Subject: Re: git rebase + fuzz = possible bad merge
Date: Mon, 23 Mar 2009 16:06:56 +0200
Message-ID: <49C79780.20105@panasas.com>
References: <49C7675E.9000309@panasas.com> <200903231454.48600.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 23 15:08:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlkpP-0006CB-8u
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbZCWOHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbZCWOHF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:07:05 -0400
Received: from gw-ca.panasas.com ([209.116.51.66]:25659 "EHLO
	laguna.int.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752853AbZCWOHE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 10:07:04 -0400
Received: from daytona.int.panasas.com ([172.17.28.41]) by laguna.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Mar 2009 07:07:02 -0700
Received: from fs1.bhalevy.com ([172.17.28.140]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Mar 2009 10:06:57 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1b3pre) Gecko/20090223 Thunderbird/3.0b2
In-Reply-To: <200903231454.48600.trast@student.ethz.ch>
X-OriginalArrivalTime: 23 Mar 2009 14:06:57.0977 (UTC) FILETIME=[A0FCEA90:01C9ABC0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114307>

On Mar. 23, 2009, 15:54 +0200, Thomas Rast <trast@student.ethz.ch> wrote:
> Benny Halevy wrote:
>> I'm hitting bad merges with (non interactive) git rebase
>> when a hunk is merged pre-maturely into an inexact match
>> when there's fuzz.
> [...]
>> { for i in {1..10}; do echo fuzz $i; done; echo; cat test_file; } > fuzz_file
> [...]
>> git rebase --onto test_branch master^ master
> 
> git-am, and by extension rebase, by default doesn't take history into
> account.  It just applies the patches "blindly".  Thus, there's no way
> to know which series of 'line N' you really wanted it to go onto.
> 
> To avoid this issue, use the -m option to git-rebase so that it uses a
> "real" merge.  (You can achieve similar effects for git-am with the -3
> option.)
> 

OK. -m indeed helps and I'm certainly going to adopt it for my rebase scripts.
git rebase -i does too, BTW.

I would expect though that the default mode for automatic rebase would be
the strictest and safest...

Benny
