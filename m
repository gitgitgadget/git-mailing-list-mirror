From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Fri, 18 Jul 2008 11:41:11 +0400
Message-ID: <20080718074111.GL2925@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <alpine.DEB.1.00.0807161902400.8986@racer> <32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com> <alpine.LNX.1.00.0807161605550.19665@iabervon.org> <861w1sn4id.fsf@lola.quinscape.zz> <m3od4wse30.fsf@localhost.localdomain> <86k5fk1ooq.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 09:42:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJkbv-00061g-Mi
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 09:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbYGRHl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 03:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756689AbYGRHlZ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 03:41:25 -0400
Received: from gv-out-0910.google.com ([216.239.58.191]:62448 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916AbYGRHlX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 03:41:23 -0400
Received: by gv-out-0910.google.com with SMTP id e6so53666gvc.37
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 00:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=O6afOqX41ko6YoH48HaJrX3eOOMTVCkrxsQuAteP4Lg=;
        b=Kobr1Mk9KF69ZKqrQUa6jJ73pfqoOcmLhOo8Y8A2J76DiMMP0SuSekBcQDHnHhLnIh
         +0rChyGx8vNufHIxmRiCrODZOekr2fZlueL4eIsIO2TazhvG1RwxBZ9aufoZR83L4tCg
         5rYLUHm/O2YUnVEuySwGY5vvgkzzXrubQlmBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VlBD96h52HGD8jvFK1qHNVmxrzuaXL5yPZnciAIhLjYaLac/+vmTINkEjuBm7boY0m
         w6YiWp6Qikf2hzj86zn0agT70HJFVOHIZjFcv7o4ifGX6jarEqTDHbDK3PQdh0HICti/
         G/Qpdtrh2gtw2ZoALf47E72o2Sm6TKme+GUpM=
Received: by 10.103.12.8 with SMTP id p8mr2699491mui.102.1216366879297;
        Fri, 18 Jul 2008 00:41:19 -0700 (PDT)
Received: from localhost ( [85.140.168.212])
        by mx.google.com with ESMTPS id y37sm7911885mug.9.2008.07.18.00.41.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 00:41:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <86k5fk1ooq.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89003>

On Thu, Jul 17, 2008 at 06:05:25PM +0200, David Kastrup wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Distinguishing between branch part of directory name by _convention_
> > is design mistake; the fact that the tool doesn't help to ensure that
> > (a) tags lie on branch (b) tags _doesn't change_ is an example of this
> > stupidity.
> 
> How much have you worked with Subversion so far?  I am doing quite a bit
> of work with it, and the do-everything-via-copying paradigm does not get
> in my hair.  It actually means that I have to remember fewer commands.
> And it is pretty easy to understand.

Staying on trunk, try to compare your files foo and bar with version
1.0. With Git, it is simple
git v1.0 -- foo bar
but I don't think you can do that so easily with SVN.

But the real problem with the do-everything-via-copying paradigm is
that now revisions do not identify anything meaningful without some
path. This leads to problems if you try to implement merge. In Git,
it is simple -- merge is a commit with more than one parent. You cannot
do like that in SVN. Instead, you have to track merges per file. This
is not just waste of resources, but this merges is very difficult if
not impossible to visulize in any useful way. But if you cannot see
something, you cannot control it well. So, not accidently, in systems
with inter-file branching, creating feature branches is discouraged.

Besides having fewer commands doesn't necessary mean easier to learn
or to use. If you have one command that conflates different concepts,
it is usually more difficult than having a devote command per concept.

Can you remove the concept of branches and merges and have your VCS
still useful? Well, you can say "we don't use branches, every developer
commits directly on trunk". The consequence of that choice is that a lot
of work-in-progress code is pushed to trunk. But no one has the perfect
foresight. Some ideas will turn out to be not so good. Some developers
will not finish their work and will be reassigned to more urgent tasks.
As result, just as release time approaches, you have a lot of unfinished
crap in your trunk. Of course, if you don't care about quality of your
software, it may be easier for you to work in this way.

However, if you do care about quality, you have to use feature branches
for WIP, and for this workflow to work, you need that merging is really
easy.  Git makes that for you, yet you may need to learn new concepts --
branching and merging.  Thus comparision of what is easier or difficult
is meaningless without defining goals. It is always easy to be sloppy
and don't care...

Dmitry
