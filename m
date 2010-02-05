From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How can I tell if a file has been updated upstream?
Date: Fri, 5 Feb 2010 08:44:07 -0800
Message-ID: <20100205164407.GA27498@spearce.org>
References: <ed82fe3e1002050823gec57827j184c9c4cff4f4a45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 17:44:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdRI2-0000wH-AT
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 17:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab0BEQoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 11:44:12 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:37776 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0BEQoL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 11:44:11 -0500
Received: by iwn27 with SMTP id 27so53692iwn.5
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 08:44:10 -0800 (PST)
Received: by 10.231.151.207 with SMTP id d15mr2519879ibw.44.1265388250427;
        Fri, 05 Feb 2010 08:44:10 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm1191483iwn.15.2010.02.05.08.44.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Feb 2010 08:44:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ed82fe3e1002050823gec57827j184c9c4cff4f4a45@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139056>

Timur Tabi <timur@freescale.com> wrote:
> Is there a way for me to tell if a particular file in my repository
> has an update in the upstream repository?  For example, the SHA of the
> HEAD is different in the remote repository than it is of the HEAD in
> the local repository.
> 
> The reason I ask is that I have a set of Python scripts that I
> distribute via git (other people in the company clone my repository).
> I want my script, every time it's run, to check if an update is
> available, and ask the user to do "git pull".

You can't tell a particular file, but you could use something like
`git ls-remote refs/heads/master` to see what the branch is at,
and compare that to the last known commit.  If its changed, then
suggest the user do a fetch.

I do this in repo, only I run `git fetch` once per day for the
end-user.  That way the objects are local, and I can use a local
check to see if there are updates that need to be pulled into the
executable working directory.

-- 
Shawn.
