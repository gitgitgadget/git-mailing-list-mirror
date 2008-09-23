From: John Freeman <jfreeman@cs.tamu.edu>
Subject: Re: clone fails: Could not get the current working directory
Date: Tue, 23 Sep 2008 16:16:06 -0500
Message-ID: <48D95C96.4030906@cs.tamu.edu>
References: <48D59A30.5020403@cs.tamu.edu>	 <81b0412b0809230539x340bd579q3489d5e257b9740@mail.gmail.com>	 <48D8EDDA.3050804@cs.tamu.edu>	 <81b0412b0809230712u4a1cbe0fo69f558cbe9a26aae@mail.gmail.com>	 <48D90125.3090703@cs.tamu.edu> <81b0412b0809230801l2e6b1a71v1210317fe636aeba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 23:17:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiFFs-0006tt-5r
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 23:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbYIWVPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 17:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbYIWVPg
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 17:15:36 -0400
Received: from smtp-relay.tamu.edu ([165.91.22.120]:4589 "EHLO
	sr-4-int.cis.tamu.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752831AbYIWVPf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 17:15:35 -0400
Received: from localhost (localhost.tamu.edu [127.0.0.1])
	by sr-4-int.cis.tamu.edu (Postfix) with ESMTP id 415DB17980;
	Tue, 23 Sep 2008 16:15:34 -0500 (CDT)
X-Virus-Scanned: amavisd-new at tamu.edu
Received: from b2.local (vpn-61.cs.tamu.edu [128.194.150.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sr-4-int.cis.tamu.edu (Postfix) with ESMTPSA id BB21117962;
	Tue, 23 Sep 2008 16:15:33 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <81b0412b0809230801l2e6b1a71v1210317fe636aeba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96601>

Alex Riesen wrote:
> I actually expected "ls -R" giving error about unable to read the 
> directory (permissions).

This worked.
> Again: try a simple program which just does getpwd for this pathname

 From what I gather, getpwd() is in libiberty, which I didn't feel like 
messing with for this example.  I ran a small test program that called 
getcwd() in the repo directory, and it failed.  errno was set to EACCES, 
indicating insufficient permissions.

http://www.opengroup.org/onlinepubs/009695399/functions/getcwd.html

I may get around later to patching this, but for now we're moving ahead 
with a workaround.

- John
