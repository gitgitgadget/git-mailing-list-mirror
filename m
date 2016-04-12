From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/4] rebase -i: add ack action
Date: Tue, 12 Apr 2016 10:51:02 +0300
Message-ID: <20160412104133-mutt-send-email-mst@redhat.com>
References: <alpine.DEB.2.20.1604111736060.2967@virtualbox>
 <20160411184535-mutt-send-email-mst@redhat.com>
 <xmqqlh4krkop.fsf@gitster.mtv.corp.google.com>
 <20160411225222-mutt-send-email-mst@redhat.com>
 <vpqr3ebnc9w.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, bafain@gmail.com, sunshine@sunshineco.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 12 09:51:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apt6R-0002Xo-69
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 09:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbcDLHvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 03:51:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59756 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755917AbcDLHvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 03:51:06 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB49D8AE72;
	Tue, 12 Apr 2016 07:51:05 +0000 (UTC)
Received: from redhat.com ([10.35.7.29])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3C7p3YC020247;
	Tue, 12 Apr 2016 03:51:03 -0400
Content-Disposition: inline
In-Reply-To: <vpqr3ebnc9w.fsf@anie.imag.fr>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291249>

On Mon, Apr 11, 2016 at 10:03:39PM +0200, Matthieu Moy wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Mon, Apr 11, 2016 at 12:48:22PM -0700, Junio C Hamano wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > Repost, sorry about the noise.
> >> >
> >> > On Mon, Apr 11, 2016 at 05:36:45PM +0200, Johannes Schindelin wrote:
> >> >> Hi Michael,
> >> >> 
> >> >> On Mon, 11 Apr 2016, Michael S. Tsirkin wrote:
> >> >> 
> >> >> > So far I only see examples of adding footers. If that's all we can think
> >> >> > up, why code in all this genericity?
> >> >> 
> >> >> Because as far as I can see, the only benefitor of your patches would be
> >> >> you.
> >> >> 
> >> >> Ciao,
> >> >> Johannes
> >> >
> >> > This seems unlikely.  Just merging the patches won't benefit me directly
> >> > - I have maintained them in my tree for a couple of years now with very
> >> > little effort.  For sure, I could benefit if they get merged and then
> >> > someone improves them further - that was the point of posting them - but
> >> > then I'm not the only benefitor.
> >> >
> >> > The workflow including getting acks for patches by email is not handled
> >> > well by upstream git right now.  It would surprise me if no one uses it
> >> > if it's upstream, as you seem to suggest.  But maybe most people moved
> >> > on and just do pull requests instead.
> >> 
> >> I doubt I would use this in its current form myself.
> >> 
> >> Patch series I receive are all queued on their own separate topic
> >> branches, and having to switch branches only to create a fake empty
> >> commit to record received Acked-by and Reviewed-by is a chore that
> >> serves only half of what needs to be done.
> >
> > Interesting. An empty commit would be rather easy to create on any
> > branch, not just the current one, using git-commit-tree.
> 
> This "modify a branch without checking-it out" makes me think of "git
> notes". It may make sense to teach "git rebase -i" to look for notes in
> rebased commits and append them to the commit message when applying.
> Just an idea, not necessarily a good one ;-).

Two things making it harder
	- machinery to look for commits is part of git rebase anyway
	- notes are expected to come after --- at the moment


> > Does it sounds interesting if I teach
> > git ack to get an active branch as a parameter?
> 
> I think "ack" is not a good name for this feature: you use it to append
> "Acked-by", but it can be used to append any trailer (for example,
> Reviewed-by: would make complete sense too).

Yes - I use it to append all trailers.

> I think using a better name
> would help the discussion (to remove the "it's my use-case" biais).
> Perhaps "append"?

Or "trailer".

> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
