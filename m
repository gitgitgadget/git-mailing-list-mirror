From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 22:16:51 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-FA4289.22165129012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <hjvgs1$rep$1@ger.gmane.org> <ron1-953427.13240429012010@news.gmane.org> <fabb9a1e1001291328s1df443d6jdf0501cda17072de@mail.gmail.com> <7vmxzwh906.fsf@alter.siamese.dyndns.org> <ron1-6C7BCB.14122429012010@news.gmane.org> <b4087cc51001291633l68760880i340d12e865641077@mail.gmail.com> <7vvdek70ma.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 07:17:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb6e0-0004hY-5l
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 07:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab0A3GRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 01:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277Ab0A3GRN
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 01:17:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:35648 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab0A3GRM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 01:17:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nb6dr-0004d4-9A
	for git@vger.kernel.org; Sat, 30 Jan 2010 07:17:11 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 07:17:11 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 07:17:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138452>

In article <7vvdek70ma.fsf@alter.siamese.dyndns.org>,
 Junio C Hamano <gitster@pobox.com> wrote:

> Michael Witten <mfwitten@gmail.com> writes:
> 
> > Isn't the difference between 'checkout' and 'reset' almost essentially
> > a matter of whether the branch reference (HEAD), index, and tree are
> > modified? Couldn't these commands be merged into one command or make
> > use of one command?
> 
> I don't think that reduces any confusion.

Ahem... as the confused one here I respectfully disagree.

> By exposing orthogonal options like --index, --head, etc., you are opening
> yourself to nonsensical combinations that were never possible with the
> existing command set, and I suspect it would make it even more confusing,
> not less.

No, because it would make it much easier to map intent back into a 
command that implements that intent.  Don't forget, this whole thing 
began because I wanted to do something very simple, tried what seemed to 
be the obvious way to do it, and stumbled accidentally on an advanced 
feature.  That would not have happened if I'd been able to just do a git 
update --tree master^.

> What does "git update --detach $commit" _really_ mean, for example?

What difference does that make?  Sure, there would be ways to shoot 
yourself in the foot with git update, but there is no shortage of ways 
to shoot yourself in the foot now.  And now if you shoot yourself in the 
foot you have to start by trying to figure out where the bullet came 
from.

BTW, nothing prevents you from providing the usual repertoire of 
higher-level functionality as thin layers on top of something like git 
update.

> You can of course say "it detaches the HEAD at $commit, but otherwise does
> not change anything else", but such a mechanical description does not give
> an answer that helps end users.  "What would I do after doing that?" and
> "What would I use this for?" are the questions they need an answer to.

Sure.  So document the combinations that make sense, and then say "You 
can mix and match the options in other ways, but you probably shouldn't 
unless you really know what you're doing."  Done.

> Flexibility and orthogonality is often good, but uncontrolled flexibility
> is not.

That seems to me to run directly counter to the design philosophy behind 
git.

rg
