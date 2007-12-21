From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH v2] Make git send-email accept $EDITOR with arguments
Date: Fri, 21 Dec 2007 22:37:12 +0100
Message-ID: <476C3208.3030700@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: luciano@eurotux.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 22:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5pYt-0002UT-4G
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 22:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940AbXLUVhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 16:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590AbXLUVhS
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 16:37:18 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:58139 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbXLUVhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 16:37:16 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 45AD425AA6;
	Fri, 21 Dec 2007 22:37:15 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 02193-09; Fri, 21 Dec 2007 22:37:14 +0100 (MET)
Received: from [192.168.13.13] (85.8.6.119.static.se.wasadata.net [85.8.6.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 954B625A9C;
	Fri, 21 Dec 2007 22:37:14 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
X-Enigmail-Version: 0.95.5
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69096>

Sorry Junio for the double, but I didn't mean to cut the CCs on this one.

On 2007-12-21 18:02, Junio C Hamano wrote:
> Gustaf Hendeby <hendeby@isy.liu.se> writes:
> 
>> Junio, even if this is technically not a bug fix, it would be nice to
>> get this fix into the 1.5.4 so that the usage of $EDITOR becomes more
>> consistent throughout git.
> 
> I can buy that, but at least a single line comment in front of that
> system() explaining why this is safe to do so would be beneficial.  I
> suspect that somebody would propose moving $compse_filename inside
> $GIT_DIR, now people realized $compose_filename is currently "./.msg.$$",
> and $GIT_DIR could be anything.  Quotemeta would probably be better as the
> code you are touching won't be affected by a future change to the value of
> that constant defined far away in the source.

Moving that file makes sense, I'll have a look at that, and do that as
well when I fix this patch.  After a first look at it though, I was
surprised to learn that git send-email actually wont work outside a
repository.  Ok, I can't really see any workflow where git send-email is
called from outside a git repository, but at the same time I don't see
why is should not be possible.  Are there any special reason for this?

Thanks,
	Gustaf
