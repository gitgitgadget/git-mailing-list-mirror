From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Document that gitweb deals with bare repositories
Date: Fri, 15 May 2009 19:29:16 -0700
Message-ID: <7vab5dsrur.fsf@alter.siamese.dyndns.org>
References: <ed82fe3e0905151349k15f040aej30dbec82037e9d76@mail.gmail.com>
	<20090515211611.27697.82605.stgit@localhost.localdomain>
	<4A0DDD94.1010901@freescale.com> <200905152336.49319.jnareb@gmail.com>
	<ed82fe3e0905151521m64df542eifca87073c4360fbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Sat May 16 04:30:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M59fE-0005GW-GH
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 04:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213AbZEPCaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 22:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755058AbZEPCaH
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 22:30:07 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:48434 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbZEPCaG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 22:30:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516022916.PSQA2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 May 2009 22:29:16 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id s2VG1b0074aMwMQ042VGoJ; Fri, 15 May 2009 22:29:16 -0400
X-Authority-Analysis: v=1.0 c=1 a=4ZHfq1p-qOcA:10 a=dNmzuCNScbMA:10
 a=6ohNodAXAAAA:8 a=YL8-FMMFXfK3pgPhNt4A:9 a=bAunCm8DK-SFj-n1FA4ljxEo3gYA:4
 a=gDjHQkheYgsA:10
X-CM-Score: 0.00
In-Reply-To: <ed82fe3e0905151521m64df542eifca87073c4360fbf@mail.gmail.com> (Timur Tabi's message of "Fri\, 15 May 2009 17\:21\:42 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119317>

Timur Tabi <timur@freescale.com> writes:

>> If you provide access for others, i.e. if those repositories shown in
>> gitweb are public repositories, it is much better to use bare
>> repositories for that.
>
> Why?  What difference does it make if they clone directly from my
> working tree, instead of some shadow repository?

There is none.

Even though I would not personally publish the live repository I
personally work in via gitweb, I do not think that has to be a holy rule
not to be broken by anybody.  Some people may want to show state of a live
tree, and other people may be willing to peek into it.  I do not think it
is worth spending excess effort beyond giving one educational advice like
Jakub did to prevent them from doing so.  It's their choice.  While they
may have to live with the consequence of such an arrangement, other people
won't be harmed (I do not think it is such a big deal for them to deal
with the fallout either).

I personally would not mind peeking into such a gitweb, but I would really
hesitate to fetch from a repository that is known to be live.  The commits
I would see there right now are not likely to be in the finished form (the
live repository owner may want to amend them).  The repository owner may
promise "I'll keep them stable and never amend", but that is worse, at
least from my point of view, as nobody is perfect and the resulting
history in such a live repository is bound to be full of crufts I'd rather
not have to wade through.

It is a very useful coalmine canary to see the path in gitweb ending with
slash dot git like /home/tt/foo/.git, not /home/tt/foo.git, for me to be
able to tell which is which.  If it is a bare repository without a work
tree, as long as the repository owner has graduated the CVS mentality and
acquired a good habit of not pushing things too hastily, there is a chance
that the history I would see there is reviewed by the author and cleaned
up to be presentable.
