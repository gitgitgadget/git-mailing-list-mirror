From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <carlos@cmartin.tk>
Subject: Re: git svn rebase bug
Date: Wed, 9 Nov 2011 11:40:56 +0100
Message-ID: <20111109104056.GB3409@beez.lab.cmartin.tk>
References: <39110A70-A25E-4A6B-A401-FCCE895B2CE5@rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Arsenault <arsenm2@rpi.edu>
X-From: git-owner@vger.kernel.org Wed Nov 09 11:41:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RO5ak-0005tZ-VA
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 11:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab1KIKlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 05:41:08 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:50543 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700Ab1KIKlH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 05:41:07 -0500
Received: from beez.lab.cmartin.tk (z39c5.pia.fu-berlin.de [87.77.57.197])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 3FF4446196;
	Wed,  9 Nov 2011 11:40:32 +0100 (CET)
Received: (nullmailer pid 7498 invoked by uid 1000);
	Wed, 09 Nov 2011 10:40:56 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <carlos@cmartin.tk>,
	Matt Arsenault <arsenm2@rpi.edu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <39110A70-A25E-4A6B-A401-FCCE895B2CE5@rpi.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185150>

On Tue, Nov 08, 2011 at 03:50:25PM -0500, Matt Arsenault wrote:
> There seems to be a bug using git svn rebase with strategies
> 
> git version 1.7.7.2
> 
> 
> $ git svn rebase --strategy=theirs

ENOENT. The "theirs" strategy doesn't exist (there is an "ours"
strategy). "Theirs" in a option to the recursive merge strategy.

> 
> First, rewinding head to replay your work on top of it...
> /usr/lib/git-core/git-rebase--merge: line 69: git-merge-theirs: command not found
> Unknown exit code (127) from command: git-merge-theirs deabad54a6d5ce3ab3f655e06b9c24eadbba6f6c^ -- HEAD deabad54a6d5ce3ab3f655e06b9c24eadbba6f6c
> rebase --strategy=theirs refs/remotes/git-svn: command returned error: 1

The bug is the failure to detect that the merge strategy doesn't
exist, but your command wouldn't have worked anyway.

   cmn
