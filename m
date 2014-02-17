From: David Kastrup <dak@gnu.org>
Subject: Re: Is there something like a blamed diff?
Date: Mon, 17 Feb 2014 12:02:31 +0100
Message-ID: <8761oeuhmg.fsf@fencepost.gnu.org>
References: <8738jk1as7.fsf@fencepost.gnu.org> <87ioseujej.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Feb 17 12:02:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFLyE-0003mV-QQ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 12:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbaBQLCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 06:02:33 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:35249 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaBQLCd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 06:02:33 -0500
Received: from localhost ([127.0.0.1]:34291 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WFLy3-0008W2-Pe; Mon, 17 Feb 2014 06:02:32 -0500
Received: by lola (Postfix, from userid 1000)
	id 507EEE06E5; Mon, 17 Feb 2014 12:02:31 +0100 (CET)
In-Reply-To: <87ioseujej.fsf@thomasrast.ch> (Thomas Rast's message of "Mon, 17
	Feb 2014 11:24:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242252>

Thomas Rast <tr@thomasrast.ch> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> When comparing two branches, decorating the flat diff with the
>> respectively responsible commits seems like it would be nice to do/have
>> (the blame on the identical parts, in contrast, is not really
>> interesting).  Is there any tool that provides something like that?
>
> This seems to come up every year or so:
>
> http://thread.gmane.org/gmane.comp.version-control.git/110369/focus=110383

Nice.  That one could likely be sped up by calling git-blame just once
on each file with multiple -L options.

Though actually with the current implementation of git-blame you are
likely faster for a large number of differences by doing each region
separately anyway since then the cost for digging through the history is
obviously O(n) for n consecutive runs on n chunks while the
administrative overhead for several chunks in a single run is O(n^2) at
the moment.

-- 
David Kastrup
