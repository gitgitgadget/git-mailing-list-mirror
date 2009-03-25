From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] How to make a shared/restricted repo?
Date: Tue, 24 Mar 2009 19:24:42 -0700
Message-ID: <7v63hybaqd.fsf@gitster.siamese.dyndns.org>
References: <200903250105.05808.johan@herland.net>
 <7vvdpybf9i.fsf@gitster.siamese.dyndns.org>
 <200903250311.56300.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 03:26:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmIoq-0006SW-QI
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 03:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbZCYCYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 22:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753984AbZCYCYv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 22:24:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbZCYCYu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 22:24:50 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 226B8A4A73;
	Tue, 24 Mar 2009 22:24:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 37889A4A72; Tue,
 24 Mar 2009 22:24:43 -0400 (EDT)
In-Reply-To: <200903250311.56300.johan@herland.net> (Johan Herland's message
 of "Wed, 25 Mar 2009 03:11:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1C200690-18E4-11DE-8F26-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114542>

Johan Herland <johan@herland.net> writes:

> On Wednesday 25 March 2009, Junio C Hamano wrote:
>> You might like to try a patch like this (untested).
>>
>>  path.c |   17 +++++------------
>>  1 files changed, 5 insertions(+), 12 deletions(-)
>
> Thanks!
>
> This works much better :)
>
> However, there are still some questions/issues:
>
> - t1301-shared-repo.sh fails:
>     Oops, .git/HEAD is not 0664 but -rw-rw---- [...]
>     * FAIL 3: shared=1 does not clear bits preset by umask 022
>   (I guess this is expected, as your patch changes the assumptions)

I'd rather say the patch breaks people's expectations.
