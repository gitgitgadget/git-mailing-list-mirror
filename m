From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perl/Git.pm: add parse_rev method
Date: Fri, 30 May 2008 14:25:58 -0700
Message-ID: <7vd4n3iivt.fsf@gitster.siamese.dyndns.org>
References: <20080530095047.GD18781@machine.or.cz>
 <1212179270-26170-1-git-send-email-LeWiemann@gmail.com>
 <20080530210531.GH18781@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 30 23:27:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2C87-0005VY-AS
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 23:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbYE3V0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 17:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbYE3V0L
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 17:26:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbYE3V0K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 17:26:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A986624A4;
	Fri, 30 May 2008 17:26:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0061524A2; Fri, 30 May 2008 17:26:02 -0400 (EDT)
In-Reply-To: <20080530210531.GH18781@machine.or.cz> (Petr Baudis's message of
 "Fri, 30 May 2008 23:05:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 04CE429E-2E8F-11DD-840E-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83338>

Petr Baudis <pasky@suse.cz> writes:

> On Fri, May 30, 2008 at 10:27:50PM +0200, Lea Wiemann wrote:
>> The parse_rev method takes a revision name and returns a SHA1 hash,
>> like the git-rev-parse command.
>> 
>> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
>
> Nice, this looks quite sane!

Perhaps, but except for the use of nonstandard try...catch.  I have been
wondering if we can move away from it, with the goal of eventually getting
rid of the construct altogether.

Didn't we hear from Randal that the construct is known to be leaky?
