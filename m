From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Intricacies of submodules [was: Migrating svn to git with	heavy
 use of externals]
Date: Thu, 10 Apr 2008 12:27:33 -0700
Message-ID: <1207855653.13123.257.camel@work.sfbay.sun.com>
References: <47F15094.5050808@et.gatech.edu>
 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
 <47FBDA77.2050402@et.gatech.edu>
 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
 <46dff0320804100907w5240b79bga3acad9fb8ecb353@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 21:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk2KR-0002Dd-Ew
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 21:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbYDJTUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 15:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbYDJTUO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 15:20:14 -0400
Received: from sca-es-mail-1.Sun.COM ([192.18.43.132]:33939 "EHLO
	sca-es-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbYDJTUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 15:20:13 -0400
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3AJKCgw029340
	for <git@vger.kernel.org>; Thu, 10 Apr 2008 12:20:12 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZ400801IUZI200@fe-sfbay-10.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Thu, 10 Apr 2008 12:20:12 -0700 (PDT)
Received: from [129.146.84.200] by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0JZ400D8IJ1NHL80@fe-sfbay-10.sun.com>; Thu,
 10 Apr 2008 12:20:11 -0700 (PDT)
In-reply-to: <46dff0320804100907w5240b79bga3acad9fb8ecb353@mail.gmail.com>
X-Mailer: Evolution 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79242>

On Fri, 2008-04-11 at 00:07 +0800, Ping Yin wrote:
> On Thu, Apr 10, 2008 at 11:43 AM, Roman Shaposhnik <rvs@sun.com> wrote:
> > Hi Junio!
> >
> 
> >      * Has an idea of having a regular file (subject to having history,
> > etc.)
> >        called something like .gitconfig at the top level of Git's repository
> > ever
> >        been considered (implemented?). That way you a repository maintainer
> >        would be able to force a particular set of settings on all of its
> > clones
> >        yet clones will be able to override then in .git/config if needed.
> >
> 
> I like this idea, it's another common/special requirement just like
> .gitignore vs. $GIT_DIR/info/exclude.

Well, I guess if enough of us like it there's a chance it can be
implemented, right? ;-)

To some extent it seems that you've solved this particular issue for 
submodules with your PATCH/RFC 3/7. Now, in a general case, if 
git-config(1) can be patched to take into account one extra place
for retrieving options from (.gitconfig) it seems that
retiring .gitmodules completely would be just one benefit of many.
Other benefits would include propagating setting like most of the
core.* and quite a few other things I see listed in git-config(1)
man page.

It seems that the only downside here would be a need for a bit
of special handling when a setting needs to be recorded. Otherwise
it looks like a pretty clean and general idea.

Thanks,
Roman.
