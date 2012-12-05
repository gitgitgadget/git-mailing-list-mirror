From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [RFC] Add basic syntax check on shell scripts
Date: Wed, 05 Dec 2012 10:11:41 +0100
Message-ID: <50BF0FCD.6080700@gmail.com>
References: <201212021417.25525.tboegi@web.de> <7vzk1vrs63.fsf@alter.siamese.dyndns.org> <CACsJy8BxviWRHqGvptsJVmkFM6HQa9HnLWsh5V6Ec6Fqv52sGA@mail.gmail.com> <7vobi9mwt4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 10:11:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgB0V-00034U-Hi
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 10:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab2LEJKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 04:10:42 -0500
Received: from plane.gmane.org ([80.91.229.3]:38010 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab2LEJKk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 04:10:40 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TgB0C-0002cy-Qb
	for git@vger.kernel.org; Wed, 05 Dec 2012 10:10:50 +0100
Received: from 192.100.123.82 ([192.100.123.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Dec 2012 10:10:48 +0100
Received: from sschuberth by 192.100.123.82 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Dec 2012 10:10:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 192.100.123.82
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vobi9mwt4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211115>

On 2012/12/04 20:39 , Junio C Hamano wrote:

> A few more things in addition to what Torsten's script attempts to
> catch that we would want to catch are:

[...]

 >   * Do not write ERE with backslashes and expect "grep" to grok them;
 >     that's GNUism.  e.g.
 >
 > 	grep "^\(author\|committer\) "
 >
 >     is bad.  Use egrep (or "grep -E") if you want to use ERE.

Yet more thing that is probably worth catching, although not related to 
bashism: Avoid the use of "which" in favor of e.g. "type".

In any case, having this check as a local pre-commit hook would be great!

-- 
Sebastian Schuberth
