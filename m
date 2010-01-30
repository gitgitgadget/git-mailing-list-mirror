From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 23:31:48 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-0D3105.23314829012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <hjvgs1$rep$1@ger.gmane.org> <ron1-953427.13240429012010@news.gmane.org> <fabb9a1e1001291328s1df443d6jdf0501cda17072de@mail.gmail.com> <7vmxzwh906.fsf@alter.siamese.dyndns.org> <ron1-6C7BCB.14122429012010@news.gmane.org> <b4087cc51001291633l68760880i340d12e865641077@mail.gmail.com> <7vvdek70ma.fsf@alter.siamese.dyndns.org> <ron1-FA4289.22165129012010@news.gmane.org> <7vaavw1478.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 08:32:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb7oX-00079B-QY
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 08:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091Ab0A3HcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 02:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034Ab0A3HcM
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 02:32:12 -0500
Received: from lo.gmane.org ([80.91.229.12]:47707 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014Ab0A3HcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 02:32:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nb7oP-00073h-9H
	for git@vger.kernel.org; Sat, 30 Jan 2010 08:32:09 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 08:32:09 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 08:32:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138458>

In article <7vaavw1478.fsf@alter.siamese.dyndns.org>,
 Junio C Hamano <gitster@pobox.com> wrote:

> Ron Garret <ron1@flownet.com> writes:
> 
> > No, because it would make it much easier to map intent back into a 
> > command that implements that intent.  Don't forget, this whole thing 
> > began because I wanted to do something very simple, tried what seemed to 
> > be the obvious way to do it, and stumbled accidentally on an advanced 
> > feature.  That would not have happened if I'd been able to just do a git 
> > update --tree master^.
> 
> Doing that _will_ confuse you in your next step.  Can you explain what
> happens if you run "git commit" from that state,

Nothing.

> why "git commit" does so,

Because my index would be empty.

> and how that is useful?

It wouldn't.  Was this a trick question?  Did you mean to ask what would 
happen if I ran commit -a?

> You may be too narrowly focused on only one single step, but I am more
> worried about the whole user experience: "I managed to do this, I am
> happy, but then the next step doesn't make much sense.  Now what?"

I think you may be making some unwarranted assumptions about my end goal.

> > What difference does that make?  Sure, there would be ways to shoot 
> > yourself in the foot with git update, but there is no shortage of ways 
> > to shoot yourself in the foot now.
> 
> As long as you have a coherent picture of the workflow individual commands
> are supporting, there is no "shoot yourself in the foot".  "git update" on
> the other hand is _designed_ not to allow such a coherent picture to be
> formed in the user's head, by letting random combinations that may or may
> not make sense.

That is a valid point.  I guess this depends on whether you think of git 
as merely a revision control system for computer source code, or if you 
think of it as a more general tool that can and should be used in other 
kinds of applications as well.

> > BTW, nothing prevents you from providing the usual repertoire of 
> > higher-level functionality as thin layers on top of something like git 
> > update.
> 
> That is more or less the same as what I said in the footnote, which you
> didn't quote from my message.

Yes, sorry about that.

> The flexibility of "update" may help Porcelain writers to pick and use
> only useful/usable combinations to present "the usual repertoire" for end
> users.  At the philosophical level of "building blocks", I do not oppose
> to such flexibility [*1*].
> 
> But.
> 
> As the main point of Michael's message was that he thought it may make
> things less confusing to the end users, I am pointing out that unleashing
> such an uncontrolled flexibility directly to end users will _not_ help
> reduce their confusion.
> 
> [Footnote]
> 
> *1* As a set of "building blocks" to implement "reset" and "checkout", I
> don't necessarily agree that "update" would be a good way to go from the
> implementation standpoint, but that is a totally separate matter.

Did you mean "don't necessarily DISagree"?

rg
