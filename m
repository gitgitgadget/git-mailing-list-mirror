From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Subtree with submodule inside?
Date: Thu, 7 Aug 2014 18:07:25 +0200
Message-ID: <20140807160725.GA22597@fair.fritz.box>
References: <CAHd499CaCeHYGZSQeY8MRVnnjXBTgDy=OUqBYqNd1e5GiKre_A@mail.gmail.com>
 <xmqqk36lmrpl.fsf@gitster.dls.corp.google.com>
 <CAHd499AmY+EYXAK8h_oYiOn-amnNrE1+a7qsQ4x7bCOVsJDxcw@mail.gmail.com>
 <53E28CAB.4040800@web.de>
 <20140806220832.GA12427@google.com>
 <xmqqr40tkxcp.fsf@gitster.dls.corp.google.com>
 <20140806235152.GB12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Robert Dailey <rcdailey.lists@gmail.com>,
	Git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 18:07:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQE7-0007LA-4k
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbaHGQHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:07:35 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.103]:54153 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089AbaHGQHf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:07:35 -0400
Received: from [37.4.179.65] (helo=fair.fritz.box)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1XFQDz-0005Gk-5t; Thu, 07 Aug 2014 18:07:31 +0200
Content-Disposition: inline
In-Reply-To: <20140806235152.GB12427@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254962>

On Wed, Aug 06, 2014 at 04:51:52PM -0700, Jonathan Nieder wrote:
> Junio C Hamano wrote:
> > Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >>  2. Submodules aware of their superproject and of the parent's branches.
> >>     In other words, submodules would act as though under refs/ they
> >>     had a symlink
> >>
> >> 	parent -> ../../../refs
> >>
> >>     So you could do
> >>
> >> 	git checkout --recurse-submodules master
> >>
> >> 	cd path/to/submodule
> >> 	git checkout parent/heads/next
> >>
> >>     This would avoid danger from "git gc" in submodules and would
> >>     get rid of most of the motivation for named branches in the
> >>     submodule, I'd think.
> >
> > Are you assuming that they share their object stores?
> 
> No.  The 'symlink' thing is a think-o.  (When trying to explain the
> idea I ended up oversimplifying and speaking nonsense.)
> 
> What I wanted to say is that parent/heads/next would be a way to
> refer from the submodule to the same commit as
> 
> 	refs/heads/next:path/to/submodule
> 
> refers to in the parent.

I like this idea. It could solve many issues and help in many cases I think.
Since we are currently quite busy with other things I took the liberty of
adding an ideas section in Jens submodule wiki[1]. This way we do not forget
about it and/or can refer others to it more easily.

I would appreciate if someone could have a look whether I described the idea
clearly enough.

Cheers Heiko

[1] https://github.com/jlehmann/git-submod-enhancements/wiki#dynamic-superproject-refs-in-submodules
