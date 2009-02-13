From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Virtual PATCH] Add an option to wrap a patch in <pre> in   git-imap-send
 which ironically results in a cleaner patch from Thunderbird.
Date: Fri, 13 Feb 2009 12:24:16 +0100
Message-ID: <49955860.80504@drmicha.warpmail.net>
References: <499446D0.90602@codeweavers.com> <7viqnfezo5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeremy White <jwhite@codeweavers.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 12:25:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXwB8-0005GE-7y
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 12:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbZBMLYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 06:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbZBMLYY
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 06:24:24 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:59795 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751306AbZBMLYY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Feb 2009 06:24:24 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 2ADA9294B97;
	Fri, 13 Feb 2009 06:24:22 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 13 Feb 2009 06:24:22 -0500
X-Sasl-enc: ITdFEAkcSiu1kEpCh6KeBd+yQOJ5jMg8mIloHfohgmEL 1234524261
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 47C85FF2F;
	Fri, 13 Feb 2009 06:24:21 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090209 Shredder/3.0b2pre
In-Reply-To: <7viqnfezo5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109741>

Junio C Hamano venit, vidit, dixit 13.02.2009 05:19:
> I do not think of a reason, other than to trigger the workaround you
> mentioned in the documentation part of the patch, why any sane user would
> want to send a patch as HTML.  This configuration variable sounds more
> like "imap.forceThunderbirdToSendNonFlowedTextByExploitingItsBug" than
> "imap.html", in other words.
> 
> What worries me the most is if there is any guarantee that this bug you
> are exploiting to force it to send a patch in the common denominator
> format _will not be fixed_ in future versions of Thunderbird.

It's not a bug, it's a feature ;)

In fact it really is: preformatted text in HTML (<pre>) is by definition
left alone. Now, when you are about to send an HTML mail TB asks you
what to do (or takes a choice from preferences/addressbook): send as
HTML, as text or both.

The fact that the current HTML->text converter respects preformated text
without reflowing (and without f-f, which would allow reflowing on the
receiving side) is a feature. TB trys to represent the HTML in text form
as closely as possible.

> I see your patch deals only with ampersand, less-than, greater-than and
> dquot.  Do you know if this is enough, or would letters outside US-ASCII
> need to be expressed in ampersand-hash "character reference" notation?

According to Ben of Mozilla fame this is enough for special characters.
I don't know about UTF-8, though. Usually, TB recognizes the proper
encoding.

Michael J Gruber
