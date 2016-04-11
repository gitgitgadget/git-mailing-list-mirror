From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/4] rebase -i: add ack action
Date: Mon, 11 Apr 2016 22:03:39 +0200
Message-ID: <vpqr3ebnc9w.fsf@anie.imag.fr>
References: <alpine.DEB.2.20.1604111736060.2967@virtualbox>
	<20160411184535-mutt-send-email-mst@redhat.com>
	<xmqqlh4krkop.fsf@gitster.mtv.corp.google.com>
	<20160411225222-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, bafain@gmail.com, sunshine@sunshineco.com
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 22:04:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1api4T-0007JS-Eo
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 22:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbcDKUDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 16:03:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52987 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbcDKUDx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 16:03:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u3BK3bKV024580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 11 Apr 2016 22:03:37 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3BK3dor007430;
	Mon, 11 Apr 2016 22:03:39 +0200
In-Reply-To: <20160411225222-mutt-send-email-mst@redhat.com> (Michael S.
	Tsirkin's message of "Mon, 11 Apr 2016 22:55:27 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 11 Apr 2016 22:03:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3BK3bKV024580
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461009818.50906@LOEgT0XMxL16Upelje61tA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291232>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Apr 11, 2016 at 12:48:22PM -0700, Junio C Hamano wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > Repost, sorry about the noise.
>> >
>> > On Mon, Apr 11, 2016 at 05:36:45PM +0200, Johannes Schindelin wrote:
>> >> Hi Michael,
>> >> 
>> >> On Mon, 11 Apr 2016, Michael S. Tsirkin wrote:
>> >> 
>> >> > So far I only see examples of adding footers. If that's all we can think
>> >> > up, why code in all this genericity?
>> >> 
>> >> Because as far as I can see, the only benefitor of your patches would be
>> >> you.
>> >> 
>> >> Ciao,
>> >> Johannes
>> >
>> > This seems unlikely.  Just merging the patches won't benefit me directly
>> > - I have maintained them in my tree for a couple of years now with very
>> > little effort.  For sure, I could benefit if they get merged and then
>> > someone improves them further - that was the point of posting them - but
>> > then I'm not the only benefitor.
>> >
>> > The workflow including getting acks for patches by email is not handled
>> > well by upstream git right now.  It would surprise me if no one uses it
>> > if it's upstream, as you seem to suggest.  But maybe most people moved
>> > on and just do pull requests instead.
>> 
>> I doubt I would use this in its current form myself.
>> 
>> Patch series I receive are all queued on their own separate topic
>> branches, and having to switch branches only to create a fake empty
>> commit to record received Acked-by and Reviewed-by is a chore that
>> serves only half of what needs to be done.
>
> Interesting. An empty commit would be rather easy to create on any
> branch, not just the current one, using git-commit-tree.

This "modify a branch without checking-it out" makes me think of "git
notes". It may make sense to teach "git rebase -i" to look for notes in
rebased commits and append them to the commit message when applying.
Just an idea, not necessarily a good one ;-).

> Does it sounds interesting if I teach
> git ack to get an active branch as a parameter?

I think "ack" is not a good name for this feature: you use it to append
"Acked-by", but it can be used to append any trailer (for example,
Reviewed-by: would make complete sense too). I think using a better name
would help the discussion (to remove the "it's my use-case" biais).
Perhaps "append"?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
