From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [PATCH] rebase -i: fix has_action
Date: Fri, 05 Aug 2011 10:17:42 -0400
Message-ID: <4E3BFB86.4010408@sohovfx.com>
References: <1312450780-5021-1-git-send-email-nrubinstein@proformatique.com> <7vliv93r9g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Noe Rubinstein <nrubinstein@proformatique.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 16:43:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpLcI-0004Wz-Sv
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 16:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835Ab1HEOnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 10:43:07 -0400
Received: from smtp03.beanfield.com ([76.9.193.172]:59036 "EHLO
	smtp03.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab1HEOnF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 10:43:05 -0400
X-Greylist: delayed 1516 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Aug 2011 10:43:05 EDT
X-Spam-Status: No
X-beanfield-mta03-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta03-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta03-MailScanner: Found to be clean
X-beanfield-mta03-MailScanner-ID: 1QpLDa-0007RN-UL
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta03.beanfield.com with esmtpa (Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QpLDa-0007RN-UL; Fri, 05 Aug 2011 10:17:42 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <7vliv93r9g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178795>

On 08/04/2011 03:34 PM, Junio C Hamano wrote:
> How about removing the unnecessary negation from the logic and directly
> ask what we really want to know?
>
> That is, "Do we have a line that is _not_ comment?"
>
> 	has_action () {
>           sane_grep -v -e '^#' -e '^[   ]*$' "$1" >/dev/null
> 	}
How about also including comments that begins with spaces? i.e.

    has_action () {
        sane_grep -v -e '^[   ]*#' -e '^[   ]*$' "$1" >/dev/null
    }

Also, is [   ] supposed to be a space and a hard tab? They just seem to
be three spaces in my email. We might need to watch out for the hard tab
getting expanded into spaces somewhere during the email process,
especially when applying the patch from email into code.

Andrew
