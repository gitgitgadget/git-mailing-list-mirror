From: Walter Bright <boost@digitalmars.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 16:16:28 -0700
Organization: Digital Mars
Message-ID: <fbsm43$ave$1@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>    =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0709061839510.5?=
	=?ISO-8859-1?Q?626@evo.linux-fo?= =?ISO-8859-1?Q?undation.or=04g>?= <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org> <85k5r27wkv.fsf@lola.goethe.zz>    =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?f=04br1a2$qm7$1@se?= =?ISO-8859-1?Q?a.gmane.org>?= <851wda7ufz.fsf@lola.goethe.zz> <fbr4oi$5ko$1@sea.gmane.org> <85wsv26cv8.fsf@lola.goethe.zz> <fbsbul$dg0$1@sea.gmane.org> <851wda2pbo.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 01:16:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITn48-00029R-2B
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 01:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbXIGXQi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 19:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbXIGXQi
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 19:16:38 -0400
Received: from main.gmane.org ([80.91.229.2]:45820 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbXIGXQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 19:16:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ITn3u-0005Tu-G8
	for git@vger.kernel.org; Sat, 08 Sep 2007 01:16:30 +0200
Received: from c-24-16-50-251.hsd1.mn.comcast.net ([24.16.50.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Sep 2007 01:16:30 +0200
Received: from boost by c-24-16-50-251.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Sep 2007 01:16:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-50-251.hsd1.mn.comcast.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <851wda2pbo.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58090>

David Kastrup wrote:
> The problem is a toy problem: in real applications,

Necessarily, to make an example suitable for a n.g. post, I ruthlessly 
cut down the size of it. This can have the inadvertent effect of making 
it appear trivial.

> you'll need to
> access several data structures using the same index, and you'll need
> to be able to assign index values to temporary variables and so on.

The index is available:

	foreach (index, value; array)
	{
		writefln("array[%s] = %s", index, value);
	}

and it isn't necessary to worry about what the correct type for index 
is, as it is inferred.

> So being able to hide the type of an index in one very specific
> application (looping through a single array completely)

  foreach'ing over a subset (i.e. slice) of an array:

	foreach (value; array[5 .. $])
		... loop from 5 to the end ...

> at one place is not going to buy you much.

Experience with foreach in real code shows that the for loop is what 
becomes a rarity. Simple as it is, foreach is one of the best liked 
improvements D has. And I speak as one who has written so many for loops 
that spewing out:

	for (int i = 0; i < 10; i++)

is a 'finger' macro for me, i.e. my fingers blit it out without even 
thinking about it.

 > Anyway, D is pretty much irrelevant as a perspective for git, so you
 > should take it to a language advocacy group.

I wished to answer your specific comments in this post.
