From: sean <seanlkml@sympatico.ca>
Subject: Re: What's in git.git
Date: Thu, 9 Feb 2006 04:40:39 -0500
Message-ID: <BAYC1-PASMTP02D0738F3BA0E42EB66C94AE030@CEZ.ICE>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP1142DA49F5BC7B7B42B22FAE030@CEZ.ICE>
	<43EB05B5.20307@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 10:41:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F78IO-0006UE-UF
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 10:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbWBIJk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 04:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbWBIJk5
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 04:40:57 -0500
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:43611 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S965130AbWBIJk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 04:40:57 -0500
X-Originating-IP: [65.94.251.146]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.94.251.146]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 9 Feb 2006 01:40:56 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 8AB2E644C28;
	Thu,  9 Feb 2006 04:40:54 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Message-Id: <20060209044039.45763d4f.seanlkml@sympatico.ca>
In-Reply-To: <43EB05B5.20307@op5.se>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.11; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 09 Feb 2006 09:40:56.0577 (UTC) FILETIME=[ED290F10:01C62D5C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 09 Feb 2006 10:04:53 +0100
Andreas Ericsson <ae@op5.se> wrote:

> I thought
> 
> 	Pull: +pu:pu
> 
> was supposed to handle such things automatically. It has always pulled 
> properly for me anyways.
> 

The only problem with that is that Junio rebases and discards commits
periodically that will still be in your local pu branch.   The fetch/merge 
logic doesn't notice that commits have disappeared from Junio's pu branch.
So you'll end up with a union of all the pu branches in your local repo 
with commits that were dropped and never merged into mainline by Junio.

Unless you add changes to the pu branch locally you should never need
anything but a fast forward when pulling from Junio.  Except it breaks
when he rebases things.   The easy hackish "fix" is just to delete and repull
the branch which is always small anyway.

Sean
