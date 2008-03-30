From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Possible d/f conflict bug or regression
Date: Sun, 30 Mar 2008 06:44:15 +0200
Message-ID: <200803300644.15502.chriscool@tuxfamily.org>
References: <200803290813.08419.chriscool@tuxfamily.org> <3e8340490803291829h6f9c39a5uf4a1b2a4e52103ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio Hamano" <junkio@cox.net>,
	krh@redhat.com
To: "Bryan Donlan" <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 30 06:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfpKQ-0000Lg-Co
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 06:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbYC3Eim convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2008 00:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbYC3Eim
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 00:38:42 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:46221 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbYC3Eil convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Mar 2008 00:38:41 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BC6361AB2B2;
	Sun, 30 Mar 2008 06:38:40 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8FE361AB2AF;
	Sun, 30 Mar 2008 06:38:40 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <3e8340490803291829h6f9c39a5uf4a1b2a4e52103ca@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78499>

Le dimanche 30 mars 2008, Bryan Donlan a =E9crit :
> On Sat, Mar 29, 2008 at 3:13 AM, Christian Couder
> <chriscool@tuxfamily.org> wrote:
> >
> >  Initialized empty Git repository in .git/
> >  Created initial commit 3f945ca: Initial commit.
> >   0 files changed, 0 insertions(+), 0 deletions(-)
> >   create mode 100644 foo
> >  fatal: unable to index file foo
> >
> >  I think it's quite bad that it doesn't work.
>
> What behavior would you expect this to have? IMO, it's not entirely=20
> clear what the user means to do if they replace a file with an empty
> directory, as an empty directory cannot be added to the index. Even
> with a directory with contents, some of the contents may be junk (.o
> for example) as far as the user is concerned.

I think Git should behave the same as when using "git rm foo" instead o=
f "rm=20
foo", that is the file "foo" should be deleted without errors. That's w=
hat=20
version 1.5.3 did too.

> Would a clearer diagnostic be a good solution? Something like:
> fatal: foo: file replaced by directory.
> Use git rm --cached or git add to specify how this should be handled.

No, I think we should fix the regression. Using "git rm stuff" instead=20
of "rm stuff" should not be required.

Regards,
Christian.
