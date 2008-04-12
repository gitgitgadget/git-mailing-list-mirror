From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Intricacies of submodules
Date: Fri, 11 Apr 2008 20:13:58 -0700
Message-ID: <1207970038.10408.8.camel@ginkgo>
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
 <7vmyo0owep.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Ping Yin <pkufranky@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 05:15:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkWCp-00013v-7o
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 05:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756755AbYDLDOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 23:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756371AbYDLDOH
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 23:14:07 -0400
Received: from sca-es-mail-1.Sun.COM ([192.18.43.132]:33724 "EHLO
	sca-es-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbYDLDOG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 23:14:06 -0400
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3C3E3Fk014959
	for <git@vger.kernel.org>; Fri, 11 Apr 2008 20:14:04 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZ600C01ZKDY700@fe-sfbay-10.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Fri, 11 Apr 2008 20:14:03 -0700 (PDT)
Received: from [192.168.0.101] ([76.21.110.21])
 by fe-sfbay-10.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb
 28 2007)) with ESMTPSA id <0JZ600J4MZNBYJ70@fe-sfbay-10.sun.com>; Fri,
 11 Apr 2008 20:14:03 -0700 (PDT)
In-reply-to: <7vmyo0owep.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79325>

On Fri, 2008-04-11 at 15:32 -0700, Junio C Hamano wrote:
> > But, how  to handle the case that  there are more than one policies
> > for different projects?
> 
> "How to"?  You would handle the case just like either of us suggested
> above.
> 
> Are you talking about a single project with more than one policies A, B,
> C, ... that conflict with each other?  Or are you talking about more than
> one projects, each of which has a single project-wide policy?
> 
> I do not think the former makes sense and won't be helped with in-tree
> file that overrides .git/config Roman discussed either.
> 
> The latter would be helped equally well whether that in-tree polic file is
> called .gitconfig or update-git-config.sh.

I believe Fedor addressed the social aspects of this issue quite well,
so I'm just going to focus on a technical aspect here: there is a 
difference between .gitconfig and update-git-config.sh approaches 
that I would like you to acknowledge. With update-git-config.sh you
are allowing for a repository to be in a state that is inconsistent
with the policies that need to be enforced, without novice users even
realizing that. Contrast this with .gitconfig where policies get
enforced right from the minute your clone operation finishes and there's
much less opportunity for the user to shoot himself in the foot. In 
fact "shooting in the foot" (senselessly overriding default policies
via .git/config) becomes an *explicit* action on user's part. He is
the one to blame.

Thanks,
Roman.
