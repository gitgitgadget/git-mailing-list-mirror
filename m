From: Andreas Ericsson <ae@op5.se>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Thu, 05 Mar 2009 10:06:09 +0100
Message-ID: <49AF9601.9060709@op5.se>
References: <Pine.LNX.4.44.0903010945290.4675-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Miles Bader <miles@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: gyles19@visi.com
X-From: git-owner@vger.kernel.org Thu Mar 05 10:08:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf9Z4-0004TM-1n
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 10:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbZCEJGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 04:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753296AbZCEJGQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 04:06:16 -0500
Received: from spsmtp02oc.mail2world.com ([74.202.142.148]:3227 "EHLO
	spsmtp02oc.mail2world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbZCEJGO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 04:06:14 -0500
Received: from mail pickup service by spsmtp02oc.mail2world.com with Microsoft SMTPSVC;
	 Thu, 5 Mar 2009 01:04:39 -0800
auth-sender: exon@home.se
Received: from 212.112.174.166 unverified ([212.112.174.166]) by spsmtp02oc.mail2world.com with Mail2World SMTP Server; 
	Thu, 05 Mar 2009 01:04:39 -0800
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <Pine.LNX.4.44.0903010945290.4675-100000@localhost.localdomain>
X-OriginalArrivalTime: 05 Mar 2009 09:04:39.0832 (UTC) FILETIME=[6A602180:01C99D71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112274>

Joi Ellis wrote:
> On Fri, 6 Feb 2009, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> Now, in this case, it was only one tweak and other responders have
>>> already pointed him in the right direction. So just making that tweak
>>> manually is probably the sane thing to do in this situation.
>>>
>>> But I wanted to point out that autoconf is not totally without value
>>> here.
>> I am not saying something that strong, either.  If autoconf generated
>> configure works _for you_ without hassle, great.  Keep using it.
>>
>> The original message that started this thread was what to do when it does
>> NOT work for you, and my point was in general it is much nicer to point at
>> the knob to tweak from the make invocation command line (or in config.mak)
>> than having you spend time on upgrade autoconf, generate configure and run
>> it.
> 
> Actually, guys, if you go back and re-read my original message, I was
> pointing out that if you use a 'git clone' to get a build tree, THERE IS
> NO CONFIGURE SCRIPT in the tree.
> 
> The problem is not that the configure script does not work.  I pointed
> out in the first paragraph that the configure script in the TARBALL
> works just fine.  What I pointed out is that the build tree DOES NOT
> PROVIDE THE CONFIGURE SCRIPT.  All I asked you to do is to consider
> adding the configure script to the repository so that it gets pushed out 
> in a clone.
> 
>> Fanboys may say that autoconf generated configure is the greatest thing
>> since sliced bread.  But let's face it.  Honestly, the track record of
>> those people in keeping autoconf part in this project up-to-date has not
>> been all that great.  There are things that the generated configure file
>> does not detect nor configure correctly (we had --with-expat patch, and we
>> also saw "the trailing slash in template_dir definition in config.mak.in"
>> discussed fairly recently).  You are much better off tweaking known
>> peculiarity of your platform in config.mak, when configure does not work
>> out of box for you.
> 
> I've been building and installing multi-platform *nix software on
> various flavors for two decades now.  "./configure && make && make install" has 
> been the standard build process even before GNU.  The whole point of
> autoconf/configure/make tools is to eliminate the need to manually tweak
> makefiles so that software is easily portable between platforms. 
> 

./configure is a generated script. Including it in the repository is not
something many projects do, since one of the things developers will be
working on is to change how that file is generated. Including it in the
release tar-balls is something every project (that uses autoconf) does,
since those are aimed at end-users.

It has not been the standard since before GNU, as the GNU project was
started quite a long time (well over a decade) before autoconf's inception.

> I got such a rash of SNOTTY messages from you folks, all directed to me
> privately, that I nearly deleted git from my laptop altogether.

I guess you're referring to the "To: " and "Cc: " fields of the emails
you received containing your address. For this particular list, that's
part of how we do things. It's quite common on high-volume lists to do
that, as people would otherwise have to sift through *all* the mail on
the list to figure out which emails are replies to their own questions
or patches. Somewhere in the Cc list you will see git@vger.kernel.org,
I'm sure.

>  You can be
> sure I will not bother attempting to build git from a clone ever again.
> I took the time to debug and diagnose the build failures I was getting,
> and I tried to politely pass it along in case anyone cares.
> 

Thank you for that.

> Clearly, you don't.  I shall not waste your or my time any further.
> 

And again, thank you for that.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
