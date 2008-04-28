From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase--interactive: Replace unportable 'tac' by a sed
 script.
Date: Mon, 28 Apr 2008 01:19:49 -0700
Message-ID: <7v7ieie6hm.fsf@gitster.siamese.dyndns.org>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>
 <20080427064250.GA5455@sigill.intra.peff.net>
 <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com>
 <48158070.7090007@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Jeff King <peff@peff.net>, git list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 10:20:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqObU-0002Dx-Jy
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 10:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765902AbYD1IUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 04:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765216AbYD1IUE
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 04:20:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47352 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765407AbYD1IUB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 04:20:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4FCAF4B98;
	Mon, 28 Apr 2008 04:19:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8E78B4B94; Mon, 28 Apr 2008 04:19:52 -0400 (EDT)
In-Reply-To: <48158070.7090007@viscovery.net> (Johannes Sixt's message of
 "Mon, 28 Apr 2008 09:44:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80508>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <johannes.sixt@telecom.at>
>
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
> Brian Gernhardt schrieb:
>> -    tac | \
>> +    perl -e 'print reverse <>' | \
>
> Here's my try, which avoids the perl hammer. ;)
> ...
> -	tac | \
> +	sed -ne '1!G;$p;h' | \

Thanks for trying, but frankly, I'd prefer the Perl hammer, as any
advanced sed scripting tend to be far less portable.
