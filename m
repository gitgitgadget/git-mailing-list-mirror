From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 16:13:06 -0700
Message-ID: <7vzlt335a5.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
 <7vskywadum.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803112234470.2947@xanadu.home>
 <alpine.LSU.1.00.0803121833210.1656@racer.site>
 <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <47D83532.70103@nrlssc.navy.mil>
 <alpine.LSU.1.00.0803122058430.1656@racer.site>
 <47D83C53.7000602@nrlssc.navy.mil>
 <7vejaf65q0.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803122153440.1656@racer.site>
 <7vwso74p33.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803122348210.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:14:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZa91-0002EA-7N
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 00:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931AbYCLXNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 19:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755924AbYCLXNT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 19:13:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902AbYCLXNS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 19:13:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B67F1F93;
	Wed, 12 Mar 2008 19:13:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 731EB1F91; Wed, 12 Mar 2008 19:13:08 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803122348210.1656@racer.site> (Johannes
 Schindelin's message of "Wed, 12 Mar 2008 23:50:39 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77022>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Yuck; approxidate() returns ulong.  Can subtracting a ulong from another
>> ever go negative?
>> 
>> Besides, because there is no guarantee of the order of evaluation between
>> these two approxidate() calls, you may get +1 or -1 on the second boundary.
>> 
>> I think the reason why you did not catch it in your test is because your
>> tests are half complete; they test only what you wanted to catch
>> (misconfigured case) and do not test the other half (properly working
>> case).
>
> Yes, probably.  Of course, comparing a difference to 0 is absolutely 
> moronic.
>
> I should have written
>
> 				approxidate(value) >= approxidate("now"))
>
> in the first place.

Eh, sorry, but why?

> So, could you tell me, please, if I should resend the patch with your 
> --prune documentation, or without?

I like Nico's suggestion to put that "historical notes" in RelNotes, so
the documentation part is fine as is.
