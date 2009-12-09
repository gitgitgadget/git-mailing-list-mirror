From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: help: bisect single file from repos
Date: Wed, 9 Dec 2009 02:28:55 +0100
Message-ID: <20091209012855.GA3208@neumann>
References: <4B1CFC4C.6090406@bfs.de> <4B1D1A5A.9060004@drmicha.warpmail.net>
	<4B1D27B6.7010900@bfs.de>
	<200912080917.17220.chriscool@tuxfamily.org>
	<4B1E5796.2090201@bfs.de> <7vein5e2lc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Michael J Gruber <git@drmicha.warpmail.net>, wharms@bfs.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 02:29:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIBMi-0004Od-Gs
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 02:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967086AbZLIB24 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 20:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967076AbZLIB24
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 20:28:56 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:53970 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967072AbZLIB2z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 20:28:55 -0500
Received: from [127.0.1.1] (p5B1309F9.dip0.t-ipconnect.de [91.19.9.249])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LwGGE-1O9GDe2KmU-017UcL; Wed, 09 Dec 2009 02:28:58 +0100
Content-Disposition: inline
In-Reply-To: <7vein5e2lc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1/7vhgxZ+HTRQzU9QIvb262FoaD3/k53diPAfL
 9o9QlmiBkphL/d6JatQtur4431bnPmOhce2OoTYJyV4O9BYjzM
 aN4B//hQP8W6+tCYd5anw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134929>

Hi,


On Tue, Dec 08, 2009 at 10:35:11AM -0800, Junio C Hamano wrote:
> But I wonder if there is
> something we _could_ have done better in the documentation area to av=
oid
> this from the beginning, iow, make it easier to "learn how things wor=
k
> before using"?  I think there is a lesson to be learned by us in here=
, and
> I'd like to hear comments and improvement suggestions, especially fro=
m
> "usability" and "friendly to new people" advocates.

when a git command accepts a commit as command line option, the
documentation usually refers to the "Specifying revisions" section of
'git rev-parse's docs for "a more complete list of ways to spell
commits"[1].  Even the docs of porcelain commands and the user manual
do that.  But 'git rev-parse' is plumbing, and we actively advertise
that avarage users don't really need to know about plumbing at all.
While new to git I repeatedly encountered this reference to 'git
rev-parse' all over the porcelain manpages, and it was a real burden
for me back then.  I was like "but I don't want to know about all the
glory details, just give me a short summary".

I think the user should not refer to plumbing manpages to be able to
use porcelain commands.  Therefore, the manpage of every command
accepting a commit option need to have a section about specifying
these commits.  This section doesn't need to be as detailed as 'git
rev-parse'; perhaps we don't need to discuss the ^{} notation there.
Also, the precedence in case of an ambiguous symbolic ref name should
be described without reference to the internal $GIT_DIR/refs/
directory structure.

=46urthermore, some manpages use the term "<commit>", while others
"<committish>" or "<rev>".  The same term should be used everywhere.


Best,
G=E1bor


[1] - 'git cherry-pick' doc says the following:

  <commit>
    Commit to cherry-pick. For a more complete list of ways to spell
    commits, see the "SPECIFYING REVISIONS" section in git-rev-parse(1)=
=2E

What?  "A _more_ complete list"!?  Well, it's not very hard to be more
complete than this, there is not a single way described here (;
