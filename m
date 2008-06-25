From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Wed, 25 Jun 2008 13:48:11 -0700
Message-ID: <7vd4m5z1f8.fsf@gitster.siamese.dyndns.org>
References: <20080624222105.GA24549@dervierte> <48620C1A.6000509@panasas.com>
 <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net>
 <alpine.DEB.1.00.0806251334060.9925@racer> <20080625135100.GF20361@mit.edu>
 <7v63rx2zwf.fsf@gitster.siamese.dyndns.org> <20080625195003.GB15077@mit.edu>
 <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com>
 <7vlk0tz33n.fsf@gitster.siamese.dyndns.org>
 <32541b130806251322l478faa87gc9f2016254689022@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Theodore Tso" <tytso@mit.edu>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Boaz Harrosh" <bharrosh@panasas.com>,
	"Steven Walter" <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:49:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBbvl-0000df-7L
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYFYUsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbYFYUsd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:48:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbYFYUsc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:48:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A0F494C80;
	Wed, 25 Jun 2008 16:48:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7EC3849DB; Wed, 25 Jun 2008 16:48:16 -0400 (EDT)
In-Reply-To: <32541b130806251322l478faa87gc9f2016254689022@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 25 Jun 2008 16:22:29 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 110E32B2-42F8-11DD-9A65-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86344>

"Avery Pennarun" <apenwarr@gmail.com> writes:

>>   * You say "git checkout -- file" when you want to "check out the file
>>    from the index";
>
> The real question here is the --.  Is it strictly needed?  It's
> optional in things like git-diff, which just do their best to guess
> what you mean if you don't use the --.

No, I wrote -- only for clarity, because you can happen to have a branch
whose name is the same as the file.  Otherwise you can safely omit it,
just like git-diff and any other commands that follow the -- convention.

I have a work tree that has an untracked file HEAD and master just to
catch script breakages that forgets to place -- in appropriate places when
they deal with user supplied pathnames.
