From: Bernie Innocenti <bernie@codewiz.org>
Subject: Re: GCC Git mirror no longer updating
Date: Thu, 13 Aug 2009 02:28:19 +0200
Organization: Sugar Labs - http://www.sugarlabs.org/
Message-ID: <1250123299.8074.1593.camel@giskard>
References: <4A8198E2.5020205@redhat.com>
	 <1250008005.8074.362.camel@giskard>	 <20090811163049.GA4578@redhat.com>
	 <1250010535.8074.366.camel@giskard>	 <20090811173006.GB4578@redhat.com>
	 <1250017013.8074.376.camel@giskard>	 <20090811191642.GA5806@redhat.com>
	 <4aca3dc20908111333i49195ec5h9b91ab5f6445f701@mail.gmail.com>
	 <4A822440.40207@redhat.com> <1250074569.8074.671.camel@giskard>
	 <4A82C786.5060602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Berlin <dberlin@dberlin.org>,
	"Frank Ch. Eigler" <fche@redhat.com>, overseers@gcc.gnu.org,
	git@vger.kernel.org
To: Jason Merrill <jason@redhat.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 02:35:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbOHj-0006gS-Nu
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 02:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbZHMAfE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2009 20:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbZHMAfE
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 20:35:04 -0400
Received: from trinity.develer.com ([89.97.188.34]:36751 "EHLO
	trinity.develer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbZHMAfD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 20:35:03 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2009 20:35:02 EDT
Received: (qmail 17804 invoked from network); 13 Aug 2009 00:28:21 -0000
Received: from static-217-133-10-139.clienti.tiscali.it (HELO ?192.168.1.100?) (bernie@217.133.10.139)
  by trinity.develer.com with ESMTPA; 13 Aug 2009 00:28:21 -0000
In-Reply-To: <4A82C786.5060602@redhat.com>
X-Mailer: Evolution 2.27.2 (2.27.2-1.fc12) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125760>

El Wed, 12-08-2009 a las 09:45 -0400, Jason Merrill escribi=F3:
> On 08/12/2009 06:56 AM, Bernie Innocenti wrote:
> > The git repository format should support concurrent access, but per=
haps
> > it only applies to git-receive-pack, not fancy operations such as
> > repacking.
>=20
> The git repository format, yes, but maybe not the stuff in .git/svn. =
 It=20
> seems like a temporary index file was referring to an object that got=
=20
> garbage collected away.  Or maybe the index file was left over from t=
he=20
> initial import, and not there due to a collision; there don't seem to=
 be=20
> index files there normally.

git-svn might be keeping extra information in files that the other git
tools don't know about.  This would explain why some objects looked
like orphans and were thus culled.  [cc'ing the git list to catch the
attention of the git-svn maintainer(s)].

Ah, and I just fixed a problem I have introduced myself while fiddling
to recover the repository: HEAD should point at "refs/remotes/trunk",
otherwise new commits won't show up in gitweb.

--=20
   // Bernie Innocenti - http://codewiz.org/
 \X/  Sugar Labs       - http://sugarlabs.org/
