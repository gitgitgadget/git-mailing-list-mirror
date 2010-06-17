From: William Hall <will@gnatter.net>
Subject: Re: SVN migration
Date: Thu, 17 Jun 2010 11:33:43 +0100
Message-ID: <4C19FA07.9010603@gnatter.net>
References: <4C1957EF.6070504@gnatter.net> <7B0F34CE-9C9F-4FC3-AD96-8B1B8DD4359B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 12:33:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPCQ3-0000sN-Kj
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 12:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759749Ab0FQKdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 06:33:53 -0400
Received: from mail.qualtersystems.com ([74.200.89.103]:52406 "EHLO
	mail.qualtersystems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759735Ab0FQKdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 06:33:52 -0400
Received: from localhost (mail [127.0.0.1])
	by mail.qualtersystems.com (Postfix) with ESMTP id 6169339607E7;
	Thu, 17 Jun 2010 11:33:51 +0100 (BST)
X-Virus-Scanned: amavisd-new at qualtersystems.com
Received: from mail.qualtersystems.com ([127.0.0.1])
	by localhost (mail.qualtersystems.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z2OenMKwIqgP; Thu, 17 Jun 2010 11:33:46 +0100 (BST)
Received: from merton.mpc.local (mpc-1.sohonet.co.uk [193.203.82.226])
	(Authenticated sender: will@mail.qualtersystems.com)
	by mail.qualtersystems.com (Postfix) with ESMTP id 6E98539507DB;
	Thu, 17 Jun 2010 11:33:45 +0100 (BST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <7B0F34CE-9C9F-4FC3-AD96-8B1B8DD4359B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149296>

Thanks Steven,

The noMetadata option will prevent me from doing anything other than a 
one-shot import, which is not what I want. I need to somehow devise a 
workflow that allows me bidirectional push/pull between an svn repo and 
a remote git repo.



Steven Michalske wrote:
> On Jun 16, 2010, at 4:02 PM, William Hall wrote:
> 
>> The issue is the dcommit operation from the bridge. The rebase part of this re-writes the commit messages to include the SVN commit-ids which is nice, but screws up the push/pulls between the bridge and the bare repo.
> 
> Look into svn.noMetadata configuration option.  It will prevent you from rebuilding the svn to git bridge if something seriously goes wrong, but it prevents the messages from changing.
> 
> svn-remote.<name>.noMetadata
> This gets rid of the git-svn-id: lines at the end of every commit.
> If you lose your .git/svn/git-svn/.rev_db file, git svn will not be able to rebuild it and you won't be able to fetch again, either. This is fine for one-shot imports.
> The git svn log command will not work on repositories using this, either. Using this conflicts with the useSvmProps option for (hopefully) obvious reasons
