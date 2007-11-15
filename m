From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Thu, 15 Nov 2007 09:51:01 +0100
Message-ID: <473C0875.3020805@op5.se>
References: <86k5on8v6p.fsf@lola.quinscape.zz>	<20071112131927.GA1701@c3sl.ufpr.br>	<Pine.LNX.4.64.0711121355380.4362@racer.site>	<200711121719.54146.wielemak@science.uva.nl>	<Pine.LNX.4.64.0711121624330.4362@racer.site>	<vpq3avbv2ju.fsf@bauges.imag.fr>	<Pine.LNX.4.64.0711121715090.4362@racer.site>	<18232.35893.243300.179076@lisa.zopyra.com>	<Pine.LNX.4.64.0711121727130.4362@racer.site>	<vpq7iknqrtp.fsf@bauges.imag.fr>	<Pine.LNX.4.64.0711121755460.4362@racer.site>	<vpqy7d3pck0.fsf@bauges.imag.fr>	<Pine.LNX.4.64.0711121804400.4362@racer.site>	<vpqoddzpc88.fsf@bauges.imag.fr>	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>	<87myth58r5.fsf@osv.gnss.ru>	<7vfxz8hbcf.fsf@gitster.siamese.dyndns.org> <85mytg1f6n.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Sergei Organov <osv@javad.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:51:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsaRe-0001z5-3m
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 09:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759954AbXKOIvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 03:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755516AbXKOIvI
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 03:51:08 -0500
Received: from mail.op5.se ([193.201.96.20]:59627 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759891AbXKOIvG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 03:51:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A2AC61F08719;
	Thu, 15 Nov 2007 09:51:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZgbbsgNikYmD; Thu, 15 Nov 2007 09:51:03 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id C2F511F08716;
	Thu, 15 Nov 2007 09:51:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <85mytg1f6n.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65091>

David Kastrup wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> But cloning void to start the same project by multiple people
>> and pushing their initial commits as roots to start a project
>> indicates the lack of developer communication (besides, it just
>> feels like a bad style, a hangover from centralized SCM
>> mentality, but that is fine).
> 
> I do not like the approach of policy by force.  It assumes that the
> developers know better than the users what the users are going to do
> with git.
> 

Junio just said "but that is fine", so afaiu he's not against allowing
it per se. It's just that him and the other frequent contributors don't
have this particular problem, so if *they* fix it it will
a) Not be done with enthusiasm, and it would indeed drain enthusiasm and
   happiness from the project.
b) Perhaps not be done the way those who want this feature would like it.
c) Take another scarce resource (time) from other, more pressing issues
   which may or may not affect your workflow too.

Junio also suggested what's likely to be needed for this to work "properly",
ie, an extension to the git protocol to let it transfer symref content.

Since empty repositories have HEAD pointing to refs/heads/master by default,
you might get away with a simpler implementation.

> For example, I use git for tracking and versioning installations and
> updaters of complex programs.  They are basically built into a directory
> tree, and this tree is checked into a bare repository in a branch
> corresponding to a particular customer.  The trees are _target_ trees
> created completely by something akin to make install.  So every checkin
> is from scratch.  The checkins for a particular customer happen in one
> branch so that it is easy to generate a diff and from that an updater
> (the diff gets converted into a batch file removing old files and a zip
> file unpacking new files over the old ones).
> 
> There simply is no common reference/starting point for the disparate
> branches.  I have some "README" in master, but that is an utterly stupid
> and unnatural starting point.
> 
> One might argue that one should use one repository per customer and just
> share the objects (many of which are similar).  But that disallows
> making diffs between the trees of different customers.  Since the
> purpose of git here is just to track history and not do any sort of
> merging or rebasing, there are no interesting ancestry connections
> between branches.
> 
> Am I stupid for using git for this sort of thing?  I believe not.  And
> yet git developers choose to call me stupid because my work flow does
> not lend any sense to a common ancestor commit.
> 

Not stupid, but most likely unusual. Optimizing git for your needs would
imho be a bad idea. It's perfectly fine to use a tool for something else
than what it was intended for, but then you'll have to live with the
fact that it *will* have a few shortcomings and that you'll have to work
around them or fix them yourself.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
