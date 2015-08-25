From: John Keeping <john@keeping.me.uk>
Subject: Re: index file list files not found in working tree
Date: Tue, 25 Aug 2015 11:32:14 +0100
Message-ID: <20150825103214.GH1412@serenity.lan>
References: <55DAF343.2050908@gmail.com>
 <55DC408B.5030804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rafik E Younan <rafik.arkdev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 12:41:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUBfe-0005om-6E
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 12:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbbHYKlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 06:41:35 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:35856 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485AbbHYKle (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 06:41:34 -0400
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Aug 2015 06:41:34 EDT
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 227B12DFD5;
	Tue, 25 Aug 2015 11:32:21 +0100 (BST)
X-Quarantine-ID: <Qf0KTnhDXOH2>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Qf0KTnhDXOH2; Tue, 25 Aug 2015 11:32:20 +0100 (BST)
Received: from serenity.lan (griffin.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 512972DEE4;
	Tue, 25 Aug 2015 11:32:16 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <55DC408B.5030804@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276517>

On Tue, Aug 25, 2015 at 12:16:43PM +0200, Rafik E Younan wrote:
> I got a recommendation to use reset --hard. I tried it and it says the 
> HEAD is now at correct commit, but missing files are not restored!
> 
> I tried `ls-tree --name-only` and it lists missing files and folders, 
> but the actual working tree doesn't have these files and folders.

Is there any chance that you have enabled sparse checkouts?  See the
documentation at the bottom of git-read-tree(1).

> On 08/24/2015 12:34 PM, Rafik E Younan wrote:
> > Hi,
> >
> > After several merges and rebases I finally got my branches and history 
> > to reflect valid commits and proper history. Everything is pushed to 
> > internal bare repo and the remotes seems OK.
> >
> > When I clone the updated repository, all branches reflect the correct 
> > updated trees and blobs.
> >
> > The problem occurs only on the original local repository where all the 
> > merging and re-basing took place!
> >
> > When I checkout a branch, several files and folders are deleted from 
> > the working tree. When I examine the history of these files, there are 
> > only commits of adding them and modifying them but no log for deleting 
> > them, and they aren't deleted when I checkout the same branch in 
> > another fresh cloned repo.
> >
> > Git status command doesn't indicate any changes in these files. I 
> > found the files and folders names in the `.git/index` file. So after 
> > manually removing the `.git/index` file and usinge `git reset` 
> > command, `git status` indicates that the files and folders are deleted.
> >
> > I use `git checkout -- <File_or_folder_names>...` and restore all 
> > missing files and folders, just then the working tree matches the 
> > fresh checkout of the same branch on any other cloned repo.
> >
> > After examining the tree object of the current commit, all files and 
> > folders exists, although clearly the checkout missed some of them!
> >
> > Because the repository is local and private, I can't share any url for 
> > publicly accessible repository, and if one exists, no problem could be 
> > found, because the problem resides in just this certain local clone.
> >
> > Answering the following questions might give some clues for the problem:
> > * How does git populate the index file after every branch checkout?
> > * Is there any object to reflect the content of the index file?
> >
> > I would appreciate any pointers for where the problem could be.
> >
> > Thanks,
> > Rafik
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
