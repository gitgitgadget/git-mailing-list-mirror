From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Require JDK1.5
Date: Mon, 14 May 2007 19:24:34 +0200
Message-ID: <200705141924.34490.robin.rosenberg@dewire.com>
References: <11790995571082-git-send-email-robin.rosenberg@dewire.com> <Pine.LNX.4.63.0705140303380.17507@alpha.polcom.net> <46480E02.1010500@peralex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Grzegorz Kulewski <kangur@polcom.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Noel Grandin <noel@peralex.com>
X-From: git-owner@vger.kernel.org Mon May 14 19:25:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HneIB-0003DP-CK
	for gcvg-git@gmane.org; Mon, 14 May 2007 19:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757332AbXENRY2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 14 May 2007 13:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755673AbXENRY1
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 13:24:27 -0400
Received: from [83.140.172.130] ([83.140.172.130]:2858 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757332AbXENRY0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2007 13:24:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C667B8028BE;
	Mon, 14 May 2007 19:18:13 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14859-05; Mon, 14 May 2007 19:18:13 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 497428027ED;
	Mon, 14 May 2007 19:18:13 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <46480E02.1010500@peralex.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47274>

m=E5ndag 14 maj 2007 skrev Noel Grandin:
>=20
> >> diff --git
> >> a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
> >> b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
> >> index c397a0d..63796fd 100644
> >> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
> >> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
> >> @@ -50,9 +50,9 @@ public class ObjectIdMap implements Map {
> >>
> >>     public ObjectIdMap(Map sample) {
> >>         try {
> >> -            Method m=3Dsample.getClass().getMethod("clone", null)=
;
> >> +            Method m=3Dsample.getClass().getMethod("clone",
> >> (Class[])null);
> >>             for (int i=3D0; i<256; ++i) {
> >> -                level0[i] =3D (Map)m.invoke(sample, null);
> >> +                level0[i] =3D (Map)m.invoke(sample, (Object[])nul=
l);
> >>             }
> >>         } catch (IllegalAccessException e) {
> >>             throw new IllegalArgumentException(e);
> >
> > I wonder why one would need changes like this?
> >
> > These casts are not needed for anything as far as I can see and you=
r
> > IDE should easily tell you what type that parameter is. No?
> >
> Those are varargs parameters, so when compiling under 1.5 you sometim=
es
> have to tell the compiler the difference between passing a varargs ar=
ray
> and passing one parameter.

The compiler does the right thing by default in this case, but I don't
like seeing warnings for code that is perfectly fine, hence the cast.

I noticed I dropped using this class just before sending the previous s=
et
of patches, so it isn't really necessary in the current code, but I thi=
nk I will start=20
using it soon so it can stay.

-- robin
