From: Samuel Abels <newsgroups@debain.org>
Subject: Re: Performance impact of a large number of commits
Date: Sat, 25 Oct 2008 07:18:35 +0200
Message-ID: <1224911915.7566.35.camel@localhost>
References: <1224874946.7566.13.camel@localhost>
	 <alpine.DEB.1.10.0810241240100.27333@asgard.lang.hm>
	 <1224878202.7566.25.camel@localhost>
	 <alpine.DEB.1.10.0810241301430.27333@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Oct 25 07:19:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtbZ4-0006Gj-Qn
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 07:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbYJYFSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 01:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbYJYFSk
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 01:18:40 -0400
Received: from mail.speedpartner.de ([91.184.32.3]:56880 "EHLO
	mail.speedpartner.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbYJYFSj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 01:18:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.speedpartner.de (Postfix) with ESMTP id 219ACB3E26;
	Sat, 25 Oct 2008 07:18:38 +0200 (CEST)
Received: from mail.speedpartner.de ([127.0.0.1])
	by localhost (mail.speedpartner.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id szHcFKZH5b+K; Sat, 25 Oct 2008 07:18:38 +0200 (CEST)
Received: from [192.168.0.3] (stgt-4d02f7a8.pool.mediaWays.net [77.2.247.168])
	by mail.speedpartner.de (Postfix) with ESMTP id CCE1AB3AF1;
	Sat, 25 Oct 2008 07:18:35 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.10.0810241301430.27333@asgard.lang.hm>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99093>

On Fri, 2008-10-24 at 13:11 -0700, david@lang.hm wrote:
> > git commit explicitly (i.e., walking the tree to stat files for finding
> > changes is not necessary).
> 
> I suspect that your limits would be filesystem/OS limits more than git 
> limits
> 
> at 5-10 files/commit you are going to be creating .5-1m files/day, even 
> spread across 256 directories this is going to be a _lot_ of files.

The files are organized in a way that places no more than ~1.000 files
into each directory. Will Git create a directory containing a larger
number of object files? I can see that this would be a problem in our
use case.

> packing this may help (depending on how much the files change), but with 
> this many files the work of doing the packing would be expensive.

We can probably do that even if it takes several hours.

-Samuel
