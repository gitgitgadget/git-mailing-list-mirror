From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: Verilog/ASIC development support is insufficient in git , help!
Date: Sun, 11 May 2008 11:21:57 +0200
Message-ID: <46d6db660805110221y1207974dt3be709e1b67cf3d6@mail.gmail.com>
References: <EB66C79C87CF49E59CB39EA4C286AE05@justinuTop>
	 <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, justin0927@hotmail.com
To: "Justin Leung" <jleung@redback.com>
X-From: git-owner@vger.kernel.org Sun May 11 11:23:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv7lx-0004Cs-EN
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 11:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbYEKJWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 05:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbYEKJV7
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 05:21:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:61505 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbYEKJV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 05:21:58 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2805283waf.23
        for <git@vger.kernel.org>; Sun, 11 May 2008 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CeHSB7kMFulK0VRUtuYwMiWc4t8WZ71cFF/vMTL0I2k=;
        b=sS4P3JMbS18jMj/21vRzSZxUA2UVqNYtt5oT7LEL16PGe7LjUlUdTITBLpzC7e5tG5bRZ7OnG3Dv+t++ZceDy9rg3f3c7bHGHrKBc1uOuTCzQHoCY7F9E7uTDTHju902ESp/KkcNFdu/LcnUpbfCbMsOLOHKi7hQgPYXZ6ED9sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kPavNfen7n4W1QY4Rm7KShsuDPsa0usafbFWbvAt69pOMrGPvozL/B/GOxT+/lYaFkA/+eA/ES8JGMFuYBi59O2ve2Z7Oq1uly6zu6SQW0P3+okzurN5NJO29NLI8R1uUg/4OO/VJEa/M+de7cxugsNCEzuhsmbttmk8shp7DaE=
Received: by 10.114.13.1 with SMTP id 1mr6224473wam.60.1210497717941;
        Sun, 11 May 2008 02:21:57 -0700 (PDT)
Received: by 10.115.33.10 with HTTP; Sun, 11 May 2008 02:21:57 -0700 (PDT)
In-Reply-To: <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81752>

On Sun, May 11, 2008 at 7:08 AM, Justin Leung <jleung@redback.com> wrote:
> Hi all,
>
> * This email probably represent the whole hardware ASIC community about git
> *

I'm an ASIC designer too.

> here are the things not fitting right in ASIC dev:
>
> - no incremental revision numbers (they are so scared of the 40hex SHA1)

this is unimportant: if they want to track a specific release of a
file, it's better to look at what was the file's content from this cut
to that cut.

>
> - Inability to reference without SHA1, they want simple numbering (ie,
> version 100, 120, 120.1, 130.4.5)

this is where tags and branches are useful to point to a specific release/cut.

>
> - Inability to refer to a file by a simple number
> (the backend guys will be confused by SHA1; they can't work with anything
> more than 4-5 digits)

same answer

>
> - Complexity of commands (although we can have warpper, but real git
> commands for non-sw guys is not going to happen)

just use gitk and git-gui: almost all can be done with these two
graphical tools.

>
> Most hardware chip designers were using CVS since their first job.
> It suited the purpose very well.

for linear development, yes. but when we were requested to perform
maintenance on a specific old cut, this was becoming a nightmare.

>
> Most RTL design veterans only use less then 5-6 cvs commands in their whole
> life (LOL, i m serious) :
>
> $ cvs checkout
> $ cvs update
> $ cvs log
> $ cvs diff (tkdiff)
> $ cvs status
> $ cvs commit

gitk, git-gui: two commands (actually gitk can be called from git-gui)

>
> We don't use branches.

this is the wrong approach.

> Our model is strict forward with a centralized, one main branch model to
> avoid mistakes .
> We see branches as evil ; some merges in Verilog codes means another 10+
> hours of simulation and regression.

use branches to reference the different ressources (rtl, simulation, layout).
then track these branches between them for deliveries and work/flow.

use tags to mark specific releases/cuts.

> - 'git-show-branch' actually show reversed serialized version numbers (we
> want it the other way, accending)

you can create an alias: git-show-branch | tail -r

> - 'git-describe' gives you commit numbers since your last annotated tags (
> ie, git-5423-g7def45b)
>
> so, i understand that a simple numbering scheme can be done .

yes, I used to be scared by sha1 too: I even created numbered tags for
each commit. Until I read more about git, and stopped expecting using
git as svn/cvs.

>
> I truly hope that the in the main repository model of git this can be turned
> on by a switch or in the git config .

no, it would kill the right approach: embrace the index, and never look back.

>
> Is it too complicated to incorporate this model ?

you have to adapt your methods instead: trust another ASIC designer :-)

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
