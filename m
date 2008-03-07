From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9001: set TERM=dumb to prevent ANSI output
Date: Fri, 07 Mar 2008 09:40:22 -0800
Message-ID: <7vbq5q301l.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803061752340.3941@racer.site>
 <7vmypb8muj.fsf@gitster.siamese.dyndns.org>
 <200803070541.15793.chriscool@tuxfamily.org>
 <7v7igf5cpk.fsf@gitster.siamese.dyndns.org>
 <7vskz33vow.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803071240590.19395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 07 18:41:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXgZG-0001Vk-07
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 18:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757100AbYCGRke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 12:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756786AbYCGRkd
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 12:40:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbYCGRkd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 12:40:33 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 367021FF3;
	Fri,  7 Mar 2008 12:40:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5F6561FEB; Fri,  7 Mar 2008 12:40:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76504>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 6 Mar 2008, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Christian Couder <chriscool@tuxfamily.org> writes:
>> > ...
>> >> This may not work well with colored output.
>> >> In test-lib.sh line 62 there is :
>> >>
>> >> [ "x$TERM" != "xdumb" ] &&
>> >> 	[ -t 1 ] &&
>> >> 	tput bold >/dev/null 2>&1 &&
>> >> 	tput setaf 1 >/dev/null 2>&1 &&
>> >> 	tput sgr0 >/dev/null 2>&1 &&
>> >> 	color=t
>> >
>> > Ahh.  Sorry about that.
>> 
>> Ahem, third time lucky.
>
> Well, with this:
>
>>  t/test-lib.sh |   24 +++++++++++++++++-------
>
> I think it is no longer worth it _not_ to special-case it.  IOW I'd prefer 
> my original patch for simplicity.

Hmm.  Do you still prefer "patch individual" approach, even after
considering longer term maintainability?
