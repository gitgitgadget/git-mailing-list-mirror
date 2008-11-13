From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bugreport: git does not like subseconds
Date: Thu, 13 Nov 2008 09:09:34 -0800
Message-ID: <7v1vxfh7sh.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0811131722360.13330@fbirervta.pbzchgretzou.qr>
 <alpine.LFD.2.00.0811130842550.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Engelhardt <jengelh@medozas.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 18:12:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0fir-0001Xg-JO
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 18:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbYKMRJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 12:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbYKMRJ6
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 12:09:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56701 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbYKMRJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 12:09:57 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BD1EB16996;
	Thu, 13 Nov 2008 12:09:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B61C01698F; Thu, 13 Nov 2008 12:09:36 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E569C38E-B1A5-11DD-8F2B-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100889>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 13 Nov 2008, Jan Engelhardt wrote:
>> 
>> 
>> Git does not like subseconds in $GIT_{AUTHOR,COMMITTER}_DATE,
>> and somehow does time travel instead. Perhaps this is a Glibc
>> limitation? Running openSUSE 11's glibc-2.8(which is actually
>> a 2.7 snapshot I think: glibc-2.8-2008042513.tar.bz2).
>
> This should have been fixed by 9f2b6d2936a7c4bb3155de8efec7b10869ca935e 
> ("date/time: do not get confused by fractional seconds").
>
> But maybe that hasn't made it into any release yet? It's in master, but 
> maybe it never made it into stable? Junio?

No it didn't.

Actually I didn't even think of that as a bug, in the sense that git never
accepted fractional seconds and feeding such to git was a user error from
day one; iow, 9f2b6d2 (date/time: do not get confused by fractional
seconds, 2008-08-16) was an idiotproofing ;-)

But I'd agree perhaps we should cherry pick that one.
