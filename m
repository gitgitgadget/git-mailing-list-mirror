From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: git-diff on touched files: bug or feature?
Date: Wed, 01 Aug 2007 21:17:48 +0200
Message-ID: <87r6mnkqsj.fsf@wine.dyndns.org>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<87vebzkrid.fsf@wine.dyndns.org>
	<7vvebz3wh3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 21:17:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGJhj-0004HL-9V
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 21:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758397AbXHATRw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 15:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755840AbXHATRw
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 15:17:52 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:50690 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbXHATRv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 15:17:51 -0400
Received: from adsl-84-227-23-240.adslplus.ch ([84.227.23.240] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IGJhe-0003fG-Ka; Wed, 01 Aug 2007 14:17:51 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 965001E7170; Wed,  1 Aug 2007 21:17:48 +0200 (CEST)
In-Reply-To: <7vvebz3wh3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 01 Aug 2007 12\:07\:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54468>

Junio C Hamano <gitster@pobox.com> writes:

> Alexandre Julliard <julliard@winehq.org> writes:
>
>> .... For
>> instance in vc-git.el the workfile-unchanged-p function currently has
>> to rehash the file every time to see if it really changed, because we
>> can't afford to refresh the whole project at that point.
>
> Maybe I am missing something.  Why can't you "afford to"?
>
> "update-index --refresh" looks at only the files whose cached
> stat information does indicate there might be chanegs.  It does
> not rehash already up-to-date ones.

No, but it goes through the tree and stats every single file. On a
large project that can be slow, especially if you don't have enough
RAM to keep it all in cache, so it's not something we can do while the
user is interacting with a file.

-- 
Alexandre Julliard
julliard@winehq.org
