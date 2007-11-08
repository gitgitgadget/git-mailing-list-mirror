From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hooks--update: fix test for properly set up project description file
Date: Thu, 08 Nov 2007 14:13:38 -0800
Message-ID: <7v640c1j3h.fsf@gitster.siamese.dyndns.org>
References: <20071106134749.24233.qmail@809f27f669039a.315fe32.mid.smarden.org>
	<4730726B.1000407@op5.se>
	<20071108140200.24902.qmail@f23d7e396b1523.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 23:14:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqFdR-0002hB-5X
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 23:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbXKHWNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 17:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753999AbXKHWNp
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 17:13:45 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59597 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbXKHWNo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 17:13:44 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 669712F9;
	Thu,  8 Nov 2007 17:14:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DD642939D3;
	Thu,  8 Nov 2007 17:14:01 -0500 (EST)
In-Reply-To: <20071108140200.24902.qmail@f23d7e396b1523.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Thu, 8 Nov 2007 14:02:00 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64081>

Gerrit Pape <pape@smarden.org> writes:

> The update hook template intends to abort if the project description file
> hasn't been adjusted or is empty.  This patch fixes the check for 'being
> adjusted'.
>
> Signed-off-by: Gerrit Pape <pape@smarden.org>
> ---
>
> On Tue, Nov 06, 2007 at 02:55:55PM +0100, Andreas Ericsson wrote:
>> Gerrit Pape wrote:
>> > # check for no description
>> >-projectdesc=$(sed -e '1p' "$GIT_DIR/description")
>> >-if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit
>> >this
>> >file to name it for gitweb" ]; then
>> >+projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
>>
>> Write this as
>>       projectdesc=$(sed -e 1q "$GIT_DIR/description")
>> instead. It's a little shorter, a little faster and slightly more
>> portable.

I even suspect that the original 'p' is indeed a typo of 'q'.
