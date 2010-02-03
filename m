From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor
	with no changes written
Date: Wed, 3 Feb 2010 02:59:47 +0100
Message-ID: <20100203015947.GA4280@neumann>
References: <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	<76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	<77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	<76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	<alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
	<76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
	<40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
	<76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
	<40aa078e1002021616s3098bf53la6af93ab0949e7e@mail.gmail.com>
	<76c5b8581002021655k5f63b81h1c55ae87625fbfc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 03:00:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcUXF-0000DA-6d
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 03:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249Ab0BCB74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 20:59:56 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:65525 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932149Ab0BCB7z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 20:59:55 -0500
Received: from [127.0.1.1] (p5B130DB1.dip0.t-ipconnect.de [91.19.13.177])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MZ776-1NJih723cS-00L3G5; Wed, 03 Feb 2010 02:59:50 +0100
Content-Disposition: inline
In-Reply-To: <76c5b8581002021655k5f63b81h1c55ae87625fbfc5@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1/OYmMfc5Umh5OXa7zslY+ZBwEnY8tJX/aiTY2
 tE1QbEvMZlQesPc5rW5hiLWW0lnOovP8467PGqqKMalzkXQiqN
 qgMbr+xrH1hWzOAEM+V+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138799>

On Tue, Feb 02, 2010 at 07:55:31PM -0500, Eugene Sajine wrote:
> On Tue, Feb 2, 2010 at 7:16 PM, Erik Faye-Lund <kusmabite@googlemail.=
com> wrote:
> > On Wed, Feb 3, 2010 at 12:48 AM, Eugene Sajine <euguess@gmail.com> =
wrote:
> >>>
> >>> This is where you're wrong. The reason why commit (without --amen=
d) is
> >>> aborting when you don't save is that the default commit message i=
s
> >>> empty, not that it wasn't saved. In fact, just saving still makes=
 in
> >>> abort. You need to add something to the commit message and then s=
ave
> >>> to get it to perform the commit.
> >>>
> >>>> Same should be applied to rebase -i and of course to commit --am=
end as
> >>>> it is still commit operation.
> >>>>
> >>>
> >>> "rebase -i" and "commit --amend" already has the exact same logic=
 as
> >>> commit without ammend in this regard - they abort if the buffer i=
s
> >>> empty.
> >>>
> >>> --
> >>> Erik "kusma" Faye-Lund
> >>>
> >>
> >> Thank you, but I'm not wrong, as i described the exact same thing
> >> somewhere in my second or third message, without even knowing the
> >> implementation details. I understand the reason WHY it is like it =
is,
> >> i just don't like it as it is inconsistent and IMHO incorrect.
> >>
> >
> > But you are. The interface isn't inconsistent. Your model of how it
> > works however, is wrong.
> >
> > --
> > Erik "kusma" Faye-Lund
> >
>=20
> I'm sorry, but I don't get in which part my model is so wrong? The on=
ly
> difference i see between your and my explanation is that you mentione=
d the
> fact that simply saving the pregenerated new commit message is not wo=
rking
> because there is no meaningful (uncommented) string inserted into the
> template. But this
> doesn't change the problem it self, so I don't think it is relevant.
>=20
> What is relevant though is that in current workflow with "rebase -i"
> you have to remove! all
> commits listed for rebase and save! the file in order to cancel! reba=
se
> operation. This is very strange user interaction model IMHO
>=20
> Instead of being explicit in applying the changes, we are explicit in
> cancelling the operation. Very strange...

No.  In case of rebase -i, exiting the editor is being explicit in
"the todo file now contains what you should do, so do it".  And if the
todo file happens to be empty, then there is nothing to do, so do
nothing.  The same applies to commit and commit --amend: exiting the
editor is being explicit in "the COMMIT_MSG file now contains what you
should put in the commit message".  But not having a commit message is
a really bad idea, therefore git complains and doesn't do that (unless
overridden by some command line option).


Best,
G=E1bor
