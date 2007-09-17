From: Junio C Hamano <gitster@pobox.com>
Subject: Re: metastore
Date: Sun, 16 Sep 2007 17:58:05 -0700
Message-ID: <7vk5qq3y76.fsf@gitster.siamese.dyndns.org>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151507310.28586@racer.site>
	<20070915145437.GA12875@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151430040.5298@iabervon.org>
	<Pine.LNX.4.64.0709152310380.28586@racer.site>
	<Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm>
	<7vwsur590q.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709161245490.24221@asgard.lang.hm>
	<7v7imq5ki0.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709161541330.24221@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Sep 17 02:58:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX4wU-00048l-3K
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 02:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbXIQA6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 20:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754611AbXIQA6T
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 20:58:19 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:50052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593AbXIQA6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 20:58:18 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D06C1365E0;
	Sun, 16 Sep 2007 20:58:29 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709161541330.24221@asgard.lang.hm>
	(david@lang.hm's message of "Sun, 16 Sep 2007 15:52:23 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58372>

david@lang.hm writes:

> On Sun, 16 Sep 2007, Junio C Hamano wrote:
>>
>> I do not think there is nothing that writes file contents to
>> stdout/pager other than "git cat-file" or "git show"; I do not
>> think they are what you have in mind when talking about managing
>> the files under /etc.  So unfortunately I do not understand the
>> rest of the discussion you made in your message.
>
> Ok, I thought that there was common code for these different
> uses. could you re-read the rest of the logic based on the change
> being done in checkout_entry?
>
> if you are unwilling to have any changes made to the checkout_entry
> code then the only remaing question is what you think of Daniel's
> suggestion to have a hook to replace check_updates()?
>
> if it's not acceptable either then we are down to doing a
> post-checkout trigger.

Post-checkout trigger is something I can say I can live with
without looking at the actual patch, but that does not mean it
would be a better approach at all.

I would not be able to answer the first question right now; that
needs a patch to prove that it can be done with a well contained
set of changes that results in a maintainable code.

I haven't tried to assess the potential extent of damage needed
to checkout_entry(), and I have never been interested in this
"keeping track of /etc in place" topic myself.  It is unlikely
I'll try to come up with such a patch on my own to support it at
such a low level near the core.  Somebody who cares about that
feature needs to take the initiative of doing that work before
we can discuss and decide, although older-times including myself
can help spot potential issues.

So while I admit I am skeptical, consider me neither willing nor
unwilling at this point.
