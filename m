From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: multiple checked out branches
Date: Wed, 1 Aug 2007 23:19:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708012309010.28202@beast.quantumfyre.co.uk>
References: <20070801220435.GA19226@raptus.dandreoli.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Domenico Andreoli <cavokz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:20:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMYJ-00032x-UP
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756260AbXHAWTb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 18:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbXHAWTa
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:19:30 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:57383 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753820AbXHAWT3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 18:19:29 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 1D9E3C614E
	for <git@vger.kernel.org>; Wed,  1 Aug 2007 23:19:26 +0100 (BST)
Received: (qmail 6492 invoked by uid 103); 1 Aug 2007 23:19:25 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3839. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.032396 secs); 01 Aug 2007 22:19:25 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 1 Aug 2007 23:19:25 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070801220435.GA19226@raptus.dandreoli.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54488>

On Thu, 2 Aug 2007, Domenico Andreoli wrote:

> Hi again,
>
>  I would like to contemporaneously work with multiple branches out of
> the same git repository. This does not work out of the box.

Depends on how you define "the box" ...

There is a script to do this in contrib called git-new-workdir.  It allows 
you to have multiple working directories from the same repository for 
exactly this purpose.

> So I prepare multiple copies of the same repository, every one will have
> its own checked out branch but I want to share most of their .git subdir.
>
> I surely want to share the object db, the local and remote refs.
> This way it is enough to make a round of fetches/merges/pushes to have
> all the shared-repositories up to date.
>
> I expect to do the trick with some symlinks but I am not an expert of
> git internals. Which traps are waiting me? Any hint? Thank you.

Symlinks are exactly what is used by new-workdir to link the workdirs back 
to the original repository.

The biggest issue with doing this is that you have no protection against 
making changes on the same branch in more than one place - something you 
really don't want to be dealing with.  Basically you need to be careful 
about updating refs that you have checkedout in workdirs.

-- 
Julian

  ---
...when fits of creativity run strong, more than one programmer or writer has
been known to abandon the desktop for the more spacious floor.
- Fred Brooks, Jr.
