From: Simon Josefsson <simon@josefsson.org>
Subject: Re: [PATCH] Add --pretty=changelog
Date: Fri, 02 Mar 2007 10:14:53 +0100
Message-ID: <87hct4roqa.fsf@latte.josefsson.org>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<87y7mhrnrc.fsf@latte.josefsson.org>
	<Pine.LNX.4.63.0703011912090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 10:15:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN3rK-0000lB-8W
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 10:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422748AbXCBJPU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 2 Mar 2007 04:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422911AbXCBJPU
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 04:15:20 -0500
Received: from 178.230.13.217.in-addr.dgcsystems.net ([217.13.230.178]:49759
	"EHLO yxa.extundo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422748AbXCBJPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 04:15:17 -0500
Received: from extundo.com (yxa.extundo.com [217.13.230.178])
	(authenticated bits=0)
	by yxa.extundo.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l229ErA7022758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Mar 2007 10:14:56 +0100
OpenPGP: id=B565716F; url=http://josefsson.org/key.txt
X-Hashcash: 1:22:070302:git@vger.kernel.org::Ejg67uAXPBk8EIVU:55+v
X-Hashcash: 1:22:070302:junkio@cox.net::6sQ/n3TJVjaf1JdL:4eb5
X-Hashcash: 1:22:070302:johannes.schindelin@gmx.de::pEPR64H3PVRVhLOO:HFtq
In-Reply-To: <Pine.LNX.4.63.0703011912090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu\, 1 Mar 2007 19\:15\:50 +0100
	\(CET\)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.94 (gnu/linux)
X-Spam-Status: No, score=-1.9 required=4.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.1
X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on yxa-iv
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on yxa.extundo.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41173>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> 1) Indentation should be under the '*'.  Compare (wrong):
>>=20
>>         * src/asn1Coding.c, src/asn1Decoding.c, src/asn1Parser.c: Im=
prove
>>           --help output.  Assume getopt_long, since gnulib provides =
it.
>
> I saw that in your mail already, and I find the style cvs2cl outputs =
ugly.

Well, if you don't follow the GNU ChangeLog format, then please call
it something else.  The format is well documented.

>> 2) Don't log anything for empty messages:
>>=20
>>         * gl/.cvsignore: *** empty log message ***
>>=20
>> Possibly, this should be an option.
>
> It does not log anything for empty messages. Not even a colon.

The problem here is that CVS insert '*** empty log message ***' when
you didn't supply a log message, and doing something intelligent with
such logs would be useful.  Plenty of projects that needs cvs2cl
functionality will be coming from the cvs world.

There is plenty of functionality in cvs2cl that I believe a proper
git2cl should support, handling empty CVS commit messages is one,
others would include ignoring files based on a regexp, output in XML
format, put ChangeLog's in sub-directories, show branches and tags.

>> 3) Possible charset problem?  Compare this (correct):
>>=20
>>         * configure.in: Fix -Wno-pointer-sign test to respect user-d=
efined
>>         CFLAGS.  Reported by "Diego 'Flameeyes' Petten=F2"
>>         <flameeyes@gentoo.org>.
>>=20
>> with (wrong):
>>=20
>>         * configure.in: Fix -Wno-pointer-sign test to respect user-d=
efined
>>           CFLAGS.  Reported
>>=20
>> The git log do seem to contain the correct data, though, from git-lo=
g:
>>=20
>>     Fix -Wno-pointer-sign test to respect user-defined CFLAGS.  Repo=
rted
>>     by "Diego 'Flameeyes' Petten=F2" <flameeyes@gentoo.org>.
>
> No charset problem. In Git commit messages, the first line is special=
=2E It=20
> is the so called "oneline" description. If you wrap the oneline, it's=
 your=20
> fault, not Git's.

But I want more than the oneline comment in the ChangeLog?  There is
no size limit on ChangeLog messages, and having as much information as
possible available is better.

Anyway, for now I'll be settling with the (just announced) git2cl
since it gives me the most flexibility.  If/when git core includes
your patch later on, and some of my pet problems are fixed, and my
distribution catches up, I'll be back.

/Simon
