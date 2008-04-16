From: "Roman V. Shaposhnik" <rvs@sun.com>
Subject: Re: Intricacies of submodules
Date: Tue, 15 Apr 2008 20:49:55 -0700
Message-ID: <1208317795.26863.91.camel@goose.sun.com>
References: <47F15094.5050808@et.gatech.edu>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
 <1207859579.13123.306.camel@work.sfbay.sun.com>
 <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
 <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com>
 <7vmyo0owep.fsf@gitster.siamese.dyndns.org> <1207970038.10408.8.camel@ginkgo>
 <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
 <1208202740.25663.69.camel@work.sfbay.sun.com>
 <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Ping Yin <pkufranky@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:36:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlyVT-0004HM-M5
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 05:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbYDPDji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 23:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754305AbYDPDji
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 23:39:38 -0400
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:51059 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237AbYDPDjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 23:39:37 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3G3dZvp029000
	for <git@vger.kernel.org>; Tue, 15 Apr 2008 20:39:35 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZE00L01FCN1C00@fe-sfbay-09.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Tue, 15 Apr 2008 20:39:35 -0700 (PDT)
Received: from [192.168.0.103] ([76.21.110.21])
 by fe-sfbay-09.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb
 28 2007)) with ESMTPSA id <0JZE002QYFHZIE40@fe-sfbay-09.sun.com>; Tue,
 15 Apr 2008 20:39:35 -0700 (PDT)
In-reply-to: <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79653>

On Mon, 2008-04-14 at 18:13 -0700, Junio C Hamano wrote:
> Roman Shaposhnik <rvs@sun.com> writes:
> 
> >> Don't get me wrong.  I am not saying that everybody should start rolling
> >> their own "sane environment setup script" and ship their project with it.
> >> I am only suggesting it as a possible way to do your "policy enforcement"
> >> without having to introduce in-tree .gitconfig, which I unfortunately see
> >> no fundamental upsides but definite downsides (security included).
> >
> > And here comes my question: could you, please, elaborate on *technical*
> > drawbacks of in-tree .gitconfig (such as security that you've
> > mentioned).
> 
> Just to name a few, as I do not see a point in spending time elaborating
> in detail when there is an alternative without such security downsides.
> 
> One of your examples was about a forced use of custom merge tool.
> Consider in-tree .gitconfig that is always read for everybody that
> describes such a tool.  A malicious script named there is a security risk
> for people who clone such a project.  A smudge filter is even worse, as it
> kicks in the minute you try to check out the project.

I'm sorry, but I don't buy this argument. If you have a malicious user
gaining access to the repository all bets are off. To single out 
in-tree .gitconfig as the only place which could be hacked seems to
be a bit shortsighted and unfair. Any "executable" portion of your
project that rarely gets eyeballed (such as Makefile infrastrucutre)
could be used. In fact, under your scenario in-tree .gitconfig is
likely to be the least of your worries. 

And here's one more thing: in-tree .gitconfig and in-tree 
update-my-git-settings.sh are absolutely identical as far
as their security ramifications are concerned. If you really paranoid
you have to eyeball either of them.

> These executable (not just merge tool or attribute filters) are designed
> to be named by .git/config exactly because .git/config is designed to be
> personal (i.e. "that _particular repository only_") and you can afford to
> be environment and platform specific there.  If you start describing them
> in in-tree .gitconfig, they must be cross platform and (worse yet)
> you have to make sure they are installed everywhere.

I don't buy this argument either. First of all, there's a $PATH. On top
of that even automounters learned how to deal with heterogeneous
hosts efficiently ($HOST, $CPU, etc.) so I really don't think Git should
have any problems. But the most obvious counterargument to your
statement would be that quite a few developers (myself included) don't
have a luxury of developing on a single architecture. Thus in-tree
.gitconfig doesn't change anything -- *my* single Git repository has to
provide settings that work on: [sparc|intel]-[Solaris|Linux]. I do
have .git/config that accomplished that. I see no reason for in-tree
.gitconfig to not be able to.

> I'm too lazy to make a laundary list of what you can have in .git/config
> with the current system (see Documentation/config.txt), but that part of
> the system is built around the design that the configuration is specific
> to the repository (and sharing what the user records in ~/.gitconfig
> across repositories is in line with it).
> 
> Unless you are willing to sift through all of them, mark which ones can be
> overriden by in-tree .gitconfig and which ones cannot, and implement an
> easy to use (by both the developers and the users) mechanism to enforce
> the distinction, just changing the git_config() function to read from one
> new place (i.e. in-tree .gitconfig) would not be a sufficient solution for
> what you seem to want to do.

Why? I'm really confused here. Unless I'm given a clear example of at
least one setting that somehow becomes dangerous when stored inside
in-tree .gitconfig, I really do consider such an enforcement to be
as meaningful as enforcing that Git MUST manage source code and nothing
else. You seemed to mention the trust issue. Well, why don't you trust
the user to place whatever he wants in in-tree .gitconfig? And yes,
we are talking about trustworthy users here and repositories that
haven't been compromised.

Thanks,
Roman.

P.S. Junio, I really don't want to waste your time especially since
I get a feeling that our discussion has clearly moved into a domain
of taste and preferences. But I had to refute your security and 
heterogeneity arguments simply because they don't seem to have any
substance to them.
