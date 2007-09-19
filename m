From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Wed, 19 Sep 2007 21:16:07 +0200
Message-ID: <20070919191607.GE13683@hardeman.nu>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <20070916060859.GB24124@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Oct 01 19:19:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcOvz-00085v-Gb
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 19:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbXJARTs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2007 13:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbXJARTr
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 13:19:47 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:42211 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbXJARTr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2007 13:19:47 -0400
X-Greylist: delayed 3424 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2007 13:19:46 EDT
Received: from ip54532fb6.speed.planet.nl ([84.83.47.182] helo=austin)
	by palpatine.hardeman.nu with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <david@hardeman.nu>)
	id 1IcO2R-0006sX-Au; Mon, 01 Oct 2007 18:22:31 +0200
Received: by austin (Postfix, from userid 1000)
	id 81F99290735; Wed, 19 Sep 2007 21:16:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070916060859.GB24124@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59627>

On Sun, Sep 16, 2007 at 08:08:59AM +0200, martin f krafft wrote:
>also sprach Daniel Barkalow <barkalow@iabervon.org> [2007.09.15.2156 +=
0200]:
>> Configuration options only apply to the local aspects of the reposit=
ory.=20
>> That is, when you clone a repository, you don't get the configuratio=
n=20
>> options from it, in general. And changing configuration options on a=
=20
>> repository does not have any effect on the content it contains. So=20
>> configuration options aren't appropriate.
>
>Sure they are. Just like git-commit figures out your email address=20
>if user.email is missing from git-config, or core.sharedRepository=20
>or core.umask deal with permissions only when you tell them to,=20
>you'd have to enable core.track or else git would just do what it
>does right now.
>
>> Git doesn't have any way to represent owners or groups, and they
>> would need to be represented carefully in order to make sense
>> across multiple computers. If you're adding support for
>> metadata-as-content (for more than "is this a script?"), you
>> should be able to cover all of the common cases of extended stuff,
>> like AFS-style ACLs.
>
>Ideally, git should be able to store an open-ended number of
>properties for each object, yes.

I haven't followed the discussion at all I must admit (I wrote metastor=
e=20
as a quick hack to store some extended metadata and it works for my=20
purposes as long as I don't do anything fancy). But I agree, if any=20
changes were made to git, I'd advocate adding arbitrary attributes to=20
files (much like xattrs) in name=3Dvalue pairs, then any extended metad=
ata=20
could be stored in those attributes and external scripts/tools could us=
e=20
them in some way that makes sense...and also make sure to only update=20
them when it makes sense.

--=20
David H=E4rdeman
