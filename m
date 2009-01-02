From: david@lang.hm
Subject: how to track the history of a line in a file
Date: Fri, 2 Jan 2009 14:13:32 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 22:13:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIrJr-0001My-5c
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 22:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758463AbZABVLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 16:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758272AbZABVLN
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 16:11:13 -0500
Received: from mail.lang.hm ([64.81.33.126]:38591 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757629AbZABVLM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 16:11:12 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n02LBA5H022805
	for <git@vger.kernel.org>; Fri, 2 Jan 2009 13:11:10 -0800
X-X-Sender: dlang@asgard.lang.hm
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104415>

I have a need to setup a repository where I'm storing config files, and I 
need to be able to search the history of a particular line, not just when 
the last edit of the line was (which is what I see from git blame)

I'm not seeing a obvious way to do this, am I missing something or does it 
need a non-obvious approach?

for example, if I do

git blame -L /SUBLEVEL/,+1 -M Makefile

on the linux kernel it currently shows

57f8f7b6 (Linus Torvalds 2008-10-23 20:06:52 -0700 3) SUBLEVEL = 28

what I would want it to show would be a list of the commits that have 
changed this line.

It looks like I can write a script to do this

git blame -L /SUBLEVEL/,+1 -M Makefile 57f8f7b6^
6e86841d (Linus Torvalds 2008-07-28 19:40:31 -0700 3) SUBLEVEL = 27
git blame -L /SUBLEVEL/,+1 -M Makefile 6e86841d^
2ddcca36 (Linus Torvalds 2008-05-03 11:59:44 -0700 3) SUBLEVEL = 26

etc.

is there a better way to do this?

David Lang
