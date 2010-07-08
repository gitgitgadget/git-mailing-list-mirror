From: Mike Hommey <mh@glandium.org>
Subject: Re: git rebase bug?
Date: Thu, 8 Jul 2010 11:47:20 +0200
Message-ID: <20100708094720.GB3720@glandium.org>
References: <20100707150545.GA24814@glandium.org>
 <20100707180004.GA3165@atjola.homenet>
 <20100707205126.GA11240@glandium.org>
 <m3bpajm0gw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 11:47:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWnhp-0006Kd-SW
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 11:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab0GHJrk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 05:47:40 -0400
Received: from vuizook.err.no ([85.19.221.46]:60759 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396Ab0GHJrk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 05:47:40 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1OWnhR-0002sb-Vf; Thu, 08 Jul 2010 11:47:37 +0200
Received: from mh by glandium.org with local (Exim 4.72)
	(envelope-from <mh@glandium.org>)
	id 1OWnhQ-0001Ej-Ud; Thu, 08 Jul 2010 11:47:20 +0200
Content-Disposition: inline
In-Reply-To: <m3bpajm0gw.fsf@localhost.localdomain>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 2.5): No, score=2.5 required=5.0 tests=DNS_FROM_OPENWHOIS,RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150553>

On Wed, Jul 07, 2010 at 02:44:50PM -0700, Jakub Narebski wrote:
> Mike Hommey <mh@glandium.org> writes:
> > On Wed, Jul 07, 2010 at 08:00:04PM +0200, Bj=F6rn Steinbrink <B.Ste=
inbrink@gmx.de> wrote:
> > > On 2010.07.07 17:05:45 +0200, Mike Hommey wrote:
>=20
> > > > See how the security/manager/ssl/public/nsIBadCertListener.idl =
file that
> > > > was created by the original patch is created as
> > > > xulrunner/examples/simple/content/contents.rdf.
> > >=20
> > > The "problem" is that nsIBadCertListener.idl wasn't actually crea=
ted by
> > > the cherry-picked commit, but was modified. It was an empty file =
before,
> > > created in 4292283190983fa91b875e22664a79a3aa9ea45d.
> > >=20
> > > And as nsIBadCertListener.idl is missing from the xulrunner/2.0 b=
ranch,
> > > git does the usual rename detection, finding another empty file a=
nd ends
> > > up patching that one instead.
> >=20
> > Oh, makes sense. Thanks. So that's a quite troubling corner case...
> > I wonder if empty files shouldn't be special cased...
>=20
> Well, similarity score (of contents and of filename) is weighted by
> contents length, but perhaps empty files / zero length somehow fall
> out as an edge case...
>=20
> I agree that empty files should be special cased... unless filename i=
s
> _very_ similar.

Question is, in a case like mine, what should the result be?

Mike
