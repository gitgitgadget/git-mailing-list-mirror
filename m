From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: filter-branch --all?
Date: Mon, 24 Mar 2008 22:22:46 +0100
Message-ID: <263C0D8D-0454-402A-B65C-08E91F7BD5C7@orakel.ntnu.no>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil> <47E298A5.6050508@nrlssc.navy.mil> <alpine.LSU.1.00.0803201812560.4124@racer.site> <7vr6e01xja.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241152050.4353@racer.site> <7viqzc18j9.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241609540.4353@racer.site>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:24:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdu96-0004ny-1X
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 22:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176AbYCXVWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 17:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755224AbYCXVWw
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 17:22:52 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:61897 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176AbYCXVWu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 17:22:50 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 90F3F1479CF;
	Mon, 24 Mar 2008 22:22:47 +0100 (CET)
In-Reply-To: <alpine.LSU.1.00.0803241609540.4353@racer.site>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78100>

On 24. mars. 2008, at 16.10, Johannes Schindelin wrote:

[Regarding filter-branch rewriting tags]

> You can say "--all", and I actually expect quite a few people to do
> exactly that.  And then you cannot really say "the user explicitely  
> asked
> to have that signed tag rewritten".


Sorry to hijack the thread.  I've seen you mention using "--all" to  
filter-branch everything before, but I can't get it to work:


	% git filter-branch --all
	Usage: /usr/local/bin/git-filter-branch [--env-filter <command>] [-- 
tree-filter <command>] [--index-filter <command>] [--parent-filter  
<command>] [--msg-filter <command>] [--commit-filter <command>] [--tag- 
name-filter <command>] [--subdirectory-filter <directory>] [--original  
<namespace>] [-d <directory>] [-f | --force] [<rev-list options>...]


I'm trying to rewrite history to match .git/info/grafts without going  
through every graft, hence the lack of an actual filter command.   
Thinking that might be the problem, I also tried the "update-index -- 
remove <filename>" example, but it wouldn't let me use "--all" either:


	% git filter-branch --index-filter 'git update-index --remove RELEASE- 
NOTES' --all
	Usage: /usr/local/bin/git-filter-branch [--env-filter <command>] [-- 
tree-filter <command>] [--index-filter <command>] [--parent-filter  
<command>] [--msg-filter <command>] [--commit-filter <command>] [--tag- 
name-filter <command>] [--subdirectory-filter <directory>] [--original  
<namespace>] [-d <directory>] [-f | --force] [<rev-list options>...]


as opposed to:


	% git filter-branch --index-filter 'git update-index --remove RELEASE- 
NOTES' HEAD
	Rewrite 266da463b4e59eaf06287b36b6435b8218db9f40 (611/4040)
	^C


git version 1.5.5.rc0.10.g7881f.dirty (the dirtiness is in git- 
submodule.sh, and I've tried it with older, cleaner versions).

Am I just stupid and/or crazy, or does it not work?
-- 
Eyvind Bernhardsen
