From: Bill Lear <rael@zopyra.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Wed, 14 Nov 2007 17:38:58 -0600
Message-ID: <18235.34578.886521.944550@lisa.zopyra.com>
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
	<18235.22445.16228.535898@lisa.zopyra.com>
	<Pine.LNX.4.64.0711142047170.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 00:39:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsRpQ-00010y-6R
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 00:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494AbXKNXjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 18:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756339AbXKNXjL
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 18:39:11 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60819 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756396AbXKNXjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 18:39:09 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lAENd6k14340;
	Wed, 14 Nov 2007 17:39:06 -0600
In-Reply-To: <Pine.LNX.4.64.0711142047170.4362@racer.site>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65026>

On Wednesday, November 14, 2007 at 20:58:29 (+0000) Johannes Schindelin writes:
>...
>I have a better idea:
>
>[the initial import, on another machine:]
>% mkdir new_repo
>% cd new_repo
>% git init
>[add content]
>% git commit -a -m "Initial stuff"
>% git remote add origin git://host/repo
>% git push origin master
>
>If you do not want to be bothered with setting up the default 
>"remote" and "merge" config variables manually, it is reasonable to ask 
>for support to do that in "git remote".

Um, ok, but the above means that this repo now differs from other
repos, in that pushing now involves more than 'git push', i.e.,
'git push origin master'.  Is there not a way to configure it "as if"
I had done a 'git clone' and thereafter could just do 'git push'?

I want to do: 1) point to origin; 2) push; and not have to remember
"oh yeah, this is that 'special' repo and I have to tack on 'origin
master' or it won't work", or to clone it somewhere else and work
there.

>If you really think that this workflow has anything to do with cloning an 
>empty repository, I cannot help you.  I mean, you did not need to clone 
>the big, empty void to do the initial commit, or did you?

I just want to point to it and treat it as if it had been cloned to
begin with: it is my future "point of origin".  If it is not cloning,
then it is "pointing to it as my origin", as if it were created by the
clone.

What's wrong with 'git init --mirror git://host/repo'?  Is it just
another special case that's busy work helping only a few, or does
it belong elsewhere in your opinion?

>(I actually think that it is another example of cvs/svn damage, where you 
>_need_ to clone first, or otherwise you will _never_ be able to commit 
>to the repository.)

I think there is a tendency here to blame every shortcoming of git on
someone else's supposedly unsanitary past rather than facing up to
inherent problems in git itself.  We have several very senior, very
dedicated software developers who LOVE git, and who loathe CVS, but
who nevertheless find many vexing issues in git.

>BTW I am somewhat disgusted by your usage of git:// for pushing.

Whatever.  We went through this before on the list and push support
was added to git://.  We have SUCKY sysadmin support at our company
and permissions were getting HOSED using ssh pushes.  The git://
protocol makes everything clean on the repo side and no nasty
surprises with permissions and no delays begging the support team to
clean things up.


Bill
