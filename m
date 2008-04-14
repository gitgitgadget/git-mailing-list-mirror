From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Intricacies of submodules
Date: Mon, 14 Apr 2008 12:52:20 -0700
Message-ID: <1208202740.25663.69.camel@work.sfbay.sun.com>
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
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Ping Yin <pkufranky@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 21:53:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlUgh-0004B5-BE
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 21:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756816AbYDNTtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 15:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753801AbYDNTtO
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 15:49:14 -0400
Received: from sca-es-mail-1.Sun.COM ([192.18.43.132]:60072 "EHLO
	sca-es-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbYDNTtN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 15:49:13 -0400
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3EJnC4R011748
	for <git@vger.kernel.org>; Mon, 14 Apr 2008 12:49:12 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZB00501YPRAY00@fe-sfbay-10.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Mon, 14 Apr 2008 12:49:12 -0700 (PDT)
Received: from [129.146.84.200] by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0JZB006PQZ207WA0@fe-sfbay-10.sun.com>; Mon,
 14 Apr 2008 12:49:12 -0700 (PDT)
In-reply-to: <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79528>

On Fri, 2008-04-11 at 22:11 -0700, Junio C Hamano wrote:
> Roman Shaposhnik <rvs@sun.com> writes:
> 
> > ... Contrast this with .gitconfig where policies get
> > enforced right from the minute your clone operation finishes and there's
> > much less opportunity for the user to shoot himself in the foot.
> 
> Why?  Even if you expect .git/config in a new repository would be vanilla
> (which you can't really, as crazy sysadmin can have /etc/gitconfig or
> template to override what you do), $HOME/.gitconfig would be in effect the
> minute you clone.

I think I understand where you are going with this. Although, truth be
told, to me ~/.gitconfig is much less of a concern. Why? Well, because
by definition if the user is smart enough to edit ~/.gitconfig I'm
not concerned about him. As I pointed out my main concern is about
junior developers for whom the only way to screw things up would
be to have a global /etc/gitconfig, which is still quite rare.

> As you cannot reasonably expect that your project is the _only_ project
> your cloners would use, you cannot dictate what $HOME/.gitconfig has.

See, that's exactly why I would love to have in-tree .gitconfig ;-) 
~/.gitconfig is not flexible enough to have settings for multiple
projects and .git/config needs to be managed by scritps. In-tree
.gitconfig just works.

> A policy issue needs to be addressed at the human level anyway, so I do
> not really see major difference either way.  You need to trust your users
> to follow the guideline at some point, and all you can do is to make it
> easy for them to do so, and (optionally) verify that they are actually
> following the guideline.  We need to suggest an easy-to-use and robust
> mechanism to allow you to do so as the BCP.

And that's where it becomes a matter of preference. I can now see your 
point very clearly and I tend to slightly disagree with it. But! This
is definitely not a technical issue anymore (in-tree .gitconfig and
in-tree shell script for managing .git/config are technically 
equivalent). So, I think I don't have any more arguments to add to the
discussion. I do have one question left (see bellow) and one comment 
to make: my experience has been that it is much easier to trust
volunteer and open source developers compared to corporate ones. 
I do get it 100% that Git is "for the kernel folks; by the kernel folks"
and I actually think that it is a healthy environment for an SCM to
grow in. But!

All I'm saying is that if the needs of the corporate folks can be taken
into account without doing Git's architecture any harm I think they
should be.

> Don't get me wrong.  I am not saying that everybody should start rolling
> their own "sane environment setup script" and ship their project with it.
> I am only suggesting it as a possible way to do your "policy enforcement"
> without having to introduce in-tree .gitconfig, which I unfortunately see
> no fundamental upsides but definite downsides (security included).

And here comes my question: could you, please, elaborate on *technical*
drawbacks of in-tree .gitconfig (such as security that you've
mentioned).

Thanks,
Roman.
