From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: Use "git pull --ff-only" by default?
Date: Fri, 21 May 2010 16:47:49 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74483234EDE@xmail3.se.axis.com>
References: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
 <4BF68F5F.9010309@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 21 16:48:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFTWH-00042K-7z
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 16:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757715Ab0EUOsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 10:48:08 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:53037 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757473Ab0EUOsA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 10:48:00 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o4LElofW028542;
	Fri, 21 May 2010 16:47:50 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Fri, 21 May 2010 16:47:50 +0200
Thread-Topic: Use "git pull --ff-only" by default?
Thread-Index: Acr47JI7xiBS7PbMRqmHvGdNRCrpEAABt+lA
In-Reply-To: <4BF68F5F.9010309@drmicha.warpmail.net>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147458>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Michael J Gruber
> Sent: den 21 maj 2010 15:49
> To: Peter Kjellerstedt
> Cc: git@vger.kernel.org
> Subject: Re: Use "git pull --ff-only" by default?
> 
> Peter Kjellerstedt venit, vidit, dixit 21.05.2010 14:59:
> > Is there some way to make "git pull --ff-only" be the default?
> > I could not find anything about this in "git config --help" and
> > also the lack of a --no-ff-only option for git pull (it exists
> > for git merge) indicates that there is no such support.
> >
> > I did considered the branch.<name>.mergeoptions configuration
> > option, but it does not seem appropriate as it only applies to
> > a specific branch, whereas I want it to apply to all branches
> > by default.
> >
> > Yes, I know I could do "git config alias.pl 'pull --ff-only'",
> > but since my intensions are for this to be the default for all
> > developers in our organization (most of whom have no git knowledge
> > at all yet) to avoid unnecessary branches caused by the developers
> > hacking directly on master rather than a topic branch, I would
> > very much prefer a configuration option rather than an alias (as
> > I am unlikely to get the developers to remember to do "git pl"
> > instead of "git pull").
> 
> Problem is they have to remember to set your new config, or, if you are
> able to set all developers system config, they have to refrain from
> overriding it.

They would get it by default from our setup scripts. If they then 
choose to turn it off, so be it.

> > My idea was to add something like merge.options and pull.options
> > as configuration options (I want to be able to specify the options
> > separately for pull and merge). However, I wanted throw this out
> > here first before starting to hack away at the code, in case I
> > missed something obvious, or if others find this to be an
> > incredibly stupid idea...
> 
> In general, you can't control reliably what people do in their repos.

I sure wish I had more control over it, but that is a separate 
discussion. ;)

> But you can control what kind of pushes into a central repo you allow.
> That is the usual approach: Let them mess up their repos, they'll learn
> their lesson when they can't push ;)

Can you differentiate between an automatic merge which happened
because the user had made some local changes before pulling (which
I do not want to appear in the central repo), and a real merge of 
a topic branch (which I do want)?

> Michael

//Peter
