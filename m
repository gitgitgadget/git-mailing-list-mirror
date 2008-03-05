From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shortlog: take the first populated line of the
 description
Date: Wed, 05 Mar 2008 13:27:21 -0800
Message-ID: <7vy78wlv46.fsf@gitster.siamese.dyndns.org>
References: <1204727050.0@pinky>
 <alpine.LFD.1.00.0803051346200.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX19p-0003K8-D1
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 22:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757219AbYCEV1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 16:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757270AbYCEV1e
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 16:27:34 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757219AbYCEV1d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 16:27:33 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D16D61C07;
	Wed,  5 Mar 2008 16:27:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1C7381C01; Wed,  5 Mar 2008 16:27:24 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76271>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 5 Mar 2008, Andy Whitcroft wrote:
> ...
>> 	...  I cannot think of any good reason not to take the first
>> 	populated line for a shortlog.	The alternative less agressive
>> 	compromise might be to skip only completly empty lines at the
>> 	start, but I am not sure that adds any value.
>> 
>> 	I seem to get a lot of these in converted SVN commits.
>> 
>> 	Comments?
>
> Maybe it is the SVN conversion that needs fixing?

I thought about saying the same, but I am of two minds.

It is likely that you would want to clean-up when importing,
especially when you are planning to abandon the other system and
switch to git.  But you may want to have an import that is as
close to the original as possible, excess blank lines in the log
messages and all.

I think Andy's fix to make the output side take away
unnecessary blank lines is unconditionally good.

I've added these three lines at the end of the log message.

    This is often useful when dealing with commits imported from foreign SCMs
    that do not tidy up the log message of useless blank lines at the
    beginning.
