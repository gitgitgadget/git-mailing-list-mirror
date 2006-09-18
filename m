From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git pull a subtree, embedded trees
Date: Mon, 18 Sep 2006 07:58:20 +0200
Organization: At home
Message-ID: <eelcgd$830$1@sea.gmane.org>
References: <4508020F.2050604@sgi.com> <ee945j$h3u$1@sea.gmane.org> <450E3399.5070601@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Sep 18 07:57:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPC8Y-00083g-PE
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 07:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965441AbWIRF5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 01:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965442AbWIRF5n
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 01:57:43 -0400
Received: from main.gmane.org ([80.91.229.2]:45292 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965441AbWIRF5m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 01:57:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GPC8S-00082h-Jn
	for git@vger.kernel.org; Mon, 18 Sep 2006 07:57:40 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Sep 2006 07:57:40 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Sep 2006 07:57:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27230>

Timothy Shimmin wrote:

>>> * Are there any tools for dumping out the contents of the
>>> git objects in the .git/objects directory.
>>> By dumping out, I mean an ascii representation of the data
>>> fields for the commit and tree objects in particular.
>>> I've written a simple small program to dump out the index
>>> entries (cache entries).
>> 
>> git-cat-file -p
>> 
> Excellent, thanks. (looks like the option is undocumented - secret option:)

It looks not:

usage: git-cat-file [-t|-s|-e|-p|<type>] <sha1>

       -p     Pretty-print the contents of <object> based on its type.

> So I added this to a script which walks over the objects directory,
> to work out what all the object ids are so I can apply git-cat-file
> to all the objects on my test directory.
> I guess this will fall down if the objects are stored in a pack :)
> I'll have to look and see how to extract all the object ids using
> some command.

git-rev-parse and/or git-rev-list (the latter with --objects option) is your
friend. And there is git-ls-tree command which list sha1 of blobs (files)
and trees (subdirectories) for specific revision (specified tree).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
