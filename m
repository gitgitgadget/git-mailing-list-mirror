From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: metastore
Date: Wed, 3 Oct 2007 00:32:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710030018240.4087@reaper.quantumfyre.co.uk>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <20070916060859.GB24124@piper.oerlikon.madduck.net>
 <20070919191607.GE13683@hardeman.nu> <20071002195301.GB14171@lapse.madduck.net>
 <20071002195816.GA6759@hardeman.nu> <85lkalz3iv.fsf@lola.goethe.zz>
 <20071002211518.GA10445@hardeman.nu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811584-1531084491-1191367938=:4087"
Cc: David Kastrup <dak@gnu.org>, martin f krafft <madduck@madduck.net>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
X-From: git-owner@vger.kernel.org Wed Oct 03 01:32:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcrE5-0003wy-Ex
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 01:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbXJBXcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 19:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbXJBXcV
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 19:32:21 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:36217 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753107AbXJBXcU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2007 19:32:20 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 00494C65F6
	for <git@vger.kernel.org>; Wed,  3 Oct 2007 00:32:18 +0100 (BST)
Received: (qmail 31658 invoked by uid 103); 3 Oct 2007 00:32:18 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91.2/4447. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.034858 secs); 02 Oct 2007 23:32:18 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 3 Oct 2007 00:32:18 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20071002211518.GA10445@hardeman.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59754>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-1531084491-1191367938=:4087
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 2 Oct 2007, David H=E4rdeman wrote:

> On Tue, Oct 02, 2007 at 10:04:56PM +0200, David Kastrup wrote:
>> David H=E4rdeman <david@hardeman.nu> writes:
>>=20
>> >  On Tue, Oct 02, 2007 at 08:53:01PM +0100, martin f krafft wrote:
>> > > also sprach David H=E4rdeman <david@hardeman.nu> [2007.09.19.2016 +0=
100]:
>> > > >  But I agree, if any changes were made to git, I'd advocate adding
>> > > >  arbitrary attributes to files (much like xattrs) in name=3Dvalue
>> > > >  pairs, then any extended metadata could be stored in those
>> > > >  attributes and external scripts/tools could use them in some way
>> > > >  that makes sense...and also make sure to only update them when it
>> > > >  makes sense.
>> > >=20
>> > > So where would those metdata be stored in your opinion?
>> >=20
>> >  I'm not sufficiently versed in the internals of git to have an
>> >  informed opinion :)
>>=20
>> I think we have something like a length count for file names in index
>> and/or tree.  We could just put the (sorted) attributes after a NUL
>> byte in the file name and include them in the count.  It would also
>> make those artificially longer file names work more or less when
>> sorting them for deltification.
>
> Or perhaps the index format could be extended to include a new field for=
=20
> value=3Dname pairs instead of overloading the name field.
>
> But as I said, I have no idea how feasible it would be to change git to=
=20
> support another arbitrary length field in the index/tree file.
>
>> However, this requires implementing _policies_: it must be possible to
>> specify per repository exactly what will and what won't get tracked,
>> or one will get conflicts that are not necessary or appropriate.
>
> I think the opposite approach would be better. Let git provide set/get/de=
lete=20
> attribute operations and leave it at that. Then external programs can do =
what=20
> they want with that data and add/remove/modify tags as necessary (and als=
o=20
> include the smarts to not, e.g. remove the permissions on all files if th=
e=20
> git repo is checked out to a FAT fs).

You need more than that.  You need to be able to log, blame etc on the=20
attributes.  One of the big annoyances of Subversion properties is being=20
unable to find out when or why a property value was changed.

I still don't see why the attributes need to be stored in git directly -=20
particularly if you are going to use an external program to actually apply=
=20
any settings - why not store the attributes as normal file (or files) of=20
some sort tracked by git?  You could use any number of methods - e.g. use=
=20
an sqlite database stored in the root of your tree, or a .<name>.props=20
file alongside each path that you have properties for.  You could even=20
write a system that uses such a method and was then SCM agnostic, allowing=
=20
you to keep your attribute tracking system if/when something better than=20
git comes along - or simply share it with less-fortunate souls stuck in an=
=20
inferior system.

--=20
Julian

  ---
A strong conviction that something must be done is the parent of many
bad measures.
 =09=09-- Daniel Webster
---1463811584-1531084491-1191367938=:4087--
