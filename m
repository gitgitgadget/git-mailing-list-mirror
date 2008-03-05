From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shortlog: take the first populated line of the
 description
Date: Wed, 05 Mar 2008 14:14:10 -0800
Message-ID: <7vmypclsy5.fsf@gitster.siamese.dyndns.org>
References: <1204727050.0@pinky>
 <alpine.LFD.1.00.0803051346200.2947@xanadu.home>
 <7vy78wlv46.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803051638150.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:15:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX1tj-0007Sy-29
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 23:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763054AbYCEWO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 17:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763019AbYCEWO1
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 17:14:27 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763201AbYCEWOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 17:14:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A6F902346;
	Wed,  5 Mar 2008 17:14:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E6D9C2345; Wed,  5 Mar 2008 17:14:17 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0803051638150.2947@xanadu.home> (Nicolas
 Pitre's message of "Wed, 05 Mar 2008 16:47:29 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76275>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 5 Mar 2008, Junio C Hamano wrote:
>
>> I think Andy's fix to make the output side take away
>> unnecessary blank lines is unconditionally good.
>
> It is not "bad" in itself.  However that feels like papering over 
> another problem which IMHO has greater merits to be fixed.  We have 
> given special semantics to the first line of a commit log in many other 
> places now, so unless all those places are also made aware of 
> substandard commit logs too, I think it would be more productive to make 
> sure those logs are semi sensible upon entering Git in the first place 
> instead.

My understanding of the current status when I wrote that message
was that everybody at commit.c layer (that is, everybody except
shortlog) strips such garbage.  Do you have a specific broken
one in mind?

I suspect --pretty=format:%s might be broken; I didn't check.

