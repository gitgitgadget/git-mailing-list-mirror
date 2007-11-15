From: David Kastrup <dak@gnu.org>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Thu, 15 Nov 2007 02:16:16 +0100
Message-ID: <85mytg1f6n.fsf@lola.goethe.zz>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
	<87myth58r5.fsf@osv.gnss.ru>
	<7vfxz8hbcf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 02:23:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsTS7-00007Y-Sj
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 02:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250AbXKOBXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 20:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755827AbXKOBXP
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 20:23:15 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:49230 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274AbXKOBXO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 20:23:14 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IsTRm-0007Fr-Vg; Wed, 14 Nov 2007 20:23:11 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 4EC791C298C7; Thu, 15 Nov 2007 02:16:16 +0100 (CET)
In-Reply-To: <7vfxz8hbcf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 14 Nov 2007 11:32:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65040>

Junio C Hamano <gitster@pobox.com> writes:

> But cloning void to start the same project by multiple people
> and pushing their initial commits as roots to start a project
> indicates the lack of developer communication (besides, it just
> feels like a bad style, a hangover from centralized SCM
> mentality, but that is fine).

I do not like the approach of policy by force.  It assumes that the
developers know better than the users what the users are going to do
with git.

For example, I use git for tracking and versioning installations and
updaters of complex programs.  They are basically built into a directory
tree, and this tree is checked into a bare repository in a branch
corresponding to a particular customer.  The trees are _target_ trees
created completely by something akin to make install.  So every checkin
is from scratch.  The checkins for a particular customer happen in one
branch so that it is easy to generate a diff and from that an updater
(the diff gets converted into a batch file removing old files and a zip
file unpacking new files over the old ones).

There simply is no common reference/starting point for the disparate
branches.  I have some "README" in master, but that is an utterly stupid
and unnatural starting point.

One might argue that one should use one repository per customer and just
share the objects (many of which are similar).  But that disallows
making diffs between the trees of different customers.  Since the
purpose of git here is just to track history and not do any sort of
merging or rebasing, there are no interesting ancestry connections
between branches.

Am I stupid for using git for this sort of thing?  I believe not.  And
yet git developers choose to call me stupid because my work flow does
not lend any sense to a common ancestor commit.

> But this time, the "feature" is not a zero cost thing.  As
> Matthieu said in the thread, we do not let you do so right now.
> Which means that it would involve new development, the code
> changes would risk regressing behaviour existing users rely on,
> and we would need testing for that.  These all take resources.

And they will continue to take resources.  And since the trend goes more
and more into name-calling on those who still feel that their workflow
justifies disparate branches without common registered ancestry, it will
increasingly drain the most important resources of all: goodwill and
enthusiasm.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
