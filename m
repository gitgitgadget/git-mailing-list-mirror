From: david@lang.hm
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 16:20:07 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic> <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic> <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
 <20090405225954.GA18730@vidovic>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 01:21:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqbew-0003l4-Pc
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 01:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbZDEXUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 19:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbZDEXUT
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 19:20:19 -0400
Received: from mail.lang.hm ([64.81.33.126]:50404 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbZDEXUS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 19:20:18 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n35NK7YO027787;
	Sun, 5 Apr 2009 16:20:07 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20090405225954.GA18730@vidovic>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115735>

On Mon, 6 Apr 2009, Nicolas Sebrecht wrote:

> On Sun, Apr 05, 2009 at 02:28:35PM -0700, david@lang.hm wrote:
>
>> guys, back off a little on telling the gentoo people to change.
>
> Don't blame Git people, please. I currently am the only one here to
> discuss that way and see a painful work coming at Gentoo.
> Git people didn't discuss around thoses issues.
>
>>                                                                 the
>> kernel developers don't split th kernel into 'core' 'drivers' etc pieces
>> just because some people only work on one area.
>
> And you might notice that they don't provide a CVS access and actually
> don't work around an unique shared repo. Also, you might notice that
> keeping the history clean to assure the work on the kernel easier is not
> an elementary issue.

these issues are completely seperate from the issue that the initial 
poster asked about, which is that when someone tries to do a clone of the 
repository the system wastes a lot of time creating a new pack.

the kernel has a central public repo, they could run the cvs server on 
that and still keep the rest of the kernel development exactly the way it 
is.

if they are currently planning for one central repo with everyone pushing 
to it, I expect that they will change their workflow as they get used to 
git, but that isn't going to address the problem in the tool.

>> just because some people only work on one area. I see the gentoo desire
>> to keep things in one repo as being something very similar.
>
> That's why I think the gentoo desire is not very clean (don't be
> affected). What I see is that in one hand you want a DSCM and on the
> other hand you want to keep a central shared repo.

don't worry about this part of things, worry about why the server wastes 
so many resources.

if this is really what's happening, other projects will suffer as well 
(including the kernel, which has a very distributed workflow)

>> the problem here is a real one, if you have a large repo, git send-pack
>> will always generate a new pack, even if it doesn't need to (with the
>> extreme case being the the repo is fully packed)
>
> What about the rsync solution given in this thread?

that may be a work-around for a situation where git just doesn't work, but 
how do they prevent users from killing their server by trying to do a 
normal git clone?

Daivd Lang
