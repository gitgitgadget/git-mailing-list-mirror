From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: git to libgit2 code relicensing
Date: Sat, 15 Nov 2008 18:13:39 +0100
Message-ID: <20081115171338.GA19259@auto.tuwien.ac.at>
References: <491DE6CC.6060201@op5.se> <20081114213352.GA12134@auto.tuwien.ac.at> <491E021E.5020104@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 15 18:14:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1OjZ-00054y-Kq
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 18:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbYKORNl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Nov 2008 12:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbYKORNl
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 12:13:41 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:43488 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYKORNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 12:13:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 39511680BEA2;
	Sat, 15 Nov 2008 18:13:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k+-6XeQKQt0m; Sat, 15 Nov 2008 18:13:39 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 0ED5C6804367; Sat, 15 Nov 2008 18:13:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <491E021E.5020104@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101078>

Andreas Ericsson wrote:
> Shawn posted the exact text. The spirit of that license is that anyon=
e can
> use an unmodified version of the library for whatever they want, but =
it's
> illegal to link non-GPL software to an altered version of the library=
=2E That
> is, the git community will get all changes back while other projects =
can
> use the official version of the library without having to worry about
> licensing issues. EvilCompany cannot make changes to the library and =
then
> link non-GPL'd software to their changed version. They can do that if=
 they
> send their library changes upstream and then only use them once they'=
re
> considered "official" though.

I would not interpret the license this way. Lets look at the text:

|  In addition to the permissions in the GNU General Public License,
|  the authors give you unlimited permission to link the compiled
|  version of this file into combinations with other programs,
|  and to distribute those combinations without any restriction
|  coming from the use of this file.  (The General Public License
|  restrictions do apply in other respects; for example, they cover
|  modification of the file, and distribution when not linked into
|  a combined executable.)

It's an additional permission, which allows linking into binaries and
distributing them.=20

Modification is still covered by the GPL text, 2b:

|  You must cause any work that you distribute or publish, that in
|  whole or in part contains or is derived from the Program or any
|  part thereof, to be licensed as a whole at no charge to all third
|  parties under the terms of this License.

So a patched version must be available unter the "this" license. In my
option, this must be GPLv2+addition permission. GPLv3 explicitly talks
about additional terms, so its clear, that they propagate. GPLv2
doesn't do this, but additional terms, like OpenSSL linkage exceptions
are usually propagated.

So EvilCompany can create their own, modified GPL+GCC exception
libgit2 version behind their doors.

Then they link it into their non-GPL software and can distribute the
resulting binary without any GPL restriction. As the exception states,
that the binary can be distributed without any restrictions coming
from the GPL+GCC exception code, this COULD mean, that clause 3 of the
GPL does not apply too (ship binary without source code).

I'm only a programmer, so you should ask people with better
understanding of legal things.

Your interpretation of the GCC exception would render it useless for
the Debian probject [and probably other projects too], which means,
that they can use/distribute libgit2 only the GPL. If you don't want
that, you should consider posting to Debian Legal
(http://lists.debian.org/debian-legal/) for advice.

mfg Martin K=F6gler
PS:=20
Have you looked at the Classpath exception:

|  Linking this library statically or dynamically with other modules is
|  making a combined work based on this library.  Thus, the terms and
|  conditions of the GNU General Public License cover the whole
|  combination.
| =20
|  As a special exception, the copyright holders of this library give y=
ou
|  permission to link this library with independent modules to produce =
an
|  executable, regardless of the license terms of these independent
|  modules, and to copy and distribute the resulting executable under
|  terms of your choice, provided that you also meet, for each linked
|  independent module, the terms and conditions of the license of that
|  module.  An independent module is a module which is not derived from
|  or based on this library.  If you modify this library, you may exten=
d
|  this exception to your version of the library, but you are not
|  obligated to do so.  If you do not wish to do so, delete this
|  exception statement from your version.=20
