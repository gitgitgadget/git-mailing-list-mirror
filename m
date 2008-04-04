From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: [REGRESSION] git-gui
Date: Fri, 4 Apr 2008 10:58:06 -0700 (PDT)
Message-ID: <488311.34417.qm@web38904.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre_rosa@lge.com>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 20:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhqIO-0006qi-Ij
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 20:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385AbYDDSEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2008 14:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759512AbYDDSEt
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 14:04:49 -0400
Received: from web38904.mail.mud.yahoo.com ([209.191.125.110]:23104 "HELO
	web38904.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759406AbYDDSEr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Apr 2008 14:04:47 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Apr 2008 14:04:47 EDT
Received: (qmail 34971 invoked by uid 60001); 4 Apr 2008 17:58:06 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=N693sF1Y9mfiTYT4Kd3qlHQbMvGXEKVRPqun6NSOqYP1XaW5Z4ofPZlI6Wep9gbLc/rdWn0Fi3qWIJYiIwu9YcehnPrS8Pwedzsiu9la/mDUxPWpq51yDrbQX89Zckh86PaG1Hdyl10heRGThgxxM4ZyRKbTTS96a1SVZxsk5Y8=;
X-YMail-OSG: H1SlKqkVM1khUJ2CIEoOyQnXh6wjOGxyF_qNyIg_RdlGF7AzHUXYUmY.2shLNPC98w--
Received: from [128.251.89.31] by web38904.mail.mud.yahoo.com via HTTP; Fri, 04 Apr 2008 10:58:06 PDT
X-Mailer: YahooMailRC/902.40 YahooMailWebService/0.7.185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78809>


>=20
> Jonathan del Strother <maillist@steelskies.com> wrote:
> > On Thu, Apr 3, 2008 at 10:04 PM, Michele Ballabio
> > <barra_cuda@katamail.com> wrote:
> > > On Thursday 03 April 2008, Jonathan del Strother wrote:
> > >  > On Thu, Apr 3, 2008 at 2:43 PM, Andr=E9 Goddard Rosa <andre_ro=
sa@lge.com> wrote:
> > >  > >
> > >  > >  # git gui
> > >  > >  Error in startup script: bad event type or keysym "["
> > >  > >    while executing
> > >  > >  "bind $ui_comm <$M1B-Key-\[> {show_less_context;break}"
> > >  >
> > >  > Doh, I broke git :(
>=20
> You and me both Jonathan.  I tested it on both Mac OS X and Win32,
> and on Tcl/Tk 8.4.1, 8.4.10, 8.4.15, and 8.5.0.  Never ran into
> this failure.  So the original poster must be running 8.4.0, and
> 8.4.0 must not support this binding.  Added in 8.4.1?  *sigh*
>=20
> > >  These changes should help (haven't tried):
> > >        \[ -> bracketleft
> > >        \] -> bracketright
> > >  but some European keyboards do not have easy access to brackets,=
 so
> > >  other keys would be preferable (comma and period, for example, o=
r 1 and 2).

Just for the record, the correct keysym should be used, especially for =
"special" characters, as above (i.e. bracketleft). It's probably more o=
f a fluke that \[ worked. Here's an exerpt from http://tcl.activestate.=
com/man/tcl8.4/TkCmd/bind.htm (note "Key" is synonymous with KeyPress):

"If the event type is KeyPress or KeyRelease, then detail may be specif=
ied in the form of an X keysym. Keysyms are textual specifications for =
particular keys on the keyboard; they include all the alphanumeric ASCI=
I characters (e.g. ``a'' is the keysym for the ASCII character ``a''), =
plus descriptions for non-alphanumeric characters (``comma'' is the key=
sym for the comma character), plus descriptions for all the non-ASCII k=
eys on the keyboard (``Shift_L'' is the keysym for the left shift key, =
and ``F1'' is the keysym for the F1 function key, if it exists). The co=
mplete list of keysyms is not presented here; it is available in other =
X documentation and may vary from system to system. If necessary, you c=
an use the %K notation described below to print out the keysym name for=
 a particular key. If a keysym detail is given, then the type field may=
 be omitted; it will default to KeyPress. For example, <Control-comma> =
is equivalent to <Control-KeyPress-comma>."

HTH,
    --brett





      _________________________________________________________________=
___________________
You rock. That's why Blockbuster's offering you one month of Blockbuste=
r Total Access, No Cost. =20
http://tc.deals.yahoo.com/tc/blockbuster/text5.com
