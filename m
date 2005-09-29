From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Really happy with cogito for inhouse teamwork, now that I've figured out cg-clone...
Date: Thu, 29 Sep 2005 17:15:35 +0200
Message-ID: <200509291715.35317.Josef.Weidendorfer@gmx.de>
References: <46a038f905092822587f5414d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 29 17:17:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL08a-0006HJ-14
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 17:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVI2PPu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 11:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVI2PPu
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 11:15:50 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:11991 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932186AbVI2PPt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 11:15:49 -0400
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 6D5A0273E
	for <git@vger.kernel.org>; Thu, 29 Sep 2005 17:15:48 +0200 (MEST)
To: Git Mailing List <git@vger.kernel.org>
User-Agent: KMail/1.8.2
In-Reply-To: <46a038f905092822587f5414d4@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9484>

On Thursday 29 September 2005 07:58, Martin Langhoff wrote:
> Doing the checkout the 'right' way:
>  $ cg-clone git+ssh://locke.catalyst.net.nz/var/git/project.git#branchname
> localdirname
>
> Work cycle:
>  # work work work
>  $ cg-commit
>  $ cg-update
>  $ cg-push

Yes, this works very well here, too.
And it works officially since cg-push allows to push on a
non-master remote head (based on git's advanced push allowing mapping of 
different head names on local and remote side).
[Before, I used a hack in cg-clone: with e.g. cloning remote head "rem",
symlink local master to a local "rem". This was working quite fine, too]

The following is equally fine (smaller work per commit, with lot more commits
relative to the pushing to the central rep - gives more documentation
on the development history):

# work
$ cg-commit
# work
$ cg-commit
# work
$ cg-commit
$ cg-update
$ cg-push

Aditionally, we have in the central repository a head per developer,
to publish experimental/instable work, and they are regularly merged
back into the central master.

The key to simplicity is here, to have one clone for every remote head.
Introducing Git/Cogito to other people this way almost needs no tutorial at 
all.

This is complemented by an automated mail to a project mailing list
via use of the update-hook in the central repository, so that every
developer is kept up-to-date on work of others. The mail is
formatted to include URLs for every commit to a matching
gitweb interface. Was really easy to setup and quite handy.

Josef
