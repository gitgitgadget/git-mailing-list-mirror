X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 02 Nov 2006 11:21:24 +0000
Message-ID: <4549D4B4.4030601@shadowen.org>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org>	 <4549C083.9060805@xs4all.nl> <4549CA6B.4090909@shadowen.org>	 <4549CE2A.3010808@xs4all.nl> <8aa486160611020312v42047716t6a13e6fa16eeae8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 2 Nov 2006 11:22:30 +0000 (UTC)
Cc: hanwen@xs4all.nl, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <8aa486160611020312v42047716t6a13e6fa16eeae8@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30733>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaeC-0006B6-0F for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751626AbWKBLWH convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006 06:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbWKBLWH
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:22:07 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:8203 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1751626AbWKBLWD
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:22:03 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GfadP-00045U-H2; Thu, 02 Nov 2006 11:21:23 +0000
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
Sender: git-owner@vger.kernel.org

Santi B=E9jar wrote:
> On 11/2/06, Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
>> Andy Whitcroft escreveu:
>> > Han-Wen Nienhuys wrote:
>> >>
>> >>   tag+sha1
>> >>
>> >> to separate the tag and the committish.
>> >
>> > Well there is a non-alphabet character in there, a minus (-).  The=
 g
>> > prefix on the sha1 _fragment_ it to indicate that it is in fact a
>> > truncated sha1, not a complete one.
>=20
> I think it is there to indicate it is a git commit sha1.
>=20
>>
>> is this policy documented somewhere?  None of the tools understand i=
t.
>>
>> [lilydev@haring git]$ git describe
>> v1.4.3.3-g1e1f76e
>> [lilydev@haring git]$ git show g1e1f76e
>> fatal: ambiguous argument 'g1e1f76e': unknown revision or path not i=
n
>> the working tree.
>> Use '--' to separate paths from revisions
>>
>=20
> Use the complete output of describe:
> $ git show v1.4.3.3-g1e1f76e
>=20
> or the abbrev sha1:
> $ git show 1e1f76e
>=20
>> My suggestion is to use
>>
>>    v1.4.3.3+1e1f76e
>=20
> My suggestion is to use:
>=20
> v1.4.3.3-git1e1f76e
>=20
> to make clear that it is a git revision version.
>=20
> One problem I see with this scheme (either 'g', 'git' of '+') is that
> it does not provide an increasing version number, even for
> fast-forwarding commits. Then it is not useful as a package version
> number (deb or rpm). I've already seen deb packages with
> version+git20061010. One possibility could be to add the number of
> commits between the tag and the commit as:
>=20
> v1.4.3.3-git12g1e1f76e
>=20
> to provide a weak ordering for fast-forwarding commits. What do you t=
hing?

I think you'll restart the 1.2.3.4 versioning is better 'debate' again!

Surly if things are being pushed into a .deb or .rpm we should be using
a real release version.  We should be tagging that.  If the project is
not providing release number, there is nothing stopping you from taggin=
g
them yourself in your copy of the repository and using your tag.  you
could use like 'unofficial-N' where N increments in the way you want.

