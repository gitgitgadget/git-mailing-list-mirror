From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dubious format-patch options
Date: Thu, 12 Jun 2008 20:01:45 -0700
Message-ID: <7vtzfyxckm.fsf@gitster.siamese.dyndns.org>
References: <E1K6xrt-00033S-2J@jdl.com>
 <alpine.LFD.1.10.0806121923400.2949@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@jdl.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 05:02:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6zYw-00065J-B0
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 05:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757110AbYFMDB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 23:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757191AbYFMDB4
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 23:01:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757108AbYFMDB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 23:01:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DC7C73452;
	Thu, 12 Jun 2008 23:01:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 33A313451; Thu, 12 Jun 2008 23:01:50 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806121923400.2949@woody.linux-foundation.org>
 (Linus Torvalds's message of "Thu, 12 Jun 2008 19:24:18 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 13A7F056-38F5-11DD-B773-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84824>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 12 Jun 2008, Jon Loeliger wrote:
>> 
>>     $ git format-patch -1 --stdout --color master
>> 
>> But I seriously doubt that we _really_ want to send a
>> patch that has the embedded escape sequences in it:
>
> Hey, you asked for it, you got it. I hope you're not complaining.

Well, having said and heard all that, coming back to our more serious
selves...

I think being able to do

    $ git -p format-patch --stdout --color -2 HEAD

makes some sense.  Being able to produce an unusable patch by saying

    $ git format-patch --stat old..

at the first glance is of quite dubious value, but even that would make
sense as a good input source for "commit log automailer".

I think I know where Jon is coming from and where he wants to go.  While I
am somewhat sympathetic to the cause of adding some warning or safety
valve to prevent nonsense option combinations from being given, I am not
sure we can draw a line to classify options into black and white.
