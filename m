From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: How to embed a hash, tag or branch name?
Date: Sat, 01 Aug 2009 18:04:58 +0200
Message-ID: <4A7467AA.7060400@dirk.my1.cc>
References: <20090731081723.GE29909@nalle> <20090731095238.GG29909@nalle> <4A743735.9020806@dirk.my1.cc> <200908011513.13016.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>,
	Mikko Rapeli <mikko.rapeli@iki.fi>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 18:05:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXH5P-0005kr-PQ
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 18:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbZHAQFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Aug 2009 12:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbZHAQFF
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 12:05:05 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.40]:54409 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbZHAQFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 12:05:04 -0400
Received: from [84.176.94.186] (helo=[192.168.2.100])
	by smtprelay06.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1MXH4u-0004Ey-Qa; Sat, 01 Aug 2009 18:05:01 +0200
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <200908011513.13016.jnareb@gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124634>

Am 01.08.2009 15:13 schrieb Jakub Narebski:
> On Sat, 1 August 2009, Dirk S=FCsserott wrote:
>> Am 31.07.2009 11:52 schrieb Mikko Rapeli:
>>> On Fri, Jul 31, 2009 at 02:27:50AM -0700, Jakub Narebski wrote:
>=20
>>>> You can embed SHA-1 of a _file contents_ (blob) using '$Id: $' key=
word
>>>> with `ident` attribute - see gitattributes manpage.
>>> Great, thanks!
>>>
>>>> The correct solution of embedding version number is to do it at=20
>>>> _build time_, using e.g. script similar to GIT-VERSION-GEN used by
>>>> Git itself and by Linux kernel.  It helps if you tag your releases=
=2E
>> Hi Mikko,
>>
>> I don't know whether you want to use the "ident" command on your fin=
al
>> binary. With Git, that's pointless, as all source files will have th=
e
>> same $Id$. So it's perfectly sufficient to have only ONE file enrich=
ed
>> with Git's SHA1.
>=20
> You are wrong.  In Git $Id$ / $Id: $ expands to SHA-1 id of _blob_=20
> (i.e. of file *contents*), not SHA-1 id of a commit.  This way when
> switching branches or rewinding branch using git-reset we don't have
> to pay huge performance penalty because of `ident`, as we would have
> because every file would have to be changed if $Id$ was about commit
> id (or if there was $Revision$ or $Author$ implemented).

Ok, sorry about that. Actually I haven't read the concerning docs
*that* well when I figured out that keyword expansion with Git
is not exactly a good idea.

>=20
>> Suggestion: During build time, compile (and link in) a file (e.g.
>> version.c) with "-DVERSION=3D\"$(git describe)\"". My version.c look=
s like
>> this:
>=20
> GIT-VERSION-GEN and various tricks in Makefile do just that, not only
> for compiled parts, but also for scripts.
>=20

Right, but my explanation shows the overall intention of that.
So, Mikko, have a look at GIT-VERSION-GEN and my suggestion and
use some kind of summary of them.
