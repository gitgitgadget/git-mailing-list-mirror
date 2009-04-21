From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Beginner problem with .gitignore
Date: Tue, 21 Apr 2009 13:43:35 +0200
Message-ID: <49EDB167.1030600@drmicha.warpmail.net>
References: <gsid27$p1$1@ger.gmane.org> <49ED8914.9090808@drmicha.warpmail.net> <49ED988A.6030504@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Kai Schlamp <schlamp@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 21 13:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwEPf-000758-Ec
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 13:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312AbZDULnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 07:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbZDULnq
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 07:43:46 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45971 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753314AbZDULnp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 07:43:45 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id AC90331EACA;
	Tue, 21 Apr 2009 07:43:44 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 21 Apr 2009 07:43:44 -0400
X-Sasl-enc: x5EBK5wApVCBJWJ+EwQULHIImaVYtiLwACFncst42jj4 1240314224
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5E9D930A35;
	Tue, 21 Apr 2009 07:43:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49ED988A.6030504@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117123>

Kai Schlamp venit, vidit, dixit 21.04.2009 11:57:
> Michael, thanks for the help. Comments below.
> 
>> By "is ignored", do you mean that git status doesn't show it? 
> 
> Yes, that is what I meant.
> 
>> git status does not recurse into subdirectories by default unless there 
>> is at least one tracked file inside.
> 
> Ok. I justed tested this a bit. Let's say I have the following directory 
> structure: "/a_dir/b_dir/c_dir"
> 
> And have a .gitignore with:
> /a_dir
> !/a_dir/b_dir/c_dir/
> 
> Now i put a file "a_file" in "c_dir".
> And add the a_file with "git add /a_dir/b_dir/c_dir/a_file". Yes, a_file 
> is tracked now.
> 
> I would have expected (after your information above) that if I create 
> another file "b_file" in "c_dir" and check "git status" that this file 
> is on the untracked file list now.

That's for the case when you don't ignore that dir.

> But it doesn't show up.
> And this makes it quite hard to exclude a whole folder, but only include 
> one of it's subfolders. I use git gui for commits. And I like it that 
> newly added files show up as untracked files.
> But in this case those files in those subdiretories won't.

The problem is the recursive way in which git applies those patterns.
Your patterns above mean that git never recurses into the subdirs.

In the example above, you probably want

/a_dir/b_dir/*
!/a_dir/b_dir/c_dir/

Cheers,
Michael

P.S.: Please don't cull cc:
