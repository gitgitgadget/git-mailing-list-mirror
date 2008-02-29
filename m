From: Sean <seanlkml@sympatico.ca>
Subject: Re: Will git have a baseline feature or something alike?
Date: Fri, 29 Feb 2008 04:56:09 -0500
Message-ID: <BAYC1-PASMTP1509BFBE329A906C583BDCAE140@CEZ.ICE>
References: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "eric miao" <eric.y.miao@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 10:57:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV1zB-0000A3-Bx
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 10:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbYB2J4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 04:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbYB2J4P
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 04:56:15 -0500
Received: from bay0-omc2-s4.bay0.hotmail.com ([65.54.246.140]:45015 "EHLO
	bay0-omc2-s4.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754049AbYB2J4O (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Feb 2008 04:56:14 -0500
Received: from BAYC1-PASMTP15 ([65.54.191.189]) by bay0-omc2-s4.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Feb 2008 01:56:14 -0800
X-Originating-IP: [70.54.5.51]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([70.54.5.51]) by BAYC1-PASMTP15.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 29 Feb 2008 01:56:13 -0800
Received: from bud.attic.local ([10.10.10.20])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1JV2uH-0002sC-8O; Fri, 29 Feb 2008 05:56:01 -0500
In-Reply-To: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.5; x86_64-pc-linux-gnu)
X-OriginalArrivalTime: 29 Feb 2008 09:56:13.0863 (UTC) FILETIME=[51B84B70:01C87AB9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75517>

On Fri, 29 Feb 2008 17:23:37 +0800
"eric miao" <eric.y.miao@gmail.com> wrote:


Hi Eric,

> I kept a mirror of
> 
> http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> by a crontab task fetching the updated commits at midnight everyday.
> 
> Yet I found the repository now grows to be 1.2G without checking out
> anything. The checked out working tree of this is about 1.5G.

There's something wrong in your setup, the entire kernel history should
take less than 200M.

> I tried "git prune" and "git repack" but it still remains so large. The
> trend of the kernel is still going to be enlarged. Thus I'm thinking
> of the possibility of a baseline feature. One can totally forget about
> the history before that baseline, and start the development there
> after.

Git provides "shallow" clones which essentially give you that ability
today via the --depth option.  While it won't automatically determine
a baseline, it avoids the need for you to download a tarball first.

Sean
