From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] git-send-email: provide hook to send lines more than 998 symbols
Date: Fri, 21 Nov 2008 12:52:33 +0200
Message-ID: <87wsex4aha.fsf@iki.fi>
References: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com>
	<1227263693.3311.0.camel@therock.nsw.bigpond.net.au>
	<5ec8ebd50811210237kd6f9341q23bc69b6ffcc2a87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arafangion <thestar@fussycoder.id.au>, git@vger.kernel.org
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 11:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3TeE-0007ZO-3L
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 11:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbYKUKwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 05:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbYKUKwq
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 05:52:46 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:48357 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbYKUKwp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 05:52:45 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 48FC59C701892211; Fri, 21 Nov 2008 12:52:35 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1L3Tcn-0001Av-A6; Fri, 21 Nov 2008 12:52:33 +0200
In-Reply-To: <5ec8ebd50811210237kd6f9341q23bc69b6ffcc2a87@mail.gmail.com> (Andy Shevchenko's message of "Fri\, 21 Nov 2008 12\:37\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101509>

Andy Shevchenko (2008-11-21 12:37 +0200) wrote:

> On Fri, Nov 21, 2008 at 12:34 PM, Arafangion <thestar@fussycoder.id.au> wrote:
>>> By default git-send-email does not accept patch which is contain
>>> lines longer than 998 symbols. Sometime it's inconvenient, i.e. you
>>> have a long list in one variable in shell script. So, define
>>> environment variable GIT_SEND_EMAIL_LONGLINE to something to avoid
>>> that restriction.
>>
>> As a curiosity, why is such a check even neccessary?

> I'm not an author of that strange check (possible it's somehow related
> to b8ebe08b9a643f432866eb7150c3b20d59b755f2)

The author (so to say) of that strange check is RFC 2822 - Internet
Message Format.

    2.1.1. Line Length Limits

        There are two limits that this standard places on the number of
        characters in a line. Each line of characters MUST be no more
        than 998 characters, and SHOULD be no more than 78 characters,
        excluding the CRLF.

        The 998 character limit is due to limitations in many
        implementations which send, receive, or store Internet Message
        Format messages that simply cannot handle more than 998
        characters on a line. [...]

http://www.faqs.org/rfcs/rfc2822.html

Perhaps longer lines will work in many cases but atleast warning should
be printed to user, or something.
