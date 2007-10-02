From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Tue, 2 Oct 2007 17:02:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710021642090.9321@iabervon.org>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <20070916060859.GB24124@piper.oerlikon.madduck.net>
 <20070919191607.GE13683@hardeman.nu> <20071002195301.GB14171@lapse.madduck.net>
 <20071002195816.GA6759@hardeman.nu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-2100497631-1191358968=:9321"
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
X-From: git-owner@vger.kernel.org Tue Oct 02 23:03:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcotO-0005Jg-C1
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 23:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbXJBVCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 17:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754248AbXJBVCu
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 17:02:50 -0400
Received: from iabervon.org ([66.92.72.58]:41694 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097AbXJBVCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 17:02:49 -0400
Received: (qmail 16042 invoked by uid 1000); 2 Oct 2007 21:02:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Oct 2007 21:02:48 -0000
In-Reply-To: <20071002195816.GA6759@hardeman.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59736>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-2100497631-1191358968=:9321
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 2 Oct 2007, David H=E4rdeman wrote:

> On Tue, Oct 02, 2007 at 08:53:01PM +0100, martin f krafft wrote:
> >also sprach David H=E4rdeman <david@hardeman.nu> [2007.09.19.2016 +0100]=
:
> > > But I agree, if any changes were made to git, I'd advocate adding
> > > arbitrary attributes to files (much like xattrs) in name=3Dvalue
> > > pairs, then any extended metadata could be stored in those
> > > attributes and external scripts/tools could use them in some way
> > > that makes sense...and also make sure to only update them when it
> > > makes sense.
> >
> >So where would those metdata be stored in your opinion?
>=20
> I'm not sufficiently versed in the internals of git to have an informed
> opinion :)

My theory was that we would provide an API for getting the "current state"=
=20
listing with all of the filenames and matching contents, and leave it up=20
to metastore to put things in the filesystem; in the other direction,=20
metastore would build up this state, and we'd store it.

People who are using this in practice would set a config option to=20
delegate the "working tree" filesystem I/O to metastore, while other=20
people could interact with the state as files describing the state, and=20
could therefore specify operations that are impossible or prohibited on=20
the filesystems that their development is done on.

(This would effectively be like giving people a convenient way of setting=
=20
attributes on entries in a tar file, such that they can edit it to=20
represent a stste that they can't necessarily create in their own=20
filesystems, and version controlling that; but more convenient, since the=
=20
file contents are represented as file contents and the attributes are=20
plain text in a listing of some sort)

=09-Daniel
*This .sig left intentionally blank*
--1547844168-2100497631-1191358968=:9321--
