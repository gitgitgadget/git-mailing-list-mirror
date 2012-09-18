From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Using Format/export-subst Howto.
Date: Tue, 18 Sep 2012 10:24:24 +0200
Message-ID: <50582FB8.7030809@drmicha.warpmail.net>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov> <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net> <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov> <50534FC6.2040207@viscovery.net> <1347656962.3998.140661128069097.6D9BE3C4@webmail.messagingengine.com> <7vfw6k2t8w.fsf@alter.siamese.dyndns.org> <7v7grw2qcu.fsf@alter.siamese.dyndns.org> <505722DD.3000806@drmicha.warpmail.net> <7v4nmwv1rr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"Mestnik\, Michael J - Eagan\, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:24:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDt73-0000dt-3B
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 10:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab2IRIYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 04:24:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39032 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757413Ab2IRIY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 04:24:27 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3BCC020AD7;
	Tue, 18 Sep 2012 04:24:26 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 18 Sep 2012 04:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=5uk6Vy2bVTmlohnahNq3J3
	5Qul0=; b=pETsxEd6NQWmZdwh5N3l9Ta1Z73DfTbwc+NWY6D87cq+yKclBxkkHU
	MvJV/jrPL5CTbPWNYd3lPIYfrnFy0aK/VdduZlEqYpHERvgivFudKpfbBiv3Jk2Y
	X35ayZUQ4TdQm5I684R8JMw08fV4U60S1o/zobsCwuYSA81Je5gHI=
X-Sasl-enc: A3d77YXMhA/rWV0G6ufsQwnCy5sSbF9T+f7kpNWbUZRV 1347956665
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 72356483805;
	Tue, 18 Sep 2012 04:24:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7v4nmwv1rr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205813>

Junio C Hamano venit, vidit, dixit 17.09.2012 22:21:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Junio C Hamano venit, vidit, dixit 15.09.2012 00:26:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>>
>>>>> you need to "rm file && git checkout file"). If the user has to
>>>>> update $Id$ to match the current sha1 (by remembering to do a
>>>>> more forceful checkout than checkout -f) then one half of that
>>>>> feature is useless.
>>>>
>>>> As if there is any value in "$Id$" _feature_.  It's a checkbox
>>>> item, nothing more ;-).
>>>
>>> Having said that, I think you could do something along this line (I 
>>> am thinking aloud, so there may be leaps in the logic below).
>>> ...
>>
>> You've convinced me not to try this in-core...
> 
> Quite contrary, I think the approach outlined is a reasonable way
> forward.  I do not care about a checkbox feature like $Id$ that is
> incomatible with the fundamental concept in Git, but the approach
> would help people who started their history with wrong CRLF
> settings, tweak the attributes and then scratch their head trying to
> repeatedly run "checkout", "reset --hard", etc. and still never
> seeing the right thing to happen.
> 

Maybe I should have said "...not to try this myself..." to make it
clearer: The approach you outlined sounds not only reasonable but the
perfect solution to this and other problems. But it's over my head and
time limit (and it's not my itch either). It touches the inner core
(index format and handling) and needs to be done diligently, too much
for a quick patch on the side of my $DAYJOB. (Though, thinking about it:
some colleagues use a similar hg feature to revision stamp their LaTeX
preprints, and working Id could help win them over.)

Michael
