From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Mon, 15 Apr 2013 10:59:20 +0100
Message-ID: <20130415095920.GE2278@serenity.lan>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
 <7v38uvcrjl.fsf@alter.siamese.dyndns.org>
 <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
 <7vehed7ilu.fsf@alter.siamese.dyndns.org>
 <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
 <7vppxw335o.fsf@alter.siamese.dyndns.org>
 <516BA732.4080405@viscovery.net>
 <7vzjx01cqn.fsf@alter.siamese.dyndns.org>
 <20130415083558.GB2278@serenity.lan>
 <7vk3o416rq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:59:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URgCH-0003D0-2h
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab3DOJ7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 05:59:33 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:39395 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab3DOJ7c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:59:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 0DC0E60656E;
	Mon, 15 Apr 2013 10:59:32 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GGOpHTzFR09u; Mon, 15 Apr 2013 10:59:31 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 0A01A6064AA;
	Mon, 15 Apr 2013 10:59:22 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vk3o416rq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221219>

On Mon, Apr 15, 2013 at 02:29:29AM -0700, Junio C Hamano wrote:
>  - Your "branch.*.remote only kicks in when I do not say either what
>    to push or where to push to, so 'git push -- master' won't be
>    affected" could be one valid natural extension to your knowledge
>    "the config only kicks in when I do not say either".
> 
>  - Peff's "'git push' chooses to push to branch.next.remote when I
>    am on 'next', so 'git push -- master' run in the same state
>    should also push to that place" is another equally valid natural
>    extension to his knowledge that "'git push' chooses to push to
>    branch.next.remote when I am on 'next'".
> 
>  - Ram's and my "branch.master.remote is about what remote my master
>    branch integrates with, so no matter where I am, 'git push' that
>    does not say where-to should push out my master to that remote"
>    is yet another equally valid natural extension to our knowledge
>    that ""branch.master.remote is about what remote my master branch
>    integrates with".
> 
> I do not think it is a red-herring at all. It is not about
> "breaking", but "there will be multiple, conflicting and equally
> plausible expectations" that makes me worry about unnecessary
> confusion.

Okay, I think it's a red herring from my point of view that "this is
something new that is very different from the current functionality",
but as you point out, "no arguments vs. some arguments" is only one
potential internal model of the current behaviour.

So the question is "what is the natural extension of the current
behaviour?", and the answer for me is "it's completely new", but others
have different (and conflicting) internal models that give different
answers.
