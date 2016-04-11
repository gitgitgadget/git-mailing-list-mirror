From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/4] rebase -i: add ack action
Date: Mon, 11 Apr 2016 22:55:27 +0300
Message-ID: <20160411225222-mutt-send-email-mst@redhat.com>
References: <alpine.DEB.2.20.1604111736060.2967@virtualbox>
 <20160411184535-mutt-send-email-mst@redhat.com>
 <xmqqlh4krkop.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, bafain@gmail.com, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 21:55:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aphvt-00039p-Su
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 21:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbcDKTzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 15:55:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38902 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311AbcDKTzc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 15:55:32 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDAE57304B;
	Mon, 11 Apr 2016 19:55:30 +0000 (UTC)
Received: from redhat.com (vpn1-5-155.ams2.redhat.com [10.36.5.155])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3BJtS0N001916;
	Mon, 11 Apr 2016 15:55:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlh4krkop.fsf@gitster.mtv.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 11 Apr 2016 19:55:31 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291231>

On Mon, Apr 11, 2016 at 12:48:22PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Repost, sorry about the noise.
> >
> > On Mon, Apr 11, 2016 at 05:36:45PM +0200, Johannes Schindelin wrote:
> >> Hi Michael,
> >> 
> >> On Mon, 11 Apr 2016, Michael S. Tsirkin wrote:
> >> 
> >> > So far I only see examples of adding footers. If that's all we can think
> >> > up, why code in all this genericity?
> >> 
> >> Because as far as I can see, the only benefitor of your patches would be
> >> you.
> >> 
> >> Ciao,
> >> Johannes
> >
> > This seems unlikely.  Just merging the patches won't benefit me directly
> > - I have maintained them in my tree for a couple of years now with very
> > little effort.  For sure, I could benefit if they get merged and then
> > someone improves them further - that was the point of posting them - but
> > then I'm not the only benefitor.
> >
> > The workflow including getting acks for patches by email is not handled
> > well by upstream git right now.  It would surprise me if no one uses it
> > if it's upstream, as you seem to suggest.  But maybe most people moved
> > on and just do pull requests instead.
> 
> I doubt I would use this in its current form myself.
> 
> Patch series I receive are all queued on their own separate topic
> branches, and having to switch branches only to create a fake empty
> commit to record received Acked-by and Reviewed-by is a chore that
> serves only half of what needs to be done.

Interesting. An empty commit would be rather easy to create on any
branch, not just the current one, using git-commit-tree.
Does it sounds interesting if I teach
git ack to get an active branch as a parameter?


> Once I decide to switch
> back to the topic branch after receiving Acked-by and Reviewed-by,
> I'd rather "rebase -i" to directly record them at that point, with
> "reword".
> 
> If the "trailers" stuff is packaged into an easier-to-use format to
> use with "git commit --amend", I may use that together with "exec"
> to automatically add these while doing so, but again, I do not see
> any need for fake empty commits out of received e-mails in the
> resulting workflow.
> 
> That does not at all mean nobody other than Michael would use it,
> though.
