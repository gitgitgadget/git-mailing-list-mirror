From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Tue, 2 Jan 2007 10:39:05 -0800 (PST)
Message-ID: <666730.12167.qm@web31802.mail.mud.yahoo.com>
References: <7vodpiytue.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Jan 02 19:39:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1oXZ-00027p-Vt
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 19:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbXABSjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 13:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbXABSjJ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 13:39:09 -0500
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:46277 "HELO
	web31802.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753569AbXABSjI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jan 2007 13:39:08 -0500
Received: (qmail 13152 invoked by uid 60001); 2 Jan 2007 18:39:05 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=AS2zsUSlAlNMzoJqpIjrAK150vhWetm7ryWCL/9v7x0Gm+T/rjhRK/lW9OlwnEqbcwjaPac9kCsX9NqqQ5gT6ODdE6Gb9ixxkEsJkEHxzKy0z1u1hICyuCza/ukp9X5M+bnQnKeuLzfQW8j6rGUx2rKFQHsZnk2Qebz9jajYKSQ=;
X-YMail-OSG: .Qoph7wVM1lKygEoQV_u5A5.LfuPAIPY3YwzZ2tlUVidg..VhU7Fx5VowB0Ubs4K7vBBSHlT9LowoSTUKxP97Ejyamwxl4hLRm83RCLd9p83gLPtYs5osFgK7IkY4x_TYJ99mKQhwug-
Received: from [71.84.31.238] by web31802.mail.mud.yahoo.com via HTTP; Tue, 02 Jan 2007 10:39:05 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodpiytue.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35795>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > It is in this sense that I do "cd <branch>; git-pull . <branch>"
> > in a sequence, and I'd rather do "cd <branch>; git-pull <symbolic-ref>"
> > to define which branch is the merge coming from given the current branch
> > _and_ the symbolic ref.
> 
> If I am reading you correctly, you have multiple directories,
> each with its own .git/ directory but major parts of these .git/
> directories are shared (namely, objects/ and refs/).  You would
> not be able to have separate checkout in these directories if
> you shared .git/HEAD and .git/index, so at least each of these
> directories has these two files for its own.
> 
> Is that what you are doing?

Yes, but the _ONLY_ thing which is NOT shared is .git/HEAD and
.git/index.  EVERYTHING else is the _same_ in all branch-per-directory.

> If that is the case, I think you do not even have to have the
> "branch spec" to express the patchflow among them.  Essentially
> you are using "one branch, one directory, one repository"
> workflow (my understanding is that this is how BK worked but I
> haven't seen it) but with your own improvements.  The reason
> this is an improvement is because such a shared .git/refs/
> allows you to do diff and log across branches this way, so if
> you have a separate .git/config just like you already have
> separate .git/HEAD and .git/index in these directories, you can
> use [remote "xyz"] sections in each of them to achieve what you
> called 'symbolic'.

Yeah, but I do not want to introduce yet another non-shared
file -- namely the config.

I want the config to be shared as well, since the repo is
exactly the same.  Firthermore, the branches are branches of
the same repo, not of different one.  config should be one
and the same -- per repo.

   Luben
