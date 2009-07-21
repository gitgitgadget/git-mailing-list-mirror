From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH] Added support for core.ignorecase when excluding gitignore
 entries
Date: Tue, 21 Jul 2009 09:55:17 -0600
Message-ID: <4A65E4E5.3030709@workspacewhiz.com>
References: <4A5EB849.1000803@workspacewhiz.com> <20090716094210.GC2800@coredump.intra.peff.net> <4A5F27EE.3070101@workspacewhiz.com> <20090720153737.GF5347@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 21 17:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTHgj-0006AQ-0D
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbZGUPzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 11:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbZGUPzY
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:55:24 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:52398 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbZGUPzY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 11:55:24 -0400
Received: (qmail 31909 invoked by uid 399); 21 Jul 2009 09:55:19 -0600
Received: from unknown (HELO ?10.102.8.74?) (jjensen@workspacewhiz.com@204.128.230.1)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Jul 2009 09:55:19 -0600
X-Originating-IP: 204.128.230.1
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <20090720153737.GF5347@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123673>

----- Original Message -----
From: Jeff King
Date: 7/20/2009 9:37 AM
>>> If your patch is the right route, it might be nice to collapse the
>>> comparison into its own function. You end up cutting and pasting a lot
>>> of the related conditionals and returns (like above, where 2 lines
>>> become 9), so it might make sense to do something like:
>>>
>>>  int filename_cmp(const char *a, const char *b, int ignore_case)
>>>  {
>>>    return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
>>>  }
>>>
>>> and then just s/strcmp/filename_cmp/ at the appropriate callsites.
>>>       
> IMHO, you are better off even with three wrapper functions, just because
> they are all very straightforward. Whereas with your patch, I felt like
> the innards of complex functions got harder to read because of big
> duplicate conditionals. But that's just my two cents.
>   
I agree.  I will update the patch soon.

Josh
