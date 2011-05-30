From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH 3/3] gitk: Allow displaying time zones from author and
 commit timestamps
Date: Sun, 29 May 2011 23:05:29 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1105291740410.23145@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu> <alpine.DEB.2.02.1101191447340.23868@dr-wily.mit.edu> <20110529044656.GA8881@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 30 05:05:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQsnS-0001mI-Iz
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 05:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab1E3DFd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2011 23:05:33 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:42043 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753275Ab1E3DFd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 23:05:33 -0400
X-AuditID: 12074423-b7babae000007c6b-6c-4de309748914
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 04.6E.31851.47903ED4; Sun, 29 May 2011 23:05:24 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id p4U35VGQ007359;
	Sun, 29 May 2011 23:05:31 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p4U35TXw025573
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 29 May 2011 23:05:31 -0400 (EDT)
In-Reply-To: <20110529044656.GA8881@brick.ozlabs.ibm.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixG6nolvC+djXoKNdwaLrSjeTxZoji9kd
	mDzm7upj9Pi8SS6AKYrLJiU1J7MstUjfLoEro/fdRtaC2zwVR37OZWtgnMvVxcjJISFgInFr
	01QWCFtM4sK99WwgtpDAPkaJ2w+1uxi5gOwNjBJndyxkh3D2MEm0nlzBDlLFIqAtsXftObBu
	NgE1ibkbJgPFOThEBFQl1l8QAgkzC4hLbFr+hgnEFhaIk5j4dhEziM0pYClx7v1JsFZeAUeJ
	rlNzWCHmL2GUeD1/AStIQlRAV2Jz91I2iCJBiZMzn7BADFWXOPDpIiOErS1x/2Yb2wRGwVlI
	ymYhKZuFpGwBI/MqRtmU3Crd3MTMnOLUZN3i5MS8vNQiXTO93MwSvdSU0k2M4PB1Ud7B+Oeg
	0iFGAQ5GJR5e06JHvkKsiWXFlbmHGCU5mJREeRs4HvsK8SXlp1RmJBZnxBeV5qQWH2KU4GBW
	EuFV/wVUzpuSWFmVWpQPk5LmYFES550rqe4rJJCeWJKanZpakFoEk5Xh4FCS4D0JMlSwKDU9
	tSItM6cEIc3EwQkynAdoeBNIDW9xQWJucWY6RP4Uo6KUOC8jMEEICYAkMkrz4Hph6eUVozjQ
	K8K8P0DaeYCpCa77FdBgJqDBve8eggwuSURISTUwtkrXP33+f+9v06NzvlhWRm33rp50cJrh
	ts4nrLxNt5mu9WvJ/2kpqZlqv+JJyDlW5y6JaTdUp1vqT1eRuW/y6trnvgSnYwlsf2ouVnTs
	8bmizfPRztM8XVggIvHh/0DBwiuynGUTgmL6jn5atOm4wivzo4FGFU7fnvlVJTCc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174713>

On Sun, 29 May 2011, Paul Mackerras wrote:
> > @@ -11018,7 +11018,18 @@ proc prefsok {} {
> >  proc formatdate {d} {
> >      global datetimeformat
> >      if {$d ne {}} {
> > -	set d [clock format [lindex $d 0] -format $datetimeformat]
> > +	if {[string match {*%[zZ]*} $datetimeformat]} {
> > +	    if {[catch {set d [clock format [lindex $d 0] -timezone [lind=
ex $d 1] -format $datetimeformat]}]} {
> > +		# Tcl < 8.5 does not support -timezone.
> > +		global env
> > +		set zone [lindex $d 1]
> > +		set env(TZ) "IDK[string range $zone 0 2]:[string range $zone 3 e=
nd]"
>=20
> What is this about?  Where is the IDK prefix for timezones defined or
> described?

Yeah, sorry, that deserved a bit more explanation.  This is a kludge to=
=20
get Tcl 8.4 to format dates in the right timezone.  IDK is an arbitrary=
=20
made up 3-letter code (=E2=80=9CI Don=E2=80=99t Know=E2=80=9D), since a=
 UTC offset can=E2=80=99t generally=20
be converted into a zone name.  The format of TZ is described at:
http://www.gnu.org/software/libc/manual/html_node/TZ-Variable.html
http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html

Actually, reading that again, I just realized that I need to invert the=
=20
sign.  Also that it can be longer than 3 letters; I=E2=80=99ll use =E2=80=
=9CUnknown=E2=80=9D=20
instead.

> > +		set d [clock format [lindex $d 0] -format $datetimeformat]
> > +		unset env(TZ)
>=20
> Oops, we just lost any previous setting of TZ...

Good point.

Thanks for taking a look.  I=E2=80=99ll follow up with a fixed version.

Anders
