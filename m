From: Mark Struberg <struberg@yahoo.de>
Subject: Re: Compatibility between git.git and jgit
Date: Sat, 2 May 2009 11:00:05 +0000 (GMT)
Message-ID: <806445.80395.qm@web27803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 13:06:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0D3a-0001dq-Ds
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 13:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbZEBLGu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2009 07:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbZEBLGu
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 07:06:50 -0400
Received: from web27803.mail.ukl.yahoo.com ([217.146.182.8]:30398 "HELO
	web27803.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752171AbZEBLGt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 May 2009 07:06:49 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 May 2009 07:06:48 EDT
Received: (qmail 64721 invoked by uid 60001); 2 May 2009 11:00:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1241262006; bh=DPlXgGeahA1uoyqBScoVFGa3IkYOe/jDo+HHMmQ4/+s=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=4NWKMlRQ36pFQtwICH7e6l7YL93meCvho5QZHtRxaCds75DWWrNHSZDhDBdXPhQaaWo49IuZwjXvD2g4Ml3L2wfn5WbLz9qoBYNpknaNWYwXi20NB5/Nortc5XMV8iOQg5KXws9fNFreSwJgc+2opEt/fADINpnWeeslskAn1aU=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xkEFN4nqDCyyRcrMtp+6ILO9xKMzTkag1XxkULNGF5qZXJ8RXSlEBh8qLhHzDJIeKjJjeB19U77GL5mYyX5mn+pUEcHbMegaZd9IFOcc8vvO4ekdWyu6sIHrC2YGpyjGcgrrg6TJUcfPdada+qYoGVBgVEo4hfAys8Pel5VV5Yw=;
X-YMail-OSG: Pdx43LYVM1kKonmyuXtlqOhJLgoMO1bDGsppArI3kw6TE9CY8dKEaC.YmJbF9pLr7UkVoqD8LJfpA.Hohcba0DVsHaSMnGLHmZRO2UkcZlWaCbkvoc1BiHUO5rl6wL0cZz0FW_T1RhvGsCWInLznqo3Oj2XZ4MY7V__cUnFLcd6h3j4j_MI1kJnFmAMROj.G3tF8rOhFNY6oHA8etsceXNpFvsJ4FD1ZM7g9k4MKl4uw1ZHnR2FaqptedKGSYiEbF0m7ThtX66n07Xe9VoHa1jySVOriptDtyYVRutJoPSzW8FFEgqNhuDrx_zia6OkcBzc-
Received: from [62.47.157.201] by web27803.mail.ukl.yahoo.com via HTTP; Sat, 02 May 2009 11:00:05 GMT
X-Mailer: YahooMailClassic/5.2.20 YahooMailWebService/0.7.289.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118130>


As for compatibility between JGIT and GIT:

We (the Apache maven-scm team with Shawn supporting us (thanks again fo=
r patiently answering my sometimes stupid questions)) are currently wor=
king on a JGIT SCM provider for maven. The commandline git-provider alr=
eady works pretty ok since more than a year now and once we have the JG=
IT version too. all this gets tested automatically via our TCK suite.

The TCK suite is pretty high-level, but at least all the fundamental st=
uff is then guaranteed to work for both implementations.

One step on our road is to further 'abstract' the current jgit-core lib=
rary and introduce a SimpleRepository which basically contains the most=
 important git commands as Java calls (e.g. addRemote, fetch, ... ) [1]=
=2E So after having this it should be really easy to side-by-side compa=
re the .git/* of e.g. git-clone uri vs SimpleRepository.clone(uri)


LieGrue,
strub

[1] http://github.com/sonatype/JGit/ branch struberg
--- Shawn O. Pearce <spearce@spearce.org> schrieb am Sa, 2.5.2009:

> Von: Shawn O. Pearce <spearce@spearce.org>
> Betreff: Re: Compatibility between git.git and jgit
> An: "Nicolas Pitre" <nico@cam.org>
> CC: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
> Datum: Samstag, 2. Mai 2009, 3:59
> Nicolas Pitre <nico@cam.org>
> wrote:
> > On Fri, 1 May 2009, Shawn O. Pearce wrote:
> >=20
> > > On an unrelated note, someone asked me recently,
> how do we ensure
> > > compatibility in implementations between git.git
> and jgit?
> >=20
> > Well... this is not exactly easy.=A0 As I said in
> the past=20
> > (http://marc.info/?l=3Dgit&m=3D121035043412788&w=3D2), I think
> that the C=20
> > version must remain the reference with regards to
> protocols and on-disk=20
> > data structures.
>=20
> I agree fully.
>=20
> > If people go wild with JGit and start making changes=20
> > to data structures then it simply won't be Git
> compatible anymore and=20
> > the user base will get fragmented.
>=20
> Agree.=A0 We may see some prototyping happen in JGit
> first on some
> topics, and JGit may even support something earlier than
> git.git,
> e.g JGit has an amazon-s3:// transport that git.git doesn't
> have.
> But it also isn't widely used.
>=20
> > A formal compatibility test suite would imply that
> every Git=20
> > reimplementation should be compatible with the
> reference C version.=A0=20
> > You could add some tests in your test suite which are
> performed in=20
> > parallel using JGit and the C git, and make sure that
> the produced=20
> > results are identical, etc.
>=20
> Yea, and to some extent we try to do that already in JGit,
> but our
> tests aren't complete enough in that area.
> =20
> > But to which extent should the C version remain
> backward compatible with=20
> > other implementations?=A0 Let's suppose a future
> protocol extension is=20
> > made and old unsuspecting C clients work just fine but
> some other=20
> > implementation crashes with it?
>=20
> This is what I think scares both myself and the folks that
> have
> recently asked me about compatibility.
>=20
> If JGit gets a broader user base, and suddenly it stops
> working
> against a newer C git-daemon because of a protocol change,
> those
> users are going to be pissed.=A0 Its no worse than the
> "github can't
> ever upgrade past 1.6.1" issue we had not too long ago.
>=20
> I think we're doing better these days about embedding file
> format
> version numbers into files (e.g. pack idx v2) to help alert
> older
> clients that the format is different.=A0 But we also
> have a something
> of a history of looking for "holes" in older C git parsers
> in
> order to wedge in new features where we didn't plan for
> them in
> the first place.=A0 E.g. the protocol capability slots
> we have now.
>=20
> I think that as reimplementations become more popular, we
> need to
> rely less on extending things by exploiting parser quirks
> in older
> C git.git code, and rely more on at least explicit version
> markers
> that everyone can work with.
>=20
> > And the reference implementation cannot be held back
> because=20
> > of bugs in all alternative implementations.
>=20
> I agree.=A0 A bug is a bug.=A0 But I'd really like to
> get away from the
> trend where we exploit bugs in older C git.git
> implementations to
> add new functionality, because maybe JGit doesn't have that
> same
> bug and will fall flat on its face with that exploit.
>=20
> > As long as they're futzing^Wdeveloping on top of Jgit
> then=20
> > interoperability shouldn't be at risk.=A0 If people
> would start adding new=20
> > object types and pack formats and the like without
> obtaining a consensus=20
> > with people around the C version then I might get
> extremely worried (and=20
> > pissed) though.
>=20
> That's why JGit is BSD, so everyone can use the one f'king
> library
> and not risk fragmenting the Java market further.
>=20
> But yea, I'd be really pissed too if someone hacked up JGit
> and made
> it incompatible with anything else.=A0 Its a risk that
> the liberal
> BSD license permits.
>=20
> I'm really sort of hoping that the development momentum
> around
> git.git and JGit trying to keep up will keep them coming
> back
> to the canonical JGit for updates, forcing them to give
> back any
> hacks^Wimprovements they have made.=A0 If the
> improvements really are
> worthwhile, they can be easily ported over to C before they
> become
> widely used in JGit.
> =20
> > One defensive approach we could adopt is to use a
> capability slot to=20
> > identify the software version of each peer involved in
> the network=20
> > communication.=A0 The advantage would be for a
> later Git version to avoid=20
> > doing some things that are known to break with client
> X or Y.=A0 Of course=20
> > even such a scheme can be abused and misused, like on
> some web sites if=20
> > you don't have the "right" browser, leading some of
> them to allow faking=20
> > the User-Agent string, etc.=A0 But maybe the
> upsides are more important=20
> > than the downsides.=A0 This doesn't help with
> on-disk interoperability,=20
> > but this is probably less important than communication
> interoperability.
>=20
> Blargh.=A0 I'm with you about the whole User-Agent
> mess.
>=20
> Asking clients and servers to identify with implementation
> and
> version markers might be useful for analysis of
> who-is-using-what,
> but I don't think its a good way to negotiate between the
> peers of
> what functionality to enable or disable, or what bug
> workarounds
> to use.=A0 Reminds me of the Apache hack during output
> to work around
> an HTTP header parsing bug in Netscape 2 when the "\r\n"
> pair was
> exactly at byte 256 in the stream.=A0 *shudder*
>=20
>=20
> FWIW, an EGit user recently complained that some random Git
> hosting
> site they were using couldn't work with EGit, but EGit
> worked fine
> with other sites, e.g. GitHub.=A0 Apparently this site's
> SSH forced command
> filter script didn't like EGit asking for "git upload-pack
> 'path.git'".
>=20
> Its not strictly a Git protocol issue, how the client
> launches
> the remote process over SSH, but this random hosting site
> was
> apparently relying on C git's current calling convention
> of
> "git-upload-pack 'path.git'".
>=20
> Long story short, I claimed it was the hosting site's
> bug.=A0 :-)
>=20
> --=20
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe
> git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20


     =20
