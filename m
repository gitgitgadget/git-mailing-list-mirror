From: David Kastrup <dak@gnu.org>
Subject: Re: metastore
Date: Tue, 02 Oct 2007 22:04:56 +0200
Message-ID: <85lkalz3iv.fsf@lola.goethe.zz>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151507310.28586@racer.site>
	<20070915145437.GA12875@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151430040.5298@iabervon.org>
	<20070916060859.GB24124@piper.oerlikon.madduck.net>
	<20070919191607.GE13683@hardeman.nu>
	<20071002195301.GB14171@lapse.madduck.net>
	<20071002195816.GA6759@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
X-From: git-owner@vger.kernel.org Tue Oct 02 22:05:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icnz7-0007RZ-4L
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 22:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbXJBUEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2007 16:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbXJBUEk
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 16:04:40 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:58204 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbXJBUEj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2007 16:04:39 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Icny6-0002Zn-Q5; Tue, 02 Oct 2007 16:03:46 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 43AFE1C4CE11; Tue,  2 Oct 2007 22:04:56 +0200 (CEST)
In-Reply-To: <20071002195816.GA6759@hardeman.nu> ("David =?iso-8859-1?Q?H?=
 =?iso-8859-1?Q?=E4rdeman=22's?= message of "Tue\, 2 Oct 2007 21\:58\:16
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59722>

David H=E4rdeman <david@hardeman.nu> writes:

> On Tue, Oct 02, 2007 at 08:53:01PM +0100, martin f krafft wrote:
>>also sprach David H=E4rdeman <david@hardeman.nu> [2007.09.19.2016 +01=
00]:
>>> But I agree, if any changes were made to git, I'd advocate adding
>>> arbitrary attributes to files (much like xattrs) in name=3Dvalue
>>> pairs, then any extended metadata could be stored in those
>>> attributes and external scripts/tools could use them in some way
>>> that makes sense...and also make sure to only update them when it
>>> makes sense.
>>
>>So where would those metdata be stored in your opinion?
>
> I'm not sufficiently versed in the internals of git to have an
> informed opinion :)

I think we have something like a length count for file names in index
and/or tree.  We could just put the (sorted) attributes after a NUL
byte in the file name and include them in the count.  It would also
make those artificially longer file names work more or less when
sorting them for deltification.

However, this requires implementing _policies_: it must be possible to
specify per repository exactly what will and what won't get tracked,
or one will get conflicts that are not necessary or appropriate.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
