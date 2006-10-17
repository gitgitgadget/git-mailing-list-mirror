From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 21:12:54 +0200
Organization: At home
Message-ID: <eh39uk$k06$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <Pine.LNX.4.63.0610170128350.14200@wbgn013.biozentrum.uni-wuerzburg.de> <4534656B.7080105@utoronto.ca> <7v64ejqx3a.fsf@assigned-by-dhcp.cox.net> <20061017185225.GE2867@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 17 21:13:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZuNP-0005dV-Qj
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 21:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWJQTNR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 15:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWJQTNQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 15:13:16 -0400
Received: from main.gmane.org ([80.91.229.2]:10632 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750752AbWJQTNQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 15:13:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZuMw-0005Vo-Fv
	for git@vger.kernel.org; Tue, 17 Oct 2006 21:12:54 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 21:12:54 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 21:12:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29106>

J. Bruce Fields wrote:

> On Mon, Oct 16, 2006 at 11:23:53PM -0700, Junio C Hamano wrote:
>> Aaron Bentley <aaron.bentley@utoronto.ca> writes:
>> 
>> > Johannes Schindelin wrote:
>> >
>> >>> You'll note we referred to that bevhavior on the page.  We don't think
>> >>> what Git does is the same as supporting renames.  AIUI, some Git users
>> >>> feel the same way.
>> >> 
>> >> Oh, we start another flamewar again?
>> >
>> > I'd hope not.  It sounds as though you feel that supporting renames in
>> > the data representation is *wrong*, and therefore it should be an insult
>> > to you if we said that Git fully supported renames.
>> 
>> Not recording and not supporting are quite different things.
> 
> Yes.  There's a risk of confusing a feature with an implementation
> detail.  From http://bazaar-vcs.org/RcsComparisons:
> 
>       "If a user can rename a file in the RCS without loosing the RCS
>       history for a file, then renames are considered supported. If
>       the operation resultes in a delete/add (aka "DA pair"), then
>       renames are not considered supported. If the operation results
>       in a copy/delete pair, renames are considered "somewhat"
>       supported. The problem with copy support is that it is hard to
>       define sane merge semantics for copies."
> 
> The first sentence sounds like a description of a user-visible feature.
> The rest of it sounds like implementation.

The proper description would be: if we get history of file up to rename
unrelated to the history of file before rename ("DA pair"), where
"unrelated" means that SCM doesn't store this relation (or equivalent
information), renames are not considered supported. If we get full
history of file under new name, and unrelated history of file up to rename
("CD pair"), renames are not considered supported ;-)
 
> And git probably has some deficiencies here, but it'd be more useful to
> identify them in terms of things a user can't do.

For example:
 * if we rename (or delete) file on one branch, and then merge changes
   with other branch where such rename didn't make place, do merge do
   the correct thing.
 * can we get whole history of file, before and after rename. Can we do
   this automatically, in one go.
 * do renames are (can be) marked as such in diff output.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
